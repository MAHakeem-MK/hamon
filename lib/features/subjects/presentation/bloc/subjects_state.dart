part of 'subjects_bloc.dart';

abstract class SubjectsState extends Equatable {
  const SubjectsState();  

  @override
  List<Object> get props => [];
}
class SubjectsInitial extends SubjectsState {}

class SubjectsLoading extends SubjectsState {}

class SubjectsLoaded extends SubjectsState {
  final List<Subject> subjects;
  const SubjectsLoaded(this.subjects);
  @override
  List<Object> get props => [subjects];
}

class SubjectsError extends SubjectsState {
  final String message;
  const SubjectsError(this.message);
  @override
  List<Object> get props => [message];
}
