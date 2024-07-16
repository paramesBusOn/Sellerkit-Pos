import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Models/Service%20Model/PettyCashModel.dart';
import 'package:posproject/url/url.dart';

class PettyCashModelAPI {
  static Future<PettyCashModel> getData(String branch,) async {
    int ressCode = 500;
    try {
      print('http://102.69.167.106:1888/api/POSMaster/GetAccountDetails/Branch?Branch=ARSFG');
      final response = await http.get(
        Uri.parse('http://102.69.167.106:1888/api/POSMaster/GetAccountDetails/Branch?Branch=${AppConstant.branch}'),
        headers: {
          "content-type": "application/json",
        },
      );
      ressCode = response.statusCode;
      // log(response.statusCode.toString());
      log("Petty cash response:::${json.decode(response.body)}");
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return PettyCashModel.fromJson(json.decode(response.body), ressCode);
      } else {
        log("Error userlogin: ${json.decode(response.body)}");
        throw Exception("Error");
        // return AccountBalanceModel.exception('Error', ressCode);
      }
    } catch (e) {
      log("Exception userlogin: $e");
       throw Exception(e.toString());
      // return PettyCashModel.exception(e.toString(), ressCode);
    }
  }
}
