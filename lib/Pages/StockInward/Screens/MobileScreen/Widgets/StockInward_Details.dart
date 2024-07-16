// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable, camel_case_types, avoid_print, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';

import '../../../../../Constant/Screen.dart';
import '../../../../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';


class StockIn_DetailsWidget extends StatelessWidget {
  StockIn_DetailsWidget({
    Key? key,
    required this.theme,
    required this.StIn_Con,
    required this.index,
    required this.SIN_Heigh,
    required this.SIN_Width,
    required this.data,
    required this.datatotal,
  }) : super(key: key);
  double SIN_Heigh;
  double SIN_Width;
  int index;
  final ThemeData theme;
  StockInwrdController StIn_Con;
  List<StockInwardDetails>? data;
  List<StockInwardList>? datatotal;

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
          right: SIN_Heigh * 0.012,
          left: SIN_Heigh * 0.012,
          top: SIN_Heigh * 0.012),
      child: Column(
        children: [
          Container(
            width: SIN_Width,
            padding: EdgeInsets.all(
              SIN_Heigh * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: SIN_Heigh * 0.3,
                  // color: Colors.amber,
                  child: Text("Request From ${datatotal![index].reqtoWhs}"),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  // width: SIN_Heigh * 0.2,
                  // color: Colors.amber,
                  child: Text("${datatotal![index].reqtransdate}"),
                )
              ],
            ),
          ),
          SizedBox(
            height: SIN_Heigh * 0.01,
          ),
          Container(
            height: SIN_Heigh * 0.79,
            width: SIN_Width,
            // padding: EdgeInsets.all(
            //   SIN_Heigh * 0.008,
            // ),

            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(), // new

                      itemCount: data!.length,
                      itemBuilder: (context, i) {
                        return data!.isEmpty
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : InkWell(
                                onTap: () {
                                  //   List<String> sample=["as","as","fds"
                                  // ];
                                  //   StIn_Con.test2![0].addAll(sample);
                                  // print(StIn_Con.test2);
                                  StIn_Con.valPass(data![i].Scanned_Qty!);
                                  StIn_Con.StInController[0].text = "";
                                  StIn_Con.ScannigVal = data![i].Scanned_Qty!;
                                  StIn_Con.passindexBachPage(
                                      index, i, data![i]);
                                  // StIn_Con.getBatchData(index, i);

                                  StIn_Con.page.animateToPage(
                                      ++StIn_Con.pageIndex,
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.linearToEaseOut);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(SIN_Heigh * 0.002),
                                  child: Container(
                                      // width: SIN_Width * 0.95,
                                      // height: SIN_Heigh * 0.3,
                                      // padding: EdgeInsets.all(
                                      //   SIN_Heigh * 0.008,
                                      // ),
                                      decoration: BoxDecoration(
                                        color: data![i].Scanned_Qty != 0 &&
                                                data![i].qty !=
                                                    data![i].Scanned_Qty!
                                            ? Color(0xFFfcedee)
                                            : data![i].Scanned_Qty != 0 &&
                                                    data![i].qty ==
                                                        data![i].Scanned_Qty!
                                                ? Color(0xFFebfaef)
                                                : data![i].Scanned_Qty == 0 &&
                                                        data![i].qty !=
                                                            data![i]
                                                                .Scanned_Qty!
                                                    ? Colors.white
                                                    : Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        border: Border.all(
                                          color: data![i].Scanned_Qty != 0 &&
                                                  data![i].qty !=
                                                      data![i].Scanned_Qty!
                                              ? Colors.red.withOpacity(0.3)
                                              : data![i].Scanned_Qty != 0 &&
                                                      data![i].qty ==
                                                          data![i].Scanned_Qty!
                                                  ? Colors.green
                                                      .withOpacity(0.3)
                                                  : data![i].Scanned_Qty == 0 &&
                                                          data![i].qty !=
                                                              data![i]
                                                                  .Scanned_Qty!
                                                      ? Colors.white
                                                      : Colors.white,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: SIN_Width * 0.48,
                                                        // color: Colors.amber,
                                                        // padding: EdgeInsets.all(
                                                        //     SIN_Heigh * 0.006),
                                                        decoration:
                                                            BoxDecoration(
                                                                // color: Colors.amber,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                        child: Text(
                                                          "${data![i].itemcode}",
                                                          // "${StIn_Con.getScanneditemData[index].ItemName}",
                                                          style: theme.textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                            // fontSize: 12,
                                                            color: Colors.black,
                                                            // fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            SIN_Heigh * 0.008,
                                                      ),
                                                      Container(
                                                        // padding: EdgeInsets.all(
                                                        //     SIN_Heigh * 0.001),
                                                        width: SIN_Width * 0.5,

                                                        // width: SIN_Width * 0.3,
                                                        decoration:
                                                            BoxDecoration(
                                                                // color: Colors.grey[600],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                        // color: Colors.blue,
                                                        child: Text(
                                                          " ${data![i].serialBatch}",
                                                          // "${StIn_Con.getScanneditemData[index].SerialBatch}",
                                                          style: theme.textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                            // fontSize: 12,
                                                            color: Colors.black,
                                                            // fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                //
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      width: SIN_Width * 0.37,
                                                      // color: Colors.blue,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width:
                                                                      SIN_Width *
                                                                          0.17,
                                                                  padding: EdgeInsets.all(
                                                                      SIN_Heigh *
                                                                          0.006),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          // color: Colors.amber,
                                                                          borderRadius:
                                                                              BorderRadius.circular(4)),
                                                                  child: Text(
                                                                    "Req.Qty",
                                                                    // "${StIn_Con.getScanneditemData[index].ItemName}",
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .copyWith(
                                                                      // fontSize: 12,
                                                                      color: Colors
                                                                          .black,
                                                                      // fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.all(
                                                                      SIN_Heigh *
                                                                          0.005),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width:
                                                                      SIN_Width *
                                                                          0.15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          // color: Colors.grey[600],
                                                                          borderRadius:
                                                                              BorderRadius.circular(4)),
                                                                  // color: Colors.blue,
                                                                  child: Text(
                                                                    "${data![i].qty}",
                                                                    // "${StIn_Con.getScanneditemData[index].SerialBatch}",
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .copyWith(
                                                                      // fontSize: 12,
                                                                      color: Colors
                                                                          .black,
                                                                      // fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Column(
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width:
                                                                      SIN_Width *
                                                                          0.15,
                                                                  padding: EdgeInsets.all(
                                                                      SIN_Heigh *
                                                                          0.006),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          // color: Colors.amber,
                                                                          borderRadius:
                                                                              BorderRadius.circular(4)),
                                                                  child: Text(
                                                                    "Tra.Qty",
                                                                    // "${StIn_Con.getScanneditemData[index].ItemName}",
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .copyWith(
                                                                      // fontSize: 12,
                                                                      color: Colors
                                                                          .black,
                                                                      // fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.all(
                                                                      SIN_Heigh *
                                                                          0.005),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width:
                                                                      SIN_Width *
                                                                          0.15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          // color: Colors.grey[600],
                                                                          borderRadius:
                                                                              BorderRadius.circular(4)),
                                                                  // color: Colors.blue,
                                                                  child: Text(
                                                                    "${data![i].trans_Qty}",
                                                                    // "${StIn_Con.getScanneditemData[index].SerialBatch}",
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .copyWith(
                                                                      // fontSize: 12,
                                                                      color: Colors
                                                                          .black,
                                                                      // fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      // width: SIN_Width,
                                                      child: Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            // width: SIN_Width * 0.21,
                                                            // padding: EdgeInsets.all(SIN_Heigh * 0.006),
                                                            decoration:
                                                                BoxDecoration(
                                                                    // color: Colors.amber,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
                                                            child: Text(
                                                              "Scanned Qty - ",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                // fontSize: 12,
                                                                color:
                                                                    Colors.grey,
                                                                // fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            // width: SIN_Width * 0.08,
                                                            decoration:
                                                                BoxDecoration(
                                                                    // color: Colors.grey[600],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4)),
                                                            child: Text(
                                                              "${data![i].Scanned_Qty}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ],
                                      )),
                                ),
                              );
                      }),
                ],
              ),
            ),
          ),
          SizedBox(
            height: SIN_Heigh * 0.01,
          ),
          Container(
            padding: EdgeInsets.all(SIN_Heigh * 0.005),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            // width: Screens.width(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      forSuspend(context, theme);
                    },
                    child: Text(
                      "Suspended",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: theme.primaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                          color: theme.primaryColor,
                          width: Screens.width(context) * 0.001),
                    ),
                  ),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      StIn_Con.holdbutton(
                          index, context, theme, data, datatotal![index]);
                      StIn_Con.page.animateToPage(--StIn_Con.pageIndex,
                          duration: Duration(milliseconds: 1400),
                          curve: Curves.linearToEaseOut);
                    },
                    child: Text(
                      "Hold",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: theme.primaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                          color: theme.primaryColor,
                          width: Screens.width(context) * 0.001),
                    ),
                  ),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        side: BorderSide(
                            color: theme.primaryColor,
                            width: Screens.width(context) * 0.001),
                      ),
                      onPressed:StIn_Con.OnclickDisable==false? () async {
                        StIn_Con.submitbutton(
                            index, context, theme, data, datatotal![index]);
                        StIn_Con.page.animateToPage(--StIn_Con.pageIndex,
                            duration: Duration(milliseconds: 1400),
                            curve: Curves.linearToEaseOut);
                        StIn_Con.myFuture(context,theme,data);
                        // await new Future.delayed(new Duration(seconds: 2));
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => DashBoardScreen()));
                      }:null,
                      child: Text("Submit",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // forSuspend(BuildContext context) {
  //   return Container(
  //       child: Column(
  //     children: [
  //       Container(
  //           // color: Colors.amber,
  //           padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
  //           child: Center(
  //               child: Text(
  //             "You about to suspended all information will be unsaved",
  //             textAlign: TextAlign.center,
  //           ))),
  //       Padding(
  //         padding: EdgeInsets.all(Screens.bodyheight(context) * 0.008),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             GestureDetector(
  //                 onTap: () {
  //                   StIn_Con.page.animateToPage(--StIn_Con.pageIndex,
  //                       duration: Duration(milliseconds: 400),
  //                       curve: Curves.linearToEaseOut);
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   width: Screens.width(context) * 0.22,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       color: theme.primaryColor,
  //                       borderRadius: BorderRadius.circular(3),
  //                       border: Border.all(
  //                         color: theme.primaryColor,
  //                       )),
  //                   height: Screens.bodyheight(context) * 0.05,
  //                   child: Text("Yes",
  //                       style: theme.textTheme.bodyText2?.copyWith(
  //                         color: Colors.white,
  //                       )),
  //                 )),
  //             GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Container(
  //                   width: Screens.width(context) * 0.22,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(3),
  //                       color: theme.primaryColor,
  //                       border: Border.all(
  //                         color: theme.primaryColor,
  //                       )),
  //                   height: Screens.bodyheight(context) * 0.05,
  //                   child: Text("No",
  //                       style: theme.textTheme.bodyText2?.copyWith(
  //                         color: Colors.white,
  //                       )),
  //                 )),
  //           ],
  //         ),
  //       ),
  //     ],
  //   ));
  // }

  forSuspend(BuildContext context, ThemeData theme) {
    return Get.defaultDialog(
        title: "Alert",
        middleText: "You about to suspended all information will be unsaved",
        backgroundColor: Colors.white,
        titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
        middleTextStyle: theme.textTheme.bodyLarge,
        radius: 0,
        // onCancel: (){},
        // onConfirm: (){},
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    StIn_Con.suspendedbutton(
                        index, context, theme, data, datatotal![index]);

                    StIn_Con.page.animateToPage(--StIn_Con.pageIndex,
                        duration: Duration(milliseconds: 1400),
                        curve: Curves.linearToEaseOut);

                    Navigator.pop(context);
                  },
                  child: Container(
                    width: Screens.width(context) * 0.22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.bodyheight(context) * 0.05,
                    child: Text("Yes",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        )),
                  )),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: Screens.width(context) * 0.22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: theme.primaryColor,
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.bodyheight(context) * 0.05,
                    child: Text("No",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        )),
                  )),
            ],
          ),
        ]);
  }
}
