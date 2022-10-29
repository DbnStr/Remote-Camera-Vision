import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../services/firebase.dart';
import '../single_camera_screen_viewmodel.dart';


class Camera extends ViewModelWidget<SingleCameraScreenViewModel> {
  final DatabaseService db = DatabaseService();

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
            child: FutureBuilder<String> (
                future: db.getImageLink(viewModel.camera.currentView),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return snapshot.hasData ?
                    Image.network(snapshot.data!, height: 400, width: 400) :
                    Image.asset('assets/images/sample1.jpg', height: 400, width: 400);
                }
            )
          ),
        )
    );
  }
}
