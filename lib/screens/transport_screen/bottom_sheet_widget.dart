import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_application/bloc/bottom_sheet_bloc.dart';
import 'package:travel_application/models/bottom_sheet_model.dart';
import 'package:travel_application/services/fonts.dart';
import 'package:travel_application/services/translation.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  var _isRadioSelected = false;
  final dateController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final paymentController = TextEditingController();
  final bloc = GetIt.instance.get<BottomSheetBloc>();
  String fromRegion = 'Брестская обл.';
  String toRegion = 'Брестская обл.';
  late String fromCity;
  late String toCity;

  @override
  void dispose() {
    dateController.dispose();
    nameController.dispose();
    phoneController.dispose();
    paymentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    bloc.state.regions.isEmpty ? bloc.readList() : super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetBloc, BottomSheetState>(
      bloc: bloc,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 70,
              ),
              child: Text(
                LocalizationKeys.addRequest,
                style: Font.joseStyle24,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: state.regions.isEmpty
                        ? const CircularProgressIndicator()
                        : Column(
                            children: [
                              Text(
                                LocalizationKeys.from,
                                style: Font.joseStyleGrey16,
                              ),
                              DropDownButton(
                                dropDownValue: state.regions.first.name,
                                listItem:
                                    state.regions.map((e) => e.name).toList(),
                                onValueChanged: (value) {
                                  setState(() {
                                    fromRegion = value;
                                  });
                                },
                              ),
                              DropDownButton(
                                dropDownValue:
                                    state.regions.first.cities.first.name,
                                listItem: state.regions
                                    .where(
                                      (e) => e.name.contains(fromRegion),
                                    )
                                    .map(
                                      (e) => e.cities
                                          .map(
                                            (e) => e.name,
                                          )
                                          .toList(),
                                    )
                                    .toList(),
                                onValueChanged: (value) => fromCity = value,
                              ),
                            ],
                          ),
                  ),
                  Expanded(
                    child: state.regions.isEmpty
                        ? const CircularProgressIndicator()
                        : Column(
                            children: [
                              Text(
                                LocalizationKeys.to,
                                style: Font.joseStyleGrey16,
                              ),
                              DropDownButton(
                                dropDownValue: state.regions.first.name,
                                listItem:
                                    state.regions.map((e) => e.name).toList(),
                                onValueChanged: (value) => toRegion = value,
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ),
              child: TextField(
                controller: dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  icon: const Icon(
                    FontAwesomeIcons.calendarAlt,
                  ),
                  hintText: LocalizationKeys.chooseDate,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ),
              child: TextField(
                controller: paymentController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  icon: const Icon(
                    FontAwesomeIcons.coins,
                  ),
                  hintText: LocalizationKeys.choosePayment,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.userAlt,
                        ),
                        hintText: LocalizationKeys.enterName,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.phoneAlt,
                        ),
                        hintText: LocalizationKeys.enterNumber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                10,
              ),
              child: Text(
                LocalizationKeys.iWantFind,
                textAlign: TextAlign.left,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LabeledRadio(
                  label: LocalizationKeys.findPeople,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  value: true,
                  groupValue: _isRadioSelected,
                  onChanged: (bool newValue) {
                    setState(
                      () {
                        _isRadioSelected = newValue;
                      },
                    );
                  },
                ),
                LabeledRadio(
                  label: LocalizationKeys.findCars,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  value: false,
                  groupValue: _isRadioSelected,
                  onChanged: (bool newValue) {
                    setState(
                      () {
                        _isRadioSelected = newValue;
                      },
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text(
                      LocalizationKeys.addRequest,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      bloc.addRequest(
                        _isRadioSelected == true
                            ? LocalizationKeys.people
                            : LocalizationKeys.cars,
                        fromCity.toString(),
                        phoneController.text,
                        paymentController.text,
                        toCity.toString(),
                        DateFormat('d.m.y').parse(dateController.text),
                        nameController.text,
                      );
                    },
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    child: Text(
                      LocalizationKeys.close,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year, DateTime.now().month),
      lastDate: DateTime(DateTime.now().year + 1, DateTime.now().month + 5),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(
        () {
          dateController.text = DateFormat('d.M.y').format(picked);
        },
      );
    }
  }
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class DropDownButton extends StatefulWidget {
  DropDownButton({
    Key? key,
    required this.dropDownValue,
    required this.listItem,
    required this.onValueChanged,
  }) : super(key: key);
  String dropDownValue;
  List listItem;
  ValueChanged<String> onValueChanged;

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dropDownValue,
      elevation: 16,
      style: const TextStyle(
        color: Colors.green,
      ),
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      onChanged: (
        String? newValue,
      ) {
        setState(
          () {
            widget.dropDownValue = newValue!;
            widget.onValueChanged(newValue);
          },
        );
      },
      items: widget.listItem.map<DropdownMenuItem<String>>(
        (value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
            ),
          );
        },
      ).toList(),
    );
  }
}
