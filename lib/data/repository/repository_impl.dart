import 'package:flutter/material.dart';
import 'package:flutteradvancedmvvm/data/data_source/remote_data_source.dart';
import 'package:flutteradvancedmvvm/data/network/error_handler.dart';
import 'package:flutteradvancedmvvm/data/network/network_info.dart';
import 'package:flutteradvancedmvvm/data/responses/responses.dart';
import 'package:flutteradvancedmvvm/domain/model/model.dart';
import 'package:flutteradvancedmvvm/data/requests/requests.dart';
import 'package:flutteradvancedmvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutteradvancedmvvm/domain/repository/repository.dart';
import 'package:flutteradvancedmvvm/data/mapper/mapper.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    //? _networkInfo.isconnected degeri future oldugu icin async eklendi ve await ile degerin gelmesi beklendi.
    if (await _networkInfo.isConnected) {
      final AuthenticationResponse response = await _remoteDataSource.login(loginRequest);
      try {
        debugPrint(response.status.toString());

        if (response.status == ApiInternalStatus.SUCCESS) {
          //? for our api is success
          //? return data (success)
          //? right mean Authentication
          return Right(response.toDomain());
        } else {
          //? return business logic error
          return Left(Failure(response.status ?? ApiInternalStatus.Failure,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
      //? its safe to call the API

    } else {
      //? return connection error.
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(response.status ?? ApiInternalStatus.Failure,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}