// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:travel_application/services/translation.dart';

import 'language_select_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          child: ListTile(
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
        ),
      ),
    );
  }
}
