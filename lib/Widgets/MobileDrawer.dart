//Future<SharedPreferences> pref = SharedPreferences.getInstance();
// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/SharedPreference.dart';
import 'package:posproject/Pages/LoginScreen/LoginScreen.dart';
import 'package:posproject/Pages/Sales%20Screen/Screens/Screens.dart';
import 'package:posproject/Pages/SalesReturn/Screens.dart';
import 'package:posproject/Pages/Settlement/Screens/SettlementScreen.dart';
import '../Constant/ConstantRoutes.dart';
import '../Pages/Expenses/ExpenseScreen.dart';
import '../Pages/PaymentReceipt/Screens/Screens.dart';
import '../Pages/StockRequest/Screens/Screens.dart';
import '../Pages/Stockslist/Screens/Screens.dart';

Drawer naviDrawerMob(BuildContext context) {
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
                  border: Border.all(
                      color: theme.primaryColor,
                      width: Screens.width(context) * 0.01),
                  // borderRadius: BorderRadius.circular(6),
                  shape: BoxShape.circle),
              child: Text(
                "POS",
                style: theme.textTheme.titleLarge!
                    .copyWith(color: theme.primaryColor, shadows: [
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
                  'assets/NavIcons/salepost.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, '/DashBoardScreen');
                  // Navigator.pop(context);

                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "DashBoard",
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                'assets/NavIcons/Neworder.png',
                fit: BoxFit.fill,

                height: Screens.bodyheight(context) * 0.05,
                width: Screens.width(context) * 0.08,
                // color: drawercolor.Dcolor,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PosMainScreens()));
              },
              title: Text(
                "Sales",
                // style: GoogleFonts.poppins(
                //     color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/easypost.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalesReturnScreens(),
                      ));

                  // Navigator.pop(context);
                  // Get.toNamed(ConstantRoutes.NewReminder);
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
                  'assets/NavIcons/checkcard.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentReceiptScreens()));
                },
                title: Text(
                  "Payment Receipt",
                ),
              ),
            ),

            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/changepost.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StockReqScreens()));
                  // Navigator.pop(context);
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Stock Request",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salepost.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => StockInwardScreens()));
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
                  'assets/NavIcons/addItem.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => StockOutwardScreens()));
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
                  'assets/NavIcons/checkcard.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
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
                  //  Navigator.pop(context);
                  // paymentReceiptScreens(theme: theme),
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Stocks",
                ),
              ),
            ),
            // StockMainScreens
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/delivery.png',
                  fit: BoxFit.fill,

                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                  // color: drawercolor.Dcolor,
                ),
                onTap: () {
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Refunds",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/tax.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ExpenseScreen()));
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
                  'assets/NavIcons/promotion.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DepositScreen()));
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Settlements",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
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
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
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
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Cash Statement",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
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
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Stock Register",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/salesperson.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                  //  Get.toNamed(ConstantRoutes.Login);
                },
                title: Text(
                  "Return Register",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/more.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () {
                   Get.toNamed(ConstantRoutes.StockReplenish);
                },
                title: Text(
                  "Stock Replenish",
                ),
              ),
            ),
            Builder(
              builder: (context) => ListTile(
                leading: Image.asset(
                  'assets/NavIcons/more.png',
                  fit: BoxFit.fill,
                  height: Screens.bodyheight(context) * 0.05,
                  width: Screens.width(context) * 0.08,
                ),
                onTap: () async {
                  SharedPref.clearDeviceID();
                  SharedPref.clearHost();
                  SharedPref.clearLoggedIN();
                  SharedPref.clearSiteCode();
                  SharedPref.clearUserSP();
                  SharedPref.clrLicenseSP();
                  SharedPref.clrUserIdSP();
                  SharedPref.clrBranchSSP();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
                title: Text(
                  "LogOut",
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
