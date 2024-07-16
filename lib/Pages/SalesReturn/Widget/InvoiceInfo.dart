// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesReturnController/SalesReturnController.dart';

class InvoiceInfo extends StatefulWidget {
  InvoiceInfo({
    Key? key,
    // required this.posSR,
    required this.theme,
    required this.cashHeight,
    required this.cashWidth,
  }) : super(key: key);
  double cashHeight;
  double cashWidth;
  final ThemeData theme;

  @override
  State<InvoiceInfo> createState() => _InvoiceInfoState();
}

class _InvoiceInfoState extends State<InvoiceInfo> {
  // SalesReturnController posSR;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: widget.cashHeight * 0.05, left: widget.cashHeight * 0.05, right: widget.cashHeight * 0.05, bottom: widget.cashHeight * 0.05),
      height: widget.cashHeight * 0.5,
      width: widget.cashWidth * 1,
      decoration: BoxDecoration(
        color: context.watch<SalesReturnController>().getselectedcust2 != null ? Colors.grey[300] : Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      // posSR.checkstocksetqty();
                      context.read<SalesReturnController>().deletealesRet();
                    },
                    child: Text('Invoice No')),
                context.watch<SalesReturnController>().getselectedcust2 != null
                    ? Text(context.watch<SalesReturnController>().getselectedcust2!.invoicenum!)
                    : context.watch<SalesReturnController>().getselectedcust == null
                        ? Text("")
                        : Text(context.watch<SalesReturnController>().getselectedcust!.invoicenum!)
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Invoice Date'),
                context.watch<SalesReturnController>().getselectedcust2 != null
                    ? Text(context.watch<SalesReturnController>().config.alignDate(context.watch<SalesReturnController>().getselectedcust2!.invoiceDate!))
                    : context.watch<SalesReturnController>().getselectedcust == null
                        ? Text("")
                        : Text(context.watch<SalesReturnController>().config.alignDate(context.watch<SalesReturnController>().getselectedcust!.invoiceDate!))
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Payment'),
                context.watch<SalesReturnController>().getselectedcust2 != null && context.watch<SalesReturnController>().getScanneditemData2.length > 0
                    ? Text(context.watch<SalesReturnController>().getselectedcust2!.totalPayment!.toStringAsFixed(2))
                    : context.watch<SalesReturnController>().getselectedcust == null || context.watch<SalesReturnController>().getselectedcust!.totalPayment == null || context.watch<SalesReturnController>().getScanneditemData.length < 1
                        ? Text("")
                        : Text("${context.watch<SalesReturnController>().config.splitValues(context.watch<SalesReturnController>().getselectedcust!.totalPayment!.toStringAsFixed(2))}")
              ],
            ),
          )
        ],
      ),
    );
  }
}
