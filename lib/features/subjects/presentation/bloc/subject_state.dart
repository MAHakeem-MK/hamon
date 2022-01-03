part of 'subject_bloc.dart';

abstract class SubjectState extends Equatable {
  const SubjectState();

  @override
  List<Object> get props => [];
}

class SubjectInitial extends SubjectState {}

class SubjectLoading extends SubjectState {}

class SubjectLoaded extends SubjectState {
  final Subject subject;
  const SubjectLoaded(this.subject);
  @override
  List<Object> get props => [subject];
}

class SubjectError extends SubjectState {}
