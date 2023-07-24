import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/views/comman/app_text.dart';
import 'package:sizer/sizer.dart';

Widget cartBox(
    {required String title,
    required String price,
    required VoidCallback onTap,
    context}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
    child: Container(
      height: 8.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColors.PRIMERY_COLOR,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appText(
                    title: title,
                    color: Colors.white,
                    fontSize: 1.5.h,
                    letterSpacing: 0.5),
                SizedBox(height: 1.h),
                appText(
                    title: price,
                    color: Colors.white,
                    fontSize: 1.5.h,
                    letterSpacing: 0.5),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  appText(
                      title: 'Go to cart',
                      color: Colors.white,
                      fontSize: 14,
                      letterSpacing: 0.5),
                  Padding(
                      padding: EdgeInsets.all(1.w),
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        color: AppColors.WHITE_COLOR,
                        size: 2.5.h,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
