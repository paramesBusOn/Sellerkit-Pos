// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:posproject/Pages/Stock%20Replenish/Screens/MobStockScreen/Screens/MobScreen.dart';
import 'package:provider/provider.dart';

import '../../../Controller/StockReplenish/StockReplenishController.dart';
import '../../../Widgets/Drawer.dart';
import '../../../Widgets/MobileDrawer.dart';
import '../../Sales Screen/Screens/MobileScreenSales/AppBar/AppBarMS.dart';
import '../Widget/AppBar.dart';
import 'TabStockScreen/TabStockReplenishSreen.dart';

class StockReplenishMainScreens extends StatefulWidget {
  const StockReplenishMainScreens({
    Key? key,
  }) : super(key: key);

  @override
  State<StockReplenishMainScreens> createState() => _StockReplenishMainScreensState();
}

class _StockReplenishMainScreensState extends State<StockReplenishMainScreens> {
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<StockReplenishController>().clearDataAll();
        context.read<StockReplenishController>().init();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
            appBar: appbarMS("Stock Replenish", theme, context),
            drawer: naviDrawerMob(context),
                                backgroundColor: Colors.grey[200],

            body: ChangeNotifierProvider<StockReplenishController>(
                create: (context) => StockReplenishController(),
                builder: (context, child) {
                  return Consumer<StockReplenishController>(
                      builder: (BuildContext context, stkCtrl, Widget? child) {
                    return SafeArea(
                      child: StockReplenishScreens(
                        stkCtrl: stkCtrl,

                        // scaffoldKey: scaffoldKey,
                      ),
                    );
                  });
                }));
      } else {
        //300
        // return ChangeNotifierProvider<StockReplenishController>(
        //     create: (context) => StockReplenishController(),
        //     builder: (context, child) {
        //       return Consumer<StockReplenishController>(
        //           builder: (BuildContext context, prdSCD, Widget? child) {
                return Scaffold(
                    resizeToAvoidBottomInset: false,
                    drawer: naviDrawer(context),
                    appBar:
                        appbar_Replenish("Stock Check ", theme, context),
                    body: const SafeArea(
                      child: TabStockReplenishScreen(
                      ),
                    ));
            //   });
            // });
      }
    });
  }
}
