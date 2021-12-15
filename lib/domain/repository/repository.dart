import 'package:dartz/dartz.dart';
import 'package:flutteradvancedmvvm/data/network/failure.dart';
import 'package:flutteradvancedmvvm/data/requests/requests.dart';
import 'package:flutteradvancedmvvm/domain/model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, ForgotPassword>> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest);
  Future<Either<Failure, HomeObject>> getHome();
}
