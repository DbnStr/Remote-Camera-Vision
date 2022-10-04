import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/ui/cameras_screen/widgets/cameras_list_widget.dart';
import 'package:stacked/stacked.dart';

import 'cameras_screen_viewmodel.dart';

class CamerasScreenView extends StatelessWidget {
  const CamerasScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CamerasScreenViewModel>.nonReactive(
      viewModelBuilder: () => CamerasScreenViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(
            title: const Text("Cameras")
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
          child: CamerasList(),
        ),
      ),
    );
  }
}
