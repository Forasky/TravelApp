import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_application/models/color_choose_model.dart';
import 'package:travel_application/screens/travel_screen/info_screen.dart';
import 'package:travel_application/services/extension.dart';
import 'package:travel_application/services/fonts.dart';

import '../../bloc/color_choose_bloc.dart';
import 'drawer_widget.dart';

class TravelScreen extends StatefulWidget {
  const TravelScreen({Key? key}) : super(key: key);

  @override
  State<TravelScreen> createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  final bloc = GetIt.instance.get<ColorChooseBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorChooseBloc, ColorChooseBlocState>(
      bloc: bloc,
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: SafeArea(
            child: Scaffold(
              drawer: TravelDrawerWidget(),
              appBar: AppBar(
                backgroundColor: HexColor.fromHex('${state.color}'),
                title: const Text('Рядом с вами'),
              ),
              body: Column(
                children: <Widget>[
                  OpenContainer(
                    transitionDuration: const Duration(seconds: 1),
                    closedBuilder: (context, void Function() action) {
                      return ListTile(
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
                              '1 C',
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
                      );
                    },
                    openBuilder: (context, void Function() action) {
                      return InfoScreen(
                        title: 'Мирсикй замок',
                        image: const FaIcon(
                          FontAwesomeIcons.chessRook,
                        ),
                        temperature: 10,
                        distance: 220,
                        description:
                            'Этот замок очень красивый. Он олицетворяет историкокультурное наследие Беларуси и выглядит массивно, широко, раскинуто.',
                      );
                    },
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
