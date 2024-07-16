// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_is_empty, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesQuotationController/SalesQuotationController.dart';
import '../../../Widgets/ContentContainer.dart';

class SQCashWidget extends StatefulWidget {
  SQCashWidget({
    Key? key,
    required this.theme,
    required this.cashHeight,
    required this.cashWidth,
  }) : super(key: key);
  double cashHeight;
  double cashWidth;
  final ThemeData theme;

  @override
  State<SQCashWidget> createState() => _SQCashWidgetState();
}

class _SQCashWidgetState extends State<SQCashWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.only(
          top: widget.cashHeight * 0.01,
          left: widget.cashHeight * 0.01,
          right: widget.cashHeight * 0.01,
          bottom: widget.cashHeight * 0.01),
      width: widget.cashWidth,
      height: widget.cashHeight,
      child: Center(
        child: GestureDetector(
            onTap: () async {
              context.read<SalesQuotationCon>().nullErrorMsg();
              if (context.read<SalesQuotationCon>().getselectedcust == null) {
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
                                content: 'Choose cusotmer..!!',
                                theme: widget.theme,
                              )),
                              buttonName: null));
                    });
              } else if (context
                      .read<SalesQuotationCon>()
                      .getScanneditemData
                      .length <
                  1) {
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
                                content: 'Choose Product..!!',
                                theme: widget.theme,
                              )),
                              buttonName: null));
                    });
              } else {
                context.read<SalesQuotationCon>().schemebtnclk = true;
                await context
                    .read<SalesQuotationCon>()
                    .scehmeapiforckout(context, widget.theme);

                // await context.read<SalesQuotationCon>().salesOrderSchemeData();
                // await context.read<SalesQuotationCon>().callSchemeOrderAPi();
                // await context
                //     .read<SalesQuotationCon>()
                //     .calculatescheme(context, theme);
              }
              context.read<SalesQuotationCon>().disableKeyBoard(context);
            },
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: widget.cashHeight * 0.01, right: widget.cashHeight * 0.01),
                height: widget.cashHeight * 0.6,
                width: widget.cashWidth * 0.25,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: widget.cashHeight * 0.6,
                      width: widget.cashWidth * 0.05,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        image: DecorationImage(
                          image: AssetImage("assets/disssccimg.png"),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      width: widget.cashWidth * 0.17,
                      child: Text("  Scheme",
                          style: widget.theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black)),
                    ),
                  ],
                ))),
      ),
    );
  }
}
