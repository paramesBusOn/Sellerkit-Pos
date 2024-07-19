// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:posproject/Pages/LoginScreen/Widgets/FooterContainer.dart';

import '../../../Constant/Screen.dart';
import '../Widgets/BodyConLogTab.dart';
import '../Widgets/HeadLoginTab.dart';

class LoginWeb extends StatelessWidget {
  const LoginWeb({
    super.key,
    // required this.logCon,
  });

  // LoginController logCon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double widthRight = Screens.width(context) / 2.5;

    final double widthLeft = Screens.width(context) - widthRight;
    final double height = Screens.padingHeight(context);
    return SizedBox(
      width: Screens.width(context),
      height: Screens.padingHeight(context),
      // color: Colors.yellow,
      child: Row(children: [
        Container(
          width: widthLeft,
          color: Theme.of(context).primaryColor,
        ),
        Container(
          // color: Colors.green,
          width: widthRight,
          padding: EdgeInsets.only(
              left: widthRight * 0.01,
              right: widthRight * 0.01,
              top: height * 0.01),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HeaderLoginTab(
                  height: 0,
                  width: 0,
                ),
                // SizedBox(height: height * 0.02),
                BodyLoginTab(
                  theme: theme,
                  height: 0,
                  width: 0,
                ),
                // SizedBox(height: height * 0.07),
                FooterContainer(
                  height: height * 0.1, width: 0,
                  // width: widthRight,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
