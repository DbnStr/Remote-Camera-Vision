import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/constants/colors.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/text.dart';
import '../add_person_screen_viewmodel.dart';

class Buttons extends ViewModelWidget<AddPersonScreenViewModel> {
  @override
  Widget build(BuildContext context, AddPersonScreenViewModel viewModel) {
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: ElevatedButton(
          onPressed: () {
            log("Add person screen :: Select images");
            viewModel.selectImages();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: ColorTheme.primaryText,
            elevation: 2,
          ),
          child: Text(TextConstants.SELECT_PHOTO.toUpperCase()),
        ),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: ElevatedButton(
          onPressed: () {
            viewModel.publishNotificationPerson();
            log("Add person screen :: Add new person");
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Человек успешно добавлен'),
                content: const Text(''),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('К списку камер'))
                ],
                  actionsAlignment: MainAxisAlignment.center
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: ColorTheme.primaryText,
            elevation: 2,
          ),
          child: Text(TextConstants.ADD.toUpperCase()),
        ),
      ),
    ]);
  }
}
