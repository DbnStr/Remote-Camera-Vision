import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rcv_mobile_app/ui/single_camera_screen/single_camera_screen_viewmodel.dart';
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
                  cameraName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black
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
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.96,
                      height: MediaQuery.of(context).size.height - 215,
                      child: viewModel.model.currentView,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.black,
                      ),
                    ),
                  ),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 4, 0),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                4, 0, 0, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                print('Notifications');
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
