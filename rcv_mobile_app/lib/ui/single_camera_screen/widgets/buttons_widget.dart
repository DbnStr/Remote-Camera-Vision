import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/constants/text.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/colors.dart';
import '../single_camera_screen_viewmodel.dart';

class Buttons extends ViewModelWidget<SingleCameraScreenViewModel> {
  @override
  Widget build(BuildContext context, SingleCameraScreenViewModel viewModel) {
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      /*Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: ElevatedButton(
          onPressed: () {
            print("Unlock");
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: ColorTheme.accent,
            elevation: 2,
          ),
          child: const Text(TextConstants.OPEN_DOOR),
        ),
      ),*/
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                child: ElevatedButton(
                  onPressed: () {
                    print('Call');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.allert,
                    elevation: 2,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(TextConstants.CALL.toUpperCase()),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    print('Notifications');
                    viewModel.openNotifications(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.primaryText,
                    elevation: 2,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(TextConstants.NOTIFICATIONS.toUpperCase()),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
