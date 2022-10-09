import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rcv_mobile_app/ui/single_camera_screen/single_camera_screen_viewmodel.dart';
import 'package:rcv_mobile_app/ui/single_camera_screen/widgets/buttons_widget.dart';
import 'package:rcv_mobile_app/ui/single_camera_screen/widgets/camera_widget.dart';
import 'package:stacked/stacked.dart';

class SingleCameraScreenView extends StatelessWidget {
  final int index;
  final String cameraName;

  const SingleCameraScreenView(
      {Key? key, required this.index, required this.cameraName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleCameraScreenViewModel>.nonReactive(
      viewModelBuilder: () => SingleCameraScreenViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(context),
      builder: (context, viewModel, _) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  'Камера ${index+1}',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.close),
              color: Colors.black,
              tooltip: 'Close',
              onPressed: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Camera(),
                  Text(
                    cameraName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  Buttons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
