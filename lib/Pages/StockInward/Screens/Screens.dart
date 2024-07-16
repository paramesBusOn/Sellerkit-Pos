// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_const_constructors_in_immutables, unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Pages/StockInward/Screens/TabScreen/StockInTab.dart';
import 'package:posproject/Pages/StockInward/Widgets/M_StIn_Appbar.dart';
import 'package:posproject/Pages/StockInward/Widgets/STinward_Appbar.dart';
import 'package:posproject/Widgets/MobileDrawer.dart';
import 'package:provider/provider.dart';
import '../../../../Controller/StockInwardController/StockInwardContler.dart';

import '../../../Widgets/Drawer.dart';
import '../Widgets/Tap_stockInItemDeatils.dart';
import 'MobileScreen/Screens/StockInward.dart';
import 'PosScreen/StockInPos.dart';

class StockInwardScreens extends StatefulWidget {
  StockInwardScreens({
    Key? key,
  }) : super(key: key);

  @override
  State<StockInwardScreens> createState() => _StockInwardScreensState();
}

class _StockInwardScreensState extends State<StockInwardScreens> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<StockInwrdController>().clearDataAll();
        context.read<StockInwrdController>().init();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return ChangeNotifierProvider<StockInwrdController>(
            create: (context) => StockInwrdController(),
            builder: (context, child) {
              return Consumer<StockInwrdController>(
                  builder: (BuildContext context, StIn_Con, Widget? child) {
                return WillPopScope(
                    onWillPop: (() {
                      StIn_Con.page.previousPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear,
                      );
                      return Future.value(false);
                    }),
                    child: Scaffold(
                        resizeToAvoidBottomInset: false,
                        appBar: StIn_appbar(
                            "Stock Inward", theme, context, StIn_Con),
                        drawer: naviDrawerMob(context),
                        backgroundColor: Colors.grey[200],
                        body: SafeArea(
                          child: StockInward(theme: theme, StIn_Con: StIn_Con),
                        )));
              });
            });
      } else {
        return Scaffold(
            drawer: naviDrawer(context),
            body: SingleChildScrollView(
              child: Column(
                children: [
                context.watch<StockInwrdController>().isselect == false
                ?  SingleChildScrollView(
                      child: Column(children: [
                        Inward_appbar("Stock Inward", theme, context),
                        StockInTab(theme: theme),
                      ]),
                ):Container(),

                context.watch<StockInwrdController>().isselect == true
                ? SingleChildScrollView(
                    child: Column(children: [
                          Inward_appbar("Stock Inward", theme, context),
                          StockInTabPageviewerSecond(theme: theme),
                    ]),
                  ):Container()
                ],
              ),
            ));
      }
    });
  }
}
