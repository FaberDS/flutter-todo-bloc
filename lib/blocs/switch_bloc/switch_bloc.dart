import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:flutter_tasks_app/blocs/bloc_exports.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchInitial(switchValue: false)) {
    on<SwitchOffEvent>((event, emit) {
      emit( SwitchState(switchValue: false));
    });
    on<SwitchOnEvent>((event, emit) {
      emit( SwitchState(switchValue: true));
    });
  }
  
  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    return SwitchState.fromMap(json);
  }
  
  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    return state.toMap();
  }
}
