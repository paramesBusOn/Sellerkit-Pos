import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockRequest/Widget/BottomBtn.dart';
import 'package:posproject/Pages/StockRequest/Widget/LoadButtons.dart';
import 'package:posproject/Pages/StockRequest/Widget/Requestitem.dart';
import 'package:posproject/Pages/StockRequest/Widget/StockreqCustomer.dart';
import 'package:posproject/Pages/StockRequest/Widget/TotalItemDetails.dart';
import 'package:provider/provider.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/StockRequestController/StockRequestController.dart';

class StockReqTab extends StatelessWidget {
  const StockReqTab({Key? key, required this.theme, })
      : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withOpacity(0.05),
        height: Screens.bodyheight(context)*0.96,
        padding: EdgeInsets.only(
          top: Screens.bodyheight(context) * 0.01,
          left: Screens.bodyheight(context) * 0.01,
          right: Screens.bodyheight(context) * 0.01,
          // bottom: Screens.bodyheight(context) * 0.01,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: Screens.width(context) * 0.5,
                child: RequestItem(
                  searchHeight: Screens.bodyheight(context) * 0.943,
                  searchWidth: Screens.width(context) * 0.48,
                  theme: theme,
                )),
            SizedBox(
                width: Screens.width(context) * 0.48,
                // color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StockReqCustomer(
                          custWidth: Screens.width(context) * 0.48,
                          custHeight: Screens.bodyheight(context) * 0.48,
                          theme: theme,
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        ItemDetails(
                          itemHeight: Screens.bodyheight(context) * 0.09,
                          itemWidth: Screens.width(context) * 0.48,
                          theme: theme,
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                         context.watch<StockReqController>().scanneditemData2.isNotEmpty
                            ? Container()
                            : LoadButtons(
                          loadWidth: Screens.width(context) * 0.48,
                          loadheight: Screens.bodyheight(context) * 0.13,
                        ),

                    
                      ],
                    ),
                    StockReqBottomBtn(
                      theme: theme,
                      btnheight: Screens.bodyheight(context) * 0.1,
                      btnWidth: Screens.width(context) * 0.48,
                    )
                  ],
                )),
          ],
        ));
  }
}
