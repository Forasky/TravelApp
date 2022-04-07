import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_application/bloc/color_choose_bloc.dart';

import '../../models/color_choose_model.dart';

class SelectColor extends StatelessWidget {
  SelectColor({Key? key}) : super(key: key);
  final bloc = GetIt.instance.get<ColorChooseBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorChooseBloc, ColorChooseBlocState>(
      bloc: bloc,
      builder: (context, state) {
        return AlertDialog(
          content: SizedBox(
            height: 100,
            width: 300,
            child: GridView.count(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: <Widget>[
                ColorContainer(
                  color: Colors.brown,
                  changedColor: (Color color) {
                    bloc.setColor(color);
                  },
                ),
                ColorContainer(
                  color: Colors.grey,
                  changedColor: (Color color) {
                    bloc.setColor(color);
                  },
                ),
                ColorContainer(
                  color: Colors.lime,
                  changedColor: (Color color) {
                    bloc.setColor(color);
                  },
                ),
                ColorContainer(
                  color: Colors.green,
                  changedColor: (Color color) {
                    bloc.setColor(color);
                  },
                ),
                ColorContainer(
                  color: Colors.amber,
                  changedColor: (Color color) {
                    bloc.setColor(color);
                  },
                ),
                ColorContainer(
                  color: Colors.deepOrange,
                  changedColor: (Color color) {
                    bloc.setColor(color);
                  },
                ),
                ColorContainer(
                  color: Colors.pink,
                  changedColor: (Color color) {
                    bloc.setColor(color);
                  },
                ),
                ColorContainer(
                  color: Colors.blue,
                  changedColor: (Color color) {
                    bloc.setColor(color);
                  },
                ),
                ColorContainer(
                  color: Colors.indigo,
                  changedColor: (Color color) {
                    bloc.setColor(color);
                  },
                ),
                ColorContainer(
                  color: Colors.purple,
                  changedColor: (Color color) {
                    bloc.setColor(color);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ColorContainer extends StatelessWidget {
  ColorContainer({Key? key, required this.color, required this.changedColor})
      : super(key: key);
  final color;
  ValueChanged<Color> changedColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changedColor(color),
      child: Container(
        width: 20,
        height: 20,
        color: color,
      ),
    );
  }
}
