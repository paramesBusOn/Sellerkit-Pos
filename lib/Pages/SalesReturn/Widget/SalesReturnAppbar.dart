// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/SalesReturnController/SalesReturnController.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/ContentContainer.dart';
import '../../../Widgets/AlertBox.dart';
import 'SearchBox.dart';

AppBar SalesReturnappbar(
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
                  context.read<SalesReturnController>().searchInitMethod();
                  context.read<SalesReturnController>().getSalesDataDatewise(
                      context.read<SalesReturnController>().config.alignDate(
                          context
                              .read<SalesReturnController>()
                              .config
                              .currentDate()),
                      context.read<SalesReturnController>().config.alignDate(
                          context
                              .read<SalesReturnController>()
                              .config
                              .currentDate()));
                  context.read<SalesReturnController>().getSalesDataDatewise(
                      context.read<SalesReturnController>().config.alignDate(
                          context
                              .read<SalesReturnController>()
                              .config
                              .currentDate()),
                      context.read<SalesReturnController>().config.alignDate(
                          context
                              .read<SalesReturnController>()
                              .config
                              .currentDate()));
                  // showDialog<dynamic>(
                  //     context: context,
                  //     builder: (_) {
                  //       return saleReturnSearhBox(
                  //         theme: theme,
                  //         searchHeight: Screens.bodyheight(context) * 0.9,
                  //         searchWidth: Screens.width(context) * 0.49,
                  //         SalesReturnCon: salesReturnController,
                  //       );
                  //     });
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: EdgeInsets.all(0),
                            content: AlertBox(
                                payMent: 'Search',
                                buttonName: null,
                                widget: saleReturnSearhBox(
                                  theme: theme,
                                  searchHeight:
                                      Screens.bodyheight(context) * 0.77,
                                  searchWidth: Screens.width(context),
                                )));
                      });
                },
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.search)),
                    Text(
                      'Search',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              SizedBox(width: Screens.width(context) * 0.02),
              GestureDetector(
                onTap: () {
                  // print(
                  //     'salesReturnController .onHoldFilter!.length:${salesReturnController!.onHoldFilter!.length}');
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: EdgeInsets.all(0),
                            content: AlertBox(
                                payMent: 'Draft bills',
                                buttonName: null,
                                widget:
                                    context
                                            .read<SalesReturnController>()
                                            .onHoldFilter!
                                            .isEmpty
                                        ? ContentContainer(
                                            content: "No Draft bills",
                                            theme: theme)
                                        : StatefulBuilder(
                                            builder: (context, st) {
                                            return Container(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          1.1,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    240,
                                                                    235,
                                                                    235)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                        color: Colors.grey
                                                            .withOpacity(0.01),
                                                      ),
                                                      child: TextFormField(
                                                        controller: context
                                                            .watch<
                                                                SalesReturnController>()
                                                            .mycontroller[2],
                                                        cursorColor:
                                                            Colors.grey,
                                                        onChanged: (v) {
                                                          st(() {
                                                            context
                                                                .read<
                                                                    SalesReturnController>()
                                                                .filterListOnHold(
                                                                    v);
                                                          });
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              'Search hold bills..!!',
                                                          hintStyle: theme
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .grey),
                                                          filled: false,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 12,
                                                            horizontal: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: Screens
                                                                .padingHeight(
                                                                    context) *
                                                            0.05),
                                                    SizedBox(
                                                        height: Screens
                                                                .padingHeight(
                                                                    context) *
                                                            0.7,
                                                        width: Screens.width(
                                                                context) *
                                                            1.1,
                                                        child: ListView.builder(
                                                            itemCount: context
                                                                .watch<
                                                                    SalesReturnController>()
                                                                .onHoldFilter!
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              log(" context.watch<  SalesReturnController>() .onHoldFilter! .length${context
                                                                      .watch<
                                                                          SalesReturnController>()
                                                                      .onHoldFilter!
                                                                      .length}");
                                                              return Card(
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.only(
                                                                      top: Screens.padingHeight(context) *
                                                                          0.01,
                                                                      left: Screens.width(
                                                                              context) *
                                                                          0.01,
                                                                      right: Screens.width(
                                                                              context) *
                                                                          0.01,
                                                                      bottom: Screens.padingHeight(
                                                                              context) *
                                                                          0.03),
                                                                  // height: custHeight * 0.2,
                                                                  child:
                                                                      ListTile(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      context.read<SalesReturnController>().mapHoldValues(
                                                                          index,
                                                                          context,
                                                                          theme);
                                                                      // showDialog(
                                                                      //     context:
                                                                      //         context,
                                                                      //     barrierDismissible:
                                                                      //         true,
                                                                      //     builder:
                                                                      //         (BuildContext context) {
                                                                      //       return AlertDialog(
                                                                      //           contentPadding: EdgeInsets.all(0),
                                                                      //           content: AlertBox(
                                                                      //               payMent: 'Alert',
                                                                      //               widget: Container(
                                                                      //                 width: Screens.width(context) * 0.6,
                                                                      //                 padding: EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.04, vertical: Screens.bodyheight(context) * 0.01),
                                                                      //                 child: Column(
                                                                      //                   children: [
                                                                      //                     Container(alignment: Alignment.center, width: Screens.width(context) * 0.8, child: Center(child: Text('You are about to continue the sales transaction this draft will be created now..!!'))),
                                                                      //                     SizedBox(
                                                                      //                       height: Screens.bodyheight(context) * 0.01,
                                                                      //                     ),
                                                                      //                     Row(
                                                                      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      //                       children: [
                                                                      //                         SizedBox(
                                                                      //                           width: Screens.width(context) * 0.15,
                                                                      //                           child: ElevatedButton(
                                                                      //                               onPressed: () {
                                                                      //                                 Navigator.pop(context);
                                                                      //                                 context.read<SalesReturnController>().mapHoldValues(index, context, theme);
                                                                      //                                 Navigator.pop(context);
                                                                      //                               },
                                                                      //                               child: Text("Yes")),
                                                                      //                         ),
                                                                      //                         SizedBox(
                                                                      //                           width: Screens.width(context) * 0.15,
                                                                      //                           child: ElevatedButton(
                                                                      //                               onPressed: () {
                                                                      //                                 Navigator.pop(context);
                                                                      //                               },
                                                                      //                               child: Text("No")),
                                                                      //                         ),
                                                                      //                       ],
                                                                      //                     )
                                                                      //                   ],
                                                                      //                 ),
                                                                      //               ),
                                                                      //               buttonName: null));
                                                                      //     });
                                                                    },
                                                                    title:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              child: Text(context.watch<SalesReturnController>().onHoldFilter![index].cardCode!),
                                                                            ),
                                                                            Container(
                                                                              child: Text(context.watch<SalesReturnController>().config.aligntimeDate(context.watch<SalesReturnController>().onHoldFilter![index].createdateTime!)),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              child: Text(context.watch<SalesReturnController>().onHoldFilter![index].custName!),
                                                                            ),
                                                                            Container(
                                                                              child: Text(""),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            })),
                                                  ]),
                                            );
                                          })));
                      });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.ballot_outlined)),
                    Text(
                      'Draft Bills',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
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
                            contentPadding: EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Stock Refresh',
                              buttonName: null,
                              widget: ContentContainer(
                                  content: "Stock Refresh", theme: theme),
                            ));
                      });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.autorenew_outlined)),
                    Text(
                      "Stock Refresh",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
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
                            contentPadding: EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Print',
                              buttonName: null,
                              widget: ContentContainer(
                                  content: "Print", theme: theme),
                            ));
                      });
                },
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.print_outlined)),
                    Text(
                      'Printers',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )
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