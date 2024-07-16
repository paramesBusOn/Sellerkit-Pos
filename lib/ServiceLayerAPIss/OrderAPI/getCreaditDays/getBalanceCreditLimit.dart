// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../../Models/ServiceLayerModel/SapSalesOrderModel/CreditDaysModal/BalanceCredit.dart';
import '../../../url/url.dart';



class GetBalanceCreditAPi{
  static String? cardCode;
  static Future<BalanceCreaditModal> getGlobalData() async {
    log(" AppConstant.sessionID.toString(): ${AppConstant.sapSessionID.toString()}");
    try {
    final response = await http.get(
        Uri.parse(
      URL.sapUrl+"/SQLQueries('CreditLimit')/List?CardCode='$cardCode'",//&\$filter= DocumentStatus eq 'bost_Open'
        
      ),
        headers: {
        "content-type": "application/json",
        "cookie": 'B1SESSION='+ AppConstant.sapSessionID.toString(),
        'Prefer': 'odata.maxpagesize=20'//${GetValues.maximumfetchValue}'
        },
      );
      log('CreditLimit.statusCode::${response.statusCode}');
      log('CreditLimit.::${response.body}');

      if (response.statusCode == 200) {
        print("GetBalanceCreditAPi:: "+json.decode(response.body).toString());
        return BalanceCreaditModal.fromJson(json.decode(response.body)as Map<String,dynamic>);
      } else {
         print(json.decode(response.body));
           print(response.statusCode);
        // throw Exception('Restart the app or contact the admin!!..');
   return BalanceCreaditModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      // throw Exception(e);
     return BalanceCreaditModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
