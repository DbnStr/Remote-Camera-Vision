import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rcv_mobile_app/constants/colors.dart';
import 'package:stacked/stacked.dart';

import '../../../models/camera_notification_model.dart';
import '../notifications_screen_viewmodel.dart';
import 'notification_image_canvas_widget.dart';

class NotificationsList extends ViewModelWidget<NotificationsScreenViewModel> {
  @override
  Widget build(BuildContext context, NotificationsScreenViewModel viewModel) {
    return RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            print('Update...');
          });
        },
        child: Stack(
          children: <Widget>[
            ListView.builder(
                padding: const EdgeInsets.only(left: 10, right: 10),
                itemCount: viewModel.notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  CameraNotification item = viewModel.notifications[index];
                  return Card(
                      elevation: 2,
                      margin: const EdgeInsets.all(4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Stack(
                          fit: StackFit.loose,
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 238,
                              margin: const EdgeInsets.only(bottom: 56),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.black,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CustomPaint(
                                  size: Size(
                                      MediaQuery.of(context).size.width * 0.96,
                                      MediaQuery.of(context).size.height * 0.5),
                                  painter: NotificationImageCanvas(
                                      image: viewModel.getImageByIndex(index),
                                      bbox: viewModel.bbox),
                                ),
                              ),
                            ),
                            Container(
                                height: 56,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                  color: ColorTheme.primaryBg,
                                ),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          DateFormat('d.M.y в H:m')
                                              .format(item.viewDateTime!)
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: ColorTheme.secondaryText)),
                                      Text(
                                          "К вам пришли: " +
                                                  item.persons!
                                                      .map((p) => p.name)
                                                      .toList()
                                                      .join(', ') ??
                                              '',
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: ColorTheme.primaryText))
                                    ])),
                            Positioned.fill(
                                child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(5),
                                      splashColor: Colors.grey.withAlpha(30),
                                      onTap: () => viewModel.openNotification(
                                          context,
                                          item.persons,
                                          item.viewDateTime,
                                          viewModel.getImageByIndex(index)),
                                    ))),
                          ]));
                }),
          ],
        ));
  }
}
