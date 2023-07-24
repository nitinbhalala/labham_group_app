// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../comman/shimmer_loader.dart';

class ViewImage extends StatefulWidget {
  var image;
  int currentIndex;
  ViewImage({super.key, required this.image, required this.currentIndex});

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  void initState() {
    widget.image;
    widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: widget.currentIndex);
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: widget.image.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.image[index]['image_url'],
                fit: BoxFit.contain,
                progressIndicatorBuilder: (context, url, progress) {
                  return const ShimmerLoader();
                  
                },
                 key: Key(widget.image[index]['image_url'])
              );}
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios)),
          )
        ],
      ),
    );
  }
}
