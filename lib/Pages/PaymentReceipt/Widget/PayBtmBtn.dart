// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/PaymentReceiptController/PayReceiptController.dart';

class PayBtmBtn extends StatefulWidget {
  PayBtmBtn({
    Key? key,
    required this.theme,
    required this.btnWidth,
    required this.btnheight,
  }) : super(key: key);

  final ThemeData theme;
  double btnheight;
  double btnWidth;

  @override
  State<PayBtmBtn> createState() => _PayBtmBtnState();
}

class _PayBtmBtnState extends State<PayBtmBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.btnheight * 0.03,
        left: widget.btnheight * 0.03,
        right: widget.btnheight * 0.03,
        bottom: widget.btnheight * 0.03,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      height: widget.btnheight,
      width: widget.btnWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // payController.getpaymentWay.isEmpty
          //     ? Container(
          //         color: Colors.red,
          //         child: Text("getpaymentWay"),
          //       )
          //     :
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(widget.btnheight * 0.01),
                  child: Text(
                    context
                            .read<PayreceiptController>()
                            .getpaymentWay
                            .isNotEmpty
                        ? "Payment Method"
                        : '',
                    textAlign: TextAlign.start,
                    style: widget.theme.textTheme.bodyMedium?.copyWith(
                      color: widget.theme.primaryColor,
                    ),
                  ),
                ),

                // SizedBox(height:paymentHeight *0.02),
                SizedBox(
                  // color: Colors.green,
                  height: widget.btnheight * 0.65,
                  child: context
                          .read<PayreceiptController>()
                          .getpaymentWay2
                          .isNotEmpty
                      ? ListView.builder(
                          itemCount: context
                              .read<PayreceiptController>()
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
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.5),
                                      //     spreadRadius: 3,
                                      //     blurRadius: 7,
                                      //     offset: Offset(0,
                                      //         3), // changes position of shadow
                                      //   ),
                                      // ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: widget.btnWidth * 0.25,
                                          // color: Colors.red,
                                          child: Text(
                                            '${context.watch<PayreceiptController>().getpaymentWay2[index].type}',
                                            // '${posController.getpaymentWay[index].dateTime}',
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: widget.btnWidth * 0.28,
                                          // color: Colors.green,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${context.watch<PayreceiptController>().getpaymentWay2[index].reference}',
                                            // '${posController.getpaymentWay[index].type}',
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            context
                                                .read<PayreceiptController>()
                                                .config
                                                .splitValues(context
                                                    .read<
                                                        PayreceiptController>()
                                                    .getpaymentWay2[index]
                                                    .amt!
                                                    .toStringAsFixed(2)),
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: widget.btnWidth * 0.05,
                                          //  color: Colors.blue,
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     widget.payController
                                        //         .removePayment(index);
                                        //   },
                                        //   child: Container(
                                        //     width: widget.btnWidth * 0.05,
                                        //     //  color: Colors.blue,
                                        //     child: Icon(
                                        //       Icons.delete,
                                        //       color: Colors.red,
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    )),
                              ),
                            );
                          })
                      : ListView.builder(
                          itemCount: context
                              .watch<PayreceiptController>()
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
                                            '${context.watch<PayreceiptController>().getpaymentWay[index].type}',
                                            // '${posController.getpaymentWay[index].dateTime}',
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: widget.btnWidth * 0.28,
                                          // color: Colors.green,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${context.watch<PayreceiptController>().getpaymentWay[index].reference}',
                                            // '${posController.getpaymentWay[index].type}',
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            context
                                                .read<PayreceiptController>()
                                                .config
                                                .splitValues(context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getpaymentWay[index]
                                                    .amt!
                                                    .toStringAsFixed(2)),
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<PayreceiptController>()
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
          SizedBox(height: widget.btnheight * 0.01),
          context.read<PayreceiptController>().selectedcust2 != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // GestureDetector(
                    //     onTap: () {},
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //         color: Colors.grey[300],
                    //         borderRadius: BorderRadius.circular(5),
                    //         // border: Border.all(
                    //         //   color: widget.theme.primaryColor,
                    //         // )
                    //       ),
                    //       height: widget.btnheight * 0.15,
                    //       width: widget.btnWidth * 0.25,
                    //       child: Text("Cancel",
                    //           style:
                    //               widget.theme.textTheme.bodyMedium?.copyWith(
                    //             color: Colors.black,
                    //           )),
                    //     )),
                    GestureDetector(
                        onTap: () async {
                          await context
                              .read<PayreceiptController>()
                              .clearpayData();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                            // border: Border.all(
                            //   color: widget.theme.primaryColor,
                            // )
                          ),
                          height: widget.btnheight * 0.15,
                          width: widget.btnWidth * 0.25,
                          child: Text("Clear",
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.black,
                              )),
                        )),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      // alignment: Alignment.center,
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //     border: Border.all(
                      //       color: widget.theme.primaryColor,
                      //     )),
                      height: widget.btnheight * 0.15,
                      width: widget.btnWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                // width: 5.0,
                                color: widget.theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<PayreceiptController>()
                                      .OndDisablebutton ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<PayreceiptController>()
                                      .OndDisablebutton = true;
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              content: AlertBox(
                                                payMent: 'Suspended',
                                                widget: forSuspend(context),
                                                buttonName: null,
                                                callback: () {
                                                  Navigator.pop(context);
                                                },
                                              ));
                                        });
                                      }).then((value) {
                                    context
                                        .read<PayreceiptController>()
                                        .OndDisablebutton = false;
                                  });
                                },
                          child: Text(
                            "Suspend",
                            style: widget.theme.textTheme.bodyMedium!
                                .copyWith(color: widget.theme.primaryColor),
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
                      height: widget.btnheight * 0.15,
                      width: widget.btnWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(
                                // width: 5.0,
                                color: widget.theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<PayreceiptController>()
                                      .OndDisablebutton ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<PayreceiptController>()
                                      .onHoldClicked(context, widget.theme);
                                },
                          child: Text(
                            "Hold",
                            style: widget.theme.textTheme.bodyMedium!
                                .copyWith(color: widget.theme.primaryColor),
                          )),
                    ),
                    SizedBox(
                      height: widget.btnheight * 0.15,
                      width: widget.btnWidth * 0.25,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: widget.theme.primaryColor,
                              side: BorderSide(
                                // width: 5.0,
                                color: widget.theme.primaryColor,
                              )),
                          onPressed: context
                                      .read<PayreceiptController>()
                                      .OndDisablebutton ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<PayreceiptController>()
                                      .submitted(context, widget.theme);
                                },
                          child: Text(
                            "Submit",
                            style: widget.theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          )),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  forSuspend(
    BuildContext context,
  ) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.02,
            vertical: Screens.bodyheight(context) * 0.005),
        child: Column(
          children: [
            SizedBox(
                height: widget.btnheight * 0.25,
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
                  width: Screens.width(context) * 0.15,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<PayreceiptController>()
                            .clearSuspendedData(context, widget.theme);
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
}
