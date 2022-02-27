// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_application/bloc/authentication_bloc.dart';
import 'package:travel_application/models/authentication_model.dart';
import 'package:travel_application/screens/signup_screen.dart/signup_screen.dart';
import 'package:travel_application/screens/transport_screen/transport_screen.dart';
import 'package:travel_application/services/fonts.dart';
import 'package:travel_application/services/translation.dart';

class StartWidget extends StatefulWidget {
  StartWidget({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordControler = TextEditingController();

  @override
  _StartWidgetState createState() => _StartWidgetState();
}

class _StartWidgetState extends State<StartWidget> {
  static const logo = 'assets/images/logo.png';
  static const title = 'PeCaBel';
  final authBloc = GetIt.I.get<AuthenticationBloc>();

  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
      bloc: authBloc,
      builder: (context, state) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Image.asset(
                        logo,
                        width: 150,
                        height: 150,
                      ),
                    ),
                    Text(
                      title,
                      style: Font.joseStyle24,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RichText(
                        text: TextSpan(
                          style: Font.joseStyle18,
                          children: [
                            TextSpan(
                              text: LocalizationKeys.explainText,
                            ),
                            TextSpan(
                              text: '\n' + LocalizationKeys.ifHaveNotAccount,
                            ),
                            TextSpan(
                              text: LocalizationKeys.register,
                              style: GoogleFonts.jost(
                                fontSize: 20,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpWidget(),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: widget.emailController,
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
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: widget.passwordControler,
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
                    ElevatedButton(
                      onPressed: () {
                        authBloc.signIn(
                          widget.emailController.text,
                          widget.passwordControler.text,
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
                            content: Text(state.message),
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
                        LocalizationKeys.login,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        LocalizationKeys.forgotPassword,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        15,
                      ),
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
