// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:posproject/Pages/StocksCheck/Widget/Search.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/StockReplenish/StockReplenishController.dart';
import '../../../Sales Screen/Widgets/ItemLists.dart';
import '../../Widget/Search.dart';

class TabStockReplenishScreen extends StatefulWidget {
  const TabStockReplenishScreen({super.key, });

  @override
  State<TabStockReplenishScreen> createState() => _TabStockReplenishScreenState();
}

class _TabStockReplenishScreenState extends State<TabStockReplenishScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.05),
      ),
      padding: EdgeInsets.only(
          top: Screens.bodyheight(context) * 0.01,
          bottom: Screens.bodyheight(context) * 0.01,
          left: Screens.width(context) * 0.01,
          right: Screens.width(context) * 0.01),
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.95,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Search_Widget_Replenish(
                searchHeight: Screens.bodyheight(context),
                searchWidth: Screens.width(context))
          ],
        ),
      ),
    );
  }
}
