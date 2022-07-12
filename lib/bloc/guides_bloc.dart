import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_application/models/guides_model.dart';

class GuidesBloc extends Cubit<GuidesState> {
  GuidesBloc(GuidesState initialState) : super(initialState);

  Future addGuides(date, place, descr, time, amount, pay, duration) async {
    final firebase = FirebaseDatabase(
      databaseURL: "https://travelapplication-ed2ff-default-rtdb.europe-west1.firebasedatabase.app",
    ).ref();
    await firebase.child(DateFormat('d_M_y').format(date).toString()).update({
      "$place": {
        "Description": "$descr",
        "Date": "$date",
        "Time": "$time",
        "Amount": "$amount",
        "Pay": "$pay",
        "Duration" : "$duration"
      }
    });
  }
}
