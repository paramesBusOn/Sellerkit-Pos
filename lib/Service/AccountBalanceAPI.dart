import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Models/Service Model/AccountBalModel.dart';

class AccountBalApi {
  static Future<AccountBalanceModel> getData(String cardcode) async {
    int ressCode = 500;

    try {
      final response = await http.get(
        Uri.parse(
            'http://102.69.167.106:1888/api/POSMaster/GetAccountBalance/$cardcode'),
        headers: {
          "content-type": "application/json",
        },
      );
      ressCode = response.statusCode;
      // log(response.statusCode.toString());
      // log("AccBal Res${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return AccountBalanceModel.fromJson(
            json.decode(response.body), ressCode);
      } else {
        log("Error AccBal: ${json.decode(response.body)}");
        throw Exception("Error");
        // return AccountBalanceModel.exception('Error', ressCode);
      }
    } catch (e) {
      log("Exception AB: $e");
      //  throw Exception(e.toString());
      return AccountBalanceModel.exception(e.toString(), ressCode);
    }
  }
}
