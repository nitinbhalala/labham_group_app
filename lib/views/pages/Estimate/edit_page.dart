// ignore_for_file: unrelated_type_equality_checks, unnecessary_brace_in_string_interps, avoid_print, prefer_typing_uninitialized_variables, unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minimall_store/Cubit/Update%20Estimate/update_estimate_state.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/constants/app_fonts.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/app_button.dart';
import 'package:minimall_store/views/comman/app_text.dart';
import 'package:minimall_store/views/comman/loader.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';
import '../../../Cubit/Update Estimate/update_estimate_cubit.dart';

class EditScreen extends StatefulWidget {
  var estimateDetail;
  EditScreen({super.key, this.estimateDetail});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  //======================Long List ===================

  double heightValue = 0.0;
  double widthValue = 0.0;
  double priceValue = 0.0;
  double resultInchData = 0.0;
  double resultSqftData = 0.0;
  double resultPriceData = 0.0;

  List<TextEditingController> heightControllers = [];
  List<TextEditingController> widthControllers = [];
  List<TextEditingController> inchControllers = [];
  List<TextEditingController> squareControllers = [];
  List<TextEditingController> priceControllers = [];
  List<TextEditingController> resultPriceControllers = [];

  // List addProductList = [];
  List updateProductList = [];
  List updateShortProductList = [];

  // ====================== Short List =============================

  double qytValue = 0.0;
  double shortPriceValue = 0.0;
  double shortPriceData = 0.0;

  List<TextEditingController> qtyControllers = [];
  List<TextEditingController> shortControllers = [];
  List<TextEditingController> shortResultPriceControllers = [];

//==========================Total List ==================

  double totalPrice = 0.0;
  double totalInch = 0.0;
  double totalSqft = 0.0;
  double shortTotalPrice = 0.0;
  double listTotalPrice = 0.0;

  TextEditingController listTotalPriceController = TextEditingController();
  TextEditingController totalInchController = TextEditingController();
  TextEditingController totalSqftController = TextEditingController();

  @override
  void initState() {
    print(widget.estimateDetail);
    initializeControllers();
    super.initState();
  }

  void initializeControllers() {
    for (int i = 0; i < widget.estimateDetail['estimate_longs'].length; i++) {
      heightControllers.add(TextEditingController());
      widthControllers.add(TextEditingController());
      inchControllers.add(TextEditingController());
      squareControllers.add(TextEditingController());
      priceControllers.add(TextEditingController());
      resultPriceControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed to avoid memory leaks
    for (var controller in heightControllers) {
      controller.clear();
    }
    for (var controller in widthControllers) {
      controller.clear();
    }
    for (var controller in inchControllers) {
      controller.clear();
    }
    for (var controller in squareControllers) {
      controller.clear();
    }
    for (var controller in priceControllers) {
      controller.clear();
    }
    for (var controller in resultPriceControllers) {
      controller.clear();
    }
    for (var controller in qtyControllers) {
      controller.clear();
    }
    for (var controller in shortControllers) {
      controller.clear();
    }
    for (var controller in shortResultPriceControllers) {
      controller.clear();
    }
    super.dispose();
  }

  void updateProduct() {
    updateProductList = [];
    updateShortProductList = [];
    for (int index = 0;
        index < widget.estimateDetail['estimate_longs'].length;
        index++) {
      var data = widget.estimateDetail['estimate_longs'][index];

      updateProductList.add({
        "id": data['id'],
        "title": data['title'],
        "height": double.tryParse(heightControllers[index].text),
        "widht": double.tryParse(widthControllers[index].text),
        "price": double.tryParse(priceControllers[index].text),
        "inch": double.tryParse(inchControllers[index].text),
        "sqft": double.tryParse(squareControllers[index].text),
        "total_price": double.tryParse(resultPriceControllers[index].text),
      });
    }
    for (int index = 0;
        index < widget.estimateDetail['estimate_shorts'].length;
        index++) {
      var data = widget.estimateDetail['estimate_shorts'][index];

      updateShortProductList.add({
        "id": data['id'],
        "title": data['title'],
        "qty": double.tryParse(qtyControllers[index].text),
        "price": double.tryParse(shortControllers[index].text),
        "total_price": double.tryParse(shortResultPriceControllers[index].text),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return BlocProvider(
      create: (context) => UpdateEstimateCubit(ApiServices()),
      child: Scaffold(
        backgroundColor: AppColors.PRIMERY_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.PRIMERY_COLOR,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: appText(
            title: lang?.getTranslatedValue('Update'),
            fontFamily: AppFonts.latoBold,
            fontWeight: FontWeight.w700,
            color: AppColors.WHITE_COLOR,
          ),
          elevation: 0,
          actions: [
            BlocBuilder<UpdateEstimateCubit, UpdateEstimateState>(
                builder: (context, state) {
              if (state is LoadedUpdateEstimateState) {
                return Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: appButton(
                    width: 20.w,
                    height: 5.5.h,
                    radius: 3.w,
                    border: Border.all(color: AppColors.WHITE_COLOR),
                    child: Center(
                        child: (!state.isLoading)
                            ? appText(
                                title: lang?.getTranslatedValue('Update'),
                                color: AppColors.WHITE_COLOR)
                            : Loader(color: AppColors.WHITE_COLOR)),
                    onTap: () {
                      print("updateProductList : ${updateProductList}");
                      print(
                          "updateShortProductList : ${updateShortProductList}");
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (updateProductList.isNotEmpty ||
                          updateShortProductList.isNotEmpty) {
                        if (!state.isLoading) {
                          context.read<UpdateEstimateCubit>().updateEstimate(
                              context: context,
                              longList: updateProductList,
                              shortList: updateShortProductList,
                              id: widget.estimateDetail['id'].toString(),
                              name: widget.estimateDetail['name'],
                              mobile_number:
                                  widget.estimateDetail['mobile_number'],
                              address: widget.estimateDetail['address'],
                              totalListPrice: listTotalPriceController.text,
                              total_inch: totalInchController.text,
                              total_sqft: totalSqftController.text);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                '${lang?.getTranslatedValue('Please Edit Estimate List')}',
                            backgroundColor: AppColors.RED_COLOR,
                            toastLength: Toast.LENGTH_SHORT);
                      }
                    },
                  ),
                ));
              }
              return Container();
            })
          ],
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
                    _longListEdit(),
                    _shortListEdit(),
                    textField(
                        readOnly: true,
                        label: lang?.getTranslatedValue('Total price'),
                        controller: listTotalPriceController),
                    SizedBox(
                      height: 1.h,
                    ),
                    widget.estimateDetail['total_list_ince'].toString() !=
                                '0' &&
                            widget.estimateDetail['total_sqft'].toString() !=
                                '0'
                        ? Column(
                            children: [
                              textField(
                                readOnly: true,
                                controller: totalInchController,
                                label: lang?.getTranslatedValue('Total Inch:'),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              textField(
                                  readOnly: true,
                                  label:
                                      lang?.getTranslatedValue('Total Sqft:'),
                                  controller: totalSqftController),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _longListEdit() {
    var lang = AppLocalization.of(context);
    return Column(
      children: List.generate(
        widget.estimateDetail['estimate_longs'].length,
        (index) {
          var data = widget.estimateDetail['estimate_longs'][index];

          var heightController = heightControllers.length > index
              ? heightControllers[index]
              : TextEditingController();
          var widthController = widthControllers.length > index
              ? widthControllers[index]
              : TextEditingController();
          var inchController = inchControllers.length > index
              ? inchControllers[index]
              : TextEditingController();
          var squareController = squareControllers.length > index
              ? squareControllers[index]
              : TextEditingController();
          var priceController = priceControllers.length > index
              ? priceControllers[index]
              : TextEditingController();
          var resultPriceController = resultPriceControllers.length > index
              ? resultPriceControllers[index]
              : TextEditingController();

          //===========================================================================

          heightControllers.add(heightController);
          widthControllers.add(widthController);
          inchControllers.add(inchController);
          squareControllers.add(squareController);
          priceControllers.add(priceController);
          resultPriceControllers.add(resultPriceController);

          heightValue = double.tryParse(data['height'].toString()) ?? 0.0;
          widthValue = double.tryParse(data['widht'].toString()) ?? 0.0;
          priceValue = double.tryParse(data['price'].toString()) ?? 0.0;
          resultInchData = double.tryParse(data['inch'].toString()) ?? 0.0;
          resultSqftData = double.tryParse(data['sqft'].toString()) ?? 0.0;
          resultPriceData =
              double.tryParse(data['total_price'].toString()) ?? 0.0;

          listTotalPrice = double.tryParse(
                  widget.estimateDetail['total_list_price'].toString()) ??
              0.0;
          totalInch = double.tryParse(
                  widget.estimateDetail['total_list_ince'].toString()) ??
              0.0;
          totalSqft =
              double.tryParse(widget.estimateDetail['total_sqft'].toString()) ??
                  0.0;

          listTotalPriceController.text = listTotalPrice.toString();
          totalInchController.text = totalInch.toString();
          totalSqftController.text = totalSqft.toString();

          heightController.text = heightValue.toStringAsFixed(2);
          priceController.text = priceValue.toStringAsFixed(2);
          widthController.text = widthValue.toStringAsFixed(2);
          inchController.text = resultInchData.toStringAsFixed(2);
          squareController.text = resultSqftData.toStringAsFixed(2);
          resultPriceController.text = resultPriceData.toStringAsFixed(2);

          //=================================================================//

          void updatedValue() {
            heightValue = double.tryParse(heightController.text) ?? 0.0;
            widthValue = double.tryParse(widthController.text) ?? 0.0;
            priceValue = double.tryParse(priceController.text) ?? 0.0;
            listTotalPrice =
                double.tryParse(listTotalPriceController.text) ?? 0.0;
            totalInch = double.tryParse(totalInchController.text) ?? 0.0;
            totalSqft = double.tryParse(totalSqftController.text) ?? 0.0;

            resultInchData = heightValue * widthValue;
            resultSqftData = resultInchData / 144;
            resultPriceData = priceValue * resultSqftData;

            inchController.text = resultInchData.toStringAsFixed(2);
            squareController.text = resultSqftData.toStringAsFixed(2);
            resultPriceController.text = resultPriceData.toStringAsFixed(2);

            totalPrice = 0.0;
            totalInch = 0.0;
            totalSqft = 0.0;
            shortTotalPrice = 0.0;

            for (int i = 0;
                i < widget.estimateDetail['estimate_longs'].length;
                i++) {
              var resultPriceData =
                  double.tryParse(resultPriceControllers[i].text) ?? 0.0;
              var resultInchData =
                  double.tryParse(inchControllers[i].text) ?? 0.0;
              var resultSqftData =
                  double.tryParse(squareControllers[i].text) ?? 0.0;

              totalPrice += resultPriceData;
              totalInch += resultInchData;
              totalSqft += resultSqftData;
            }

            for (int i = 0;
                i < widget.estimateDetail['estimate_shorts'].length;
                i++) {
              var resultPriceData =
                  double.tryParse(shortResultPriceControllers[i].text) ?? 0.0;
              shortTotalPrice += resultPriceData;
            }

            listTotalPrice = totalPrice + shortTotalPrice;
            listTotalPriceController.text = listTotalPrice.toStringAsFixed(2);
            totalInchController.text = totalInch.toStringAsFixed(2);
            totalSqftController.text = totalSqft.toStringAsFixed(2);
            updateProduct();
          }

          heightController.addListener(() {
            updatedValue();
          });

          widthController.addListener(() {
            updatedValue();
          });
          //===========================================================================

          priceController.addListener(() {
            updatedValue();
          });

          //==============================================================

          return widget.estimateDetail['estimate_longs'].length > 0
              ? Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.w),
                      color: AppColors.WHITE_COLOR,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.GREY,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            appText(
                              title:
                                  "${lang?.getTranslatedValue('name')}: ${data['title']}",
                              fontSize: 2.h,
                              maxLines: 3,
                              color: AppColors.PRIMERY_COLOR,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                        Row(
                          children: [
                            Expanded(
                              child: textField(
                                controller: heightController,
                                label: lang?.getTranslatedValue('Height'),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: textField(
                                controller: widthController,
                                label: lang?.getTranslatedValue(
                                    'Widht'), // Corrected typo here
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Expanded(
                              child: textField(
                                controller: inchController,
                                readOnly: true,
                                label: lang?.getTranslatedValue('Inch'),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: textField(
                                controller: squareController,
                                readOnly: true,
                                label: lang?.getTranslatedValue('Sqft'),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                        textField(
                          controller: priceController,
                          label: lang?.getTranslatedValue("Price:"),
                        ),
                        SizedBox(height: 1.h),
                        textField(
                          controller: resultPriceController,
                          readOnly: true,
                          label: lang?.getTranslatedValue('Total price'),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }

  Widget _shortListEdit() {
    var lang = AppLocalization.of(context);
    return Column(
      children: List.generate(widget.estimateDetail['estimate_shorts'].length,
          (index) {
        var data = widget.estimateDetail['estimate_shorts'][index];
        var qtyController = qtyControllers.length > index
            ? qtyControllers[index]
            : TextEditingController();
        var shortController = shortControllers.length > index
            ? shortControllers[index]
            : TextEditingController();
        var shortResultPriceController =
            shortResultPriceControllers.length > index
                ? shortResultPriceControllers[index]
                : TextEditingController();

        qtyControllers.add(qtyController);
        shortControllers.add(shortController);
        shortResultPriceControllers.add(shortResultPriceController);

        qytValue = double.tryParse(data['qty'].toString()) ?? 0.0;
        shortPriceValue = double.tryParse(data['price'].toString()) ?? 0.0;
        shortPriceData = double.tryParse(data['total_price'].toString()) ?? 0.0;
        listTotalPrice = double.tryParse(listTotalPriceController.text) ?? 0.0;
        totalInch = double.tryParse(totalInchController.text) ?? 0.0;
        totalSqft = double.tryParse(totalSqftController.text) ?? 0.0;
        // listTotalPrice = double.tryParse(widget.estimateDetail['total_list_price'].toString()) ?? 0.0;

        qtyController.text = qytValue.toString();
        shortController.text = shortPriceValue.toString();
        shortResultPriceController.text = shortPriceData.toString();

        

        qtyController.addListener(() {
          qytValue = double.tryParse(qtyController.text) ?? 0.0;
          shortPriceValue = double.tryParse(shortController.text) ?? 0.0;
          shortPriceData = qytValue * shortPriceValue;
          shortResultPriceController.text = shortPriceData.toStringAsFixed(2);
          totalPrice = 0.0;
          shortTotalPrice = 0.0;
          for (int i = 0;
              i < widget.estimateDetail['estimate_shorts'].length;
              i++) {
            var resultPriceData =
                double.tryParse(shortResultPriceControllers[i].text) ?? 0.0;
            shortTotalPrice += resultPriceData;
          }

          for (int i = 0;
              i < widget.estimateDetail['estimate_longs'].length;
              i++) {
            var resultPriceData =
                double.tryParse(resultPriceControllers[i].text) ?? 0.0;
            var resultInchData =
                double.tryParse(inchControllers[i].text) ?? 0.0;
            var resultSqftData =
                double.tryParse(squareControllers[i].text) ?? 0.0;

            totalPrice += resultPriceData;
            totalInch += resultInchData;
            totalSqft += resultSqftData;
          }

          listTotalPrice = totalPrice + shortTotalPrice;
          listTotalPriceController.text = listTotalPrice.toStringAsFixed(2);

          updateProduct();
        });

        shortController.addListener(() {
          qytValue = double.tryParse(qtyController.text) ?? 0.0;
          shortPriceValue = double.tryParse(shortController.text) ?? 0.0;
          listTotalPrice =
              double.tryParse(listTotalPriceController.text) ?? 0.0;
          totalInch = double.tryParse(totalInchController.text) ?? 0.0;
          totalSqft = double.tryParse(totalSqftController.text) ?? 0.0;

          shortPriceData = qytValue * shortPriceValue;
          shortResultPriceController.text = shortPriceData.toStringAsFixed(2);
          totalPrice = 0.0;

          shortTotalPrice = 0.0;
          for (int i = 0;
              i < widget.estimateDetail['estimate_shorts'].length;
              i++) {
            var resultPriceData =
                double.parse(shortResultPriceControllers[i].text);
            shortTotalPrice += resultPriceData;
          }
          print("shortTotalPrice :2 ${shortTotalPrice}");

          for (int i = 0;
              i < widget.estimateDetail['estimate_longs'].length;
              i++) {
            var resultPriceData =
                double.tryParse(resultPriceControllers[i].text) ?? 0.0;
            var resultInchData =
                double.tryParse(inchControllers[i].text) ?? 0.0;
            var resultSqftData =
                double.tryParse(squareControllers[i].text) ?? 0.0;

            totalPrice += resultPriceData;
            totalInch += resultInchData;
            totalSqft += resultSqftData;
          }

          listTotalPrice = totalPrice + shortTotalPrice;
          listTotalPriceController.text = listTotalPrice.toStringAsFixed(2);
          print("listTotalPrice :5 ${listTotalPrice}");
          print("listTotalPriceController :5 ${listTotalPriceController.text}");
          updateProduct();
        });
        return widget.estimateDetail['estimate_shorts'].length > 0
            ? Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
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
                          title:
                              "${lang?.getTranslatedValue('name')}:  ${data['title']}",
                          fontSize: 2.h,
                          color: AppColors.PRIMERY_COLOR,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: textField(
                                label: '${lang?.getTranslatedValue('qty:')}',
                                controller: qtyController),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                              child: textField(
                                  label: lang?.getTranslatedValue("Price:"),
                                  controller: shortController))
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      textField(
                          readOnly: true,
                          label: lang?.getTranslatedValue('Total price'),
                          controller: shortResultPriceController)
                    ],
                  ),
                ),
              )
            : const SizedBox();
      }),
    );
  }

  textField({
    label,
    hint,
    image,
    maxLines,
    keyboardType,
    validator,
    minline,
    controller,
    suffixIcon,
    obscureText,
    prefixIcon,
    readOnly,
    onTap,
    inputFormatters,
    length,
    horizontalpadding,
    verticalpading,
    onEditingComplete,
    autovalidateMode,
    onChanged,
    autofocus,
    focusNode,
    backgroundcolor, // Pass the background color here
    textInputAction,
    fillColor,
    child,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalpadding ?? 0, vertical: verticalpading ?? 7),
      child: TextFormField(
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        onTap: onTap,
        focusNode: focusNode,
        validator: validator,
        keyboardType: TextInputType.number,
        textInputAction: textInputAction ?? TextInputAction.done,
        controller: controller,
        maxLines: maxLines,
        minLines: minline,
        autofocus: autofocus ?? false,
        autovalidateMode:
            autovalidateMode ?? AutovalidateMode.onUserInteraction,
        readOnly: readOnly ?? false,
        cursorColor: AppColors.PRIMERY_COLOR,
        obscureText: obscureText ?? false,
        style: const TextStyle(fontSize: 14, letterSpacing: 0.2),
        inputFormatters: const [
          // LengthLimitingTextInputFormatter(length),
        ],
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.PRIMERY_COLOR),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.PRIMERY_COLOR,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1,
              color: AppColors.PRIMERY_COLOR,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.PRIMERY_COLOR,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(8)),
          suffixIcon: suffixIcon,
          icon: prefixIcon,
          isDense: true,
          hintText: hint,
          errorMaxLines: 2,
          errorStyle: const TextStyle(height: 0, fontSize: 10),
          hintStyle: const TextStyle(
            color: AppColors.PRIMERY_COLOR,
            fontSize: 15,
          ),
          fillColor: fillColor ?? Colors.white, // Use the background color here
        ),
        // textCapitalization: TextCapitalization.sentences,
      ),
    );
  }
}
