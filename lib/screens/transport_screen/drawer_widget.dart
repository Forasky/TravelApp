import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_application/bloc/authentication_bloc.dart';
import 'package:travel_application/screens/settings_screen/settings_screen.dart';
import 'package:travel_application/services/fonts.dart';
import 'package:travel_application/services/translation.dart';

import '../../bloc/color_choose_bloc.dart';
import '../../models/authentication_model.dart';
import '../../services/extension.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({
    Key? key,
    required this.findOut,
  }) : super(key: key);
  final ValueChanged<String> findOut;
  final bloc = GetIt.I.get<AuthenticationBloc>();
  final sharedPrefs = GetIt.I.get<ColorChooseBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
      bloc: bloc,
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
                children: <Widget>[
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: Icon(
                      Icons.map_outlined,
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
                  const Spacer(),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      findOut(LocalizationKeys.cars);
                    },
                    leading: const FaIcon(
                      FontAwesomeIcons.car,
                    ),
                    title: Text(
                      LocalizationKeys.checkCars,
                      style: Font.joseStyleWhite20,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      findOut(LocalizationKeys.people);
                    },
                    leading: const FaIcon(
                      FontAwesomeIcons.userAlt,
                    ),
                    title: Text(
                      LocalizationKeys.checkPeople,
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
                      LocalizationKeys.settings,
                      style: Font.joseStyleWhite20,
                    ),
                  ),
                  Text(
                    LocalizationKeys.nameApplication,
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
