
import 'dart:convert';

import '../SAPInwardModel/InwardPostList.dart';
//     "AccountCode": "_SYS00000000698",
class PostingInvoiceLines {
  String itemName;
  String? ItemCode;
  String? Quantity;
  String? TaxCode;
  String? UnitPrice;
  String? Price;
  String? DiscPrcnt;
  String? WhsCode;
  String? Currency; //"TZS";
  String? basedocentry;
  String? baseline;
//  String accountCode;
  int? BaseType;
    List<Invbatch> batchNumbers;
  // String? fromWarehouse;
  // String? toWarehouse;

  PostingInvoiceLines(
      {required this.itemName,
      // required this.accountCode,
      this.Currency,
      this.DiscPrcnt,
      this.ItemCode,
      this.Price,
      this.Quantity,
      this.TaxCode,
      this.UnitPrice,
      this.WhsCode,
     required this.batchNumbers,
      // this.fromWarehouse,
      // this.toWarehouse,
      this.BaseType,
      this.basedocentry,
      this.baseline});
  Map<String, dynamic> tojson() =>{

      "ItemCode": ItemCode.toString(),
      "ItemDescription": itemName,
      "DiscountPercent": DiscPrcnt.toString(),
      "TaxCode": TaxCode.toString(),
      "Quantity": Quantity.toString(),
      "Price": UnitPrice.toString(),
      "WarehouseCode":WhsCode,
      "BatchNumbers": List<dynamic>.from(batchNumbers.map((x) => x.toJson2())),
      // List<Invbatch>.from(
      //       json["BatchNumbers"].map((x) => Invbatch.fromJson(x))),
      "Currency": "TZS",
 
  };
}
class Invbatch {
  double quantity;
  String batchNumberProperty;

  Invbatch({
    // required this.baseLineNumber,
    required this.quantity,
    required this.batchNumberProperty,
  });

  factory Invbatch.fromJson(Map<String, dynamic> json) => Invbatch(
        // baseLineNumber: json["BaseLineNumber"],
        quantity: json["Quantity"],
        batchNumberProperty: json["BatchNumbers"],
      );

  Map<String, dynamic> toJson2() => {
        // "BaseLineNumber": baseLineNumber,
        "Quantity": quantity,
        "BatchNumber": batchNumberProperty,
      };
}
