// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';

// class StockOutward extends StatefulWidget {
//   StockOutward(
//       {Key? key,
//       required this.theme,
//       required this.stockInWidth,
//       required this.stockInheight,
//       required this.index,
//       required this.data,
//       required this.datatotal}):super(key: key);
//   ThemeData theme;
//   double stockInheight;
//   double stockInWidth;
//   int index;
//   List<StockOutwardDetails>? data;
//   List<StockOutwardList>? datatotal;

//   @override
//   State<StockOutward> createState() => _StockOutwardState();
// }

// class _StockOutwardState extends State<StockOutward> {
//   @override
//   Widget build(BuildContext context) {

//     return
StockOutward(
    ThemeData theme,
    double stockInWidth,
    double stockInheight,
    int index,
    List<StockOutwardDetails>? data,
    List<StockOutwardList>? datatotal,
    BuildContext context) {
  final theme = Theme.of(context);
  return StatefulBuilder(builder: (context, st) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: stockInheight * 0.01,
            left: stockInheight * 0.01,
            right: stockInheight * 0.01,
            bottom: stockInheight * 0.01,
          ),
          decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {
                context.read<StockOutwardController>().deleteoutdata();
              },
              child: SizedBox(
                  width: stockInWidth * 0.5,
                  child: Text(
                    'Item Name',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: Colors.white),
                  )),
            ),
            Container(
                alignment: Alignment.center,
                width: stockInWidth * 0.15,
                child: Text(
                  'Requested Quantity',
                  style:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                )),
            Container(
                alignment: Alignment.center,
                width: stockInWidth * 0.15,
                child: Text(
                  'Transfered Quantity',
                  style:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                )),
            Container(
                alignment: Alignment.center,
                width: stockInWidth * 0.15,
                child: Text(
                  'Scanned Quantity',
                  style:
                      theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                ))
          ]),
        ),
        Container(
          // color: Colors.green,
          height: stockInheight * 0.77,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 3,
              //     blurRadius: 7,
              //     offset: Offset(0, 3), // changes position of shadow
              //   ),
              // ],
              ),
          child: context.read<StockOutwardController>().StockOutward2.isNotEmpty
              ? ListView.builder(
                  itemCount: context
                      .watch<StockOutwardController>()
                      .StockOutward2[0]
                      .data
                      .length,
                  itemBuilder: (context, i) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          // StOut_Con.valPass(StOut_Con
                          //     .StockOutward2[index].data[i].Scanned_Qty!);
                          // StOut_Con.StOutController[0].text = "";
                          // StOut_Con.ScannigVal = StOut_Con
                          //     .StockOutward2[index].data[i].Scanned_Qty!;
                          // // posC.Scanloop(data![i].serialbatch, i);
                          // // data![i].serialBatch!;
                          // StOut_Con.Selectindex2(i);
                          // StOut_Con.passindexBachPage(
                          //     index, i, StOut_Con.StockOutward2[index].data[i]);

                          // StOut_Con.getBatchData(index, i);
                          // StOut_Con.tappage.animateToPage(
                          //     ++StOut_Con.tappageIndex,
                          //     duration: Duration(milliseconds: 400),
                          //     curve: Curves.linearToEaseOut);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => MyDialog(
                          //           StOut_Con: StOut_Con,
                          //           datalist: data![i],
                          //           ind: i,
                          //           index: index)),
                          // );
                          // showDialog<dynamic>(
                          // context: context,
                          // builder: (_) {
                          //   return MyDialog(StOut_Con: StOut_Con, datalist: data![i], ind: i, index: index);
                          // });
                          // showDialog(
                          //     context: context,
                          //     barrierDismissible: true,
                          //     builder: (BuildContext context) {
                          //       return ChangeNotifierProvider.value(
                          //         value: StOut_Con,
                          //         child: AlertDialog(
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.all(
                          //                     Radius.circular(4))),
                          //             contentPadding: EdgeInsets.all(0),
                          //             // backgroundColor: Colors.transparent,
                          //             insetPadding: EdgeInsets.all(
                          //                 Screens.bodyheight(context) * 0.02),

                          //             // contentPadding: EdgeInsets.all(0),
                          //             content: AlertBox(
                          //                 payMent: 'Stock Outward',
                          //                 widget: forInwardScan(context,
                          //                     StOut_Con, data![i], i, index),
                          //                 buttonName: null)),
                          //       );
                          //     }).then((value) => {});
                          // print(data![i].serialbatch![i].Serialbatch);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: stockInheight * 0.008,
                            left: stockInheight * 0.01,
                            right: stockInheight * 0.01,
                            bottom: stockInheight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: Screens.width(context) * 0.001,
                              color: Colors.white,
                            ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    // color: Colors.amber,
                                    width: stockInWidth * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${context.watch<StockOutwardController>().StockOutward2[0].data[i].itemcode}",
                                          style: theme.textTheme.bodyLarge,
                                          // maxLines: 2,
                                        ),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              " ${context.watch<StockOutwardController>().StockOutward2[0].data[i].serialBatch}",
                                              style: theme.textTheme.bodyLarge,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.amber,
                                    alignment: Alignment.center,
                                    width: stockInWidth * 0.15,
                                    child: Text(
                                      "${context.watch<StockOutwardController>().StockOutward2[0].data[i].qty}",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: stockInWidth * 0.15,
                                    child: Text(
                                      "${context.watch<StockOutwardController>().StockOutward2[0].data[i].trans_Qty}",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: stockInWidth * 0.15,
                                    child: Text(
                                      "${context.watch<StockOutwardController>().StockOutward2[0].data[i].Scanned_Qty}",
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    );
                  })
              : ListView.builder(
                  itemCount: data!.length,
                  controller:
                      context.read<StockOutwardController>().scrollController,
                  itemBuilder: (context, i) {
                    return data.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Card(
                            child: InkWell(
                              onTap: () {
                                st(() {
                                

                                  context
                                      .read<StockOutwardController>()
                                      .valPass(data[i].Scanned_Qty!);
                                  context
                                      .read<StockOutwardController>()
                                      .StOutController[0]
                                      .text = "";
                                  context
                                      .read<StockOutwardController>()
                                      .ScannigVal = data[i].Scanned_Qty!;
                                  context
                                      .read<StockOutwardController>()
                                      .Selectindex2(i);
                                  context
                                      .read<StockOutwardController>()
                                      .passindexBachPage(index, i, data[i]); 
                                       context
                                      .read<StockOutwardController>()
                                      .isselectmethod();
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: stockInheight * 0.008,
                                  left: stockInheight * 0.01,
                                  right: stockInheight * 0.01,
                                  bottom: stockInheight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: data[i].Scanned_Qty != 0 &&
                                          data[i].qty != data[i].Scanned_Qty!
                                      ? Color(0xFFfcedee)
                                      : data[i].Scanned_Qty != 0 &&
                                              data[i].qty ==
                                                  data[i].Scanned_Qty!
                                          ? Color(0xFFebfaef)
                                          : data[i].Scanned_Qty == 0 &&
                                                  data[i].qty !=
                                                      data[i].Scanned_Qty!
                                              ? Colors.grey.withOpacity(0.04)
                                              : Colors.grey.withOpacity(0.04),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: Screens.width(context) * 0.001,
                                    color: data[i].Scanned_Qty != 0 &&
                                            data[i].qty != data[i].Scanned_Qty!
                                        ? Colors.red.withOpacity(0.3)
                                        : data[i].Scanned_Qty != 0 &&
                                                data[i].qty ==
                                                    data[i].Scanned_Qty!
                                            ? Colors.green.withOpacity(0.3)
                                            : data[i].Scanned_Qty == 0 &&
                                                    data[i].qty !=
                                                        data[i].Scanned_Qty!
                                                ? Colors.white
                                                : Colors.white,
                                  ),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          // color: Colors.amber,
                                          width: stockInWidth * 0.5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${data[i].itemcode}",
                                                style:
                                                    theme.textTheme.bodyLarge,
                                                // maxLines: 2,
                                              ),
                                              Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    " ",
                                                    style: theme
                                                        .textTheme.bodyLarge,
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.amber,
                                          alignment: Alignment.center,
                                          width: stockInWidth * 0.15,
                                          child: Text(
                                            "${data[i].qty}",
                                            style: theme.textTheme.bodyLarge,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: stockInWidth * 0.15,
                                          child: Text(
                                            "${data[i].trans_Qty}",
                                            style: theme.textTheme.bodyLarge,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          width: stockInWidth * 0.15,
                                          child: Text(
                                            "${data[i].Scanned_Qty}",
                                            style: theme.textTheme.bodyLarge,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          );
                  }),
        ),
        SizedBox(
          height: stockInheight * 0.008,
        ),
        Container(
          padding: EdgeInsets.only(
            top: stockInheight * 0.01,
            left: stockInheight * 0.01,
            right: stockInheight * 0.01,
            bottom: stockInheight * 0.01,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 3,
              //     blurRadius: 7,
              //     offset: Offset(0, 3), // changes position of shadow
              //   ),
              // ],
              ),
          child:
              context.watch<StockOutwardController>().StockOutward2.isNotEmpty
                  ? Container(
                      alignment: Alignment.center,
                      // width: stockInWidth * 1,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(3),
                        // color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<StockOutwardController>()
                            .StOutController2[50],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyMedium?.copyWith(),
                        onChanged: (v) {},
                        readOnly: true,
                        decoration: InputDecoration(
                          // hintText: "Remarks",
                          filled: false,
                          labelText: "Remarks",

                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      // width: stockInWidth * 1,
                      decoration: BoxDecoration(
                        // color: Colors.red,

                        borderRadius: BorderRadius.circular(3),
                        // color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<StockOutwardController>()
                            .StOutController[50],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyMedium?.copyWith(),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' Please Enter the Remark';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Remarks",
                          filled: false,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
        ),
        Container(
          padding: EdgeInsets.only(
            top: stockInheight * 0.01,
            left: stockInheight * 0.01,
            right: stockInheight * 0.01,
            bottom: stockInheight * 0.01,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 3,
            //     blurRadius: 7,
            //     offset: Offset(0, 3), // changes position of shadow
            //   ),
            // ],
          ),
          height: stockInheight * 0.095,
          child: context
                  .watch<StockOutwardController>()
                  .StockOutward2
                  .isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () {
                          st(() {
                            context.read<StockOutwardController>().cancelbtn =
                                true;
                            context
                                .read<StockOutwardController>()
                                .clickcancelbtn(context, theme);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: stockInheight * 0.9,
                          width: stockInWidth * 0.25,
                          child: context
                                      .watch<StockOutwardController>()
                                      .cancelbtn ==
                                  false
                              ? Text("Cancel",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.black,
                                  ))
                              : CircularProgressIndicator(
                                  color: theme.primaryColor),
                        )),
                    GestureDetector(
                        onTap: () {
                          st(() {
                            //
                            context.read<StockOutwardController>().cancelbtn =
                                false;
                            context
                                .read<StockOutwardController>()
                                .StockOutward
                                .clear();
                            context
                                .read<StockOutwardController>()
                                .StockOutward2
                                .clear();
                            context
                                .read<StockOutwardController>()
                                .getStockReqData();
                            context
                                .read<StockOutwardController>()
                                .StOutController2[50]
                                .text = "";
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: stockInheight * 0.9,
                          width: stockInWidth * 0.25,
                          child: Text("Clear",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.black,
                              )),
                        )),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      // alignment: Alignment.center,
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(
                      //       color: theme.primaryColor,
                      //     )),
                      height: stockInheight * 0.9,
                      width: stockInWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                // width: 5.0,
                                color: theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<StockOutwardController>()
                                      .OnclickDisable ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<StockOutwardController>()
                                      .OnclickDisable = true;
                                  if (datatotal!.isEmpty) {
                                    Get.defaultDialog(
                                            // content: Container(
                                            //   width: Screens.width(context) * 0.4,
                                            //   height: Screens.bodyheight(context) * 0.1,
                                            // ),
                                            title: "Alert",
                                            middleText: 'No Data Found..!!',
                                            backgroundColor: Colors.white,
                                            titleStyle: theme
                                                .textTheme.bodyLarge!
                                                .copyWith(color: Colors.red),
                                            middleTextStyle:
                                                theme.textTheme.bodyLarge,
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    child: Text("Close"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            radius: 5)
                                        .then((value) {
                                      context
                                          .watch<StockOutwardController>()
                                          .OnclickDisable = false;
                                    });
                                  } else {
                                    // showDialog(
                                    //         context: context,
                                    //         barrierDismissible: true,
                                    //         builder: (BuildContext context) {
                                    //           return AlertDialog(
                                    //               contentPadding: EdgeInsets.all(0),
                                    //               content: AlertBox(
                                    //                 payMent: 'Suspended',
                                    // widget:
                                    forSuspend(context, theme, index, data!,
                                        datatotal);
                                  }
                                  //         buttonName: null,
                                  //       ));
                                  // });
                                  context
                                      .read<StockOutwardController>()
                                      .disableKeyBoard(context);
                                  context
                                      .read<StockOutwardController>()
                                      .OnclickDisable = false;
                                },
                          child: Text(
                            "Suspend",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          )),
                    ),
                    SizedBox(
                      // alignment: Alignment.center,
                      // decoration: BoxDecoration(
                      //     // color: Colors.grey[200],
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(
                      //       color: theme.primaryColor,
                      //     )),
                      height: stockInheight * 0.9,
                      width: stockInWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                // width: 5.0,
                                color: theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<StockOutwardController>()
                                      .OnclickDisable ==
                                  true
                              ? null
                              : () {
                                 
                                  if (datatotal!.isEmpty) {
                                     context
                                      .read<StockOutwardController>()
                                      .OnclickDisable = true;
                                    Get.defaultDialog(
                                            // content: Container(
                                            //   width: Screens.width(context) * 0.4,
                                            //   height: Screens.bodyheight(context) * 0.1,
                                            // ),
                                            title: "Alert",
                                            middleText: 'No Data Found..!!',
                                            backgroundColor: Colors.white,
                                            titleStyle: theme
                                                .textTheme.bodyLarge!
                                                .copyWith(color: Colors.red),
                                            middleTextStyle:
                                                theme.textTheme.bodyLarge,
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    child: Text("Close"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            radius: 5)
                                        .then((value) {
                                      context
                                          .read<StockOutwardController>()
                                          .OnclickDisable = false;
                                    });
                                  } else if (data!.isEmpty) {
                                     context
                                      .read<StockOutwardController>()
                                      .OnclickDisable = true;
                                    Get.defaultDialog(
                                            // content: Container(
                                            //   width: Screens.width(context) * 0.4,
                                            //   height: Screens.bodyheight(context) * 0.1,
                                            // ),
                                            title: "Alert",
                                            middleText:
                                                'Please Choose Item..!!',
                                            backgroundColor: Colors.white,
                                            titleStyle: theme
                                                .textTheme.bodyLarge!
                                                .copyWith(color: Colors.red),
                                            middleTextStyle:
                                                theme.textTheme.bodyLarge,
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    child: Text("Close"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            radius: 5)
                                        .then((value) {
                                      context
                                          .read<StockOutwardController>()
                                          .OnclickDisable = false;
                                    });
                                  } else {
                                     context
                                      .read<StockOutwardController>()
                                      .OnclickDisable = true;
                                    // StOut_Con.saveValuesTODB(
                                    //     "hold", context, theme, index,data,datatotal![index]);
                                    context
                                        .read<StockOutwardController>()
                                        .holdbutton(index, context, theme, data,
                                            datatotal[index]);
                                  }
                                  context
                                      .read<StockOutwardController>()
                                      .disableKeyBoard(context);

                                  // context
                                  //     .read<StockOutwardController>()
                                  //     .OnclickDisable = false;

                                  // StOut_Con.HoldMethod(
                                  //     context, theme, data, datatotal, index);
                                },
                          child: Text(
                            "Hold",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          )),
                    ),
                    SizedBox(
                      height: stockInheight * 0.9,
                      width: stockInWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                          ),
                          onPressed: context
                                      .read<StockOutwardController>()
                                      .OnclickDisable ==
                                  false
                              ? () {
                                  context
                                      .read<StockOutwardController>()
                                      .OnclickDisable = true;
                                  if (datatotal!.isEmpty) {
                                    Get.defaultDialog(
                                            title: "Alert",
                                            middleText: 'No Data Found..!!',
                                            backgroundColor: Colors.white,
                                            titleStyle: theme
                                                .textTheme.bodyLarge!
                                                .copyWith(color: Colors.red),
                                            middleTextStyle:
                                                theme.textTheme.bodyLarge,
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    child: Text("Close"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            radius: 5)
                                        .then((value) {
                                      context
                                          .read<StockOutwardController>()
                                          .OnclickDisable = false;
                                    });
                                  } else if (data!.isEmpty) {
                                    Get.defaultDialog(
                                            title: "Alert",
                                            middleText:
                                                'Please Choose Item..!!',
                                            backgroundColor: Colors.white,
                                            titleStyle: theme
                                                .textTheme.bodyLarge!
                                                .copyWith(color: Colors.red),
                                            middleTextStyle:
                                                theme.textTheme.bodyLarge,
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    child: Text("Close"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            radius: 5)
                                        .then((value) {
                                      context
                                          .read<StockOutwardController>()
                                          .OnclickDisable = false;
                                    });
                                  } else {
                                    context
                                        .read<StockOutwardController>()
                                        .submitbutton(index, context, theme,
                                            data, datatotal[index]);
                                    context
                                        .read<StockOutwardController>()
                                        .myFuture(context, theme, data);
                                  }
                                  context
                                      .read<StockOutwardController>()
                                      .disableKeyBoard(context);
                                  // context
                                  //     .read<StockOutwardController>()
                                  //     .OnclickDisable = false;
                                }
                              : null,
                          child: Text(
                            "Submit",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          )),
                    ),
                  ],
                ),
        )
      ],
    );
  });
}

forSuspend(
  BuildContext context,
  ThemeData theme,
  int index,
  List<StockOutwardDetails>? data,
  List<StockOutwardList>? datatotal,
) {
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
                  Navigator.pop(context);
                  context.read<StockOutwardController>().suspendedbutton(
                      index, context, theme, data, datatotal![index]);
                },
                child: Container(
                  width: Screens.width(context) * 0.1,
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
                  width: Screens.width(context) * 0.1,
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
// StatefulBuilder forInwardScan(
//     BuildContext context,
//     StockOutwardController StOut_Con,
//     StockOutwardDetails? datalist,
//     int? ind,
//     int? index
//     // List<StockInwardList>? datatotal
//     ) {
//   return StatefulBuilder(builder: (context, st) {
//     return Container(
//       width: stockInWidth * 1.2,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(
//             height: stockInheight * 0.01,
//           ),
//           Container(
//               alignment: Alignment.center,
//               width: stockInWidth * 1.18,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Color.fromARGB(255, 207, 201, 201)),
//                 borderRadius: BorderRadius.circular(3),
//                 color: Colors.grey.withOpacity(0.01),
//               ),
//               child: TextFormField(
//                 style: theme.textTheme.bodyText2,
//                 cursorColor: Colors.grey,
//                 controller: StOut_Con.StOutController[0],
//                 onEditingComplete: () {
//                   st(() {
//                     // StOut_Con.scanmethod(
//                     //     index!, datalist!.serialBatch!, ind!);
//                     // StOut_Con.disableKeyBoard(context);
//                     // StOut_Con.scanmethod(index, datalist!.serialBatch!, ind!,);
//                     // StOut_Con.scan3(datalist,
//                     //     StOut_Con.StOutController[0].text, Stock_i, StList_i);
//                   });
//                 },
//                 onChanged: (v) {
//                   if (v.isNotEmpty) {
//                     st(() {
//                       StOut_Con.msg = "";
//                     });
//                   }
//                 },
//                 decoration: InputDecoration(
//                   filled: false,
//                   hintText: 'Scan Here..',
//                   hintStyle: theme.textTheme.bodyText2?.copyWith(
//                       //  color: Colors.grey
//                       //   fontWeight: FontWeight.normal
//                       ),
//                   enabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(
//                     vertical: 15,
//                     horizontal: 10,
//                   ),
//                 ),
//               )),
//           Row(
//             children: [
//               Text(
//                 "  ${StOut_Con.msg}",
//                 style: theme.textTheme.bodySmall!
//                     .copyWith(color: Colors.red),
//               ),
//             ],
//           ),
//           SizedBox(height: stockInheight * 0.008),
//           Container(
//             width: stockInWidth * 1.18,
//             height: stockInheight * 0.6,
//             // color: Colors.red,
//             child: datalist!.serialbatchList == null
//                 ? Center(
//                     child: Text("Scan Item.."),
//                   )
//                 : ListView.builder(
//                     itemCount: datalist.serialbatchList!.length,
//                     physics: BouncingScrollPhysics(),
//                     itemBuilder: (context, i) {
//                       return Card(
//                         child: Container(
//                           padding: EdgeInsets.only(
//                             top: stockInheight * 0.01,
//                             left: stockInheight * 0.01,
//                             right: stockInheight * 0.01,
//                             bottom: stockInheight * 0.01,
//                           ),
//                           decoration: BoxDecoration(
//                               color:
//                                   //  datalist.serialbatchList![i].scanbool ==
//                                   //         true
//                                   //     ? Color(0xFFebfaef)
//                                   //     :
//                                   Colors.white,
//                               border: Border.all(
//                                   color:
//                                       // datalist.serialbatchList![i].scanbool ==
//                                       //         true
//                                       //     ? Colors.green.withOpacity(0.3)
//                                       //     :
//                                       Colors.white),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.5),
//                                   spreadRadius: 3,
//                                   blurRadius: 7,
//                                   offset: Offset(
//                                       0, 3), // changes position of shadow
//                                 ),
//                               ]),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       // color: Colors.amber,
//                                       width: stockInWidth * 0.4,
//                                       child: Text(
//                                         "${datalist.serialbatchList![i].itemcode}",
//                                         style:
//                                             theme.textTheme.bodyText1,
//                                       ),
//                                     ),
//                                     // Container(
//                                     //   alignment: Alignment.center,
//                                     //   // color: Colors.amber,
//                                     //   width: stockInWidth * 0.35,
//                                     //   child: Text(
//                                     //     "${datalist.serialbatchList![i].docentry}",
//                                     //     style: theme.textTheme.bodyText1,
//                                     //   ),
//                                     // ),
//                                     Container(
//                                       alignment: Alignment.centerRight,
//                                       // color: Colors.amber,
//                                       width: stockInWidth * 0.35,
//                                       child: Text(
//                                         "${datalist.serialbatchList![i].serialbatch}",
//                                         style:
//                                             theme.textTheme.bodyText1,
//                                       ),
//                                     ),
//                                   ]),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     alignment: Alignment.centerLeft,
//                                     // color: Colors.amber,
//                                     width: stockInWidth * 0.4,
//                                     child: Text(
//                                       "Scanned Qty : ${datalist.Scanned_Qty}",
//                                       style: theme.textTheme.bodyText1,
//                                     ),
//                                   ),
//                                   Container(
//                                       alignment: Alignment.center,
//                                       // color: Colors.amber,
//                                       height: stockInheight * 0.06,
//                                       width: stockInWidth * 0.1,
//                                       decoration: BoxDecoration(
//                                           color: Colors.blue,
//                                           shape: BoxShape.circle),
//                                       child: IconButton(
//                                           color: Colors.white,
//                                           padding: EdgeInsets.zero,
//                                           iconSize: 18,
//                                           onPressed: () {
//                                             st(() {
//                                               StOut_Con.scanqtyRemove(
//                                                   index!, ind!, i);
//                                             });
//                                           },
//                                           icon: Icon(Icons.remove))),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//           ),
//           SizedBox(
//             height: stockInheight * 0.05,
//           ),
//           GestureDetector(
//               onTap: () {
//                 // StOut_Con.AcceptButton(ind!, index!, context);
//                 StOut_Con.stoutLineRefersh(index!, ind!);
//                 Navigator.pop(context);
//                 // StOut_Con.AcceptButton(ind!, index, context);
//                 // StOut_Con.AcceptValidation(
//                 //     context, data, datatotal, index, Stock_i);
//               },
//               child: Container(
//                 padding: EdgeInsets.only(
//                     top: stockInheight * 0.01,
//                     left: stockInheight * 0.02,
//                     right: stockInheight * 0.02,
//                     bottom: stockInheight * 0.01),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     // color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       color: theme.primaryColor,
//                     )),
//                 height: stockInheight * 0.06,
//                 width: stockInWidth * 0.4,
//                 child: Text("Accept",
//                     style: theme.textTheme.bodyText2?.copyWith(
//                       color: theme.primaryColor,
//                     )),
//               )),
//           SizedBox(
//             height: stockInheight * 0.01,
//           ),
//         ],
//       ),
//     );
//   });
// }

// forSuspend(BuildContext context) {

// }
