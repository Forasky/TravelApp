import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_application/models/main_screen_model.dart';

class TransportScreenBloc extends Cubit<TransportScreenBlocState> {
  TransportScreenBloc(initialState)
      : super(
          TransportScreenBlocState(
            isOn: true,
          ),
        );

  Stream<QuerySnapshot<Map<String, dynamic>>> streamBloc(String whatToFind) {
    final documentStream =
        FirebaseFirestore.instance.collection(whatToFind).snapshots();
    return documentStream;
  }
}
