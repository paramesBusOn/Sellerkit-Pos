// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/SalesReturnController/SalesReturnController.dart';

class SalesReturnPayment extends StatefulWidget {
  SalesReturnPayment(
      {Key? key,
      required this.theme,
      // required this.prdSR,
      required this.paymentHeight,
      required this.paymentWidth})
      : super(key: key);
  final ThemeData theme;
  // SalesReturnController prdSR;
  double paymentHeight;
  double paymentWidth;

  @override
  State<SalesReturnPayment> createState() => _SalesReturnPaymentState();
}

class _SalesReturnPaymentState extends State<SalesReturnPayment> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.paymentHeight,
        width: widget.paymentWidth,
        padding: EdgeInsets.only(
          top: widget.paymentHeight * 0.03,
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
            color: context
                    .watch<SalesReturnController>()
                    .getScanneditemData2
                    .isNotEmpty
                ? Colors.grey[300]
                : Colors.grey.withOpacity(0.05),
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
                // height: paymentHeight * 0.11,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: widget.paymentWidth * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // context
                                  //     .read<SalesReturnController>()
                                  //     .viewSalesRet();
                                },
                                child: SizedBox(
                                  width: widget.paymentWidth * 0.18,
                                  child: Text(
                                    "Total Items",
                                    style: widget.theme.textTheme.bodyMedium
                                        ?.copyWith(),
                                  ),
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.1,
                                  alignment: Alignment.centerRight,
                                  child: context
                                          .watch<SalesReturnController>()
                                          .getScanneditemData2
                                          .isNotEmpty
                                      ? Text(
                                          context
                                              .watch<SalesReturnController>()
                                              .getScanneditemData2
                                              .length
                                              .toString(),
                                          // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
                                          style: widget
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith())
                                      : context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .totalPayment ==
                                              null
                                          ? Text(
                                              "0",
                                            )
                                          // Container()
                                          : Text(
                                              context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getScanneditemData
                                                  .length
                                                  .toString(),
                                              // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
                                              style: widget
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith())),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: widget.paymentWidth * 0.18,
                                child: Text(
                                  "Total Quantity",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.1,
                                  alignment: Alignment.centerRight,
                                  child: context
                                              .watch<SalesReturnController>()
                                              .totalPayment2 !=
                                          null
                                      ? Text(context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .totalPayment2!
                                                  .total !=
                                              null
                                          ? "${context.watch<SalesReturnController>().totalPayment2!.total!}"
                                          : "0.00")
                                      : context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .totalPayment ==
                                              null
                                          ? Text(
                                              "0",
                                            )

                                          // Container()
                                          : Text(
                                              context
                                                          .watch<
                                                              SalesReturnController>()
                                                          .totalPayment!
                                                          .total !=
                                                      null
                                                  ? "${context.watch<SalesReturnController>().totalPayment!.total!}"
                                                  : "0.00",

                                              // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
                                              style: widget
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith()))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: widget.paymentWidth * 0.18,
                                child: Text(
                                  "Total Weight",
                                  style: widget.theme.textTheme.bodyMedium,
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.1,
                                  alignment: Alignment.centerRight,
                                  child: context
                                          .watch<SalesReturnController>()
                                          .scanneditemData2
                                          .isNotEmpty
                                      ? Text(
                                          "${context.watch<SalesReturnController>().totwieght2!.toStringAsFixed(2)}Kg",
                                          // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
                                          style: widget
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith())

                                      // Container()
                                      : context
                                              .watch<SalesReturnController>()
                                              .scanneditemData
                                              .isNotEmpty
                                          ? Text(
                                              "${context.watch<SalesReturnController>().totwieght != null ? context.watch<SalesReturnController>().totwieght!.toStringAsFixed(2) : 0}Kg",
                                              // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
                                              style: widget
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith())
                                          : Text("0.00",
                                              // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
                                              style: widget
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith()))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: widget.paymentWidth * 0.18,
                                child: Text(
                                  "Total Ltr",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.1,
                                  alignment: Alignment.centerRight,
                                  child: context
                                          .watch<SalesReturnController>()
                                          .scanneditemData2
                                          .isNotEmpty
                                      ? Text(
                                          "${context.watch<SalesReturnController>().totLiter2!.toStringAsFixed(2)}Kg",
                                          // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
                                          style: widget
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith())

                                      // Container()
                                      : context
                                              .watch<SalesReturnController>()
                                              .scanneditemData
                                              .isNotEmpty
                                          ? Text(
                                              "${context.watch<SalesReturnController>().totLiter != null ? context.watch<SalesReturnController>().totLiter!.toStringAsFixed(2) : 0}Kg",
                                              // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
                                              style: widget
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith())
                                          : Text("0.00",
                                              // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
                                              style: widget
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith()))
                            ],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       width: paymentWidth * 0.18,
                          //       child: Text(
                          //         "Other Amout",
                          //         style: theme.textTheme.bodyText2?.copyWith(),
                          //       ),
                          //     ),
                          //     Container(
                          //       width: paymentWidth * 0.18,
                          //       alignment: Alignment.centerRight,
                          //       child:  context.watch<SalesReturnController>().getScanneditemData.isEmpty
                          //           ? Text("0.00")
                          //           : Text(
                          //               ( context.watch<SalesReturnController>().totalPayment!.totalDue! -
                          //                        context.watch<SalesReturnController>().salesCreditamt)
                          //                   //  context.watch<SalesReturnController>().totalPayment!.totalDue!
                          //                   .toStringAsFixed(2),
                          //               // "${prdPmt.totalPayment!.subtotal!.toStringAsFixed(2)}",
                          //               style: theme.textTheme.bodyText2?.copyWith(),
                          //             ),
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       width: paymentWidth * 0.18,
                          //       child: Text(
                          //         "Credited Amout",
                          //         style: theme.textTheme.bodyText2?.copyWith(),
                          //       ),
                          //     ),
                          //     Container(
                          //       width: paymentWidth * 0.18,
                          //       alignment: Alignment.centerRight,
                          //       child:  context.watch<SalesReturnController>().getScanneditemData.isEmpty
                          //           ? Text("0.00")
                          //           : Text(
                          //                context.watch<SalesReturnController>().salesCreditamt.toStringAsFixed(2),
                          //               // "${prdPmt.totalPayment!.subtotal!.toStringAsFixed(2)}",
                          //               style: theme.textTheme.bodyText2?.copyWith(),
                          //             ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: paymentWidth * 0.02,
                          // ),
                        ],
                      ),
                    ),
                    context
                            .watch<SalesReturnController>()
                            .scanneditemData2
                            .isNotEmpty
                        ? Container(
                            alignment: Alignment.center,
                            width: widget.paymentWidth * 1,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(3),
                              // color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: context
                                  .watch<SalesReturnController>()
                                  .mycontroller2[50],
                              cursorColor: Colors.grey,
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
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
                              controller: context
                                  .watch<SalesReturnController>()
                                  .remarkcontroller3,
                              cursorColor: Colors.grey,
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
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
                          width: widget.paymentWidth * 0.15,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Discount",
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.17,
                          alignment: Alignment.centerRight,
                          child: context
                                      .watch<SalesReturnController>()
                                      .totalPayment2 !=
                                  null
                              ? Text(
                                  context
                                      .watch<SalesReturnController>()
                                      .config
                                      .splitValues(
                                          "${context.watch<SalesReturnController>().totalPayment2!.discount!.toStringAsFixed(2)}"),
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                )
                              : context
                                          .watch<SalesReturnController>()
                                          .totalPayment ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<SalesReturnController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<SalesReturnController>().totalPayment!.discount!.toStringAsFixed(2)}"),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    ),
                        ),
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
                            "Sub Total",
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.17,
                          alignment: Alignment.centerRight,
                          child: context
                                      .watch<SalesReturnController>()
                                      .totalPayment2 !=
                                  null
                              ? Text(
                                  context
                                      .watch<SalesReturnController>()
                                      .config
                                      .splitValues(
                                          " ${context.watch<SalesReturnController>().totalPayment2!.subtotal!.toStringAsFixed(2)}"),
                                  // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith())
                              : context
                                          .watch<SalesReturnController>()
                                          .totalPayment ==
                                      null
                                  ? Text("0.00")
                                  : Text(
                                      context
                                          .watch<SalesReturnController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<SalesReturnController>().totalPayment!.subtotal!.toStringAsFixed(2)}"),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // color: Colors.red,
                          width: widget.paymentWidth * 0.15,
                          // height: paymentHeight * 0.03,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total Tax",
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          width: widget.paymentWidth * 0.17,
                          alignment: Alignment.centerRight,
                          child: context
                                      .watch<SalesReturnController>()
                                      .totalPayment2 !=
                                  null
                              ? Text(
                                  context
                                      .watch<SalesReturnController>()
                                      .config
                                      .splitValues(
                                          "${context.watch<SalesReturnController>().totalPayment2!.totalTX!.toStringAsFixed(2)}"),
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                )
                              : context
                                          .watch<SalesReturnController>()
                                          .totalPayment ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<SalesReturnController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<SalesReturnController>().totalPayment!.totalTX!.toStringAsFixed(2)}"),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: widget.paymentWidth * 0.15,
                          child: Text(
                            "Total Due",
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.17,
                          alignment: Alignment.centerRight,
                          child: context
                                      .watch<SalesReturnController>()
                                      .totalPayment2 !=
                                  null
                              ? Text(
                                  context
                                      .watch<SalesReturnController>()
                                      .config
                                      .splitValues(
                                          "${context.watch<SalesReturnController>().totalPayment2!.balance!.toStringAsFixed(2)}"),
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                )
                              : context
                                          .watch<SalesReturnController>()
                                          .totalPayment ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<SalesReturnController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<SalesReturnController>().totalPayment!.totalDue!.toStringAsFixed(2)}"),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
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
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.17,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<SalesReturnController>()
                                  .getScanneditemData2
                                  .isNotEmpty
                              ? Text(
                                  context
                                      .watch<SalesReturnController>()
                                      .config
                                      .splitValues(
                                          "${context.watch<SalesReturnController>().getSumTotalPaid3().toStringAsFixed(2)}"),
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                )
                              : context
                                          .watch<SalesReturnController>()
                                          .totalPayment ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<SalesReturnController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<SalesReturnController>().getSumTotalPaid2().toStringAsFixed(2)}"),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    ),
                        ),
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
                            style: widget.theme.textTheme.bodyMedium?.copyWith(
                                color: widget.theme.primaryColor, fontSize: 16),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.17,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<SalesReturnController>()
                                  .getScanneditemData2
                                  .isNotEmpty
                              ? Text(
                                  context
                                      .watch<SalesReturnController>()
                                      .totalPayment2!
                                      .balance!
                                      .toStringAsFixed(2),
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                )
                              : context
                                          .watch<SalesReturnController>()
                                          .totalPayment ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<SalesReturnController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<SalesReturnController>().getBalancePaid2().toStringAsFixed(2)}"),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
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
