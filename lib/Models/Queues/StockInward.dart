import 'dart:convert';
import '../../DBModel/StockInwardBatchModel.dart';
import '../../DBModel/StockinwardHeader.dart';
import '../../DBModel/StockinwardLineData.dart';

class StockInward {
  int? TypeCode;
  String? TypeName;
  List<StockInHeaderDataDB> salesHeader; //headersss
  List<StockInLineDataDB> salesLine;
  List<StockInBatchDataDB> stInbatch;

  StockInward({
    required this.TypeCode,
    required this.TypeName,
    required this.salesHeader,
    required this.salesLine,
    required this.stInbatch
  });

  factory StockInward.fromjson(Map<String, dynamic> resp) {
    var header = jsonDecode(resp['StockInwardHeader'].toString()) as List;
    var line = jsonDecode(resp['StockInwardLine'].toString()) as List;
    var batchIn = jsonDecode(resp['StockInwardBatch'].toString()) as List;

    List<StockInHeaderDataDB> listhead =
        header.map((e) => StockInHeaderDataDB.fromjson(e)).toList();

    List<StockInLineDataDB> listline =
        line.map((e) => StockInLineDataDB.fromjson(e)).toList();

   List<StockInBatchDataDB> listbathcIn =
        batchIn.map((e) => StockInBatchDataDB.fromjson(e)).toList();
   
    return StockInward(
      TypeCode: resp['TypeCode'],
      TypeName: resp['TypeName'],
      salesHeader: listhead,
      salesLine: listline,
      stInbatch: listbathcIn
    );
  }
}
