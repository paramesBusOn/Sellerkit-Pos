// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:posproject/Constant/padings.dart';
import '../../../../Constant/Screen.dart';

import '../widgets/ForgotBodySection.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  Paddings constant = Paddings();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<ForgotPasswordController>().disPosed();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context),
            height: Screens.padingHeight(context),
            //  decoration: BoxDecoration(
            //    color: Colors.white
            //  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //  Stack(
              children: [
                MobForgotBodySection()
              ],
            ),
          ),
        )));
  }
}
