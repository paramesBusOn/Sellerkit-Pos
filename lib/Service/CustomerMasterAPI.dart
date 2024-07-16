import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Constant/AppConstant.dart';
import '../Models/Service Model/CustomerMasterModel.dart';


class CustomerMasterApi {
  static Future<CustomerModel> getData() async {
    // int resCode = 500;

    try {//http://102.69.167.106:1888/api/POSMaster/CustomerMaster/ARSFG/T1
      final response = await http.get(
        Uri.parse('http://102.69.167.106:1888/api/POSMaster/CustomerMaster/${AppConstant.branch}/${AppConstant.terminal}'),
        headers: {
          "content-type": "application/json",
        },
      );
      // resCode = response.statusCode;
      log(response.statusCode.toString());
      // log("sk_inventory_master_data${json.decode(response.body)}");
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return CustomerModel.fromJson(json.decode(response.body), response.statusCode);
      } else {
        log("Error CM: ${json.decode(response.body)}");
        throw Exception("Error");
        // return CustomerModel.error('Error', resCode);
      }
    } catch (e) {
      log("Exception CM: $e");
       throw Exception(e.toString());
      // return CustomerModel.error(e.toString(), resCode);
    }
  }
}
