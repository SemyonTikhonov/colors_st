import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

const Color defaultColor = Color(0xFF80DEEA);

class ColorsState extends Equatable {
  const ColorsState._({required this.text, required this.color});
  const ColorsState.initial()
      : color = defaultColor,
        text = '';
  final Color color; // screen color
  final String text; // word

  ColorsState copyWith({Color? color, String? text}) => ColorsState._(text: text ?? this.text, color: color ?? this.color);

  @override
  List<Object?> get props => [color, text];
}

class CounterCubit extends Cubit<ColorsState> {
  CounterCubit() : super(const ColorsState.initial());

  void updateText(String text) {
    emit(state.copyWith(text: text));
    computeColor();
  }

  void computeColor() {
    final units = [...utf8.encode(state.text)]..shuffle(Random(1));

    final hasEnoughDigits = units.length > 2;

    final red = (((hasEnoughDigits ? units[0] : defaultColor.red) / 255) * 255).floor();
    final blue = (((hasEnoughDigits ? units[1] : defaultColor.blue) / 255) * 230).floor();
    final green = (((hasEnoughDigits ? units[2] : defaultColor.green) / 255) * 200).floor();

    final Color color = Color.fromRGBO(red, blue, green, 1);

    updateColor(color);
  }

  void updateColor(Color color) {
    emit(state.copyWith(color: color));
  }
}
