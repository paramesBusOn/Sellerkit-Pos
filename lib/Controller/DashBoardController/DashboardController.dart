// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:posproject/Constant/Configuration.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import 'package:posproject/DB%20Helper/DBOperation.dart';
import 'package:posproject/DB%20Helper/DBhelper.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/SharedPreference.dart';
import '../../Constant/UserValues.dart';
import '../../DBModel/NotificationModel.dart';
import '../../DBModel/NumberingSeries.dart';
import '../../DBModel/UserDBModel.dart';
import '../../DBModel/paidfromModel.dart';
import '../../Models/DataModel/OriginalSales/OriginalSales.dart';
import '../../Models/ExpenseModel/paidfrom.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../DepositController/DepositsController.dart';
import '../StockOutwardController/StockOutwardController.dart';
import '../StockRequestController/StockRequestController.dart';

class DashBoardController extends ChangeNotifier {
  Configure config = Configure();
  double percent = 0.0;
  double get getpercent => percent;
  List<UserValues> userConstVal = [];
  List<String> catchmsg = [];

  void init(BuildContext context) async {
    await getApppDefaultVal();
    getuserVlues();
    insterNumberingSeries();
    // reievervb2();
    getOutOfStockItems();
    chartMethod();
    getNotification();
    checkpaidfrom();
    getFCM();
    refreshQueue();
await deleteholdmethod();
    // userloginapi();
  }

  reievervb2() async {
    String? ip = await getIP();
    String? branch = await getBranch();
    String? terminal = await getTerminal();
  }

  // callLoginApi() async {
  //   // mycontroller[0]

  //   await LoginUserAPI.getData().then((value) async {
  //     if (value.statuscode >= 200 && value.statuscode <= 210) {
  //       // log("value.users length:::${value.loginuserList!.length}");
  //       if (value.loginuserList != null) {
  //         for (int i = 0; i < value.loginuserList!.length; i++) {}

  //         notifyListeners();
  //       } else if (value.loginuserList == null) {
  //         // exception = value.message!;
  //         // catchmsg.add("Users details: " + value.exception!);
  //       }
  //     } else if (value.statuscode >= 400 && value.statuscode <= 410) {
  //       // exception = value.exception!;
  //       catchmsg.add("Users details: " + value.exception!);
  //     } else {
  //       // exception = value.exception!;
  //       catchmsg.add("Users details: " + value.exception!);
  //     }
  //   });
  // }

// notification
  List<NotificationModel> notify = [];
  List<NotificationModel> get getnotify => notify;

  List<NotificationModel> notifyreverse = [];
  getNotification() async {
    final Database db = (await DBHelper.getInstance())!;
    notifyreverse = await DBOperation.getNotification(db);
    notify = notifyreverse.reversed.toList();
    notifyListeners();
  }

  final firebaseMessaging = FirebaseMessaging.instance;
  getFCM() async {
    String? tokenFCM = await getToken();
//log("FCM tocken: " + tokenFCM!);
  }

  Future<String?> getToken() async {
    return firebaseMessaging.getToken();
  }

  refreshQueue() async {
    bool? netbool = await config.haveInterNet();
    if (netbool == true) {
      final Database db = (await DBHelper.getInstance())!;
      List<Map<String, Object?>> getQstatusData = await DBOperation.get_QstatusData22(db);

      if (getQstatusData.isNotEmpty) {
        for (int i = 0; i < getQstatusData.length; i++) {
          if (getQstatusData[i]["doctype"].toString() == "Sales Invoice") {
            if (getQstatusData[i]["sapDocentry"] != null && getQstatusData[i]["sapDocNo"] != null && getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(db, int.parse(getQstatusData[i]["sapDocentry"].toString()), int.parse(getQstatusData[i]["sapDocNo"].toString()), int.parse(getQstatusData[i]["docentry"].toString()), 'SalesHeader');
              notifyListeners();
            }
            //
          } else if (getQstatusData[i]["doctype"].toString() == "Sales Order") {
            if (getQstatusData[i]["sapDocentry"] != null && getQstatusData[i]["sapDocNo"] != null && getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(db, int.parse(getQstatusData[i]["sapDocentry"].toString()), int.parse(getQstatusData[i]["sapDocNo"].toString()), int.parse(getQstatusData[i]["docentry"].toString()), 'SalesOrderHeader');
              notifyListeners();
            }
            //
          } else if (getQstatusData[i]["doctype"].toString() == "Sales Quotation") {
            if (getQstatusData[i]["sapDocentry"] != null && getQstatusData[i]["sapDocNo"] != null && getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(db, int.parse(getQstatusData[i]["sapDocentry"].toString()), int.parse(getQstatusData[i]["sapDocNo"].toString()), int.parse(getQstatusData[i]["docentry"].toString()), 'SalesQuotationHeader');

              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Sales Return") {
            if (getQstatusData[i]["sapDocentry"] != null && getQstatusData[i]["sapDocNo"] != null && getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(db, int.parse(getQstatusData[i]["sapDocentry"].toString()), int.parse(getQstatusData[i]["sapDocNo"].toString()), int.parse(getQstatusData[i]["docentry"].toString()), 'SalesReturnHeader');
              notifyListeners();
            }
            //
          } else if (getQstatusData[i]["doctype"].toString() == "Payment Receipt") {
            if (getQstatusData[i]["sapDocentry"] != null && getQstatusData[i]["sapDocNo"] != null && getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(db, int.parse(getQstatusData[i]["sapDocentry"].toString()), int.parse(getQstatusData[i]["sapDocNo"].toString()), int.parse(getQstatusData[i]["docentry"].toString()), 'ReceiptHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Stock Request") {
            print("Stock Req");
            StockReqController StockReq = new StockReqController();
            String? whsCode = await DBOperation.getStockReq_WhsCode(db, int.parse(getQstatusData[i]["docentry"].toString()));

            if (getQstatusData[i]["sapDocentry"] != null && getQstatusData[i]["sapDocNo"] != null && getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(db, int.parse(getQstatusData[i]["sapDocentry"].toString()), int.parse(getQstatusData[i]["sapDocNo"].toString()), int.parse(getQstatusData[i]["docentry"].toString()), 'StockReqHDT');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Stock Outward") {
            StockOutwardController stOut = new StockOutwardController();
            // List<Map<String, Object?>> getStOutDetails =
            //     await DBOperation.getRabitMqStOutDetails(
            //         db, int.parse(getQstatusData[i]["docentry"].toString()));
            // log("getQstatusDatabaseDocentry::${getQstatusData[i]["basedocentry"].toString()}");

            if (getQstatusData[i]["sapDocentry"] != null && getQstatusData[i]["sapDocNo"] != null && getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(db, int.parse(getQstatusData[i]["sapDocentry"].toString()), int.parse(getQstatusData[i]["sapDocNo"].toString()), int.parse(getQstatusData[i]["docentry"].toString()), 'StockOutHeaderDataDB');
            }
//
          } else if (getQstatusData[i]["doctype"].toString() == "Stock Inward") {
            StockInwrdController stIn = new StockInwrdController();
            // List<Map<String, Object?>> getStInDetails =
            await DBOperation.getRabitMqStInDetails(db, int.parse(getQstatusData[i]["docentry"].toString()));

            if (getQstatusData[i]["sapDocentry"] != null && getQstatusData[i]["sapDocNo"] != null && getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(db, int.parse(getQstatusData[i]["sapDocentry"].toString()), int.parse(getQstatusData[i]["sapDocNo"].toString()), int.parse(getQstatusData[i]["docentry"].toString()), 'StockInHeaderDB');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Expense") {
            if (getQstatusData[i]["sapDocentry"] != null && getQstatusData[i]["sapDocNo"] != null && getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(db, int.parse(getQstatusData[i]["sapDocentry"].toString()), int.parse(getQstatusData[i]["sapDocNo"].toString()), int.parse(getQstatusData[i]["docentry"].toString()), 'Expense');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Settlement") {
            DepositsController Settle = new DepositsController();

            if (getQstatusData[i]["sapDocentry"] != null && getQstatusData[i]["sapDocNo"] != null && getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(db, int.parse(getQstatusData[i]["sapDocentry"].toString()), int.parse(getQstatusData[i]["sapDocNo"].toString()), int.parse(getQstatusData[i]["docentry"].toString()), 'tableDepositHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Refund") {
            notifyListeners();
          }
        }
        notifyListeners();
      }
    }
    notifyListeners();
  }

  List<DocumentName> docNameId = [
    DocumentName(docName: 'Sales Order'),
    DocumentName(docName: 'Sales Invoice'),
    DocumentName(docName: 'Sales Return'),
    DocumentName(docName: 'Inventory Transfer Request'),
    DocumentName(docName: 'Stock Inward'),
    DocumentName(docName: 'Stock Outward'),
    DocumentName(docName: 'Payment Receipt'),
    DocumentName(docName: 'Expenses'),
    DocumentName(docName: 'Settlement'),
    DocumentName(docName: 'Sales Quotation'),

  ];

  insterNumberingSeries() async {
    final Database db = (await DBHelper.getInstance())!;

    int? count = await DBOperation.getcountofTable(db, 'id', 'NumberingSeries');
    if (count! < 1) {
      insertNumberingSeries();
    }
  }

  insertNumberingSeries() async {
    final Database db = (await DBHelper.getInstance())!;
    List<NumberingSriesTDB> numberseries = [];

    for (int i = 0; i < docNameId.length; i++) {
      numberseries.add(NumberingSriesTDB(
          id: i + 1,DocID: i + 1, FirstNo: 1, FromDate: DateTime.now().toString(), LastNo: 199999, NextNo: 0, Prefix: prefix(i + 1, AppConstant.branch.substring(0, 2), AppConstant.terminal, 100000), Terminal: AppConstant.terminal, ToDate: DateTime.now().toString(), WareHouse: AppConstant.branch, DocName: docNameId[i].docName!));
    }
    //DocID: i + 1
    await DBOperation.insertnumbering(db, numberseries);
  }

  String prefix(int menu, String brnch, String terminal, int value) {
    return '24' + menu.toString().padLeft(2, '0') + brnch + terminal + value.toString();
  }

  refresh() async {
//log("BBBBBBBB");
    reievervb2();
    final Database db = (await DBHelper.getInstance())!;
    await getOutOfStockItems();
    await chartMethod();
    await refreshQueue();
    getNotification();

    // checkCouponMaster();
  }

  List<OrdinalSales> chartDataList = [];
  List<SyncData> syncData1 = [];
  List<SyncData> outOfstock = [];
  bool outOfstockBool = false;
  bool syncdataBool = false;
  bool annocementBool = false;

  int noofSales = 0;
  double noofSalesamt = 0.0;
  double Cashbalance = 0.0;
  int noofSalesOrder = 0;
  int couponsCount = 0;
  int couponsUsedCount = 0;

  double noofSalesOrderamt = 0.0;

  chartMethod() async {
    syncdataBool = true;
    syncData1.clear();
    noofSales = 0;
    noofSalesamt = 0.0;
    couponsCount = 0;
    couponsUsedCount = 0;
    Cashbalance = 0.0;
    noofSalesamt = 0.0;
    noofSalesOrder = 0;
    notifyListeners();
    final Database db = (await DBHelper.getInstance())!;
//chart---
    List<Map<String, Object?>> chartData = await DBOperation.getChartData(db);
    // log("chartData.length:::" + chartData.length.toString());
    for (int i = 0; i < chartData.length; i++) {
      chartDataList.add(OrdinalSales(chartData[i]["createdatetime"] == null ? "a" : chartData[i]["createdatetime"].toString(), chartData[i]["amtpaid"] == null ? 0.0 : double.parse(chartData[i]["amtpaid"].toString())));
    }
    // log("chartDataList.length:::" + chartDataList.length.toString());

    //No of Sales--
    List<Map<String, Object?>> noOfSalesData = await DBOperation.getNoSalesData(db);

    if (noOfSalesData.isNotEmpty) {
      noofSales = noOfSalesData[0]["noofsales"] == null ? 0 : int.parse(noOfSalesData[0]["noofsales"].toString());
      noofSalesamt = noOfSalesData[0]["amtpaid"] == null ? 0.00 : double.parse(noOfSalesData[0]["amtpaid"].toString());
    } else {}
    //No of SalesOrder--
    List<Map<String, Object?>> noOfSalesOrderData = await DBOperation.getNoSalesOrderData(db);
    if (noOfSalesOrderData.isNotEmpty) {
      noofSalesOrder = noOfSalesOrderData[0]["noofsales"] == null ? 0 : int.parse(noOfSalesOrderData[0]["noofsales"].toString());
      noofSalesOrderamt = noOfSalesOrderData[0]["doctotal"] == null ? 0.00 : double.parse(noOfSalesOrderData[0]["doctotal"].toString());
    } else {}
    //CashBalance---
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    List<Map<String, Object?>> getDBsalespaysettle5 = await DBOperation.finalforDeposit(db, "Cash");
    if (getDBsalespaysettle5.isNotEmpty) {
      for (int j = 0; j < getDBsalespaysettle5.length; j++) {
        if (formattedDate.toString() == config.alignDate(getDBsalespaysettle5[j]["createdateTime"].toString())) {
          Cashbalance = Cashbalance + double.parse(getDBsalespaysettle5[j]["rcamount"].toString());
        }
      }
    } else {}
    //Out Of Items Data

    //Coupons
    List<Map<String, Object?>> getCouponsCountData = await DBOperation.getCouponsCount(db);
    List<Map<String, Object?>> getCouponsUsedCountData = await DBOperation.getCouponsUsedCount(db);
    // if (getCouponsCountData.isNotEmpty && getCouponsUsedCountData.isNotEmpty) {
    couponsCount = getCouponsCountData[0]["count"] == null ? 0 : int.parse(getCouponsCountData[0]["count"].toString());
    couponsUsedCount = getCouponsUsedCountData[0]["count"] == null ? 0 : int.parse(getCouponsUsedCountData[0]["count"].toString());

    notifyListeners();

    List<Map<String, Object?>> getsyncedData = await DBOperation.getSynceData(db);
    if (getsyncedData.isNotEmpty) {
      for (int j = 0; j < getsyncedData.length; j++) {
        syncData1.add(SyncData(
          qStatus: getsyncedData[j]["qStatus"].toString(),
          doctype: getsyncedData[j]["doctype"].toString(),
          DocNo: getsyncedData[j]["documentno"] == null ? "0" : getsyncedData[j]["documentno"].toString(),
          // itemname: getsyncedData[j]["itemname"].toString(),
          Docdate: getsyncedData[j]["createdateTime"].toString(),
          // qty: 1,
          sapDate: getsyncedData[j]["UpdatedDatetime"].toString(),
          customername: getsyncedData[j]["customername"].toString(),
          sapNo: getsyncedData[j]["sapDocNo"] == null ? 0 : int.parse(getsyncedData[j]["sapDocNo"].toString().replaceAll(',', '')),
          editType: getsyncedData[j]["editType"].toString(),
        ));
        notifyListeners();
      }
    } else {
      syncdataBool = false;
      notifyListeners();
    }

    notifyListeners();
  }


deleteholdmethod() async{
    final Database db = (await DBHelper.getInstance())!;
 await DBOperation. holdDeleteQuery(db);
 notifyListeners();
}
  getOutOfStockItems() async {
    outOfstock.clear();
    outOfstockBool = true;
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getOutOfItemsData = await DBOperation.getoutofDataData(db);
    if (getOutOfItemsData.isNotEmpty) {
      for (int j = 0; j < getOutOfItemsData.length; j++) {
        if (getOutOfItemsData[j]["shortageQty"] != 0) {
          outOfstock.add(SyncData(
              // DocNo:getsyncedData[j]["documentno"]==null?0: int.parse(getsyncedData[j]["documentno"].toString()),
              itemname: getOutOfItemsData[j]["itemname_short"] == null ? '' : getOutOfItemsData[j]["itemname_short"].toString(),
              // Docdate: getsyncedData[j]["createdateTime"].toString(),
              qty: getOutOfItemsData[j]["shortageQty"] == null ? 0 : int.parse(getOutOfItemsData[j]["shortageQty"].toString()),
              customername: '',
              editType: ''
              // sapDate: getsyncedData[j]["UpdatedDatetime"].toString(),
              // sapNo: getsyncedData[j]["sapDocNo"] == null
              //     ? 0
              //     : int.parse(getsyncedData[j]["sapDocNo"].toString())
              ));
        }
      }
    } else {
      getOutOfStockItems();
      outOfstockBool = false;
      notifyListeners();
    }
    notifyListeners();
  }

  List<PaidFrom> paidfrom = [
    PaidFrom(accountcode: "account1", accountname: "Petty Cash", balance: ""),
    PaidFrom(accountcode: "account2", accountname: "Petty Card", balance: ""),
    PaidFrom(accountcode: "account3", accountname: "Cash In Hand", balance: ""),
  ];

  insertpaidefrome() async {
    final Database db = (await DBHelper.getInstance())!;

    List<expensepaidfrom> paidfromExpense = [];
    for (int i = 0; i < paidfrom.length; i++) {
      paidfromExpense.add(expensepaidfrom(accountcode: paidfrom[i].accountcode, accountname: paidfrom[i].accountname, balance: paidfrom[i].balance));
    }
    await DBOperation.insertExpensepaidfrom(db, paidfromExpense);
    // log("Paid from inserted");

    notifyListeners();
    paidfrom.clear();
    // getpaidfomExpense();
  }

  checkpaidfrom() async {
    final Database db = (await DBHelper.getInstance())!;
    int? getval = await DBOperation.getExpaidfromcount(
      db,
    );
    if (getval! < 1) {
      // print("nothing111..");
      insertpaidefrome();
    } else if (getval > 0) {
      // log("yeah we have111..");
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure?"),
            content: const Text("Do you want to exit an app"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("yes"))
            ],
          ),
        )) ??
        false;
  }

  getApppDefaultVal() async {
    AppConstant.ip = (await SharedPref.getHostDSP())!;
    AppConstant.branch = (await SharedPref.getBranchSSP())!;
    AppConstant.terminal = (await SharedPref.getTerminal())!;
    print("ZZZZZZZZZZz" + AppConstant.branch + ":::" + AppConstant.terminal);
    notifyListeners();
  }

  getuserVlues() async {
    final Database db = (await DBHelper.getInstance())!;
    List<UserModelDB> userModeldb = await DBOperation.userValues(db, (await SharedPref.getUSerSP()).toString());
    for (int i = 0; i < userModeldb.length; i++) {
      UserValues.branch = (await SharedPref.getBranchSSP()).toString();
      UserValues.deviceID = (await SharedPref.getDeviceIDSP());
      UserValues.userID = int.parse(userModeldb[i].createdUserID.toString());
      UserValues.salesExce = '';
      UserValues.lastUpdateIp = userModeldb[i].lastupdateIp.toString();
      UserValues.username = userModeldb[i].userName!;
      UserValues.licenseKey = userModeldb[i].licensekey!;
      UserValues.userStaus = userModeldb[i].userstatus.toString();
      UserValues.userType = userModeldb[i].usertype!.toString();
      UserValues.terminal = (await SharedPref.getTerminal()).toString();
      notifyListeners();
    }
    // log("Terminal message:::" + UserValues.terminal.toString());
    notifyListeners();
  }

  // List<LoginUserData> loginUserItemData = [];
  // userloginapi() async {
  //   log(AppConstant.branch + ":::" + AppConstant.terminal);
  //   loginUserItemData = [];
  //   await LoginUserAPI.getData(AppConstant.branch, AppConstant.terminal).then((value) {
  //     if (value!.statuscode >= 200 && value.statuscode <= 210) {
  //       loginUserItemData = value.loginuserList!;
  //   //log(loginUserItemData[0].branch.toString());
  //       notifyListeners();
  //     } else if (value.statuscode >= 400 && value.statuscode <= 410) {
  //       catchmsg.add("CustomerMaster details: " + value!.exception!);
  //     } else {
  //       // exception = value.exception!;
  //       catchmsg.add("CustomerMaster details: " + value.exception!);
  //     }
  //   });
  // }

  final pagecontroller = PageController(
    initialPage: 0,
  );
}

class SyncData {
  String editType;
  String? DocNo;
  String? itemname;
  String? Docdate;
  String? qStatus;
  int? qty;
  int? sapNo;
  String? sapDate;
  String? doctype;
  String? customername;
  String? sapStatus;
  String? docentry;
  String? basedocentry;
  String? sapDocentry;
  String? reqfromwhs;
  String? reqtowhs;

  // String? customerCode;

  SyncData(
      {this.DocNo,
      required this.editType,
      this.itemname,
      this.Docdate,
      this.qty,
      this.doctype,
      this.sapNo,
      this.qStatus,
      this.sapStatus,
      this.sapDocentry,
      this.docentry,
      this.basedocentry,
      this.reqfromwhs,
      this.reqtowhs,

      // required this.customerCode,
      this.customername,
      this.sapDate});
}
class DocumentName{

  String? docName;
DocumentName({
required this.docName
});
}