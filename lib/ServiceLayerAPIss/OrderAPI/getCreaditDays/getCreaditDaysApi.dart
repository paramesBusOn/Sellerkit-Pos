// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';


import '../../../Models/ServiceLayerModel/SapSalesOrderModel/CreditDaysModal/creditDaysModal.dart';
import '../../../url/url.dart';


class GettCreditDaysAPi{
  static String? cardCode;
  static String? date;
  static Future<CreaditDaysModal> getGlobalData() async {
    // print("date: $date");
    // print("carcode: $cardCode");
    try {
    final response = await http.get(
        Uri.parse(
      URL.sapUrl+"/SQLQueries('CreditDays')/List?CardCode='$cardCode'&TodayDt='$date'",//&\$filter= DocumentStatus eq 'bost_Open'
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ AppConstant.sapSessionID.toString(),
        'Prefer': 'odata.maxpagesize=20'
        // ${GetValues.maximumfetchValue}'
        },
      );
       log('CreditDays.statusCode::${response.statusCode}');
      log('CreditDays::${response.body}');
      if (response.statusCode == 200) {
        log("GettCreditDaysAPi:: "+json.decode(response.body).toString());
        return CreaditDaysModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
         print("GettCreditDaysAPi:: "+json.decode(response.body).toString());
           print(response.statusCode);
        throw Exception('Restart the app or contact the admin!!..');
   // return ApprovalsOrdersModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
     // return ApprovalsOrdersModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
