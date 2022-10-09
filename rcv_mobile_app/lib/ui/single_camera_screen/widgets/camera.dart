import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../single_camera_screen_viewmodel.dart';


class Camera extends ViewModelWidget<SingleCameraScreenViewModel> {
  @override
  Widget build(BuildContext context, SingleCameraScreenViewModel viewModel) {
    return (
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.96,
            height: MediaQuery.of(context).size.height - 215,
            child: viewModel.model.currentView,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.black,
            ),
          ),
        )
    );
  }
}
