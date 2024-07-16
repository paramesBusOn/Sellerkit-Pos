//GET https://localhost:50000/b1s/v1/Quotations(123)
//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/Service Model/CustomerModel/AddressPachModel.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotStatusModel.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';

class SerlaySalesQuoPatchAPI {
  static String? sessionID;
  static String? cardCodePost;
  static List<QuatationLines>? docLineQout;
  static String? docDate;
  static String? dueDate;
  static String? remarks;
  static String? deviceTransID;

  static Future<CreatePatchModel> getData(String sapDocEntry) async {
    // int? ressCode = 500;
    log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("sapDocNum sapDocNum::$sapDocEntry");
      final response = await http.patch(
        Uri.parse(
            'http://102.69.167.106:50001/b1s/v1/Quotations($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
        body: json.encode({
          "CardCode": "$cardCodePost",
          "DocumentStatus": "bost_Open",
          "DocDate": "$docDate",
          "DocDueDate": "$dueDate",
          "Comments": "$remarks",
          "U_DeviceTransID": deviceTransID,
          "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
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
              "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
            }),
      );

      // ressCode = response.statusCode;
      log("SalesQuopatch stscode::${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return CreatePatchModel.fromJson(
        response.statusCode);
      } else {
        print("SalesQuo Exception: Error");
        // throw Exception("Errorrrrr");
        return CreatePatchModel.fromJson2(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("Exception:: $e");
      // throw Exception("Error");
      return CreatePatchModel.issue("Exception", 500);
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}