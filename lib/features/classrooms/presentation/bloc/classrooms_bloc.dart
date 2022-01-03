import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/features/classrooms/domain/entities/classroom.dart';
import 'package:hamon/features/classrooms/domain/usecases/get_classrooms.dart';

part 'classrooms_event.dart';
part 'classrooms_state.dart';

class ClassroomsBloc extends Bloc<ClassroomsEvent, ClassroomsState> {
  final GetClassrooms getClassroomsUseCase;
  ClassroomsBloc(this.getClassroomsUseCase) : super(ClassroomsInitial()) {
    on<ClassroomsEvent>((event, emit) async {
      if (event is GetClassroomsEvent) {
        emit(ClassroomsLoading());
        final failureOrClassrooms = await getClassroomsUseCase();
        failureOrClassrooms.fold(
          (failure) {
            if (failure is ServerFailure) {
              emit(const ClassroomsError('Server Failure'));
            } else {
              emit(const ClassroomsError('Unknown Failure'));
            }
          },
          (classrooms) => emit(ClassroomsLoaded(classrooms)),
        );
      }
    });
  }
}
