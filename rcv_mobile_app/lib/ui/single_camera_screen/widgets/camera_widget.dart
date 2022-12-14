import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../single_camera_screen_viewmodel.dart';


class Camera extends ViewModelWidget<SingleCameraScreenViewModel> {
  @override
  Widget build(BuildContext context, SingleCameraScreenViewModel viewModel) {
    return (
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.96,
            height: MediaQuery.of(context).size.height - 146,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.black,
            ),
            child: viewModel.model.currentView != null ?
              Image.memory(base64Decode(viewModel.model.currentView!), height: 400, width: 400)
                : Image.asset('assets/images/sample1.jpg', height: 400, width: 400),
          ),
        )
    );
  }
}
