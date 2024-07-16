// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesQuotationController/SalesQuotationController.dart';
import '../../../Widgets/Drawer.dart';
import '../Widgets/SQAppBar.dart';
import 'TabScreen/SQTabScreen.dart';

class SalesQuotationScreens extends StatefulWidget {
  const SalesQuotationScreens({
    Key? key,
  }) : super(key: key);

  @override
  State<SalesQuotationScreens> createState() => SalesQuotationScreensState();
}

class SalesQuotationScreensState extends State<SalesQuotationScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SalesQuotationCon>().init(context,Theme.of(context));
      setState(() {});
     });
  }
  @override
  Widget build(BuildContext context) {
      final theme=Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      // if (constraints.maxWidth <= 800) {
      //   return Scaffold(
      //      drawer: naviDrawerMob(context),
      //      body:
      //      ChangeNotifierProvider<SOCon>(
      //         create: (context) => SOCon(),//SOCon
      //         builder: (context, child) {
      //           return Consumer<SOCon>(
      //               builder: (BuildContext context, prdSCD, Widget? child) {
      //         return   SafeArea(
      //             child: SOSalesMobile(prdCD: prdSCD,
      //                    // scaffoldKey: scaffoldKey,
      //                   ),
      //           );
      //         }
      //       );
      //      }),
      //   );
      // } else
      
      //  if (constraints.maxWidth <= 1300) {
 return Scaffold(
  resizeToAvoidBottomInset: false,
           drawer: naviDrawer(context),
           body:
          // ChangeNotifierProvider<SOCon>(
          //     create: (context) => SOCon(),
          //     builder: (context, child) {
          //       return Consumer<SOCon>(
          //           builder: (BuildContext context, prdSCD, Widget? child) {
                 SingleChildScrollView(
                  child:SafeArea (
                    child: Column(children: <Widget>[
                            SQappbar("Sales Quotation", theme, context ),
                            SQuotationbillingTabScreen(theme:theme,),
                          ]),
                  ),
                ));
          //     }
          //   );
          //  }),
       // );
      // }
      // else{
      //    return Scaffold(
      //      body: ChangeNotifierProvider<SalesQuotationCon>(
      //         create: (context) => SalesQuotationCon(),
      //         builder: (context, child) {
      //           return Consumer<SalesQuotationCon>(
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
