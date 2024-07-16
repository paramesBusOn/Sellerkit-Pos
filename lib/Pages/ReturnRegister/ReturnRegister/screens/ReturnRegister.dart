// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Controller/ReturnRegisterController/ReturnRegister.dart';
import '../../../../Widgets/Drawer.dart';
import '../../../../Widgets/MobileDrawer.dart';
import '../widgets/AppBar.dart';
import 'TabScreen/TabScreenRetReg.dart';


class RetRegisterScreens extends StatefulWidget {
  const RetRegisterScreens({
    Key? key,
  }) : super(key: key);

  @override
  State<RetRegisterScreens> createState() => SalesRegisterState();
}

class SalesRegisterState extends State<RetRegisterScreens> {
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<RetnRegCon>().init();
    });
  }
  @override
  Widget build(BuildContext context) {
      final theme=Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
           drawer: naviDrawerMob(context),
           body: ChangeNotifierProvider<RetnRegCon>(
              create: (context) => RetnRegCon(),//SOCon
              builder: (context, child) {
                return Consumer<RetnRegCon>(
                    builder: (BuildContext context, stRegCon, Widget? child) {
                return SafeArea(
                  child: Container(),
                );
              }
            );
           }),
        );
      } else {//300
 return Scaffold(
  resizeToAvoidBottomInset: false,
           drawer: naviDrawer(context),
           body: 
          //  ChangeNotifierProvider<RetnRegCon>(
          //     create: (context) => RetnRegCon(),
          //     builder: (context, child) {
          //       return Consumer<RetnRegCon>(
          //           builder: (BuildContext context, stRegCon, Widget? child) {
          //       return 
                SafeArea(
                  child: Column(children: <Widget>[
                         appbarDefault('Return Register',theme,context),
                         TabReturnReg(theme: theme,)
                        ]),
                ),
          //     }
          //   );
          //  }),
        );
      }    
    });
  }

   
}

