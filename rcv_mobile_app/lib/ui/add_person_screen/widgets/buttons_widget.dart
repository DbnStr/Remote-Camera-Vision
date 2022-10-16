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
            print("Select");
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
            print("Add");
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
