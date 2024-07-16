import 'dart:convert';
import '../../DBModel/SalesHeader.dart';
import '../../DBModel/SalesLineDBModel.dart';
import '../../DBModel/SalesPay.dart';

class SalesInvoice {
  int? TypeCode;
  String ? TypeName;
  List<SalesHeaderTModelDB>? salesHeader; 
  List<SalesLineTDB>? salesLine;
  List<SalesPayTDB>? salesPayDB;

  SalesInvoice({
    required this.TypeCode,
    required this.TypeName,
    required this.salesHeader,
    required this.salesLine,
    required this.salesPayDB
  });

  factory SalesInvoice.fromjson(Map<String, dynamic> resp) {
     var header = jsonDecode(resp['InvoiceHeader'].toString()) as List;
     var line = jsonDecode(resp['InvoiceLine'].toString()) as List;
     var pay = jsonDecode(resp['InvoicePay'].toString()) as List;



     List<SalesHeaderTModelDB> listhead =  header.map((e) => 
     SalesHeaderTModelDB .fromjson(e)).toList();

     
     List<SalesLineTDB> listline=  line.map((e) => 
     SalesLineTDB .fromjson(e)).toList();

     List<SalesPayTDB> paylist=  pay.map((e) => 
     SalesPayTDB .fromjson(e)).toList();

      return SalesInvoice(
          TypeCode: resp['TypeCode'],
          TypeName: resp['TypeName'],
          salesHeader: listhead,
          salesLine:listline,
          salesPayDB:paylist
      );
  }
}