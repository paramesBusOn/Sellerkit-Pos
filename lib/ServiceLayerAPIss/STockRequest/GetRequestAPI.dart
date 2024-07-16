//GET https://localhost:50000/b1s/v1/Quotations(123)
//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/SAPStockRequest/SapStkRequestModel.dart';

import '../../url/url.dart';

class SerlayStkRequestAPI {
  static Future<SapStkrequestModel> getData(String sapDocEntry) async {
    // int? ressCode = 500;
    log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("sapDocNum sapDocNum::$sapDocEntry");
      final response = await http.get(
        Uri.parse('${URL.sapUrl}/InventoryTransferRequests($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );
      // ressCode = response.statusCode;
      log("request stscode::${response.statusCode}");
      log("request::${json.decode(response.body)}");

      if (response.statusCode == 200) {
        return SapStkrequestModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("request Exception: Error");
        // throw Exception("Errorrrrr");
        return SapStkrequestModel.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("Exception:: $e");
      throw Exception("Error");
      // return AccountBalanceModel.exception(e.toString(), ressCode);

    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}