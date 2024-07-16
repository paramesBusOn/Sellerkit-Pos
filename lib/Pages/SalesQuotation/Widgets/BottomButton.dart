// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesQuotationController/SalesQuotationController.dart';
import '../../../Widgets/ContentContainer.dart';

class SQBottomButtons extends StatefulWidget {
  SQBottomButtons(
      {Key? key,
      required this.theme,
      required this.btnWidth,
      required this.btnheight})
      : super(key: key);

  final ThemeData theme;
  double btnheight;
  double btnWidth;

  @override
  State<SQBottomButtons> createState() => SQBottomButtonsState();
}

class SQBottomButtonsState extends State<SQBottomButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(
          // vertical: Screens.bodyheight(context)*0.01,
          horizontal: Screens.width(context) * 0.01),
      height: widget.btnheight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // height: btnheight * 0.9,
            // color: Colors.yellow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(widget.btnheight * 0.01),
                  child: Text(
                    context.read<SalesQuotationCon>().getpaymentWay.isNotEmpty
                        ? "Payment Method"
                        : '',
                    textAlign: TextAlign.start,
                    style: widget.theme.textTheme.bodyLarge?.copyWith(
                      color: widget.theme.primaryColor,
                    ),
                  ),
                ),

                // SizedBox(height:paymentHeight *0.02),
                SizedBox(
                  // color: Colors.green,
                  height: widget.btnheight * 0.65,
                  child: context
                          .read<SalesQuotationCon>()
                          .getpaymentWay2
                          .isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: context
                              .watch<SalesQuotationCon>()
                              .getpaymentWay2
                              .length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Card(
                                elevation: 2,
                                child: Container(
                                    padding: EdgeInsets.only(
                                      right: widget.btnheight * 0.03,
                                      left: widget.btnheight * 0.03,
                                      bottom: widget.btnheight * 0.03,
                                      top: widget.btnheight * 0.03,
                                    ),

                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(5),
                                    //  // color: Colors.grey.withOpacity(0.04),
                                    // ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: widget.btnWidth * 0.25,
                                          // color: Colors.red,
                                          child: Text(
                                            '${context.watch<SalesQuotationCon>().getpaymentWay2[index].type}',
                                            // '${posController.getpaymentWay[index].dateTime}',
                                            style: widget
                                                .theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: widget.btnWidth * 0.28,
                                          // color: Colors.green,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${context.watch<SalesQuotationCon>().getpaymentWay2[index].reference}',
                                            // '${posController.getpaymentWay[index].type}',
                                            style: widget
                                                .theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            context
                                                .read<SalesQuotationCon>()
                                                .config
                                                .splitValues(context
                                                    .read<SalesQuotationCon>()
                                                    .getpaymentWay2[index]
                                                    .amt!
                                                    .toStringAsFixed(2)),
                                            style: widget
                                                .theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        context
                                                .read<SalesQuotationCon>()
                                                .getpaymentWay2
                                                .isNotEmpty
                                            ? Container(
                                                width: widget.btnWidth * 0.05,
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  // context
                                                  //     .read<SalesQuotationCon>()
                                                  //     .removePayment(index);
                                                },
                                                child: SizedBox(
                                                  width: widget.btnWidth * 0.05,
                                                  //  color: Colors.blue,
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                      ],
                                    )),
                              ),
                            );
                          })
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: context
                              .watch<SalesQuotationCon>()
                              .getpaymentWay
                              .length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Card(
                                elevation: 2,
                                child: Container(
                                    padding: EdgeInsets.only(
                                      right: widget.btnheight * 0.03,
                                      left: widget.btnheight * 0.03,
                                      bottom: widget.btnheight * 0.03,
                                      top: widget.btnheight * 0.03,
                                    ),

                                    // decoration: BoxDecoration(
                                    //   borderRadius: BorderRadius.circular(5),
                                    //  // color: Colors.grey.withOpacity(0.04),
                                    // ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: widget.btnWidth * 0.25,
                                          // color: Colors.red,
                                          child: Text(
                                            '${context.read<SalesQuotationCon>().getpaymentWay[index].type}',
                                            style: widget
                                                .theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: widget.btnWidth * 0.28,
                                          // color: Colors.green,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${context.read<SalesQuotationCon>().getpaymentWay[index].reference}',
                                            style: widget
                                                .theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            context
                                                .read<SalesQuotationCon>()
                                                .config
                                                .splitValues(context
                                                    .read<SalesQuotationCon>()
                                                    .getpaymentWay[index]
                                                    .amt!
                                                    .toStringAsFixed(2)),
                                            style: widget
                                                .theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              // context
                                              //     .read<SalesQuotationCon>()
                                              //     .removePayment(index);
                                            });
                                          },
                                          child: SizedBox(
                                            width: widget.btnWidth * 0.05,
                                            //  color: Colors.blue,
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          }),
                ),
              ],
            ),
          ),
          context.watch<SalesQuotationCon>().editqty == true
              ? Container(
                  child: Center(
                    child: SizedBox(
                      width: widget.btnWidth * 0.18,
                      height: widget.btnheight * 0.2,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.theme.primaryColor,
                          ),
                          onPressed: context
                                      .read<SalesQuotationCon>()
                                      .OndDisablebutton ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<SalesQuotationCon>()
                                      .validateUpdate(context, widget.theme);
                                  // context
                                  //     .read<SalesQuotationCon>()
                                  //     .updatechangecheckout(
                                  //         context, widget.theme);
                                  context
                                      .read<SalesQuotationCon>()
                                      .disableKeyBoard(context);
                                },
                          child: Text(
                            "Update",
                            style: widget.theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          )),
                    ),
                    // GestureDetector(
                    //     onTap: context
                    //                 .watch<SalesQuotationCon>()
                    //                 .OndDisablebutton ==
                    //             true
                    //         ? null
                    //         : () {
                    //             setState(() {
                    //               context
                    //                   .read<SalesQuotationCon>()
                    //                   .OndDisablebutton = true;
                    //               context
                    //                   .read<SalesQuotationCon>()
                    //                   .updatechangecheckout(
                    //                       context, widget.theme);
                    //             });
                    //           },
                    //     child: Container(
                    //       width: widget.btnWidth * 0.2,
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //           // color: Colors.grey[400],
                    //           borderRadius: BorderRadius.circular(5),
                    //           border: Border.all(
                    //             color: widget.theme.primaryColor,
                    //           )),
                    //       height: widget.btnheight * 0.17,
                    //       child: context
                    //                   .watch<SalesQuotationCon>()
                    //                   .OndDisablebutton ==
                    //               true
                    //           ? SizedBox(
                    //               width: Screens.padingHeight(context) * 0.05,
                    //               height: Screens.padingHeight(context) * 0.15,
                    //               child: Center(
                    //                   child: CircularProgressIndicator()))
                    //           : Text("Update",
                    //               textAlign: TextAlign.center,
                    //               style: widget.theme.textTheme.bodyLarge
                    //                   ?.copyWith(
                    //                       color: widget.theme.primaryColor)),
                    //     )
                    // ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(
                    widget.btnheight * 0.01,
                  ),
                  child: context.read<SalesQuotationCon>().selectedcust2 != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                padding: EdgeInsets.all(
                                  widget.btnheight * 0.01,
                                ),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<SalesQuotationCon>()
                                            .cancelbtn = true;

                                        context
                                            .read<SalesQuotationCon>()
                                            .clickacancelbtn(
                                                context, widget.theme);
                                      });
                                    },
                                    child: Container(
                                      width: widget.btnWidth * 0.2,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(5),
                                        // border: Border.all(
                                        //   color: widget.theme.primaryColor,
                                        // )
                                      ),
                                      height: widget.btnheight * 0.15,
                                      child: context
                                                  .watch<SalesQuotationCon>()
                                                  .cancelbtn ==
                                              false
                                          ? Text("Cancel",
                                              textAlign: TextAlign.center,
                                              style: widget
                                                  .theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: Colors.black,
                                              ))
                                          : CircularProgressIndicator(
                                              color: widget.theme.primaryColor),
                                    ))),
                            Container(
                                padding: EdgeInsets.all(
                                  widget.btnheight * 0.01,
                                ),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<SalesQuotationCon>()
                                            .clickaEditBtn(
                                                context, widget.theme);

                                        // context.read<SalesQuotationCon>().updateFixDataMethod(context, widget.theme);
                                      });
                                    },
                                    child: Container(
                                      width: widget.btnWidth * 0.2,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: widget.theme.primaryColor
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: widget.theme.primaryColor,
                                          )),
                                      height: widget.btnheight * 0.15,
                                      child: Text("Edit",
                                          textAlign: TextAlign.center,
                                          style: widget
                                              .theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: Colors.black,
                                          )),
                                    ))),
                            Container(
                                padding: EdgeInsets.all(
                                  widget.btnheight * 0.01,
                                ),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<SalesQuotationCon>()
                                            .selectedcust2 = null;
                                        context
                                            .read<SalesQuotationCon>()
                                            .selectedcust25 = null;
                                        context
                                            .read<SalesQuotationCon>()
                                            .scanneditemData2
                                            .clear();
                                        context
                                            .read<SalesQuotationCon>()
                                            .paymentWay2
                                            .clear();
                                        context
                                            .read<SalesQuotationCon>()
                                            .totalPayment2 = null;
                                        context
                                            .read<SalesQuotationCon>()
                                            .custList2
                                            .clear();
                                        context
                                            .read<SalesQuotationCon>()
                                            .injectToDb();
                                        context
                                            .read<SalesQuotationCon>()
                                            .getdraftindex();
                                        context
                                            .read<SalesQuotationCon>()
                                            .mycontroller2[50]
                                            .text = "";
                                        context
                                            .read<SalesQuotationCon>()
                                            .cancelbtn = false;
                                      });
                                    },
                                    child: Container(
                                      width: widget.btnWidth * 0.2,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.circular(5),
                                        // border: Border.all(
                                        //   color: widget.theme.primaryColor,
                                        // )
                                      ),
                                      height: widget.btnheight * 0.15,
                                      child: Text("Clear",
                                          textAlign: TextAlign.center,
                                          style: widget
                                              .theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: Colors.black,
                                          )),
                                    ))),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: widget.btnheight * 0.2,
                              width: widget.btnWidth * 0.2,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        // width: 5.0,
                                        color: widget.theme.primaryColor,
                                      )),
                                  onPressed: context
                                              .read<SalesQuotationCon>()
                                              .OndDisablebutton ==
                                          true
                                      ? null
                                      : () {
                                          context
                                                  .read<SalesQuotationCon>()
                                                  .OndDisablebutton ==
                                              true;
                                          if (context
                                                      .read<SalesQuotationCon>()
                                                      .getselectedcust ==
                                                  null &&
                                              context
                                                  .read<SalesQuotationCon>()
                                                  .getScanneditemData
                                                  .isEmpty) {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      content: AlertBox(
                                                        payMent: 'Alert',
                                                        errormsg: true,
                                                        widget: Center(
                                                            child:
                                                                ContentContainer(
                                                          content:
                                                              'Atleast Choose the Customer..!! or Product',
                                                          theme: widget.theme,
                                                        )),
                                                        buttonName: null,
                                                      ));
                                                }).then((value) {
                                              context
                                                      .read<SalesQuotationCon>()
                                                      .OndDisablebutton ==
                                                  false;
                                            });
                                          } else {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      content: AlertBox(
                                                        payMent: 'Suspended',
                                                        widget: forSuspend(
                                                            context,
                                                            widget.theme),
                                                        buttonName:
                                                            null, //'Ok',
                                                      ));
                                                }).then((value) {
                                              context
                                                      .read<SalesQuotationCon>()
                                                      .OndDisablebutton ==
                                                  false;
                                            });
                                          }
                                          context
                                              .read<SalesQuotationCon>()
                                              .disableKeyBoard(context);
                                          context
                                                  .read<SalesQuotationCon>()
                                                  .OndDisablebutton ==
                                              false;
                                        },
                                  child: Text(
                                    "Suspend",
                                    style: widget.theme.textTheme.bodyMedium!
                                        .copyWith(
                                            color: widget.theme.primaryColor),
                                  )),
                            ),
                            SizedBox(
                              height: widget.btnheight * 0.2,
                              width: widget.btnWidth * 0.2,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        // width: 5.0,
                                        color: widget.theme.primaryColor,
                                      )),
                                  onPressed: context
                                              .read<SalesQuotationCon>()
                                              .OndDisablebutton ==
                                          true
                                      ? null
                                      : () {
                                          context
                                              .read<SalesQuotationCon>()
                                              .onHoldClicked(
                                                  context, widget.theme);
                                          context
                                              .read<SalesQuotationCon>()
                                              .disableKeyBoard(context);

                                          // posController.getdraft();
                                        },
                                  child: Text(
                                    "Hold",
                                    style: widget.theme.textTheme.bodyMedium!
                                        .copyWith(
                                            color: widget.theme.primaryColor),
                                  )),
                            ),
                            SizedBox(
                              width: widget.btnWidth * 0.2,
                              height: widget.btnheight * 0.2,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.theme.primaryColor,
                                  ),
                                  onPressed: context
                                              .read<SalesQuotationCon>()
                                              .OndDisablebutton ==
                                          true
                                      ? null
                                      : () {
                                          context
                                              .read<SalesQuotationCon>()
                                              .changecheckout(
                                                  context, widget.theme);
                                          // context
                                          //     .read<SalesQuotationCon>()
                                          //     .checkOut(context, widget.theme);
                                          context
                                              .read<SalesQuotationCon>()
                                              .disableKeyBoard(context);
                                        },
                                  child: Text(
                                    "Check Out",
                                    style: widget.theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                ),
        ],
      ),
    );
  }

  forSuspend(BuildContext context, ThemeData theme) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.02,
            vertical: Screens.bodyheight(context) * 0.005),
        child: Column(
          children: [
            SizedBox(
                height: widget.btnheight * 0.2,
                child: Center(
                    child: Text(
                        "You about to suspended all information will be unsaved  "))),
            // SizedBox(
            //   height: Screens.bodyheight(context) * 0.01,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Screens.width(context) * 0.1,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<SalesQuotationCon>()
                            .clearSuspendedData(context, theme);
                      },
                      child: Text("Yes")),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.1,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("No")),
                ),
              ],
            )
          ],
        ));
  }
}
//   Container(
        //     //height: btnheight * 0.25,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,

        //       children: [
        //         Container(
                  
        //           alignment: Alignment.centerLeft,
        //           child: Text("Notes",
        //               textAlign: TextAlign.start,
        //               style: theme.textTheme.bodyText1
        //                   ?.copyWith(color: theme.primaryColor)),
        //         ),
        //         Container(
        //           alignment: Alignment.centerLeft,
        //           padding: EdgeInsets.only(left:btnheight *0.2),
        //           decoration: BoxDecoration(

        //             color: Colors.grey.withOpacity(0.1),
        //             borderRadius: BorderRadius.circular(5),
        //           ),
        //           width: btnWidth * 1,
        //           child: Text(
        //               "Customer Mode 0 request on this particular items# 20-01,Customer Mode 0 request on this ....",
        //               style: theme.textTheme.bodyText1?.copyWith()),
        //         ),
        //       ],
        //     ),
        //   ),