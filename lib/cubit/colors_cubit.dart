import 'dart:ui';

import 'package:equatable/equatable.dart';

class ColorsState extends Equatable {
  const ColorsState._({required this.text, required this.color});
  const ColorsState.initial()
      : color = const Color(0xFF80DEEA),
        text = '';
  final Color color; // screen color
  final String text; // word

  ColorsState copyWith({Color? color, String? text}) => ColorsState._(text: text ?? this.text, color: color ?? this.color);

  @override
  List<Object?> get props => [color, text];
}
