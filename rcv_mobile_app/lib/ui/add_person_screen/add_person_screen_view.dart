import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rcv_mobile_app/ui/add_person_screen/widgets/appbar_textfield_widget.dart';
import 'package:rcv_mobile_app/ui/add_person_screen/widgets/buttons_widget.dart';
import 'package:rcv_mobile_app/ui/add_person_screen/widgets/photos_carousel_slider_widget.dart';
import 'package:stacked/stacked.dart';

import 'add_person_screen_viewmodel.dart';

class AddPersonScreenView extends StatelessWidget {
  const AddPersonScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPersonScreenViewModel>.nonReactive(
      viewModelBuilder: () => AddPersonScreenViewModel(),
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
              AppbarTextfield(),
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
                  PhotosCarouselSlider(),
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
