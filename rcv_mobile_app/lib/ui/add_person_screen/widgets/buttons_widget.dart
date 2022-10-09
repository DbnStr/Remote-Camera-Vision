import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../add_person_screen_viewmodel.dart';

class Buttons extends ViewModelWidget<AddPersonScreenViewModel> {
  @override
  Widget build(BuildContext context, AddPersonScreenViewModel viewModel) {
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: ElevatedButton(
          onPressed: () {
            print("Select");
            viewModel.selectImages();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.green,
            elevation: 2,
          ),
          child: const Text('Выбрать фото'),
        ),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: ElevatedButton(
          onPressed: () {
            print("Add");
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.green,
            elevation: 2,
          ),
          child: const Text('Добавить'),
        ),
      ),
    ]);
  }
}
