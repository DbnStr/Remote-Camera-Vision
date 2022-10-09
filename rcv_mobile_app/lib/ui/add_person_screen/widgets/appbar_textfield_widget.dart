import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../add_person_screen_viewmodel.dart';

class AppbarTextfield extends ViewModelWidget<AddPersonScreenViewModel> {
  @override
  Widget build(BuildContext context, AddPersonScreenViewModel viewModel) {
    return Expanded(
      flex: 5,
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(0),
          counter: null,
          counterText: "",
          hintText: "Name",
          hintStyle: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            height: 1.5,
            color: Colors.grey,
          ),
        ),
        maxLength: 31,
        maxLines: 1,
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          height: 1.5,
          color: Colors.black,
        ),
        textCapitalization: TextCapitalization.words,
        controller: viewModel.nameController,
      ),
    );
  }
}
