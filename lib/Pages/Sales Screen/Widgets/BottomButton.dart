// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/ContentContainer.dart';

class BottomButtons extends StatefulWidget {
  BottomButtons({
    Key? key,
    required this.theme,
    required this.btnWidth,
    required this.btnheight,
    // required this.posController
  }) : super(key: key);

  final ThemeData theme;
  double btnheight;
  double btnWidth;
  // final PosController posController;

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
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
                    context.read<PosController>().getpaymentWay.isNotEmpty
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
                  child: context.read<PosController>().getpaymentWay2.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: context
                              .watch<PosController>()
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
                                            '${context.watch<PosController>().getpaymentWay2[index].type}',
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
                                            '${context.watch<PosController>().getpaymentWay2[index].reference}',
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
                                                .watch<PosController>()
                                                .config
                                                .splitValues(context
                                                    .watch<PosController>()
                                                    .getpaymentWay2[index]
                                                    .amt!
                                                    .toStringAsFixed(2)),
                                            style: widget
                                                .theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        context
                                                .read<PosController>()
                                                .getpaymentWay2
                                                .isNotEmpty
                                            ? Container(
                                                width: widget.btnWidth * 0.05,
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  context
                                                      .read<PosController>()
                                                      .removePayment(index);
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
                              .watch<PosController>()
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
                                            '${context.watch<PosController>().getpaymentWay[index].type}',
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
                                            '${context.watch<PosController>().getpaymentWay[index].reference}',
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
                                                .watch<PosController>()
                                                .config
                                                .splitValues(context
                                                    .watch<PosController>()
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
                                            context
                                                .read<PosController>()
                                                .removePayment(index);
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
          Container(
            padding: EdgeInsets.all(
              widget.btnheight * 0.01,
            ),
            child: context.watch<PosController>().selectedcust2 != null &&
                    context.watch<PosController>().scanneditemData2.isNotEmpty
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
                                  context.read<PosController>().cancelbtn =
                                      true;
                                  context
                                      .read<PosController>()
                                      .clickcancelbtn(context, widget.theme);
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
                                            .watch<PosController>()
                                            .cancelbtn ==
                                        false
                                    ? Text("Cancel",
                                        textAlign: TextAlign.center,
                                        style: widget.theme.textTheme.bodySmall
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
                                  context.read<PosController>().cancelbtn =
                                      false;
                                  context.read<PosController>().selectedcust2 =
                                      null;
                                  context.read<PosController>().selectedcust =
                                      null;
                                  context
                                      .read<PosController>()
                                      .scanneditemData2
                                      .clear();
                                  context
                                      .read<PosController>()
                                      .paymentWay2
                                      .clear();
                                  context.read<PosController>().totalPayment2 =
                                      null;
                                  context.read<PosController>().injectToDb();
                                  context.read<PosController>().getdraftindex();
                                  context
                                      .read<PosController>()
                                      .mycontroller2[50]
                                      .text = "";
                                  context.read<PosController>().searchmapbool =
                                      false;
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
                                    style: widget.theme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: Colors.black,
                                    )),
                              ))),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        // decoration: BoxDecoration(
                        //     //  color: Colors.red[200],
                        //     borderRadius: BorderRadius.circular(5),
                        //   ),
                        height: widget.btnheight * 0.2,
                        width: widget.btnWidth * 0.22,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  // width: 5.0,
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<PosController>()
                                        .OndDisablebutton ==
                                    true
                                ? null
                                : () {
                                    context
                                        .read<PosController>()
                                        .disableKeyBoard(context);
                                    context
                                        .read<PosController>()
                                        .clearTextField();
                                    context
                                        .read<PosController>()
                                        .salesorderheader();
                                    context.read<PosController>().soScanItem =
                                        [];
                                    log(" context.watch<PosController>().soSalesmodl.length:::${context.read<PosController>().soSalesmodl.length}");
                                    context
                                        .read<PosController>()
                                        .mycontroller[79]
                                        .text = '';
                                    context.read<PosController>().textError =
                                        '';

                                    context
                                                .read<PosController>()
                                                .getselectedcust ==
                                            null
                                        ? showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  content: AlertBox(
                                                    payMent: 'Alert',
                                                    errormsg: true,
                                                    widget: Center(
                                                        child: ContentContainer(
                                                      content:
                                                          'Choose customer..!!',
                                                      theme: widget.theme,
                                                    )),
                                                    buttonName: null,
                                                  ));
                                            })
                                        : context
                                                .read<PosController>()
                                                .soSalesmodl
                                                .isNotEmpty
                                            ? setState(() {
                                                context
                                                    .read<PosController>()
                                                    .selectIndex = null;
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return StatefulBuilder(
                                                          builder:
                                                              (context, st) {
                                                        return AlertDialog(
                                                            insetPadding:
                                                                EdgeInsets.all(
                                                                    Screens.padingHeight(
                                                                            context) *
                                                                        0.01),
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            content: AlertBox(
                                                              payMent:
                                                                  'Sales Orders',
                                                              widget:
                                                                  forClicksoBtn(
                                                                      context,
                                                                      widget
                                                                          .theme),
                                                              callback: () {
                                                                context
                                                                    .read<
                                                                        PosController>()
                                                                    .selectIndex = null;
                                                                context
                                                                    .read<
                                                                        PosController>()
                                                                    .clearsoaqty();
                                                                context
                                                                    .read<
                                                                        PosController>()
                                                                    .soOrderdata();

                                                                st(() {
                                                                  if (context
                                                                      .read<
                                                                          PosController>()
                                                                      .soData
                                                                      .isNotEmpty) {
                                                                    Navigator.pop(
                                                                        context);
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        barrierDismissible:
                                                                            false,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                              insetPadding: EdgeInsets.all(widget.btnWidth * 0.01),
                                                                              contentPadding: EdgeInsets.zero,
                                                                              content: AlertBox(
                                                                                payMent: 'Sales Order',
                                                                                widget: forScanSoOrder(context, widget.theme),
                                                                                buttonName: null,
                                                                                // callback: () {

                                                                                // },
                                                                              ));
                                                                        });
                                                                  } else {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        barrierDismissible:
                                                                            true,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                              contentPadding: EdgeInsets.all(0),
                                                                              content: AlertBox(
                                                                                payMent: 'Alert',
                                                                                errormsg: true,
                                                                                widget: Center(
                                                                                    child: ContentContainer(
                                                                                  content: 'Choose a Sales Order..!!',
                                                                                  theme: widget.theme,
                                                                                )),
                                                                                buttonName: null,
                                                                              ));
                                                                        });
                                                                  }
                                                                });
                                                              },
                                                              buttonName: "OK",
                                                            ));
                                                      });
                                                    });
                                              })
                                            : showDialog(
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
                                                              'No sales order here',
                                                          theme: widget.theme,
                                                        )),
                                                        buttonName: null,
                                                      ));
                                                });

                                    context
                                        .read<PosController>()
                                        .disableKeyBoard(context);
                                    //  context.read<PosController>().salesOrderClicked(context, widget.theme);
                                  },
                            child: Text(
                              "Copy From S.O",
                              style: widget.theme.textTheme.bodyLarge!
                                  .copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      GestureDetector(
                          onTap: context
                                      .read<PosController>()
                                      .OndDisablebutton ==
                                  true
                              ? null
                              : () {
                                  if (context
                                              .read<PosController>()
                                              .getselectedcust ==
                                          null &&
                                      context
                                          .read<PosController>()
                                          .soScanItem
                                          .isEmpty) {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              content: AlertBox(
                                                payMent: 'Alert',
                                                errormsg: true,
                                                widget: Center(
                                                    child: ContentContainer(
                                                  content:
                                                      'Atleast Choose the Customer..!! or Product',
                                                  theme: widget.theme,
                                                )),
                                                buttonName: null,
                                              ));
                                        });
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              content: AlertBox(
                                                payMent: 'Suspended',
                                                widget: forSuspend(
                                                    context, widget.theme),
                                                buttonName: null, //'Ok',
                                                // callback: () {
                                                //   Navigator.pop(context);
                                                //   posController.clearAllData();
                                                // },
                                              ));
                                        });
                                  }
                                  context
                                      .read<PosController>()
                                      .disableKeyBoard(context);
                                },
                          child: SizedBox(
                            // alignment: Alignment.center,
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(5),
                            //     border: Border.all(
                            //       color: widget.theme.primaryColor,
                            //     )),
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
                                            .read<PosController>()
                                            .OndDisablebutton ==
                                        true
                                    ? null
                                    : () {
                                        context
                                            .read<PosController>()
                                            .OndDisablebutton = true;
                                        if (context
                                                    .read<PosController>()
                                                    .getselectedcust ==
                                                null &&
                                            context
                                                .read<PosController>()
                                                .soScanItem
                                                .isEmpty) {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
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
                                                .read<PosController>()
                                                .OndDisablebutton = false;
                                          });
                                        } else {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    content: AlertBox(
                                                      payMent: 'Suspended',
                                                      widget: forSuspend(
                                                          context,
                                                          widget.theme),
                                                      buttonName: null, //'Ok',
                                                      // callback: () {
                                                      //   Navigator.pop(context);
                                                      //   posController.clearAllData();
                                                      // },
                                                    ));
                                              }).then((value) {
                                            context
                                                .read<PosController>()
                                                .OndDisablebutton = false;
                                          });
                                        }
                                        context
                                            .read<PosController>()
                                            .disableKeyBoard(context);
                                        context
                                            .read<PosController>()
                                            .OndDisablebutton = false;
                                      },
                                child: Text(
                                  "Suspend",
                                  style: widget.theme.textTheme.bodyMedium!
                                      .copyWith(
                                          color: widget.theme.primaryColor),
                                )),
                          )),
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
                                        .read<PosController>()
                                        .OndDisablebutton ==
                                    true
                                ? null
                                : () {
                                    setState(() {
                                      context
                                          .read<PosController>()
                                          .onHoldClicked(context, widget.theme);
                                      context
                                          .read<PosController>()
                                          .disableKeyBoard(context);
                                    });

                                    // posController.getdraft();
                                  },
                            child: Text(
                              "Hold",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        width: widget.btnWidth * 0.2,
                        // alignment: Alignment.center,
                        // decoration: BoxDecoration(
                        //     color: widget.theme.primaryColor,
                        //     borderRadius: BorderRadius.circular(5),
                        //     border: Border.all(
                        //       color: widget.theme.primaryColor,
                        //     )),
                        height: widget.btnheight * 0.2,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.theme.primaryColor,
                            ),
                            onPressed: context
                                        .read<PosController>()
                                        .OndDisablebutton ==
                                    false
                                ? () {
                                    setState(() {
                                      context
                                          .read<PosController>()
                                          .changecheckout(
                                              context, widget.theme);

                                      context
                                          .read<PosController>()
                                          .disableKeyBoard(context);
                                    });
                                  }
                                : null,
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
            horizontal: Screens.width(context) * 0.04,
            vertical: Screens.bodyheight(context) * 0.01),
        child: Column(
          children: [
            SizedBox(
                height: widget.btnheight * 0.4,
                child: Center(
                    child: Text(
                        "You about to suspended all information will be unsaved  "))),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Screens.width(context) * 0.15,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);

                        context
                            .read<PosController>()
                            .clearSuspendedData(context, theme);

                        // posController.insertSalesHeaderToDB();
                        // posController.clearAllData();
                      },
                      child: Text("Yes")),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.15,
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

  forClicksoBtn(BuildContext context, ThemeData theme) {
    return StatefulBuilder(builder: (context, st) {
      return SingleChildScrollView(
        child: Container(
          // height: widget.btnheight * 3,
          // width: widget.btnWidth * 1.3,
          padding: EdgeInsets.all(widget.btnheight * 0.02),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(widget.btnheight * 0.06),
                // height: widget.btnWidth * 0.07,
                width: widget.btnWidth * 1.5,
                color: theme.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: widget.btnWidth * 0.25,
                      // color: Colors.green,
                      child: Text("S.O Number",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      // color: Colors.green,
                      width: widget.btnWidth * 0.45,
                      alignment: Alignment.center,
                      child: Text("Customer Name",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: widget.btnWidth * 0.18,
                      // color: Colors.green,
                      child: Text("Date",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: widget.btnWidth * 0.15,
                      // color: Colors.red,
                      child: Text("Total",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(widget.btnheight * 0.02),
                height: widget.btnheight * 2.4,
                width: widget.btnWidth * 1.5,
                // height: widget.btnheight * 1.9,
                // width: double.infinity,

                //color: Colors.amber,
                child: ListView.builder(
                    itemCount:
                        context.watch<PosController>().soSalesmodl.length,
                    itemBuilder: (context, index) {
                      return Card(
                          color: Colors.grey[200],
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: context
                                                .watch<PosController>()
                                                .soSalesmodl[index]
                                                .invoiceClr ==
                                            0 &&
                                        context
                                                .watch<PosController>()
                                                .soSalesmodl[index]
                                                .checkBClr ==
                                            false
                                    ? Colors.grey.withOpacity(0.2)
                                    : Colors.blue.withOpacity(0.35)),
                            child: CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  context
                                      .read<PosController>()
                                      .itemDeSelect(index);
                                },
                                value: context
                                    .read<PosController>()
                                    .soSalesmodl[index]
                                    .checkBClr,
                                title: Container(
                                  // padding: EdgeInsets.only(left: widget.btnWidth * 0.01, right: widget.btnWidth * 0.01),
                                  //   color: Colors.amber,
                                  width: widget.btnWidth * 0.77,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          // color: Colors.red,
                                          width: widget.btnWidth * 0.3,
                                          child: Text(
                                            "Order / ${context.watch<PosController>().soSalesmodl[index].sapOrderNum.toString()}",
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(),
                                          )),
                                      Container(
                                          alignment: Alignment.center,
                                          // color: Colors.red,
                                          width: widget.btnWidth * 0.45,
                                          child: Text(
                                            context
                                                .watch<PosController>()
                                                .soSalesmodl[index]
                                                .custName
                                                .toString(),
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(),
                                          )),
                                      Container(
                                          width: widget.btnWidth * 0.18,
                                          alignment: Alignment.center,
                                          // color: Colors.pink,
                                          child: Text(
                                            context
                                                .watch<PosController>()
                                                .soSalesmodl[index]
                                                .invoceDate
                                                .toString(),
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(),
                                          )),
                                      Container(
                                          alignment: Alignment.centerRight,
                                          width: widget.btnWidth * 0.18,
                                          // color: Colors.pink,

                                          child: Text(context
                                              .watch<PosController>()
                                              .soSalesmodl[index]
                                              .invoceAmount
                                              .toString())),
                                    ],
                                  ),
                                )),
                          ));
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }

  forScanSoOrder(BuildContext context, ThemeData theme) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.all(
          widget.btnheight * 0.01,
        ),
        width: widget.btnWidth * 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  Container(
                    width: widget.btnWidth * 0.95,

                    padding: EdgeInsets.only(
                      top: widget.btnheight * 0.01,
                      left: widget.btnWidth * 0.01,
                      right: widget.btnWidth * 0.01,
                      bottom: widget.btnheight * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                    ),
                    //  height:  widget.btnheight * 0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            // color: Colors.red,
                            padding: EdgeInsets.only(
                              left: widget.btnheight * 0.01,
                            ),
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.23,
                            child: Text(
                              "Item Code",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                        Container(
                            // color: Colors.red,
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.5,
                            child: Text(
                              "Item Name",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                        Container(
                            // color: Colors.red,
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.13,
                            child: Text(
                              "S.O Qty",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    height: widget.btnheight * 3.1,
                    width: widget.btnWidth * 0.95,
                    child: ListView.builder(
                        itemCount:
                            context.watch<PosController>().getsoData.length,
                        itemBuilder: (context, index) {
                          return Card(
                              color: Colors.grey[200],
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: context
                                                  .watch<PosController>()
                                                  .selectIndex ==
                                              index
                                          //    context .watch<PosController>()
                                          // .getsoData[index]
                                          // .invoiceClr ==
                                          // 1 &&
                                          // context
                                          //         .watch<PosController>()
                                          //         .getsoData[index]
                                          //         .checkBClr ==
                                          //     true
                                          ? Colors.blue.withOpacity(0.35)
                                          : Colors.grey.withOpacity(0.2)),
                                  child: CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      onChanged: (val) {
                                        setState(() {
                                          // context
                                          //     .read<PosController>()
                                          //     .selectIndex = null;

                                          context
                                              .read<PosController>()
                                              .selctIndex(index);

                                          // context
                                          //     .read<PosController>()
                                          //     .SOitemDeSelect(index);
                                        });
                                      },
                                      value: context
                                          .watch<PosController>()
                                          .getsoData[index]
                                          .checkBClr,
                                      title: Transform.translate(
                                          offset: const Offset(-20, 0),
                                          child: Container(
                                            // color: Colors.red,
                                            // padding: EdgeInsets.all(6),
                                            height: widget.btnheight * 0.3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width:
                                                        widget.btnWidth * 0.18,
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              PosController>()
                                                          .getsoData[index]
                                                          .ItemCode
                                                          .toString(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(),
                                                    )),
                                                Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width:
                                                        widget.btnWidth * 0.5,
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              PosController>()
                                                          .getsoData[index]
                                                          .ItemName
                                                          .toString(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(),
                                                    )),
                                                Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width:
                                                        widget.btnWidth * 0.15,
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              PosController>()
                                                          .getsoData[index]
                                                          .Qty
                                                          .toString(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(),
                                                    )),
                                                // Container(
                                                //     width: widget.btnWidth * 0.08,
                                                //     // height: widget.btnheight * 0.16,
                                                //     alignment: Alignment.center,
                                                //     child: TextFormField(
                                                //       readOnly: true,
                                                //       style: theme.textTheme.bodyMedium,
                                                //       onTap: () {
                                                //         context.read<PosController>().soqtycontroller[index].text = context.read<PosController>().soqtycontroller[index].text;
                                                //         context.read<PosController>().soqtycontroller[index].selection = TextSelection(
                                                //           baseOffset: 0,
                                                //           extentOffset: context.read<PosController>().soqtycontroller[index].text.length,
                                                //         );
                                                //       },
                                                //       onChanged: (v) {},
                                                //       cursorColor: Colors.grey,
                                                //       textDirection: TextDirection.rtl,
                                                //       keyboardType: TextInputType.number,
                                                //       onEditingComplete: () {
                                                //         setState(() {
                                                //           context.read<PosController>().soqtychangealertbc(index, context, theme);
                                                //         });

                                                //         context.read<PosController>().disableKeyBoard(context);
                                                //       },
                                                //       controller: context.read<PosController>().soqtycontroller[index],
                                                //       decoration: InputDecoration(
                                                //         enabledBorder: OutlineInputBorder(
                                                //           borderRadius: BorderRadius.circular(5),
                                                //           borderSide: BorderSide(color: Colors.grey),
                                                //         ),
                                                //         focusedBorder: OutlineInputBorder(
                                                //           borderRadius: BorderRadius.circular(5),
                                                //           borderSide: BorderSide(color: Colors.grey),
                                                //         ),
                                                //         contentPadding: const EdgeInsets.symmetric(
                                                //           vertical: 5,
                                                //           horizontal: 5,
                                                //         ),
                                                //       ),
                                                //     )),
                                              ],
                                            ),
                                          )))));
                        }),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[100],
              height: widget.btnheight * 3.22,
              width: widget.btnWidth * 1.01,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.white.withOpacity(0.3), //color of shadow
                          spreadRadius: 3, //spread radius
                          blurRadius: 2, // blur radius
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller:
                          context.read<PosController>().mycontroller[79],
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.black),
                      onChanged: (val) {},
                      onEditingComplete: () {
                        st(() {
                          context.read<PosController>().textError = '';

                          // context.read<PosController>().scannsolistcopy(context.read<PosController>().mycontroller[79].text.toString().trim().toUpperCase(), context, theme);
                          context.read<PosController>().soInvoiceScan(
                              context
                                  .read<PosController>()
                                  .mycontroller[79]
                                  .text
                                  .toString()
                                  .trim()
                                  .toUpperCase(),
                              context,
                              theme);
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8),
                        hintText: "Scan Serial Batch",
                        hintStyle: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.grey[600]),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: widget.btnheight * 0.02,
                  ),
                  context.watch<PosController>().soScanItem.length > 0
                      ? Container(
                          child: Column(
                            children: [
                              Container(
                                width: widget.btnWidth * 1,
                                padding: EdgeInsets.only(
                                  top: widget.btnheight * 0.01,
                                  left: widget.btnWidth * 0.01,
                                  right: widget.btnWidth * 0.01,
                                  // bottom: widget.btnheight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                          left: widget.btnheight * 0.01,
                                        ),
                                        alignment: Alignment.center,
                                        width: widget.btnWidth * 0.23,
                                        child: Text(
                                          "Product Information",
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.white),
                                        )),
                                    Container(
                                        // color: Colors.red,
                                        alignment: Alignment.center,
                                        width: widget.btnWidth * 0.13,
                                        child: Text(
                                          "S.O Qty",
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: widget.btnheight * 0.01,
                              ),
                              Container(
                                height: widget.btnheight * 2.5,
                                width: widget.btnWidth * 1,
                                child: ListView.builder(
                                    itemCount: context
                                        .watch<PosController>()
                                        .soScanItem
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                top: widget.btnheight * 0.01,
                                                left: widget.btnWidth * 0.01,
                                                right: widget.btnWidth * 0.01,
                                                // bottom: widget.btnheight * 0.02,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.grey
                                                    .withOpacity(0.04),
                                              ),
                                              child: Column(children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        width: widget.btnWidth *
                                                            0.4,
                                                        // height:  btnheight * 0.02,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "${context.watch<PosController>().soScanItem[index].ItemName}",
                                                          maxLines: 2,
                                                          style: theme.textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        )),
                                                    SizedBox(
                                                        width: widget.btnWidth *
                                                            0.1,
                                                        child: Row(
                                                            //
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              // InkWell(
                                                              //   onTap: () {
                                                              //     // prdsrch.itemdecrement(
                                                              //     //     context, theme, index);
                                                              //   },
                                                              //   child: Container(
                                                              //     // alignment: Alignment.center,
                                                              //     width: widget.btnWidth * 0.1,
                                                              //     height: widget.btnheight * 0.15,
                                                              //     decoration: BoxDecoration(color: theme.primaryColor, shape: BoxShape.circle),
                                                              //     child: Icon(
                                                              //       Icons.remove,
                                                              //       color: Colors.white,
                                                              //     ),
                                                              //   ),
                                                              // ),s
                                                              Container(
                                                                  // color: Colors.red,
                                                                  width: widget
                                                                          .btnWidth *
                                                                      0.1,
                                                                  height: widget
                                                                          .btnheight *
                                                                      0.17,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          widget.btnWidth *
                                                                              0.005),
                                                                  child:
                                                                      TextFormField(
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodyMedium
                                                                        ?.copyWith(
                                                                            color:
                                                                                Colors.black),
                                                                    onTap: () {
                                                                      context.read<PosController>().soqtycontroller[index].text = context
                                                                          .read<
                                                                              PosController>()
                                                                          .soqtycontroller[
                                                                              index]
                                                                          .text;

                                                                      context
                                                                          .read<
                                                                              PosController>()
                                                                          .soqtycontroller[
                                                                              index]
                                                                          .selection = TextSelection(
                                                                        baseOffset:
                                                                            0,
                                                                        extentOffset: context
                                                                            .read<PosController>()
                                                                            .soqtycontroller[index]
                                                                            .text
                                                                            .length,
                                                                      );
                                                                    },
                                                                    cursorColor:
                                                                        Colors
                                                                            .grey,
                                                                    textDirection:
                                                                        TextDirection
                                                                            .rtl,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    inputFormatters: [
                                                                      FilteringTextInputFormatter
                                                                          .digitsOnly
                                                                    ],
                                                                    onEditingComplete:
                                                                        () {
                                                                      // context.read<PosController>().qqqqq();
                                                                      context.read<PosController>().mapsoqty(
                                                                          index,
                                                                          context,
                                                                          theme);
                                                                      context
                                                                          .read<
                                                                              PosController>()
                                                                          .disableKeyBoard(
                                                                              context);
                                                                    },
                                                                    controller: context
                                                                        .read<
                                                                            PosController>()
                                                                        .soqtycontroller[index],
                                                                    decoration:
                                                                        InputDecoration(
                                                                      filled:
                                                                          false,
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        borderSide:
                                                                            BorderSide(color: Colors.grey),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        borderSide:
                                                                            BorderSide(color: Colors.grey),
                                                                      ),
                                                                      contentPadding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        vertical:
                                                                            0,
                                                                        horizontal:
                                                                            5,
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ])),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      widget.btnheight * 0.01,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "${context.watch<PosController>().soScanItem[index].SerialBatch}",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: theme.textTheme
                                                              .bodyMedium
                                                              ?.copyWith(),
                                                        )),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // width:  btnWidth * 0.13,
                                                      child: Text(
                                                        "  |  ${context.watch<PosController>().soScanItem[index].ItemCode}",
                                                        style: theme.textTheme
                                                            .bodyMedium
                                                            ?.copyWith(),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ])),
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: widget.btnheight * 0.02,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (context
                                          .read<PosController>()
                                          .soScanItem
                                          .isNotEmpty) {
                                        context.read<PosController>().cpyfrmso =
                                            "CopyfromSo";

                                        context.read<PosController>().mapsodata(
                                              context,
                                              widget.theme,
                                            );
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  content: AlertBox(
                                                    payMent: 'Alert',
                                                    errormsg: true,
                                                    widget: Center(
                                                        child: ContentContainer(
                                                      content:
                                                          'Scan the Serialbatch',
                                                      theme: widget.theme,
                                                    )),
                                                    buttonName: null,
                                                  ));
                                            });
                                      }
                                    });
                                  },
                                  //
                                  child: Container(
                                      width: widget.btnWidth * 1,
                                      alignment: Alignment.center,
                                      height: widget.btnheight * 0.15,
                                      child: Text('OK')))
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),

        // context.watch<PosController>().textError.isNotEmpty
        //     ? Container(
        //         padding: EdgeInsets.only(
        //           left: widget.btnWidth * 0.05,
        //         ),
        //         alignment: Alignment.centerLeft,
        //         child: Text(
        //           context.watch<PosController>().textError,
        //           style: widget.theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
        //         ),
        //       )
        //     : SizedBox(
        //         height: widget.btnheight * 0.05,
        //       ),
        // context.read<PosController>().getsoData.isNotEmpty
        //     ? Column(
        //         children: [
        //           Container(
        //               height: widget.btnheight * 0.19,
        //               padding: EdgeInsets.only(
        //                 left: widget.btnWidth * 0.02,
        //                 right: widget.btnWidth * 0.02,
        //               ),
        //               color: theme.primaryColor,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   SizedBox(
        //                     width: widget.btnWidth * 0.15,
        //                     child: Text("Item Code",
        //                         style: theme.textTheme.bodyMedium?.copyWith(
        //                           color: Colors.white,
        //                         )),
        //                   ),
        //                   Container(
        //                     // color: Colors.yellow,
        //                     alignment: Alignment.center,
        //                     width: widget.btnWidth * 0.5,

        //                     child: Text("Item Name",
        //                         style: theme.textTheme.bodyMedium?.copyWith(
        //                           color: Colors.white,
        //                         )),
        //                   ),
        //                   // Container(
        //                   //   alignment: Alignment.center,
        //                   //   width: widget.btnWidth * 0.17,
        //                   //   // color: Colors.red,
        //                   //   child: Text("Serial Batch",
        //                   //       style: theme.textTheme.bodyMedium?.copyWith(
        //                   //         color: Colors.white,
        //                   //       )),
        //                   // ),
        //                   Container(
        //                     width: widget.btnWidth * 0.1,
        //                     alignment: Alignment.center,
        //                     child: Text("S.O Qty",
        //                         style: theme.textTheme.bodyMedium?.copyWith(
        //                           color: Colors.white,
        //                         )),
        //                   ),
        //                   SizedBox(
        //                     width: widget.btnWidth * 0.05,
        //                     child: Text("Qty",
        //                         style: theme.textTheme.bodyMedium?.copyWith(
        //                           color: Colors.white,
        //                         )),
        //                   ),
        //                 ],
        //               )),
        //           SizedBox(
        //             // color: Colors.amber,
        //             height: widget.btnheight * 2.4,
        //             width: widget.btnWidth * 1.5,
        // child: ListView.builder(
        //     itemCount: context.watch<PosController>().getsoData.length,
        //     itemBuilder: (context, index) {
        //       return Card(
        //           color: Colors.grey[200],
        //           child: Container(
        //               decoration:
        //                   BoxDecoration(borderRadius: BorderRadius.circular(5), color: context.read<PosController>().getsoData[index].invoiceClr == 1 && context.read<PosController>().getsoData[index].checkBClr == true ? Colors.blue.withOpacity(0.35) : Colors.grey.withOpacity(0.2)),
        //               child: CheckboxListTile(
        //                   controlAffinity: ListTileControlAffinity.leading,
        //                   onChanged: (val) {
        //                     context.read<PosController>().SOitemDeSelect(index);
        //                   },
        //                   value: context.read<PosController>().getsoData[index].checkBClr,
        //                   title: Container(
        //                     // padding: EdgeInsets.only(left: widget.btnWidth * 0.01, right: widget.btnWidth * 0.01),
        //                     //   color: Colors.amber,
        //                     width: widget.btnWidth * 0.77,
        //                     child: Container(
        //                       padding: EdgeInsets.all(6),
        //                       width: widget.btnWidth * 11,
        //                       height: widget.btnheight * 0.3,
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           Container(
        //                               alignment: Alignment.centerLeft,
        //                               width: widget.btnWidth * 0.18,
        //                               // color: Colors.green,
        //                               child: Text(
        //                                 context.watch<PosController>().getsoData[index].ItemCode.toString(),
        //                                 style: theme.textTheme.bodyLarge!.copyWith(),
        //                               )),
        //                           Container(
        //                               alignment: Alignment.centerLeft,
        //                               // color: Colors.green,
        //                               width: widget.btnWidth * 0.55,
        //                               child: Text(
        //                                 context.watch<PosController>().getsoData[index].ItemName.toString(),
        //                                 style: theme.textTheme.bodyLarge!.copyWith(),
        //                               )),
        //                           Container(
        //                               alignment: Alignment.centerRight,
        //                               // color: Colors.green,
        //                               width: widget.btnWidth * 0.1,
        //                               child: Text(
        //                                 context.watch<PosController>().getsoData[index].Qty.toString(),
        //                                 style: theme.textTheme.bodyLarge!.copyWith(),
        //                               )),
        //                           Container(
        //                               width: widget.btnWidth * 0.08,
        //                               // height: widget.btnheight * 0.16,
        //                               // color: Colors.blue,
        //                               alignment: Alignment.center,
        //                               child: TextFormField(
        //                                 readOnly: true,
        //                                 style: theme.textTheme.bodyMedium,
        //                                 onTap: () {
        //                                   context.read<PosController>().soqtycontroller[index].text = context.read<PosController>().soqtycontroller[index].text;
        //                                   context.read<PosController>().soqtycontroller[index].selection = TextSelection(
        //                                     baseOffset: 0,
        //                                     extentOffset: context.read<PosController>().soqtycontroller[index].text.length,
        //                                   );
        //                                 },
        //                                 onChanged: (v) {},
        //                                 cursorColor: Colors.grey,
        //                                 textDirection: TextDirection.rtl,
        //                                 keyboardType: TextInputType.number,
        //                                 onEditingComplete: () {
        //                                   setState(() {
        //                                     context.read<PosController>().soqtychangealertbc(index, context, theme);
        //                                   });

        //                                   context.read<PosController>().disableKeyBoard(context);
        //                                 },
        //                                 controller: context.read<PosController>().soqtycontroller[index],
        //                                 decoration: InputDecoration(
        //                                   enabledBorder: OutlineInputBorder(
        //                                     borderRadius: BorderRadius.circular(5),
        //                                     borderSide: BorderSide(color: Colors.grey),
        //                                   ),
        //                                   focusedBorder: OutlineInputBorder(
        //                                     borderRadius: BorderRadius.circular(5),
        //                                     borderSide: BorderSide(color: Colors.grey),
        //                                   ),
        //                                   contentPadding: const EdgeInsets.symmetric(
        //                                     vertical: 5,
        //                                     horizontal: 5,
        //                                   ),
        //                                 ),
        //                               )),
        //                         ],
        //                       ),
        //                     ),
        //                   ))));
        //     }),
        //           ),
        //         ],
      );
    });
  }

  // forClicksoBtn(BuildContext context, ThemeData theme) {
  //   return StatefulBuilder(builder: (context, st) {
  //     return SingleChildScrollView(
  //       child: Container(
  //         height: widget.btnheight * 2.5,
  //         width: widget.btnWidth * 1.35,
  //         padding: EdgeInsets.all(widget.btnheight * 0.02),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               padding: EdgeInsets.all(widget.btnheight * 0.06),
  //               height: widget.btnWidth * 0.07,
  //               color: theme.primaryColor,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Container(
  //                     alignment: Alignment.center,
  //                     width: widget.btnWidth * 0.2,
  //                     // color: Colors.green,
  //                     child: Text("S.O Number",
  //                         style: theme.textTheme.bodyMedium?.copyWith(
  //                           color: Colors.white,
  //                         )),
  //                   ),
  //                   Container(
  //                     // color: Colors.green,
  //                     width: widget.btnWidth * 0.35,
  //                     alignment: Alignment.center,
  //                     child: Text("Customer Name",
  //                         style: theme.textTheme.bodyMedium?.copyWith(
  //                           color: Colors.white,
  //                         )),
  //                   ),
  //                   Container(
  //                     alignment: Alignment.center,
  //                     width: widget.btnWidth * 0.18,
  //                     // color: Colors.green,
  //                     child: Text("Date",
  //                         style: theme.textTheme.bodyMedium?.copyWith(
  //                           color: Colors.white,
  //                         )),
  //                   ),
  //                   Container(
  //                     alignment: Alignment.centerRight,
  //                     width: widget.btnWidth * 0.18,
  //                     // color: Colors.red,
  //                     child: Text("Total",
  //                         style: theme.textTheme.bodyMedium?.copyWith(
  //                           color: Colors.white,
  //                         )),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               padding: EdgeInsets.all(widget.btnheight * 0.02),
  //               height: widget.btnheight * 1.9,
  //               width: double.infinity,
  //               //color: Colors.amber,
  //               child: ListView.builder(
  //                   itemCount:
  //                       context.watch<PosController>().soSalesmodl.length,
  //                   itemBuilder: (context, index) {
  //                     return Card(
  //                         color: Colors.grey[200],
  //                         child: ListTile(
  //                           contentPadding: EdgeInsets.all(0),
  //                           onTap: () {
  //                             context.read<PosController>().clearsoaqty();
  //                             context.read<PosController>().soOrderdata(
  //                                 index,
  //                                 context
  //                                     .read<PosController>()
  //                                     .soSalesmodl[index]
  //                                     .docentry
  //                                     .toString());
  //                             st(() {
  //                               Navigator.pop(context);
  //                               showDialog(
  //                                   context: context,
  //                                   barrierDismissible: false,
  //                                   builder: (BuildContext context) {
  //                                     return AlertDialog(
  //                                         insetPadding: EdgeInsets.all(
  //                                             widget.btnWidth * 0.01),
  //                                         contentPadding: EdgeInsets.zero,
  //                                         content: AlertBox(
  //                                           payMent: 'Sales Order',
  //                                           widget:
  //                                               forScanSoOrder(context, theme),
  //                                           buttonName: "OK",
  //                                           callback: () {
  //                                             setState(() {
  //                                               Navigator.pop(context);
  //                                               context
  //                                                   .read<PosController>()
  //                                                   .cpyfrmso = "CopyfromSo";

  //                                               context
  //                                                   .read<PosController>()
  //                                                   .mapsodata(
  //                                                       context, theme, index);
  //                                             });

  //                                             // : showDialog(
  //                                             //     context: context,
  //                                             //     barrierDismissible: true,
  //                                             //     builder: (BuildContext
  //                                             //         context) {
  //                                             //       return AlertDialog(
  //                                             //           contentPadding:
  //                                             //               EdgeInsets.all(
  //                                             //                   0),
  //                                             //           content: AlertBox(
  //                                             //             payMent: 'Alert',
  //                                             //             errormsg: true,
  //                                             //             widget: Center(
  //                                             //                 child:
  //                                             //                     ContentContainer(
  //                                             //               content:
  //                                             //                   'Scan the serial batch..!!',
  //                                             //               theme: widget
  //                                             //                   .theme,
  //                                             //             )),
  //                                             //             buttonName: null,
  //                                             //           ));
  //                                             //     });
  //                                           },
  //                                         ));
  //                                   });
  //                             });
  //                           },
  //                           title: Container(
  //                             padding: EdgeInsets.only(
  //                                 left: widget.btnWidth * 0.01,
  //                                 right: widget.btnWidth * 0.01),
  //                             //   color: Colors.amber,
  //                             width: widget.btnWidth * 0.77,
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 // Checkbox(
  //                                 //   activeColor: Colors.greenAccent,
  //                                 //   value: context
  //                                 //       .watch<PosController>()
  //                                 //       .valuefirst,
  //                                 //   onChanged: (value) {
  //                                 //     st(() {
  //                                 //       context
  //                                 //           .read<PosController>()
  //                                 //           .valuefirst = value!;
  //                                 //     });
  //                                 //   },
  //                                 // ),
  //                                 SizedBox(
  //                                     // color: Colors.red,
  //                                     width: widget.btnWidth * 0.2,
  //                                     child: Text(
  //                                       "Order /0${context.watch<PosController>().soSalesmodl[index].invoiceNum.toString()}",
  //                                       style: theme.textTheme.bodyLarge!
  //                                           .copyWith(),
  //                                     )),
  //                                 Container(
  //                                     alignment: Alignment.center,
  //                                     // color: Colors.red,
  //                                     width: widget.btnWidth * 0.4,
  //                                     child: Text(
  //                                       context
  //                                           .watch<PosController>()
  //                                           .soSalesmodl[index]
  //                                           .custName
  //                                           .toString(),
  //                                       style: theme.textTheme.bodyLarge!
  //                                           .copyWith(),
  //                                     )),
  //                                 Container(
  //                                     width: widget.btnWidth * 0.18,
  //                                     alignment: Alignment.center,
  //                                     // color: Colors.pink,
  //                                     child: Text(
  //                                       context
  //                                           .watch<PosController>()
  //                                           .soSalesmodl[index]
  //                                           .invoceDate
  //                                           .toString(),
  //                                       style: theme.textTheme.bodyLarge!
  //                                           .copyWith(),
  //                                     )),
  //                                 Container(
  //                                     alignment: Alignment.centerRight,
  //                                     width: widget.btnWidth * 0.18,
  //                                     // color: Colors.pink,

  //                                     child: Text(context
  //                                         .watch<PosController>()
  //                                         .soSalesmodl[index]
  //                                         .invoceAmount
  //                                         .toString())),
  //                               ],
  //                             ),
  //                           ),
  //                         ));
  //                   }),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  // }

  // forScanSoOrder(BuildContext context, ThemeData theme) {
  //   return StatefulBuilder(builder: (context, st) {
  //     return Container(
  //       // color: Colors.red,
  //       padding: EdgeInsets.all(
  //         widget.btnheight * 0.02,
  //       ),
  //       height: widget.btnheight * 2.3,
  //       width: widget.btnWidth * 2,
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Container(
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 context.read<PosController>().getsoData.isNotEmpty
  //                     ? Container(
  //                         child: Column(
  //                           children: [
  //                             Container(
  //                                 height: widget.btnheight * 0.19,
  //                                 padding: EdgeInsets.only(
  //                                   left: widget.btnWidth * 0.01,
  //                                   // right: widget.btnWidth * 0.005,
  //                                 ),
  //                                 color: theme.primaryColor,
  //                                 child: Row(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Container(
  //                                       // color: Colors.amber,
  //                                       width: widget.btnWidth * 0.16,
  //                                       child: Text("Item Code",
  //                                           style: theme.textTheme.bodyMedium
  //                                               ?.copyWith(
  //                                             color: Colors.white,
  //                                           )),
  //                                     ),
  //                                     Container(
  //                                       // color: Colors.yellow,
  //                                       alignment: Alignment.center,
  //                                       width: widget.btnWidth * 0.58,
  //                                       child: Text("Item Name",
  //                                           style: theme.textTheme.bodyMedium
  //                                               ?.copyWith(
  //                                             color: Colors.white,
  //                                           )),
  //                                     ),
  //                                     // Container(
  //                                     //   alignment: Alignment.center,
  //                                     //   width: widget.btnWidth * 0.17,
  //                                     //   // color: Colors.red,
  //                                     //   child: Text("Serial Batch",
  //                                     //       style: theme.textTheme.bodyMedium?.copyWith(
  //                                     //         color: Colors.white,
  //                                     //       )),
  //                                     // ),
  //                                     Container(
  //                                       // color: Colors.green,
  //                                       width: widget.btnWidth * 0.13,
  //                                       alignment: Alignment.center,
  //                                       child: Text("S.O Qty",
  //                                           style: theme.textTheme.bodyMedium
  //                                               ?.copyWith(
  //                                             color: Colors.white,
  //                                           )),
  //                                     ),
  //                                     // SizedBox(
  //                                     //   width: widget.btnWidth * 0.1,
  //                                     //   child: Text("Qty",
  //                                     //       style: theme.textTheme.bodyMedium
  //                                     //           ?.copyWith(
  //                                     //         color: Colors.white,
  //                                     //       )),
  //                                     // ),
  //                                   ],
  //                                 )),
  //                             SizedBox(
  //                               // color: Colors.amber,
  //                               height: widget.btnheight * 1.75,
  //                               width: widget.btnWidth * 0.9,
  //                               child: ListView.builder(
  //                                   itemCount: context
  //                                       .watch<PosController>()
  //                                       .getsoData
  //                                       .length,
  //                                   itemBuilder: (context, index) {
  //                                     return GestureDetector(
  //                                         onTap: () {
  //                                           // context
  //                                           //     .read<PosController>()
  //                                           //     .scannsolist(context, theme, index);
  //                                           // showDialog(
  //                                           //     context: context,
  //                                           //     barrierDismissible: true,
  //                                           //     builder: (BuildContext context) {
  //                                           //       return AlertDialog(
  //                                           //           contentPadding: EdgeInsets.all(0),
  //                                           //           content: AlertBox(
  //                                           //             payMent: 'Item List',
  //                                           //             widget: soItemseriallist(
  //                                           //                 context, theme),
  //                                           //             buttonName: null,
  //                                           //           ));
  //                                           //     });
  //                                         },
  //                                         child: Card(
  //                                           // color: Colors.red,
  //                                           child: Container(
  //                                             padding: EdgeInsets.all(6),
  //                                             width: widget.btnWidth * 11,
  //                                             height: widget.btnheight * 0.3,
  //                                             child: Row(
  //                                               mainAxisAlignment:
  //                                                   MainAxisAlignment
  //                                                       .spaceBetween,
  //                                               children: [
  //                                                 Container(
  //                                                     alignment:
  //                                                         Alignment.centerLeft,
  //                                                     width: widget.btnWidth *
  //                                                         0.16,
  //                                                     // color: Colors.green,
  //                                                     child: Text(
  //                                                       context
  //                                                           .watch<
  //                                                               PosController>()
  //                                                           .getsoData[index]
  //                                                           .ItemCode
  //                                                           .toString(),
  //                                                       style: theme.textTheme
  //                                                           .bodyLarge!
  //                                                           .copyWith(),
  //                                                     )),
  //                                                 Container(
  //                                                     alignment:
  //                                                         Alignment.centerLeft,
  //                                                     // color: Colors.green,
  //                                                     width: widget.btnWidth *
  //                                                         0.58,
  //                                                     child: Text(
  //                                                       context
  //                                                           .watch<
  //                                                               PosController>()
  //                                                           .getsoData[index]
  //                                                           .ItemName
  //                                                           .toString(),
  //                                                       maxLines: 2,
  //                                                       style: theme.textTheme
  //                                                           .bodyLarge!
  //                                                           .copyWith(),
  //                                                     )),
  //                                                 Container(
  //                                                     padding: EdgeInsets.only(
  //                                                         right:
  //                                                             widget.btnWidth *
  //                                                                 0.01),
  //                                                     alignment:
  //                                                         Alignment.centerRight,
  //                                                     // color: Colors.green,
  //                                                     width: widget.btnWidth *
  //                                                         0.08,
  //                                                     child: Text(
  //                                                       context
  //                                                           .watch<
  //                                                               PosController>()
  //                                                           .getsoData[index]
  //                                                           .Qty
  //                                                           .toString(),
  //                                                       style: theme.textTheme
  //                                                           .bodyLarge!
  //                                                           .copyWith(),
  //                                                     )),
  //                                               ],
  //                                             ),
  //                                           ),
  //                                         ));
  //                                   }),
  //                             ),
  //                           ],
  //                         ),
  //                       )
  //                     : Container(),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   width: widget.btnWidth * 1,
  //                   decoration: BoxDecoration(
  //                     // color: Colors.red,
  //                     border: Border.all(color: Colors.grey[300]!),
  //                     borderRadius: BorderRadius.all(Radius.circular(5)),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color:
  //                             Colors.white.withOpacity(0.3), //color of shadow
  //                         spreadRadius: 3, //spread radius
  //                         blurRadius: 2, // blur radius
  //                         offset: Offset(0, 2), // changes position of shadow
  //                       ),
  //                     ],
  //                   ),
  //                   child: TextFormField(
  //                     // autofocus: true,
  //                     controller:
  //                         context.watch<PosController>().mycontroller[79],
  //                     style: theme.textTheme.bodyMedium!
  //                         .copyWith(color: Colors.black),

  //                     onChanged: (val) {},
  //                     onEditingComplete: () {
  //                       setState(() {
  //                         context.read<PosController>().scannsolist(
  //                             context
  //                                 .read<PosController>()
  //                                 .mycontroller[79]
  //                                 .text
  //                                 .toString()
  //                                 .trim()
  //                                 .toUpperCase(),
  //                             context,
  //                             theme);
  //                         // context.read<PosController>().scannsolist(
  //                         //     context
  //                         //         .read<PosController>()
  //                         //         .mycontroller[79]
  //                         //         .text
  //                         //         .toString()
  //                         //         .toUpperCase()
  //                         //         .trim(),
  //                         //     context,
  //                         //     theme);
  //                       });
  //                       // log("message:::${widget.posController.getsoData.length}");
  //                     },
  //                     // Only numbers can be entered
  //                     decoration: InputDecoration(
  //                       border: InputBorder.none,
  //                       contentPadding: EdgeInsets.all(8),
  //                       hintText: "Scan Serial Batch",
  //                       hintStyle: theme.textTheme.bodyMedium!
  //                           .copyWith(color: Colors.grey[600]),
  //                       suffixIcon: IconButton(
  //                         onPressed: () {},
  //                         icon: Icon(
  //                           Icons.search,
  //                         ),
  //                       ),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(30),
  //                         borderSide: BorderSide(color: Colors.white),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(30),
  //                         borderSide: BorderSide(color: Colors.white),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: widget.btnheight * 0.03,
  //                 ),
  //                 context.watch<PosController>().soitemcodelistitem.isNotEmpty
  //                     ? SizedBox(
  //                         // color: Colors.amber,
  //                         height: widget.btnheight * 1.75,
  //                         width: widget.btnWidth * 1,
  //                         child: ListView.builder(
  //                             itemCount: context
  //                                 .watch<PosController>()
  //                                 .soitemcodelistitem
  //                                 .length,
  //                             itemBuilder: (context, index) {
  //                               int soqqttyy = context
  //                                       .read<PosController>()
  //                                       .soqtycontroller[index]
  //                                       .text
  //                                       .isNotEmpty
  //                                   ? int.parse(context
  //                                       .read<PosController>()
  //                                       .soqtycontroller[index]
  //                                       .text
  //                                       .toString())
  //                                   : 0;
  //                               return Card(
  //                                   child: Container(
  //                                       // color: Colors.pink,
  //                                       width: widget.btnWidth * 1,
  //                                       height: widget.btnheight * 0.3,
  //                                       child: Row(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.spaceBetween,
  //                                           children: [
  //                                             Container(
  //                                                 alignment:
  //                                                     Alignment.centerLeft,
  //                                                 width: widget.btnWidth * 0.18,
  //                                                 // color: Colors.yellow,
  //                                                 child: Text(
  //                                                   context
  //                                                       .watch<PosController>()
  //                                                       .soitemcodelistitem[
  //                                                           index]
  //                                                       .ItemCode
  //                                                       .toString(),
  //                                                   style: theme
  //                                                       .textTheme.bodyLarge!
  //                                                       .copyWith(),
  //                                                 )),
  //                                             Container(
  //                                                 alignment:
  //                                                     Alignment.centerLeft,
  //                                                 width: widget.btnWidth * 0.5,
  //                                                 // color: Colors.yellow,
  //                                                 child: Text(
  //                                                   context
  //                                                       .watch<PosController>()
  //                                                       .soitemcodelistitem[
  //                                                           index]
  //                                                       .ItemName
  //                                                       .toString(),
  //                                                   style: theme
  //                                                       .textTheme.bodyLarge!
  //                                                       .copyWith(),
  //                                                 )),
  //                                             Container(
  //                                                 alignment:
  //                                                     Alignment.centerLeft,
  //                                                 // width: widget.btnWidth * 0.16,
  //                                                 // color: Colors.green,
  //                                                 child: Text(
  //                                                   context
  //                                                       .watch<PosController>()
  //                                                       .soitemcodelistitem[
  //                                                           index]
  //                                                       .SerialBatch
  //                                                       .toString(),
  //                                                   style: theme
  //                                                       .textTheme.bodyLarge!
  //                                                       .copyWith(),
  //                                                 )),
  //                                             soqqttyy != 0
  //                                                 ? Container(
  //                                                     width: widget.btnWidth *
  //                                                         0.15,
  //                                                     // color: Colors.green,
  //                                                     child: Row(
  //                                                       mainAxisAlignment:
  //                                                           MainAxisAlignment
  //                                                               .spaceEvenly,
  //                                                       children: [
  //                                                         Container(
  //                                                             width: widget
  //                                                                     .btnWidth *
  //                                                                 0.08,
  //                                                             alignment:
  //                                                                 Alignment
  //                                                                     .center,
  //                                                             child:
  //                                                                 TextFormField(
  //                                                               readOnly: true,
  //                                                               style: theme
  //                                                                   .textTheme
  //                                                                   .bodyMedium,
  //                                                               // onTap: () {
  //                                                               // context
  //                                                               //         .read<PosController>()
  //                                                               //         .soqtycontroller[index]
  //                                                               //         .text =
  //                                                               //       context
  //                                                               //           .read<PosController>()
  //                                                               //           .soqtycontroller[
  //                                                               //               index]
  //                                                               //           .text;
  //                                                               //   context
  //                                                               //       .read<PosController>()
  //                                                               //       .soqtycontroller[index]
  //                                                               //       .selection = TextSelection(
  //                                                               //     baseOffset: 0,
  //                                                               //     extentOffset: context
  //                                                               //         .read<PosController>()
  //                                                               //         .soqtycontroller[index]
  //                                                               //         .text
  //                                                               //         .length,
  //                                                               //   );
  //                                                               // },
  //                                                               onChanged:
  //                                                                   (v) {},
  //                                                               cursorColor:
  //                                                                   Colors.grey,
  //                                                               textDirection:
  //                                                                   TextDirection
  //                                                                       .rtl,
  //                                                               keyboardType:
  //                                                                   TextInputType
  //                                                                       .number,
  //                                                               onEditingComplete:
  //                                                                   () {
  //                                                                 setState(() {
  //                                                                   context
  //                                                                       .read<
  //                                                                           PosController>()
  //                                                                       .soqtychangealertbc(
  //                                                                           index,
  //                                                                           context,
  //                                                                           theme);
  //                                                                 });

  //                                                                 context
  //                                                                     .read<
  //                                                                         PosController>()
  //                                                                     .disableKeyBoard(
  //                                                                         context);
  //                                                               },
  //                                                               controller: context
  //                                                                   .read<
  //                                                                       PosController>()
  //                                                                   .soqtycontroller[index],
  //                                                               decoration:
  //                                                                   InputDecoration(
  //                                                                 border:
  //                                                                     InputBorder
  //                                                                         .none,
  //                                                                 // enabledBorder:
  //                                                                 //     OutlineInputBorder(
  //                                                                 //   borderRadius:
  //                                                                 //       BorderRadius.circular(
  //                                                                 //           5),
  //                                                                 //   borderSide: BorderSide(
  //                                                                 //       color: Colors.grey),
  //                                                                 // ),
  //                                                                 // focusedBorder:
  //                                                                 //     OutlineInputBorder(
  //                                                                 //   borderRadius:
  //                                                                 //       BorderRadius.circular(
  //                                                                 //           5),
  //                                                                 //   borderSide: BorderSide(
  //                                                                 //       color: Colors.grey),
  //                                                                 // ),
  //                                                                 contentPadding:
  //                                                                     const EdgeInsets
  //                                                                         .symmetric(
  //                                                                   vertical: 5,
  //                                                                   horizontal:
  //                                                                       5,
  //                                                                 ),
  //                                                               ),
  //                                                             )),
  //                                                         Container(
  //                                                           alignment: Alignment
  //                                                               .center,
  //                                                           child: InkWell(
  //                                                             onTap: () {
  //                                                               context
  //                                                                   .read<
  //                                                                       PosController>()
  //                                                                   .soItemDecrement(
  //                                                                     context,
  //                                                                     theme,
  //                                                                     index,
  //                                                                   );
  //                                                             },
  //                                                             child: Container(
  //                                                               alignment:
  //                                                                   Alignment
  //                                                                       .center,
  //                                                               width: widget
  //                                                                       .btnWidth *
  //                                                                   0.05,
  //                                                               height: widget
  //                                                                       .btnheight *
  //                                                                   0.09,
  //                                                               color:
  //                                                                   Colors.blue,
  //                                                               child: Icon(
  //                                                                 Icons.remove,
  //                                                                 color: Colors
  //                                                                     .white,
  //                                                                 // size: widget.btnheight *
  //                                                                 //     0.05,
  //                                                               ),
  //                                                             ),
  //                                                           ),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   )
  //                                                 : Container(
  //                                                     width: widget.btnWidth *
  //                                                         0.15,
  //                                                   ),
  //                                           ])));
  //                             }))
  //                     : Container()
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }
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
