import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../single_camera_screen_viewmodel.dart';

class Buttons extends ViewModelWidget<SingleCameraScreenViewModel> {
  @override
  Widget build(BuildContext context, SingleCameraScreenViewModel viewModel) {
    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
        child: ElevatedButton(
          onPressed: () {
            print("Unlock");
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.green,
            elevation: 2,
          ),
          child: const Text('Открыть дверь'),
        ),
      ),
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
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
                    backgroundColor: Colors.red,
                    elevation: 2,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Звонок'),
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
                    backgroundColor: Colors.blueGrey,
                    elevation: 2,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Уведомления'),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
