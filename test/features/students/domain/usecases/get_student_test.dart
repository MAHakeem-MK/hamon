import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/features/students/domain/entities/student.dart';
import 'package:hamon/features/students/domain/repositories/students_repository.dart';
import 'package:hamon/features/students/domain/usecases/get_student.dart';

class MockStudentsRepository implements StudentsRepository {
  @override
  Future<Either<Failure, Student>> getStudent(int id) {
    return Future.delayed(const Duration(seconds: 1), () {
      return const Right(Student(
        id: 1,
        name: 'test name',
        age: 20,
        email: 'mail@email.com',
      ));
    });
  }

  @override
  Future<Either<Failure, List<Student>>> getStudents() {
    return Future.delayed(const Duration(seconds: 1), () {
      return const Right(<Student>[
        Student(id: 1, name: 'test name', age: 20, email: 'mail@email.com')
      ]);
    });
  }
}

void main() {
  late GetStudent usecase;
  late MockStudentsRepository mockStudentsRepository;

  setUp(() {
    mockStudentsRepository = MockStudentsRepository();
    usecase = GetStudent(mockStudentsRepository);
  });

  test(
    'should get a student with given id, from the repository',
    () async {
      final result = await usecase(1);
      // assert
      expect(
        result,
        const Right<Failure, Student>(
          Student(
            id: 1,
            name: 'test name',
            age: 20,
            email: 'mail@email.com',
          ),
        ),
      );
    },
  );
}
