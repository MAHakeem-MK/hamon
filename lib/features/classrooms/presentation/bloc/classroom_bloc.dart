import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamon/core/errors/failure.dart';
import 'package:hamon/features/classrooms/domain/entities/classroom.dart';
import 'package:hamon/features/classrooms/domain/usecases/assign_subject.dart';
import 'package:hamon/features/classrooms/domain/usecases/get_classroom.dart';
import 'package:hamon/features/subjects/presentation/bloc/subject_bloc.dart';

part 'classroom_event.dart';
part 'classroom_state.dart';

class ClassroomBloc extends Bloc<ClassroomEvent, ClassroomState> {
  final GetClassroom getClassroomUseCase;
  final AssignSubject assignSubjectUseCase;
  final SubjectBloc subjectBloc;
  ClassroomBloc(
      this.getClassroomUseCase, this.assignSubjectUseCase, this.subjectBloc)
      : super(ClassroomInitial()) {
    on<ClassroomEvent>((event, emit) async {
      if (event is GetClassroomEvent) {
        emit(ClassroomLoading());
        final failureOrClassroom = await getClassroomUseCase(event.id);
        failureOrClassroom.fold((failure) {
          if (failure is ServerFailure) {
            emit(const ClassroomError('Server Failure'));
          } else {
            emit(const ClassroomError('Unknown Failure'));
          }
        }, (classroom) {
          if (classroom.subject.isNotEmpty) {
            subjectBloc.add(GetSubjectEvent(classroom.subject));
            subjectBloc.stream.listen((subjectState) {
              if (subjectState is SubjectLoaded) {
                add(ClassroomUpdateEvent(
                    classroom.copyWith(subject: subjectState.subject.name)));
              }
            });
          } else {
            emit(ClassroomLoaded(classroom));
          }
        });
      }
      if (event is ClassroomUpdateEvent) {
        emit(ClassroomLoaded(event.classroom));
      }
      if (event is AssignSubjectEvent) {
        final failureOrClassroom =
            await assignSubjectUseCase(event.id, event.subjectId);
        failureOrClassroom.fold((failure) {
          if (failure is ServerFailure) {
            emit(const ClassroomError('Server Failure'));
          } else {
            emit(const ClassroomError('Unknown Failure'));
          }
        }, (classroom) {
          if (classroom.subject.isNotEmpty) {
            subjectBloc.add(GetSubjectEvent(classroom.subject));
            subjectBloc.stream.listen((subjectState) {
              if (subjectState is SubjectLoaded) {
                add(
                  ClassroomUpdateEvent(
                    classroom.copyWith(
                      subject: subjectState.subject.name,
                    ),
                  ),
                );
              }
            });
          } else {
            emit(ClassroomLoaded(classroom));
          }
        });
      }
    });
  }
}
