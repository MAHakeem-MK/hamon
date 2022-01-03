part of 'classroom_bloc.dart';

abstract class ClassroomEvent extends Equatable {
  const ClassroomEvent();
}

class GetClassroomEvent extends ClassroomEvent {
  final int id;

  const GetClassroomEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ClassroomUpdateEvent extends ClassroomEvent {
  final Classroom classroom;

  const ClassroomUpdateEvent(this.classroom);

  @override
  List<Object> get props => [classroom];
}

class AssignSubjectEvent extends ClassroomEvent {
  final int id;
  final int subjectId;

  const AssignSubjectEvent(this.id, this.subjectId);

  @override
  List<Object> get props => [id, subjectId];
}
