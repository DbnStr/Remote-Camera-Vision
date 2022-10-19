import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rcv_mobile_app/constants/colors.dart';
import 'package:rcv_mobile_app/constants/text.dart';
import 'package:rcv_mobile_app/ui/notification_screen/widgets/notification_carousel_slider.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

import '../../models/person_model.dart';
import 'notification_screen_viewmodel.dart';

class NotificationScreenView extends StatelessWidget {
  final List<Person> data;
  final DateTime date;

  const NotificationScreenView(
      {Key? key, required this.data, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationScreenViewModel>.nonReactive(
      viewModelBuilder: () => NotificationScreenViewModel(data, date),
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
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      DateFormat('d.M.y в H:m')
                          .format(viewModel.date)
                          .toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        color: ColorTheme.primaryText,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    )),
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
                  NotificationCarouselSlider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
