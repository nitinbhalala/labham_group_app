// ignore_for_file: avoid_print, unused_local_variable, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minimall_store/services/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // -------------  EREATE ESTIMATE API --------------

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


 // -------------  UpDATE ESTIMATE API --------------

  Future updateEstimate(
     
      var longList,
      var shortList,
      String id,
      String name,
      String mobile_number,
      String address,
      String totalListPrice,
      String total_inch,
      String total_sqft) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? language = prefs.getString('language');
    Response response;
   
  
   print("longList :1 ${longList}");
   print("longList :2 ${shortList}");

    response = await http.post(
      Uri.parse('${ApiUrl.updateEstimatetUrl}/$id'),
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
