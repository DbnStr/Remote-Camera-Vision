import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/constants/colors.dart';
import 'package:stacked/stacked.dart';

import '../notification_screen_viewmodel.dart';
import 'notification_image_canvas_widget.dart';

class NotificationCarouselSlider
    extends ViewModelWidget<NotificationScreenViewModel> {
  @override
  Widget build(BuildContext context, NotificationScreenViewModel viewModel) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: const DecorationImage(
            image: AssetImage('assets/images/no_image.png'),
            fit: BoxFit.none,
          ),
        ),
        child: CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            height: MediaQuery.of(context).size.height - 100,
            enableInfiniteScroll: false,
          ),
          items: viewModel.persons!.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.96,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CustomPaint(
                        size: Size(MediaQuery.of(context).size.width * 0.96,
                            MediaQuery.of(context).size.height * 0.8),
                        painter: NotificationImageCanvas(
                            image: viewModel.image, bbox: viewModel.bbox),
                      ),
                    ),
                  ),
                  Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text('${item}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: ColorTheme.primaryText)))
                ]);
              },
            );
          }).toList(),
        ));
  }
}
