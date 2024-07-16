// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Controller/DepositController/DepositsController.dart';
import 'package:provider/provider.dart';

import '../../../../Constant/Screen.dart';
import '../../Widgets/TabsetledSecondScreen.dart';
import '../../Widgets/firstScreen.dart';

class TabSettleScreen extends StatelessWidget {
  TabSettleScreen({
    Key? key,
  }) : super(key: key);
// DepositsController settleCon;
  // String? _chosenValue;

  String? chosenValue;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return SizedBox(
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.95,
      child: PageView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          // pageSnapping: false,
          controller: context.read<DepositsController>().tappage,
          children: [
            //  children: [
            Column(
              children: [
                SettleFirstscreen(
                  custHeight: Screens.padingHeight(context) * 0.80,
                  custWidth: Screens.width(context) * 0.90,
                ),
              ],
            ),
            TabsetledSecondScreen(
              custHeight: Screens.padingHeight(context) * 0.90,
              custWidth: Screens.width(context) * 0.90,
            )
          ]),
      // ),
      // ]
    );
  }
}
