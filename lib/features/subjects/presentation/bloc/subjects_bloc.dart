import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hamon/features/subjects/domain/entities/subject.dart';
import 'package:hamon/features/subjects/domain/usecases/get_subjects.dart';

part 'subjects_event.dart';
part 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  final GetSubjects getSubjectsUseCase;
  SubjectsBloc(this.getSubjectsUseCase) : super(SubjectsInitial()) {
    on<SubjectsEvent>((event, emit) async {
      if (event is GetSubjectsEvent) {
        emit(SubjectsLoading());
        final failureOrSubjects = await getSubjectsUseCase();
        failureOrSubjects.fold(
          (l) => emit(
            const SubjectsError("Error"),
          ),
          (r) => emit(
            SubjectsLoaded(r),
          ),
        );
      }
    });
  }
}
