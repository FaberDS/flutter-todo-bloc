import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class Task extends Equatable {


  final String id;
  final String title;
  final String desctiption;
  bool? isDone;
  bool? isDeleted;
  Task({
    required this.id,
    required this.title,
    required this.desctiption,
    this.isDone,
    this.isDeleted,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWith({
    String? id,
    String? title,
    String? desctiption,
    ValueGetter<bool?>? isDone,
    ValueGetter<bool?>? isDeleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      desctiption: desctiption ?? this.desctiption,
      isDone: isDone != null ? isDone() : this.isDone,
      isDeleted: isDeleted != null ? isDeleted() : this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desctiption': desctiption,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      desctiption: map['desctiption'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(id: $id, title: $title, desctiption: $desctiption, isDone: $isDone, isDeleted: $isDeleted)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      desctiption,
      isDone,
      isDeleted,
    ];
  }
}
