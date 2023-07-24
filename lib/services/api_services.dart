// ignore_for_file: avoid_print, unused_local_variable, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minimall_store/services/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';

class ApiServices {
  //----------------------Login API----------------------------
  Future loginUser(String mobileNo, String password) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('language');
    response = await http.post(
      Uri.parse(ApiUrl.loginUrl),
      headers: {
        'Content-Type': 'application/json',
        'locale': language!,
      },
      body: jsonEncode({
        'phone': mobileNo,
        'password': password,
      }),
    );
    print("LOGIN STATUS CODE : ${response.statusCode}");
    print("LOGIN BODY : ${response.body}");
    return json.decode(response.body);
  }

//-----------------RegisterUser API -------------------------------

  Future registerUser(
    String name,
    String email,
    String mobileNo,
    String password,
    int status,
  ) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('language');
    response = await http.post(
      Uri.parse(ApiUrl.registerUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'locale': lang.toString(),
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': mobileNo,
        'password': password,
        'status': status,
        'language': lang,
      }),
    );
    print("REGISTER STATUS CODE : ${response.statusCode}");
    print("REGISTER BODY : ${response.body}");
    return json.decode(response.body);
  }

// ----------------- ChangePassword API ---------------------------------

  Future changePassowrd(String currentPassword, String newPassword) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.post(
      Uri.parse("${ApiUrl.baseUrl}/change-password/$id"),
      headers: {
        'Content-Type': 'application/json',
        'locale': language.toString(),
        'token': token!,
      },
      body: jsonEncode({
        'current_password': currentPassword,
        'new_password': newPassword,
      }),
    );
    print("PASSWORD STATUS CODE : ${response.statusCode}");
    print("PASSWORD BODY : ${response.body}");
    return json.decode(response.body);
  }

// --------------ChangeLanguage API---------------

  Future changelanguage(String language) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    String? token = prefs.getString('token');

    response = await http.post(
      Uri.parse(ApiUrl.languageUrl),
      headers: {
        'Content-Type': 'application/json',
        'locale': language.toString(),
        'token': token!,
      },
      body: jsonEncode({
        'language': language,
      }),
    );
    print("LANGUAGE STATUS CODE : ${response.statusCode}");
    print("LANGUAGE BODY : ${response.body}");
    return json.decode(response.body);
  }

  // ----------- Banner API ------------------

  Future<List<dynamic>> getBanner() async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.get(Uri.parse(ApiUrl.bannerUrl), headers: {
      'locale': language.toString(),
      'token': token!,
    });
    print("BANNER STATUS CODE : ${response.statusCode}");
    print("BANNER BODY : ${response.body}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final banner = jsonResponse['data'];
      return banner;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

// ---------------- Video List API -----------------

  Future<List<dynamic>> getVideoList() async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.get(Uri.parse(ApiUrl.videoListUrl), headers: {
      'locale': language.toString(),
      'token': token!,
    });
    print("VIDEO STATUS CODE : ${response.statusCode}");
    print("VIDEO BODY : ${response.body}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final video = jsonResponse['data'];
      return video;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

// ========================/GalleryList/===============================

  Future galleryList() async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.get(Uri.parse(ApiUrl.galleryListUrl), headers: {
      'locale': language.toString(),
      'token': token!,
    });
    print("GALLERY STATUS CODE : ${response.statusCode}");
    print("GALLERY BODY : ${response.body}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body)['data'];
      var gallery = jsonResponse;
      return gallery;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

// ========================/EstimateList/===============================

  Future estimateList() async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.get(Uri.parse(ApiUrl.EstimateListUrl), headers: {
      'locale': language.toString(),
      'token': token!,
    });
    print("ESTIMATE STATUS CODE : ${response.statusCode}");
    print("ESTIMATE BODY : ${response.body}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body)['data'];
      var estimate = jsonResponse;
      return estimate;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // ------------- Add Address API --------------

  Future createEstimate(
      var longList,
      var shortList,
      String name,
      String mobile_number,
      String address,
      String totalListPrice,
      String total_inch,
      String total_sqft) async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    Response response;
   
  
   print("longList :1 ${longList}");
   print("longList :2 ${shortList}");

    response = await http.post(
      Uri.parse(ApiUrl.createEstimatetUrl),
      headers: {
        'Content-Type': 'application/json',
        'locale': language.toString(),
        'token': token!,
      },
      body: jsonEncode({
        'long': longList,
        'short': shortList,
        'name': name,
        'mobile_number': mobile_number,
        'address': mobile_number,
        'total_list_ince': total_inch,
        'total_sqft': total_sqft,
        'total_list_price': totalListPrice,
      }),
    );
    print("CREATE ESTIMATE STATUS CODE : ${response.statusCode}");
    print("CREATE ESTIMATE BODY : ${response.body}");
    return json.decode(response.body);
  }

  // ========================/updateProfile/===============================

  Future updateProfile(String name, String email, String mobileNo,
      XFile? avatar, XFile? appLogo, XFile? userLogo) async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    String url = ApiUrl.updateProfileUrl;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'locale': language.toString(),
      'token': token!,
    });
    request.fields['name'] = name;
    request.fields['phone'] = mobileNo;
    request.fields['email'] = email;

    if (avatar != null) {
      request.files
          .add(await http.MultipartFile.fromPath('avatar', avatar.path));
    }
    if (appLogo != null) {
      request.files
          .add(await http.MultipartFile.fromPath('app_logo', appLogo.path));
    }
    if (userLogo != null) {
      request.files
          .add(await http.MultipartFile.fromPath('user_logo', userLogo.path));
    }

    var response = await request.send();
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    return userData;
  }

  // ---------- Delete Address -----------

  Future deleteEstimate(int id) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await get(
      Uri.parse("${ApiUrl.deleteEstimate}/$id"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'locale': language.toString(),
        'token': token!,
      },
    );
    print("DELETE ESTIMATE STATUS CODE: ${response.statusCode}");
    print("DELETE ESTIMATE STATUS BODY: ${response.body}");
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete user.');
    }
  }

  // ----------- Delivery Address List API -----------------------

  Future<List<dynamic>> deliveryAddressList() async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response =
        await http.get(Uri.parse(ApiUrl.deliveryAddressListUrl), headers: {
      'locale': language.toString(),
      'token': token!,
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final deliveryList = jsonResponse['data'];
      return deliveryList;
    } else {
      throw Exception('Failed to load trending offers');
    }
  }

  // -----------------Update address ----------------

  Future updateDeliveryAddress(
    String buildingNo,
    String address1,
    String address2,
    String landmark,
    String zipcode,
    String type,
    int id,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    Response response;
    return checkZipCode(zipcode).then((value) async {
      if (value['status'] == true) {
        response = await http.post(
          Uri.parse('${ApiUrl.baseUrl}/delivery-address/update/$id'),
          headers: {
            'Content-Type': 'application/json',
            'locale': language.toString(),
            'token': token!,
          },
          body: jsonEncode({
            'building_no': buildingNo,
            'address1': address1,
            'address2': address2,
            'landmark': landmark,
            'zipcode': zipcode,
            'type': type,
            'city_id': 1,
            'state_id': 1,
            'country_id': 1,
            'status': 1,
            'is_primary': 0
          }),
        );
        return json.decode(response.body);
      } else {
        return value;
      }
    });
  }

// ========================/primaryAddress/===============================

  Future primaryAddress(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    Response response;
    response = await http.post(
      Uri.parse('${ApiUrl.baseUrl}/delivery-address/mark-as-primary/$id'),
      headers: {
        'Content-Type': 'application/json',
        'locale': language.toString(),
        'token': token!,
      },
      body: jsonEncode({'1': 1}),
    );
    return json.decode(response.body);
  }

  // ========================/checkZipCode/===============================

  Future checkZipCode(String zipCode) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.get(
      Uri.parse("${ApiUrl.baseUrl}/check-delivery-status?zipcode=$zipCode"),
      headers: {
        'locale': language.toString(),
        'token': token!,
      },
    );
    return json.decode(response.body);
  }

  // ========================/getproductDetail/===============================

  Future getproductDetail(int id) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http
        .get(Uri.parse("${ApiUrl.baseUrl}/product/detail/$id"), headers: {
      'locale': language.toString(),
      'token': token!,
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body)['data'];
      final productDetail = jsonResponse;

      return productDetail;
    } else {
      throw Exception('Failed to load trending offers');
    }
  }

  // ========================/createOrder/===============================

  // Future createOrder(
  //   var basket,
  //   int address_id,
  //   String order_note,
  //   double order_total,
  //   double use_wallet_amount,
  //   int status,
  // ) async {
  //   Response response;
  //   final prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //   String? language = prefs.getString('language');
  //   int? addressId = prefs.getInt('primaryId');
  //   List basketList = [];
  //   for (var element in basket) {
  //     var data = CartModel.fromJson(jsonDecode(element));
  //     basketList.add({
  //       "product_id": data.id,
  //       "quantity": data.itemcount,
  //       "price": data.price,
  //       "item_total": data.itemTotal,
  //       "category_id": data.categoryId,
  //       "unit_id": data.unitId
  //     });
  //   }

  //   response = await http.post(
  //     Uri.parse(ApiUrl.createOrderUrl),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'locale': language.toString(),
  //       'token': token!,
  //     },
  //     body: jsonEncode({
  //       'basket': basketList,
  //       "address_id": address_id,
  //       "order_note": order_note,
  //       "order_total": order_total,
  //       "use_wallet_amount": use_wallet_amount,
  //       "status": status
  //     }),
  //   );
  //   print("body: jsonEncode : ${address_id}");
  //   var model = json.decode(response.body);

  //   return model;
  // }

  // // ========================/getOrderList/===============================

  // Future getOrderList(int page, bool hasnext) async {
  //   Response response;
  //   final prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //   String? language = prefs.getString('language');
  //   response = await http.get(
  //     Uri.parse(
  //         '${ApiUrl.baseUrl}/order/list?page=$page&status=${Constants.order_pending},${Constants.order_in_progress},${Constants.order_confirmed},${Constants.order_shipped}'),
  //     headers: {
  //       'locale': language.toString(),
  //       'token': token!,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(response.body);
  //     final orderList = jsonResponse['data']['data'];
  //     return orderList;
  //   } else {
  //     throw Exception('Failed to load trending offers');
  //   }
  // }

// ========================/getCancelList/===============================

  Future getCancelList(int page, bool hasnext) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.get(
      Uri.parse(
          '${ApiUrl.baseUrl}/order/list?page=$page&status=${Constants.order_delivered},${Constants.order_cancelled}'),
      headers: {
        'locale': language.toString(),
        'token': token!,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final orderCancelList = jsonResponse['data']['data'];
      return orderCancelList;
    } else {
      throw Exception('Failed to load trending offers');
    }
  }

  // ========================/cancelOrder/===============================

  Future cancelOrder(int id) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await delete(
      Uri.parse("${ApiUrl.baseUrl}/order/delete/$id"),
      headers: {
        'Content-Type': 'application/json',
        'locale': language.toString(),
        'token': token!,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to cancel order.');
    }
  }

  // ========================/getTrendingPopup/===============================

  Future getTrendingPopup() async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.get(Uri.parse(ApiUrl.trendingPopupUrl), headers: {
      'locale': language.toString(),
      'token': token!,
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final PopupImage = jsonResponse;

      return PopupImage;
    } else {
      throw Exception('Failed to load trending offers');
    }
  }

  // ========================/DeleviryBoyOrderList/===============================

  Future DeleviryBoyOrderList(int page, bool hasnext) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.get(
      Uri.parse(
          '${ApiUrl.baseUrl}/delivery/person/orders?page=$page&status=${Constants.order_shipped}'),
      headers: {
        'locale': language.toString(),
        'token': token!,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body)['data'];

      return jsonResponse;
    } else {
      throw Exception('Failed to load trending offers');
    }
  }

  // ========================/DeliveryBoyCancelList/===============================

  Future DeliveryBoyCancelList(int page, bool hasnext) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.get(
      Uri.parse(
          '${ApiUrl.baseUrl}/delivery/person/orders?page=$page&status=${Constants.order_delivered},${Constants.order_cancelled}'),
      headers: {
        'locale': language.toString(),
        'token': token!,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body)['data'];

      return jsonResponse;
    } else {
      throw Exception('Failed to load trending offers');
    }
  }

  // ========================/markOrderDelivery/===============================

  Future markOrderDelivery(int id, String otp) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    Response response;
    response = await http.get(
      Uri.parse('${ApiUrl.baseUrl}/mark-or-as-delivered?order_id=$id&otp=$otp'),
      headers: {
        'Content-Type': 'application/json',
        'locale': language.toString(),
        'token': token!,
      },
    );

    return json.decode(response.body);
  }

// ========================/getCouponList/===============================

  Future getCouponList(int page, bool hasnext) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.get(
      Uri.parse('${ApiUrl.CoupanListUrl}?page=$page'),
      headers: {
        'locale': language.toString(),
        'token': token!,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    } else {
      throw Exception('Failed to load trending offers');
    }
  }

// ========================/markCouponScratch/===============================

  Future markCouponScratch(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    Response response;
    response = await http.post(
      Uri.parse('${ApiUrl.baseUrl}/coupon/mark-scratched/$id'),
      headers: {
        'Content-Type': 'application/json',
        'locale': language.toString(),
        'token': token!,
      },
      body: jsonEncode({'1': 1}),
    );

    return json.decode(response.body);
  }

// ========================/getFavouriteList/===============================

  Future getFavouriteList(int page, bool hasnext) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http.get(
      Uri.parse('${ApiUrl.baseUrl}/product/wishlist?page=$page'),
      headers: {
        'locale': language.toString(),
        'token': token!,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body)['data']['data'];
      return jsonResponse;
    } else {
      throw Exception('Failed to load trending offers');
    }
  }

  // ========================/removeWishList/===============================

  Future removeWishList(int id) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await post(
      Uri.parse("${ApiUrl.baseUrl}/product/remove-from-wishlist/$id"),
      headers: {
        'Content-Type': 'application/json',
        'locale': language.toString(),
        'token': token!,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to cancel order.');
    }
  }

  // ========================/addWishList/===============================

  Future addWishList(int id) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await post(
      Uri.parse("${ApiUrl.baseUrl}/product/add-to-wishlist/$id"),
      headers: {
        'Content-Type': 'application/json',
        'locale': language.toString(),
        'token': token!,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to cancel order.');
    }
  }

// ========================/getWallateHistoryList/===============================

  Future getWalletHistoryList(
    int page,
    bool hasnext,
  ) async {
    Response response;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    response = await http
        .get(Uri.parse("${ApiUrl.walletHistoryUrl}?page=$page"), headers: {
      'locale': language.toString(),
      'token': token!,
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body)['data']['data'];
      var wallateHistory = jsonResponse;
      return wallateHistory;
    } else {
      throw Exception('Failed to load trending offers');
    }
  }

  Future getTermsAndCondition() async {
    Response response;
    response = await http.get(Uri.parse(ApiUrl.tremsAndConditionUrl));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final termsAndCondition = jsonResponse;
      return termsAndCondition;
    } else {
      throw Exception('Failed to load trending offers');
    }
  }
}
