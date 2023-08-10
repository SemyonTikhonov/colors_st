import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'colors_cubit.dart';

class ColorsPage extends StatefulWidget {
  const ColorsPage({super.key});

  @override
  State<ColorsPage> createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  bool isBrightEnough(Color color) {
    final luminance = (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    return !(1 - luminance > 0.5);
  }

  Color chooseSubColor(Color color) {
    return isBrightEnough(color) ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ColorsCubit(),
      child: BlocBuilder<ColorsCubit, ColorsState>(builder: (context, state) {
        final cubit = BlocProvider.of<ColorsCubit>(context);
        return Scaffold(
          backgroundColor: state.color,
          body: Center(
              child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: TextField(
                cursorColor: chooseSubColor(state.color),
                style: TextStyle(color: chooseSubColor(state.color)),
                decoration:
                    InputDecoration(focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: chooseSubColor(state.color)))),
                onChanged: cubit.updateText),
          )),
        );
      }),
    );
  }
}
