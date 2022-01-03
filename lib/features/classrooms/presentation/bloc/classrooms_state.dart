part of 'classrooms_bloc.dart';

abstract class ClassroomsState extends Equatable {
  const ClassroomsState();

  @override
  List<Object> get props => [];
}

class ClassroomsInitial extends ClassroomsState {}

class ClassroomsLoading extends ClassroomsState {}

class ClassroomsLoaded extends ClassroomsState {
  final List<Classroom> classrooms;

  const ClassroomsLoaded(this.classrooms);

  @override
  List<Object> get props => [classrooms];
}

class ClassroomsError extends ClassroomsState {
  final String message;

  const ClassroomsError(this.message);

  @override
  List<Object> get props => [message];
}
