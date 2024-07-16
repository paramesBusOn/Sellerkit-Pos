// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/SalesInvoice/SalesInvoiceController.dart';

class PaymentDetails extends StatefulWidget {
  PaymentDetails(
      {Key? key,
      required this.theme,
      required this.paymentHeight,
      required this.paymentWidth})
      : super(key: key);
  final ThemeData theme;
  double paymentHeight;
  double paymentWidth;

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.paymentHeight,
        width: widget.paymentWidth,
        padding: EdgeInsets.only(
          top: widget.paymentHeight * 0.01,
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
            color: context.watch<PosController>().getScanneditemData2.isNotEmpty
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
                width: widget.paymentWidth * 0.5,
// color: Colors.red,
                // height: paymentHeight * 0.11,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widget.paymentWidth * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: context
                                        .watch<PosController>()
                                        .getScanneditemData2
                                        .isNotEmpty
                                    ? null
                                    : () {
                                        context
                                            .watch<PosController>()
                                            // .viewSalesRet();
                                            .checkstocksetqty();
                                      },
                                child: SizedBox(
                                  width: widget.paymentWidth * 0.18,
                                  child: Text(
                                    "Total Items",
                                    style:
                                        widget.theme.textTheme.bodyMedium?.copyWith(),
                                  ),
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.1,
                                  alignment: Alignment.centerRight,
                                  child: context
                                          .watch<PosController>()
                                          .getScanneditemData2
                                          .isNotEmpty
                                      ? context
                                                  .watch<PosController>()
                                                  .totalPayment2 ==
                                              null
                                          ? Text(
                                              "0",
                                            )
                                          // Container()
                                          : Text(
                                              context
                                                  .watch<PosController>()
                                                  .getScanneditemData2
                                                  .length
                                                  .toString(),
                                              // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
                                              style: widget.theme.textTheme.bodyMedium
                                                  ?.copyWith())
                                      : context
                                                  .watch<PosController>()
                                                  .totalPayment ==
                                              null
                                          ? Text(
                                              "0",
                                            )
                                          // Container()
                                          : Text(
                                              context
                                                  .watch<PosController>()
                                                  .getScanneditemData
                                                  .length
                                                  .toString(),
                                              // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
                                              style: widget.theme.textTheme.bodyMedium
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
                                  style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.1,
                                  alignment: Alignment.centerRight,
                                  child: context
                                          .watch<PosController>()
                                          .scanneditemData2
                                          .isNotEmpty
                                      ? context
                                                  .watch<PosController>()
                                                  .totalPayment2 ==
                                              null
                                          ? Text(
                                              "0",
                                            )

                                          // Container()
                                          : Text(
                                              context
                                                  .watch<PosController>()
                                                  .totalPayment2!
                                                  .total!
                                                  .toString(),

                                              // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
                                              style: widget.theme.textTheme.bodyMedium
                                                  ?.copyWith())
                                      : context
                                                  .watch<PosController>()
                                                  .totalPayment ==
                                              null
                                          ? Text(
                                              "0",
                                            )

                                          // Container()
                                          : Text(
                                              context
                                                  .watch<PosController>()
                                                  .totalPayment!
                                                  .total!
                                                  .toString(),

                                              // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
                                              style: widget.theme.textTheme.bodyMedium
                                                  ?.copyWith()))
                            ],
                          ),
                        ],
                      ),
                    ),
                    context.watch<PosController>().scanneditemData2.isNotEmpty
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
                                  .watch<PosController>()
                                  .mycontroller2[50],
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
                              controller: context
                                  .watch<PosController>()
                                  .remarkcontroller3,
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
                width: widget.paymentWidth * 0.45,
                // color: Colors.green,
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
                            style: widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          // color: Colors.yellow,
                          width: widget.paymentWidth * 0.25,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<PosController>()
                                  .scanneditemData2
                                  .isNotEmpty
                              ? context.watch<PosController>().totalPayment2 ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().totalPayment2!.discount!.toStringAsFixed(0)}"),
                                      style:
                                          widget.theme.textTheme.bodyMedium?.copyWith(),
                                    )
                              : context.watch<PosController>().totalPayment ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().totalPayment!.discount!.toStringAsFixed(0)}"),
                                      style:
                                          widget.theme.textTheme.bodyMedium?.copyWith(),
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
                            style: widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          // color: Colors.yellow,
                          width: widget.paymentWidth * 0.25,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<PosController>()
                                  .scanneditemData2
                                  .isNotEmpty
                              ? context.watch<PosController>().totalPayment2 ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().totalPayment2!.subtotal!.toStringAsFixed(0)}"),
                                      style:
                                          widget.theme.textTheme.bodyMedium?.copyWith(),
                                    )
                              : context.watch<PosController>().totalPayment ==
                                      null
                                  ? Text("0.00")
                                  : Text(
                                      context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().totalPayment!.subtotal!.toStringAsFixed(0)}"),
                                      style:
                                          widget.theme.textTheme.bodyMedium?.copyWith(),
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
                            style: widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          // color: Colors.yellow,
                          width: widget.paymentWidth * 0.25,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<PosController>()
                                  .scanneditemData2
                                  .isNotEmpty
                              ? context.watch<PosController>().totalPayment2 ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().totalPayment2!.totalTX!.toStringAsFixed(0)}"),
                                      style:
                                          widget.theme.textTheme.bodyMedium?.copyWith(),
                                    )
                              : context.watch<PosController>().totalPayment ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().totalPayment!.totalTX!.toStringAsFixed(0)}"),
                                      style:
                                          widget.theme.textTheme.bodyMedium?.copyWith(),
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
                            style: widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          // color: Colors.yellow,
                          width: widget.paymentWidth * 0.25,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<PosController>()
                                  .scanneditemData2
                                  .isNotEmpty
                              ? context.watch<PosController>().totalPayment2 ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().totalPayment2!.totalDue!.toStringAsFixed(0)}"),
                                      style:
                                          widget.theme.textTheme.bodyMedium?.copyWith(),
                                    )
                              : context.watch<PosController>().totalPayment ==
                                      null
                                  ? Container(
                                      child: Text("0.00"),
                                    )
                                  : Text(
                                      context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().totalPayment!.totalDue!.toStringAsFixed(0)}"),
                                      style:
                                          widget.theme.textTheme.bodyMedium?.copyWith(),
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
                          // color: Colors.yellow,
                          width: widget.paymentWidth * 0.25,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<PosController>()
                                  .scanneditemData2
                                  .isNotEmpty
                              ? context.watch<PosController>().totalPayment2 !=
                                      null
                                  ? Text(
                                      context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().getSumTotalPaid2().toStringAsFixed(0)}"),
                                      style:
                                          widget.theme.textTheme.bodyMedium?.copyWith(),
                                    )
                                  : context.watch<PosController>().tottpaid !=
                                          null
                                      ? Text(context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().tottpaid!.toStringAsFixed(0)}"))
                                      : Text("0.00")
                              : context.watch<PosController>().totalPayment !=
                                      null
                                  ? Text(
                                      context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().getSumTotalPaid().toStringAsFixed(0)}"),
                                      style:
                                          widget.theme.textTheme.bodyMedium?.copyWith(),
                                    )
                                  : context.watch<PosController>().tottpaid !=
                                          null
                                      ? Text(context
                                          .watch<PosController>()
                                          .config
                                          .splitValues(
                                              "${context.watch<PosController>().tottpaid!.toStringAsFixed(0)}"))
                                      : Text("0.00"),
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
                            // color: Colors.yellow,
                            width: widget.paymentWidth * 0.25,
                            alignment: Alignment.centerRight,
                            child: context
                                    .watch<PosController>()
                                    .scanneditemData2
                                    .isNotEmpty
                                ? context.watch<PosController>().totalPayment2 !=
                                        null
                                    ? Text(
                                        context
                                            .watch<PosController>()
                                            .config
                                            .splitValues(
                                                "${context.watch<PosController>().totalPayment2!.balance!.toStringAsFixed(0)}"),
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      )
                                    : context.watch<PosController>().tottpaid !=
                                            null
                                        ? Text(context
                                            .watch<PosController>()
                                            .config
                                            .splitValues(
                                                "${context.watch<PosController>().tottpaid!.toStringAsFixed(0)}"))
                                        : Text("0.00")
                                : context.watch<PosController>().totalPayment !=
                                        null
                                    ? Text(
                                        context
                                            .watch<PosController>()
                                            .config
                                            .splitValues(
                                                "${context.watch<PosController>().getBalancePaid().toStringAsFixed(0)}"),
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      )
                                    : Text("0.00")),
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

// // ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

// import 'package:flutter/material.dart';
// import 'package:posbillingdesign/Controller/SalesInvoice/SalesInvoiceController.dart';
// import 'package:provider/provider.dart';

// class PaymentDetails extends StatefulWidget {
//   PaymentDetails(
//       {Key? key,
//       required this.theme,
//       required this.paymentHeight,
//       required this.paymentWidth})
//       : super(key: key);
//   final ThemeData theme;

//   double paymentHeight;
//   double paymentWidth;

//   @override
//   State<PaymentDetails> createState() => _PaymentDetailsState();
// }

// class _PaymentDetailsState extends State<PaymentDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: widget.paymentHeight,
//         width: widget.paymentWidth,
//         padding: EdgeInsets.only(
//           top: widget.paymentHeight * 0.01,
//           left: widget.paymentHeight * 0.01,
//           right: widget.paymentHeight * 0.01,
//           bottom: widget.paymentHeight * 0.01,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Container(
//           // height: paymentHeight * 0.35,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: context.watch<PosController>().getScanneditemData2.isNotEmpty
//                 ? Colors.grey[300]
//                 : Colors.grey.withOpacity(0.05),
//           ),
//           padding: EdgeInsets.only(
//             top: widget.paymentHeight * 0.01,
//             left: widget.paymentHeight * 0.01,
//             right: widget.paymentHeight * 0.02,
//             bottom: widget.paymentHeight * 0.02,
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: widget.paymentWidth * 0.6,
//                 // height: paymentHeight * 0.11,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: widget.paymentWidth * 0.3,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               GestureDetector(
//                                 onTap: context
//                                         .watch<PosController>()
//                                         .getScanneditemData2
//                                         .isNotEmpty
//                                     ? null
//                                     : () {
//                                         context
//                                             .watch<PosController>()
//                                             .checkstocksetqty();
//                                       },
//                                 child: SizedBox(
//                                   width: widget.paymentWidth * 0.18,
//                                   child: Text(
//                                     "Total Items",
//                                     style: widget.theme.textTheme.bodyMedium
//                                         ?.copyWith(),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                   width: widget.paymentWidth * 0.1,
//                                   alignment: Alignment.centerRight,
//                                   child: context
//                                           .watch<PosController>()
//                                           .getScanneditemData2
//                                           .isNotEmpty
//                                       ? context
//                                                   .watch<PosController>()
//                                                   .totalPayment2 ==
//                                               null
//                                           ? Text(
//                                               "0",
//                                             )
//                                           // Container()
//                                           : Text(
//                                               context
//                                                   .watch<PosController>()
//                                                   .getScanneditemData2
//                                                   .length
//                                                   .toString(),
//                                               // "${context.watch<PosController>().totalPayment!.total!.toStringAsFixed(0)}",
//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith())
//                                       : context
//                                                   .watch<PosController>()
//                                                   .totalPayment ==
//                                               null
//                                           ? Text(
//                                               "0",
//                                             )
//                                           // Container()
//                                           : Text(
//                                               context
//                                                   .watch<PosController>()
//                                                   .getScanneditemData
//                                                   .length
//                                                   .toString(),
//                                               // "${context.watch<PosController>().totalPayment!.total!.toStringAsFixed(0)}",
//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith())),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                 width: widget.paymentWidth * 0.18,
//                                 child: Text(
//                                   "Total Quantity",
//                                   style: widget.theme.textTheme.bodyMedium
//                                       ?.copyWith(),
//                                 ),
//                               ),
//                               Container(
//                                   width: widget.paymentWidth * 0.1,
//                                   alignment: Alignment.centerRight,
//                                   child: context
//                                           .watch<PosController>()
//                                           .scanneditemData2
//                                           .isNotEmpty
//                                       ? context
//                                                   .watch<PosController>()
//                                                   .totalPayment2 ==
//                                               null
//                                           ? Text(
//                                               "0",
//                                             )

//                                           // Container()
//                                           : Text(
//                                               context
//                                                   .watch<PosController>()
//                                                   .totalPayment2!
//                                                   .total!
//                                                   .toString(),

//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith())
//                                       : context
//                                                   .watch<PosController>()
//                                                   .totalPayment ==
//                                               null
//                                           ? Text(
//                                               "0",
//                                             )

                                  
//                                           : Text(
//                                               "${context.watch<PosController>().totalPayment!.total.toString()}",

//                                               // "${context.watch<PosController>().totalPayment!.discount!.toStringAsFixed(0)}",
//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith()))
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                 width: widget.paymentWidth * 0.18,
//                                 child: Text(
//                                   "Total Weight",
//                                   style: widget.theme.textTheme.bodyMedium,
//                                 ),
//                               ),
//                               Container(
//                                   width: widget.paymentWidth * 0.1,
//                                   alignment: Alignment.centerRight,
//                                   child: context
//                                           .watch<PosController>()
//                                           .getScanneditemData2
//                                           .isNotEmpty
//                                       ? Text(
//                                           "${context.watch<PosController>().totwieght!.toStringAsFixed(2)}Kg",
//                                           // context.watch<PosController>().config.splitValues(
//                                           //     "${context.watch<PosController>().totalPayment!.discount!.toStringAsFixed(2)}"),
//                                           style: widget
//                                               .theme.textTheme.bodyMedium
//                                               ?.copyWith())
//                                       : context
//                                               .watch<PosController>()
//                                               .getScanneditemData
//                                               .isNotEmpty
//                                           ? Text(
//                                               "${context.watch<PosController>().totalWeight().toStringAsFixed(2)}kg",
//                                               // context.watch<PosController>().config.splitValues(
//                                               //     "${context.watch<PosController>().totalPayment!.discount!.toStringAsFixed(2)}"),
//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith())

//                                           // Container()
//                                           : Text("0.00",
//                                               // context.watch<PosController>().config.splitValues(
//                                               //     "${context.watch<PosController>().totalPayment!.discount!.toStringAsFixed(2)}"),
//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith()))
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                 width: widget.paymentWidth * 0.18,
//                                 child: Text(
//                                   "Total Ltr",
//                                   style: widget.theme.textTheme.bodyMedium
//                                       ?.copyWith(),
//                                 ),
//                               ),
//                               Container(
//                                   width: widget.paymentWidth * 0.1,
//                                   alignment: Alignment.centerRight,
//                                   child: context
//                                           .watch<PosController>()
//                                           .getScanneditemData2
//                                           .isNotEmpty
//                                       ? Text(
//                                           "${context.watch<PosController>().totLiter!.toStringAsFixed(2)}",
//                                           // context.watch<PosController>().config.splitValues(
//                                           //     "${context.watch<PosController>().totalPayment!.discount!.toStringAsFixed(2)}"),
//                                           style: widget
//                                               .theme.textTheme.bodyMedium
//                                               ?.copyWith())
//                                       : context
//                                               .watch<PosController>()
//                                               .getScanneditemData
//                                               .isNotEmpty
//                                           ? Text(
//                                               "${context.watch<PosController>().totalLiter().toStringAsFixed(2)}",
//                                               // context.watch<PosController>().config.splitValues(
//                                               //     "${context.watch<PosController>().totalPayment!.discount!.toStringAsFixed(2)}"),
//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith())

//                                           // Container()
//                                           : Text("0.00",
//                                               // context.watch<PosController>().config.splitValues(
//                                               //     "${context.watch<PosController>().totalPayment!.discount!.toStringAsFixed(2)}"),
//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith()))
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     context.watch<PosController>().scanneditemData2.isNotEmpty
//                         ? Container(
//                             alignment: Alignment.center,
//                             width: widget.paymentWidth * 1,
//                             decoration: BoxDecoration(
//                               // color: Colors.red,
//                               borderRadius: BorderRadius.circular(3),
//                               // color: Colors.grey.withOpacity(0.01),
//                             ),
//                             child: TextFormField(
//                               controller: context
//                                   .watch<PosController>()
//                                   .remarkcontroller3,
//                               cursorColor: Colors.grey,
//                               style:
//                                   widget.theme.textTheme.bodyMedium?.copyWith(),
//                               onChanged: (v) {},
//                               watchOnly: true,
//                               decoration: InputDecoration(
//                                 // hintText: "Remarks",
//                                 filled: false,
//                                 labelText: "Remarks",

//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.grey),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.grey),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 5,
//                                   horizontal: 10,
//                                 ),
//                               ),
//                             ),
//                           )
//                         : Container(
//                             alignment: Alignment.center,
//                             width: widget.paymentWidth * 1,
//                             decoration: BoxDecoration(
//                               // color: Colors.red,

//                               borderRadius: BorderRadius.circular(3),
//                               // color: Colors.grey.withOpacity(0.01),
//                             ),
//                             child: TextFormField(
//                               controller: context
//                                   .watch<PosController>()
//                                   .remarkcontroller3,
//                               cursorColor: Colors.grey,
//                               style:
//                                   widget.theme.textTheme.bodyMedium?.copyWith(),
//                               onChanged: (v) {},
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return ' Please Enter the Remark';
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                 hintText: "Remarks",
//                                 filled: false,
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.grey),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.grey),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 5,
//                                   horizontal: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 width: widget.paymentWidth * 0.35,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: widget.paymentWidth * 0.15,
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Discount",
//                             style:
//                                 widget.theme.textTheme.bodyMedium?.copyWith(),
//                           ),
//                         ),
//                         Container(
//                           width: widget.paymentWidth * 0.17,
//                           alignment: Alignment.centerRight,
//                           child: context
//                                   .watch<PosController>()
//                                   .scanneditemData2
//                                   .isNotEmpty
//                               ? context.watch<PosController>().totalPayment2 ==
//                                       null
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context
//                                           .watch<PosController>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<PosController>().totalPayment2!.discount!.toStringAsFixed(2)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                               : context.watch<PosController>().totalPayment ==
//                                       null
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context
//                                           .watch<PosController>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<PosController>().totalPayment!.discount!.toString()}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: widget.paymentWidth * 0.15,
//                           // height: paymentHeight * 0.03,
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Sub Total",
//                             style:
//                                 widget.theme.textTheme.bodyMedium?.copyWith(),
//                           ),
//                         ),
//                         Container(
//                           width: widget.paymentWidth * 0.17,
//                           alignment: Alignment.centerRight,
//                           child: context
//                                   .watch<PosController>()
//                                   .scanneditemData2
//                                   .isNotEmpty
//                               ? context.watch<PosController>().totalPayment2 ==
//                                       null
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context
//                                           .watch<PosController>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<PosController>().totalPayment2!.subtotal!.toStringAsFixed(2)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                               : context.watch<PosController>().totalPayment ==
//                                       null
//                                   ? Text("0.00")
//                                   : Text(
//                                       context
//                                           .watch<PosController>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<PosController>().totalPayment!.subtotal!.toStringAsFixed(2)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           // color: Colors.red,
//                           width: widget.paymentWidth * 0.15,
//                           // height: paymentHeight * 0.03,
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Total Tax",
//                             style:
//                                 widget.theme.textTheme.bodyMedium?.copyWith(),
//                           ),
//                         ),
//                         Container(
//                           // color: Colors.red,
//                           width: widget.paymentWidth * 0.17,
//                           alignment: Alignment.centerRight,
//                           child: context
//                                   .watch<PosController>()
//                                   .scanneditemData2
//                                   .isNotEmpty
//                               ? context.watch<PosController>().totalPayment2 ==
//                                       null
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context
//                                           .watch<PosController>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<PosController>().totalPayment2!.totalTX!.toStringAsFixed(2)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                               : context.watch<PosController>().totalPayment ==
//                                       null
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context
//                                           .watch<PosController>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<PosController>().totalPayment!.totalTX!.toStringAsFixed(2)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           width: widget.paymentWidth * 0.15,
//                           child: Text(
//                             "Total Due",
//                             style:
//                                 widget.theme.textTheme.bodyMedium?.copyWith(),
//                           ),
//                         ),
//                         Container(
//                           width: widget.paymentWidth * 0.17,
//                           alignment: Alignment.centerRight,
//                           child: context
//                                   .watch<PosController>()
//                                   .scanneditemData2
//                                   .isNotEmpty
//                               ? context.watch<PosController>().totalPayment2 ==
//                                       null
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context
//                                           .watch<PosController>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<PosController>().totalPayment2!.totalDue!.toStringAsFixed(2)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                               : context.watch<PosController>().totalPayment ==
//                                       null
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context
//                                           .watch<PosController>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<PosController>().totalPayment!.totalDue!.toStringAsFixed(2)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     ),
//                         )
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: widget.paymentWidth * 0.15,
//                           // height: paymentHeight * 0.03,
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Total Paid",
//                             style:
//                                 widget.theme.textTheme.bodyMedium?.copyWith(),
//                           ),
//                         ),
//                         Container(
//                           width: widget.paymentWidth * 0.17,
//                           alignment: Alignment.centerRight,
//                           child: context
//                                   .watch<PosController>()
//                                   .scanneditemData2
//                                   .isNotEmpty
//                               ? context.watch<PosController>().totalPayment2 !=
//                                       null
//                                   ? Text(
//                                       "${context.watch<PosController>().getSumTotalPaid2().toStringAsFixed(2)}",
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                                   : context.watch<PosController>().tottpaid !=
//                                           null
//                                       ? Text(context
//                                           .watch<PosController>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<PosController>().tottpaid!.toStringAsFixed(2)}"))
//                                       : Text("0.00")
//                               : context.watch<PosController>().totalPayment !=
//                                       null
//                                   ? Text(
//                                       "${context.watch<PosController>().getSumTotalPaid().toStringAsFixed(2)}",
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                                   : context.watch<PosController>().tottpaid !=
//                                           null
//                                       ? Text(context
//                                           .watch<PosController>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<PosController>().tottpaid!.toStringAsFixed(2)}"))
//                                       : Text("0.00"),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: widget.paymentWidth * 0.15,
//                           // height: paymentHeight * 0.03,
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Balance",
//                             style: widget.theme.textTheme.bodyMedium?.copyWith(
//                                 color: widget.theme.primaryColor, fontSize: 16),
//                           ),
//                         ),
//                         Container(
//                             width: widget.paymentWidth * 0.17,
//                             alignment: Alignment.centerRight,
//                             child: context
//                                     .watch<PosController>()
//                                     .scanneditemData2
//                                     .isNotEmpty
//                                 ? context.watch<PosController>().totalPayment2 !=
//                                         null
//                                     ? Text(
//                                         "${context.watch<PosController>().totalPayment2!.balance!.toStringAsFixed(2)}",
//                                         style: widget.theme.textTheme.bodyMedium
//                                             ?.copyWith(),
//                                       )
//                                     : context.watch<PosController>().tottpaid !=
//                                             null
//                                         ? Text(context
//                                             .watch<PosController>()
//                                             .config
//                                             .splitValues(
//                                                 "${context.watch<PosController>().tottpaid!.toStringAsFixed(2)}"))
//                                         : Text("0.00")
//                                 : context.watch<PosController>().totalPayment !=
//                                         null
//                                     ? Text(
//                                         context
//                                             .watch<PosController>()
//                                             .config
//                                             .splitValues(
//                                                 "${context.watch<PosController>().getBalancePaid().toStringAsFixed(2)}"),
//                                         style: widget.theme.textTheme.bodyMedium
//                                             ?.copyWith(),
//                                       )
//                                     : Text("0.00")
//                             // : context.watch<PosController>().baltopay != null
//                             //     ? Text("${context.watch<PosController>().baltopay}")
//                             //     : Container(
//                             //         child: Text("0.00"),
//                             //       )
//                             ),
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }
