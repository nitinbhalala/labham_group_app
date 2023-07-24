// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/loader.dart';
import 'package:sizer/sizer.dart';


class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  final ApiServices apiServices = ApiServices();

  var data;
 


  Future<dynamic> getData() async {
    final data = await apiServices.getTermsAndCondition();
    return data['data']['tnc'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(
              child: Loader(),
            );
        }else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }else{
             final text = snapshot.data;
            return SingleChildScrollView(
            child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            // child: Html(
            //   data: text,
            //   style: {
            //     'body': Style(
            //         color: AppColors.FONT_COLOR,
            //         fontSize: FontSize(2.h),
            //         fontFamily: AppFonts.latoReguler),
            //   },
            // ),
          ),
        ));
          }
        }

      )
    );
  }
}
