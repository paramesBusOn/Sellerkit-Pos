// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import '../../../../../Constant/Screen.dart';
import '../../../Widgets/ContentContainer.dart';
import '../Screens/MobileScreen/Widgets/M_Draftbill.dart';


AppBar StIn_appbar(String titles, ThemeData theme, BuildContext context,
    StockInwrdController posController) {
  final theme = Theme.of(context);
  // final GlobalKey<ScaffoldState> Key = GlobalKey<ScaffoldState>();

  return AppBar(
    backgroundColor: theme.primaryColor,
    // bottom: TabBar(
    //   labelStyle: theme.textTheme.bodySmall!.copyWith(),
    //   tabs: const [
    //     Tab(
    //       text: ("Customer\n   Details"),
    //     ),
    //     Tab(
    //       text: ("Product Details"),
    //     ),
    //     Tab(
    //       text: ("Payment"),
    //     )
    //   ],
    // ),
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            //  _Key.currentState!.openDrawer();
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),

    toolbarHeight: Screens.padingHeight(context) * 0.08, // Set this height
    title: Text(
      titles,
      style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
    ),
    actions: [
      Container(
        width: Screens.width(context) * 0.1,
        height: Screens.padingHeight(context) * 0.06,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(25),
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
          // image: DecorationImage(
          //     image: AssetImage('Assets/dashboardlogo.png'),
          //     fit: BoxFit.fill)
        ),
        child: PopupMenuButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          itemBuilder: (ctx) => [
            PopupMenuItem(
              child: Center(
                  child: IconButton(
                      tooltip: "Draft Bills",
                      onPressed: () {
                        print(posController.savedraftBill.length);
                        // posController.gethold();
                        if (posController.savedraftBill.isEmpty) {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    content: AlertBox(
                                      payMent: 'Draft bills',
                                      buttonName: null,
                                      widget: ContentContainer(
                                          content: "Draft bills", theme: theme),
                                    ));
                              });
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    contentPadding: EdgeInsets.all(0),
                                    // backgroundColor: Colors.transparent,
                                    insetPadding: EdgeInsets.all(
                                        Screens.bodyheight(context) * 0.02),
                                    content: AlertBox(
                                        payMent: 'Draft bills',
                                        buttonName: null,
                                        widget: M_StockInDraftbill(
                                            theme: theme,
                                            prdsrch: posController,
                                            searchHeight:
                                                Screens.bodyheight(context) *
                                                    0.5,
                                            searchWidth:
                                                Screens.width(context) * 0.9,
                                            StockIn:
                                                posController.savedraftBill)));
                              });
                        }
                      },
                      icon: Icon(
                        Icons.ballot_outlined,
                        color: theme.primaryColor,
                      ))),
              value: 1,
            ),
            PopupMenuItem(
                child: Center(
                    child: IconButton(
                        tooltip: "Stock Refresh",
                        onPressed: () {},
                        icon: Icon(
                          Icons.autorenew_outlined,
                          color: theme.primaryColor,
                        ))),
                value: 2),
            PopupMenuItem(
                child: Center(
                    child: IconButton(
                        tooltip: "Printers",
                        onPressed: () {},
                        icon: Icon(
                          Icons.print_outlined,
                          color: theme.primaryColor,
                        ))),
                value: 3),
            PopupMenuItem(
                child: Center(
                    child: IconButton(
                        tooltip: "Access Til",
                        onPressed: () {},
                        icon: Icon(
                          Icons.auto_mode_outlined,
                          color: theme.primaryColor,
                        ))),
                value: 4),
            PopupMenuItem(
                child: Center(
                    child: IconButton(
                        tooltip: "Dual Screen",
                        onPressed: () {},
                        icon: Icon(
                          Icons.screenshot_outlined,
                          color: theme.primaryColor,
                        ))),
                value: 5)
          ],
          onSelected: (id) {
            if (id == 1) {
              print(posController.savedraftBill.length);

              if (posController.savedraftBill.isEmpty) {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: EdgeInsets.all(0),
                          content: AlertBox(
                            payMent: 'Draft bills',
                            buttonName: null,
                            widget: ContentContainer(
                                content: "Draft bills", theme: theme),
                          ));
                    });
              } else {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: EdgeInsets.all(0),
                          content: AlertBox(
                              payMent: 'Draft bills',
                              buttonName: null,
                              widget: M_StockInDraftbill(
                                  theme: theme,
                                  prdsrch: posController,
                                  searchHeight:
                                      Screens.bodyheight(context) * 0.5,
                                  searchWidth: Screens.width(context) * 0.9,
                                  StockIn: posController.savedraftBill)));
                    });
              }
            }
            if (id == 2) {
              // Perform action on click on Upload
            }
            if (id == 3) {
              // Perform action on click on Exit
            }
            if (id == 4) {
              // Perform action on click on Upload
            }
            if (id == 5) {
              // Perform action on click on Exit
            }
          },
        ),
      )
    ],
  );
}
