import 'package:hamon/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hamon/core/use_cases/get_all_use_case.dart';
import 'package:hamon/features/subjects/domain/entities/subject.dart';
import 'package:hamon/features/subjects/domain/repositories/subjects_repository.dart';

class GetSubjects extends GetAllUseCase {
  final SubjectsRepository repository;
  GetSubjects(this.repository);
  @override
  Future<Either<Failure, List<Subject>>> call() {
    return repository.getSubjects();
  }
}
