import 'package:dartz/dartz.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/features/classrooms/domain/entities/classroom.dart';

abstract class ClassroomRepository {
  Future<Either<Failure,List<Classroom>>> getClassrooms();
  Future<Either<Failure,Classroom>> getClassroom(int id);
  Future<Either<Failure,Classroom>> assignSubject(int classroomId, int subjectId);
}
