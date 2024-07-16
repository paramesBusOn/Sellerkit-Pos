// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/SalesReturnController/SalesReturnController.dart';

class SRInvcWidget extends StatelessWidget {
  const SRInvcWidget({
    Key? key,
    required this.theme,
    required this.salesReturnController,
  }) : super(key: key);

  final ThemeData theme;
  final SalesReturnController salesReturnController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
      // height: Screens.bodyheight(context) * 0.4,
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
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.02,
          vertical: Screens.padingHeight(context) * 0.01),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Invoice No',
                    style: theme.textTheme.bodyMedium?.copyWith()),
                salesReturnController.getselectedcust == null
                    ? Text("")
                    : Text(salesReturnController.getselectedcust!.invoicenum!,
                        style: theme.textTheme.bodyMedium?.copyWith())
              ],
            ),
          ),
          SizedBox(height: Screens.bodyheight(context) * 0.01),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Invoice Date',
                    style: theme.textTheme.bodyMedium?.copyWith()),
                salesReturnController.getselectedcust == null
                    ? Text("")
                    : Text(salesReturnController.config.alignDate(salesReturnController.getselectedcust!.invoiceDate!),
                        style: theme.textTheme.bodyMedium?.copyWith())
              ],
            ),
          ),
          SizedBox(height: Screens.bodyheight(context) * 0.01),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Payment',
                    style: theme.textTheme.bodyMedium?.copyWith()),
                salesReturnController.getselectedcust == null
                    ? Text("")
                    : Text(
                        salesReturnController.getselectedcust!.totalPayment!
                            .toStringAsFixed(2),
                        style: theme.textTheme.bodyMedium?.copyWith())
              ],
            ),
          )
        ],
      ),
    );
  }
}
