import 'package:dartz/dartz.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/core/use_cases/get_all_use_case.dart';
import 'package:hamon/features/students/domain/entities/student.dart';
import 'package:hamon/features/students/domain/repositories/students_repository.dart';

class GetStudents extends GetAllUseCase<List<Student>> {
  final StudentsRepository repository;

  GetStudents(this.repository);

  @override
  Future<Either<Failure, List<Student>>> call() async {
    return await repository.getStudents();
  }
}
