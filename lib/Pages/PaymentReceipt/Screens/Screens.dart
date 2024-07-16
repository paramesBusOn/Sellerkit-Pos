// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:posproject/Widgets/ContentContainer.dart';
import 'package:provider/provider.dart';
import '../../../Controller/PaymentReceiptController/PayReceiptController.dart';
import '../../../Widgets/Drawer.dart';
import '../Widget/SearchBox.dart';
import 'PayMobile/Payment Receipt/Screens/PaymentReceipt.dart';
import 'PayTab/TabScreen.dart';

class PaymentReceiptScreens extends StatefulWidget {
  const PaymentReceiptScreens({
    Key? key,
    // required this.theme,
  }) : super(key: key);

  // final ThemeData theme;

  @override
  State<PaymentReceiptScreens> createState() => _PaymentReceiptScreensState();
}

class _PaymentReceiptScreensState extends State<PaymentReceiptScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<PayreceiptController>().init();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
          drawer: naviDrawer(context),
          body: ChangeNotifierProvider<PayreceiptController>(
              create: (context) => PayreceiptController(),
              builder: (context, child) {
                return Consumer<PayreceiptController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                    child: MobPaymentReceipt(payCD: prdSCD),
                    // scaffoldKey: scaffoldKey,
                  );
                });
              }),
        );
      } else {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: naviDrawer(context),
            body:
                //  ChangeNotifierProvider<PayreceiptController>(
                //     create: (context) => PayreceiptController(),
                //     builder: (context, child) {
                //       return Consumer<PayreceiptController>(
                //           builder: (BuildContext context, prdSCD, Widget? child) {
                SafeArea(
              child: Column(children: <Widget>[
                AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payment Receipt'),
                      Container(
                        child: Row(
                          children: [
                            StatefulBuilder(builder: (context, st) {
                              return GestureDetector(
                                onTap: () {
                                  st(() {
                                    context
                                        .read<PayreceiptController>()
                                        .searchInitMethod();
                                    context
                                        .read<PayreceiptController>()
                                        .getSalesDataDatewise(
                                            context
                                                .read<PayreceiptController>()
                                                .config
                                                .alignDate(context
                                                    .read<
                                                        PayreceiptController>()
                                                    .config
                                                    .currentDate()),
                                            context
                                                .read<PayreceiptController>()
                                                .config
                                                .alignDate(context
                                                    .read<
                                                        PayreceiptController>()
                                                    .config
                                                    .currentDate()));
                                    context
                                        .read<PayreceiptController>()
                                        .getSalesDataDatewise(
                                            context
                                                .read<PayreceiptController>()
                                                .config
                                                .alignDate(context
                                                    .read<
                                                        PayreceiptController>()
                                                    .config
                                                    .currentDate()),
                                            context
                                                .read<PayreceiptController>()
                                                .config
                                                .alignDate(context
                                                    .read<
                                                        PayreceiptController>()
                                                    .config
                                                    .currentDate()));
                                  });

                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            contentPadding: EdgeInsets.all(0),
                                            content: AlertBox(
                                                payMent: 'Search',
                                                buttonName: null,
                                                widget: PaymentRecieptSearhBox(
                                                  theme: theme,
                                                  searchHeight:
                                                      Screens.bodyheight(
                                                              context) *
                                                          0.76,
                                                  searchWidth:
                                                      Screens.width(context),
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
                              );
                            }),
                            SizedBox(width: Screens.width(context) * 0.02),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      // print(
                                      //     "onHoldFilter.length:${context.read<PayreceiptController>().onHoldFilter!.length}");
                                      return AlertDialog(
                                          contentPadding: EdgeInsets.all(0),
                                          content: AlertBox(
                                              payMent: 'Draft bills',
                                              buttonName: null,
                                              widget: context
                                                      .read<
                                                          PayreceiptController>()
                                                      .onHoldFilter!
                                                      .isEmpty
                                                  ? ContentContainer(
                                                      content:
                                                          " No Draft bills",
                                                      theme: theme)
                                                  : StatefulBuilder(
                                                      builder: (context, st) {
                                                      return Container(
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Container(
                                                                width: Screens
                                                                        .width(
                                                                            context) *
                                                                    1.1,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          240,
                                                                          235,
                                                                          235)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.01),
                                                                ),
                                                                child:
                                                                    TextFormField(
                                                                  controller: context
                                                                      .read<
                                                                          PayreceiptController>()
                                                                      .mycontroller[2],
                                                                  cursorColor:
                                                                      Colors
                                                                          .grey,
                                                                  onChanged:
                                                                      (v) {
                                                                    st(() {
                                                                      context
                                                                          .read<
                                                                              PayreceiptController>()
                                                                          .filterListOnHold(
                                                                              v);
                                                                    });
                                                                  },
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'Search..!!',
                                                                    hintStyle: theme
                                                                        .textTheme
                                                                        .bodyLarge
                                                                        ?.copyWith(
                                                                            color:
                                                                                Colors.grey),
                                                                    filled:
                                                                        false,
                                                                    enabledBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    focusedBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          25,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: Screens
                                                                          .bodyheight(
                                                                              context) *
                                                                      0.05),
                                                              SizedBox(
                                                                  height: Screens
                                                                          .bodyheight(
                                                                              context) *
                                                                      0.7,
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      1.1,
                                                                  child: ListView
                                                                      .builder(
                                                                          itemCount: context
                                                                              .watch<
                                                                                  PayreceiptController>()
                                                                              .onHoldFilter!
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                                // log("VVVVVVV::"+context.watch<PayreceiptController>().config.aligntimeDate(context.watch<PayreceiptController>().onHoldFilter![index].createdateTime.toString()));
                                                                            return Card(
                                                                              child: Container(
                                                                                padding: EdgeInsets.only(top: Screens.bodyheight(context) * 0.01, left: Screens.width(context) * 0.01, right: Screens.width(context) * 0.01, bottom: Screens.bodyheight(context) * 0.03),
                                                                                // height: custHeight * 0.2,
                                                                                child: ListTile(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                    context.read<PayreceiptController>().mapHoldValues(index, context, theme);

                                                                                    // showDialog(
                                                                                    //     context: context,
                                                                                    //     barrierDismissible: true,
                                                                                    //     builder: (BuildContext context) {
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
                                                                                    //                                 context.read<PayreceiptController>().mapHoldValues(index, context, theme);
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
                                                                                  title: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Container(
                                                                                            child: Text(context.watch<PayreceiptController>().onHoldFilter![index].cardCode ?? ''),
                                                                                          ),
                                                                                          Container(
                                                                                            child: Text(context.watch<PayreceiptController>().config.aligntimeDate(context.watch<PayreceiptController>().onHoldFilter![index].createdateTime.toString())),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Container(
                                                                                            child: Text(context.watch<PayreceiptController>().onHoldFilter![index].custName ?? ''),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            payMent: 'Account Refresh',
                                            buttonName: null,
                                            widget: ContentContainer(
                                                content: "Account Refresh",
                                                theme: theme),
                                          ));
                                    });
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    "Account Refresh",
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
                                            payMent: 'Access Til',
                                            buttonName: null,
                                            widget: ContentContainer(
                                                content: "Access Til",
                                                theme: theme),
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
                                      child: Icon(Icons.auto_mode_outlined)),
                                  Text(
                                    'Access Til',
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
                                            payMent: 'Dual Screen',
                                            buttonName: null,
                                            widget: ContentContainer(
                                                content: "Dual Screen",
                                                theme: theme),
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
                                      child: Icon(Icons.screenshot_outlined)),
                                  Text('Dual Screen',
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(color: Colors.white))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                PaymentTab(
                  theme: theme,
                ),
              ]),
            )
            //   });
            // }),
            );
      }
      //  else {
      //   return Scaffold(
      //     body: ChangeNotifierProvider<PayreceiptController>(
      //         create: (context) => PayreceiptController(),
      //         builder: (context, child) {
      //           return Consumer<PayreceiptController>(
      //               builder: (BuildContext context, prdSCD, Widget? child) {
      //             return SafeArea(
      //                 child: PaymentRecieptPos(
      //               theme:theme,
      //               prdSCD: prdSCD,
      //             ));
      //           });
      //         }),
      //   );
      // }
    });
  }
}
