import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamon/features/subjects/domain/entities/subject.dart';
import 'package:hamon/features/subjects/domain/repositories/subjects_repository.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectsRepository repository;
  SubjectBloc(this.repository) : super(SubjectInitial()) {
    on<SubjectEvent>((event, emit) async {
      if (event is GetSubjectEvent) {
        emit(SubjectLoading());
        final failureOrSubject =
            await repository.getSubject(int.tryParse(event.id) ?? 0);
        if (failureOrSubject.isLeft()) {
          emit(SubjectError());
        } else {
          failureOrSubject.fold((l) => emit(SubjectError()), (r) => emit(SubjectLoaded(r)));
        }
      }
    });
  }
}
