import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/SalesQuotationController/SalesQuotationController.dart';
import '../../Widgets/BottomButton.dart';
import '../../Widgets/CashandCheque.dart';
import '../../Widgets/CustomerDetails.dart';
import '../../Widgets/Paymentpage.dart';
import '../../Widgets/ItemLists.dart';

class SQuotationbillingTabScreen extends StatefulWidget {
  const SQuotationbillingTabScreen({
    Key? key,
    required this.theme, // required this.prdSCD
  }) : super(key: key);

  final ThemeData theme;

  @override
  State<SQuotationbillingTabScreen> createState() => _SQuotationbillingTabScreenState();
}

class _SQuotationbillingTabScreenState extends State<SQuotationbillingTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.withOpacity(0.05),
        height: Screens.bodyheight(context) * 0.95,
        padding: EdgeInsets.only(
          top: Screens.bodyheight(context) * 0.01,
          left: Screens.bodyheight(context) * 0.01,
          right: Screens.bodyheight(context) * 0.01,
          bottom: Screens.bodyheight(context) * 0.01,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: Screens.width(context) * 0.5,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  SQuotationSearchWidget(
                    searchHeight: Screens.bodyheight(context) * 0.69,
                    searchWidth: Screens.width(context) * 0.48,
                    theme: widget.theme,
                  ),
                  SQuotationPayDetails(
                    theme: widget.theme,
                    paymentWidth: Screens.width(context) * 0.48,
                    paymentHeight: Screens.bodyheight(context) * 0.22,
                  )
                ])),
            SizedBox(
                width: Screens.width(context) * 0.48,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    context.watch<SalesQuotationCon>().loadingscrn == true
                        ? SizedBox(
                            width: Screens.width(context) * 0.48,
                            height: Screens.bodyheight(context) * 0.3,
                            child: Center(
                                child: CircularProgressIndicator(
                              color: widget.theme.primaryColor,
                            )))
                        : SQCustomerDetails(
                            custWidth: Screens.width(context) * 0.48,
                            custHeight: Screens.bodyheight(context) * 0.3,
                            theme: widget.theme,
                          ),
                    context.watch<SalesQuotationCon>().getScanneditemData2.isNotEmpty && context.watch<SalesQuotationCon>().getselectedcust2 != null
                        ? Container()
                        : SQCashWidget(
                            cashWidth: Screens.width(context) * 0.48,
                            cashHeight: Screens.bodyheight(context) * 0.1,
                            theme: widget.theme,
                          ),
                    SQBottomButtons(
                      theme: widget.theme,
                      btnheight: Screens.bodyheight(context) * 0.35,
                      btnWidth: Screens.width(context) * 0.48,
                    )
                  ],
                )),
          ],
        ));
  }
}
