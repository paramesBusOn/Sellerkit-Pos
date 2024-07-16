// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/StockListsController/StockListsController.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import '../../Sales Screen/Screens/MobileScreenSales/AppBar/AppBarMS.dart';
import 'MobStockScreen/Screens/MobScreen.dart';
import 'PosStockScreen/PosStockMainScreen.dart';
import 'TabStockScreen/TabStockSreen.dart';

class StockMainScreens extends StatefulWidget {
  const StockMainScreens({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  State<StockMainScreens> createState() => _StockMainScreensState();
}

class _StockMainScreensState extends State<StockMainScreens> {
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        // context.read<StockReplenishController>().clearDataAll();
        context.read<StockController>().init();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
            appBar: appbarMS("Stock Lists ", widget.theme, context),
            drawer: naviDrawerMob(context),
            body: ChangeNotifierProvider<StockController>(
                create: (context) => StockController(),
                builder: (context, child) {
                  return Consumer<StockController>(
                      builder: (BuildContext context, stkCtrl, Widget? child) {
                    return SafeArea(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StockMobScreens(
                              stkCtrl: stkCtrl,

                              // scaffoldKey: scaffoldKey,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                }));
      } else if (constraints.maxWidth <= 1300) {
        //300
        return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: naviDrawer(context),
          appBar: AppBar(
            title: const Text("Stocks List"),
            actions: [
              // IconButton(
              //     onPressed: () {
              //       // context.read<DashBoardController>().refresh();
              //     },
              //     icon: const Icon(Icons.refresh))
            ],
          ),
          // appBar: appbar(
          //   "Stock Lists ",
          //   widget.theme,
          //   context,

          // ),
          body: SafeArea(
            child: TabStockScreen(
                // stkCtrl: prdSCD,
                ),
          ),
        );
      } else {
        return Scaffold(
          body: ChangeNotifierProvider<StockController>(
              create: (context) => StockController(),
              builder: (context, child) {
                return Consumer<StockController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                      child: PosStockMainScreen(
                    stkCtrl: prdSCD,
                  ));
                });
              }),
        );
      }
    });
  }
}
