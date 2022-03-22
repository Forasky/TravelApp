import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_application/bloc/main_screen_bloc.dart';
import 'package:travel_application/models/main_screen_model.dart';
import 'package:travel_application/services/fonts.dart';
import 'package:travel_application/services/translation.dart';

import 'bottom_sheet_widget.dart';
import 'drawer_widget.dart';

class TransportScreen extends StatefulWidget {
  TransportScreen({
    Key? key,
    required this.titleText,
    required this.streamName,
  }) : super(key: key);
  final String titleText;
  String streamName;

  @override
  _TransportScreenState createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  final mainBloc = GetIt.instance.get<TransportScreenBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransportScreenBloc, TransportScreenBlocState>(
      bloc: mainBloc,
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            drawer: DrawerWidget(
              findOut: _setFind,
            ),
            appBar: AppBar(
              title: Text(
                widget.titleText,
                style: Font.joseStyleWhite24,
              ),
              backgroundColor: Colors.green,
            ),
            body: StreamBuilder(
              stream: mainBloc.streamBloc(widget.streamName),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                return ListView(
                  children: snapshot.data!.docs.map(
                    (DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ListItem(
                        from: data['From'],
                        to: data['To'],
                        when: data['When'].seconds * 1000,
                        name: data['Who'],
                        paid: data['Payment'].toString(),
                      );
                    },
                  ).toList(),
                );
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.green,
              onPressed: () {
                showModalBottomSheet<void>(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  isScrollControlled: true,
                  //backgroundColor: Colors.green,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: const BottomSheetWidget(),
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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        );
      },
    );
  }

  void _setFind(String find) {
    setState(() {
      widget.streamName=find;
    });
  }
}

class ListItem extends StatelessWidget {
  final String from;
  final String to;
  final int when;
  final String name;
  final String paid;
  const ListItem({
    Key? key,
    required this.from,
    required this.to,
    required this.when,
    required this.name,
    required this.paid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: TextButton(
        onPressed: () {},
        child: const Icon(
          Icons.star_border_outlined,
        ),
      ),
      leading: const Icon(
        FontAwesomeIcons.userAlt,
        size: 30,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            '$from - $to   ',
            style: Font.joseStyle18,
          ),
          Text(
            DateFormat('d.MM.y')
                    .format(
                      DateTime.fromMillisecondsSinceEpoch(when),
                    )
                    .toString() +
                ' ',
            style: Font.joseStyle18,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name.toString(),
            style: Font.joseStyleGrey16,
          ),
          Text(
            paid != '0' ? '$paid BYN' : LocalizationKeys.payment,
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
  }
}
