// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/SAPOutwardModel/StockOutPostingMidel.dart';
import '../../Models/ServiceLayerModel/SAPOutwardModel/sapOutwardmodel.dart';
import '../../url/url.dart';

class PostStkOutwardAPi {
  static String? fromWarehouse;
  static String? toWarehouse;
  static String? comments;

  static String? docDate;
  static String? dueDate;
  static List<StockOutLineModel>? stockTransferLines;
  static void method(String? deviceCode) {
    final dat = json.encode({
      "DocumentStatus": "bost_Open",
      "DocDate": "$docDate",
      "DueDate": "$dueDate",
      "FromWarehouse": "$fromWarehouse",
      "ToWarehouse": "$toWarehouse",
      "Comments": "$comments",
      "StockTransferLines": stockTransferLines!.map((e) => e.toJson()).toList(),
    });
  }

  static Future<SapOutwardModel> getGlobalData(String? deviceTransID) async {
    try {
      log("Step11");
      final response =
          await http.post(Uri.parse(URL.sapUrl + "/StockTransfers"),
              headers: {
                "content-type": "application/json",
                "cookie": 'B1SESSION=' + AppConstant.sapSessionID,
                // "Prefer":"return-no-content"
              },
              body: json.encode({
                "DocumentStatus": "bost_Open",
                "DocDate": "$docDate",
                "DueDate": "$dueDate",
                "FromWarehouse": "$fromWarehouse",
                "ToWarehouse": "$toWarehouse",
                "Comments": "$comments",
                "U_DeviceTransID": deviceTransID,
                "StockTransferLines":
                    stockTransferLines!.map((e) => e.toJson()).toList(),
              }));
      log(json.encode({
        "DocumentStatus": "bost_Open",
        "DocDate": "$docDate",
        "DueDate": "$dueDate",
        "FromWarehouse": "$fromWarehouse",
        "ToWarehouse": "$toWarehouse",
        "Comments": "$comments",
        "StockTransferLines":
            stockTransferLines!.map((e) => e.toJson()).toList(),
      }));
      log("PostRequestAPi stcode11 ::" + response.statusCode.toString());

      log("PostRequestAPi: " + json.decode(response.body).toString());

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log("Step22");

        return SapOutwardModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        log("PostRequestAPi: " + json.decode(response.body).toString());
        log("PostRequestAPi stcode22 ::" + response.statusCode.toString());
        // throw Exception("Error");
        return SapOutwardModel.issue(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('Exception PostRequestAPi: $e');
      throw Exception('Exception PostRequestAPi: $e');
      // return SapOutwardModel.issue(json.decode('Restart the app or contact the admin!!..'), 500);
    }
  }
}
