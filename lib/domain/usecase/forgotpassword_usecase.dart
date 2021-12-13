import 'package:flutteradvancedmvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutteradvancedmvvm/data/requests/requests.dart';
import 'package:flutteradvancedmvvm/domain/model/model.dart';
import 'package:flutteradvancedmvvm/domain/repository/repository.dart';
import 'package:flutteradvancedmvvm/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase
    implements BaseUsecase<ForgotPasswordInputUsecase, ForgotPassword> {
  final Repository _repository;
  ForgotPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, ForgotPassword>> execute(input) async{
      return await _repository.forgotPassword(ForgotPasswordRequest(input.email));
  }
}

class ForgotPasswordInputUsecase {
  String email;
  ForgotPasswordInputUsecase(this.email);
}
