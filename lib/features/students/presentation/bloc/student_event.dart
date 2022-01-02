part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class GetStudentEvent extends StudentEvent {
  final int id;
  const GetStudentEvent(this.id);

  @override
  List<Object> get props => [id];
}
