import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_application/services/fonts.dart';

import 'drawer_widget.dart';

class TravelScreen extends StatefulWidget {
  const TravelScreen({Key? key}) : super(key: key);

  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SafeArea(
        child: Scaffold(
          drawer: TravelDrawerWidget(),
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text('Рядом с вами'),
          ),
          body: Column(
            children: <Widget>[
              Hero(
                tag: '01',
                child: ListTile(
                  trailing: TextButton(
                    onPressed: () {},
                    child: const FaIcon(
                      FontAwesomeIcons.heart,
                    ),
                  ),
                  leading: const Icon(
                    FontAwesomeIcons.chessRook,
                    size: 30,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Мирский замок',
                        style: Font.joseStyle18,
                      ),
                      Text(
                        '150 км',
                        style: Font.joseStyle18,
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '10 C',
                        style: Font.joseStyleGrey16,
                      ),
                      Text(
                        'Пасмурно',
                        style: Font.joseStyleGrey16,
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(
                    30,
                    10,
                    0,
                    15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
