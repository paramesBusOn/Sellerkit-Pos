import 'dart:convert';
import 'dart:developer';

class PettyCashModel {
  bool? status;
  String? message;
  List<PettyCashData>? pettyCashList;
  String? exception;
  int statuscode;
  PettyCashModel({required this.status, required this.message, this.pettyCashList, required this.statuscode, this.exception});

  factory PettyCashModel.fromJson(Map<String, dynamic> jsons, int Statuscode) {
    if (jsons['message'] == "Success") {
      var list = jsonDecode(jsons['data'] as String) as List;
      List<PettyCashData> dataList = list.map((data) => PettyCashData.fromJson(data)).toList();

      return PettyCashModel(
          pettyCashList: dataList,
          //
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: Statuscode);
    } else {
      log("stcode::$Statuscode");
      return PettyCashModel(
          message: jsons['message'].toString(),
          //
          status: jsons['status'] as bool,
          pettyCashList: null,
          statuscode: Statuscode);
    }
  }
  factory PettyCashModel.exception(String jsons, int stcode) {
    return PettyCashModel(
        pettyCashList: null,
        //
        message: null,
        status: null,
        statuscode: stcode,
        exception: jsons);
  }
}

class PettyCashData {
  String? acctCode;
  String? acctName;
  String? currTotal;
  String? formatCode;
  String? whsCode;

  PettyCashData({
    required this.whsCode,
    required this.acctCode,
    required this.acctName,
    required this.currTotal,
    required this.formatCode,
  });
//{"status":true,"message":"Success","data":"[{\"AcctCode\":\"_SYS00000000362\",\"AcctName\":\"Petty Cash (AR)\",\"CurrTotal\":0.756840,\"FormatCode\":\"114000602\",\"WhsCode\":\"ARSFG\"}]"}
  factory PettyCashData.fromJson(Map<String, dynamic> jsons) => PettyCashData(
        // autoId: int.parse(jsons['autoId'].toString()),
        acctCode: jsons['AcctCode'].toString(),
        acctName: jsons['AcctName'].toString(),
        formatCode: jsons['FormatCode'].toString(),
        currTotal: jsons['CurrTotal'].toString(),
        whsCode: jsons['WhsCode'].toString(),
      );
}
