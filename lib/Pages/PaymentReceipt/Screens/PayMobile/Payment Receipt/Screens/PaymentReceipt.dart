import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';
// import '../../../../../MobileScreen/Widgets/Mobile_Drawer.dart';
import '../Widgets/AppBar/PayAppBar.dart';
import '../Widgets/MobPaymentMethod.dart';
import '../Widgets/PayReceipt_BottomButton.dart';
import '../Widgets/PayReceipt_Customerdet.dart';
import '../Widgets/PayReceipt_PayTypes.dart';
import '../Widgets/PayReceipt_ProWidgets.dart';
import '../Widgets/PaymentMethod.dart';

class MobPaymentReceipt extends StatefulWidget {
  const MobPaymentReceipt({super.key, required this.payCD});
  final PayreceiptController payCD;
  @override
  State<MobPaymentReceipt> createState() => MobPaymentReceiptState();
}

class MobPaymentReceiptState extends State<MobPaymentReceipt> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            payappbarMS("Payment Receipt", theme, context,
                payController: widget.payCD),
            SizedBox(
              height: Screens.bodyheight(context) * 0.005,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.02,
                  vertical: Screens.padingHeight(context) * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PayReceipt_CustomerDetails(
                    theme: theme,
                    prdCD: widget.payCD,
                    CusHeight: Screens.bodyheight(context) * 0.2,
                    CusWidth: Screens.width(context) * 0.953,
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  PayReceipt_ProWidget(
                      theme: theme,
                      prdsrch: widget.payCD,
                      ProHeight: Screens.bodyheight(context) * 0.5,
                      ProWidth: Screens.width(context) * 0.95),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  PayReceipt_PayTypeWidget(
                    theme: theme,
                    PayHeight: Screens.bodyheight(context),
                    PayWidth: Screens.width(context),
                    Paycon: widget.payCD,
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.015,
                  ),
                  MobPayReceiptDetails(prdPmt:widget. payCD, theme: theme,),
                    SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  MobPaymentMethod(
                    prdCD: widget.payCD,
                    theme: theme,
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  PayReceipt_BottomButton(
                    payCon: widget.payCD,
                    theme: theme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
