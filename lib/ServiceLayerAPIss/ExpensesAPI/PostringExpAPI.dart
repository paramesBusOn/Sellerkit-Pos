// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/SAPInwardModel/InwardPostList.dart';
import '../../Models/ServiceLayerModel/SAPOutwardModel/StockOutPostingMidel.dart';

import '../../Models/ServiceLayerModel/SapExpensModel/ExpePostingList.dart';
import '../../Models/ServiceLayerModel/SapExpensModel/SapExpensesModell.dart';
import '../../Models/ServiceLayerModel/SapInwardModel/SapInwardModel.dart';
import '../../url/url.dart';

class PostExpenseAPi {
  static String? DocType;

  static String? CashAccount;
  static String? Remarks;
  static String? docDate;
  static String? CashSum;
  static List<ExpenseListMoel>? paymentAccounts;
  static Future<SapExpenseModel> getGlobalData(String? deviceTransID) async {
    try {
      log("Step11");
      final response =
          await http.post(Uri.parse(URL.sapUrl + "/VendorPayments"),
              headers: {
                "content-type": "application/json",
                "cookie": 'B1SESSION=' + AppConstant.sapSessionID,
                // "Prefer":"return-no-content"
              },
              body: json.encode({
                "DocDate": "$docDate",
                "DocType": "$DocType",
                "CashAccount": "$CashAccount",
                "Remarks": "$Remarks",
                "CashSum": "$CashSum",
                "PaymentAccounts":
                    paymentAccounts!.map((e) => e.tojson()).toList(),
              }));
      log(json.encode({
        "DocDate": "$docDate",
        "DocType": "$DocType",
        "CashAccount": "$CashAccount",
        "Remarks": "$Remarks",
        "CashSum": "$CashSum",
        "PaymentAccounts": paymentAccounts!.map((e) => e.tojson()).toList(),
      }));
      log("PostRequestAPi stcode11 ::" + response.statusCode.toString());

      log("PostRequestAPi: " + json.decode(response.body).toString());

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log("Step22");

        return SapExpenseModel.fromJson(
            json.decode(response.body) , response.statusCode);
      } else {
        log("PostRequestAPi: " + json.decode(response.body).toString());
        log("PostRequestAPi stcode22 ::" + response.statusCode.toString());
        // throw Exception("Error");
        return SapExpenseModel.issue(
            json.decode(response.body)as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('Exception PostRequestAPi: $e');
      throw Exception('Exception PostRequestAPi: $e');
      // return SapInwardModel.issue(json.decode('Restart the app or contact the admin!!..'), 500);
    }
  }
}
