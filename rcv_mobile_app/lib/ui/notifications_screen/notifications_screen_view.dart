import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/ui/notifications_screen/widgets/notifications_list_widget.dart';
import 'package:stacked/stacked.dart';

import 'notifications_screen_viewmodel.dart';

class NotificationsScreenView extends StatelessWidget {
  const NotificationsScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsScreenViewModel>.nonReactive(
      viewModelBuilder: () => NotificationsScreenViewModel(),
      onModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(elevation: 2, title: const Text("Notifications")),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
          child: NotificationsList(),
        ),
      ),
    );
  }
}
