
part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> removedTasks;
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> favoriteTasks;
  const TasksState(
    {
      this.pendingTasks = const <Task>[],
      this.removedTasks = const <Task>[],
      this.completedTasks = const <Task>[],
      this.favoriteTasks = const <Task>[],
      }
  );
  
  @override
  List<Object> get props => [pendingTasks,removedTasks,favoriteTasks,completedTasks];

  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      completedTasks: List<Task>.from(map['completedTasks']?.map((x) => Task.fromMap(x))),
      removedTasks: List<Task>.from(map['removedTasks']?.map((x) => Task.fromMap(x))),
      pendingTasks: List<Task>.from(map['pendingTasks']?.map((x) => Task.fromMap(x))),
      favoriteTasks: List<Task>.from(map['favoriteTasks']?.map((x) => Task.fromMap(x))),
    );
  }

  String toJson() => jsonEncode(toMap()); // ✅ Explicit function
factory TasksState.fromJson(String source) => TasksState.fromMap(jsonDecode(source)); // ✅ Explicit function

}

 class TasksInitial extends TasksState {}
