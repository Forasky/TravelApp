import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_application/bloc/authentication_bloc.dart';
import 'package:travel_application/bloc/color_choose_bloc.dart';
import 'package:travel_application/models/authentication_model.dart';
import 'package:travel_application/screens/guides/guides_screen.dart';
import 'package:travel_application/screens/login_screen/login_screen.dart';
import 'package:travel_application/screens/settings_screen/settings_screen.dart';
import 'package:travel_application/screens/transport_screen/transport_screen.dart';
import 'package:travel_application/screens/weather_screen/main_screen.dart';
import 'package:travel_application/services/fonts.dart';
import 'package:travel_application/services/translation.dart';

import '../../services/extension.dart';

class TravelDrawerWidget extends StatelessWidget {
  TravelDrawerWidget({Key? key}) : super(key: key);
  final authBloc = GetIt.I.get<AuthenticationBloc>();
  final sharedPrefs = GetIt.I.get<ColorChooseBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
      bloc: authBloc,
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            canvasColor: HexColor.fromHex('${sharedPrefs.state.color}'),
          ),
          child: Drawer(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: FaIcon(
                      FontAwesomeIcons.userAlt,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                  ...state.isLogin == false
                      ? {
                          Text(
                            'Вы не в системе',
                            style: Font.joseStyleWhite16,
                          ),
                          TextButton(
                            child: Text(
                              'Войти',
                              style: Font.joseStyleWhite16,
                            ),
                            onPressed: () {},
                          ),
                        }
                      : {
                          Text(
                            state.userName.toString(),
                            style: Font.joseStyleWhite16,
                          ),
                          Text(
                            state.email.toString(),
                            style: Font.joseStyleWhite16,
                          ),
                        },
                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //       LocalizationKeys.viewProfile,
                  //       style: Font.joseStyleWhite20,
                  //     ),
                  //   ),
                  // ),
                  const Spacer(),
                  ListTile(
                    onTap: () {
                      if (state.isLogin) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GuidesScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartWidget(),
                          ),
                        );
                      }
                    },
                    leading: const FaIcon(
                      FontAwesomeIcons.userAlt,
                    ),
                    title: Text(
                      'Экскурсии',
                      style: Font.joseStyleWhite20,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      if (state.isLogin) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransportScreen(
                              titleText: LocalizationKeys.findPeople,
                              streamName: LocalizationKeys.people,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartWidget(),
                          ),
                        );
                      }
                    },
                    leading: const FaIcon(
                      FontAwesomeIcons.car,
                    ),
                    title: Text(
                      'Попутчики',
                      style: Font.joseStyleWhite20,
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    ),
                    leading: const FaIcon(
                      FontAwesomeIcons.cloud,
                    ),
                    title: Text(
                      'Погода',
                      style: Font.joseStyleWhite20,
                    ),
                  ),

                  const Spacer(),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                    leading: const FaIcon(
                      FontAwesomeIcons.cogs,
                    ),
                    title: Text(
                      'Настройки',
                      style: Font.joseStyleWhite20,
                    ),
                  ),
                  Text(
                    'Турист Беларуси',
                    style: Font.joseStyleWhite16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
