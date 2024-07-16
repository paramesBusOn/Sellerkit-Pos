// ignore_for_file: prefer_single_quotes, omit_local_variable_types, prefer_final_locals, prefer_interpolation_to_compose_Strings

class SalesQuotStatus {
  SalesQuotStatus(
      {this.statusCode,
      this.error,
      this.erros,
      this.docEntry,
      this.documentNum});
  int? statusCode;
  Error? error;
  String? erros;
  int? docEntry;
  int? documentNum;
  factory SalesQuotStatus.fromJson(int statusCode) {
    return SalesQuotStatus(
      statusCode: statusCode,
    );
  }
  factory SalesQuotStatus.errorIN(
    Map<String, dynamic> json,
    int statusCode,
  ) {
    return SalesQuotStatus(
      statusCode: statusCode,
      error: Error.fromJson(json['error']),
    );
  }
  factory SalesQuotStatus.issue(String e) {
    return SalesQuotStatus(
      erros: e,
    );
  }
}

class Error {
  int? code;
  Message? message;
  Error({
    this.code,
    this.message,
  });

  factory Error.fromJson(dynamic jsons) {
    return Error(
      code: jsons['code'] as int,
      message: Message.fromJson(jsons['message']),
    );
  }
}

class Message {
  String? lang;
  String? value;
  Message({
    this.lang,
    this.value,
  });

  factory Message.fromJson(dynamic jsons) {
    return Message(
      //  groupCode: jsons['GroupCode'] as int,
      lang: jsons['lang'] as String,
      value: jsons['value'] as String,
    );
  }
}

class SAP_Quatation {
  int? DocEntry;
  int? DocNum;
  String? CardCode;
  String? DocDueDate;
  List<QuatationLines>? DocumentLines;
  String? CardName;
  String? Comments;
  String? U_TransID;
  String? U_PBranch;
  String? U_Terminal;
  String? U_OrderDate;
  String? U_Order_Type;
  String? U_GP_Approval;
  String? U_Received_Time;
  String? DocStatus;
  String? SlpCode;
  String? DocDate;
  String? NumAtCard;
  String? Series;
  SAP_Quatation({
    required this.CardCode,
    required this.CardName,
    required this.Comments,
    required this.DocDate,
    required this.DocDueDate,
    required this.DocEntry,
    required this.DocNum,
    required this.DocStatus,
    required this.DocumentLines,
    required this.NumAtCard,
    required this.Series,
    required this.SlpCode,
    required this.U_GP_Approval,
    required this.U_OrderDate,
    required this.U_Order_Type,
    required this.U_PBranch,
    required this.U_Received_Time,
    required this.U_Terminal,
    required this.U_TransID,
  });
}

class QuatationLines {
  String itemName;
  String? ItemCode;
  String? Quantity;
  String? TaxCode;
  String? UnitPrice;
  String? Price;
  String? DiscPrcnt;
  String? WhsCode;
  String? Currency; //"TZS";
  int? basedocentry;
  int? baseline;
  int? BaseType;
  // String? fromWarehouse;
  // String? toWarehouse;

  QuatationLines(
      {required this.itemName,
      this.Currency,
      this.DiscPrcnt,
      this.ItemCode,
      this.Price,
      this.Quantity,
      this.TaxCode,
      this.UnitPrice,
      this.WhsCode,
      // this.fromWarehouse,
      // this.toWarehouse,
      this.BaseType,
      this.basedocentry,
      this.baseline});
  Map<String, dynamic> tojson() {
    Map<String, String> map = {
      "ItemCode": ItemCode.toString(),
      "ItemDescription": itemName,
      "DiscountPercent": DiscPrcnt.toString(),
      "TaxCode": TaxCode.toString(),
      "Quantity": Quantity.toString(),
      "UnitPrice": UnitPrice.toString(),
      "Currency": "TZS",
      // "ShipToCode": LogisticPageState.shipto.toString(),
      // "valueAF": valueAF.toString(),
      // "WarehouseCode": WhsCode.toString(),
    };
    return map;
  }
}

class AddItem {
  String itemName;
  String itemCode;
  double? price;
  int? qty;
  double? discount;
  double? total;
  double? tax;
  double? taxPer;
  String? valuechoosed;
  String? taxCode;
  double? discounpercent;
  String? shipToCode;
  double? valueAF;
  int? carton;
  int? lineNo;
  double? U_Pack_Size;
  int? U_Tins_Per_Box;
  AddItem(
      {required this.itemCode,
      required this.itemName,
      required this.price,
      required this.discount,
      required this.qty,
      required this.total,
      required this.tax,
      required this.valuechoosed,
      required this.taxCode,
      required this.discounpercent,
      required this.taxPer,
      this.shipToCode,
      this.valueAF,
      this.lineNo,
      this.carton,
      this.U_Pack_Size,
      this.U_Tins_Per_Box});

  Map<String, dynamic> tojson() {
    Map<String, String> map = {
      "ItemCode": itemCode,
      "ItemDescription": itemName,
      "DiscountPercent": discounpercent.toString(),
      "TaxCode": taxCode.toString(),
      "Quantity": qty.toString(),
      "UnitPrice": price.toString(),
      "Currency": "TZS",
      // "ShipToCode": LogisticPageState.shipto.toString(),
      "valueAF": valueAF.toString(),
      // "WarehouseCode": GetValues.branch.toString(),
    };
    return map;
  }
}

// class postData{
//   String docDate;
//   String dueDate;

// }
