// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:posproject/Pages/SalesReturn/SalesReturnScreens/PosScreen/PosScreen.dart';
import 'package:posproject/Pages/SalesReturn/SalesReturnScreens/TabScreen/TabScreen.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/Drawer.dart';
import '../../Controller/SalesReturnController/SalesReturnController.dart';
import '../../Widgets/MobileDrawer.dart';
import 'SalesReturnScreens/MobileScreen/SalesReturnMS.dart';
import 'Widget/SalesReturnAppbar.dart';

class SalesReturnScreens extends StatefulWidget {
  const SalesReturnScreens({
    Key? key,
  }) : super(key: key);

  // final ThemeData theme;

  @override
  State<SalesReturnScreens> createState() => _SalesReturnScreensState();
}

class _SalesReturnScreensState extends State<SalesReturnScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<SalesReturnController>().clearAllData();
      context.read<SalesReturnController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
          drawer: naviDrawerMob(context),
          body: ChangeNotifierProvider<SalesReturnController>(
              create: (context) => SalesReturnController(),
              builder: (context, child) {
                return Consumer<SalesReturnController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                      child: SalesReturnMobile(
                    salesReturnController: prdSCD,
                  ));
                });
              }),
        );
      } else if (constraints.maxWidth <= 1300) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: naviDrawer(context),
            body:
                // ChangeNotifierProvider<SalesReturnController>(
                //     create: (context) => SalesReturnController(),
                //     builder: (context, child) {
                //       return Consumer<SalesReturnController>(
                //           builder: (BuildContext context, prdSCD, Widget? child) {
                //         return
                SafeArea(
                    child: Container(
              child: Column(children: [
                SalesReturnappbar(
                  "Sales Return",
                  theme,
                  context,
                ),
                SalesReturnTabScreen(
                  theme: theme,
                ),
              ]),
            ))
            //   });
            // }),
            );
      } else {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: ChangeNotifierProvider<SalesReturnController>(
              create: (context) => SalesReturnController(),
              builder: (context, child) {
                return Consumer<SalesReturnController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                    child: SalesReturnPosScreen(
                      theme: theme,
                      prdSR: prdSCD,
                    ),
                  );
                });
              }),
        );
      }
    });
  }
}

// return Scaffold(
//     drawer: naviDrawer(context),
//     body: ChangeNotifierProvider<SalesReturnController>(
//         create: (context) => SalesReturnController(),
//         builder: (context, child) {
//           return Consumer<SalesReturnController>(
//               builder: (BuildContext context, prdSCD, Widget? child) {
//             return LayoutBuilder(
//               builder: (context, constraints) {
//                    if (constraints.maxWidth <= 800) {
//           return SalesReturnMobile();
//         }
//              else if (constraints.maxWidth <= 1300) {
//                 return
//                 Container(
//                   child: Column(
//                     children:[
//                     SalesReturnappbar("Sales Return", widget.theme, context,salesReturnController: prdSCD),
//                     SalesReturnTabScreen(theme: widget.theme, prdSR: prdSCD),
//                   ]),
//                 );
//               } else
//                 return SafeArea(
//                   child: SalesReturnPosScreen(
//                     theme: widget.theme,
//                prdSR: prdSCD,
//                   ),
//                 );
//             });
//           });
//         }));
