//Future<SharedPreferences> pref = SharedPreferences.getInstance();

// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import '../Constant/ConstantRoutes.dart';
import '../Pages/Stockslist/Screens/Screens.dart';

Drawer naviDrawer(BuildContext context) {
  // PosController posController = PosController();
  final theme = Theme.of(context);
  double drawerHeight;
  double drawerWidth;
  return Drawer(
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: Screens.bodyheight(context) * 0.04,
            ),
            Container(
              alignment: Alignment.center,
              height: Screens.bodyheight(context) * 0.12,
              width: Screens.width(context) * 0.32,
              decoration: BoxDecoration(
                  border: Border.all(color: theme.primaryColor, width: Screens.width(context) * 0.01),
                  // borderRadius: BorderRadius.circular(6),
                  shape: BoxShape.circle),
              child: Text(
                "POS",
                style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor, shadows: [
                  Shadow(
                      // bottomLeft
                      offset: Offset(-1.5, -1.5),
                      color: Colors.grey[200]!),
                  Shadow(
                      // bottomRight
                      offset: Offset(1.5, -1.5),
                      color: Colors.white),
                ]),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/dashboard.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.035,
                  width: Screens.width(context) * 0.02,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Get.toNamed(ConstantRoutes.dashboard);

                  // Navigator.pop(context);
                  // Get.toNamed(ConstantRoutes.NewReminder);
                },
                title: Text(
                  "Dashboard",
                  // style: GoogleFonts.poppins(
                  //     color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Builder(builder: (context) {
              return ListTile(
                leading: Image.asset(
                  'assets/Drawer/salesorder.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.024,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.salesQuotation);
                },
                title: Text(
                  "Sales Quotation",
                ),
              );
            }),
            Builder(builder: (context) {
              return ListTile(
                leading: Image.asset(
                  'assets/Drawer/quotation.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.024,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.salesOrder);
                },
                title: Text(
                  "Sales Order",
                ),
              );
            }),
            Builder(builder: (context) {
              return ListTile(
                leading: Image.asset(
                  'assets/Drawer/sales.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.024,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.sales);
                },
                title: Text(
                  "Sales",
                  // style: GoogleFonts.poppins(
                  //     color: Colors.black, fontWeight: FontWeight.w500),
                ),
              );
            }),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/exchange.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.024,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.salesReturn);

                  // Navigator.pop(context);
                },
                title: Text(
                  "Sales Return",
                  // style: GoogleFonts.poppins(
                  //     color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/bill.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.024,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.paymentReciept);

                  //  Navigator.pop(context);
                  // paymentReceiptScreens(theme: theme),
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Payment Receipt",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/demand.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.045,
                  width: Screens.width(context) * 0.026,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.stockRequest);

                  // Navigator.pop(context);
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Inventory Transfer Request",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/just-in-time.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.024,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.stockOutward);

                  //  Navigator.pop(context);
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Stock Outward",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/receive.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.024,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.stockInward);

                  // Navigator.pop(context);

                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Stock Inward",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/stocklist.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.022,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockMainScreens(
                                theme: theme,
                              )));
                  // Navigator.pop(context);

                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Stock Lists",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/refund.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.03,
                  width: Screens.width(context) * 0.02,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  //RefundScreens
                  //  Get.toNamed(ConstantRoutes.Login);
                  // Navigator.push(context,
                  Get.toNamed(ConstantRoutes.refunds);
                  // MaterialPageRoute(builder: (context) => RefundScreens()));
                },
                title: Text(
                  "Refunds",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/expense.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.02,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Get.toNamed(ConstantRoutes.expence);

                  //  Get.toNamed(ConstantRoutes.Login);
                  //  Navigator.pop(context);
                },
                title: Text(
                  "Expenses",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/handshake.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.042,
                  width: Screens.width(context) * 0.02,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.deposits);
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Deposits",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/stockcheck.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.024,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Get.toNamed(ConstantRoutes.stocCheck);
                },
                title: Text(
                  "Stock Check",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/customers.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.022,
                ),
                onTap: () {
                  Get.toNamed(ConstantRoutes.customer);
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Customers",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/cashstatement.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.022,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.cashStatement);
                },
                title: Text(
                  "Cash Statement",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/pendingorder.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.022,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.pendingOrders);
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Pending Order",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/stockregister.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.024,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.stockRegister);
                },
                title: Text(
                  "Sales Register",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/returnregister.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.023,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.retrurnRegister);
                },
                title: Text(
                  "Return Register",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/stockreplenish.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.024,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Get.toNamed(ConstantRoutes.StockReplenish);
                },
                title: Text(
                  "Stock Replenish",
                ),
              ),
            ),
            //  Builder(
            //   builder: (context) => ListTile(
            //     leading: Image.asset(
            //       'assets/Drawer/numseries.png',
            //       fit: BoxFit.fill,
            //       height: Screens.bodyheight(context) * 0.038,
            //       width: Screens.width(context) * 0.024,
            //     ),
            //     onTap: () {
            //       Navigator.pop(context);
            //       Get.toNamed(ConstantRoutes.numberSeris);
            //     },
            //     title: Text(
            //       "Numbering Series",
            //     ),
            //   ),
            // ),
            // Builder(
            //   builder: (context) => ListTile(
            //     leading: Image.asset(
            //       'assets/Drawer/sync.png',
            //       fit: BoxFit.fill,
            //       height: Screens.bodyheight(context) * 0.038,
            //       width: Screens.width(context) * 0.024,
            //     ),
            //     onTap: () {
            //       Navigator.pop(context);
            //       Get.toNamed(ConstantRoutes.syncdataPage);
            //     },
            //     title: Text(
            //       "Transaction Sync",
            //     ),
            //   ),
            // ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/Drawer/gear.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.038,
                  width: Screens.width(context) * 0.024,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(ConstantRoutes.apiSettings);
                },
                title: Text(
                  "Settings",
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
