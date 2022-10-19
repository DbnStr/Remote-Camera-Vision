import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/ui/cameras_screen/widgets/cameras_list_widget.dart';
import 'package:stacked/stacked.dart';

import '../../constants/colors.dart';
import '../../constants/text.dart';
import '../../models/camera_notification_model.dart';
import '../../models/user_model.dart';
import 'cameras_screen_viewmodel.dart';

class CamerasScreenView extends StatelessWidget {
  final User user;

  const CamerasScreenView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CamerasScreenViewModel>.nonReactive(
      viewModelBuilder: () => CamerasScreenViewModel(user),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, _) => Scaffold(
        backgroundColor: ColorTheme.primaryBg,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorTheme.primary,
            title: Text(
              TextConstants.CAMERAS_SCREEN_TITLE,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: ColorTheme.primaryText,
              ),
              maxLines: 1,
              textAlign: TextAlign.left,
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_a_photo_outlined),
                tooltip: TextConstants.ADD_PERSON_BUTTON,
                color: ColorTheme.primaryText,
                onPressed: () {
                  viewModel.openPersonAdding(context);
                },
              ),
            ]),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
          child: CamerasList(),
        ),
      ),
    );
  }
}
