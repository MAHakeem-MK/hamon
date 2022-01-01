import 'package:dartz/dartz.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/core/use_cases/get_one_use_case.dart';
import 'package:hamon/features/students/domain/entities/student.dart';
import 'package:hamon/features/students/domain/repositories/students_repository.dart';

class GetStudent implements GetOneUseCase<Student,int> {
  final StudentsRepository repository;

  GetStudent(this.repository);

  @override
  Future<Either<Failure,Student>> call(int id) async {
    return await repository.getStudent(id);
  }
}