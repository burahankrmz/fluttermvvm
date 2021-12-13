import 'package:flutteradvancedmvvm/app/functions.dart';
import 'package:flutteradvancedmvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutteradvancedmvvm/data/requests/requests.dart';
import 'package:flutteradvancedmvvm/domain/model/model.dart';
import 'package:flutteradvancedmvvm/domain/repository/repository.dart';
import 'package:flutteradvancedmvvm/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUsecase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository
        .login(LoginRequest(input.email, input.password, deviceInfo.identifier, deviceInfo.name));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
