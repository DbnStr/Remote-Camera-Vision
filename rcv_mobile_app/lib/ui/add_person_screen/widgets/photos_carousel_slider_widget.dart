import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/ui/add_person_screen/add_person_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PhotosCarouselSlider extends ViewModelWidget<AddPersonScreenViewModel> {
  @override
  Widget build(BuildContext context, AddPersonScreenViewModel viewModel) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height - 205,
        enableInfiniteScroll: false,
      ),
      items: viewModel.imageFileList!.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width * 0.96,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.black),
                child: Image.file(File(i.path)),
            );
          },
        );
      }).toList(),
    );
  }
}
