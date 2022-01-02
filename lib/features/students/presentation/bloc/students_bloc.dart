import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/features/students/domain/entities/student.dart';
import 'package:hamon/features/students/domain/usecases/get_students.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final GetStudents getStudentsUseCase;
  StudentsBloc({required this.getStudentsUseCase}) : super(StudentsInitial()) {
    on<StudentsEvent>((event, emit) async {
      if (event is GetStudentsEvent) {
        emit(StudentsLoading());
        final failureOrStudents = await getStudentsUseCase();
        failureOrStudents.fold(
          (failure) {
            if (failure is ServerFailure) {
              emit(const StudentsError('Server Failure'));
            } else {
              emit(const StudentsError('Unknown Failure'));
            }
          },
          (students) => emit(StudentsLoaded(students)),
        );
      }
    });
  }
}
