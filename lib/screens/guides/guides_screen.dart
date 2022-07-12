import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_application/bloc/color_choose_bloc.dart';
import 'package:travel_application/bloc/main_screen_bloc.dart';
import 'package:travel_application/models/color_choose_model.dart';
import 'package:travel_application/screens/guides/guides_add.dart';
import 'package:travel_application/screens/travel_screen/drawer_widget.dart';
import 'package:travel_application/services/extension.dart';
import 'package:travel_application/services/fonts.dart';
import 'package:travel_application/services/translation.dart';

class GuidesScreen extends StatefulWidget {
  const GuidesScreen({Key? key}) : super(key: key);

  @override
  State<GuidesScreen> createState() => _GuidesScreenState();
}

class _GuidesScreenState extends State<GuidesScreen> {
  final mainBloc = GetIt.instance.get<TransportScreenBloc>();
  final bloc = GetIt.instance.get<ColorChooseBloc>();

  @override
  Widget build(BuildContext context) {
    Future<DataSnapshot> firebase = FirebaseDatabase(
            databaseURL:
                "https://travelapplication-ed2ff-default-rtdb.europe-west1.firebasedatabase.app")
        .reference()
        .child('')
        .get();
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
                title: const Text('Экскурсии'),
              ),
              body: FutureBuilder(
                future: firebase,
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        LocalizationKeys.whatsWrong,
                        style: Font.joseStyle24,
                      ),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const CircularProgressIndicator(),
                          Text(
                            LocalizationKeys.loading,
                            style: Font.joseStyle24,
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done && snapshot.data == null) {
                    return Center(
                      child: Text('Экскурсий не найдено', style: Font.joseStyle20),
                    );
                  }
                  return ListView.builder(
                    //itemCount: snapshot.data,
                    itemBuilder: (context, index) {
                    return ListTile(
                      leading: FaIcon(FontAwesomeIcons.mapMarkedAlt),
                      title: Text(''),
                      subtitle: Text(''),
                    );
                  });
                },
              ),
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: HexColor.fromHex('${bloc.state.color}'),
                onPressed: () {
                  showModalBottomSheet<void>(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: const BottomGuidesSheet(),
                      );
                    },
                  );
                },
                label: Text(
                  LocalizationKeys.add,
                ),
                icon: const Icon(
                  FontAwesomeIcons.plus,
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            ),
          ),
        );
      },
    );
  }
}
