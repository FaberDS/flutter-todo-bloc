import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'dart:convert';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<RemoveTask>(_onRemoveTask);
    on<DeleteTask>(_onDeleteTask);
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    emit(TasksState(
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDeleted: () => true)),
        favoriteTasks: List.from(state.favoriteTasks)..remove(task),
        completedTasks: List.from(state.completedTasks)..remove(task),
        pendingTasks: List.from(state.pendingTasks)..remove(task)
        )
        );
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    print("state.removedTasks: ${state.removedTasks.length}");
    List<Task> removedTasks = List.from(state.removedTasks)..remove(task);
    print("removedTasks: ${removedTasks.length}");

    emit(TasksState(
      favoriteTasks: state.favoriteTasks, 
      removedTasks: removedTasks,
      completedTasks: state.completedTasks
      ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;

    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: () => true))
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: () => false))
          };
    emit(TasksState(
        pendingTasks: pendingTasks,
        removedTasks: state.removedTasks,
        completedTasks: completedTasks,
        favoriteTasks: state.favoriteTasks));
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        removedTasks: state.removedTasks,
        favoriteTasks: state.favoriteTasks,
        completedTasks: state.completedTasks));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
