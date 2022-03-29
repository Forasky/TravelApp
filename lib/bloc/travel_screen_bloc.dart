import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/travel_screen_model.dart';

class TravelScreenBloc extends Cubit<TravelScreenBlocState> {
  TravelScreenBloc(TravelScreenBlocState initialState) : super(initialState);

  Future getColor() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString('color') ?? '#00ff00';
  }

  Future setColor(Color color) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(
        'color', '#${color.value.toRadixString(16).padLeft(2, '0')}');
  }
}
