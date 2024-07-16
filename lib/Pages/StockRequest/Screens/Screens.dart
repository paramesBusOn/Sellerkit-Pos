import 'package:flutter/material.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:posproject/Pages/StockRequest/Widget/STReq_Appbar.dart';

import 'package:posproject/Widgets/MobileDrawer.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/Drawer.dart';
import 'StockMobile/Screens/Mobile.dart';
import 'StockMobile/Widgets/M_StIn_Appbar.dart';
import 'StockReqTab/TabScreen.dart';

class StockReqScreens extends StatefulWidget {
  const StockReqScreens({
    Key? key,
  }) : super(key: key);

  @override
  State<StockReqScreens> createState() => _StockReqScreensState();
}

class _StockReqScreensState extends State<StockReqScreens> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        // context.read<StockReqController>().searchclear();
        context.read<StockReqController>().init();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        // return ChangeNotifierProvider<StockReqController>(
        //     create: (context) => StockReqController(),
        //     builder: (context, child) {
        //       return Consumer<StockReqController>(
        //           builder: (BuildContext context, StReq_Con, Widget? child) {
        return WillPopScope(
            onWillPop: (() {
              //   StIn_Con.page.previousPage(
              //   duration: Duration(milliseconds: 200),
              //   curve: Curves.linear,
              // );
              return Future.value(true);
            }),
            child: Scaffold(
                appBar: appbarSReqMS("Inventory Transfer Request", theme, context,
                    posController: context.read<StockReqController>()),
                drawer: naviDrawerMob(context),

                // drawer: M_naviDrawer(context),
                backgroundColor: Colors.grey[200],
                body: SafeArea(
                    child: StockReqMob(
                        SR_Con: context.read<StockReqController>()))));
        //   });
        // });
      } else {
        return Scaffold(
            drawer: naviDrawer(context),
            body:
                //  ChangeNotifierProvider<StockReqController>(
                //     create: (context) => StockReqController(),
                //     builder: (context, child) {
                //       return Consumer<StockReqController>(
                //           builder: (BuildContext context, prdSCD, Widget? child) {
                //         return LayoutBuilder(builder: (context, constraints) {
                //           return
                SafeArea(
              child: SingleChildScrollView(
                child: Column(children: [
                  SReq_appbar("Inventory Transfer Request", theme, context),
                  // naviDrawer(context),
                  StockReqTab(
                    theme: theme,
                  ),
                ]),
              ),
            )
            // });
            //   });
            // })
            );
      }
    });
  }
}

// return Scaffold(
//     drawer: naviDrawer(context),
//     body: ChangeNotifierProvider<PosController>(
//         create: (context) => PosController(),
//         builder: (context, child) {
//           return Consumer<PosController>(
//               builder: (BuildContext context, prdSCD, Widget? child) {
//             return LayoutBuilder(
//               builder: (context, constraints) {
//                    if (constraints.maxWidth <= 568) {
//           return StockReqMob();
//         }
//              else if (constraints.maxWidth <= 1168) {
//                 return
//                 Container(
//                   child: Column(
//                     children:[
//                     appbar("Stock Request", widget.theme, context),
//                     StockReqTab(
//                       theme: widget.theme, prdSCD: prdSCD),
//                   ]),
//                 );
//               } else
//                 return StockReqPos( theme: widget.theme,prdSCD: prdSCD,);
//                 //
//                 //   prdSCD: prdSCD,
//                 // );
//             });
//           });
//         }));
