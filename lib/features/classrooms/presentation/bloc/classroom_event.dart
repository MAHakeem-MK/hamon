part of 'classroom_bloc.dart';

abstract class ClassroomEvent extends Equatable {
  const ClassroomEvent();

  @override
  List<Object> get props => [];
}

class GetClassroomEvent extends ClassroomEvent {
  final int id;

  const GetClassroomEvent(this.id);

  @override
  List<Object> get props => [id];
}
