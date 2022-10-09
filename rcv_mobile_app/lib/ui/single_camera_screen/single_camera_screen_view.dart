import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rcv_mobile_app/constants/colors.dart';
import 'package:rcv_mobile_app/constants/text.dart';
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
        backgroundColor: ColorTheme.primaryBg,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorTheme.primary,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  '${TextConstants.SINGLE_CAMERA_SCREEN_TITLE} ${index + 1}',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    color: ColorTheme.primaryText,
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
              color: ColorTheme.primaryText,
              tooltip: TextConstants.CLOSE,
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
                  Container(
                      height: 44,
                      child: Column(children: [
                        Divider(),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              cameraName,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                height: 1,
                                color: ColorTheme.primaryText,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            )),
                        Divider(),
                      ])),
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
