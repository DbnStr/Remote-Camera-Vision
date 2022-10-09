import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/constants/colors.dart';
import 'package:rcv_mobile_app/ui/add_person_screen/add_person_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';

class PhotosCarouselSlider extends ViewModelWidget<AddPersonScreenViewModel> {
  @override
  Widget build(BuildContext context, AddPersonScreenViewModel viewModel) {
    return Container(
        decoration: BoxDecoration(
            color: ColorTheme.secondaryText, borderRadius: BorderRadius.circular(5)),
        child: CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        height: MediaQuery.of(context).size.height - 205,
        enableInfiniteScroll: false,
      ),
      items: viewModel.imageFileList!.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.96,
              margin: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
              child: Image.file(File(i.path)),
            );
          },
        );
      }).toList(),
    ));
  }
}
