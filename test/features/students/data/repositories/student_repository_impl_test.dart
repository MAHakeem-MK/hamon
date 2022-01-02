import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamon/core/platform/network_info.dart';
import 'package:hamon/features/students/data/datasources/students_remote_data_source.dart';
import 'package:hamon/features/students/data/models/student_model.dart';
import 'package:hamon/features/students/data/repositories/students_repository_impl.dart';

class MockRemoteDataSource implements StudentsRemoteDataSource {
  @override
  Future<StudentModel> getStudent(int id) {
    return Future.delayed(const Duration(seconds: 1), () {
      return const StudentModel(
        id: 1,
        name: 'test name',
        age: 20,
        email: 'mail@email.com',
      );
    });
  }

  @override
  Future<List<StudentModel>> getStudents() {
    return Future.delayed(const Duration(seconds: 1), () {
      return const <StudentModel>[
        StudentModel(id: 1, name: 'test name', age: 20, email: 'mail@email.com')
      ];
    });
  }
}

class MockNetworkInfo implements NetworkInfo {
  @override
  Future<bool> get isConnected =>
      Future.delayed(const Duration(microseconds: 300), () {
        return true;
      });
}

void main() {
  late StudentsRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = StudentsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('get students', () {
    test('should check if the device is online', () async {
      assert(await mockNetworkInfo.isConnected);
    });

    test('should return remote data when network available', () async {
      final students = await repository.getStudents();
      expect(
        students,
        equals(
          const Right(
            <StudentModel>[
              StudentModel(
                  id: 1, name: 'test name', age: 20, email: 'mail@email.com')
            ],
          ),
        ),
      );
    });
  });
}
