// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, unnecessary_string_interpolations, unused_local_variable, prefer_final_locals, omit_local_variable_types

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/url/url.dart';

import '../../Models/Service Model/CustomerModel/AddressPachModel.dart';
import 'CreatecustPostApi copy.dart';

class PostAddressCreateAPi {
  // static List<NewCutomeAdrsModel>? newCutomerModel;
  static NewAddressModel? newCutomerAddModel;
  static Future<CreatePatchModel> getGlobalData(String? cardCode) async {
    print("AppConstant.sessionID vv:::${AppConstant.sapSessionID.toString()}");
    try {
      //http://102.69.167.106:50001/b1s/v1 URL.sapUrl +
      log(URL.sapUrl + "/BusinessPartners('$cardCode')");
      final response = await http.patch(
          Uri.parse(URL.sapUrl + "/BusinessPartners('$cardCode')"),
          headers: {
            'content-type': 'application/json',
            "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString()
          },
          body: json.encode({
            "BPAddresses":
                newCutomerAddModel!.newModel!.map((e) => e.tojson()).toList(),
          }));

      log('response code:::' + response.statusCode.toString());
      log("response.body::" + response.body.toString());

      log(json.encode({
        "BPAddresses": newCutomerAddModel!.newModel!
            .map(
              (e) => e.tojson(),
            )
            .toList()
      }));

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log("Success");
        return CreatePatchModel.fromJson(response.statusCode);
      } else {
        print("Exception11");
        // throw Exception("Error!!...");
        return CreatePatchModel.fromJson2(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("Exception22::$e");

      //  throw Exception("Exception: $e");
      return CreatePatchModel.issue(e.toString(), 500);
    }
  }
}

class NewAddressModel {
  List<NewCutomeAdrsModel>? newModel;
  NewAddressModel({
    this.newModel,
  });
}
