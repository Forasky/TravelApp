import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_application/screens/travel_screen/travel_screen.dart';

import 'bloc/authentication_bloc.dart';
import 'bloc/bottom_sheet_bloc.dart';
import 'bloc/main_screen_bloc.dart';
import 'bloc/search_bloc.dart';
import 'bloc/weather_bloc.dart';
import 'models/authentication_model.dart';
import 'models/bottom_sheet_model.dart';
import 'models/searchBloc_model.dart';
import 'models/weather_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.instance.registerSingleton<TransportScreenBloc>(
    TransportScreenBloc(true),
  );
  GetIt.instance.registerSingleton<BottomSheetBloc>(
    BottomSheetBloc(
      BottomSheetState(
        regions: [],
      ),
    ),
  );
  GetIt.instance.registerSingleton<TempBloc>(
    TempBloc(
      WeatherBlocState(
        temperature: Temperature(
          current: Current(
              dt: DateTime.now(),
              feelsLike: 0,
              humidity: 0,
              pressure: 0,
              temp: 0,
              weather: [],
              windSpeed: 0),
          daily: [],
          hasData: false,
          hourly: [],
        ),
        currentCity: '',
      ),
    ),
  );
  GetIt.instance.registerSingleton<SearchBloc>(
    SearchBloc(
      SearchBlocState(),
    ),
  );
  GetIt.instance.registerSingleton<AuthenticationBloc>(
    AuthenticationBloc(
      AuthenticationBlocState(
        message: '',
        isLogin: false,
      ),
    ),
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const TravelScreen(),
    ),
  );
}
