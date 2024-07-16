// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../Controller/StockListsController/StockListsController.dart';
import '../Widget/MobStockList.dart';

class StockMobScreens extends StatelessWidget {
   StockMobScreens({super.key,required this.stkCtrl});
StockController stkCtrl;
  @override
  Widget build(BuildContext context) {
    return Container(

      child: MobStockList(stkCtrl:stkCtrl),
    );
  }
}