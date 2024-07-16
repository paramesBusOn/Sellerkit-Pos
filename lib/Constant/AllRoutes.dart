// ignore_for_file: prefer_const_constructors

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:posproject/Pages/Customer/Screens/Screens.dart';
import 'package:posproject/Pages/Settlement/Screens/SettlementScreen.dart';
import 'package:posproject/Pages/TransactionSync/Screens/TranscationSyncPage.dart';
import '../Pages/ApiSettings/TabScreen/TabApiSettingScreen.dart';
import '../Pages/CashStatement/CashStatement/screens/CashStatement.dart';
import '../Pages/DashBoard/Screens/DashBoardScreen.dart';
import '../Pages/DownloadPage/Screens.dart';
import '../Pages/Expenses/ExpenseScreen.dart';
import '../Pages/NumberingSeriesPage/Screens/Screens.dart';
import '../Pages/PaymentReceipt/Screens/Screens.dart';
import '../Pages/PendingOrder/Screens/Screens.dart';
import '../Pages/Refunds/Screens/Screens.dart';
import '../Pages/ReturnRegister/ReturnRegister/screens/ReturnRegister.dart';
import '../Pages/Sales Screen/Screens/Screens.dart';
import '../Pages/SalesOrder/Screens/Screens.dart';
import '../Pages/SalesQuotation/Screens/Screens.dart';
import '../Pages/SalesReturn/Screens.dart';
import '../Pages/Stock Replenish/Screens/Screens.dart';
import '../Pages/StockInward/Screens/Screens.dart';
import '../Pages/StockOutward/Screens/Screens.dart';
import '../Pages/StockRegister/StockRegister/screens/SalesRegister.dart';
import '../Pages/StockRequest/Screens/Screens.dart';
import '../Pages/StocksCheck/Screens/Screens.dart';
import 'ConstantRoutes.dart';

class Routes {
  static List<GetPage> allRoutes = [
    GetPage<dynamic>(name: ConstantRoutes.dashboard, page: () => DashBoardScreen(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(name: ConstantRoutes.sales, page: () => PosMainScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(name: ConstantRoutes.salesReturn, page: () => SalesReturnScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(name: ConstantRoutes.paymentReciept, page: () => PaymentReceiptScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(name: ConstantRoutes.stockRequest, page: () => StockReqScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(name: ConstantRoutes.stockInward, page: () => StockInwardScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),

    //Resource

    GetPage<dynamic>(name: ConstantRoutes.stockOutward, page: () => StockOutwardScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(name: ConstantRoutes.expence, page: () => ExpenseScreen(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(name: ConstantRoutes.deposits, page: () => DepositScreen(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),

    GetPage<dynamic>(name: ConstantRoutes.salesOrder, page: () => SalesOrderScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(name: ConstantRoutes.stocCheck, page: () => StockCheckMainScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    // StockReplenishMainScreens
    GetPage<dynamic>(name: ConstantRoutes.StockReplenish, page: () => StockReplenishMainScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    // DownloadPage
    GetPage<dynamic>(name: ConstantRoutes.DownloadPage, page: () => DownloadScreen(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(name: ConstantRoutes.stockRegister, page: () => SalesRegisterScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(name: ConstantRoutes.retrurnRegister, page: () => RetRegisterScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(name: ConstantRoutes.cashStatement, page: () => CashSatementScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(name: ConstantRoutes.pendingOrders, page: () => PendingOrderScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(name: ConstantRoutes.customer, page: () => CustomerMainScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(name: ConstantRoutes.refunds, page: () => RefundScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(name: ConstantRoutes.apiSettings, page: () => TabApiSettingsScreen(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(name: ConstantRoutes.salesQuotation, page: () => SalesQuotationScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
    GetPage<dynamic>(name: ConstantRoutes.syncdataPage, page: () => TransactionSyncScreen(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
  GetPage<dynamic>(name: ConstantRoutes.numberSeris, page: () => NumberingScreens(), transition: Transition.fade, transitionDuration: Duration(seconds: 1)),
 
  ];
}
