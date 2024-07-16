// ignore_for_file: empty_constructor_bodies, camel_case_types, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';

class StockReplenishController extends ChangeNotifier {
  // StockReplenishController() {
  //   getOutOfStockItems();
  // }
  clearDataAll() {
    outOfstock.clear();
    filteroutOfstockList.clear();
    outOfstockBool = false;
  }

  init() {
    getOutOfStockItems();
  }

  List<stockCheckList> outOfstock = [];
  List<stockCheckList> filteroutOfstockList = [];
  bool outOfstockBool = false;
  filterListSearched(String v) {
    //y
    outOfstockBool = false;
    if (v.isNotEmpty) {
      filteroutOfstockList = outOfstock
          .where((e) => e.itemname!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filteroutOfstockList = outOfstock;
      notifyListeners();
    }
  }

  getOutOfStockItems() async {
    outOfstock.clear();
    outOfstockBool = true;
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getOutOfItemsData =
        await DBOperation.getoutofDataData(db);
    if (getOutOfItemsData.isNotEmpty) {
      for (int j = 0; j < getOutOfItemsData.length; j++) {
        if (getOutOfItemsData[j]["shortageQty"] != 0) {
          outOfstock.add(stockCheckList(
            // DocNo:getsyncedData[j]["documentno"]==null?0: int.parse(getsyncedData[j]["documentno"].toString()),
            itemname: getOutOfItemsData[j]["itemname_short"] == null
                ? ''
                : getOutOfItemsData[j]["itemname_short"].toString(),
            // Docdate: getsyncedData[j]["createdateTime"].toString(),
            qty: getOutOfItemsData[j]["shortageQty"] == null
                ? 0
                : int.parse(getOutOfItemsData[j]["shortageQty"].toString()),
          ));
        }
      }
      filteroutOfstockList = outOfstock;
    } else {
      getOutOfStockItems();
      outOfstockBool = false;
      notifyListeners();
    }
    notifyListeners();
  }
}

class stockCheckList {
  String? itemname;
  String? itemCode;
  String? serialbatch;
  String? branch;
  int? qty;
  stockCheckList({
    this.branch,
    this.itemCode,
    this.itemname,
    this.qty,
    this.serialbatch,
  });
}
