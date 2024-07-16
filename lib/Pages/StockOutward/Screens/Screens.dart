// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_print, unnecessary_new
import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockOutward/Screens/TabScreen/StockOutTab.dart';
import 'package:posproject/Pages/StockOutward/Widgets/M_StOut_Appbar.dart';
import 'package:provider/provider.dart';
import '../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import '../Widgets/SToutward_Appbar.dart';
import '../Widgets/Tap_stockOutItemDeatils.dart';
import 'MobileScreen/Screens/StockOutward.dart';

class StockOutwardScreens extends StatefulWidget {
  const StockOutwardScreens({
    Key? key,
  }) : super(key: key);

  @override
  State<StockOutwardScreens> createState() => _StockOutwardScreensState();
}

class _StockOutwardScreensState extends State<StockOutwardScreens> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<StockOutwardController>().clearDataAll();
        context.read<StockOutwardController>().init();
        context.read<StockOutwardController>().adddlistner();
      });
    });
  }

  @override
  void dispose() {
    // context.read<StockOutwardController>().pageController.dispose();
    // context.read<StockOutwardController>().disposmethod();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return ChangeNotifierProvider<StockOutwardController>(
            create: (context) => StockOutwardController(),
            builder: (context, child) {
              return Consumer<StockOutwardController>(
                  builder: (BuildContext context, StOut_Con, Widget? child) {
                return Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: StOut_appbar(
                        "Stock Outward", theme, context, StOut_Con),
                    drawer: naviDrawerMob(context),
                    // drawer: M_naviDrawer(context),
                    backgroundColor: Colors.grey[200],
                    body: SafeArea(
                      child:
                          StockOutward(theme: theme, SOut_Con: StOut_Con),
                    ));
              });
            });
      } else {
        return Scaffold(
            drawer: naviDrawer(context),
            body:
                // ChangeNotifierProvider<StockOutwardController>(
                //     create: (context) => StockOutwardController(),
                //     builder: (context, child) {
                //       return Consumer<StockOutwardController>(
                //           builder: (BuildContext context, prdSCD, Widget? child) {
                //         return LayoutBuilder(builder: (context, constraints) {
                //           return
                SingleChildScrollView(
                  child: Column(
                    // scrollDirection: Axis.horizontal,
                    // pageSnapping: true,
                    // controller: context.read<StockOutwardController>().pageController,
                    // physics: new NeverScrollableScrollPhysics(),
                    // onPageChanged: (index) {
                    //   log("index: $index");
                    //   setState(() {
                    //     context.read<StockOutwardController>().currentPage = index;
                    //   });
                    //   // print(context.read<StockOutwardController>().currentPage);
                    // },
                    children: [
                      context.watch<StockOutwardController>().isselect == false
                          ? SingleChildScrollView(
                              child: Column(children: [
                                Outward_appbar(
                                  "Stock Outward",
                                  theme,
                                  context,
                                ),
                                StockOutTab(
                                  theme: theme,
                                ),
                              ]),
                            )
                          : Container(),
                      context.watch<StockOutwardController>().isselect == true
                          ? SingleChildScrollView(
                              child: Column(children: [
                                Outward_appbar(
                                  "Stock Outward",
                                  theme,
                                  context,
                                ),
                                StockOutTabPageviewerSecond(
                                  theme: theme,
                                ),
                              ]),
                            )
                          : Container(),
                    ],
                    // ),
                    // });
                    //   });
                    // }
                  ),
                ));
      }
      // else {
      //   return Scaffold(
      //       body: ChangeNotifierProvider<StockOutwardController>(
      //           create: (context) => StockOutwardController(),
      //           builder: (context, child) {
      //             return Consumer<StockOutwardController>(
      //                 builder: (BuildContext context, prdSCD, Widget? child) {
      //               return LayoutBuilder(builder: (context, constraints) {
      //                 return SafeArea(
      //                   child: StockOutPos(
      //                     theme: theme,
      //                     StOut_Con: prdSCD,
      //                   ),
      //                 );
      //               });
      //             });
      //           }));
      // }
    });
  }
}
