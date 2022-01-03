import 'package:hamon/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hamon/core/use_cases/get_one_use_case.dart';
import 'package:hamon/features/classrooms/domain/entities/classroom.dart';
import 'package:hamon/features/classrooms/domain/repositories/classroom_repository.dart';

class GetClassroom extends GetOneUseCase<Classroom, int> {
  final ClassroomRepository repository;
  GetClassroom(this.repository);
  @override
  Future<Either<Failure, Classroom>> call(int params) {
    return repository.getClassroom(params);
  }
}
