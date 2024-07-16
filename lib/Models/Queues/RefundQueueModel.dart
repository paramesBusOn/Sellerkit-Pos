import 'dart:convert';
import '../../DBModel/RefundLine.dart';
import '../../DBModel/RefundPayment.dart';
import '../../DBModel/Refundheader.dart';

class RefundQueue {
  int? TypeCode;
  String? TypeName;
  List<RefundHeaderTDB>? refundHeader;
  List<RefundLineTDB>? refundLine;
  List<RefundPayTDB>? refundPayDB;

  RefundQueue(
      {required this.TypeCode,
      required this.TypeName,
      required this.refundHeader,
      required this.refundLine,
      required this.refundPayDB});
  factory RefundQueue.fromjson(Map<String, dynamic> resp) {
    var header = jsonDecode(resp['RefundHeader'].toString()) as List;
    var line = jsonDecode(resp['RefundLine'].toString()) as List;
    var pay = jsonDecode(resp['RefundPay'].toString()) as List;

    List<RefundHeaderTDB> listhead =
        header.map((e) => RefundHeaderTDB.fromjson(e)).toList();

    List<RefundLineTDB> listline =
        line.map((e) => RefundLineTDB.fromjson(e)).toList();

    List<RefundPayTDB> paylist =
        pay.map((e) => RefundPayTDB.fromjson(e)).toList();

    return RefundQueue(
        TypeCode: resp['TypeCode'],
        TypeName: resp['TypeName'],
        refundHeader: listhead,
        refundLine: listline,
        refundPayDB: paylist);
  }
}
