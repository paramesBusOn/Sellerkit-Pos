// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, unused_local_variable

import 'package:flutter/material.dart';
import 'package:posproject/Widgets/Drawer.dart';
import 'package:provider/provider.dart';
import '../../../Controller/DepositController/DepositsController.dart';
import 'MobSettleScreen/MobSettleScreen.dart';
import 'TabSettleScreen/TabSettleScreen.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DepositsController>().init();
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Deposits Screen"),
            ),
            drawer: naviDrawer(context),
            body: ChangeNotifierProvider<DepositsController>(
                create: (context) => DepositsController(),
                builder: (context, child) {
                  return Consumer<DepositsController>(builder:
                      (BuildContext context, settleCon, Widget? child) {
                    return SafeArea(
                        child: SingleChildScrollView(
                            child: MobSettleScreen(
                      // settleCon: settleCon,
                    )));
                  });
                }));
      } else {
        return WillPopScope(
          onWillPop: context.read<DepositsController>().onbackpress,
          child: Scaffold(
              appBar: AppBar(
                title: Text("Deposits Screen"),
              ),
              drawer: naviDrawer(context),
              body: 
              // ChangeNotifierProvider<DepositsController>(
              //     create: (context) => DepositsController(),
              //     builder: (context, child) {
              //       return Consumer<DepositsController>(builder:
              //           (BuildContext context, settleCon, Widget? child) {
              //         return
                       SafeArea(
                          child: SingleChildScrollView(
                              child: TabSettleScreen(
                        // settleCon: settleCon,
                      ))),
                  //   });
                  // })
                  ),
        );
                
      } 
      // else
      //   return Scaffold(
      //       body: ChangeNotifierProvider<DepositsController>(
      //           create: (context) => DepositsController(),
      //           builder: (context, child) {
      //             return Consumer<DepositsController>(builder:
      //                 (BuildContext context, settleCon, Widget? child) {
      //               return SafeArea(
      //                   child: SingleChildScrollView(
      //                       child: PosSettleScreen(
      //                 settleCon: settleCon,
      //               )));
      //             });
      //           }));
    });
  }
}
