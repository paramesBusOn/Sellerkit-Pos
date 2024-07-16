// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Models/Service%20Model/SeriesModel.dart';
import 'package:posproject/url/url.dart';


class GetSeriesApiAPi {
  static Future<SeriesModel> getGlobalData() async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr": "Server=INSIGNIAC03313;Database=MRP T1;User Id=sa; Password=Insignia@2021#;",
              "query": "Select Series, SeriesName From nnm1 Where ObjectCode = '2' And DocSubType = 'C'",
          })
      );
     
      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
       print("SERIES: " + json.decode(response.body).toString());
       print(response.statusCode);
      if (response.statusCode == 200) {
        return SeriesModel.fromJson(response.body,response.statusCode);
      } else {
        print("Exception: Error");
        return SeriesModel.fromJson( response.body,response.statusCode);
      }
    } catch (e) {
      print("Exception: $e");
      //  throw Exception("Exception: $e");
      return SeriesModel.fromJson(e.toString(),500);
    }
  }
}
