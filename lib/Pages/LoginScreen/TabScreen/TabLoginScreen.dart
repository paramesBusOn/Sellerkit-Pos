// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:posproject/Pages/LoginScreen/Widgets/FooterContainer.dart';

import '../../../Constant/Screen.dart';
import '../Widgets/BodyConLogTab.dart';
import '../Widgets/HeadLoginTab.dart';

class TabLoginScreen extends StatelessWidget {
  const TabLoginScreen({
    Key? key,
   // required this.logCon,
  }) : super(key: key);

 // LoginController logCon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: Screens.width(context),
      height: Screens.padingHeight(context),
      // color: Colors.yellow,
      child: Row(children: [
        Container(
          width: Screens.width(context) * 0.50,
          color: Theme.of(context).primaryColor,
        ),
        Container(
          //color: Colors.green,
          width: Screens.width(context) * 0.50,
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderLoginTab(),
                SizedBox(height: Screens.padingHeight(context) * 0.02),
                BodyLoginTab( theme: theme),
                SizedBox(height: Screens.padingHeight(context) * 0.07),
                FooterContainer( height: Screens.padingHeight(context) * 0.1)
              ],
            ),
          ),
        ),
      ]),
    );
  }
}




