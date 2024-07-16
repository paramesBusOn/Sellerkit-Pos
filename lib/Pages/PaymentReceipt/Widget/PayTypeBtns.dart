// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_is_empty, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/PaymentReceiptController/PayReceiptController.dart';
import '../../../Models/DataModel/CouponsDetailsModel/CouponDetModel.dart';
import '../../../Widgets/ContentContainer.dart';

class PayTypeBtns extends StatefulWidget {
  PayTypeBtns({
    Key? key,
    required this.theme,
    required this.cashHeight,
    required this.cashWidth,
  }) : super(key: key);
  double cashHeight;
  double cashWidth;
  final ThemeData theme;

  @override
  State<PayTypeBtns> createState() => _PayTypeBtnsState();
}

class _PayTypeBtnsState extends State<PayTypeBtns> {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  print(
                      "advancetype::${context.read<PayreceiptController>().advancetype}");
                  context.read<PayreceiptController>().nullErrorMsg();
                  context.read<PayreceiptController>().selectedcust == null
                      ? showDialog(
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
                                    content: 'Choose customer..!!',
                                    theme: widget.theme,
                                  )),
                                  buttonName: null,
                                ));
                          })
                      : context.read<PayreceiptController>().selectedcust !=
                                  null &&
                              context
                                      .read<PayreceiptController>()
                                      .advancetype !=
                                  "Advance" &&
                              context
                                      .read<PayreceiptController>()
                                      .getScanneditemData
                                      .length >
                                  0 &&
                              context
                                  .read<PayreceiptController>()
                                  .paymentWay
                                  .isEmpty &&
                              context
                                      .read<PayreceiptController>()
                                      .getBalancePaid() <
                                  1 &&
                              context
                                      .read<PayreceiptController>()
                                      .totalduepay! <
                                  1 &&
                              context
                                      .read<PayreceiptController>()
                                      .getSumTotalPaid() <
                                  1
                          ? showDialog(
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
                                        content:
                                            'Choose a Document or Advance..!!',
                                        theme: widget.theme,
                                      )),
                                      buttonName: null,
                                    ));
                              })
                          : context.read<PayreceiptController>().advancetype ==
                                  "Advance"
                              ? showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, st) {
                                      return AlertDialog(
                                          contentPadding: EdgeInsets.all(0),
                                          content: AlertBox(
                                            payMent: 'Payment Mode - Cash',
                                            widget: forCashDialog(context),
                                            buttonName: 'OK',
                                            callback: () {
                                              st(
                                                () {
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .addEnteredAmtType(
                                                          'Cash',
                                                          context,
                                                          1,
                                                          widget.theme);
                                                },
                                              );
                                            },
                                          ));
                                    });
                                  })
                              : context
                                          .read<PayreceiptController>()
                                          .getScanneditemData
                                          .length >
                                      0
                                  ? showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, st) {
                                          return AlertDialog(
                                              contentPadding: EdgeInsets.all(0),
                                              content: AlertBox(
                                                payMent: 'Payment Mode - Cash',
                                                widget: forCashDialog(context),
                                                buttonName: 'OK',
                                                callback: () {
                                                  st(
                                                    () {
                                                      context
                                                          .read<
                                                              PayreceiptController>()
                                                          .addEnteredAmtType(
                                                              'Cash',
                                                              context,
                                                              1,
                                                              widget.theme);
                                                    },
                                                  );
                                                },
                                              ));
                                        });
                                      })
                                  : null;
                  // showDialog(
                  //     context: context,
                  //     barrierDismissible: true,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //           contentPadding: EdgeInsets.all(0),
                  //           content: AlertBox(
                  //             payMent: 'Alert',
                  //             errormsg: true,
                  //             widget: Center(
                  //                 child: ContentContainer(
                  //               content: 'Choose Advance..!!',
                  //               theme: widget.theme,
                  //             )),
                  //             buttonName: null,
                  //           ));
                  //     });

                  // context.read<PayreceiptController>().scanneditemData.length == 0 &&
                  // context.read<PayreceiptController>().selectedcust != null &&
                  //context.read<PayreceiptController>().advancetype != "Advance"
                  //     ? showDialog(
                  //         context: context,
                  //         barrierDismissible: false,
                  //         builder: (BuildContext context) {
                  //           return StatefulBuilder(builder: (context, st) {
                  //             return AlertDialog(
                  //                 contentPadding: EdgeInsets.all(0),
                  //                 content: AlertBox(
                  //                   payMent: 'Alert',
                  //                   errormsg: true,
                  //                   widget: ContentContainer(content: 'Choose Advance Mode', theme: widget.theme),
                  //                   buttonName: null,
                  //                 ));
                  //           });
                  //         })
                  //     : context.read<PayreceiptController>().selectedcust != null && context.read<PayreceiptController>().advancetype == "Advance"
                  // ? showDialog(
                  //     context: context,
                  //     barrierDismissible: false,
                  //     builder: (BuildContext context) {
                  //       return StatefulBuilder(builder: (context, st) {
                  //         return AlertDialog(
                  //             contentPadding: EdgeInsets.all(0),
                  //             content: AlertBox(
                  //               payMent: 'Payment Mode - Cash',
                  //               widget: forCashDialog(context),
                  //               buttonName: 'OK',
                  //               callback: () {
                  //                 st(
                  //                   () {
                  //                     context.read<PayreceiptController>().addEnteredAmtType('Cash', context, 1, widget.theme);
                  //                   },
                  //                 );
                  //               },
                  //             ));
                  //       });
                  //     })
                  //         : context.read<PayreceiptController>().selectedcust == null && context.read<PayreceiptController>().advancetype == "Advance"
                  //             ? context.read<PayreceiptController>().foraccselect(context, widget.theme, "")
                  //             : showDialog(
                  //                 context: context,
                  //                 barrierDismissible: false,
                  //                 builder: (BuildContext context) {
                  //                   return StatefulBuilder(builder: (context, st) {
                  //                     return AlertDialog(
                  //                         contentPadding: EdgeInsets.all(0),
                  //                         content: AlertBox(
                  //                           payMent: 'Payment Mode - Cash',
                  //                           widget: forCashDialog(context),
                  //                           buttonName: 'OK',
                  //                           callback: () {
                  //                             st(
                  //                               () {
                  //                                 context.read<PayreceiptController>().addEnteredAmtType('Cash', context, 1, widget.theme);
                  //                               },
                  //                             );
                  //                           },
                  //                         ));
                  //                   });
                  //                 });
                  context.read<PayreceiptController>().disableKeyBoard(context);
                },
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        top: widget.cashHeight * 0.01,
                        left: widget.cashHeight * 0.01,
                        right: widget.cashHeight * 0.01,
                        bottom: widget.cashHeight * 0.01),
                    height: widget.cashHeight * 0.29,
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
                            height: widget.cashHeight * 0.13,
                            width: widget.cashWidth * 0.05,
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              width: widget.cashWidth * 0.17,
                              child: Text(
                                "Cash",
                                style: widget.theme.textTheme.bodyMedium,
                              )),
                        ])),
              ),
              GestureDetector(
                  onTap: () {
                    context.read<PayreceiptController>().clearTextField();
                    context
                                    .read<PayreceiptController>()
                                    .scanneditemData
                                    .length ==
                                0 &&
                            context.read<PayreceiptController>().selectedcust !=
                                null &&
                            context.read<PayreceiptController>().advancetype !=
                                "Advance"
                        ? showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (context, st) {
                                return AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    content: AlertBox(
                                      payMent: 'Alert',
                                      errormsg: true,
                                      widget: ContentContainer(
                                          content: 'Choose Advance Mode',
                                          theme: widget.theme),
                                      buttonName: null,
                                    ));
                              });
                            })
                        : context.read<PayreceiptController>().advancetype ==
                                "Advance"
                            ? showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                        contentPadding: EdgeInsets.all(0),
                                        content: AlertBox(
                                            callback: () {
                                              st(
                                                () {
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .addEnteredAmtType(
                                                          'Cheque',
                                                          context,
                                                          2,
                                                          widget.theme);
                                                },
                                              );
                                            },
                                            payMent: 'Payment Mode - Cheque',
                                            widget: forCheque(context),
                                            buttonName: 'OK'));
                                  });
                                })
                            : context
                                        .read<PayreceiptController>()
                                        .totalduepay! <
                                    1
                                ? context
                                    .read<PayreceiptController>()
                                    .foraccselect(context, widget.theme, "")
                                : showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, st) {
                                        return AlertDialog(
                                            contentPadding: EdgeInsets.all(0),
                                            content: AlertBox(
                                                callback: () {
                                                  st(
                                                    () {
                                                      context
                                                          .read<
                                                              PayreceiptController>()
                                                          .addEnteredAmtType(
                                                              'Cheque',
                                                              context,
                                                              2,
                                                              widget.theme);
                                                    },
                                                  );
                                                },
                                                payMent:
                                                    'Payment Mode - Cheque',
                                                widget: forCheque(context),
                                                buttonName: 'OK'));
                                      });
                                    });
                    context
                        .read<PayreceiptController>()
                        .disableKeyBoard(context);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: widget.cashHeight * 0.01,
                          right: widget.cashHeight * 0.01),
                      height: widget.cashHeight * 0.29,
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
                                height: widget.cashHeight * 0.13,
                                width: widget.cashWidth * 0.04,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 155, 65, 228),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Icon(
                                  Icons.credit_card,
                                  color: Colors.white,
                                  size: widget.cashHeight * 0.1,
                                )),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: widget.cashWidth * 0.17,
                              child: Text("Cheque",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith()),
                            ),
                          ]))),
              GestureDetector(
                  onTap: () {
                    context.read<PayreceiptController>().nullErrorMsg();
                    // payController.getselectedcust == null
                    context
                                    .read<PayreceiptController>()
                                    .scanneditemData
                                    .length ==
                                0 &&
                            context.read<PayreceiptController>().selectedcust !=
                                null &&
                            context.read<PayreceiptController>().advancetype !=
                                "Advance"
                        ? showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (context, st) {
                                return AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    content: AlertBox(
                                      payMent: 'Alert',
                                      errormsg: true,
                                      widget: ContentContainer(
                                          content: 'Choose Advance Mode',
                                          theme: widget.theme),
                                      buttonName: null,
                                    ));
                              });
                            })
                        : context.read<PayreceiptController>().advancetype ==
                                "Advance"
                            ? showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                        contentPadding: EdgeInsets.all(0),
                                        content: AlertBox(
                                          callback: () {
                                            st(
                                              () {
                                                context
                                                    .read<
                                                        PayreceiptController>()
                                                    .addEnteredAmtType(
                                                        'Card',
                                                        context,
                                                        3,
                                                        widget.theme);
                                              },
                                            );
                                          },
                                          payMent: 'Payment Mode - Card',
                                          widget: forCard(context, "Card"),
                                          buttonName: 'OK',
                                        ));
                                  });
                                })
                            : context
                                        .read<PayreceiptController>()
                                        .totalduepay ==
                                    0
                                ? context
                                    .read<PayreceiptController>()
                                    .foraccselect(context, widget.theme, "")
                                : showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, st) {
                                        return AlertDialog(
                                            contentPadding: EdgeInsets.all(0),
                                            content: AlertBox(
                                              callback: () {
                                                st(
                                                  () {
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .addEnteredAmtType(
                                                            'Card',
                                                            context,
                                                            3,
                                                            widget.theme);
                                                  },
                                                );
                                              },
                                              payMent: 'Payment Mode - Card',
                                              widget: forCard(context, "Card"),
                                              buttonName: 'OK',
                                            ));
                                      });
                                    });
                    context
                        .read<PayreceiptController>()
                        .disableKeyBoard(context);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: widget.cashHeight * 0.01,
                          right: widget.cashHeight * 0.01),
                      height: widget.cashHeight * 0.29,
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
                              height: widget.cashHeight * 0.12,
                              width: widget.cashWidth * 0.05,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/creditIcon.png"),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: widget.cashWidth * 0.17,
                              child: Text("Card",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black)),
                            ),
                          ]))),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    // log(" payController.typeee::" + payController.typeee);

                    context.read<PayreceiptController>().nullErrorMsg();
                    context
                                    .read<PayreceiptController>()
                                    .scanneditemData
                                    .length ==
                                0 &&
                            context.read<PayreceiptController>().selectedcust !=
                                null &&
                            context.read<PayreceiptController>().advancetype !=
                                "Advance"
                        ? showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (context, st) {
                                return AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    content: AlertBox(
                                      payMent: 'Alert',
                                      errormsg: true,
                                      widget: ContentContainer(
                                          content: 'Choose Advance Mode',
                                          theme: widget.theme),
                                      buttonName: null,
                                    ));
                              });
                            })
                        : context.read<PayreceiptController>().advancetype ==
                                "Advance"
                            ? showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                        contentPadding: EdgeInsets.all(0),
                                        content: AlertBox(
                                            callback: () {
                                              st(() {
                                                context
                                                    .read<
                                                        PayreceiptController>()
                                                    .addEnteredAmtType(
                                                        'Wallet',
                                                        context,
                                                        5,
                                                        widget.theme);
                                              });
                                            },
                                            payMent: 'Payment Mode - Wallet',
                                            widget: forwallet(context),
                                            buttonName: 'OK'));
                                  });
                                })
                            : context
                                        .read<PayreceiptController>()
                                        .totalduepay ==
                                    0
                                ? context
                                    .read<PayreceiptController>()
                                    .foraccselect(context, widget.theme, "")
                                : showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, st) {
                                        return AlertDialog(
                                            contentPadding: EdgeInsets.all(0),
                                            content: AlertBox(
                                                callback: () {
                                                  st(() {
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .addEnteredAmtType(
                                                            'Wallet',
                                                            context,
                                                            5,
                                                            widget.theme);
                                                  });
                                                },
                                                payMent:
                                                    'Payment Mode - Wallet',
                                                widget: forwallet(context),
                                                buttonName: 'OK'));
                                      });
                                    });
                    context
                        .read<PayreceiptController>()
                        .disableKeyBoard(context);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: widget.cashHeight * 0.01,
                          right: widget.cashHeight * 0.01),
                      height: widget.cashHeight * 0.29,
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
                              height: widget.cashHeight * 0.12,
                              width: widget.cashWidth * 0.05,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/NetIcon.png"),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: widget.cashWidth * 0.17,
                              child: Text("Wallet",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black)),
                            ),
                          ]))),
              GestureDetector(
                  onTap: () {
                    context.read<PayreceiptController>().nullErrorMsg();
                    context
                                    .read<PayreceiptController>()
                                    .scanneditemData
                                    .length ==
                                0 &&
                            context.read<PayreceiptController>().selectedcust !=
                                null &&
                            context.read<PayreceiptController>().advancetype !=
                                "Advance"
                        ? showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (context, st) {
                                return AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    content: AlertBox(
                                      payMent: 'Alert',
                                      errormsg: true,
                                      widget: ContentContainer(
                                          content: 'Choose Advance Mode',
                                          theme: widget.theme),
                                      buttonName: null,
                                    ));
                              });
                            })
                        : context.read<PayreceiptController>().advancetype ==
                                "Advance"
                            ? showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                        contentPadding: EdgeInsets.all(0),
                                        content: AlertBox(
                                            callback: () {
                                              st(() {
                                                context
                                                    .read<
                                                        PayreceiptController>()
                                                    .addEnteredAmtType(
                                                        'Transfer',
                                                        context,
                                                        6,
                                                        widget.theme);
                                              });
                                            },
                                            payMent: 'Payment Mode - Transfer',
                                            widget: forTransfer(context),
                                            buttonName: 'OK'));
                                  });
                                })
                            : context
                                        .read<PayreceiptController>()
                                        .totalduepay ==
                                    0
                                ? context
                                    .read<PayreceiptController>()
                                    .foraccselect(context, widget.theme, "")
                                : showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, st) {
                                        return AlertDialog(
                                            contentPadding: EdgeInsets.all(0),
                                            content: AlertBox(
                                                callback: () {
                                                  st(() {
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .addEnteredAmtType(
                                                            'Transfer',
                                                            context,
                                                            6,
                                                            widget.theme);
                                                  });
                                                },
                                                payMent:
                                                    'Payment Mode - Transfer',
                                                widget: forTransfer(context),
                                                buttonName: 'OK'));
                                      });
                                    });
                    context
                        .read<PayreceiptController>()
                        .disableKeyBoard(context);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: widget.cashHeight * 0.01,
                          right: widget.cashHeight * 0.01),
                      height: widget.cashHeight * 0.29,
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
                              alignment: Alignment.centerLeft,
                              height: widget.cashHeight * 0.12,
                              width: widget.cashWidth * 0.05,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/upiicon.png"),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: widget.cashWidth * 0.17,
                              child: Text("Transfer",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black)),
                            ),
                          ]))),
              context.read<PayreceiptController>().getScanneditemData.length >
                          0 &&
                      context.read<PayreceiptController>().advancetype !=
                          "Advance"
                  ? GestureDetector(
                      onTap: () {
                        context.read<PayreceiptController>().nullErrorMsg();
                        context.read<PayreceiptController>().advancetype ==
                                "Advance"
                            ? showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                        contentPadding: EdgeInsets.all(0),
                                        content: AlertBox(
                                            callback: () {
                                              st(() {
                                                context
                                                    .read<
                                                        PayreceiptController>()
                                                    .addEnteredAmtType(
                                                        'Coupons',
                                                        context,
                                                        7,
                                                        widget.theme);
                                              });
                                            },
                                            payMent: 'Payment Mode - Coupons',
                                            widget: forCoupons(context),
                                            buttonName: 'OK'));
                                  });
                                })
                            : context
                                        .read<PayreceiptController>()
                                        .totalduepay ==
                                    0
                                ? context
                                    .read<PayreceiptController>()
                                    .foraccselect(context, widget.theme, "")
                                : showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, st) {
                                        return AlertDialog(
                                            contentPadding: EdgeInsets.all(0),
                                            content: AlertBox(
                                                callback: () {
                                                  st(() {
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .addEnteredAmtType(
                                                            'Coupons',
                                                            context,
                                                            7,
                                                            widget.theme);
                                                  });
                                                },
                                                payMent:
                                                    'Payment Mode - Coupons',
                                                widget: forCoupons(context),
                                                buttonName: 'OK'));
                                      });
                                    });
                        context
                            .read<PayreceiptController>()
                            .disableKeyBoard(context);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: widget.cashHeight * 0.01,
                              right: widget.cashHeight * 0.01),
                          height: widget.cashHeight * 0.29,
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
                                  height: widget.cashHeight * 0.13,
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
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(color: Colors.black)),
                                ),
                              ])))
                  : SizedBox(
                      height: widget.cashHeight * 0.29,
                      width: widget.cashWidth * 0.25,
                    ),
            ],
          ),
          // SizedBox(
          //   height: cashHeight * 0.03,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              context.read<PayreceiptController>().getScanneditemData.length >
                          0 &&
                      context.read<PayreceiptController>().advancetype !=
                          "Advance"
                  ? GestureDetector(
                      onTap: () {
                        context.read<PayreceiptController>().nullErrorMsg();
                        // if (payController.getselectedcust == null) {
                        //   showDialog(
                        //       context: context,
                        //      barrierDismissible: false,
                        //       builder: (BuildContext context) {
                        //         return AlertDialog(
                        //             contentPadding: EdgeInsets.all(0),
                        //             content: AlertBox(
                        //               payMent: 'Alert',
                        //               errormsg: true,
                        //               widget: Center(
                        //                   child: ContentContainer(
                        //                 content: 'Choose customer..!!',
                        //                 theme: theme,
                        //               )),
                        //               buttonName: null,
                        //             ));
                        //       });
                        // } else {

                        context.read<PayreceiptController>().totalduepay == 0
                            ? context
                                .read<PayreceiptController>()
                                .foraccselect(context, widget.theme, "")
                            : showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: EdgeInsets.all(0),
                                      content: AlertBox(
                                        callback: () {
                                          context
                                              .read<PayreceiptController>()
                                              .addEnteredAmtType(
                                                  'Points Redemption',
                                                  context,
                                                  8,
                                                  widget.theme);
                                        },
                                        buttonName: 'OK',
                                        payMent:
                                            'Payment Mode - Points Redemption',
                                        widget: forPoints(
                                          context,
                                        ),
                                      ));
                                });
                        context
                                .read<PayreceiptController>()
                                .mycontroller[37]
                                .text =
                            context
                                .read<PayreceiptController>()
                                .getselectedcust!
                                .point!;
                        // }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: widget.cashHeight * 0.01,
                              right: widget.cashHeight * 0.01),
                          height: widget.cashHeight * 0.29,
                          width: widget.cashWidth * 0.25,
                          decoration: BoxDecoration(
                            //  color: Colors.red,
                            color: Colors.grey.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text("Point Redemption",
                              style: widget.theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black))),
                    )
                  : Container(width: widget.cashWidth * 0.2),
//               GestureDetector(
//                   onTap: () {
//                     payController.nullErrorMsg();
//                     payController.getselectedcust == null
//                         ? payController.foraccselect(context, theme, "")
//                         : payController.totalduepay == 0
//                             ? payController.foracctotaldue(context, theme)
//                             : showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return StatefulBuilder(
//                                       builder: (context, st) {
//                                     return AlertDialog(
//                                         contentPadding: EdgeInsets.all(0),
//                                         content: AlertBox(
//                                             callback: () {
//                                               st(
//                                                 () {
//                                                   payController
//                                                       .addEnteredAmtType(
//                                                           'Account Balance',
//                                                           context,
//                                                           9,
//                                                           theme);
//                                                 },
//                                               );
//                                             },
//                                             payMent: 'Account Balance',
//                                             widget: forAccBal(
//                                                 context, payController),
//                                             buttonName: 'Accept'));
//                                   });
//                                 });
//                     payController.mycontroller[55].text =
//                         payController.getselectedcust!.accBalance.toString();
//                     // payController.onAccPayment == 0
//                     //     ? payController.mycontroller[55].text =

//                     //             payController.getselectedcust!.accBalance.toString()
//                     //     : payController.mycontroller[55].text =
//                     //         payController.onAccPayment.toString();
//                   },
//                   child: Container(
//                       alignment: Alignment.center,
//                       padding: EdgeInsets.only(
//                           left: cashHeight * 0.01, right: cashHeight * 0.01),
//                       height: cashHeight * 0.29,
//                       width: cashWidth * 0.25,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.withOpacity(0.05),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text("Account Balance",
//                           style: theme.textTheme.bodyText2
//                               ?.copyWith(color: Colors.black)))),
//               GestureDetector(
//                   onTap: () {
//                     payController.nullErrorMsg();
// //  payController.totalduepay == 0
// //                         ? payController.typeee != "On Account"
// //                             ? payController.foracctotaldue(context, theme)
// //                             :
//                     payController.forOnAccPaid2222();
//                     // showDialog(
//                     //     context: context,
//                     //     barrierDismissible: false,
//                     //     builder: (BuildContext context) {
//                     //       return StatefulBuilder(builder: (context, st) {
//                     //         return
//                     //          AlertDialog(
//                     //             contentPadding: EdgeInsets.all(0),
//                     //             content: AlertBox(
//                     //               callback: () {
//                     //                 st(
//                     //                   () {
//                     //                     payController.forOnAccPaid(
//                     //                       'On Account',
//                     //                       context,
//                     //                       theme,
//                     //                       10,
//                     //                     );
//                     //                   },
//                     //                 );
//                     //               },
//                     //               payMent: 'Payment Mode - On Account',
//                     //               widget: forOnAcc(context, payController),
//                     //               buttonName: 'Accept',
//                     //             ));
//                     //       });
//                     // });
//                   },
//                   child: Container(
//                       alignment: Alignment.center,
//                       padding: EdgeInsets.only(
//                           left: cashHeight * 0.01, right: cashHeight * 0.01),
//                       height: cashHeight * 0.29,
//                       width: cashWidth * 0.25,
//                       decoration: BoxDecoration(
//                         //  color: Colors.red,
//                         color: Colors.grey.withOpacity(0.05),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               height: cashHeight * 0.12,
//                               width: cashWidth * 0.05,
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: AssetImage("assets/creditIcon.png"),
//                                 ),
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               width: cashWidth * 0.17,
//                               child: Text("On Account",
//                                   style: theme.textTheme.bodyText2
//                                       ?.copyWith(color: Colors.black)),
//                             ),
//                           ]))),
            ],
          ),
        ],
      ),
    );
  }

  forCashDialog(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: widget.cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.05,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                context.read<PayreceiptController>().getmsgforAmount == null
                    ? ''
                    : "${context.watch<PayreceiptController>().getmsgforAmount}",
                style: widget.theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.red),
              ),
            ),
            // Container(
            //   child: Text(
            //     posC.getmsgforAmount == null ? '' : "${posC.getmsgforAmount}",
            //     style: theme.textTheme.bodyText2?.copyWith(color: Colors.red),
            //   ),
            // ),
            Form(
              key: context.read<PayreceiptController>().formkey[1],
              child: Row(
                children: [
                  SizedBox(
                    width: widget.cashWidth * 0.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          // height: cashHeight * 0.1,
                          child: Text("Amount"),
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<PayreceiptController>()
                                  .cpyBtnclik(22);
                            },
                            icon: Icon(
                              Icons.copy,
                              // size: cashHeight * 0.15,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    width: widget.cashWidth * 0.7,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.001),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      controller:
                          context.read<PayreceiptController>().mycontroller[22],
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
                        hintStyle: widget.theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.grey),
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
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  forCheque(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.05,
            left: widget.cashHeight * 0.05,
            right: widget.cashHeight * 0.05,
            bottom: widget.cashHeight * 0.05),
        width: widget.cashWidth * 1.1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                context.read<PayreceiptController>().getmsgforAmount == null
                    ? ''
                    : "${context.watch<PayreceiptController>().getmsgforAmount}",
                style: widget.theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.red),
              ),
            ),
            Container(
                child: Form(
                    key: context.read<PayreceiptController>().formkey[2],
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                // height: cashHeight * 0.1,
                                // width: Screens.width(context) * 0.18,
                                child: Text("Cheque No"),
                              ),
                              Container(
                                // height: cashHeight * 0.2,
                                width: widget.cashWidth * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.grey.withOpacity(0.01),
                                ),
                                child: TextFormField(
                                  autofocus: true,
                                  keyboardType: TextInputType.number,
                                  controller: context
                                      .read<PayreceiptController>()
                                      .mycontroller[23],
                                  cursorColor: Colors.grey,
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                  onChanged: (v) {},
                                  validator: ((value) {
                                    if (value!.isEmpty) {
                                      return " Please Enter Cheque Number";
                                    } else if (value.length < 6) {
                                      return " Please Enter a 6 digit Cheque Number";
                                    } else {
                                      return null;
                                    }
                                  }),
                                  maxLength: 6,
                                  decoration: InputDecoration(
                                    counterText: '',
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
                          SizedBox(height: widget.cashHeight * 0.05),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // height: cashHeight * 0.1,
                                  child: Text("Cheque Date"),
                                ),
                                Container(
                                  // height: cashHeight * 0.2,
                                  width: widget.cashWidth * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey.withOpacity(0.01),
                                  ),
                                  child: TextFormField(
                                    onTap: () {
                                      context
                                          .read<PayreceiptController>()
                                          .getDate(context, 'Cheque');
                                    },
                                    autofocus: true,
                                    readOnly: true,
                                    controller: context
                                        .read<PayreceiptController>()
                                        .mycontroller[24],
                                    cursorColor: Colors.grey,
                                    style: widget.theme.textTheme.bodyMedium
                                        ?.copyWith(),
                                    onChanged: (v) {},
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
                                                .read<PayreceiptController>()
                                                .getDate(context, 'Cheque');
                                          },
                                          icon: Icon(Icons.date_range)),
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
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: widget.cashHeight * 0.05),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: widget.cashWidth * 0.35,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        // height: cashHeight * 0.1,
                                        child: Text("Amount"),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            context
                                                .read<PayreceiptController>()
                                                .cpyBtnclik(25);
                                          },
                                          icon: Icon(
                                            Icons.copy,
                                            // size: cashHeight * 0.15,
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  // height: cashHeight * 0.2,
                                  width: widget.cashWidth * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey.withOpacity(0.01),
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    autofocus: true,
                                    controller: context
                                        .read<PayreceiptController>()
                                        .mycontroller[25],
                                    cursorColor: Colors.grey,
                                    style: widget.theme.textTheme.bodyMedium
                                        ?.copyWith(),
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
                          SizedBox(height: widget.cashHeight * 0.05),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // height: cashHeight * 0.1,
                                  child: Text("Remarks"),
                                ),
                                Container(
                                  // height: cashHeight * 0.2,
                                  width: widget.cashWidth * 0.7,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey.withOpacity(0.01),
                                  ),
                                  child: TextFormField(
                                    autofocus: true,
                                    controller: context
                                        .read<PayreceiptController>()
                                        .mycontroller[26],
                                    cursorColor: Colors.grey,
                                    style: widget.theme.textTheme.bodyMedium
                                        ?.copyWith(),
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

  forCard(
    BuildContext context,
    String cardType,
  ) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        color: Colors.white,
        width: widget.cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.05,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                context.read<PayreceiptController>().getmsgforAmount == null
                    ? ''
                    : "${context.watch<PayreceiptController>().getmsgforAmount}",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ),
            Container(
              child: Form(
                  key: context.read<PayreceiptController>().formkey[3],
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // height: cashHeight * 0.1,
                            // width: Screens.width(context) * 0.05,
                            child: Text("Payment Terminal"),
                          ),
                          SizedBox(height: widget.cashHeight * 0.05),
                          Container(
                            // height: cashHeight * 0.24,
                            width: widget.cashWidth * 0.7,
                            padding: EdgeInsets.only(
                              left: widget.cashHeight * 0.01,
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
                                  'Select Payment Terminal',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context
                                                  .read<PayreceiptController>()
                                                  .gethintcolor ==
                                              true
                                          ? Colors.red
                                          : Colors.grey),
                                ),
                                items: context
                                    .read<PayreceiptController>()
                                    .getpayTerminal
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
                                    .read<PayreceiptController>()
                                    .paymentterm,
                                onChanged: (value) {
                                  st(() {
                                    context
                                        .read<PayreceiptController>()
                                        .paymentterm = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: widget.cashHeight * 0.05),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              // width: Screens.width(context) * 0.05,
                              child: Text("Approval No"),
                            ),
                            Container(
                              // height: cashHeight * 0.2,
                              width: widget.cashWidth * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                controller: context
                                    .read<PayreceiptController>()
                                    .mycontroller[27],
                                cursorColor: Colors.grey,
                                style: theme.textTheme.bodyMedium?.copyWith(),
                                onChanged: (v) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' Please Enter the Approval Number';
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
                      SizedBox(height: widget.cashHeight * 0.05),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Card Reference"),
                            ),
                            Container(
                              // height: cashHeight * 0.2,
                              width: widget.cashWidth * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                controller: context
                                    .read<PayreceiptController>()
                                    .mycontroller[28],
                                cursorColor: Colors.grey,
                                style: theme.textTheme.bodyMedium?.copyWith(),
                                onChanged: (v) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' Please Enter the Card Reference';
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
                      SizedBox(height: widget.cashHeight * 0.05),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: widget.cashWidth * 0.35,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    // height: cashHeight * 0.1,
                                    child: Text("Amount"),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<PayreceiptController>()
                                            .cpyBtnclik(29);
                                      },
                                      icon: Icon(
                                        Icons.copy,
                                        // size: cashHeight * 0.15,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              // height: cashHeight * 0.2,
                              width: widget.cashWidth * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: context
                                    .read<PayreceiptController>()
                                    .mycontroller[29],
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
                    ],
                  )),
            ),
          ],
        ),
      );
    });
  }

  forTransfer(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.02,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                context.read<PayreceiptController>().getmsgforAmount == null
                    ? ''
                    : "${context.watch<PayreceiptController>().getmsgforAmount}",
                style: widget.theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.red),
              ),
            ),
            Container(
                child: Form(
              key: context.read<PayreceiptController>().formkey[6],
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
                            child: Text("Trans Type"),
                          ),
                          Container(
                            width: widget.cashWidth * 0.7,
                            padding: EdgeInsets.only(
                              left: widget.cashHeight * 0.01,
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
                                  'Select Trans Type',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: context
                                                .read<PayreceiptController>()
                                                .gethintcolor ==
                                            false
                                        ? Colors.grey
                                        : Colors.red,
                                  ),
                                ),
                                items: context
                                    .read<PayreceiptController>()
                                    .gettransType
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
                                    .read<PayreceiptController>()
                                    .selectedType,
                                onChanged: (value) {
                                  st(() {
                                    context
                                        .read<PayreceiptController>()
                                        .selectedType = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: widget.cashHeight * 0.05),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // width: Screens.width(context) * 0.05,
                            child: Text("Trans Reference"),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: context
                                  .read<PayreceiptController>()
                                  .mycontroller[30],
                              cursorColor: Colors.grey,
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Trans Reference';
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widget.cashWidth * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // height: cashHeight * 0.1,
                                  child: Text("Amount"),
                                ),
                                IconButton(
                                    onPressed: () {
                                      st(() {
                                        context
                                            .read<PayreceiptController>()
                                            .cpyBtnclik(31);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      // size: cashHeight * 0.15,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: context
                                  .read<PayreceiptController>()
                                  .mycontroller[31],
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

  forwallet(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.02,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.02),
        child: Column(
          children: [
            Container(
              child: Text(
                context.read<PayreceiptController>().getmsgforAmount == null
                    ? ''
                    : "${context.read<PayreceiptController>().getmsgforAmount}",
                style: widget.theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.red),
              ),
            ),
            Container(
              child: Form(
                  key: context.read<PayreceiptController>().formkey[5],
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // width: Screens.width(context) * 0.05,
                            child: Text("Wallet"),
                          ),
                          SizedBox(height: widget.cashHeight * 0.05),
                          Container(
                            width: widget.cashWidth * 0.7,
                            padding: EdgeInsets.only(
                              left: widget.cashHeight * 0.01,
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
                                  'Select Wallet Type',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: context
                                                  .read<PayreceiptController>()
                                                  .gethintcolor ==
                                              true
                                          ? Colors.red
                                          : Colors.grey),
                                ),
                                items: context
                                    .read<PayreceiptController>()
                                    .walletlist
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
                                value:
                                    context.read<PayreceiptController>().wallet,
                                onChanged: (value) {
                                  st(() {
                                    context
                                        .read<PayreceiptController>()
                                        .wallet = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: widget.cashHeight * 0.05),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              // width: Screens.width(context) * 0.05,
                              child: Text("Waller ID"),
                            ),
                            Container(
                              // height: cashHeight * 0.2,
                              width: widget.cashWidth * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                controller: context
                                    .read<PayreceiptController>()
                                    .mycontroller[32],
                                cursorColor: Colors.grey,
                                style: widget.theme.textTheme.bodyMedium
                                    ?.copyWith(),
                                onChanged: (v) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' Please Enter the Wallet ID';
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
                      SizedBox(height: widget.cashHeight * 0.05),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              // width: Screens.width(context) * 0.05,
                              child: Text("Payment Reference"),
                            ),
                            Container(
                              // height: cashHeight * 0.2,
                              width: widget.cashWidth * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                controller: context
                                    .read<PayreceiptController>()
                                    .mycontroller[33],
                                cursorColor: Colors.grey,
                                style: widget.theme.textTheme.bodyMedium
                                    ?.copyWith(),
                                onChanged: (v) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' Please Enter the Payment Reference';
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
                      SizedBox(height: widget.cashHeight * 0.05),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: widget.cashWidth * 0.35,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    // height: cashHeight * 0.1,
                                    child: Text("Amount"),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        context
                                            .read<PayreceiptController>()
                                            .cpyBtnclik(34);
                                      },
                                      icon: Icon(
                                        Icons.copy,
                                        // size: cashHeight * 0.15,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              // height: cashHeight * 0.2,
                              width: widget.cashWidth * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: context
                                    .read<PayreceiptController>()
                                    .mycontroller[34],
                                cursorColor: Colors.grey,
                                style: widget.theme.textTheme.bodyMedium
                                    ?.copyWith(),
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
                    ],
                  )),
            )
          ],
        ),
      );
    });
  }

  forCashConfirm(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
          top: widget.cashHeight * 0.01,
          left: widget.cashHeight * 0.09,
          right: widget.cashHeight * 0.09,
        ),
        height: widget.cashHeight * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: widget.cashHeight * 0.6,
                alignment: Alignment.center,
                child: Text(
                    "Is full amount (Rs. ${context.read<PayreceiptController>().config.splitValues(context.watch<PayreceiptController>().getBalancePaid().toStringAsFixed(0))})  as Cash")),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        st(
                          () {
                            context
                                .read<PayreceiptController>()
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
                        width: widget.cashWidth * 0.2,
                        height: widget.cashHeight * 0.3,
                        child: Text(
                          "yes",
                          style: widget.theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        context.read<PayreceiptController>().nullErrorMsg();
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (context, st) {
                                return AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    content: AlertBox(
                                      payMent: 'Payment Mode - Cash',
                                      widget: forCashDialog(context),
                                      buttonName: 'OK',
                                      callback: () {
                                        st(
                                          () {
                                            context
                                                .read<PayreceiptController>()
                                                .addEnteredAmtType('Cash',
                                                    context, 1, widget.theme);
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
                        width: widget.cashWidth * 0.2,
                        height: widget.cashHeight * 0.3,
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

  forCoupons(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: widget.cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.02,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                context.read<PayreceiptController>().getmsgforAmount == null
                    ? ''
                    : "${context.watch<PayreceiptController>().getmsgforAmount}",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ),
            Container(
                child: Form(
              key: context.read<PayreceiptController>().formkey[7],
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
                            width: widget.cashWidth * 0.7,
                            padding: EdgeInsets.only(
                              left: widget.cashHeight * 0.01,
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
                                                .read<PayreceiptController>()
                                                .gethintcolor ==
                                            false
                                        ? Colors.grey
                                        : Colors.red,
                                  ),
                                ),
                                items: context
                                    .watch<PayreceiptController>()
                                    .couponData
                                    .map((CouponDetModel valueitem) {
                                  return DropdownMenuItem(
                                    value: valueitem.coupontype,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Screens.width(context) * 0.02),
                                      child: Text(
                                        valueitem.coupontype.toString(),
                                        style: theme.textTheme.bodyLarge,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                value:
                                    context.read<PayreceiptController>().coupon,
                                onChanged: (value) {
                                  st(() {
                                    context
                                        .read<PayreceiptController>()
                                        .coupon = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: widget.cashHeight * 0.05),
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
                            // height: cashHeight * 0.2,
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: context
                                  .read<PayreceiptController>()
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widget.cashWidth * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // height: cashHeight * 0.1,
                                  child: Text("Amount"),
                                ),
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<PayreceiptController>()
                                          .couponcpybtn();
                                      // posC.cpyBtnclik(36);
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      // size: cashHeight * 0.15,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: context
                                  .read<PayreceiptController>()
                                  .mycontroller[36],
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

  forPoints(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: widget.cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.02,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                context.read<PayreceiptController>().getmsgforAmount == null
                    ? ''
                    : "${context.watch<PayreceiptController>().getmsgforAmount}",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ),
            Container(
                child: Form(
              key: context.read<PayreceiptController>().formkey[8],
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
                            child: Text("Available Points"),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              readOnly: true,
                              controller: context
                                  .read<PayreceiptController>()
                                  .mycontroller[37],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return ' Please Enter the Available Points';
                              //   } else {
                              //     return null;
                              //   }
                              // },
                              decoration: InputDecoration(
                                // hintText: posC.getselectedcust!.point,
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // width: Screens.width(context) * 0.05,
                            child: Text("Points to Redeem"),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: context
                                  .read<PayreceiptController>()
                                  .mycontroller[38],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Redeem points';
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    // Row(
                    //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    InkWell(
                      onTap: () {
                        st(() {
                          context.read<PayreceiptController>().pointconvert();
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: widget.cashHeight * 0.32,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                        ),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Convert points to redeem",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //     onTap: () {
                    //       st(() {
                    //         posC.pointconvert();
                    //       });
                    //     },
                    //     child:
                    //      Container(
                    //         color: Colors.grey, child: Icon(Icons.refresh))),
                    // Container(
                    //   // height: cashHeight * 0.2,
                    //   width: cashWidth * 0.7,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(3),
                    //     color: Colors.grey.withOpacity(0.01),
                    //   ),
                    //   child: TextFormField(
                    //     readOnly: true,
                    //     controller: posC.mycontroller[39],
                    //     cursorColor: Colors.grey,
                    //     style: theme.textTheme.bodyText2?.copyWith(),
                    //     onChanged: (v) {},
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return ' Please Enter the Convert Points';
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     decoration: InputDecoration(
                    //       filled: false,
                    //       focusedErrorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.red),
                    //       ),
                    //       errorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.red),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       contentPadding: const EdgeInsets.symmetric(
                    //         vertical: 5,
                    //         horizontal: 10,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //   ],
                    // ),
                    SizedBox(height: widget.cashHeight * 0.05),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // height: cashHeight * 0.1,
                                  child: Text("Amount"),
                                ),
                                // IconButton(
                                //     onPressed: () {
                                //       st(() {
                                //         posC.pointconvert();
                                //       });
                                //     },
                                //     icon: Icon(
                                //       Icons.copy,
                                //       size: cashHeight * 0.15,
                                //     )),
                              ],
                            ),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: context
                                  .read<PayreceiptController>()
                                  .mycontroller[40],
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

  // forDiscount(BuildContext context, payController posC) {
  forAccBal(BuildContext context, PayreceiptController posC) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: widget.cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.02,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                posC.getmsgforAmount == null ? '' : "${posC.getmsgforAmount}",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
            ),
            Container(
                child: Form(
              key: posC.formkey[9],
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
                            child: Text("Available Balance"),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: widget.cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              readOnly: true,
                              controller: posC.mycontroller[55],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Account Balance';
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
                    SizedBox(height: widget.cashHeight * 0.05),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // width: Screens.width(context) * 0.05,
                            child: Text("Amount to Adjust"),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              // height: cashHeight * 0.2,
                              width: widget.cashWidth * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                controller: posC.mycontroller[42],
                                cursorColor: Colors.grey,
                                style: theme.textTheme.bodyMedium?.copyWith(),
                                onChanged: (v) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' Please Enter the Adjust Amount';
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
                          ),
                        ],
                      ),
                    ),
                  ]),
            )),
            SizedBox(height: widget.cashHeight * 0.05),
          ],
        ),
      );
    });
  }

  forOnAcc(BuildContext context, PayreceiptController posC) {
    return Container(
        padding: EdgeInsets.only(
            top: widget.cashHeight * 0.1,
            left: widget.cashHeight * 0.1,
            right: widget.cashHeight * 0.1,
            bottom: widget.cashHeight * 0.1),
        child: Form(
          key: posC.formkey[10],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                // width: Screens.width(context) * 0.05,
                child: Text("Amount"),
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
                  controller: posC.mycontroller[45],
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
