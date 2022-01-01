import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'classrooms_event.dart';
part 'classrooms_state.dart';

class ClassroomsBloc extends Bloc<ClassroomsEvent, ClassroomsState> {
  ClassroomsBloc() : super(ClassroomsInitial()) {
    on<ClassroomsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
