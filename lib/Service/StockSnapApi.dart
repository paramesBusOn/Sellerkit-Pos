import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Constant/AppConstant.dart';
import '../Models/Service Model/StockSnapModelApi.dart';

class StockSnapModelApi {
  static Future<StocksnapModel> getData() async {
    // int resCode = 500;

    try {
      //http://102.69.167.106:1888/api/POSMaster/ItemMaster/ARSFG/T1
      final response = await http.get(
        Uri.parse('http://102.69.167.106:1888/api/POSMaster/ItemMaster/${AppConstant.branch}/${AppConstant.terminal}'),
        headers: {
          "content-type": "application/json",
        },
      );
      // resCode = response.statusCode;
      print(response.statusCode.toString());
      // log("sk_inventory_master_data${json.decode(response.body)}");
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return StocksnapModel.fromJson(json.decode(response.body), response.statusCode);
      } else {
        log("Error SS: ${json.decode(response.body)}");
        throw Exception("Error");
        // return StocksnapModel.error('Error', resCode);
      }
    } catch (e) {
      log("Exception SS: $e");
      throw Exception(e.toString());
      // return StocksnapModel.error(e.toString(), resCode);
    }
  }
}
