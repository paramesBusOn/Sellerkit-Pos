import 'package:flutter/material.dart';
import 'package:posproject/DB%20Helper/DBOperation.dart';
import 'package:sqflite/sqflite.dart';
import '../../DB Helper/DBhelper.dart';

class CashStateCon extends ChangeNotifier {

  // CashStateCon(){
  //  init();
  // }

  init()async{
    clearalldata();
    await getStockReg();
  }

  List<CashState> salesReg = [];
  List<CashState> filtersalesReg = [];
  List<CashState> get getfiltersalesReg => filtersalesReg;
  clearalldata(){
salesReg.clear();
filtersalesReg.clear();
  }
 Future<void> getStockReg()async{
 final Database db = (await DBHelper.getInstance())!;
   List<Map<String, Object?>> data = await DBOperation.getCashstatement(db);

    for(int i = 0; i< data.length; i++ ){
      salesReg.add(CashState(
        branch: data[i]['branch'].toString(), 
        cardcode: data[i]['customercode'].toString(), 
        cardname: data[i]['customername'].toString(), 
        date: data[i]['transtime'].toString(), 
        expense:data[i]['Expense'].toString(), 
        docno: data[i]['documentno'].toString(), 
        doctype: data[i]['doctype'].toString(), 
        amount: data[i]['rcamount'].toString(), 
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
              e.doctype!.toLowerCase().contains(v.toLowerCase()) ||
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

class CashState {
 String? docno;
 String? expense;
 String? branch;
 String? terminal;
 String? cardcode;
 String? cardname;
 String? doctype;
 String? amount;
 String? date;

 CashState({
  required this.branch,
  required this.cardcode,
  required this.cardname,
  required this.date,
  required this.expense,
  required this.docno,
  required this.doctype,
  required this.amount,
  required this.terminal
 });
}