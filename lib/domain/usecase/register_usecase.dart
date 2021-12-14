import 'package:flutteradvancedmvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutteradvancedmvvm/data/requests/requests.dart';
import 'package:flutteradvancedmvvm/domain/model/model.dart';
import 'package:flutteradvancedmvvm/domain/repository/repository.dart';
import 'package:flutteradvancedmvvm/domain/usecase/base_usecase.dart';

class RegisterUsecase
    implements BaseUsecase<RegisterUsecaseInput, Authentication> {
  final Repository _repository;
  RegisterUsecase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    return await _repository.register(RegisterRequest(
        input.name,
        input.countryMobileCode,
        input.mobileNumber,
        input.email,
        input.password,
        "abc"));
  }
}

class RegisterUsecaseInput {
  String name;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;
  RegisterUsecaseInput(this.name, this.countryMobileCode, this.mobileNumber,
      this.email, this.password, this.profilePicture);
}
