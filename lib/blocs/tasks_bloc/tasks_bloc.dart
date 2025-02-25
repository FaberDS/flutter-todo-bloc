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
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTask>(_onDeleteAllTask);
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
      completedTasks: state.completedTasks,
      pendingTasks: state.pendingTasks
      ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    task.isDone == true
        ? {
          completedTasks = List.from(completedTasks)..remove(task),
          pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: () => false))
            
          }
        : {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWith(isDone: () => true))
          };
    if (task.isFavorite == true) {
      var tasksIndex = favoriteTasks.indexOf(task);
      favoriteTasks = favoriteTasks..remove(task)
      ..insert(tasksIndex,task.copyWith(isDone:()=>   task.isDone == true ? false : true));
    }
    emit(TasksState(
        pendingTasks: pendingTasks,
        removedTasks: state.removedTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks));
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        removedTasks: state.removedTasks,
        favoriteTasks: state.favoriteTasks,
        completedTasks: state.completedTasks));
  }


  void _onMarkFavoriteOrUnfavoriteTask(MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    final isNotFavorite = event.task.isFavorite == false;

    if (event.task.isDone == false) {
      var taskIndex = pendingTasks.indexOf(task);
      final isNotFavorite = event.task.isFavorite == false;
      pendingTasks = List.from(pendingTasks)
        ..remove(task)
        ..insert(taskIndex,task.copyWith(isFavorite: ()=>isNotFavorite));
    } else {
      var taskIndex = completedTasks.indexOf(task);
      completedTasks = List.from(completedTasks)
        ..remove(task)
        ..insert(taskIndex,task.copyWith(isFavorite: ()=>isNotFavorite));
    }
    if(isNotFavorite) {
        favoriteTasks = List.from(favoriteTasks)..add(task.copyWith(isFavorite: ()=>true));
      } else {
        favoriteTasks = List.from(favoriteTasks)..remove(task);
      }
      emit(TasksState(
        pendingTasks: pendingTasks,
        removedTasks: state.removedTasks,
        favoriteTasks: favoriteTasks,
        completedTasks: completedTasks
      ));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favoriteTasks = state.favoriteTasks;
    if(event.oldTask.isFavorite == true) {
      favoriteTasks
        ..remove(event.oldTask)
        ..insert(0,event.newTask);
    }

    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)
      ..remove(event.oldTask)
      ..insert(0,event.newTask),
      completedTasks: state.completedTasks..remove(event.oldTask),
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks
    ));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        removedTasks:  List.from(state.removedTasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)
          ..insert(0,event.task.copyWith(
            isDeleted: ()=> false,
            isDone: ()=>false,
            isFavorite: ()=> event.task.isFavorite
          )),
          completedTasks: state.completedTasks,
          favoriteTasks: state.favoriteTasks
    ));
  }

  void _onDeleteAllTask(DeleteAllTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        removedTasks: List.from(state.removedTasks)..clear(),
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks
    ));
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
