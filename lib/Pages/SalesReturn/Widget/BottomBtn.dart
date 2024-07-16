// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/SalesReturnController/SalesReturnController.dart';
import '../../../Widgets/ContentContainer.dart';

class BottomBtn extends StatefulWidget {
  BottomBtn({
    Key? key,
    required this.theme,
    required this.btnWidth,
    required this.btnheight,
    // required this.posSR
  }) : super(key: key);

  final ThemeData theme;
  double btnheight;
  double btnWidth;
  // SalesReturnController posSR;

  @override
  State<BottomBtn> createState() => _BottomBtnState();
}

class _BottomBtnState extends State<BottomBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.01),
      height: widget.btnheight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // color: Colors.green,
            padding: EdgeInsets.all(widget.btnheight * 0.01),
            child: Text(
              context.read<SalesReturnController>().paymentWay.isEmpty ? "" : "Payment Method",
              textAlign: TextAlign.start,
              style: widget.theme.textTheme.bodyLarge?.copyWith(
                color: widget.theme.primaryColor,
              ),
            ),
          ),

          // SizedBox(height:paymentHeight *0.02),
          SizedBox(
            //color: Colors.blue,
            height: widget.btnheight * 0.6,
            child: context.read<SalesReturnController>().paymentWay2.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: context.watch<SalesReturnController>().paymentWay2.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // posSR.clearPayment();
                        },
                        child: Card(
                          elevation: 2,
                          child: Container(
                              padding: EdgeInsets.only(
                                right: widget.btnheight * 0.03,
                                left: widget.btnheight * 0.03,
                                bottom: widget.btnheight * 0.03,
                                top: widget.btnheight * 0.03,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.btnWidth * 0.25,
                                    // color: Colors.red,
                                    child: Text(
                                      '${context.watch<SalesReturnController>().getpaymentWay2[index].type}',
                                      // '${posController.getpaymentWay[index].dateTime}',
                                      style: widget.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: widget.btnWidth * 0.28,
                                    // color: Colors.green,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${context.watch<SalesReturnController>().getpaymentWay2[index].reference}',
                                      // '${posController.getpaymentWay[index].type}',
                                      style: widget.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      context.watch<SalesReturnController>().config.splitValues(context.watch<SalesReturnController>().getpaymentWay2[index].amt!.toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  context.watch<SalesReturnController>().paymentWay2.isNotEmpty
                                      ? Container(
                                          width: widget.btnWidth * 0.05,
                                        )
                                      : InkWell(
                                          onTap: () {
                                            //  context.watch<SalesReturnController>().removePayment(index);
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
                    itemCount: context.watch<SalesReturnController>().paymentWay.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // posSR.clearPayment();
                        },
                        child: Card(
                          elevation: 2,
                          child: Container(
                              padding: EdgeInsets.only(
                                right: widget.btnheight * 0.03,
                                left: widget.btnheight * 0.03,
                                bottom: widget.btnheight * 0.03,
                                top: widget.btnheight * 0.03,
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
                                  SizedBox(
                                    width: widget.btnWidth * 0.25,
                                    // color: Colors.red,
                                    child: Text(
                                      '${context.watch<SalesReturnController>().getpaymentWay[index].type}',
                                      // '${posController.getpaymentWay[index].dateTime}',
                                      style: widget.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: widget.btnWidth * 0.28,
                                    // color: Colors.green,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${context.watch<SalesReturnController>().getpaymentWay[index].reference}',
                                      // '${posController.getpaymentWay[index].type}',
                                      style: widget.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      context.watch<SalesReturnController>().config.splitValues(context.watch<SalesReturnController>().getpaymentWay[index].amt!.toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<SalesReturnController>().removePayment(index);
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
          Container(
            //color: Colors.red,
            padding: EdgeInsets.all(
              widget.btnheight * 0.01,
            ),
            child: context.read<SalesReturnController>().scanneditemData2.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              context.read<SalesReturnController>().cancelbtn = true;
                              context.read<SalesReturnController>().clickacancelbtn(context, widget.theme);
                            });
                          },
                          child: Container(
                            width: widget.btnWidth * 0.28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                              // border: Border.all(
                              //   color: theme.primaryColor,
                              // )
                            ),
                            height: widget.btnheight * 0.2,
                            child: context.read<SalesReturnController>().cancelbtn == false
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
                              context.read<SalesReturnController>().scanneditemData2.clear();
                              //  context.watch<SalesReturnController>().scanneditemData.clear();
                              context.read<SalesReturnController>().selectedcust2 = null;
                              context.read<SalesReturnController>().totalPayment2 = null;
                              context.read<SalesReturnController>().paymentWay2.clear();
                              context.read<SalesReturnController>().scanneditemData.clear();
                              context.read<SalesReturnController>().cancelbtn = false;
                              context.read<SalesReturnController>().selectedcust = null;
                              context.read<SalesReturnController>().totalPayment = null;
                              context.read<SalesReturnController>().paymentWay.clear();
                              context.read<SalesReturnController>().getdraftindex();

                              context.read<SalesReturnController>().mycontroller2[50].text = "";
                            });
                          },
                          child: Container(
                            width: widget.btnWidth * 0.28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                              // border: Border.all(
                              //   color: theme.primaryColor,
                              // )
                            ),
                            height: widget.btnheight * 0.2,
                            child: Text("Clear",
                                style: widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.black,
                                )),
                          )),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // alignment: Alignment.center,
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(5),
                        //     border: Border.all(
                        //       color: widget.theme.primaryColor,
                        //     )),
                        height: widget.btnheight * 0.23,
                        width: widget.btnWidth * 0.28,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  // width: 5.0,
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context.read<SalesReturnController>().freezeScrn == true
                                ? null
                                : () {
                                    context.read<SalesReturnController>().freezeScrn = true;
                                    if (context.read<SalesReturnController>().selectedcust == null) {
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
                                                      content: 'Choose Customer..!!',
                                                      theme: widget.theme,
                                                    )),
                                                    buttonName: null));
                                          }).then((value) {
                                        context.read<SalesReturnController>().freezeScrn = false;
                                      });
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                contentPadding: EdgeInsets.all(0),
                                                content: AlertBox(
                                                  buttonName: null,
                                                  payMent: 'Suspended',
                                                  widget: forSuspend(context, widget.theme),
                                                ));
                                          }).then((value) {
                                        setState(() {
                                          context.read<SalesReturnController>().freezeScrn = false;
                                        });
                                      });
                                    }
                                    context.read<SalesReturnController>().disableKeyBoard(context);
                                  },
                            child: Text(
                              "Suspend",
                              style: widget.theme.textTheme.bodyMedium!.copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                    height: widget.btnheight * 0.23,
                        width: widget.btnWidth * 0.28,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  // width: 5.0,
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context.read<SalesReturnController>().freezeScrn == true
                                ? null
                                : () {
                                    context.read<SalesReturnController>().onHoldClicked(context, widget.theme);
                                  },
                            child: Text(
                              "Hold",
                              style: widget.theme.textTheme.bodyMedium!.copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        width: widget.btnWidth * 0.28,
                        height: widget.btnheight * 0.23,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                // backgroundColor: widget.theme.primaryColor,
                                ),
                            onPressed: context.read<SalesReturnController>().freezeScrn == false
                                ? () {
                                    log('VV::${context.read<SalesReturnController>().freezeScrn}');

                                    setState(() {
                                      context.read<SalesReturnController>().confirmReturn(context, widget.theme);
                                    });
                                    context.read<SalesReturnController>().disableKeyBoard(context);
                                  }
                                : null,
                            child: Text(
                              "Confirm Request",
                              style: widget.theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
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
        padding: EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.04, vertical: Screens.bodyheight(context) * 0.01),
        child: Column(
          children: [
            SizedBox(height: widget.btnheight * 0.3, child: Center(child: Text("You about to suspended all information will be unsaved  "))),
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
                        context.read<SalesReturnController>().freezeScrn = true;
                        context.read<SalesReturnController>().clearSuspendedData(context, theme);
                      },
                      child: Text("Yes")),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.15,
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<SalesReturnController>().freezeScrn = false;
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
