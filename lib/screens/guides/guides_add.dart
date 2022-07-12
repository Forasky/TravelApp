import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_application/bloc/color_choose_bloc.dart';
import 'package:travel_application/bloc/guides_bloc.dart';
import 'package:travel_application/services/fonts.dart';

class BottomGuidesSheet extends StatefulWidget {
  const BottomGuidesSheet({Key? key}) : super(key: key);

  @override
  State<BottomGuidesSheet> createState() => _BottomGuidesSheetState();
}

class _BottomGuidesSheetState extends State<BottomGuidesSheet> {
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountPeople = TextEditingController();
  final _price = TextEditingController();
  final _duration = TextEditingController();
  final bloc = GetIt.instance.get<ColorChooseBloc>();

  @override
  void dispose() {
    _placeController.dispose();
    _descriptionController.dispose();
    _amountPeople.dispose();
    _price.dispose();
    _duration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 35),
                child: Text(
                  'Создание заявки на экскурсию',
                  style: Font.joseStyle20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                    hintText: 'Уточните место',
                  ),
                ),
              ),
              // get data
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Введите описание',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _amountPeople,
                        decoration: const InputDecoration(
                          hintText: 'Кол-во человек',
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _price,
                        decoration: const InputDecoration(
                          hintText: 'Цена',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: _duration,
                  decoration: const InputDecoration(
                    hintText: 'Продолжительность экскурсии',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  GetIt.instance.get<GuidesBloc>().addGuides(
                      'data',
                      _placeController.text,
                      _descriptionController.text,
                      'time',
                      _amountPeople.text,
                      _price.text,
                      _duration.text);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: const Text('Создать заявку'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
