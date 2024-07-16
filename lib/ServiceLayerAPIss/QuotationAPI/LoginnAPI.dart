// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../Models/ServiceLayerModel/LoginModel/login_data.dart';

class PostLoginAPi {
  static String? username;
  static String? password;

  static Future<Logindata> getGlobalData() async {
    try {
      log("Step11");
      final response = await http.post(
          Uri.parse("http://102.69.167.106:50001/b1s/v1/Login"),
          headers: {
            'Content-Type': 'application/json'
          }, //{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}
          body: json.encode({
            "CompanyDB": "MRP T1",
            "UserName": "api",
            "Password": "1234"
          }));
      print(json.encode(
          {"CompanyDB": "MRP T1", "UserName": "api", "Password": "8765"}));
      print("saplogin stcode11 ::" + response.statusCode.toString());

      log("saplogin: " + json.decode(response.body).toString());

      if (response.statusCode == 200) {
        log("Step22");

        return Logindata.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        log("saplogin: " + json.decode(response.body).toString());
        log("saplogin stcode22 ::" + response.statusCode.toString());
        throw Exception("Error");
        // return Logindata.error(
        //     json.decode(response.body) as Map<String, dynamic>,
        //     response.statusCode);
      }
    } catch (e) {
      log('Exception saplogin: $e');
      // throw Exception('Exception saplogin: $e');
      return Logindata.issue('Restart the app or contact the admin!!..', 500);
    }
  }
}