// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, prefer_is_empty, must_be_immutable

import 'package:flutter/material.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/SalesOrderController/SalesOrderController.dart';
import 'AppBar/AppBarMS.dart';
import 'WidgetsMob/AmountSelectionWidget.dart';
import 'WidgetsMob/AmtCalWidget.dart';
import 'WidgetsMob/BottomBtnMob.dart';
import 'WidgetsMob/CustomerWidgetMob.dart';
import 'WidgetsMob/ItemSearchWidget.dart';
import 'WidgetsMob/PaymentWidegt.dart';

class SOSalesMobile extends StatelessWidget {
  SOSalesMobile({
    super.key,
    required this.prdCD,
  });
  SOCon prdCD;
  //final GlobalKey<ScaffoldState> scaffoldKey;required this.scaffoldKey
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: Screens.bodyheight(context),
      width: Screens.width(context),
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(children: [
          appbarMS("Sales Order", theme, context, posController: null),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
                vertical: Screens.bodyheight(context) * 0.01),
            child: Column(
              children: [
                CustomerWidgetMobile(
                  theme: theme,
                  prdSI: prdCD,
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                ItemSearchWidget(theme: theme, prdCD: prdCD),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                AmountSelectionWidget(theme: theme,prdCD:prdCD),
                 SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                SOPaymentDetailsMob(prdCD: prdCD, theme: theme),
                  SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                AmtCalCulationWidget(theme: theme, prdCD: prdCD),
                  SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                BottomButtonMob(prdCD: prdCD, theme: theme)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}








