// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:posproject/Controller/ExpenseController/ExpenseController.dart';

import '../../../../Constant/Screen.dart';
import '../../../Sales Screen/Screens/MobileScreenSales/WidgetsMob/ContentcontainerMob.dart';
import '../../../../Widgets/AlertBox.dart';

AppBar appbarMSExpense(String titles, ThemeData theme, BuildContext context,
    ExpenseController posController) {
  final theme = Theme.of(context);

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
        ],
      ),
    ),

    actions: [
      //list if widget in appbar actions
      PopupMenuButton(itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Draft Bills"),
                Icon(
                  Icons.ballot_outlined,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Stock Refresh"),
                Icon(
                  Icons.autorenew_outlined,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Printers"),
                Icon(
                  Icons.print_outlined,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Access Til"),
                Icon(
                  Icons.auto_mode_outlined,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Dual Screen"),
                Icon(
                  Icons.screenshot_outlined,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
        ];
      }, onSelected: (value) {
        if (value == 0) {
          print("My account menu is selected.");
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                posController.mycontroller[3].clear();
                return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    contentPadding: const EdgeInsets.all(0),
                    // backgroundColor: Colors.transparent,
                    insetPadding:
                        EdgeInsets.all(Screens.bodyheight(context) * 0.02),
                    content: posController.onhold.isEmpty
                        ? ContentWidgetMob(theme: theme, msg: "No draft bill")
                        : StatefulBuilder(builder: (context, st) {
                            return SizedBox(
                              width: Screens.width(context),
                              child: Column(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: Screens.width(context),
                                      height:
                                          Screens.padingHeight(context) * 0.05,
                                      color: theme.primaryColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: Screens.padingHeight(
                                                        context) *
                                                    0.02,
                                                right: Screens.padingHeight(
                                                        context) *
                                                    0.02),
                                            // color: Colors.red,
                                            width: Screens.width(context) * 0.7,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Draft Bills",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                size: Screens.padingHeight(
                                                        context) *
                                                    0.025,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              Screens.padingHeight(context) *
                                                  0.01,
                                          horizontal:
                                              Screens.width(context) * 0.01),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 1.1,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 240, 235, 235)),
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color:
                                                  Colors.grey.withOpacity(0.01),
                                            ),
                                            child: TextFormField(
                                              controller:
                                                  posController.mycontroller[3],
                                              cursorColor: Colors.grey,
                                              onChanged: (v) {
                                                st(() {
                                                  posController
                                                      .filterListOnHold(v);
                                                });
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Search hold bills..!!',
                                                hintStyle: theme
                                                    .textTheme.bodyLarge
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                                filled: true,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 12,
                                                  horizontal: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.01),
                                          SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.5,
                                              width:
                                                  Screens.width(context) * 1.1,
                                              child: ListView.builder(
                                                  itemCount: posController
                                                      .onholdfilter.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            top: Screens
                                                                    .padingHeight(
                                                                        context) *
                                                                0.0,
                                                            left: Screens.width(
                                                                    context) *
                                                                0.01,
                                                            right: Screens.width(
                                                                    context) *
                                                                0.01,
                                                            bottom: Screens
                                                                    .padingHeight(
                                                                        context) *
                                                                0.03),
                                                        // height: custHeight * 0.2,
                                                        child: ListTile(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            posController
                                                                .mapHoldValues(
                                                                    index,
                                                                    context,
                                                                    theme);

                                                            // showDialog(
                                                            //     context:
                                                            //         context,
                                                            //     barrierDismissible:
                                                            //         true,
                                                            //     builder:
                                                            //         (BuildContext
                                                            //             context) {
                                                            //       return AlertDialog(
                                                            //           contentPadding:
                                                            //               const EdgeInsets
                                                            //                   .all(
                                                            //                   0),
                                                            //           content: AlertBox(
                                                            //               payMent: 'Alert',
                                                            //               widget: Container(
                                                            //                 // width:
                                                            //                 //     Screens.width(context) * 0.6,
                                                            //                 padding:
                                                            //                     EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.04, vertical: Screens.bodyheight(context) * 0.01),
                                                            //                 child:
                                                            //                     Column(
                                                            //                   children: [
                                                            //                     Container(alignment: Alignment.center, width: Screens.width(context) * 0.8,
                                                            //                     child:  Center(child: Text('You are about to continue the sales transaction this draft will be created now..!!'))),
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
                                                            //                                 posController.mapHoldValues(index, context, theme);
                                                            //                                 Navigator.pop(context);
                                                            //                               },
                                                            //                               child: const Text("Yes")),
                                                            //                         ),
                                                            //                         SizedBox(
                                                            //                           width: Screens.width(context) * 0.15,
                                                            //                           child: ElevatedButton(
                                                            //                               onPressed: () {
                                                            //                                 Navigator.pop(context);
                                                            //                               },
                                                            //                               child: const Text("No")),
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    child: Text(posController
                                                                        .onholdfilter[
                                                                            index]
                                                                        .expensecode!),
                                                                  ),
                                                                  // Container(
                                                                  //     child: Text(posController
                                                                  //         .config
                                                                  //         .currentDate())
                                                                  //     // .onHoldFilter![
                                                                  //     //     index]
                                                                  //     // .invoceDate!),
                                                                  //     ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    child: Text(posController
                                                                        .onholdfilter[
                                                                            index]
                                                                        .rcamount!),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        const Text(
                                                                            ""),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  })),
                                        ],
                                      ),
                                    ),

                                    //  SizedBox(height:  Screens.padingHeight(context) * 0.09),
                                  ]),
                            );
                          })
                    // AlertBox(
                    //     payMent: 'Draft bills',
                    //     buttonName: null,
                    //     widget: )
                    );
              });
        } else if (value == 1) {
          print("Settings menu is selected.");
        } else if (value == 2) {
          print("Logout menu is selected.");
        } else if (value == 3) {
          print("Logout menu is selected.");
        } else if (value == 4) {
          print("Logout menu is selected.");
        }
      }),
    ],
  );
}