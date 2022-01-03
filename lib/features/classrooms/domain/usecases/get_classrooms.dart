import 'package:dartz/dartz.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/core/use_cases/get_all_use_case.dart';
import 'package:hamon/features/classrooms/domain/entities/classroom.dart';
import 'package:hamon/features/classrooms/domain/repositories/classroom_repository.dart';

class GetClassrooms extends GetAllUseCase<List<Classroom>> {
  final ClassroomRepository repository;
  GetClassrooms(this.repository);
  @override
  Future<Either<Failure, List<Classroom>>> call() {
    return repository.getClassrooms();
  }
}