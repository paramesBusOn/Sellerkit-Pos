import 'package:flutter/material.dart';

import '../../../../../../../../Constant/Screen.dart';
import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';
import '../../../../../../Widgets/AlertBox.dart';

// Positioned PayReceipt_BottomButton(
//     BuildContext context, PayreceiptController SRcon, ThemeData theme) {

class PayReceipt_BottomButton extends StatelessWidget {
  const PayReceipt_BottomButton(
      {super.key, required this.payCon, required this.theme});
  final PayreceiptController payCon;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        alignment: Alignment.center,
        width: Screens.width(context),
        padding: EdgeInsets.all(Screens.bodyheight(context) * 0.008),

        decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(Screens.bodyheight(context) * 0.002),
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  height: payCon.get_isVisible
                      ? Screens.bodyheight(context) * 0.06
                      : 0.0,
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  contentPadding: const EdgeInsets.all(0),
                                  content: AlertBox(
                                    payMent: 'Suspended',
                                    widget: forSuspend(theme, context),
                                    buttonName: 'Ok',
                                    callback: () {
                                      Navigator.pop(context);
                                    },
                                  ));
                            });
                      },
                      child: Text("Suspend",
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.white)))),
            ),
            Padding(
              padding: EdgeInsets.all(Screens.bodyheight(context) * 0.002),
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  height: payCon.get_isVisible
                      ? Screens.bodyheight(context) * 0.06
                      : 0.0,
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                      onPressed: () {
                        payCon.onHoldClicked(context, theme);
                      },
                      child: Text("Hold",
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.white)))),
            ),
            Padding(
              padding: EdgeInsets.all(Screens.bodyheight(context) * 0.002),
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  height: payCon.get_isVisible
                      ? Screens.bodyheight(context) * 0.06
                      : 0.0,
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                      onPressed: () {
                        payCon.submitted(context, theme);
                      },
                      child: Text("Submit",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.white)))),
            ),
          ],
        ),
      ),
    );
  }

  forSuspend(ThemeData theme, BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
            height: Screens.bodyheight(context) * 0.12,
            child: Center(
                child: Text(
                    "You about to suspended all information will be unsaved",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium))),
      ],
    ));
  }
}
