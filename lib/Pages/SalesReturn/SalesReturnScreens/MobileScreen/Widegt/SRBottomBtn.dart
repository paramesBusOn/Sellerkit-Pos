

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:posproject/Controller/SalesReturnController/SalesReturnController.dart';
import '../../../../../Constant/Screen.dart';

class SRBottomBtn extends StatelessWidget {
  const SRBottomBtn({
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
      //height: Screens.bodyheight(context) * 0.4,
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
           
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4))),
                            contentPadding: EdgeInsets.all(0),
                            // backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.all(
                                Screens.bodyheight(context) * 0.02),
                           content: forSuspend(context, salesReturnController),
                          );
                        });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    height: Screens.padingHeight(context) * 0.06,
                    width: Screens.width(context) * 0.4,
                    child: Text("Suspend",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),

                  //
                    GestureDetector(
                  onTap: () {
                    salesReturnController.onHoldClicked(
                        context, theme);
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
                    width: Screens.width(context) * 0.4,
                    child: Text("Hold",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.primaryColor,
                        )),
                  )),
            ],
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              GestureDetector(
                  onTap: () {
                    salesReturnController.confirmReturn(context, theme);
                  },
                  child: Container(
                    height: Screens.padingHeight(context) * 0.06,
                    width: Screens.width(context) *0.9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: theme.primaryColor,
                        )),
                    child: Text("Confirm Return",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                        )),
                  )),
            ],
          )
        ],
      ),
    );
  }
  forSuspend(BuildContext context,SalesReturnController srController) {
    return Container(
      width: Screens.width(context),
        padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.01,
            vertical: Screens.padingHeight(context) * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              Container(
                      width: Screens.width(context),
                      height: Screens.padingHeight(context) * 0.05,
                      color: theme.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: Screens.padingHeight(context) * 0.02,
                                right: Screens.padingHeight(context) * 0.02),
                            // color: Colors.red,
                            width: Screens.width(context) * 0.7,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Alert",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                size: Screens.padingHeight(context) * 0.025,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                      SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            SizedBox(
                width: Screens.width(context) * 0.8,
                child: Center(
                    child: Text(
                        "You about to suspended all information will be unsaved  "))),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        salesReturnController.saveSalRetValuesTODB('suspend', context, theme);
                        // salesReturnController.clearAllData();
                      },
                      child: Text("Yes")),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.3,
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

