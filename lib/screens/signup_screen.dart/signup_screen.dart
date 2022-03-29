// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_application/bloc/authentication_bloc.dart';
import 'package:travel_application/models/authentication_model.dart';
import 'package:travel_application/screens/transport_screen/transport_screen.dart';
import 'package:travel_application/services/fonts.dart';
import 'package:travel_application/services/translation.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final emailContorller = TextEditingController();
  final passwordContorler = TextEditingController();
  final numberController = TextEditingController();
  final nameController = TextEditingController();
  final authBloc = GetIt.I.get<AuthenticationBloc>();

  @override
  void dispose() {
    emailContorller.dispose();
    passwordContorler.dispose();
    numberController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
      bloc: authBloc,
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                LocalizationKeys.labelRegistration,
                style: Font.joseStyle20,
              ),
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      icon: const Icon(
                        FontAwesomeIcons.userAlt,
                      ),
                      hintText: LocalizationKeys.enterFLname,
                    ),
                    validator: (value) => authBloc.validation(
                      value ?? '',
                      'name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: TextFormField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: const Icon(
                        FontAwesomeIcons.phoneAlt,
                      ),
                      hintText: LocalizationKeys.enterNumber,
                    ),
                    validator: (value) => authBloc.validation(
                      value ?? '',
                      'number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: TextFormField(
                    controller: emailContorller,
                    decoration: InputDecoration(
                      icon: const Icon(
                        FontAwesomeIcons.mailBulk,
                      ),
                      hintText: LocalizationKeys.enterEmail,
                    ),
                    validator: (value) => authBloc.validation(
                      value ?? '',
                      'email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: TextFormField(
                    controller: passwordContorler,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: const Icon(
                        FontAwesomeIcons.lock,
                      ),
                      hintText: LocalizationKeys.wrPassword,
                    ),
                    validator: (value) => authBloc.validation(
                      value ?? '',
                      'password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: const Icon(
                        FontAwesomeIcons.lock,
                      ),
                      hintText: LocalizationKeys.repeatPassword,
                    ),
                    validator: (value) {
                      authBloc.validation(
                        value ?? '',
                        'password',
                      );
                      if (value != passwordContorler.text) Exception();
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () async {
                      await authBloc.signUp(
                        emailContorller.text,
                        passwordContorler.text,
                        numberController.text,
                        nameController.text,
                      );
                      if (state.isLogin) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransportScreen(
                              titleText: LocalizationKeys.findPeople,
                              streamName: LocalizationKeys.people,
                            ),
                          ),
                        );
                      } else {
                        AlertDialog(
                          title: Text(
                            LocalizationKeys.error,
                          ),
                          content: Text(
                            state.message,
                          ),
                          actions: [
                            ElevatedButton(
                              child: Text(
                                LocalizationKeys.submit,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      }
                    },
                    child: Text(
                      LocalizationKeys.submit,
                      style: Font.joseStyle20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    20,
                  ),
                  child: Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
