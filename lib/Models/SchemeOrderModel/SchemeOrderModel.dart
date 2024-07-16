// ignore_for_file: prefer_final_locals, omit_local_variable_types, prefer_single_quotes, prefer_interpolation_to_compose_strings

import 'dart:developer';

class SchemeOrderModal {
  SchemeOrderModal({required this.status, required this.message, this.saleOrder, required this.statuscode, this.exception});

  bool? status;
  String? message;
  List<SchemeOrderModalData>? saleOrder;
  String? exception;
  int statuscode;

  factory SchemeOrderModal.fromJson(Map<String, dynamic> jsons, int Statuscode) {
    if (jsons['saleOrder'] != null) {
      // log("stcode1"+Statuscode.toString());
      var list = jsons['saleOrder'] as List;
      //jsonDecode(jsons['data'] as String) as List; //jsonDecode
      // print(list);
      List<SchemeOrderModalData> dataList = list.map((dynamic enquiries) => SchemeOrderModalData.fromJson(enquiries)).toList();
      // print(dataList[0]);
      return SchemeOrderModal(saleOrder: dataList, message: jsons['message'].toString(), status: jsons['status'] as bool, statuscode: Statuscode);
    } else {
      log("stcode" + Statuscode.toString());
      return SchemeOrderModal(message: jsons['message'].toString(), status: jsons['status'] as bool, saleOrder: null, statuscode: Statuscode);
    }
  }
  factory SchemeOrderModal.issue(int statuscode) {
    return SchemeOrderModal(status: null, message: null, saleOrder: null, statuscode: statuscode);
  }

  factory SchemeOrderModal.exception(String e, int statuscode) {
    return SchemeOrderModal(status: null, message: null, exception: e, statuscode: statuscode, saleOrder: null);
  }
}

class SchemeOrderModalData {
  int docEntry;
  String schemeEntry;
  int lineNum;

  double discPer;
  double discVal;

  SchemeOrderModalData({required this.docEntry, required this.schemeEntry, required this.lineNum, required this.discPer, required this.discVal});

  factory SchemeOrderModalData.fromJson(dynamic jsons) {
    return SchemeOrderModalData(
      docEntry: int.parse(jsons['docEntry'].toString()),
      schemeEntry: jsons['schemeEntry'].toString(),
      lineNum: int.parse(jsons['lineNum'].toString()),
      discPer: double.parse(jsons['discPer'].toString()),
      discVal: double.parse(jsons['discVal'].toString()),
    );
  }
}

// for api

class SalesOrderScheme {
  String lineno;
  String ItemCode;
  String Quantity;
  String PriceBefDi;
  String UCartons;
  String balance;
  String customer;
  String Warehouse;

  SalesOrderScheme({required this.ItemCode, required this.PriceBefDi, required this.Quantity, required this.UCartons, required this.lineno, required this.balance, required this.customer, required this.Warehouse});

  Map<String, dynamic> toMap() {
    // log("ZZZZZZZZZZZZZZZZ");
    // log("LineNum:$lineno");
    // log("ItemCode::$ItemCode");
    // log("Quantit:$Quantity");
    // log("balance:$balance");
    // log("PriceBefDi:$PriceBefDi");
    // log("U_Cartons:$UCartons");
    // log("Customer:$customer");

    Map<String, String> map = {
      "LineNum": lineno,
      "ItemCode": ItemCode,
      "Quantity": Quantity,
      "PriceBefDi": PriceBefDi,
      "U_Cartons": UCartons,
      "Balance": balance,
      "Customer": customer,
      "Warehouse": Warehouse,
    };
    return map;
  }

  //   Map<String, dynamic> tojson() {
  //   Map<String, String> map = {
  //     "ItemCode": itemCode,
  //     "ItemDescription": itemName,
  //     "DiscountPercent": discounpercent.toString(),
  //     "TaxCode": taxCode.toString(),
  //     "Quantity": qty.toString(),
  //     "UnitPrice": price.toString(),
  //     "Currency": "TZS",
  //     "ShipToCode": LogisticOrderState.shipto.toString(),
  //     "WarehouseCode": GetValues.branch.toString(),
  //   };
  //   return map;
  // }

  //  "LineNum": "1",
  //           "ItemCode": "1000002D",
  //           "Quantity": "1000.000000",
  //           "PriceBefDi": "18000.00000",
  //           "UCartons": "0"
}
