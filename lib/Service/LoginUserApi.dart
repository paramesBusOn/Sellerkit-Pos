import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Models/Service%20Model/LoginUserModel.dart';
import 'package:posproject/url/url.dart';

class LoginUserAPI {
  static Future<LoginUserModel> getData(String userCode) async {
    int ressCode = 500; //
    print("br , term::${AppConstant.branch}:: ${AppConstant.terminal}");
    try {
      print(URL.url + 'LoginAuth/UserCode/Password/Terminal/Branch?UserCode=${userCode}&Password=1234&Terminal=${AppConstant.terminal}&Branch=${AppConstant.branch}');
      final response = await http.get(
        Uri.parse(URL.url + 'LoginAuth/UserCode/Password/Terminal/Branch?UserCode=${userCode}&Password=1234&Terminal=${AppConstant.terminal}&Branch=${AppConstant.branch}'),
        headers: {
          "content-type": "application/json",
        },
      );
      ressCode = response.statusCode;
      print(response.statusCode.toString());
      print("response:::${json.decode(response.body)}");
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return LoginUserModel.fromJson(json.decode(response.body), ressCode);
      } else {
        log("Error userlogin: ${json.decode(response.body)}");
        throw Exception("Error");
        // return AccountBalanceModel.exception('Error', ressCode);
      }
    } catch (e) {
      log("Exception userlogin: $e");
      //  throw Exception(e.toString());
      return LoginUserModel.exception(e.toString(), ressCode);
    }
  }
}
