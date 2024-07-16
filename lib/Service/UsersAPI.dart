import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Models/Service%20Model/LoginUserModel.dart';
import 'package:posproject/url/url.dart';

class UsersAPI {
  static Future<LoginUserModel> getData(
    String branch,
  ) async {
    int ressCode = 500;
    try {
      print('http://102.69.167.106:1888/api/POSMaster/TerminalLogin/Branch?Branch=$branch');
      final response = await http.get(
        Uri.parse('http://102.69.167.106:1888/api/POSMaster/TerminalLogin/Branch?Branch=$branch'),
        headers: {
          "content-type": "application/json",
        },
      );
      ressCode = response.statusCode;
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        print("response users:::${json.decode(response.body)}");

        // Map data = json.decode(response.body);
        return LoginUserModel.fromJson(json.decode(response.body), ressCode);
      } else {
        log("Error users: ${json.decode(response.body)}");
        throw Exception("Error");
        // return AccountBalanceModel.exception('Error', ressCode);
      }
    } catch (e) {
      log("Exception user: $e");
      throw Exception(e.toString());
      // return LoginUserModel.exception(e.toString(), ressCode);
    }
  }
}
