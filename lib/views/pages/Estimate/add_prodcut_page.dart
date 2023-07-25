// ignore_for_file: unused_local_variable, unused_element, no_leading_underscores_for_local_identifiers, unrelated_type_equality_checks, avoid_print, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/app_button.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';
import '../../../businessLogic/blocs/Create Estimate/create_estimate_cubit.dart';
import '../../../businessLogic/blocs/Create Estimate/create_estimate_state.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/constants.dart';
import '../../comman/app_text.dart';
import '../../comman/app_textfiled.dart';
import '../../comman/loader.dart';



class AddProductPage extends StatefulWidget {
  String name;
  String email;
  String phone;
  AddProductPage(
      {super.key,
      required this.name,
      required this.email,
      required this.phone});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController witdhController = TextEditingController();
  TextEditingController depthController = TextEditingController();
  TextEditingController dropdownController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  TextEditingController shortTitleController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController shortPriceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  MeasurementType unitType = MeasurementType.sqft;

  PriceType priceType = PriceType.sqft;

  List addProductList = [];

  double sqftUnit = 0.0;
  double inchUnit = 0.0;
  double totalPrice = 0.0;
  double price = 0.0;
  double height = 0.0;
  double width = 0.0;

  void _addTodo() {
    setState(() {
      // addProductList.add(ProductTodo(
      //   title: titleController.text,
      //   height: double.parse(heightController.text),
      //   width:double.parse(witdhController.text),
      //   price: double.parse(priceController.text),
      //   inchUnit: inchUnit,
      //   sqftUnit: sqftUnit,
      //   totalPrice: totalPrice,
      // ));
      addProductList.add({
        "title": titleController.text,
        "height": double.parse(heightController.text),
        "widht": double.parse(witdhController.text),
        "price": double.parse(priceController.text),
        "inch": inchUnit,
        "sqft": sqftUnit,
        "total_price": totalPrice
      });
    });
    print("addProductList :1 ${addProductList}");
  }

  //====================== Short Product ====================================
  List addShortProductList = [];
  double shortTotalPrice = 0.0;
  double qty = 0.0;
  double shortPrice = 0.0;

  void _addShortTodo() {
    setState(() {
      // addShortProductList.add(ShortProductTodo(
      //   title: shortTitleController.text,
      //   price: double.parse(shortPriceController.text),
      //   totalPrice: shortTotalPrice,
      //   qty: double.parse(qtyController.text),
      // ));

      addShortProductList.add({
        "title": shortTitleController.text,
        "price": double.parse(shortPriceController.text),
        "total_price": shortTotalPrice,
        "qty": double.parse(qtyController.text),
      });
    });
  }

//================================ Total list Count =====================

  double totalProductTodoeInchUnitSum = 0.0;
  double totalProductTodoeSqftUnitSum = 0.0;

  double totalProductTodopriceSum = 0.0;
  double totalShortProductTodopriceSum = 0.0;
  double listTotalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);

    return BlocProvider(
      create: (context) => CreateEstimateCubit(ApiServices()),
      child: Scaffold(
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
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 1.5.w),
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      useSafeArea: true,
                      context: context,
                      builder: (context) {
                        return _addShortDetail(context);
                      },
                    );
                  },
                  child: Icon(
                    Icons.chair,
                    color: AppColors.WHITE_COLOR,
                    size: 4.h,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(right: 1.5.w),
              child: GestureDetector(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      useSafeArea: true,
                      context: context,
                      builder: (context) {
                        return _addDetail(context);
                      },
                    );
                  },
                  child: Icon(
                    Icons.bedroom_parent,
                    color: AppColors.WHITE_COLOR,
                    size: 4.h,
                  )),
            )
          ],
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Column(
                      children: List.generate(addProductList.length, (index) {
                        var productTodo = addProductList[index];

                        setState(() {
                          totalProductTodopriceSum = addProductList.fold(
                              0,
                              (sum, productTodo) =>
                                  sum + productTodo['total_price']);

                          totalProductTodoeInchUnitSum = addProductList.fold(0,
                              (sum, productTodo) => sum + productTodo['inch']);

                          totalProductTodoeSqftUnitSum = addProductList.fold(0,
                              (sum, productTodo) => sum + productTodo['sqft']);

                          listTotalPrice = totalProductTodopriceSum +
                              totalShortProductTodopriceSum;
                        });

                        return Padding(
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
                                        title: productTodo['title'],
                                        fontSize: 1.5.h,
                                        maxLines: 3,
                                        color: AppColors.PRIMERY_COLOR,
                                        fontWeight: FontWeight.w700),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            addProductList.removeAt(index);
                                            totalProductTodopriceSum =
                                                addProductList.fold(
                                                    0,
                                                    (sum, productTodo) =>
                                                        sum +
                                                        productTodo['total_price']);
                                            listTotalPrice =
                                                totalProductTodopriceSum +
                                                    totalShortProductTodopriceSum;
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: AppColors.FONT_COLOR,
                                          size: 3.h,
                                        ))
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
                                          color:
                                              AppColors.GREY.withOpacity(0.1),
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
                                                title: lang?.getTranslatedValue(
                                                    'Height:'),
                                              ),
                                              appText(
                                                  title: productTodo['height']
                                                      .toStringAsFixed(2)),
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
                                          color:
                                              AppColors.GREY.withOpacity(0.1),
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
                                                title: lang?.getTranslatedValue(
                                                    'Widht:'),
                                              ),
                                              appText(
                                                  title: productTodo['widht']
                                                      .toStringAsFixed(2)),
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
                                          color:
                                              AppColors.GREY.withOpacity(0.1),
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
                                                title: lang?.getTranslatedValue(
                                                    'Inch:'),
                                              ),
                                              appText(
                                                  title: productTodo['inch']
                                                      .toStringAsFixed(2)),
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
                                          color:
                                              AppColors.GREY.withOpacity(0.1),
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
                                                title: lang?.getTranslatedValue(
                                                    'Sqft:'),
                                              ),
                                              appText(
                                                  title: productTodo['sqft']
                                                      .toStringAsFixed(2)),
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
                                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                                  height: 7.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.GREY.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4.w),
                                    // border: Border.all(
                                    //     color: AppColors.GREY, width: 0.3)
                                  ),
                                  child: Center(
                                    child: appText(
                                        title: '₹${productTodo['price'].toStringAsFixed(2)}',
                                        color: AppColors.FONT_COLOR),
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
                                    borderRadius: BorderRadius.circular(4.w),
                                    // border: Border.all(
                                    //     color: AppColors.GREY, width: 0.3)
                                  ),
                                  child: Center(
                                    child: appText(
                                        title:
                                            '${lang?.getTranslatedValue('Total')}: ₹${productTodo['total_price'].toStringAsFixed(2)}',
                                        color: AppColors.WHITE_COLOR),
                                  ),
                                ),

                                // appText(
                                //     title:
                                //         productTodo.totalPrice.toString()),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    Column(
                      children:
                          List.generate(addShortProductList.length, (index) {
                        var shortProductList =
                            addShortProductList[index];

                        setState(() {
                          totalShortProductTodopriceSum =
                              addShortProductList.fold(
                                  0,
                                  (sum, productTodo) =>
                                      sum + productTodo['total_price']);

                          listTotalPrice = totalProductTodopriceSum +
                              totalShortProductTodopriceSum;
                        });

                        print(
                            'listTotalPrice: 2 $totalShortProductTodopriceSum');

                        return Padding(
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    appText(
                                        title: shortProductList['title'],
                                        fontSize: 1.5.h,
                                        color: AppColors.PRIMERY_COLOR,
                                        fontWeight: FontWeight.w700),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            addShortProductList.removeAt(index);
                                            totalShortProductTodopriceSum =
                                                addShortProductList.fold(
                                                    0,
                                                    (sum, productTodo) =>
                                                        sum +
                                                        productTodo['total_price']);
                                            listTotalPrice =
                                                totalProductTodopriceSum +
                                                    totalShortProductTodopriceSum;
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: AppColors.FONT_COLOR,
                                          size: 3.h,
                                        ))
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
                                          color:
                                              AppColors.GREY.withOpacity(0.1),
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
                                                title: lang?.getTranslatedValue(
                                                    'qty:'),
                                              ),
                                              appText(
                                                  title: shortProductList['qty']
                                                      .toStringAsFixed(2)),
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
                                          color:
                                              AppColors.GREY.withOpacity(0.1),
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
                                                title: lang?.getTranslatedValue(
                                                    'Price:'),
                                              ),
                                              appText(
                                                  title: '₹${shortProductList['price']
                                                      .toStringAsFixed(2)}'),
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
                                    borderRadius: BorderRadius.circular(4.w),
                                    // border: Border.all(
                                    //     color: AppColors.GREY, width: 0.3)
                                  ),
                                  child: Center(
                                    child: appText(
                                        title: '${lang?.getTranslatedValue('Total')}: ₹${shortProductList['total_price']
                                            .toStringAsFixed(2)}',
                                        color: AppColors.WHITE_COLOR),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    addProductList.isNotEmpty || addShortProductList.isNotEmpty
                        ? Container(
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
                                  appText(title:' ₹${ listTotalPrice.toStringAsFixed(2)}'),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 1.h,
                    ),
                    addProductList.isNotEmpty
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      appText(
                                        title: lang
                                            ?.getTranslatedValue('Total Inch:'),
                                      ),
                                      appText(
                                          title: totalProductTodoeInchUnitSum
                                              .toStringAsFixed(2)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      appText(
                                        title: lang
                                            ?.getTranslatedValue('Total Sqft:'),
                                      ),
                                      appText(
                                          title: totalProductTodoeSqftUnitSum
                                              .toStringAsFixed(2)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 2.h,
                    ),
                    addProductList.isNotEmpty || addShortProductList.isNotEmpty
                        ?
                         Center(
                            child: BlocBuilder<CreateEstimateCubit,
                                CreateEstimateState>(
                              builder: (context, state) {
                                if (state is LoadedCreateEstimateState) {
                                  return appButton(
                                      onTap: () {
                                        if (!state.isLoading) {
                                          context
                                              .read<CreateEstimateCubit>()
                                              .createEstimate(
                                                  context: context,
                                                  longList: addProductList,
                                                  shortList:
                                                      addShortProductList,
                                                  name: widget.name,
                                                  mobile_number: widget.phone,
                                                  address: widget.email,
                                                  totalListPrice:
                                                      listTotalPrice.toString(),
                                                  total_inch:
                                                      totalProductTodoeInchUnitSum
                                                          .toString(),
                                                  total_sqft:
                                                      totalProductTodoeSqftUnitSum
                                                          .toString());

                                          // }
                                        }
                                        
                                      },
                                      child: (!state.isLoading)
                                          ? appText(
                                              title: lang
                                                  ?.getTranslatedValue('Add'),
                                              color: AppColors.WHITE_COLOR)
                                          : Loader(
                                              color: AppColors.WHITE_COLOR));
                                }
                                return Container();
                              },
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _addDetail(BuildContext context) {
    var lang = AppLocalization.of(context);

    sqftUnit = 0.0;
    inchUnit = 0.0;
    totalPrice = 0.0;

    price = 0.0;
    height = 0.0;
    width = 0.0;
    return SingleChildScrollView(
      child: AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
              color: AppColors.PRIMERY_COLOR,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3.w),
                  topRight: Radius.circular(3.w))),
          height: 10.h,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appText(
                    title: lang?.getTranslatedValue('Create'),
                    color: AppColors.WHITE_COLOR,
                    fontWeight: FontWeight.w700),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: AppColors.WHITE_COLOR,
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          StatefulBuilder(
            builder: (context, setState) {
              // if (unitType == MeasurementType.sqft) {

              setState((){
                inchUnit = height * width;
                sqftUnit = inchUnit / 144;
              });
              // setState(() {
              //   sqftUnit = height * width;
              //   inchUnit = height * width / 144;
              // });
              // } else {
              //   setState(() {
              //     sqftUnit = height * width / 144;
              //     inchUnit = height * width;
              //   });
              // }

              //============================== total Price ====================================

              // if (priceType == PriceType.sqft &&
              //     unitType == MeasurementType.sqft) {
              setState(() {
                totalPrice = price * sqftUnit;
              });
              // } else if (priceType == PriceType.inch &&
              //     unitType == MeasurementType.inch) {
              //   setState(() {
              //     totalPrice = price * inchUnit;
              //   });
              // } else if (priceType == PriceType.inch &&
              //     unitType == MeasurementType.sqft) {
              //   setState(() {
              //     totalPrice = price * inchUnit;
              //   });
              // } else if (priceType == PriceType.sqft &&
              //     unitType == MeasurementType.inch) {
              //   setState(() {
              //     totalPrice = price * sqftUnit;
              //   });
              // } else {
              //   totalPrice = 0;
              // }

              return SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: appText(
                              title: lang?.getTranslatedValue('Enter Title'),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        appTextfild(
                          isdense: true,
                          controller: titleController,
                          hint: lang?.getTranslatedValue('Title'),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          borderRadius: 4.w,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return lang?.getTranslatedValue('Enter Title');
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: appText(
                                        title:
                                            lang?.getTranslatedValue('Height:'),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  appTextfild(
                                    isdense: true,
                                    controller: heightController,
                                    hint: lang?.getTranslatedValue('Height'),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    borderRadius: 4.w,
                                    onChanged: (value) {
                                      setState(() {
                                        height = double.tryParse(value) ?? 0.0;
                                      });
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return lang?.getTranslatedValue(
                                            'Enter Height');
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: appText(
                                        title:
                                            lang?.getTranslatedValue('Widht:'),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  appTextfild(
                                    isdense: true,
                                    controller: witdhController,
                                    hint: lang?.getTranslatedValue('Widht'),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    borderRadius: 4.w,
                                    onChanged: (value) {
                                      setState(() {
                                        width = double.tryParse(value) ?? 0.0;
                                      });
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return lang
                                            ?.getTranslatedValue('Enter Widht');
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: appText(
                                        title: lang
                                            ?.getTranslatedValue('Total Inch:'),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    height: 7.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.w),
                                      color: AppColors.GREY.withOpacity(0.1),
                                      // border: Border.all(
                                      //     color: AppColors.GREY, width: 0.3)
                                    ),
                                    child: Center(
                                      child: appText(
                                          title: inchUnit.toStringAsFixed(2)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: appText(
                                        title: lang
                                            ?.getTranslatedValue('Total Sqft:'),
                                        fontWeight: FontWeight.w700),
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
                                      child: appText(
                                          title: sqftUnit.toStringAsFixed(2)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        appText(
                            title: lang?.getTranslatedValue('Enter Price'),
                            fontWeight: FontWeight.w600),
                        SizedBox(
                          height: 1.h,
                        ),
                        appTextfild(
                          isdense: true,
                          controller: priceController,
                          hint: lang?.getTranslatedValue('Enter Price'),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          borderRadius: 4.w,
                          onChanged: (value) {
                            setState(() {
                              price = double.tryParse(value) ?? 0.0;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return lang?.getTranslatedValue('Enter Price');
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          height: 7.h,
                          //  width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.GREY.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          child: Center(
                            child: appText(
                                title: totalPrice.toStringAsFixed(2),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Center(
                          child: appButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _addTodo();
                                    Navigator.pop(context);
                                    titleController.clear();
                                    heightController.clear();
                                    witdhController.clear();
                                    priceController.clear();
                                    sqftUnit = 0.0;
                                    inchUnit = 0.0;
                                    totalPrice = 0.0;
                                  });
                                }
                              },
                              radius: 3.w,
                              width: 40.w,
                              child: appText(
                                  title: lang?.getTranslatedValue('Add'),
                                  color: AppColors.WHITE_COLOR)),
                        )
                      ],
                    )),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _addShortDetail(BuildContext context) {
    var lang = AppLocalization.of(context);

    shortTotalPrice = 0.0;
    qty = 0.0;
    shortPrice = 0.0;

    return SingleChildScrollView(
      child: AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
              color: AppColors.PRIMERY_COLOR,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3.w),
                  topRight: Radius.circular(3.w))),
          height: 10.h,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appText(
                    title: lang?.getTranslatedValue('Create'),
                    color: AppColors.WHITE_COLOR,
                    fontWeight: FontWeight.w700),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: AppColors.WHITE_COLOR,
                  ),
                )
              ],
            ),
          ),
        ),
        actions: [
          StatefulBuilder(
            builder: (context, setState) {
              setState(() {
                shortTotalPrice = qty * shortPrice;
              });
              return SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: appText(
                              title: lang?.getTranslatedValue('Enter Title'),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        appTextfild(
                          isdense: true,
                          controller: shortTitleController,
                          hint: lang?.getTranslatedValue('Title'),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          borderRadius: 4.w,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return lang?.getTranslatedValue('Enter Title');
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: appText(
                                        title: lang?.getTranslatedValue('qty:'),
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  appTextfild(
                                    isdense: true,
                                    controller: qtyController,
                                    hint: lang?.getTranslatedValue('qty:'),
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    borderRadius: 4.w,
                                    onChanged: (value) {
                                      setState(() {
                                        qty = double.tryParse(value) ?? 0.0;
                                      });
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return lang
                                            ?.getTranslatedValue('Enter qty');
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                appText(
                                    title:
                                        lang?.getTranslatedValue('Enter Price'),
                                    fontWeight: FontWeight.w600),
                                SizedBox(
                                  height: 1.h,
                                ),
                                appTextfild(
                                  isdense: true,
                                  controller: shortPriceController,
                                  hint: lang?.getTranslatedValue('Enter Price'),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  borderRadius: 4.w,
                                  onChanged: (value) {
                                    setState(() {
                                      shortPrice =
                                          double.tryParse(value) ?? 0.0;
                                    });
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return lang
                                          ?.getTranslatedValue('Enter Price');
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            )),
                            SizedBox(
                              width: 1.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          height: 7.h,
                          //  width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.GREY.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          child: Center(
                            child: appText(
                                title: shortTotalPrice.toStringAsFixed(2),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Center(
                          child: appButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _addShortTodo();
                                    Navigator.pop(context);
                                    print("SHORTTOTAL:- $shortTotalPrice");
                                    shortTitleController.clear();
                                    shortPriceController.clear();
                                    qtyController.clear();
                                    shortTotalPrice = 0.0;
                                  });
                                }
                              },
                              radius: 3.w,
                              width: 40.w,
                              child: appText(
                                  title: lang?.getTranslatedValue('Add'),
                                  color: AppColors.WHITE_COLOR)),
                        )
                      ],
                    )),
              );
            },
          ),
        ],
      ),
    );
  }
}
