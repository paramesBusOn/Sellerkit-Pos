// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Controller/PaymentReceiptController/PayReceiptController.dart';
import 'package:provider/provider.dart';

class PayReceiptPayDetails extends StatefulWidget {
  PayReceiptPayDetails({Key? key, required this.theme, required this.paymentHeight, required this.paymentWidth}) : super(key: key);
  final ThemeData theme;
  double paymentHeight;
  double paymentWidth;

  @override
  State<PayReceiptPayDetails> createState() => _PayReceiptPayDetailsState();
}

class _PayReceiptPayDetailsState extends State<PayReceiptPayDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.paymentHeight,
        width: widget.paymentWidth,
        padding: EdgeInsets.only(
          top: widget.paymentHeight * 0.05,
          left: widget.paymentHeight * 0.01,
          right: widget.paymentHeight * 0.01,
          bottom: widget.paymentHeight * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          // height: paymentHeight * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: context.watch<PayreceiptController>().selectedcust2 != null || context.watch<PayreceiptController>().getScanneditemData2.isNotEmpty ? Colors.grey[300] : Colors.grey.withOpacity(0.05),
          ),
          padding: EdgeInsets.only(
            top: widget.paymentHeight * 0.01,
            left: widget.paymentHeight * 0.01,
            right: widget.paymentHeight * 0.02,
            bottom: widget.paymentHeight * 0.02,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: widget.paymentWidth * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: widget.paymentWidth * 0.3,
                      // height: paymentHeight * 0.11,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: context.watch<PayreceiptController>().getScanneditemData2.isNotEmpty
                                    ? null
                                    : () {
                                        context.read<PayreceiptController>().insertpaymentreceipt();
                                      },
                                child: SizedBox(
                                  width: widget.paymentWidth * 0.18,
                                  child: Text(
                                    "Total Document",
                                    style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                  ),
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.1,
                                  alignment: Alignment.centerRight,
                                  child: context.watch<PayreceiptController>().selectedcust2 != null || context.watch<PayreceiptController>().getScanneditemData2.isNotEmpty
                                      ? Text(context.watch<PayreceiptController>().getScanneditemData2.length.toString(), style: widget.theme.textTheme.bodyMedium?.copyWith())
                                      : context.watch<PayreceiptController>().getScanneditemData.isEmpty
                                          ? Text(
                                              "0",
                                            )
                                          // Container()
                                          : Text(context.watch<PayreceiptController>().getScanneditemData.length.toString(),
                                              // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
                                              style: widget.theme.textTheme.bodyMedium?.copyWith())),
                            ],
                          ),
                        ],
                      ),
                    ),
                    context.watch<PayreceiptController>().selectedcust2 != null || context.watch<PayreceiptController>().scanneditemData2.isNotEmpty
                        ? Container(
                            alignment: Alignment.center,
                            width: widget.paymentWidth * 1,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(3),
                              // color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: context.watch<PayreceiptController>().remarkcontroller3,
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
                            width: widget.paymentWidth * 1,
                            decoration: BoxDecoration(
                              // color: Colors.red,

                              borderRadius: BorderRadius.circular(3),
                              // color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: context.watch<PayreceiptController>().mycontroller[50],
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
                  ],
                ),
              ),
              SizedBox(
                width: widget.paymentWidth * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: widget.paymentWidth * 0.15,
                          child: Text(
                            "Total Due",
                            style: widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.17,
                          alignment: Alignment.centerRight,
                          child: context.watch<PayreceiptController>().selectedcust2 != null || context.watch<PayreceiptController>().scanneditemData2.isNotEmpty
                              ? Text(
                                  context.watch<PayreceiptController>().config.splitValues(context.watch<PayreceiptController>().totalpaidamt2().toStringAsFixed(2)),
                                  style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                )
                              : context.watch<PayreceiptController>().totalduepay == 0
                                  ? Text(
                                      "0.00",
                                      style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                    )
                                  : Text(
                                      context.watch<PayreceiptController>().totalduepay != null ? context.watch<PayreceiptController>().config.splitValues(context.watch<PayreceiptController>().totalduepay!.toString()) : '',
                                      style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                    ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: widget.paymentWidth * 0.15,
                          // height: paymentHeight * 0.03,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total Paid",
                            style: widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                            width: widget.paymentWidth * 0.17,
                            alignment: Alignment.centerRight,
                            child: Text(
                              context.watch<PayreceiptController>().selectedcust2 != null
                                  ? context.watch<PayreceiptController>().paymentWay2.isEmpty
                                      ? "0.00"
                                      : context.watch<PayreceiptController>().config.splitValues(context.watch<PayreceiptController>().getSumTotalPaid33().toStringAsFixed(2).toString())
                                  : context.watch<PayreceiptController>().advancetype == "Advance"
                                      ? context.watch<PayreceiptController>().config.splitValues(context.watch<PayreceiptController>().getSumTotalPaid().toStringAsFixed(2).toString())
                                      : context.watch<PayreceiptController>().paymentWay.isEmpty
                                          ? "0.00"
                                          : context.watch<PayreceiptController>().config.splitValues(context.watch<PayreceiptController>().getSumTotalPaid().toStringAsFixed(2).toString()),
                              style: widget.theme.textTheme.bodyMedium?.copyWith(),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: widget.paymentWidth * 0.15,
                          // height: paymentHeight * 0.03,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Balance",
                            style: widget.theme.textTheme.bodyMedium?.copyWith(color: widget.theme.primaryColor, fontSize: 16),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.17,
                          alignment: Alignment.centerRight,
                          child: context.watch<PayreceiptController>().scanneditemData2.isNotEmpty
                              ? context.watch<PayreceiptController>().totalduepay2 == 0
                                  ? Text(context.watch<PayreceiptController>().config.splitValues(context.watch<PayreceiptController>().getBalancePaid33().toString()))
                                  : Text(
                                      "0.00",
                                      style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                    )
                              : context.watch<PayreceiptController>().totalduepay == 0
                                  ? Text(context.watch<PayreceiptController>().config.splitValues(context.watch<PayreceiptController>().totalduepay.toString()))
                                  // Container()
                                  : Text(
                                      context.watch<PayreceiptController>().config.splitValues("${context.watch<PayreceiptController>().getBalancePaid().toStringAsFixed(2)}"),
                                      style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                    ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
