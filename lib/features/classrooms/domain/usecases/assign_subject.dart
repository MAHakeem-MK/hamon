import 'package:dartz/dartz.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/features/classrooms/domain/entities/classroom.dart';
import 'package:hamon/features/classrooms/domain/repositories/classroom_repository.dart';

class AssignSubject {
  final ClassroomRepository repository;
  AssignSubject(this.repository);
  Future<Either<Failure, Classroom>> call(int classroomId, int subjectId) {
    return repository.assignSubject(classroomId, subjectId);
  }
}
