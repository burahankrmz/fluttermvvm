import 'package:dartz/dartz.dart';
import 'package:flutteradvancedmvvm/data/network/failure.dart';

abstract class BaseUsecase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
