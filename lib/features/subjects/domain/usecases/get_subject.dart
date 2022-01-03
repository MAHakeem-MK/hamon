import 'package:hamon/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hamon/core/use_cases/get_one_use_case.dart';
import 'package:hamon/features/subjects/domain/repositories/subjects_repository.dart';

class GetSubject extends GetOneUseCase {
  final SubjectsRepository repository;
  GetSubject(this.repository);
  @override
  Future<Either<Failure, dynamic>> call(params) {
    return repository.getSubject(params);
  }
}
