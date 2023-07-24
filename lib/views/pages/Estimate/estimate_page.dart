// ignore_for_file: sized_box_for_whitespace, prefer_is_empty, use_build_context_synchronously, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimall_store/businessLogic/blocs/Estimate%20List/estimate_list_sate.dart';
import 'package:minimall_store/constants/app_assets.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/app_button.dart';
import 'package:minimall_store/views/comman/app_text.dart';
import 'package:minimall_store/views/comman/connectivity_check.dart';
import 'package:minimall_store/views/comman/function.dart';
import 'package:minimall_store/views/comman/no_found.dart';
import 'package:minimall_store/views/pages/Estimate/create_estimate.dart';
import 'package:minimall_store/views/pages/Estimate/view_product_page.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';
import '../../../businessLogic/blocs/Estimate List/estimate_list_bloc.dart';
import '../../../constants/app_fonts.dart';
import '../../comman/app_dialogs.dart';
import '../../comman/loader.dart';

class EstimatePage extends StatefulWidget {
  const EstimatePage({super.key});

  @override
  State<EstimatePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<EstimatePage> {
  bool? isConnected;
  //====From Date =======

  DateTime? pickedDate;
  DateTime? selectdDate;
  String? formattedDate;

  //====To  Date =======

  DateTime? pickedToDate;
  DateTime? selectdToDate;
  String? formattedToDate;

  Functions functions = Functions();

  getinternet() async {
    isConnected = await ConnectivityService.isConnected;
    if (isConnected == false) {
      AppDialog.showInternetDialog(
        context,
        onTap: () {
          Navigator.pop(context);
          getinternet();
        },
      );
    }
  }

  @override
  void initState() {
    getinternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return BlocProvider(
      create: (context) => EstimateListCubit(ApiServices()),
      child: Scaffold(
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
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.WHITE_COLOR,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.w),
                  topRight: Radius.circular(7.w))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      BlocBuilder<EstimateListCubit, EstimateListState>(
                        builder: (context, state) {
                          if (state is EstimateListLodingState) {
                            return Center(
                              child: Loader(
                                color: AppColors.PRIMERY_COLOR,
                              ),
                            );
                          }
                          if (state is EstimateListLoadadState) {
                            return state.estimate.length > 0
                                ? ListView.builder(
                                    itemCount: state.estimate.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var data = state.estimate[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewProductPage(
                                                        estimateDetail: state
                                                            .estimate[index]),
                                              ));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.5.h, horizontal: 2.w),
                                          decoration: BoxDecoration(
                                              color: AppColors.WHITE_COLOR,
                                              borderRadius:
                                                  BorderRadius.circular(3.w),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color:
                                                        AppColors.BACK_GROUND,
                                                    blurRadius: 5)
                                              ]),
                                          margin: EdgeInsets.only(bottom: 2.h),
                                          width: double.infinity,
                                          // height: 10.h,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  appText(
                                                      title: data['name'],
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  appText(
                                                      title: '#${data['estimate_id']}',
                                                      fontWeight:
                                                          FontWeight.w600)
                                                ],
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              appText(
                                                  title: data['mobile_number'],
                                                  fontWeight: FontWeight.w300),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          functions.launchPhoneCall(
                                                              data[
                                                                  'mobile_number']);
                                                        },
                                                        child: Container(
                                                          height: 5.h,
                                                          width: 5.h,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .PRIMERY_COLOR,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.h)),
                                                          child: Center(
                                                              child:
                                                                  Image.asset(
                                                            AppAssets.PHONE,
                                                            scale: 3.h,
                                                            color: AppColors
                                                                .WHITE_COLOR,
                                                          )),
                                                        ),
                                                      ),
                                                      SizedBox(width: 2.w),
                                                      // GestureDetector(
                                                      //   onTap: () {
                                                      //     functions.launchEmail(
                                                      //         data['url']);
                                                      //   },
                                                      //   child: Container(
                                                      //     height: 5.h,
                                                      //     width: 5.h,
                                                      //     decoration: BoxDecoration(
                                                      //         color: AppColors
                                                      //             .PRIMERY_COLOR,
                                                      //         borderRadius:
                                                      //             BorderRadius
                                                      //                 .circular(
                                                      //                     5.h)),
                                                      //     child: Center(
                                                      //       child: Image.asset(
                                                      //         AppAssets.EMAIL,
                                                      //         scale: 3.h,
                                                      //         color: AppColors
                                                      //             .WHITE_COLOR,
                                                      //       ),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      // SizedBox(width: 2.w),
                                                      GestureDetector(
                                                        onTap: () {
                                                          functions
                                                              .launchWhatsapp(
                                                                  data['mobile_number'],data['url']);
                                                        },
                                                        child: Container(
                                                          height: 5.h,
                                                          width: 5.h,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .PRIMERY_COLOR,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.h)),
                                                          child: Center(
                                                            child: Image.asset(
                                                              AppAssets
                                                                  .WHATSAPP,
                                                              scale: 3.h,
                                                              color: AppColors
                                                                  .WHITE_COLOR,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          bool isConfrimed =
                                                              await AppDialog
                                                                  .showDialog(
                                                                      context,
                                                                      title:
                                                                          '${lang?.getTranslatedValue('Delete')}',
                                                                      message:
                                                                          '${lang?.getTranslatedValue('Are you sure to delete Estimate?')}');
                                                          if (isConfrimed) {
                                                            BlocProvider.of<
                                                                        EstimateListCubit>(
                                                                    context)
                                                                .deleteEstimate(
                                                                    data['id']);
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 5.h,
                                                          width: 5.h,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .PRIMERY_COLOR,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.h)),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.delete,
                                                              size: 3.h,
                                                              color: AppColors
                                                                  .WHITE_COLOR,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  appText(
                                                      title: data['date'],
                                                      fontSize: 1.5.h,
                                                      color: AppColors.GREY)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(top: 20.h),
                                    child: Center(
                                        child: noFound(
                                            title: lang?.getTranslatedValue(
                                                'Estimate not found'))),
                                  );
                          }
                          if (state is EstimateListErrorState) {
                            return Center(
                              child: appText(title: state.error),
                            );
                          }
                          return Container();
                        },
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: appButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreateEstimate(),
                              ));
                        },
                        child: appText(
                            title: lang?.getTranslatedValue('Create Estimate'),
                            color: AppColors.WHITE_COLOR,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
