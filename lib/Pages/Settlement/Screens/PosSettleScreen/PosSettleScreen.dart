// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/DepositController/DepositsController.dart';
import '../../../Sales Screen/Widgets/QuickOptions.dart';
import '../../Widgets/firstScreen.dart';

class PosSettleScreen extends StatelessWidget {
   PosSettleScreen({
    Key? key,required this.settleCon
  }) : super(key: key);

  String? chosenValue;

  // String? _chosenValue;
DepositsController settleCon;
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          
          SizedBox(
           // color: Colors.amber,
            height: Screens.padingHeight(context)*0.95,
            width: Screens.width(context)*0.90,
            child: SettleFirstscreen(
            custHeight: Screens.padingHeight(context)*0.70,
            custWidth:Screens.width(context)*0.90 ,
            )),
          const SingleChildScrollView(child: QuickOptions()),
                  ],
      ),
    );
  }
}
