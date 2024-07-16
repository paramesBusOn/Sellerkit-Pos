import 'dart:convert';
import '../../DBModel/SalesOrderHeader.dart';
import '../../DBModel/SalesOrderLineDB.dart';
import '../../DBModel/SalesOrderPay.dart';

class SalesOrderQueue {
  int? TypeCode;
  String ? TypeName;
  List<SalesOrderHeaderModelDB>? salesOrderHeader; 
  List<SalesOrderLineTDB>? salesOrderLine;
  List<SalesOrderPayTDB>? salesOrderPayDB;

  SalesOrderQueue({
    required this.TypeCode,
    required this.TypeName,
    required this.salesOrderHeader,
    required this.salesOrderLine,
    required this.salesOrderPayDB
  });

  factory SalesOrderQueue.fromjson(Map<String, dynamic> resp) {
     var header = jsonDecode(resp['SalesOrderHeader'].toString()) as List;
     var line = jsonDecode(resp['SalesOrderLine'].toString()) as List;
     var pay = jsonDecode(resp['SalesOrderPay'].toString()) as List;



     List<SalesOrderHeaderModelDB> listhead =  header.map((e) => 
     SalesOrderHeaderModelDB .fromjson(e)).toList();

     
     List<SalesOrderLineTDB> listline=  line.map((e) => 
     SalesOrderLineTDB .fromjson(e)).toList();

     List<SalesOrderPayTDB> paylist=  pay.map((e) => 
     SalesOrderPayTDB .fromjson(e)).toList();

      return SalesOrderQueue(
          TypeCode: resp['TypeCode'],
          TypeName: resp['TypeName'],
          salesOrderHeader: listhead,
          salesOrderLine:listline,
          salesOrderPayDB:paylist
      );
  }
}