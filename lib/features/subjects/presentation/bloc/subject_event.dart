part of 'subject_bloc.dart';

abstract class SubjectEvent extends Equatable {
  const SubjectEvent();

  @override
  List<Object> get props => [];
}

class GetSubjectEvent extends SubjectEvent {
  final String id;
  const GetSubjectEvent(this.id);
  @override
  List<Object> get props => [id];
}
