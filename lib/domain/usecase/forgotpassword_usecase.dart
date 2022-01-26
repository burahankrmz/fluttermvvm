import '../../data/network/failure.dart';
import 'package:dartz/dartz.dart';
import '../../data/requests/requests.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

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
