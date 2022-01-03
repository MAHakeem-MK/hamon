import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/features/classrooms/domain/entities/classroom.dart';
import 'package:hamon/features/classrooms/domain/usecases/get_classroom.dart';

part 'classroom_event.dart';
part 'classroom_state.dart';

class ClassroomBloc extends Bloc<ClassroomEvent, ClassroomState> {
  final GetClassroom getClassroomUseCase;
  ClassroomBloc(this.getClassroomUseCase) : super(ClassroomInitial()) {
    on<ClassroomEvent>((event, emit) async {
      if (event is GetClassroomEvent) {
        emit(ClassroomLoading());
        final failureOrClassroom = await getClassroomUseCase(event.id);
        failureOrClassroom.fold(
          (failure) {
            if (failure is ServerFailure) {
              emit(const ClassroomError('Server Failure'));
            } else {
              emit(const ClassroomError('Unknown Failure'));
            }
          },
          (classrooms) => emit(ClassroomLoaded(classrooms)),
        );
      }
    });
  }
}
