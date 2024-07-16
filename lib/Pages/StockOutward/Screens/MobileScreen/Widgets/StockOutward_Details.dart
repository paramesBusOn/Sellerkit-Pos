// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable, camel_case_types, avoid_print, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';


class StockOut_DetailsWidget extends StatelessWidget {
  StockOut_DetailsWidget({
    Key? key,
    required this.theme,
    required this.StOut_Con,
    required this.index,
    required this.SOut_Heigh,
    required this.SOut_Width,
    required this.data,
    required this.datatotal,
  }) : super(key: key);
  double SOut_Heigh;
  double SOut_Width;
  int index;
  final ThemeData theme;
  StockOutwardController StOut_Con;
  List<StockOutwardDetails>? data;
  List<StockOutwardList>? datatotal;

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // padding: EdgeInsets.only(
      //     right: SOut_Width * 0.017,
      //     left: SOut_Width * 0.017,
      //     top: SOut_Heigh * 0.012),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: SOut_Width,
            padding: EdgeInsets.all(
              SOut_Heigh * 0.01,
            ),
            // height: SOut_Heigh * 0.1,
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
                  width: SOut_Heigh * 0.3,
                  // color: Colors.amber,
                  child: Text("Request From ${datatotal![index].reqfromWhs}"),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  // width:SOut_Heigh * 0.2,
                  // color: Colors.amber,
                  child: Text("${datatotal![index].reqtransdate}"),
                )
              ],
            ),
          ),
          SizedBox(
            height: SOut_Heigh * 0.015,
          ),
          Container(
            height: SOut_Heigh * 0.79,
            width: SOut_Width,
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
                                  StOut_Con.valPass(data![i].Scanned_Qty!);
                                  StOut_Con.StOutController[0].text = "";
                                  StOut_Con.ScannigVal = data![i].Scanned_Qty!;
                                  StOut_Con.passindexBachPage(
                                      index, i, data![i]);
                                  StOut_Con.getBatchData(index, i);

                                  // StOut_Con.page.animateToPage(
                                  //     ++StOut_Con.pageIndex,
                                  //     duration: Duration(milliseconds: 400),
                                  //     curve: Curves.linearToEaseOut);
                                  // showDialog(
                                  //     context: context,
                                  //     barrierDismissible: false,
                                  //     builder: (BuildContext context) {
                                  //       return AlertDialog(
                                  //           shape: RoundedRectangleBorder(
                                  //               borderRadius: BorderRadius.all(
                                  //                   Radius.circular(4))),
                                  //           contentPadding: EdgeInsets.all(0),
                                  //           // backgroundColor: Colors.transparent,
                                  //           insetPadding: EdgeInsets.all(
                                  //               Screens.bodyheight(context) *
                                  //                   0.02),
                                  //           content: AlertBox(
                                  //             payMent: 'Stock Outward',
                                  //             widget: ScanAlertbox(
                                  //                 context,
                                  //                 StOut_Con,
                                  //                 data![i],
                                  //                 i,
                                  //                 index),
                                  //             buttonName: "Accept",
                                  //             callback: () {
                                  //               StOut_Con.AcceptButton(
                                  //                   i, index, context);
                                  //             },
                                  //           ));
                                  //     }).then((value) {
                                  //       StOut_Con.stoutLineRefersh(index, i);
                                  //     });
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(SOut_Heigh * 0.002),
                                  child: Container(
                                      width: SOut_Width * 0.95,
                                      // height: SOut_Heigh * 0.3,
                                      padding: EdgeInsets.all(
                                        SOut_Heigh * 0.008,
                                      ),
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
                                                          data![i]
                                                                  .Scanned_Qty! 
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
                                                        width:
                                                            SOut_Width * 0.48,
                                                        // color: Colors.amber,
                                                        // padding: EdgeInsets.all(
                                                        //     SOut_Heigh * 0.006),
                                                        decoration:
                                                            BoxDecoration(
                                                                // color: Colors.amber,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                        child: Text(
                                                          "${data![i].itemcode}",
                                                          // "${StOut_Con.getScanneditemData[index].ItemName}",
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
                                                            SOut_Heigh * 0.008,
                                                      ),
                                                      Container(
                                                        // padding: EdgeInsets.all(
                                                        //     SOut_Heigh * 0.001),
                                                        width: SOut_Width * 0.5,

                                                        // width: SOut_Width * 0.3,
                                                        decoration:
                                                            BoxDecoration(
                                                                // color: Colors.grey[600],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4)),
                                                        // color: Colors.blue,
                                                        child: Text(
                                                          "${data![i].serialBatch}",
                                                          // "${StOut_Con.getScanneditemData[index].SerialBatch}",
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
                                                      width: SOut_Width * 0.37,
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
                                                                      SOut_Width *
                                                                          0.17,
                                                                  padding: EdgeInsets.all(
                                                                      SOut_Heigh *
                                                                          0.006),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          // color: Colors.amber,
                                                                          borderRadius:
                                                                              BorderRadius.circular(4)),
                                                                  child: Text(
                                                                    "Req.Qty",
                                                                    // "${StOut_Con.getScanneditemData[index].ItemName}",
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
                                                                      SOut_Heigh *
                                                                          0.005),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width:
                                                                      SOut_Width *
                                                                          0.15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          // color: Colors.grey[600],
                                                                          borderRadius:
                                                                              BorderRadius.circular(4)),
                                                                  // color: Colors.blue,
                                                                  child: Text(
                                                                    "${data![i].qty}",
                                                                    // "${StOut_Con.getScanneditemData[index].SerialBatch}",
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
                                                                      SOut_Width *
                                                                          0.15,
                                                                  padding: EdgeInsets.all(
                                                                      SOut_Heigh *
                                                                          0.006),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          // color: Colors.amber,
                                                                          borderRadius:
                                                                              BorderRadius.circular(4)),
                                                                  child: Text(
                                                                    "Tra.Qty",
                                                                    // "${StOut_Con.getScanneditemData[index].ItemName}",
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
                                                                      SOut_Heigh *
                                                                          0.005),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width:
                                                                      SOut_Width *
                                                                          0.15,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          // color: Colors.grey[600],
                                                                          borderRadius:
                                                                              BorderRadius.circular(4)),
                                                                  // color: Colors.blue,
                                                                  child: Text(
                                                                    "${data![i].trans_Qty}",
                                                                    // "${StOut_Con.getScanneditemData[index].SerialBatch}",
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
                                                      // width: SOut_Width,
                                                      child: Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            // width: SOut_Width * 0.21,
                                                            // padding: EdgeInsets.all(SOut_Heigh * 0.006),
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
                                                            // padding: EdgeInsets.all(SOut_Heigh * 0.005),
                                                            alignment: Alignment
                                                                .centerRight,
                                                            // width: SOut_Width * 0.08,
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
                  // ElevatedButton(
                  //     onPressed: () {
                  //       StOut_Con.page.animateToPage(--StOut_Con.pageIndex,
                  //           duration: Duration(milliseconds: 800),
                  //           curve: Curves.linearToEaseOut);
                  //     },
                  //     child: Text("Back"))
                ],
              ),
            ),
          ),
          SizedBox(
            height: SOut_Heigh * 0.014,
          ),
          Padding(
            padding: EdgeInsets.all(SOut_Heigh * 0.006),
            child: Container(
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
              width: Screens.width(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        StOut_Con.holdbutton(
                            index, context, theme, data, datatotal![index]);
                        // StOut_Con.page.animateToPage(--StOut_Con.pageIndex,
                        //     duration: Duration(milliseconds: 1400),
                        //     curve: Curves.linearToEaseOut);
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
                        onPressed:StOut_Con.OnclickDisable ==false? () {
                          StOut_Con.submitbutton(
                              index, context, theme, data, datatotal![index]);
                          // StOut_Con.page.animateToPage(--StOut_Con.pageIndex,
                          //     duration: Duration(milliseconds: 1400),
                          //     curve: Curves.linearToEaseOut);

                          StOut_Con.myFuture(context,theme,data);
                          // Get.toNamed(ConstantRoutes.dashboard);
                          // StOut_Con.page.animateToPage(--StOut_Con.pageIndex,
                          //     duration: Duration(milliseconds: 1400),
                          //     curve: Curves.linearToEaseOut);
                        }:null,
                        child: Text("Submit",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white))),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // forSuspend(BuildContext contextt) {
  //   return Container(
  //       child: Column(
  //     children: [
  //       Container(
  //           // color: Colors.amber,
  //           padding: EdgeInsets.all(Screens.bodyheight(contextt) * 0.02),
  //           child: Center(
  //               child: Text(
  //             "You about to suspended all information will be unsaved",
  //             textAlign: TextAlign.center,
  //           ))),
  //       Padding(
  //         padding: EdgeInsets.all(Screens.bodyheight(contextt) * 0.008),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             GestureDetector(
  //                 onTap: () {

  //                   StOut_Con.suspendedbutton(
  //                       index, contextt, theme, data, datatotal![index]);

  //                        StOut_Con.page.animateToPage(--StOut_Con.pageIndex,
  //                           duration: Duration(milliseconds: 1400),
  //                           curve: Curves.linearToEaseOut);

  //                   Navigator.pop(contextt);
  //                 },
  //                 child: Container(
  //                   width: Screens.width(contextt) * 0.22,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       color: theme.primaryColor,
  //                       borderRadius: BorderRadius.circular(3),
  //                       border: Border.all(
  //                         color: theme.primaryColor,
  //                       )),
  //                   height: Screens.bodyheight(contextt) * 0.05,
  //                   child: Text("Yes",
  //                       style: theme.textTheme.bodyText2?.copyWith(
  //                         color: Colors.white,
  //                       )),
  //                 )),
  //             GestureDetector(
  //                 onTap: () {
  //                   Navigator.pop(contextt);
  //                 },
  //                 child: Container(
  //                   width: Screens.width(contextt) * 0.22,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(3),
  //                       color: theme.primaryColor,
  //                       border: Border.all(
  //                         color: theme.primaryColor,
  //                       )),
  //                   height: Screens.bodyheight(contextt) * 0.05,
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
                    StOut_Con.suspendedbutton(
                        index, context, theme, data, datatotal![index]);

                    // StOut_Con.page.animateToPage(--StOut_Con.pageIndex,
                    //     duration: Duration(milliseconds: 1400),
                    //     curve: Curves.linearToEaseOut);

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
