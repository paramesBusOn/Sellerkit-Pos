// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:provider/provider.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';

class StockInward extends StatefulWidget {
  StockInward({super.key, required this.theme, required this.stockInWidth, required this.stockInheight, required this.index, required this.data, required this.datatotal});
  ThemeData theme;
  double stockInheight;
  double stockInWidth;
  int index;
  List<StockInwardDetails>? data;
  List<StockInwardList>? datatotal;

  @override
  State<StockInward> createState() => _StockInwardState();
}

class _StockInwardState extends State<StockInward> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: widget.stockInheight * 0.02,
              left: widget.stockInheight * 0.01,
              right: widget.stockInheight * 0.01,
              bottom: widget.stockInheight * 0.01,
            ),
            decoration: BoxDecoration(color: widget.theme.primaryColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                  width: widget.stockInWidth * 0.5,
                  child: GestureDetector(
                    onTap: (){
   context.read<StockInwrdController>(). deletereq();

                    },
                    child: Text(
                      'Item Name',
                      style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                    ),
                  )),
              Container(
                  alignment: Alignment.center,
                  width: widget.stockInWidth * 0.15,
                  child: Text(
                    'Requested Quantity',
                    style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                  )),
              Container(
                  alignment: Alignment.center,
                  width: widget.stockInWidth * 0.15,
                  child: Text(
                    'Transfered Quantity',
                    style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                  )),
              Container(
                  alignment: Alignment.center,
                  width: widget.stockInWidth * 0.15,
                  child: Text(
                    'Scanned Quantity',
                    style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ))
            ]),
          ),
          Container(
            // color: Colors.green,
            height: widget.stockInheight * 0.76,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 3,
                //     blurRadius: 7,
                //     offset: Offset(0, 3), // changes position of shadow
                //   ),
                // ],
                ),
            child: context.read<StockInwrdController>().StockInward2.isNotEmpty
                ? ListView.builder(
                    itemCount: context.read<StockInwrdController>().StockInward2[0].data.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                          
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: widget.stockInheight * 0.008,
                              left: widget.stockInheight * 0.01,
                              right: widget.stockInheight * 0.01,
                              bottom: widget.stockInheight * 0.01,
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
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                SizedBox(
                                  // color: Colors.amber,
                                  width: widget.stockInWidth * 0.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${context.watch<StockInwrdController>().StockInward2[0].data[i].itemcode}",
                                        style: widget.theme.textTheme.bodyLarge,
                                        // maxLines: 2,
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            " ${context.watch<StockInwrdController>().StockInward2[0].data[i].serialBatch}",
                                            style: widget.theme.textTheme.bodyLarge,
                                          ))
                                    ],
                                  ),
                                ),
                                Container(
                                  // color: Colors.amber,
                                  alignment: Alignment.center,
                                  width: widget.stockInWidth * 0.15,
                                  child: Text(
                                    "${context.watch<StockInwrdController>().StockInward2[0].data[i].qty}",
                                    style: widget.theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: widget.stockInWidth * 0.15,
                                  child: Text(
                                    "${context.watch<StockInwrdController>().StockInward2[0].data[i].trans_Qty}",
                                    style: widget.theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: widget.stockInWidth * 0.15,
                                  child: Text(
                                    "${context.watch<StockInwrdController>().StockInward2[0].data[i].Scanned_Qty}",
                                    style: widget.theme.textTheme.bodyLarge,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      );
                    })
                : ListView.builder(
                    itemCount: widget.data!.length,
                    itemBuilder: (context, i) {
                      return widget.data!.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Card(
                              child: InkWell(
                                onTap: () {
                                  context.read<StockInwrdController>().valPass(widget.data![i].Scanned_Qty!);
                                  context.read<StockInwrdController>().StInController[0].text = "";
                                  context.read<StockInwrdController>().ScannigVal = widget.data![i].Scanned_Qty!;
                                  context.read<StockInwrdController>().Selectindex2(i);
                                  // posC.Scanloop(data![i].serialbatch, i);
                                  // data![i].serialBatch!;
                                  context.read<StockInwrdController>().passindexBachPage(widget.index, i, widget.data![i]);
                                
                                  context.read<StockInwrdController>().isselectmethod();

                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: widget.stockInheight * 0.008,
                                    left: widget.stockInheight * 0.01,
                                    right: widget.stockInheight * 0.01,
                                    bottom: widget.stockInheight * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    color: widget.data![i].Scanned_Qty != 0 && widget.data![i].Scanned_Qty != widget.data![i].trans_Qty
                                        ? Color(0xFFfcedee)
                                        : widget.data![i].Scanned_Qty == widget.data![i].trans_Qty
                                            ? Color(0xFFebfaef)
                                            : context.watch<StockInwrdController>().get_ScannigVal == 0
                                                ? Colors.grey.withOpacity(0.04)
                                                : Colors.grey.withOpacity(0.04),
                                    borderRadius: BorderRadius.circular(5),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.5),
                                    //     spreadRadius: 3,
                                    //     blurRadius: 7,
                                    //     offset: Offset(
                                    //         0, 3), // changes position of shadow
                                    //   ),
                                    // ],
                                    border: Border.all(
                                        width: Screens.width(context) * 0.001,
                                        color: widget.data![i].Scanned_Qty != 0 && widget.data![i].Scanned_Qty != widget.data![i].trans_Qty
                                            ? Colors.red.withOpacity(0.4)
                                            : widget.data![i].Scanned_Qty == widget.data![i].trans_Qty
                                                ? Colors.green.withOpacity(0.4)
                                                : context.watch<StockInwrdController>().get_ScannigVal == 0
                                                    ? Colors.white
                                                    : Colors.white),
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      SizedBox(
                                        // color: Colors.amber,
                                        width: widget.stockInWidth * 0.5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${widget.data![i].itemcode}",
                                              style: widget.theme.textTheme.bodyLarge,
                                              // maxLines: 2,
                                            ),
                                            Container(
                                              child: Wrap(
                                                  spacing: 10.0,
                                                  runSpacing: 10.0,
                                                  children: listContainersBatch(
                                                    context,
                                                    widget.theme,
                                                    widget.data![i],
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.amber,
                                        alignment: Alignment.center,
                                        width: widget.stockInWidth * 0.15,
                                        child: Text(
                                          "${widget.data![i].qty}",
                                          style: widget.theme.textTheme.bodyLarge,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: widget.stockInWidth * 0.15,
                                        child: Text(
                                          "${widget.data![i].trans_Qty}",
                                          style: widget.theme.textTheme.bodyLarge,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: widget.stockInWidth * 0.15,
                                        child: Text(
                                          "${widget.data![i].Scanned_Qty}",
                                          style: widget.theme.textTheme.bodyLarge,
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
            height: widget.stockInheight * 0.008,
          ),
          Container(
            padding: EdgeInsets.only(
              top: widget.stockInheight * 0.01,
              left: widget.stockInheight * 0.01,
              right: widget.stockInheight * 0.01,
              bottom: widget.stockInheight * 0.01,
            ),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 3,
                //     blurRadius: 7,
                //     offset: Offset(0, 3), // changes position of shadow
                //   ),
                // ],
                ),
            child: context.watch<StockInwrdController>().StockInward2.isNotEmpty
                ? Container(
                    alignment: Alignment.center,
                    // width: widget.stockInWidth * 1,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                      // color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      controller: context.read<StockInwrdController>().StInController2[50],
                      cursorColor: Colors.grey,
                      style: widget.theme.textTheme.bodyMedium?.copyWith(),
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
                    // width: widget.stockInWidth * 1,
                    decoration: BoxDecoration(
                      // color: Colors.red,

                      borderRadius: BorderRadius.circular(3),
                      // color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      controller: context.read<StockInwrdController>().StInController[50],
                      cursorColor: Colors.grey,
                      style: widget.theme.textTheme.bodyMedium?.copyWith(),
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
              top: widget.stockInheight * 0.01,
              left: widget.stockInheight * 0.01,
              right: widget.stockInheight * 0.01,
              bottom: widget.stockInheight * 0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(5),
              // bottomRight: Radius.circular(5)
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 3,
            //     blurRadius: 7,
            //     offset: Offset(0, 3), // changes position of shadow
            //   ),
            // ],
            // color: Colors.white,

            height: widget.stockInheight * 0.095,
            child: context.watch<StockInwrdController>().StockInward2.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              context.read<StockInwrdController>().clickcancelbtn(context, widget.theme);
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: widget.stockInheight * 0.9,
                            width: widget.stockInWidth * 0.25,
                            child: context.watch<StockInwrdController>().cancelbtn == false
                                ? Text("Cancel",
                                    textAlign: TextAlign.center,
                                    style: widget.theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.black,
                                    ))
                                : CircularProgressIndicator(color: widget.theme.primaryColor),
                          )),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              context.read<StockInwrdController>().StInController2[50].text = "";
                              context.read<StockInwrdController>().StockInward2.clear();
                              context.read<StockInwrdController>().StockInward.clear();
                              context.read<StockInwrdController>(). 
                     
                              getStockOutData();
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: widget.stockInheight * 0.9,
                            width: widget.stockInWidth * 0.25,
                            child: Text("Clear",
                                style: widget.theme.textTheme.bodyMedium?.copyWith(
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
                        //       color: widget.theme.primaryColor,
                        //     )),
                        height: widget.stockInheight * 0.9,
                        width: widget.stockInWidth * 0.25,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  // width: 5.0,
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context.read<StockInwrdController>().OnclickDisable == true
                                ? null
                                : () {
                                    context.read<StockInwrdController>().StInController[50].clear();
                                    context.read<StockInwrdController>().OnclickDisable = true;
                                    if (widget.datatotal!.isEmpty) {
                                      Get.defaultDialog(
                                              // content: Container(
                                              //   width: Screens.width(context) * 0.4,
                                              //   height: Screens.bodyheight(context) * 0.1,
                                              // ),
                                              title: "Alert",
                                              middleText: 'No Data Found..!!',
                                              backgroundColor: Colors.white,
                                              titleStyle: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
                                              middleTextStyle: widget.theme.textTheme.bodyLarge,
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                        context.read<StockInwrdController>().OnclickDisable = false;
                                      });
                                    } else {
                                      forSuspend(context, widget.theme);
                                    }
                                    context.read<StockInwrdController>().disableKeyBoard(context);
                                    context.read<StockInwrdController>().OnclickDisable = false;
                                  },
                            child: Text(
                              "Suspend",
                              style: widget.theme.textTheme.bodyMedium!.copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        // alignment: Alignment.center,
                        // decoration: BoxDecoration(
                        //     // color: Colors.grey[200],
                        //     borderRadius: BorderRadius.circular(5),
                        //     border: Border.all(
                        //       color: widget.theme.primaryColor,
                        //     )),
                        height: widget.stockInheight * 0.9,
                        width: widget.stockInWidth * 0.25,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  // width: 5.0,
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context.read<StockInwrdController>().OnclickDisable == true
                                ? null
                                : () {
                                    context.read<StockInwrdController>().OnclickDisable = true;
                                    if (widget.datatotal!.isEmpty) {
                                      Get.defaultDialog(
                                              // content: Container(
                                              //   width: Screens.width(context) * 0.4,
                                              //   height: Screens.bodyheight(context) * 0.1,
                                              // ),
                                              title: "Alert",
                                              middleText: 'No Data Found..!!',
                                              backgroundColor: Colors.white,
                                              titleStyle: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
                                              middleTextStyle: widget.theme.textTheme.bodyLarge,
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                        context.read<StockInwrdController>().OnclickDisable = false;
                                      });
                                    } else if (widget.data!.isEmpty) {
                                      Get.defaultDialog(
                                              // content: Container(
                                              //   width: Screens.width(context) * 0.4,
                                              //   height: Screens.bodyheight(context) * 0.1,
                                              // ),
                                              title: "Alert",
                                              middleText: 'Please Choose Item..!!',
                                              backgroundColor: Colors.white,
                                              titleStyle: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
                                              middleTextStyle: widget.theme.textTheme.bodyLarge,
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                        context.read<StockInwrdController>().OnclickDisable = false;
                                      });
                                    } else {
                                      context.read<StockInwrdController>().holdbutton(widget.index, context, widget.theme, widget.data, widget.datatotal![widget.index]);
                                    }
                                    context.read<StockInwrdController>().disableKeyBoard(context);
                                    context.read<StockInwrdController>().OnclickDisable = false;
                                    // posC.HoldMethod(context, theme, data, datatotal, index);
                                  },
                            child: Text(
                              "Hold",
                              style: widget.theme.textTheme.bodyMedium!.copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        // alignment: Alignment.center,
                        // decoration: BoxDecoration(
                        //     color: widget.theme.primaryColor,
                        //     borderRadius: BorderRadius.circular(5),
                        //     border: Border.all(
                        //       color: widget.theme.primaryColor,
                        //     )),
                        height: widget.stockInheight * 0.9,
                        width: widget.stockInWidth * 0.25,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: widget.theme.primaryColor),
                            onPressed: context.read<StockInwrdController>().OnclickDisable == false
                                ? () async {
                                    context.read<StockInwrdController>().OnclickDisable = true;
                                    if (widget.datatotal!.isEmpty) {
                                      Get.defaultDialog(
                                              // content: Container(
                                              //   width: Screens.width(context) * 0.4,
                                              //   height: Screens.bodyheight(context) * 0.1,
                                              // ),
                                              title: "Alert",
                                              middleText: 'No Data Found..!!',
                                              backgroundColor: Colors.white,
                                              titleStyle: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
                                              middleTextStyle: widget.theme.textTheme.bodyLarge,
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                        context.read<StockInwrdController>().OnclickDisable = false;
                                      });
                                    } else if (widget.data!.isEmpty) {
                                      Get.defaultDialog(
                                              // content: Container(
                                              //   width: Screens.width(context) * 0.4,
                                              //   height: Screens.bodyheight(context) * 0.1,
                                              // ),
                                              title: "Alert",
                                              middleText: 'Please Choose Item..!!',
                                              backgroundColor: Colors.white,
                                              titleStyle: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
                                              middleTextStyle: widget.theme.textTheme.bodyLarge,
                                              actions: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                        context.read<StockInwrdController>().OnclickDisable = false;
                                      });
                                    } else {
                                     await context.read<StockInwrdController>().submitbutton(widget.index, context, widget.theme, widget.data, widget.datatotal![widget.index]);
                                      context.read<StockInwrdController>().myFuture(context, widget.theme, widget.data);
                                    }
                                    context.read<StockInwrdController>().disableKeyBoard(context);
                                    // context.read<StockInwrdController>().OnclickDisable = false;
                                  }
                                : null,
                            child: Text(
                              "Submit",
                              style: widget.theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  // // forSuspend(BuildContext context) {
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
                    Navigator.pop(context);
                    context.read<StockInwrdController>().suspendedbutton(widget.index, context, theme, widget.data, widget.datatotal![widget.index]);
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

  List<Widget> listContainersBatch(BuildContext context, ThemeData theme, StockInwardDetails data) {
    return List.generate(
      data.StOutSerialbatchList!.length,
      (ind) {
        log("StOutSerialbatchList.length::${data.StOutSerialbatchList!.length}");
        return Container(
          padding: EdgeInsets.all(Screens.width(context) * 0.002),
          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(3)),
          child: Text("${data.StOutSerialbatchList![ind].serialbatch} / ${data.StOutSerialbatchList![ind].qty} "),
        );
      },
    );
  }
}
