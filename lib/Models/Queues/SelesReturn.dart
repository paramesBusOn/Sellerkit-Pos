import 'dart:convert';

import '../../DBModel/SalesReturnHeadT.dart';
import '../../DBModel/SalesReturnLineT.dart';
// import '../../DBModel/SalesReturnPayT.dart';

class SalesRetrun {
  int? TypeCode;
  String? TypeName;

  List<SalesReturnTModelDB>? salesHeader;
  List<SalesReturnLineTDB>? salesLine;
  // List<SalesReturnPayTDB>? salesPayDB;

  SalesRetrun({
    required this.TypeCode,
    required this.TypeName,
    required this.salesHeader,
    required this.salesLine,
    // required this.salesPayDB
  });

  factory SalesRetrun.fromjson(Map<String, dynamic> resp) {
    var header = jsonDecode(resp['SalesReturnHeader'].toString()) as List;
    var line = jsonDecode(resp['SalesReturnLine'].toString()) as List;
    //  var pay = jsonDecode(resp['SalesReturntPay'].toString()) as List;

    List<SalesReturnTModelDB> listhead =
        header.map((e) => SalesReturnTModelDB.fromjson(e)).toList();

    List<SalesReturnLineTDB> listline =
        line.map((e) => SalesReturnLineTDB.fromjson(e)).toList();

    //  List<SalesReturnPayTDB> paylist=  pay.map((e) =>
    //  SalesReturnPayTDB .fromjson(e)).toList();

    return SalesRetrun(
      TypeCode: resp['TypeCode'],
      TypeName: resp['TypeName'],
      salesHeader: listhead,
      salesLine: listline,
      // salesPayDB:paylist
    );
  }
}
