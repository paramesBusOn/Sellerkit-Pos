import 'package:flutter/material.dart';
import 'package:posproject/DB%20Helper/DBOperation.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB Helper/DBhelper.dart';

class StRegCon extends ChangeNotifier {

  // StRegCon(){
  //  init();
  // }

  init()async{
    clearalldata();
    await getStockReg();
  }


  List<StockRegister> salesReg = [];
  List<StockRegister> filtersalesReg = [];
  List<StockRegister> get getfiltersalesReg => filtersalesReg;


clearalldata(){
   salesReg.clear();
   filtersalesReg .clear();
}
 Future<void> getStockReg()async{
 final Database db = (await DBHelper.getInstance())!;
   List<Map<String, Object?>> data = await DBOperation.getStockRegister(db);

    for(int i = 0; i< data.length; i++ ){
      salesReg.add(StockRegister(
        branch: data[i]['branch'].toString(), 
        cardcode: data[i]['customercode'].toString(), 
        cardname: data[i]['customername'].toString(), 
        date: data[i]['transtime'].toString(), 
        docEntry:int.parse(data[i]['docentry'].toString()), 
        docno: data[i]['documentno'].toString(), 
        itemcode: data[i]['itemcode'].toString(), 
        itemname: data[i]['itemname'].toString(), 
        terminal: data[i]['terminal'].toString()
        ));
    }
  filtersalesReg =  salesReg;
  notifyListeners();
  }

  filterListSearched(String v) {
    //y
    if (v.isNotEmpty) {
      filtersalesReg = salesReg
          .where((e) =>
              e.itemcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemname!.toLowerCase().contains(v.toLowerCase()) ||
              e.cardcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.cardname!.toLowerCase().contains(v.toLowerCase()) ||
              e.docno!.toLowerCase().contains(v.toLowerCase())
              
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersalesReg = salesReg;
      notifyListeners();
    }
  }
}

class StockRegister {
 String? docno;
 int? docEntry;
 String? branch;
 String? terminal;
 String? cardcode;
 String? cardname;
 String? itemcode;
 String? itemname;
 String? date;

 StockRegister({
  required this.branch,
  required this.cardcode,
  required this.cardname,
  required this.date,
  required this.docEntry,
  required this.docno,
  required this.itemcode,
  required this.itemname,
  required this.terminal
 });


}