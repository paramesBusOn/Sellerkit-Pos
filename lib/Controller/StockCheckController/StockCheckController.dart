// ignore_for_file: empty_constructor_bodies, camel_case_types, unused_local_variable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';

class StockCheckController extends ChangeNotifier {
  // StockCheckController() {
  //   getStockSnap();
  // }

  void init(){
    getStockSnap();
  }
  clearDataAll(){
    stockSnapList.clear();
    filterStockSnapList.clear();
    listbool = false;
  }
  List<stockCheckList> stockSnapList = [];
  List<stockCheckList> filterStockSnapList = [];
  bool listbool = false;
  getStockSnap() async {
    listbool = true;
    stockSnapList.clear();
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getStocksnapData =
        await DBOperation.getStockSnapFullData(db);
    if (getStocksnapData.isNotEmpty) {
 //log(  "branch::"+ getStocksnapData[0]["branch"].toString());
      for (int i = 0; i < getStocksnapData.length; i++) {
        stockSnapList.add(stockCheckList(
            branch: getStocksnapData[i]["branch"].toString(),
            itemCode: getStocksnapData[i]["itemcode"].toString(),
            itemname: getStocksnapData[i]["itemname"].toString(),
            qty: int.parse(getStocksnapData[i]["quantity"].toString()),
            serialbatch: getStocksnapData[i]["serialbatch"].toString(), 
            price: 
            getStocksnapData[i]["sellprice"] == null ||  getStocksnapData[i]["sellprice"] == 'null' ? 0:double.parse(getStocksnapData[i]["sellprice"].toString().replaceAll(',', ''))));
      }
      filterStockSnapList = stockSnapList;
      // notifyListeners();
    } else {
      listbool = false;
      // notifyListeners();
    }
    notifyListeners();
  }

  filterListSearched(String v) {
    //y
    listbool = false;
    if (v.isNotEmpty) {
      filterStockSnapList = stockSnapList
          .where((e) =>
              e.itemname!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.serialbatch!.toLowerCase().contains(v.toLowerCase())
             )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterStockSnapList = stockSnapList;
      notifyListeners();
    }
  }
}

class stockCheckList {
  String? itemname;
  String? itemCode;
  String? serialbatch;
  String? branch;
  int? qty;
  double? price;
  stockCheckList({
    required this.price,
    required this.branch,
    required this.itemCode,
    required this.itemname,
    required this.qty,
    required this.serialbatch,
  });
}
