import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_application/screens/settings_screen/settings_screen.dart';
import 'package:travel_application/services/fonts.dart';
import 'package:travel_application/services/translation.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    required this.findOut,
  }) : super(key: key);
  final ValueChanged<String> findOut;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.green,
      ),
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                child: Icon(
                  Icons.map_outlined,
                  color: Colors.black,
                  size: 50,
                ),
              ),
              Text(
                'Артём Андреевич', //here will be UserName
                style: Font.joseStyleWhite24,
              ),
              Text(
                '+375445458845', //here will be UserNumber
                style: Font.joseStyleWhite16,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    LocalizationKeys.viewProfile,
                    style: Font.joseStyleWhite20,
                  ),
                ),
              ),
              const Spacer(),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  findOut(LocalizationKeys.cars);
                },
                leading: const FaIcon(
                  FontAwesomeIcons.car,
                ),
                title: Text(
                  LocalizationKeys.checkCars,
                  style: Font.joseStyleWhite20,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  findOut(LocalizationKeys.people);
                },
                leading: const FaIcon(
                  FontAwesomeIcons.userAlt,
                ),
                title: Text(
                  LocalizationKeys.checkPeople,
                  style: Font.joseStyleWhite20,
                ),
              ),
              const Spacer(),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                leading: const FaIcon(
                  FontAwesomeIcons.cogs,
                ),
                title: Text(
                  LocalizationKeys.settings,
                  style: Font.joseStyleWhite20,
                ),
              ),
              Text(
                LocalizationKeys.nameApplication,
                style: Font.joseStyleWhite16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
