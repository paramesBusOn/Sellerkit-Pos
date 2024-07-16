// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';

class MobPayReceiptDetails extends StatelessWidget {
  MobPayReceiptDetails({
    Key? key,
    required this.theme,
    required this.prdPmt,
  }) : super(key: key);
  final ThemeData theme;
  PayreceiptController prdPmt;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Screens.padingHeight(context) * 0.13,
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
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.withOpacity(0.05),
              ),
              padding: EdgeInsets.only(
                  top: Screens.padingHeight(context) * 0.01,
                  left: Screens.width(context) * 0.01,
                  right: Screens.width(context) * 0.01,
                  bottom: Screens.padingHeight(context) * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            // prdPmt.insertpaymentreceipt();
                          },
                          child: Text(
                            "Total Document",
                            style: theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                      ),
                      Container(
                          width: Screens.width(context) * 0.1,
                          alignment: Alignment.centerRight,
                          child: prdPmt.getScanneditemData.isEmpty
                              ? Text(
                                  "0",
                                )
                              // Container()
                              : Text(
                                  prdPmt.getScanneditemData.length.toString(),
                                  // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
                                  style:
                                      theme.textTheme.bodyMedium?.copyWith())),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        // width: Screens.width(context) * 0.15,
                        child: Text(
                          "Total Due",
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                      Container(
                        // width: Screens.width(context) * 0.17,
                        alignment: Alignment.centerRight,
                        child: prdPmt.getScanneditemData.isEmpty
                            ? Text(
                                "0.00",
                                style: theme.textTheme.bodyMedium?.copyWith(),
                              )
                            : Text(
                                prdPmt.totalduepay!.toStringAsFixed(2),
                                style: theme.textTheme.bodyMedium?.copyWith(),
                              ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: Screens.width(context) * 0.15,
                        // height: paymentHeight * 0.03,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Total Paid",
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                      Container(
                        width: Screens.width(context) * 0.17,
                        alignment: Alignment.centerRight,
                        child: prdPmt.totalduepay == 0
                            ? Text("0.00")
                            : Text(
                                prdPmt.getSumTotalPaid().toStringAsFixed(2),
                                style: theme.textTheme.bodyMedium?.copyWith(),
                              ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: Screens.width(context) * 0.15,
                        // height: paymentHeight * 0.03,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Balance",
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor, fontSize: 16),
                        ),
                      ),
                      Container(
                        // width:Screens.width(context)* 0.17,
                        alignment: Alignment.centerRight,
                        child: prdPmt.getScanneditemData.isEmpty
                            ? Text("0.00")
                            : prdPmt.totalduepay == 0
                                ? Text(prdPmt.config
                                    .splitValues(prdPmt.totalduepay.toString()))
                                // Container()
                                : Text(
                                    "${prdPmt.getBalancePaid().toStringAsFixed(2)}",
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith(),
                                  ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Screens.width(context) * 0.9,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(3),
              //   color: Colors.grey.withOpacity(0.01),
              // ),
              child: TextFormField(
                controller: prdPmt.mycontroller[50],
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
                  hintText: 'Remarks',
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
          ],
        ));
  }
}
