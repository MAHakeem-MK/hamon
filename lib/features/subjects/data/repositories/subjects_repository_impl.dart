import 'package:hamon/core/errors/exception.dart';
import 'package:hamon/core/platform/network_info.dart';
import 'package:hamon/features/subjects/data/datasources/subjects_remote_data_source.dart';
import 'package:hamon/features/subjects/domain/entities/subject.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:hamon/features/subjects/domain/repositories/subjects_repository.dart';

class SubjectsRepositoryImpl extends SubjectsRepository {
  final NetworkInfo networkInfo;
  final SubjectsRemoteDataSource remoteDataSource;

  SubjectsRepositoryImpl(
      {required this.networkInfo, required this.remoteDataSource});
  @override
  Future<Either<Failure, Subject>> getSubject(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final subject = await remoteDataSource.getSubject(id);
        return Right(subject);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Future.value(Left(NetworkFailure()));
    }
  }

  @override
  Future<Either<Failure, List<Subject>>> getSubjects() async {
    if (await networkInfo.isConnected) {
      try {
        final subjects = await remoteDataSource.getSubjects();
        return Right(subjects);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Future.value(Left(NetworkFailure()));
    }
  }
}
