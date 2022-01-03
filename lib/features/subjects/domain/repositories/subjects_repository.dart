import 'package:dartz/dartz.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/features/subjects/domain/entities/subject.dart';

abstract class SubjectsRepository {
  Future<Either<Failure, List<Subject>>> getSubjects();
  Future<Either<Failure, Subject>> getSubject(int id);
}

