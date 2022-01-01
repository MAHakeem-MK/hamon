import 'package:dartz/dartz.dart';
import 'package:hamon/core/errors/failure.dart';

abstract class GetOneUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}