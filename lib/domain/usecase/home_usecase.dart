import 'package:flutteradvancedmvvm/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutteradvancedmvvm/domain/model/model.dart';
import 'package:flutteradvancedmvvm/domain/repository/repository.dart';
import 'package:flutteradvancedmvvm/domain/usecase/base_usecase.dart';

class HomeUseCase implements BaseUsecase<void, HomeObject> {
  final Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(input) async {
    return await _repository.getHome();
  }
}
