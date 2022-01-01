import 'package:dartz/dartz.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/features/students/domain/entities/student.dart';

abstract class StudentsRepository {
  Future<Either<Failure,List<Student>>> getStudents();
  Future<Either<Failure,Student>> getStudent(int id);
}
