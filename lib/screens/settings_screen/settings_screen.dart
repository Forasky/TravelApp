// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_application/bloc/color_choose_bloc.dart';
import 'package:travel_application/screens/settings_screen/color_select.dart';
import 'package:travel_application/services/translation.dart';

import '../../models/color_choose_model.dart';
import '../../services/extension.dart';
import 'language_select_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final sharedPref = GetIt.instance.get<ColorChooseBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorChooseBloc, ColorChooseBlocState>(
      bloc: sharedPref,
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                LocalizationKeys.settings,
              ),
              backgroundColor: HexColor.fromHex('${state.color}'),
            ),
            body: Center(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      LocalizationKeys.chooseLang,
                    ),
                    subtitle: Text(
                      LocalizationKeys.currentLang + context.locale.toString(),
                    ),
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => const SelectLanguage(),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Choose color of toolbar",
                    ),
                    subtitle: Text(
                        "Current color: ${HexColor.fromHex('${state.color}')}"),
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => SelectColor(),
                    ),
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
