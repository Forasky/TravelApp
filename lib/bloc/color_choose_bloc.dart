import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/color_choose_model.dart';

class ColorChooseBloc extends Cubit<ColorChooseBlocState> {
  ColorChooseBloc(ColorChooseBlocState initialState) : super(initialState);

  Future getColor(String s) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    emit(
      ColorChooseBlocState(
        color: sharedPrefs.getString('color') ?? '#00ff00',
      ),
    );
  }

  Future setColor(Color color) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final hexColor = '#${color.value.toRadixString(16).padLeft(2, '0')}';
    sharedPrefs.setString(
      'color',
      hexColor,
    );
    emit(
      ColorChooseBlocState(color: hexColor),
    );
  }
}
