// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/constants/app_fonts.dart';
import 'package:minimall_store/views/comman/app_text.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';

class ViewProductPage extends StatefulWidget {
  var estimateDetail;
  ViewProductPage({super.key, this.estimateDetail});

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  @override
  void initState() {
    print("estimateDetail : ${widget.estimateDetail}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return Scaffold(
      backgroundColor: AppColors.PRIMERY_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.PRIMERY_COLOR,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: appText(
          title: lang?.getTranslatedValue('Estimate'),
          fontFamily: AppFonts.latoBold,
          fontWeight: FontWeight.w700,
          color: AppColors.WHITE_COLOR,
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.WHITE_COLOR,
          ),
        ),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.WHITE_COLOR,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.w),
                  topRight: Radius.circular(7.w))),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                        widget.estimateDetail['estimate_longs'].length,
                        (index) {
                      var data = widget.estimateDetail['estimate_longs'][index];
                      return widget.estimateDetail['estimate_longs'].length > 0
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 1.h),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.w),
                                    color: AppColors.WHITE_COLOR,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: AppColors.GREY,
                                          blurRadius: 5,
                                          offset: Offset(0, 2))
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        appText(
                                            title: data['title'],
                                            fontSize: 1.5.h,
                                            maxLines: 3,
                                            color: AppColors.PRIMERY_COLOR,
                                            fontWeight: FontWeight.w700),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 7.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.w),
                                              color: AppColors.GREY
                                                  .withOpacity(0.1),
                                              // border: Border.all(
                                              //     color: AppColors.GREY, width: 0.3)
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  appText(
                                                    title: lang
                                                        ?.getTranslatedValue(
                                                            'Height:'),
                                                  ),
                                                  appText(
                                                      title: data['height']
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 7.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: AppColors.GREY
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(4.w),
                                              // border: Border.all(
                                              //     color: AppColors.GREY, width: 0.3)
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  appText(
                                                    title: lang
                                                        ?.getTranslatedValue(
                                                            'Widht:'),
                                                  ),
                                                  appText(
                                                      title: data['widht']
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 7.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.w),
                                              color: AppColors.GREY
                                                  .withOpacity(0.1),
                                              // border: Border.all(
                                              //     color: AppColors.GREY, width: 0.3)
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  appText(
                                                    title: lang
                                                        ?.getTranslatedValue(
                                                            'Inch:'),
                                                  ),
                                                  appText(
                                                      title: data['inch']
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 7.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: AppColors.GREY
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(4.w),
                                              // border: Border.all(
                                              //     color: AppColors.GREY, width: 0.3)
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  appText(
                                                    title: lang
                                                        ?.getTranslatedValue(
                                                            'Sqft:'),
                                                  ),
                                                  appText(
                                                      title: data['sqft']
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      height: 7.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.GREY.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(4.w),
                                        // border: Border.all(
                                        //     color: AppColors.GREY, width: 0.3)
                                      ),
                                      child: Center(
                                        child: appText(
                                            title:'${lang?.getTranslatedValue('Price:')} ${data['price'].toString()}',
                                            color: AppColors.FONT_COLOR
                                            ), 
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Container(
                                      height: 7.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.PRIMERY_COLOR,
                                        borderRadius:
                                            BorderRadius.circular(4.w),
                                        // border: Border.all(
                                        //     color: AppColors.GREY, width: 0.3)
                                      ),
                                      child: Center(
                                        child: appText(
                                            title:
                                                '${lang?.getTranslatedValue('Total')}: ₹${data['total_price'].toString()}',
                                            color: AppColors.WHITE_COLOR),
                                      ),
                                    ),

                                    // appText(
                                    //     title:
                                    //         productTodo.totalPrice.toString()),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox();
                    }),
                  ),
                  Column(
                    children: List.generate(
                        widget.estimateDetail['estimate_shorts'].length,
                        (index) {
                      var data =
                          widget.estimateDetail['estimate_shorts'][index];
                      return widget.estimateDetail['estimate_shorts'].length > 0
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 1.h),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.w),
                                    color: AppColors.WHITE_COLOR,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: AppColors.GREY,
                                          blurRadius: 5,
                                          offset: Offset(0, 2))
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    appText(
                                        title: data['title'],
                                        fontSize: 1.5.h,
                                        color: AppColors.PRIMERY_COLOR,
                                        fontWeight: FontWeight.w700),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 7.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.w),
                                              color: AppColors.GREY
                                                  .withOpacity(0.1),
                                              // border: Border.all(
                                              //     color: AppColors.GREY, width: 0.3)
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  appText(
                                                    title: lang
                                                        ?.getTranslatedValue(
                                                            'qty:'),
                                                  ),
                                                  appText(
                                                      title: data['qty']
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 7.h,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: AppColors.GREY
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(4.w),
                                              // border: Border.all(
                                              //     color: AppColors.GREY, width: 0.3)
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  appText(
                                                    title: lang
                                                        ?.getTranslatedValue(
                                                            'Price:'),
                                                  ),
                                                  appText(
                                                      title: data['price']
                                                          .toString()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Container(
                                      height: 7.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.PRIMERY_COLOR,
                                        borderRadius:
                                            BorderRadius.circular(4.w),
                                        // border: Border.all(
                                        //     color: AppColors.GREY, width: 0.3)
                                      ),
                                      child: Center(
                                        child: appText(
                                            title:
                                                '${lang?.getTranslatedValue('Total')}: ₹${data['total_price'].toString()}',
                                            color: AppColors.WHITE_COLOR),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox();
                    }),
                  ),
                  Container(
                    height: 7.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.GREY.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.w),
                      // border: Border.all(
                      //     color: AppColors.GREY, width: 0.3)
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          appText(
                            title: lang?.getTranslatedValue('Price:'),
                          ),
                          appText(
                              title: ' ₹${widget.estimateDetail['total_list_price']
                                  .toString()}'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  widget.estimateDetail['total_list_ince'].toString() != '0' &&
                          widget.estimateDetail['total_sqft'].toString() != '0'
                      ? Column(
                          children: [
                            Container(
                              height: 7.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.GREY.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4.w),
                                // border: Border.all(
                                //     color: AppColors.GREY, width: 0.3)
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    appText(
                                      title: lang
                                          ?.getTranslatedValue('Total Inch:'),
                                    ),
                                    appText(
                                        title: widget
                                            .estimateDetail['total_list_ince']
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              height: 7.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.GREY.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4.w),
                                // border: Border.all(
                                //     color: AppColors.GREY, width: 0.3)
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    appText(
                                      title: lang
                                          ?.getTranslatedValue('Total Sqft:'),
                                    ),
                                    appText(
                                        title: widget
                                            .estimateDetail['total_sqft']
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          )),
    );
  }
}
