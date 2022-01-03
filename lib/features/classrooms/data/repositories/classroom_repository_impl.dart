import 'package:hamon/core/errors/exception.dart';
import 'package:hamon/core/platform/network_info.dart';
import 'package:hamon/features/classrooms/data/datasources/classrooms_remote_data_source.dart';
import 'package:hamon/features/classrooms/domain/entities/classroom.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hamon/features/classrooms/domain/repositories/classroom_repository.dart';

class ClassroomRepositoryImpl extends ClassroomRepository {
  final ClassroomsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ClassroomRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, Classroom>> getClassroom(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClassroom = await remoteDataSource.getClassroom(id);
        return Right(remoteClassroom);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Future.value(Left(NetworkFailure()));
    }
  }

  @override
  Future<Either<Failure, List<Classroom>>> getClassrooms() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteClassrooms = await remoteDataSource.getClassrooms();
        return Right(remoteClassrooms);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Future.value(Left(NetworkFailure()));
    }
  }
}
