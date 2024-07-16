import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Models/Service Model/ProductMasterModel.dart';

class ProductMasterApi {
  static Future<ProductMasterModel> getData(String branch, String terminal) async {
    // int resCode = 500;
    log("MMMMnnnnvvvMMMMMMM");

    try {
      log("http://102.69.167.106:1888/api/POSMaster/ProductMaster/$branch/$terminal");
      final response = await http.get(
        Uri.parse('http://102.69.167.106:1888/api/POSMaster/ProductMaster/$branch/$terminal'),
        headers: {"content-type": "application/json", "Connection": "keep-alive"},
      );
      log("MMMMMMMMMMMM");
      log("prooofff::::${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return ProductMasterModel.fromJson(json.decode(response.body), response.statusCode);
      } else {
        print("Error PM: ${json.decode(response.body)}");
        throw Exception("Error");
        //  return ProductMasterModel.error('Error', resCode);
      }
    } catch (e) {
      print("Exception PM: $e");
      throw Exception(e.toString());
      //  return ProductMasterModel.error(e.toString(), resCode);
    }
  }
}
