// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';

class StockInwardPageviewerLeft extends StatelessWidget {
  StockInwardPageviewerLeft(
      {super.key,
      required this.theme,
      required this.stockInWidth,
      required this.stockInheight,
      required this.index,
      required this.data,
      required this.datatotal});
  ThemeData theme;
  double stockInheight;
  double stockInWidth;
  int index;
  List<StockInwardDetails>? data;
  List<StockInwardList>? datatotal;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Colors.green,
          width: stockInWidth,
          height: stockInheight * 1.08,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
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
              //  ListView.builder(
              //     itemCount: data!.length,
              //     itemBuilder: (context, i) {
              //       return data!.isEmpty
              //           ? Center(
              //               child: CircularProgressIndicator(),
              //             )
              //           :
              Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: stockInheight * 0.01,
                  left: stockInheight * 0.01,
                  right: stockInheight * 0.01,
                  bottom: stockInheight * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5)
                  ),
                  color: theme.primaryColor,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: stockInWidth * 0.5,
                          child: Text(
                            'Item Name',
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: stockInWidth * 0.15,
                          child: Text(
                            'Requested Quantity',
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: stockInWidth * 0.15,
                          child: Text(
                            'Transfered Quantity',
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          )),
                      Container(
                          alignment: Alignment.center,
                          width: stockInWidth * 0.15,
                          child: Text(
                            'Scanned Quantity',
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                          ))
                    ]),
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    // context.read<StockInwrdController>().valPass(data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty!);
                    // context.watch<StockInwrdController>().StInController[0].text = "";
                    // context.watch<StockInwrdController>().ScannigVal = data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty!;
                    // // posC.Scanloop(data![i].serialbatch, i);
                    // // data![i].serialBatch!;
                    // context.read<StockInwrdController>().getBatchData(index, context.read<StockInwrdController>().selectIndex2);
                    
                  },
                  child: Container(
                    // height: stockInheight * 0.1,
                    width: stockInWidth,
                    padding: EdgeInsets.only(
                      top: stockInheight * 0.01,
                      left: stockInheight * 0.01,
                      right: stockInheight * 0.01,
                      bottom: stockInheight * 0.01,
                    ),
                    decoration: BoxDecoration(
                        color: data!=null && data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty != 0 &&
                                data![context.watch<StockInwrdController>().selectIndex2].qty !=
                                    (data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty! +
                                        data![context.watch<StockInwrdController>().selectIndex2].trans_Qty!)
                            ? const Color(0xFFfcedee)
                            : data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty != 0 &&
                                    data![context.watch<StockInwrdController>().selectIndex2].qty ==
                                        (data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty! +
                                            data![context.watch<StockInwrdController>().selectIndex2].trans_Qty!)
                                ? const Color(0xFFebfaef)
                                : data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty == 0 &&
                                        data![context.watch<StockInwrdController>().selectIndex2].qty !=
                                            (data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty! +
                                                data![context.watch<StockInwrdController>().selectIndex2].trans_Qty!)
                                    ? Colors.grey.withOpacity(0.04)
                                    : Colors.grey.withOpacity(0.04),
                                    borderRadius: BorderRadius.circular(5),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey.withOpacity(0.5),
                        //     spreadRadius: 3,
                        //     blurRadius: 7,
                        //     offset: Offset(0, 3), // changes position of shadow
                        //   ),
                        // ],
                        // border: Border.all(
                        //   width: Screens.width(context) * 0.001,
                        //   color: data![i].Scanned_Qty != 0 &&
                        //           data![i].qty !=
                        //               (data![i].Scanned_Qty! +
                        //                   data![i].trans_Qty!)
                        //       ? Colors.red.withOpacity(0.3)
                        //       : data![i].Scanned_Qty != 0 &&
                        //               data![i].qty ==
                        //                   (data![i].Scanned_Qty! +
                        //                       data![i].trans_Qty!)
                        //           ? Colors.green.withOpacity(0.3)
                        //           : data![i].Scanned_Qty == 0 &&
                        //                   data![i].qty !=
                        //                       (data![i].Scanned_Qty! +
                        //                           data![i].trans_Qty!)
                        //               ? Colors.white
                        //               : Colors.white,
                        // ),
                        border: Border.all(color: Colors.green)),
                    child: IntrinsicHeight(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // color: Colors.amber,
                              width: stockInWidth * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 data==null? const Text(""): Text(
                                    "${data![context.watch<StockInwrdController>().selectIndex2].itemcode}",
                                    style: theme.textTheme.bodyLarge,
                                    // maxLines: 2,
                                  ),
                                   data==null? const Text(""): Container(
                                                  child: Wrap(
                                                      spacing: 10.0,
                                                      runSpacing: 10.0,
                                                      children:
                                                          listContainersBatch(
                                                        context,
                                                        theme,
                                                        data![context.watch<StockInwrdController>().selectIndex2],
                                                      )),
                                                )
                                ],
                              ),
                            ),
                            Container(
                              // color: Colors.amber,
                              alignment: Alignment.center,
                              width: stockInWidth * 0.15,
                              child: data==null? const Text(""):Text(
                                "${data![context.watch<StockInwrdController>().selectIndex2].qty}",
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: stockInWidth * 0.15,
                              child: data==null? const Text(""):Text(
                                "${data![context.watch<StockInwrdController>().selectIndex2].trans_Qty}",
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: stockInWidth * 0.15,
                              child:data==null? const Text(""): Text(
                                "${data![context.watch<StockInwrdController>().selectIndex2].Scanned_Qty}",
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // }),
        ),
        SizedBox(
          height: stockInheight * 0.008,
        ),
        // Container(
        //   padding: EdgeInsets.only(
        //     top: stockInheight * 0.01,
        //     left: stockInheight * 0.01,
        //     right: stockInheight * 0.01,
        //     bottom: stockInheight * 0.01,
        //   ),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     // boxShadow: [
        //     //   BoxShadow(
        //     //     color: Colors.grey.withOpacity(0.5),
        //     //     spreadRadius: 3,
        //     //     blurRadius: 7,
        //     //     offset: Offset(0, 3), // changes position of shadow
        //     //   ),
        //     // ],
        //   ),
        //   height: stockInheight * 0.095,
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       GestureDetector(
        //           onTap: () {
        //             // showDialog(
        //             //         context: context,
        //             //         barrierDismissible: true,
        //             //         builder: (BuildContext context) {
        //             //           return AlertDialog(
        //             //               contentPadding: EdgeInsets.all(0),
        //             //               content: AlertBox(
        //             //                 payMent: 'Suspended',
        //             // widget:
        //             forSuspend(context, theme);
        //             //         buttonName: null,
        //             //       ));
        //             // });
        //           },
        //           child: Container(
        //             alignment: Alignment.center,
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(5),
        //                 border: Border.all(
        //                   color: theme.primaryColor,
        //                 )),
        //             height: stockInheight * 0.9,
        //             width: stockInWidth * 0.25,
        //             child: Text("Suspend",
        //                 style: theme.textTheme.bodyText2?.copyWith(
        //                   color: theme.primaryColor,
        //                 )),
        //           )),
        //       GestureDetector(
        //           onTap: () {
        //             // StOut_Con.saveValuesTODB(
        //             //     "hold", context, theme, index,data,datatotal![index]);
        //             StOut_Con.holdbutton(
        //                 index, context, theme, data, datatotal![index]);
        //             // StOut_Con.HoldMethod(
        //             //     context, theme, data, datatotal, index);
        //           },
        //           child: Container(
        //             alignment: Alignment.center,
        //             decoration: BoxDecoration(
        //                 // color: Colors.grey[200],
        //                 borderRadius: BorderRadius.circular(5),
        //                 border: Border.all(
        //                   color: theme.primaryColor,
        //                 )),
        //             height: stockInheight * 0.9,
        //             width: stockInWidth * 0.25,
        //             child: Text("Hold",
        //                 style: theme.textTheme.bodyText2?.copyWith(
        //                   color: theme.primaryColor,
        //                 )),
        //           )),
        //       GestureDetector(
        //           onTap: () {
        //             StOut_Con.submitbutton(
        //                 index, context, theme, data, datatotal![index]);
        //             StOut_Con.myFuture(context);
        //           },
        //           child: Container(
        //             alignment: Alignment.center,
        //             decoration: BoxDecoration(
        //                 color: theme.primaryColor,
        //                 borderRadius: BorderRadius.circular(5),
        //                 border: Border.all(
        //                   color: theme.primaryColor,
        //                 )),
        //             height: stockInheight * 0.9,
        //             width: stockInWidth * 0.25,
        //             child: Text("Submit",
        //                 style: theme.textTheme.bodyText2?.copyWith(
        //                   color: Colors.white,
        //                 )),
        //           )),
        //     ],
        //   ),
        // )
      ],
    );
  }

  // StatefulBuilder forInwardScan(
  //     BuildContext context,
  //     StockInwrdController stoutCon,
  //     StockInwardDetails? datalist,
  //     int? ind,
  //     int? index
  //     // List<StockInwardList>? datatotal
  //     ) {
  //   return StatefulBuilder(builder: (context, st) {
  //     return SizedBox(
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
  //                 border: Border.all(color: const Color.fromARGB(255, 207, 201, 201)),
  //                 borderRadius: BorderRadius.circular(3),
  //                 color: Colors.grey.withOpacity(0.01),
  //               ),
  //               child: TextFormField(
  //                 style: theme.textTheme.bodyMedium,
  //                 cursorColor: Colors.grey,
  //                 controller: stoutCon.StInController[0],
  //                 onEditingComplete: () {
  //                   st(() {
  //                     stoutCon.scanmethod(
  //                         index!, datalist!.serialBatch!, ind!);
  //                     stoutCon.disableKeyBoard(context);
  //                     // StOut_Con.scanmethod(index, datalist!.serialBatch!, ind!,);
  //                     // StOut_Con.scan3(datalist,
  //                     //     StOut_Con.StOutController[0].text, Stock_i, StList_i);
  //                   });
  //                 },
  //                 onChanged: (v) {
  //                   if (v.isNotEmpty) {
  //                     st(() {
  //                       stoutCon.msg = "";
  //                     });
  //                   }
  //                 },
  //                 decoration: InputDecoration(
  //                   filled: false,
  //                   hintText: 'Scan Here..',
  //                   hintStyle: theme.textTheme.bodyMedium?.copyWith(
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
  //                 "  ${stoutCon.msg}",
  //                 style: theme.textTheme.bodySmall!.copyWith(color: Colors.red),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: stockInheight * 0.008),
  //           SizedBox(
  //             width: stockInWidth * 1.18,
  //             height: stockInheight * 0.6,
  //             // color: Colors.red,
  //             child: datalist!.serialbatchList == null
  //                 ? const Center(
  //                     child: Text("Scan Item.."),
  //                   )
  //                 : ListView.builder(
  //                     itemCount: datalist.serialbatchList!.length,
  //                     physics: const BouncingScrollPhysics(),
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
  //                                   offset: const Offset(
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
  //                                     SizedBox(
  //                                       // color: Colors.amber,
  //                                       width: stockInWidth * 0.4,
  //                                       child: Text(
  //                                         "${datalist.serialbatchList![i].itemcode}",
  //                                         style: theme.textTheme.bodyLarge,
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
  //                                      Container(
  //                                                 child: Wrap(
  //                                                     spacing: 10.0,
  //                                                     runSpacing: 10.0,
  //                                                     children:
  //                                                         listContainersBatch(
  //                                                       context,
  //                                                       theme,
  //                                                       datalist,
  //                                                     )),
  //                                               )
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
  //                                       style: theme.textTheme.bodyLarge,
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                       alignment: Alignment.center,
  //                                       // color: Colors.amber,
  //                                       height: stockInheight * 0.06,
  //                                       width: stockInWidth * 0.1,
  //                                       decoration: const BoxDecoration(
  //                                           color: Colors.blue,
  //                                           shape: BoxShape.circle),
  //                                       child: IconButton(
  //                                           color: Colors.white,
  //                                           padding: EdgeInsets.zero,
  //                                           iconSize: 18,
  //                                           onPressed: () {
  //                                             st(() {
  //                                               stoutCon.scanqtyRemove(
  //                                                   index!, ind!, i);
  //                                             });
  //                                           },
  //                                           icon: const Icon(Icons.remove))),
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
  //                 stoutCon.StInLineRefersh(index!, ind!);
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
  //                     style: theme.textTheme.bodyMedium?.copyWith(
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
  //   return Container(
  //       child: Column(
  //     children: [
  //       Container(
  //           padding: EdgeInsets.all(stockInheight * 0.05),
  //           child: Center(
  //               child: Text(
  //                   "You about to suspended all information will be unsaved"))),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           GestureDetector(
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 // StOut_Con.suspendedbutton(data, index);
  //                 StOut_Con.suspendedbutton(
  //                     index, context, theme, data, datatotal![index]);
  //                 //  StOut_Con.saveValuesTODB(
  //                 //     "suspend", context, theme, index,data,datatotal![index]);
  //                 // Navigator.pop(context);
  //                 // data!.clear();
  //                 // datatotal!.removeAt(index);
  //                 // StOut_Con.callList();
  //               },
  //               child: Container(
  //                 width: stockInWidth * 0.2,
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                     color: theme.primaryColor,
  //                     borderRadius: BorderRadius.circular(3),
  //                     border: Border.all(
  //                       color: theme.primaryColor,
  //                     )),
  //                 height: stockInheight * 0.1,
  //                 child: Text("Yes",
  //                     style: theme.textTheme.bodyText2?.copyWith(
  //                       color: Colors.white,
  //                     )),
  //               )),
  //           GestureDetector(
  //               onTap: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Container(
  //                 width: stockInWidth * 0.2,
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(3),
  //                     color: theme.primaryColor,
  //                     border: Border.all(
  //                       color: theme.primaryColor,
  //                     )),
  //                 height: stockInheight * 0.1,
  //                 child: Text("No",
  //                     style: theme.textTheme.bodyText2?.copyWith(
  //                       color: Colors.white,
  //                     )),
  //               )),
  //         ],
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
                    Navigator.pop(context);
                    context.read<StockInwrdController>().suspendedbutton(
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
   List<Widget> listContainersBatch(
      BuildContext context, ThemeData theme, StockInwardDetails data) {
    return List.generate(
      data.StOutSerialbatchList!.length,
      (ind) {
        // log("posC.custList.length::${posC.custList2.length}");
        return Container(
          padding: EdgeInsets.all(Screens.width(context)*0.002),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(3)
          ),
          child: Text("${data.StOutSerialbatchList![ind].serialbatch} / ${data.StOutSerialbatchList![ind].qty} "),
        );
      },
    );
  }
}
