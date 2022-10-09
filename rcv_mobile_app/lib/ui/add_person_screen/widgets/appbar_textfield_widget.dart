import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/constants/colors.dart';
import 'package:rcv_mobile_app/constants/text.dart';
import 'package:stacked/stacked.dart';

import '../add_person_screen_viewmodel.dart';

class AppbarTextfield extends ViewModelWidget<AddPersonScreenViewModel> {
  @override
  Widget build(BuildContext context, AddPersonScreenViewModel viewModel) {
    return Expanded(
      flex: 5,
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
          counter: null,
          counterText: "",
          hintText: TextConstants.NAME,
          hintStyle: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            height: 1.5,
            color: ColorTheme.secondaryText,
          ),
        ),
        maxLength: 31,
        maxLines: 1,
        style: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          height: 1.5,
          color: ColorTheme.primaryText,
        ),
        textCapitalization: TextCapitalization.words,
        controller: viewModel.nameController,
      ),
    );
  }
}
