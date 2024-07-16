import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/StockOutwardController/StockOutwardController.dart';
import 'StockOutScanPage.dart';
import 'TapStockOutItemList.dart';

class StockOutTabPageviewerSecond extends StatefulWidget {
  const StockOutTabPageviewerSecond(
      {Key? key, required this.theme, })
      : super(key: key);

  final ThemeData theme;

  @override
  State<StockOutTabPageviewerSecond> createState() => _StockOutTabPageviewerSecondState();
}

class _StockOutTabPageviewerSecondState extends State<StockOutTabPageviewerSecond> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withOpacity(0.05),
        // height: Screens.bodyheight(context),
        padding: EdgeInsets.only(
          top: Screens.bodyheight(context) * 0.02,
          left: Screens.bodyheight(context) * 0.01,
          right: Screens.bodyheight(context) * 0.01,
          bottom: Screens.bodyheight(context) * 0.01,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StockOutwardPageviewerLeft(
              theme: widget.theme,
              stockInWidth: Screens.width(context) * 0.48,
              stockInheight: Screens.bodyheight(context)*0.9002 ,
              index:  context.watch<StockOutwardController>().get_i_value,
              data:  context.watch<StockOutwardController>().passdata,
              datatotal: context.watch<StockOutwardController>().StockOutward,
            ),
            SizedBox(
                width: Screens.width(context) * 0.48,
                child: StockOutscanPage(
                  searchHeight: Screens.bodyheight(context) * 0.782,
                  searchWidth: Screens.width(context) * 0.5,
                  index: context.watch<StockOutwardController>().get_i_value,
                  // ind:  context.watch<StockOutwardController>().batch_i,
                  theme: widget.theme,
                  datalist: context.watch<StockOutwardController>().batch_datalist,
                )),
         
          ],
        ));
  }
}
