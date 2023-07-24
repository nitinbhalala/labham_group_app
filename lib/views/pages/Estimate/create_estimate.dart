import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimall_store/views/pages/Estimate/add_prodcut_page.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../comman/app_button.dart';
import '../../comman/app_text.dart';
import '../../comman/app_textfiled.dart';

class CreateEstimate extends StatefulWidget {
  const CreateEstimate({super.key});

  @override
  State<CreateEstimate> createState() => _CreateEstimateState();
}

class _CreateEstimateState extends State<CreateEstimate> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return Scaffold(
      backgroundColor: AppColors.PRIMERY_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.PRIMERY_COLOR,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.WHITE_COLOR,
          ),
        ),
        title: appText(
          title: lang?.getTranslatedValue('Create Estimate'),
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
            topRight: Radius.circular(7.w),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  appTextfild(
                    borderRadius: 7.w,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return lang?.getTranslatedValue('Enter name');
                      } else {
                        return null;
                      }
                    },
                    controller: nameController,
                    hint: lang?.getTranslatedValue('Enter name'),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  appTextfild(
                    borderRadius: 7.w,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return lang
                            ?.getTranslatedValue('Please Enter Mobile number');
                      } else if (val!.length < 10) {
                        return lang
                            ?.getTranslatedValue('Enter valid mobilnumber');
                      } else {
                        return null;
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: numberController,
                    hint: lang?.getTranslatedValue('Enter Mobile Number'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),

                  TextFormField(
                    cursorColor: AppColors.GREY,  
                    controller: addressController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    style: TextStyle(
                        fontSize: 2.5.h,
                        letterSpacing: 0.2,
                        color: AppColors.FONT_COLOR,
                        fontFamily: AppFonts.latoReguler),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return lang?.getTranslatedValue('Enter address');
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.w),
                        borderSide:
                            const BorderSide(width: 0.3, color: AppColors.GREY),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.w),
                        borderSide:
                            const BorderSide(width: 0.3, color: AppColors.GREY),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.w),
                        borderSide: const BorderSide(
                            width: 0.3, color: AppColors.RED_COLOR),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.w),
                        borderSide: const BorderSide(
                            width: 0.3, color: AppColors.RED_COLOR),
                      ),
                      hintText: "Enter address",
                      errorMaxLines: 2,
                      errorStyle: const TextStyle(fontSize: 10),
                      hintStyle: const TextStyle(
                          color: Color(0xFF757570), fontSize: 14),
                      border: InputBorder.none,
                    ),
                  ),
                  // appTextfild(
                  //   maxLines: 5,
                  //   borderRadius: 7.w,
                  //   validator: (val) {
                  //     if (val!.isEmpty) {
                  //       return lang?.getTranslatedValue('Enter Email');
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  //   controller: emailController,
                  //   hint: lang?.getTranslatedValue('Enter Email'),
                  //   keyboardType: TextInputType.emailAddress,
                  //   textInputAction: TextInputAction.next,
                  // ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: appButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddProductPage(
                                        email: addressController.text,
                                        name: nameController.text,
                                        phone: numberController.text),
                                  ));
                            }
                          },
                          child: appText(
                              title: lang?.getTranslatedValue('Next'),
                              color: AppColors.WHITE_COLOR,
                              fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
