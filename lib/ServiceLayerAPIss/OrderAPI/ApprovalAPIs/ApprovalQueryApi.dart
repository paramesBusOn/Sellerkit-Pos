// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas, leading_newlines_in_multiline_strings, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';


import '../../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/DynamicAproval.dart';
import '../../../url/url.dart';


class GetDyApprovalAPi {
  static String? slpCode;
  static String? dbname;

  static Future<ApprovaldyModel> getGlobalData(String fromDate,String toDate) async {
    try {
      final response = await http.post(
        Uri.parse(URL.dynamicUrl),
        headers: {
          'content-type': 'application/json',
          },
         body: json.encode({
              "constr": "Server=INSIGNIAC03313;Database='$dbname';User Id=sa; Password=Insignia@2021#;",
              "query": '''Select T0.[WddCode],T0.[WtmCode],T0.[ObjType],T0.[CurrStep],T0.[CreateDate], T0.[CreateTime],T0.[DraftEntry],
              T2.[USER_CODE] [FromUser], T3.[DocNum], T3.[DocDate] ,T3.[CardCode], T3.[CardName] From [OWDD] T0 Inner Join [WST1] T1 on 
              T0.[CurrStep] = T1.[WstCode] Inner Join [OUSR] T2 on T2.[USERID] = T0.[UserSign] Inner Join [ODRF] T3 on 
              T3.[DocEntry] = T0.[DraftEntry] Where T0.[Status] = 'Y' and T3.[DocStatus] <> 'C' And T0.[ObjType] = 17 and 
              T3.[SlpCode] = ${slpCode} and t3.DocDate  between '$fromDate' and '$toDate' order by T3.[DocDate] desc''', //'${GetValues.slpCode}'
          })
      );
     
      log(json.encode({
              "constr": "Server=INSIGNIAC03313;Database='$dbname';User Id=sa; Password=Insignia@2021#;",
          "query":'''Select T0.[WddCode],T0.[WtmCode],T0.[ObjType],T0.[CurrStep],T0.[CreateDate], T0.[CreateTime],T0.[DraftEntry],
          T2.[USER_CODE] [FromUser], T3.[DocNum], T3.[DocDate] ,T3.[CardCode], T3.[CardName] From [OWDD] T0 Inner Join [WST1] T1 on 
          T0.[CurrStep] = T1.[WstCode] Inner Join [OUSR] T2 on T2.[USERID] = T0.[UserSign] Inner Join [ODRF] T3 on 
          T3.[DocEntry] = T0.[DraftEntry] Where T0.[Status] = 'Y' and T3.[DocStatus] <> 'C' And T0.[ObjType] = 17 and 
          T3.[SlpCode] = ${slpCode} and t3.DocDate  between '$fromDate' and '$toDate' order by T3.[DocDate] desc''' 
   }));
      log("aprovals details: " + json.decode(response.body).toString());
      log("Approvals statusCode::"+response.statusCode.toString());
        return ApprovaldyModel.fromJson( response.body,response.statusCode);
  
        // throw Exception("Error!!...");
    } catch (e) {
      //  throw Exception("Exception: $e");
      return ApprovaldyModel.fromJson(e.toString(),500);
    }
  }
}
