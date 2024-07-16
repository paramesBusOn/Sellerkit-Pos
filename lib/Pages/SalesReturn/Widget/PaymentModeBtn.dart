// ignore_for_file: prefer_is_empty, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Controller/SalesReturnController/SalesReturnController.dart';
import '../../../Widgets/ContentContainer.dart';

class PaymentModeBtn extends StatefulWidget {
  PaymentModeBtn(
      {Key? key,
      // required this.salesReturnController,
      required this.theme,
      required this.cashHeight,
      required this.cashWidth,
      required this.dialogheight,
      required this.dialogwidth})
      : super(key: key);
  double cashHeight;
  double cashWidth;
  double dialogheight;
  double dialogwidth;
  final ThemeData theme;

  @override
  State<PaymentModeBtn> createState() => _PaymentModeBtnState();
}

class _PaymentModeBtnState extends State<PaymentModeBtn> {
  // SalesReturnController salesReturnController;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.only(
          top: widget.cashHeight * 0.03,
          left: widget.cashHeight * 0.01,
          right: widget.cashHeight * 0.01,
          bottom: widget.cashHeight * 0.01),
      width: widget.cashWidth,
      height: widget.cashHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: widget.cashHeight * 0.6,
            child: GestureDetector(
              onTap:
                  context.read<SalesReturnController>().enableModeBtn == false
                      ? null
                      : () {
                          context.read<SalesReturnController>().nullErrorMsg();

                          if (context
                                  .read<SalesReturnController>()
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
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: EdgeInsets.all(0),
                                      content: AlertBox(
                                          payMent: 'Payment Mode - Cash',
                                          widget: forCashConfirm(
                                            context,
                                          ),
                                          buttonName: null));
                                });
                          }
                        },
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      top: widget.cashHeight * 0.01,
                      left: widget.cashHeight * 0.01,
                      right: widget.cashHeight * 0.01,
                      bottom: widget.cashHeight * 0.01),
                  height: widget.cashHeight * 0.5,
                  width: widget.cashWidth * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: widget.cashHeight * 0.01,
                              right: widget.cashHeight * 0.01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: AssetImage("assets/Cashpng.png"),
                            ),
                          ),
                          alignment: Alignment.center,
                          height: widget.cashHeight * 0.5,
                          width: widget.cashWidth * 0.05,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: widget.cashWidth * 0.17,
                            child: Text("Cash",
                                style: widget.theme.textTheme.bodyMedium?.copyWith(
                                    color: context
                                                .read<SalesReturnController>()
                                                .enableModeBtn ==
                                            true
                                        ? Colors.black
                                        : Colors.grey))),
                      ])),
            ),
          ),
          SizedBox(
            height: widget.cashHeight * 0.6,
            child: GestureDetector(
                onTap: context.read<SalesReturnController>().enableModeBtn ==
                        false
                    ? null
                    : () {
                        print('AAAA');

                        context.read<SalesReturnController>().nullErrorMsg();
                        if (context
                                .read<SalesReturnController>()
                                .getScanneditemData
                                .length <
                            1) {
                          print('BBBBB');

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
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder: (context, st) {
                                  return AlertDialog(
                                      contentPadding: EdgeInsets.all(0),
                                      content: AlertBox(
                                          callback: () {
                                            st(
                                              () {
                                                context
                                                    .read<
                                                        SalesReturnController>()
                                                    .addEnteredAmtType('Cheque',
                                                        context, 2, widget.theme);
                                              },
                                            );
                                          },
                                          payMent: 'Payment Mode - Cheque',
                                          widget: forCheque(context),
                                          buttonName: 'OK'));
                                });
                              });
                        }
                      },
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: widget.cashHeight * 0.01, right: widget.cashHeight * 0.01),
                    height: widget.cashHeight * 0.5,
                    width: widget.cashWidth * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              height: widget.cashHeight * 0.45,
                              width: widget.cashWidth * 0.04,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 155, 65, 228),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(
                                Icons.credit_card,
                                color: Colors.white,
                                // size: cashHeight * 0.2,
                              )),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: widget.cashWidth * 0.17,
                            child: Text("Cheque",
                                style: widget.theme.textTheme.bodyMedium?.copyWith(
                                    color: context
                                                .read<SalesReturnController>()
                                                .enableModeBtn ==
                                            true
                                        ? Colors.black
                                        : Colors.grey)),
                          ),
                        ]))),
          ),

          SizedBox(
            height: widget.cashHeight * 0.6,
            child: GestureDetector(
                onTap: context.read<SalesReturnController>().enableModeBtn ==
                        false
                    ? null
                    : () {
                        context.read<SalesReturnController>().nullErrorMsg();
                        if (context
                                .read<SalesReturnController>()
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder: (context, st) {
                                  return AlertDialog(
                                      contentPadding: EdgeInsets.all(0),
                                      content: AlertBox(
                                          callback: () {
                                            st(() {
                                              context
                                                  .read<SalesReturnController>()
                                                  .addEnteredAmtType('Coupons',
                                                      context, 7, widget.theme);
                                            });
                                          },
                                          payMent: 'Payment Mode - Coupons',
                                          widget: forCoupons(
                                            context,
                                          ),
                                          buttonName: 'OK'));
                                });
                              });
                        }
                      },
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: widget.cashHeight * 0.01, right: widget.cashHeight * 0.01),
                    height: widget.cashHeight * 0.4,
                    width: widget.cashWidth * 0.25,
                    decoration: BoxDecoration(
                      //  color: Colors.red,
                      color: Colors.grey.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: widget.cashHeight * 0.5,
                            width: widget.cashWidth * 0.05,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/NicePng.png"),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: widget.cashWidth * 0.17,
                            child: Text("Coupons",
                                style: widget.theme.textTheme.bodyMedium?.copyWith(
                                    color: context
                                                .read<SalesReturnController>()
                                                .enableModeBtn ==
                                            true
                                        ? Colors.black
                                        : Colors.grey)),
                          ),
                        ]))),
          ),
          // GestureDetector(
          //     onTap: () {
          //       salesReturnController.nullErrorMsg();
          //       if (salesReturnController.getScanneditemData.length < 1) {
          //         showDialog(
          //             context: context,
          //             barrierDismissible: true,
          //             builder: (BuildContext context) {
          //               return AlertDialog(
          //                   contentPadding: EdgeInsets.all(0),
          //                   content: AlertBox(
          //                       payMent: 'Alert',
          //                       errormsg: true,
          //                       widget: Center(
          //                           child: ContentContainer(
          //                         content: 'Choose Product..!!',
          //                         theme: theme,
          //                       )),
          //                       buttonName: null));
          //             });
          //       } else {
          //         showDialog(
          //             context: context,
          //             builder: (BuildContext context) {
          //               return StatefulBuilder(builder: (context, st) {
          //                 return AlertDialog(
          //                     contentPadding: EdgeInsets.all(0),
          //                     content: AlertBox(
          //                         callback: () {
          //                           st(() {
          //                             salesReturnController.addOnAccAmtType(
          //                                 'OnAccount', context, 8, theme);
          //                           });
          //                         },
          //                         payMent: 'Payment Mode - On Account',
          //                         widget: forOnAcc(
          //                             context, salesReturnController),
          //                         buttonName: 'OK'));
          //               });
          //             });
          //       }
          //     },
          //     child: Container(
          //         alignment: Alignment.center,
          //         padding: EdgeInsets.only(
          //             left: cashHeight * 0.01, right: cashHeight * 0.01),
          //         height: cashHeight * 0.4,
          //         width: cashWidth * 0.25,
          //         decoration: BoxDecoration(
          //           //  color: Colors.red,
          //           color: Colors.grey.withOpacity(0.05),
          //           borderRadius: BorderRadius.circular(5),
          //         ),
          //         child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: [
          //               Container(
          //                 alignment: Alignment.centerLeft,
          //                 height: cashHeight * 0.5,
          //                 width: cashWidth * 0.05,
          //                 decoration: BoxDecoration(
          //                   // ignore: prefer_const_constructors
          //                   // image: DecorationImage(
          //                   //   image: AssetImage("assets/NicePng.png"),
          //                   // ),
          //                   borderRadius: BorderRadius.circular(5),
          //                 ),
          //               ),
          //               Container(
          //                 alignment: Alignment.centerLeft,
          //                 width: cashWidth * 0.17,
          //                 child: Text("On Account",
          //                     style: theme.textTheme.bodyText2
          //                         ?.copyWith(color: Colors.black)),
          //               ),
          //             ]))),
        ],
      ),
    );
  }

  forCashConfirm(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
          top: widget.dialogheight * 0.01,
          left: widget.dialogheight * 0.09,
          right: widget.dialogheight * 0.09,
        ),
        height: widget.dialogheight * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: widget.dialogheight * 0.3,
                alignment: Alignment.center, //totallamountt
                child: Text(
                    //( context.watch<SalesReturnController>().getBalancePaid2()- context.watch<SalesReturnController>().salesCreditamt).toStringAsFixed(2)
                    'Is full amount (Rs. ${context.watch<SalesReturnController>().totalcalculate().toStringAsFixed(2)}) as Cash')),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        st(
                          () {
                            context
                                .read<SalesReturnController>()
                                .fullamt('Cash', context, widget.theme);
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                        alignment: Alignment.center,
                        width: widget.dialogwidth * 0.2,
                        height: widget.dialogheight * 0.2,
                        child: Text(
                          "Yes",
                          style: widget.theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        context.read<SalesReturnController>().nullErrorMsg();
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (context, st) {
                                return AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    content: AlertBox(
                                      payMent: 'Payment Mode - Cash',
                                      widget: forCashDialog(
                                        context,
                                      ),
                                      buttonName: 'Ok',
                                      callback: () {
                                        st(
                                          () {
                                            context
                                                .read<SalesReturnController>()
                                                .addEnteredAmtType(
                                                    'Cash', context, 1, widget.theme);
                                          },
                                        );
                                      },
                                    ));
                              });
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                        alignment: Alignment.center,
                        width: widget.dialogwidth * 0.2,
                        height: widget.dialogheight * 0.2,
                        child: Text(
                          "Partial Amount",
                          style: widget.theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  forCashDialog(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: widget.dialogwidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.dialogheight * 0.05,
            left: widget.dialogheight * 0.1,
            right: widget.dialogheight * 0.1,
            bottom: widget.dialogheight * 0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                context.watch<SalesReturnController>().getmsgforAmount == null
                    ? ''
                    : "${context.watch<SalesReturnController>().getmsgforAmount}",
                style: widget.theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ),
            Form(
              key: context.watch<SalesReturnController>().formkey[1],
              child: Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.001),
                ),
                child: TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  controller:
                      context.watch<SalesReturnController>().mycontroller[22],
                  cursorColor: Colors.grey,
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' Please Enter the Amount';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
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
                    hintText: 'Enter the Amount',
                    hintStyle:
                        widget.theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    filled: false,
                    // enabledBorder: InputBorder.none,
                    // focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: dialogheight * 0.1),
            // Container(
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //       onTap: () {
            //         st(() {
            //            context.watch<SalesReturnController>().addEnteredAmtType('Cash', context, 1);
            //         });
            //       },
            //       child: Container(
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             border: Border.all(color: Colors.red)),
            //         height: dialogheight * 0.2,
            //         width: dialogwidth * 0.18,
            //         child: Text("OK",
            //             style: theme.textTheme.bodyText2?.copyWith(
            //               color: Colors.red,
            //             )),
            //       )),
            // ),
          ],
        ),
      );
    });
  }

//
  forCheque(
    BuildContext context,
    // SalesReturnController posC,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: widget.dialogheight * 0.05,
            left: widget.dialogheight * 0.05,
            right: widget.dialogheight * 0.05,
            bottom: widget.dialogheight * 0.05),
        width: widget.dialogwidth * 1.1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                context.watch<SalesReturnController>().getmsgforAmount == null
                    ? ''
                    : "${context.watch<SalesReturnController>().getmsgforAmount}",
                style: widget.theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ),
            Container(
                child: Form(
                    key: context.watch<SalesReturnController>().formkey[2],
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                // height: dialogheight * 0.1,
                                // width: Screens.width(context) * 0.18,
                                child: Text("Cheque No"),
                              ),
                              Container(
                                // height: dialogheight * 0.2,
                                width: widget.dialogwidth * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.grey.withOpacity(0.01),
                                ),
                                child: TextFormField(
                                  autofocus: true,
                                  controller: context
                                      .watch<SalesReturnController>()
                                      .mycontroller[23],
                                  cursorColor: Colors.grey,
                                  style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                  onChanged: (v) {},
                                  validator: ((value) {
                                    if (value!.isEmpty) {
                                      return " Please Enter Cheque Number";
                                    } else {
                                      return null;
                                    }
                                  }),
                                  decoration: InputDecoration(
                                    filled: false,
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
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
                          SizedBox(height: widget.dialogheight * 0.05),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // height: dialogheight * 0.1,
                                  child: Text("Cheque Date"),
                                ),
                                Container(
                                  // height: dialogheight * 0.2,
                                  width: widget.dialogwidth * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey.withOpacity(0.01),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      st(() {
                                        context
                                            .read<SalesReturnController>()
                                            .getDate(context, 'Cheque');
                                      });
                                    },
                                    child: TextFormField(
                                      autofocus: true,
                                      readOnly: true,
                                      controller: context
                                          .watch<SalesReturnController>()
                                          .mycontroller[24],
                                      cursorColor: Colors.grey,
                                      style:
                                          widget.theme.textTheme.bodyMedium?.copyWith(),
                                      onChanged: (v) {},
                                      onTap: () {
                                        context
                                            .read<SalesReturnController>()
                                            .getDate(context, 'Cheque');
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return '  Please Enter the Cheque Date';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              print("Cheque Date");
                                              context
                                                  .read<SalesReturnController>()
                                                  .getDate(context, 'Cheque');
                                            },
                                            icon: Icon(Icons.date_range)),
                                        filled: false,
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: widget.dialogheight * 0.05),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: widget.dialogwidth * 0.35,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        // height: dialogheight * 0.1,
                                        child: Text("Amount"),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            context
                                                .read<SalesReturnController>()
                                                .cpyBtnclik(25);
                                          },
                                          icon: Icon(
                                            Icons.copy,
                                            size: widget.dialogheight * 0.15,
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  // height: dialogheight * 0.2,
                                  width: widget.dialogwidth * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey.withOpacity(0.01),
                                  ),
                                  child: TextFormField(
                                    autofocus: true,
                                    keyboardType: TextInputType.number,
                                    controller: context
                                        .watch<SalesReturnController>()
                                        .mycontroller[25],
                                    cursorColor: Colors.grey,
                                    style:
                                        widget.theme.textTheme.bodyMedium?.copyWith(),
                                    onChanged: (v) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ' Please Enter the Amount';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      // hintText: posController.boolCash == true
                                      //     ? '${posController.getBalancePaid().toStringAsFixed(2)}'
                                      //     : '',
                                      filled: false,
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: widget.dialogheight * 0.05),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // height: dialogheight * 0.1,
                                  child: Text("Remarks"),
                                ),
                                Container(
                                  // height: dialogheight * 0.2,
                                  width: widget.dialogwidth * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey.withOpacity(0.01),
                                  ),
                                  child: TextFormField(
                                    autofocus: true,
                                    controller: context
                                        .watch<SalesReturnController>()
                                        .mycontroller[26],
                                    cursorColor: Colors.grey,
                                    style:
                                        widget.theme.textTheme.bodyMedium?.copyWith(),
                                    onChanged: (v) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '  Please Enter the Remark';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      filled: false,
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      // enabledBorder: InputBorder.none,
                                      // focusedBorder: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]))),

            // ),
          ],
        ),
      );
    });
  }

  /// coupons

  forCoupons(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: widget.dialogwidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.dialogheight * 0.02,
            left: widget.dialogheight * 0.1,
            right: widget.dialogheight * 0.1,
            bottom: widget.dialogheight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                context.watch<SalesReturnController>().getmsgforAmount == null
                    ? ''
                    : "${context.watch<SalesReturnController>().getmsgforAmount}",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ),
            Container(
                child: Form(
              key: context.watch<SalesReturnController>().formkey[7],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // width: Screens.width(context) * 0.05,
                            child: Text("Coupons Type"),
                          ),
                          Container(
                            width: widget.dialogwidth * 0.7,
                            padding: EdgeInsets.only(
                              left: widget.dialogheight * 0.01,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                focusColor: Colors.white,
                                hint: Text(
                                  'Select Coupons  Type',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: context
                                                .watch<SalesReturnController>()
                                                .gethintcolor ==
                                            false
                                        ? Colors.grey
                                        : Colors.red,
                                  ),
                                ),
                                items: context
                                    .watch<SalesReturnController>()
                                    .getcouponlist
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: context
                                    .watch<SalesReturnController>()
                                    .coupon,
                                onChanged: (value) {
                                  st(() {
                                    context
                                        .read<SalesReturnController>()
                                        .coupon = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: widget.dialogheight * 0.05),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // width: Screens.width(context) * 0.05,
                            child: Text("Coupon Code"),
                          ),
                          Container(
                            // height: dialogheight * 0.2,
                            width: widget.dialogwidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: context
                                  .watch<SalesReturnController>()
                                  .mycontroller[35],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Coupon Code';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
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
                    SizedBox(height: widget.dialogheight * 0.05),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widget.dialogwidth * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // height: dialogheight * 0.1,
                                  child: Text("Amount"),
                                ),
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<SalesReturnController>()
                                          .cpyBtnclik(36);
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      size: widget.dialogheight * 0.15,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            // height: dialogheight * 0.2,
                            width: widget.dialogwidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: context
                                  .watch<SalesReturnController>()
                                  .mycontroller[36],
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Amount';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
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
                  ]),
            )),
          ],
        ),
      );
    });
  }

  forOnAcc(
    BuildContext context,
  ) {
    return Container(
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.1,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.1),
        child: Form(
          key: context.watch<SalesReturnController>().formkey[8],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.red,
                alignment: Alignment.centerLeft,
                width: widget.dialogwidth * 0.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      // height: dialogheight * 0.1,
                      child: Text("Amount"),
                    ),
                    IconButton(
                        onPressed: () {
                          context
                              .read<SalesReturnController>()
                              .onAcccpyBtnclik(38);
                        },
                        icon: Icon(
                          Icons.copy,
                        )),
                  ],
                ),
              ),
              Container(
                // height: cashHeight * 0.2,
                width: widget.cashWidth * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  autofocus: true,
                  controller:
                      context.watch<SalesReturnController>().mycontroller[38],
                  cursorColor: Colors.grey,
                  style: widget.theme.textTheme.bodyMedium?.copyWith(),
                  onChanged: (v) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' Please Enter the Amount';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
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
        ));
  }
}
