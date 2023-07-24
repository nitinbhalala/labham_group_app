import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_assets.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.LIGHT_GREY,
      highlightColor: AppColors.GREY.withOpacity(0.5),
      child:Image.asset(AppAssets.LABHAM_LOGO,color: AppColors.LIGHT_GREY,)
    );
  }
}