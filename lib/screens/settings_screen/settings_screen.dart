// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_application/screens/settings_screen/color_select.dart';
import 'package:travel_application/services/translation.dart';

import 'language_select_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final sharedPref = GetIt.instance.get<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocalizationKeys.settings,
          ),
          backgroundColor: Colors.green,
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
                subtitle:
                    Text("Current color: ${sharedPref.getString('color')}"),
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
  }
}
