import 'dart:convert';

import 'package:posproject/DBModel/Receipt.dart';

import '../../DBModel/ReceiptLine2.dart';
import '../../DBModel/RecieptLine1.dart';

class ReceiptQueue {
  int? TypeCode;
  String? TypeName;
  List<ReceiptHeaderTDB>? salesHeader;
  List<ReceiptLineTDB>? salesLine;
  List<ReceiptLine2TDB>? salesPayDB;

  ReceiptQueue(
      {required this.TypeCode,
      required this.TypeName,
      required this.salesHeader,
      required this.salesLine,
      required this.salesPayDB});
  factory ReceiptQueue.fromjson(Map<String, dynamic> resp) {
    var header = jsonDecode(resp['ReceiptHeader'].toString()) as List;
    var line = jsonDecode(resp['ReceiptLine'].toString()) as List;
    var pay = jsonDecode(resp['ReceiptPay'].toString()) as List;

    List<ReceiptHeaderTDB> listhead =
        header.map((e) => ReceiptHeaderTDB.fromjson(e)).toList();

    List<ReceiptLineTDB> listline =
        line.map((e) => ReceiptLineTDB.fromjson(e)).toList();

    List<ReceiptLine2TDB> paylist =
        pay.map((e) => ReceiptLine2TDB.fromjson(e)).toList();

    return ReceiptQueue(
        TypeCode: resp['TypeCode'],
        TypeName: resp['TypeName'],
        salesHeader: listhead,
        salesLine: listline,
        salesPayDB: paylist);
  }
}
