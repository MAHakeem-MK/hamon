part of 'classroom_bloc.dart';

abstract class ClassroomState extends Equatable {
  const ClassroomState();
  
  @override
  List<Object> get props => [];
}

class ClassroomInitial extends ClassroomState {}

class ClassroomLoading extends ClassroomState {}

class ClassroomLoaded extends ClassroomState {
  final Classroom classroom;

  const ClassroomLoaded(this.classroom);
}

class ClassroomError extends ClassroomState {
  final String message;

  const ClassroomError(this.message);

  @override
  List<Object> get props => [message];
}
