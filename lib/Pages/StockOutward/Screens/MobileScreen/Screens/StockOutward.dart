// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockOutward/Screens/MobileScreen/Widgets/StockOutward_ReqList.dart';
import 'package:posproject/Pages/StockOutward/Screens/MobileScreen/Widgets/StockOutward_Scanpage.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../Widgets/StockOutward_Details.dart';

class StockOutward extends StatelessWidget {
  StockOutward({Key? key, required this.theme, required this.SOut_Con})
      : super(key: key);

  final ThemeData theme;
  StockOutwardController SOut_Con;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageView(
      scrollDirection: Axis.horizontal,
      pageSnapping: false,
      // controller: SOut_Con.page,
      physics: NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        SOut_Con.PageIndexvalue(index);
      },
      children: [
        StockOut_ListWidget(
            theme: theme,
            StOut_Con: SOut_Con,
            SOut_Heigh: Screens.bodyheight(context),
            SOut_Width: Screens.width(context)),
        StockOut_DetailsWidget(
          theme: theme,
          StOut_Con: SOut_Con,
          SOut_Heigh: Screens.bodyheight(context),
          SOut_Width: Screens.width(context),
          index: SOut_Con.get_i_value,
          data: SOut_Con.passdata,
          datatotal: SOut_Con.StockOutward,
        ),
        MyWidget(
            StIn_Con: SOut_Con,
            datalist: SOut_Con.batch_datalist,
            ind: SOut_Con.batch_i!,
            index: SOut_Con.get_i_value)
      ],
    );
  }
}
