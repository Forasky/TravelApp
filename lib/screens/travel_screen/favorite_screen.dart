import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_application/screens/travel_screen/travel_screen.dart';

import '../../services/fonts.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TravelScreen(),
              ),
            ),
            child: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            ),
          ),
          title: const Text('Любимые места'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Text(
            'Добавьте любимый город..',
            style: Font.joseStyle24,
          ),
        ),
      ),
    );
  }
}
