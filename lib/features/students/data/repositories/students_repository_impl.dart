import 'package:hamon/core/errors/exception.dart';
import 'package:hamon/core/platform/network_info.dart';
import 'package:hamon/features/students/data/datasources/students_remote_data_source.dart';
import 'package:hamon/features/students/domain/entities/student.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hamon/features/students/domain/repositories/students_repository.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  final StudentsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  StudentsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Student>> getStudent(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final student = await remoteDataSource.getStudent(id);
        return Right(student);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Student>>> getStudents() async {
    if (await networkInfo.isConnected) {
      try {
        final students = await remoteDataSource.getStudents();
        return Right(students);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
