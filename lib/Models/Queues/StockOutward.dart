import 'dart:convert';
import 'dart:developer';
import '../../DBModel/StockOutwardBatchModel.dart';
import '../../DBModel/StockOutwardHeader.dart';
import '../../DBModel/StockOutwardLineData.dart';

class StockOutward {
  int? TypeCode;
  String? TypeName;
  List<StockOutHeaderDataDB> salesHeader; //headersss
  List<StockOutLineDataDB> salesLine;
  List<StockOutBatchDataDB> stoutBatchlist;
  StockOutward({
    required this.TypeCode,
    required this.TypeName,
    required this.salesHeader,
    required this.salesLine,
    required this.stoutBatchlist,
  });

  factory StockOutward.fromjson(Map<String, dynamic> resp) {

    var header = jsonDecode(resp['StockOutwardHeader'].toString()) as List;
    var line = jsonDecode(resp['StockOutwardLine'].toString()) as List;
    var batch = jsonDecode(resp['StockOutwardBatch'].toString()) as List;
log('batch:xxx:${batch}');

    List<StockOutHeaderDataDB> listhead =
        header.map((e) => StockOutHeaderDataDB.fromjson(e)).toList();

    List<StockOutLineDataDB> listline =
        line.map((e) => StockOutLineDataDB.fromjson(e)).toList();

    List<StockOutBatchDataDB> listbatch =
        batch.map((e) => StockOutBatchDataDB.fromjson(e)).toList();

    return StockOutward(
        TypeCode: resp['TypeCode'],
        TypeName: resp['TypeName'],
        salesHeader: listhead,
        salesLine: listline,
        stoutBatchlist: listbatch);
  }
}
