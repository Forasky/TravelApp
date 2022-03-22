import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_application/models/authentication_model.dart';
import 'package:travel_application/services/translation.dart';

class AuthenticationBloc extends Cubit<AuthenticationBlocState> {
  AuthenticationBloc(AuthenticationBlocState initialState)
      : super(initialState);

  Future signUp(
      String email, String password, String number, String name) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final dbRef = FirebaseFirestore.instance.collection("Users");
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (FirebaseAuth.instance.currentUser != null) {
        dbRef.add(
          {"email": email, "number": number, "name": name},
        );
        emit(
          AuthenticationBlocState(
            message: '',
            isLogin: true,
            userName: name,
            email: email,
          ),
        );
      } else {
        setFalse('incorrect user');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setFalse(
          LocalizationKeys.incorrectPassword,
        );
      } else if (e.code == 'email-already-in-use') {
        setFalse(
          LocalizationKeys.accountExist,
        );
      }
    } catch (e) {
      setFalse(
        e.toString(),
      );
    }
  }

  Future checkSignIn() async {
    final result = FirebaseAuth.instance.currentUser;
    if (result != null) {
      emit(
        AuthenticationBlocState(
          message: '',
          isLogin: true,
          email: result.email,
          userName: result.displayName,
        ),
      );
    }
  }

  Future signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.instance.authStateChanges().listen(
        (User? user) {
          if (user != null) {
            emit(
              AuthenticationBlocState(
                isLogin: true,
                message: '',
                email: user.email,
                userName: user.displayName,
              ),
            );
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setFalse(
          LocalizationKeys.userNoFound,
        );
      } else if (e.code == 'wrong-password') {
        setFalse(
          LocalizationKeys.incorrectPassword,
        );
      }
    }
  }

  Future logOut() async {
    await FirebaseAuth.instance.signOut();
    emit(
      AuthenticationBlocState(
        message: '',
        isLogin: false,
      ),
    );
  }

  void setFalse(String message) {
    emit(
      AuthenticationBlocState(
        message: message,
        isLogin: false,
      ),
    );
    Future.delayed(
      const Duration(seconds: 3),
      () => emit(
        AuthenticationBlocState(
          isLogin: false,
          message: '',
        ),
      ),
    );
  }

  String validation(String text, String type) {
    switch (type) {
      case 'email':
        {
          if (text.isEmpty) {
            return LocalizationKeys.enterEmail;
          } else if (!text.contains('@')) {
            return LocalizationKeys.plsEnterEmail;
          }
          return '';
        }
      case 'password':
        {
          if (text.isEmpty) {
            return LocalizationKeys.enterPassword;
          } else if (text.length < 6) {
            return LocalizationKeys.plsEnterPassword;
          }
          return '';
        }
      case 'name':
        {
          if (text.isEmpty) {
            return LocalizationKeys.enterName;
          }
          return '';
        }
      case 'number':
        {
          if (text.isEmpty) {
            return LocalizationKeys.enterNumber;
          }
        }
    }
    return '';
  }
}
