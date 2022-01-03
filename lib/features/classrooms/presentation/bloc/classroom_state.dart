part of 'classroom_bloc.dart';

abstract class ClassroomState extends Equatable {
  const ClassroomState();
}

class ClassroomInitial extends ClassroomState {
  @override
  List<Object> get props => [];
}

class ClassroomLoading extends ClassroomState {
  @override
  List<Object> get props => [];
}

class ClassroomLoaded extends ClassroomState {
  final Classroom classroom;
  const ClassroomLoaded(this.classroom);
  @override
  List<Object> get props => [classroom];
}

class ClassroomError extends ClassroomState {
  final String message;

  const ClassroomError(this.message);

  @override
  List<Object> get props => [message];
}
