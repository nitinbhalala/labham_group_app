// ignore_for_file: deprecated_member_use

import 'package:minimall_store/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Functions{
  
launchWhatsapp(String contact,String link) async {
  var url = "whatsapp://send?phone=+91$contact&text=$link";
  if (await launch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

 launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    launchUrl(emailLaunchUri);
  }


 launchPhoneCall(String phone) async {
    final url = Uri.parse('tel:$phone');
    if (await launchUrl(url)) {
      launchUrl(url);
    } else {
      throw "Can't launch $url";
      
    }
  }

   launchPlayStore() async {
    const url = Constants.Rating;
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

launchPrivacy(String privacyData) async {
  String url = privacyData;
  
  if (await launch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  
}