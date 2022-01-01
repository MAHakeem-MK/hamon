import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'subjects_event.dart';
part 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  SubjectsBloc() : super(SubjectsInitial()) {
    on<SubjectsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
