// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/ConstantRoutes.dart';
import 'package:posproject/Pages/DashBoard/Screens/WebPosScreens/dashboard_web.dart';
import 'package:posproject/Widgets/Drawer.dart';
import 'package:posproject/Widgets/MobileDrawer.dart';
import 'package:provider/provider.dart';

import '../../../Controller/DashBoardController/DashboardController.dart';
import '../../Sales Screen/Screens/Screens.dart';
import 'MobDashScreen/MobDashScreen.dart';
import 'PosDashScreen/PosDashScreen.dart';
import 'TabDashScreen/TabDashScreen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DashBoardController>().init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        // return ChangeNotifierProvider<DashBoardController>(
        //     create: (context) => DashBoardController(),
        //     builder: (context, child) {
        //       return Consumer<DashBoardController>(
        //           builder: (BuildContext context, prdDBC, Widget? child) {
        return WillPopScope(
          onWillPop: () async =>
              await context.read<DashBoardController>().onWillPop(context),
          child: Scaffold(
            drawer: naviDrawerMob(context),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PosMainScreens()));
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/cart.png'),
                )),
            body: SafeArea(
              child: MobDashScreen(
                prdDBC: context.read<DashBoardController>(),
                theme: theme,
              ),
            ),
          ),
        );
        //   });
        // });
      } else if (constraints.maxWidth <= 1300) {
        //1300
        return WillPopScope(
          onWillPop: () async =>
              await context.read<DashBoardController>().onWillPop(context),
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              drawer: naviDrawer(context),
              floatingActionButton: FloatingActionButton(
                backgroundColor: theme.primaryColor,
                  onPressed: () {
                    Get.toNamed(ConstantRoutes.sales);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => PosMainScreens()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(Icons.shopping_cart,),
                  )),
              body: SafeArea(
                child: TabDashScreen(
                  theme: theme,
                ),
              )),
        );

        //  }});
      } 
      else if (constraints.maxWidth >= 1300) {
        //1300
        return WillPopScope(
          onWillPop: () async =>
              await context.read<DashBoardController>().onWillPop(context),
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              drawer: naviDrawer(context),
              floatingActionButton: FloatingActionButton(
                backgroundColor: theme.primaryColor,
                  onPressed: () {
                    Get.toNamed(ConstantRoutes.sales);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => PosMainScreens()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: const Icon(Icons.shopping_cart,),
                  )),
              body: SafeArea(
                child: DashboardWeb(
                  theme: theme,
                ),
              )),
        );

        //  }});
      } else {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PosMainScreens()));
              },
              child: Container(
                alignment: Alignment.center,
                child: Image.asset('assets/cart.png'),
              )),

          //  Image.asset('assets/cart.png'),
          body: ChangeNotifierProvider<DashBoardController>(
              create: (context) => DashBoardController(),
              builder: (context, child) {
                return Consumer<DashBoardController>(
                    builder: (BuildContext context, prdDBC, Widget? child) {
                  return SafeArea(
                      child: PosDashScreen(
                    prdDBC: prdDBC,
                    theme: theme,
                  ));
                });
              }),
        );
      }
    });
  }
}
