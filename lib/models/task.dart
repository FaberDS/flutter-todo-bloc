import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class Task extends Equatable {


  final String id;
  final String title;
  final String desctiption;
  final String date;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;
  Task({
    required this.id,
    required this.title,
    required this.desctiption,
    required this.date,
    this.isDone,
    this.isDeleted,
    this.isFavorite,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
  }

  Task copyWith({
    String? id,
    String? title,
    String? desctiption,
    String? date,
    ValueGetter<bool?>? isDone,
    ValueGetter<bool?>? isDeleted,
    ValueGetter<bool?>? isFavorite,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      desctiption: desctiption ?? this.desctiption,
      date: date ?? this.date,
      isDone: isDone != null ? isDone() : this.isDone,
      isDeleted: isDeleted != null ? isDeleted() : this.isDeleted,
      isFavorite: isFavorite != null ? isFavorite() : this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desctiption': desctiption,
      'date': date,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      desctiption: map['desctiption'] ?? '',
      date: map['date'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
      isFavorite: map['isFavorite'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(id: $id, title: $title, desctiption: $desctiption, date: $date, isDone: $isDone, isDeleted: $isDeleted, isFavorite: $isFavorite)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      title,
      desctiption,
      date,
      isDone,
      isDeleted,
      isFavorite,
    ];
  }
}
