import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../cameras_screen_viewmodel.dart';

class CamerasList extends ViewModelWidget<CamerasScreenViewModel> {
  @override
  Widget build(BuildContext context, CamerasScreenViewModel viewModel) {
    return Stack(
      children: <Widget>[
        ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: viewModel.cameras.length,
            itemBuilder: (BuildContext context, int index) {
              dynamic item = viewModel.cameras[index];
              return ListTile(
                  leading: Image.asset('assets/images/camera_icon.jpeg'),
                  title: Text(
                      item.name
                  ),
                  shape: Border(
                    bottom: BorderSide(),
                  ),
                  onTap: () { // NEW from here .// ..
                    print(item);
                  });
            }),
      ],
    );
  }
}
