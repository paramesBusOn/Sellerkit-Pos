import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockInward/Widgets/InwardItem.dart';
import 'package:posproject/Pages/StockInward/Widgets/Stockinreqlist.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/StockInwardController/StockInwardContler.dart';


class StockInTab extends StatelessWidget {
  const StockInTab({Key? key, required this.theme})
      : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withOpacity(0.05),
        // height: Screens.bodyheight(context),
        padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.01,
          left: Screens.padingHeight(context) * 0.01,
          right: Screens.padingHeight(context) * 0.01,
          bottom: Screens.padingHeight(context) * 0.01,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StockInReqList(
              searchHeight: Screens.bodyheight(context) * 0.9,
              searchWidth: Screens.width(context) * 0.5,
              theme: theme,
            ),       
            SizedBox(
                width: Screens.width(context) * 0.48,
                child: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text("data",style: TextStyle(color: Colors.amber),),
                      StockInward(
                        theme: theme,
                        stockInWidth: Screens.width(context) * 0.48,
                        stockInheight: Screens.bodyheight(context) * 0.907,
                        index: context.watch<StockInwrdController>().get_i_value,
                        data: context.watch<StockInwrdController>().passdata,
                        datatotal: context.watch<StockInwrdController>().StockInward,
                      ),
                    
                    ],
                  ),
                )),
          ],
        ));
  }
}
