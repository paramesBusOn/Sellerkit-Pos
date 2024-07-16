import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockOutward/Widgets/OutwardItem.dart';
import 'package:posproject/Pages/StockOutward/Widgets/StockOutreqlist.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/StockOutwardController/StockOutwardController.dart';

class StockOutTab extends StatelessWidget {
  const StockOutTab({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

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
            StockOutReqList(
              // context,
              theme: theme,
              searchHeight: Screens.bodyheight(context) * 0.87,
              searchWidth: Screens.width(context) * 0.5,
            ),
            SizedBox(
                width: Screens.width(context) * 0.48,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text("data",style: TextStyle(color: Colors.amber),),
                    StockOutward(
                        theme,
                        Screens.width(context) * 0.4,
                        Screens.bodyheight(context) * 0.88,
                        context.watch<StockOutwardController>().get_i_value,
                        context.watch<StockOutwardController>().passdata,
                        context.watch<StockOutwardController>().StockOutward,
                        context),
                  ],
                )),
          ],
        ));
  }
}
