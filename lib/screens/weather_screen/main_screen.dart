// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_application/screens/weather_screen/search_screen.dart';
import 'package:travel_application/screens/weather_screen/weather_screen.dart';

import '../../services/translation.dart';
import 'map_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminPage();
  }
}

class AdminPage extends StatefulWidget {
  @override
  AdminPageState createState() => AdminPageState();
}

class AdminPageState extends State<AdminPage>
    with SingleTickerProviderStateMixin {
  final cityController = TextEditingController();
  int currentIndex = 0;
  String ciName = 'Minsk';
  double lat = 0;
  double lon = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  void _setPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget _getPage(int index) {
    if (index == 0) {
      return WeatherScreen(
        cityName: ciName,
        lat: lat,
        lon: lon,
      );
    }
    if (index == 1) return SearchScreen(onCityTab: _navigateToHome);
    return MapSample(onLocationTab: _naviagateToHomeLocation);
  }

  void _navigateToHome(String city) {
    setState(() {
      lat = 0;
      lon = 0;
      ciName = city;
      currentIndex = 0;
    });
  }

  void _naviagateToHomeLocation(LatLng pos) {
    setState(() {
      lat = pos.latitude;
      lon = pos.longitude;
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Scaffold(
        body: _getPage(currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _setPage(index),
          items: [
            BottomNavigationBarItem(
              icon: const FaIcon(FontAwesomeIcons.cloud),
              label: LocalizationKeys.weather,
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
              icon: const FaIcon(FontAwesomeIcons.search),
              label: LocalizationKeys.search,
              backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: const FaIcon(FontAwesomeIcons.mapMarkedAlt),
              label: LocalizationKeys.map,
              backgroundColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
