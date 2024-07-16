// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';

class MobPaymentMethod extends StatelessWidget {
  const MobPaymentMethod({
    Key? key,
    required this.prdCD,
    required this.theme,
  }) : super(key: key);

  final PayreceiptController prdCD;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return prdCD.getpaymentWay.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.01,
                left: Screens.width(context) * 0.01,
                right: Screens.width(context) * 0.01,
                bottom: Screens.padingHeight(context) * 0.01),
            width: Screens.width(context),
            // height: Screens.padingHeight(context) * 0.4,
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
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        EdgeInsets.all(Screens.padingHeight(context) * 0.01),
                    child: Text(
                      prdCD.getpaymentWay.isNotEmpty ? "Payment Method" : '',
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),

                  // SizedBox(height:paymentHeight *0.02),
                  ListView.builder(
                      itemCount: prdCD.getpaymentWay.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 2,
                            child: Container(
                                padding: EdgeInsets.only(
                                  right: Screens.width(context) * 0.03,
                                  left: Screens.width(context) * 0.03,
                                  bottom: Screens.padingHeight(context) * 0.01,
                                  top: Screens.padingHeight(context) * 0.01,
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
                                      width: Screens.width(context) * 0.25,
                                      // color: Colors.red,
                                      child: Text(
                                        '${prdCD.getpaymentWay[index].type}',
                                        // '${posController.getpaymentWay[index].dateTime}',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.28,
                                      // color: Colors.green,
                                      alignment: Alignment.centerLeft,
                                      child: Text(prdCD.getpaymentWay[index].reference==null?
                                        '${prdCD.getpaymentWay[index].reference}':"",
                                        // '${posController.getpaymentWay[index].type}',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        prdCD.config.splitValues(prdCD
                                            .getpaymentWay[index].amt!
                                            .toStringAsFixed(2)),
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        prdCD.removePayment(index);
                                      },
                                      child: SizedBox(
                                        width: Screens.width(context) * 0.05,
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
                ],
              ),
            ),
          );
  }
}
