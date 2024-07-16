// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';
import '../../../Controller/RefundsController/RefundController.dart';

class RefundBtmBtn extends StatelessWidget {
  RefundBtmBtn({
    Key? key,
    required this.theme,
    required this.btnWidth,
    required this.btnheight,
  }) : super(key: key);

  final ThemeData theme;
  double btnheight;
  double btnWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: btnheight * 0.03,
        left: btnheight * 0.03,
        right: btnheight * 0.03,
        bottom: btnheight * 0.03,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      height: btnheight,
      width: btnWidth,
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
                  padding: EdgeInsets.all(btnheight * 0.01),
                  child: Text(
                    context.read<RefundController>().getpaymentWay.isNotEmpty
                        ? "Payment Method"
                        : '',
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),

                // SizedBox(height:paymentHeight *0.02),
                SizedBox(
                  // color: Colors.green,
                  height: btnheight * 0.65,
                  child: ListView.builder(
                      itemCount: context
                          .watch<RefundController>()
                          .getpaymentWay
                          .length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 2,
                            child: Container(
                                padding: EdgeInsets.only(
                                  right: btnheight * 0.03,
                                  left: btnheight * 0.03,
                                  bottom: btnheight * 0.03,
                                  top: btnheight * 0.03,
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
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: btnWidth * 0.25,
                                      // color: Colors.red,
                                      child: Text(
                                        '${context.watch<RefundController>().getpaymentWay[index].type}',
                                        // '${posController.getpaymentWay[index].dateTime}',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      width: btnWidth * 0.28,
                                      // color: Colors.green,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        context
                                                    .watch<RefundController>()
                                                    .getpaymentWay[index]
                                                    .reference !=
                                                null
                                            ? '${context.watch<RefundController>().getpaymentWay[index].reference}'
                                            : '',
                                        // '${posController.getpaymentWay[index].type}',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        context
                                            .watch<RefundController>()
                                            .config
                                            .splitValues(context
                                                .watch<RefundController>()
                                                .getpaymentWay[index]
                                                .amt!
                                                .toStringAsFixed(2)),
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .read<RefundController>()
                                            .removePayment(index);
                                      },
                                      child: SizedBox(
                                        width: btnWidth * 0.05,
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
          SizedBox(height: btnheight * 0.01),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
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
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: btnheight * 0.15,
                    width: btnWidth * 0.25,
                    child: Text("Suspend",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              GestureDetector(
                  onTap: () {
                    context
                        .read<RefundController>()
                        .onHoldClicked(context, theme);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        // color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: btnheight * 0.15,
                    width: btnWidth * 0.25,
                    child: Text("Hold",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
              GestureDetector(
                  onTap: () {
                    context.read<RefundController>().submitted(context, theme);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        // color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: btnheight * 0.15,
                    width: btnWidth * 0.25,
                    child: Text("Submit",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  forSuspend(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
            padding: EdgeInsets.all(btnheight * 0.05),
            child: Center(
                child: Text(
                    "You about to suspended all information will be unsaved"))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  context
                      .read<RefundController>()
                      .clearSuspendedData(context, theme);
                  // context.read<RefundController>().clearpayData();
                },
                child: Container(
                  width: btnWidth * 0.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        color: theme.primaryColor,
                      )),
                  height: btnheight * 0.1,
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
                  width: btnWidth * 0.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: theme.primaryColor,
                      border: Border.all(
                        color: theme.primaryColor,
                      )),
                  height: btnheight * 0.1,
                  child: Text("No",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      )),
                )),
          ],
        ),
      ],
    ));
  }
}
