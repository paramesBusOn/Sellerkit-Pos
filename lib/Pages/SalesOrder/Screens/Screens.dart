// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesOrderController/SalesOrderController.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import '../Widgets/SOBar.dart';
import 'MobileScreenSales/SalesMS.dart';
import 'TabScreen/BillingTabScreen.dart';

class SalesOrderScreens extends StatefulWidget {
  const SalesOrderScreens({
    Key? key,
  }) : super(key: key);

  @override
  State<SalesOrderScreens> createState() => SalesOrderScreensState();
}

class SalesOrderScreensState extends State<SalesOrderScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SOCon>().init(context,Theme.of(context));
      setState(() {});
     });
  }


  @override
  Widget build(BuildContext context) {
      final theme=Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
           drawer: naviDrawerMob(context),
           body:
           ChangeNotifierProvider<SOCon>(
              create: (context) => SOCon(),//SOCon
              builder: (context, child) {
                return Consumer<SOCon>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
              return   SafeArea(
                  child: SOSalesMobile(prdCD: prdSCD,
                         // scaffoldKey: scaffoldKey,
                        ),
                );
              }
            );
           }),
        );
      } else
      //  if (constraints.maxWidth <= 1300)
      {//300
 return Scaffold(
  resizeToAvoidBottomInset: false,
           drawer: naviDrawer(context),
           body:
          // ChangeNotifierProvider<SOCon>(
          //     create: (context) => SOCon(),
          //     builder: (context, child) {
          //       return Consumer<SOCon>(
          //           builder: (BuildContext context, prdSCD, Widget? child) {
                 SafeArea(
                  child: Column(children: <Widget>[
                          SOappbar("Sales Order", theme, context ),
                          SObillingTabScreen(theme:theme,),
                        ]),
                ));
          //     }
          //   );
          //  }),
       // );
      }
      // else{
      //    return Scaffold(
      //      body: ChangeNotifierProvider<SOCon>(
      //         create: (context) => SOCon(),
      //         builder: (context, child) {
      //           return Consumer<SOCon>(
      //               builder: (BuildContext context, prdSCD, Widget? child) {
      //          return SafeArea(
      //            child: SOPosScreen(
      //                     theme: theme,
      //                     prdSCD: prdSCD,
      //                   ),
      //          );
      //         }
      //       );
      //      }),
      //   );

      // }
    
    });
  }
}
