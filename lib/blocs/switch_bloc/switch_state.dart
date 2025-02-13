part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  final bool switchValue;

  const SwitchState({
    required this.switchValue,
  });

  @override
  List<Object> get props => [switchValue];

  SwitchState copyWith({
    bool? switchValue,
  }) {
    return SwitchState(
      switchValue: switchValue ?? this.switchValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'switchValue': switchValue,
    };
  }

  factory SwitchState.fromMap(Map<String, dynamic> map) {
    return SwitchState(
      switchValue: map['switchValue'] ?? false,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory SwitchState.fromJson(String source) => SwitchState.fromMap(jsonDecode(source));

  @override
  String toString() => 'SwitchState(switchValue: $switchValue)';
}

class SwitchInitial extends SwitchState {
  SwitchInitial({required bool switchValue}): super(switchValue: switchValue);
}
