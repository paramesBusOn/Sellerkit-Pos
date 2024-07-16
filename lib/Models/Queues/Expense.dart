import 'dart:convert';
import '../../DBModel/ExpenseDBModel.dart';


class ExpenseQueue{
  int? TypeCode;
  String ? TypeName;
  List<ExpenseDBModel> salesHeader;//headersss

  ExpenseQueue({
    required this.TypeCode,
    required this.TypeName,
    required this.salesHeader,
  });

  factory ExpenseQueue.fromjson(Map<String, dynamic> resp) {
     var header = jsonDecode(resp['ExpensesHeader'].toString()) as List;

     List<ExpenseDBModel> listhead =  header.map((e) => 
     ExpenseDBModel .fromjson(e)).toList();

      return ExpenseQueue(
          TypeCode: resp['TypeCode'],
          TypeName: resp['TypeName'],
          salesHeader: listhead,
      );
  }
}