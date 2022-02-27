// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class SelectLanguage extends StatelessWidget {
  final english = 'English';
  final russian = 'Русский';

  const SelectLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _TileOfChoosing(
            locale: context.supportedLocales[0],
            title: english,
          ),
          const Divider(
            height: 24,
            color: Colors.grey,
          ),
          _TileOfChoosing(
            locale: context.supportedLocales[1],
            title: russian,
          ),
        ],
      ),
    );
  }
}

class _TileOfChoosing extends StatelessWidget {
  const _TileOfChoosing({
    Key? key,
    required this.locale,
    required this.title,
  }) : super(key: key);

  final String title;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        title,
      ),
      onTap: () async {
        await context.setLocale(
          locale,
        );
        Navigator.pop(context);
        // const SnackBar(
        //   content: Text('To apply changes, please, restart app'),
        // );
      },
    );
  }
}
