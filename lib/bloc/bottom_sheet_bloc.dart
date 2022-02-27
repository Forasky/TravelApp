import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_application/models/bottom_sheet_model.dart';

class BottomSheetBloc extends Cubit<BottomSheetState> {
  BottomSheetBloc(BottomSheetState initialState) : super(initialState);

  void readList() async {
    final text = await rootBundle.loadString('assets/cities/by-cities.json');
    emit(
      BottomSheetState.fromJson(
        jsonDecode(text),
      ),
    );
  }

  Future<void> addRequest(
    String collection,
    String from,
    String number,
    String payment,
    String to,
    DateTime when,
    String who,
  ) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(collection);
    users.add(
      {
        'From': from,
        'Number': number,
        'Payment': payment,
        'To': to,
        'When': when,
        'Who': who,
      },
    );
  }
}
