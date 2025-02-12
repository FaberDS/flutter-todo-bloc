import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class Task extends Equatable {

  static List <Task> tasksList = [
    Task(title: "Task 1"),
    Task(title: "Task 2"),
    Task(title: "Task 3")
  ];
  final String title;
  bool? isDone;
  bool? isDeleted;
  Task({
    required this.title,
    this.isDone,
    this.isDeleted,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWith({
    String? title,
    ValueGetter<bool?>? isDone,
    ValueGetter<bool?>? isDeleted,
  }) {
    return Task(
      title: title ?? this.title,
      isDone: isDone != null ? isDone() : this.isDone,
      isDeleted: isDeleted != null ? isDeleted() : this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() => 'Task(title: $title, isDone: $isDone, isDeleted: $isDeleted)';

  @override
  List<Object?> get props => [title, isDone, isDeleted];
}
