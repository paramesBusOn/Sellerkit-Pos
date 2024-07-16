// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, noop_primitive_operations, unnecessary_statements, unnecessary_parenthesis

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Models/ServiceLayerModel/SapInvoiceModel/InvPostingLineModel.dart';

import '../../Models/ServiceLayerModel/SapSalesReturnModel/ReturnCreditListModel.dart';
import '../../Models/ServiceLayerModel/SapSalesReturnModel/ReturnPostingListModel.dart';
import '../../url/url.dart';

class SalesReurnPostAPi {
  static String? cardCodePost;
  static List<ReturnPostingtLine>? docLineQout;
  static String? docDate;
  static String? dueDate;
  static String? remarks;
  static void method(String? deviceTransID) {
    final data = json.encode({
      "CardCode": "$cardCodePost",
      "DocumentStatus": "bost_Open",
      "DocDate": "$docDate",
      "DocDueDate": "$dueDate",
      "Comments": "$remarks",
      "U_DeviceTransID": deviceTransID,
      "DocumentLines": docLineQout!.map((e) => e.toJson3()).toList(),
    });
    //  log("post q data : "+data.toString());
  }

  static Future<SapReturnCreditModel> getGlobalData(
      String? deviceTransID) async {
    try {
      log(URL.sapUrl + "/CreditNotes");
      final response = await http.post(
        Uri.parse(
          // URL.url+
          URL.sapUrl + "/CreditNotes",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
          // "Prefer":"return-no-content"
        },
        body: json.encode({
          "CardCode": "$cardCodePost",
          "DocumentStatus": "bost_Open",
          "DocDate": "$docDate",
          "DocDueDate": "$dueDate",
          "Comments": "$remarks",
          "U_DeviceTransID": deviceTransID,
          "DocumentLines": docLineQout!.map((e) => e.toJson3()).toList(),
        }),
      );

      log(
        "datatatat: " +
            json.encode({
              "CardCode": "$cardCodePost",
              "DocumentStatus": "bost_Open",
              "DocDate": "$docDate",
              "DocDueDate": "$dueDate",
              "Comments": "$remarks",
              "U_DeviceTransID": deviceTransID,
              "DocumentLines": docLineQout!.map((e) => e.toJson3()).toList(),
            }),
      );
      log("Responce: " + (json.decode(response.body).toString()));
      log("statucCode: " + response.statusCode.toString());
      // log("Quotations post: "+json.decode(response.body.toString()).toString());
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        final dynamic data = json.decode(response.body.toString());
        return SapReturnCreditModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // throw Exception('Restart the app or contact the admin!!..');
        return SapReturnCreditModel.issue(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
      // return Servicrlayerquotation.issue(
      //     'Restart the app or contact the admin!!..\n');
    }
  }
}
