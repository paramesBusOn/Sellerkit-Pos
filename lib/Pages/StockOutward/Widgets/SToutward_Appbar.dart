import 'package:flutter/material.dart';
import 'package:posproject/Pages/StockOutward/Widgets/Draftbillr.dart';
import 'package:posproject/Pages/StockOutward/Widgets/SearchBox.dart';
import 'package:provider/provider.dart';
import 'package:posproject/Widgets/AlertBox.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../Widgets/ContentContainer.dart';

// import 'SearchBox.dart';

AppBar Outward_appbar(
  String titles,
  ThemeData theme,
  BuildContext context,
) {
  final theme = Theme.of(context);
  // final GlobalKey<ScaffoldState> Key = GlobalKey<ScaffoldState>();

  return AppBar(
    backgroundColor: theme.primaryColor,
    automaticallyImplyLeading: false,
    // centerTitle: true,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    // toolbarHeight: Screens.padingHeight(context) * 0.08, // Set this height
    title: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titles),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<StockOutwardController>().searchInitMethod();
                  context
                      .read<StockOutwardController>()
                      .getSalesDataDatewise(context.read<StockOutwardController>().config.alignDate(context.read<StockOutwardController>().config.currentDate()), context.read<StockOutwardController>().config.alignDate(context.read<StockOutwardController>().config.currentDate()));

                  context
                      .read<StockOutwardController>()
                      .getSalesDataDatewise(context.read<StockOutwardController>().config.alignDate(context.read<StockOutwardController>().config.currentDate()), context.read<StockOutwardController>().config.alignDate(context.read<StockOutwardController>().config.currentDate()));

                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            content: AlertBox(
                                payMent: 'Search',
                                buttonName: null,
                                widget: StConSearhBox(
                                  theme: theme,
                                  searchHeight: Screens.bodyheight(context) * 0.8,
                                  searchWidth: Screens.width(context) * 0.955,
                                )));
                      });
                },
                child: Column(
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: const Icon(Icons.search)),
                    Text(
                      'Search',
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(width: Screens.width(context) * 0.02),
              GestureDetector(
                onTap: () {
                  print(context.read<StockOutwardController>().savedraftBill.length);

                  if (context.read<StockOutwardController>().savedraftBill.isEmpty) {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              contentPadding: const EdgeInsets.all(0),
                              content: AlertBox(
                                payMent: 'Draft bills',
                                buttonName: null,
                                widget: ContentContainer(content: "Draft bills", theme: theme),
                              ));
                        });
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              contentPadding: const EdgeInsets.all(0),
                              content: AlertBox(payMent: 'Draft bills', buttonName: null, widget: StockOutDraftbill(theme: theme, searchHeight: Screens.bodyheight(context) * 0.9, searchWidth: Screens.width(context) * 0.49, StockOut: context.watch<StockOutwardController>().savedraftBill)));
                        });
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: const Icon(Icons.ballot_outlined)),
                    Text(
                      'Draft Bills',
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(width: Screens.width(context) * 0.02),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Stock Refresh',
                              buttonName: null,
                              widget: ContentContainer(content: "Stock Refresh", theme: theme),
                            ));
                      });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: const Icon(Icons.autorenew_outlined)),
                    Text(
                      "Stock Refresh",
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(width: Screens.width(context) * 0.02),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Print',
                              buttonName: null,
                              widget: ContentContainer(content: "Print", theme: theme),
                            ));
                      });
                },
                child: Column(
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: const Icon(Icons.print_outlined)),
                    Text(
                      'Printers',
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(width: Screens.width(context) * 0.02),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Access Til',
                              buttonName: null,
                              widget: ContentContainer(content: "Access Til", theme: theme),
                            ));
                      });
                },
                child: Column(
                  children: [
                    Container(
                        // width: Screens.width(context) * 0.18,
                        // height: Screens.padingHeight(context) * 0.06,
                        decoration: const BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: const Icon(Icons.auto_mode_outlined)),
                    Text(
                      'Access Til',
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(width: Screens.width(context) * 0.02),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Dual Screen',
                              buttonName: null,
                              widget: ContentContainer(content: "Dual Screen", theme: theme),
                            ));
                      });
                },
                child: Column(
                  children: [
                    Container(
                        // width: Screens.width(context) * 0.18,
                        // height: Screens.padingHeight(context) * 0.06,
                        decoration: const BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: const Icon(Icons.screenshot_outlined)),
                    Text('Dual Screen', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
