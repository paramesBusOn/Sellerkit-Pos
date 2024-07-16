import 'dart:convert';
import '../../DBModel/StockReqLine.dart';
import '../../DBModel/StockRequestHD.dart';

class StockRequest{
  int? TypeCode;
  String ? TypeName;

  List<StockReqHDTDB>? salesHeader; 
  List<StockReqLineTDB>? salesLine;

  StockRequest({
    required this.TypeCode,
    required this.TypeName,
    required this.salesHeader,
    required this.salesLine,
  });

  factory StockRequest.fromjson(Map<String, dynamic> resp) {
     var header = jsonDecode(resp['StockRequestHeader'].toString()) as List;
     var line = jsonDecode(resp['StockRequestLine'].toString()) as List;



     List<StockReqHDTDB> listhead =  header.map((e) => 
     StockReqHDTDB .fromjson(e)).toList();

     
     List<StockReqLineTDB> listline=  line.map((e) => 
     StockReqLineTDB .fromjson(e)).toList();

      return StockRequest(
          TypeCode: resp['TypeCode'],
          TypeName: resp['TypeName'],
          salesHeader: listhead,
          salesLine:listline,
      );
  }
}