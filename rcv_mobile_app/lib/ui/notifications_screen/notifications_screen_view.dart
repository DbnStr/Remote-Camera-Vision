import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/constants/colors.dart';
import 'package:rcv_mobile_app/ui/notifications_screen/widgets/notifications_list_widget.dart';
import 'package:stacked/stacked.dart';

import '../../constants/text.dart';
import 'notifications_screen_viewmodel.dart';

class NotificationsScreenView extends StatelessWidget {
  const NotificationsScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsScreenViewModel>.nonReactive(
      viewModelBuilder: () => NotificationsScreenViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, _) => Scaffold(
        backgroundColor: ColorTheme.primaryBg,
        appBar: AppBar(
          foregroundColor: ColorTheme.primaryText,
            elevation: 0,
            title: Text(
              TextConstants.NOTIFICATIONS_SCREEN_TITLE,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: ColorTheme.primaryText,
              ),
              maxLines: 1,
              textAlign: TextAlign.left,
            ),
            backgroundColor: ColorTheme.primary
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
          child: NotificationsList(),
        ),
      ),
    );
  }
}
