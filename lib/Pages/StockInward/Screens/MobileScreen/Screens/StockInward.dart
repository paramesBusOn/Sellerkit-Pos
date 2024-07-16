// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockInward/Screens/MobileScreen/Widgets/StockInward_ReqList.dart';
import 'package:posproject/Pages/StockInward/Screens/MobileScreen/Widgets/StockInward_Scanpage.dart';
import '../../../../../Constant/Screen.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../Widgets/StockInward_Details.dart';

class StockInward extends StatelessWidget {
  StockInward({Key? key, required this.theme, required this.StIn_Con})
      : super(key: key);

  final ThemeData theme;
  StockInwrdController StIn_Con;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageView(
      scrollDirection: Axis.horizontal,
      pageSnapping: false,
      controller: StIn_Con.page,
      physics: NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        StIn_Con.PageIndexvalue(index);
      },
      children: [
        StockIn_ListWidget(
            theme: theme,
            StIn_Con: StIn_Con,
            SIN_Heigh: Screens.bodyheight(context),
            SIN_Width: Screens.width(context)),
        StockIn_DetailsWidget(
          theme: theme,
          StIn_Con: StIn_Con,
          SIN_Heigh: Screens.bodyheight(context),
          SIN_Width: Screens.width(context),
          index: StIn_Con.get_i_value,
          data: StIn_Con.passdata,
          datatotal: StIn_Con.StockInward,
        ),
        MyWidget(
            StIn_Con: StIn_Con,
            datalist: StIn_Con.batch_datalist,
            ind: StIn_Con.batch_i!,
            index: StIn_Con.get_i_value)
      ],
    );
  }
}
