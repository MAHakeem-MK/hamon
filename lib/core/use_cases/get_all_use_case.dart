import 'package:dartz/dartz.dart';
import 'package:hamon/core/errors/failure.dart';

abstract class GetAllUseCase<Type> {
  Future<Either<Failure, Type>> call();
}