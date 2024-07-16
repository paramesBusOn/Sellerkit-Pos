// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:posproject/Controller/StockOutwardController/StockOutwardController.dart';
import 'package:posproject/Pages/StockOutward/Widgets/Draftbillr.dart';
import 'package:posproject/Widgets/AlertBox.dart';

import '../../../Constant/Screen.dart';
import '../../../Widgets/ContentContainer.dart';

class BillingOptions extends StatelessWidget {
  const BillingOptions({
    Key? key,
    required this.theme,
    required this.posController
  }) : super(key: key);

  final ThemeData theme;
  final StockOutwardController posController;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
       padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.01,
          left: Screens.padingHeight(context) * 0.01,
          right: Screens.padingHeight(context) * 0.01,
          bottom: Screens.padingHeight(context) * 0.01),
       width: Screens.width(context) * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              height: Screens.padingHeight(context) * 0.03,
              child: Text('Billing Options',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            GestureDetector(
                onTap: () {
                  if (posController.savedraftBill.isEmpty) {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              content: AlertBox(
                                payMent: 'Draft bills',
                                buttonName: null,
                                widget: ContentContainer(
                                    content: "Draft bills", theme: theme),
                              ));
                        });
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              contentPadding: EdgeInsets.all(0),
                              content: AlertBox(
                                  payMent: 'Draft bills',
                                  buttonName: null,
                                  widget: StockOutDraftbill(
                                      theme: theme,
                                      searchHeight:
                                          Screens.bodyheight(context) * 0.9,
                                      searchWidth:
                                          Screens.width(context) * 0.49,
                                      StockOut:
                                          posController.savedraftBill)));
                        });
                  }
                   },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: theme.primaryColor,
                      )),

                  height: Screens.padingHeight(context) * 0.06,
                  // width: Screens.width(context)*0.15,
                  child: Text("Draft Bills",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      )),
                )),
                 SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Storck Refresh',
                              buttonName: null,
                              widget: ContentContainer(
                                  content: "Storck Refresh", theme: theme),
                            ));
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: theme.primaryColor,
                      )),

                  height: Screens.padingHeight(context) * 0.06,
                  // width: Screens.width(context)*0.15,
                  child: Text("Store Refresh",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      )),
                )),
                 SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Print',
                              buttonName: null,
                              widget: ContentContainer(
                                  content: "Print", theme: theme),
                            ));
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: theme.primaryColor,
                      )),

                  height: Screens.padingHeight(context) * 0.06,
                  // width: Screens.width(context)*0.15,
                  child: Text("Print",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      )),
                )),
                 SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Access Till',
                              buttonName: null,
                              widget: ContentContainer(
                                  content: "Access Till", theme: theme),
                            ));
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: theme.primaryColor,
                      )),

                  height: Screens.padingHeight(context) * 0.06,
                  // width: Screens.width(context)*0.15,
                  child: Text("Access Till",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      )),
                )),
                 SizedBox(
                  height: Screens.padingHeight(context) * 0.01,
                ),
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Dual Screen',
                              buttonName: null,
                              widget: ContentContainer(
                                  content: "Dual Screen", theme: theme),
                            ));
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: theme.primaryColor,
                      )),

                  height: Screens.padingHeight(context) * 0.06,
                  // width: Screens.width(context)*0.15,
                  child: Text("Dual Screen",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      )),
                )),
          ],
        ));
  }
}
