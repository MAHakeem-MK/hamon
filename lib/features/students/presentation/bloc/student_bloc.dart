import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/features/students/domain/entities/student.dart';
import 'package:hamon/features/students/domain/usecases/get_student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final GetStudent getStudentUseCase;
  StudentBloc({required this.getStudentUseCase}) : super(StudentInitial()) {
    on<StudentEvent>((event, emit) async {
      if (event is GetStudentEvent) {
        emit(StudentLoading());
        final failureOrStudents = await getStudentUseCase(event.id);
        failureOrStudents.fold(
          (failure) {
            if (failure is ServerFailure) {
              emit(const StudentError('Server Failure'));
            } else {
              emit(const StudentError('Unknown Failure'));
            }
          },
          (student) => emit(StudentLoaded(student)),
        );
      }
    });
  }
}
