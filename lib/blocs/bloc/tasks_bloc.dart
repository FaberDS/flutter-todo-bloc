
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
      removedTasks: List.from(state.removedTasks)..add(event.task.copyWith(isDeleted: ()=>true)), 
      allTasks: List.from(state.allTasks)..remove(task)));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    print("state.removedTasks: ${state.removedTasks.length}");
    List<Task> removedTasks = List.from(state.removedTasks)..remove(task);
    print("removedTasks: ${removedTasks.length}");

    emit(TasksState(
      allTasks: state.allTasks,
      removedTasks: removedTasks
      ));
  }
  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
  final int index = state.allTasks.indexOf(task);
    List<Task> allTasks = List.from(state.allTasks)..remove(task);
    task.isDone == false  
      ? allTasks.insert(index,task.copyWith(isDone: ()=>true))
      :  allTasks.insert(index,task.copyWith(isDone: ()=>false));
      emit(TasksState(allTasks: allTasks,removedTasks: state.removedTasks));
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(allTasks: List.from(state.allTasks)..add(event.task)
    ,removedTasks: state.removedTasks));
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
