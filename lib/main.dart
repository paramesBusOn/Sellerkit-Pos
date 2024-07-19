// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_new, prefer_interpolation_to_compose_strings, unused_import, unnecessary_string_interpolations, depend_on_referenced_packages, must_be_immutable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:dart_amqp/dart_amqp.dart' as am;
import 'package:dart_amqp/dart_amqp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:posproject/Constant/colorGenarator.dart';
import 'package:posproject/Controller/DashBoardController/DashboardController.dart';
import 'package:posproject/Controller/PrinterController/PrintController.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:posproject/Controller/TransacationSyncController/TransactionSyncController.dart';
import 'package:posproject/DBModel/StockSnap.dart';
import 'package:posproject/Pages/DashBoard/Screens/DashBoardScreen.dart';
import 'package:posproject/Pages/PaymentReceipt/Screens/Screens.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'Constant/AllRoutes.dart';
import 'Constant/AppConstant.dart';
import 'Constant/Configuration.dart';
import 'Constant/LocalNotification.dart';
import 'Constant/SharedPreference.dart';
import 'Controller/ApiSettingsController/ApiSettingsController.dart';
import 'Controller/CashStatementController/CashSatementCont.dart';
import 'Controller/CustomerController/CustomerController.dart';
import 'Controller/DepositController/DepositsController.dart';
import 'Controller/DownLoadController/DownloadController.dart';
import 'Controller/ExpenseController/ExpenseController.dart';
import 'Controller/LocalizationController/Localization.dart';
import 'Controller/LoginController/LoginController.dart';
import 'Controller/NumberingSeriesCtrl/NumberingSeriesCtrler.dart';
import 'Controller/PaymentReceiptController/PayReceiptController.dart';
import 'Controller/PendingOrderController/PendingOrderController.dart';
import 'Controller/RefundsController/RefundController.dart';
import 'Controller/ReturnRegisterController/ReturnRegister.dart';
import 'Controller/SalesInvoice/SalesInvoiceController.dart';
import 'Controller/SalesOrderController/SalesOrderController.dart';
import 'Controller/SalesQuotationController/SalesQuotationController.dart';
import 'Controller/SalesReturnController/SalesReturnController.dart';
import 'Controller/StockCheckController/StockCheckController.dart';
import 'Controller/StockInwardController/StockInwardContler.dart';
import 'Controller/StockListsController/StockListsController.dart';
import 'Controller/StockOutwardController/StockOutwardController.dart';
import 'Controller/StockRegisterController/StockRegisterCon.dart';
import 'Controller/StockReplenish/StockReplenishController.dart';
import 'DB Helper/DBOperation.dart';
import 'DB Helper/DBhelper.dart';
import 'DBModel/NotificationModel.dart';
import 'DBModel/SalesHeader.dart';
import 'DBModel/SalesLineDBModel.dart';
import 'DBModel/SalesPay.dart';
import 'Models/Queues/Expense.dart';
import 'Models/Queues/PayReceiptQueue.dart';
import 'Models/Queues/RefundQueueModel.dart';
import 'Models/Queues/SalesOrderQueue.dart';
import 'Models/Queues/SalesQuotationqueue.dart';
import 'Models/Queues/Salesinvoice.dart';
import 'Models/Queues/SapConsumeQueue.dart';
import 'Models/Queues/SelesReturn.dart';
import 'Models/Queues/Settlementqueue.dart';
import 'Models/Queues/StockInward.dart';
import 'Models/Queues/StockOutward.dart';
import 'Models/Queues/StockReq.dart';
import 'Pages/ApiSettings/TabScreen/TabApiSettingScreen.dart';
import 'Pages/DownloadPage/Screens.dart';
import 'Pages/DownloadPage/Widgets/DownloadPage.dart';
import 'Pages/LoginScreen/LoginScreen.dart';
import 'Pages/PendingOrder/Screens/Screens.dart';
import 'Pages/Stockslist/Screens/Screens.dart';
import 'Themes/theme_manager.dart';
import 'l10n/l10n.dart';

LocalNotificationService localNotificationService =
    new LocalNotificationService();

Configure config = Configure();
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  List<NotificationModel> notify = [];
  final Database db = (await DBHelper.getInstance())!;
  Configure config2 = Configure();

  if (message.notification!.android!.imageUrl != null) {
    notify.add(NotificationModel(
      docEntry: 0,
      titile: message.notification!.title,
      description: message.notification!.body!,
      receiveTime: config2.currentDate(),
      seenTime: '0',
      imgUrl: message.notification!.android!.imageUrl.toString(),
      naviScn: 'null',
    ));
    await DBOperation.insertNotification(notify, db);
  } else {
    notify.add(NotificationModel(
      docEntry: 0,
      titile: message.notification!.title,
      description: message.notification!.body!,
      receiveTime: config2.currentDate(),
      seenTime: '0',
      imgUrl: 'null',
      naviScn: 'null',
    ));
    await DBOperation.insertNotification(notify, db);
  }
}

onReciveFCM() async {
  final Database dbs = (await DBHelper.getInstance())!;
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    List<NotificationModel> notify = [];

    if (message.notification != null) {
      localNotificationService.showNitification(
          titile: message.notification!.title,
          msg: message.notification!.body,
          message: message);

      if (message.notification!.android!.imageUrl != null) {
        notify.add(NotificationModel(
          docEntry: 0, //
          titile: message.notification!.title,
          description: message.notification!.body!,
          receiveTime: config.currentDate(),
          seenTime: '0',
          imgUrl: message.notification!.android!.imageUrl.toString(),
          naviScn: 'null',
        ));
        DBOperation.insertNotification(notify, dbs);
      } else {
        notify.add(NotificationModel(
            docEntry: 0,
            //
            titile: message.notification!.title,
            description: message.notification!.body!,
            receiveTime: config.currentDate(),
            seenTime: '0',
            imgUrl: 'null',
            naviScn: 'null'));
        DBOperation.insertNotification(notify, dbs);
      }
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await localNotificationService.flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(localNotificationService.channel);
  // onReciveFCM();
  bool? isdonload = await SharedPref.getDatadonld();
  bool? isLog = await SharedPref.getLoggedINSP();
  // await initializeService();
  runApp(MyApp(
    isLogged: isLog,
    isdonload: isdonload,
  ));
}

Future<void> initializeService() async {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}

void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  //receivervb();
  timePeriod(service);
}

void timePeriod(ServiceInstance service) {
  // Timer.periodic(const Duration(seconds: 15), (timer) async {
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "My App Service",
      content: "Updated at ${DateTime.now()}",
    );
  }

  String? device;

  service.invoke(
    'update',
    {
      "current_date": DateTime.now().toIso8601String(),
      "device": device,
    },
  );
  // });
  receivervb();
}

am.Consumer? consumer2;
am.Queue? queue;
am.Client? client;
am.Channel? channel;
String? qname;
int? consumercount;

Future<void> receivervb() async {
  String? ip = await getIP();
  String? branch = await getBranch();
  String? terminal = await getTerminal();

  if (ip != null &&
      ip != 'null' &&
      branch != null &&
      branch != 'null' &&
      terminal != null &&
      terminal != 'null') {
    AppConstant.ip = ip;
    AppConstant.branch = branch.toString();
    AppConstant.terminal = terminal.toString(); //102.69.167.106

    am.ConnectionSettings settings = am.ConnectionSettings(
        host: "${AppConstant.ip.toString().trim()}",
        //"102.69.167.106"
        port: 5672,
        authProvider: am.PlainAuthenticator("buson", "BusOn123"));
    client = am.Client(settings: settings);

    Map<String, Object> data = {"Branch": UserValues.branch.toString()};

    channel = await client!.channel(); // Br_HOFG_T2

    queue = await channel!.queue(
        "Br_${AppConstant.branch.trim()}_${AppConstant.terminal.toString().trim()}",
        durable: true,
        arguments: data);

    await SharedPref.saveQeueName(queue!.name.toString());
    await SharedPref.saveConsumercount(queue!.consumerCount.toString());
    log("queue!.consumerCount::${queue!.consumerCount}");
    if (queue!.consumerCount == 0) {
      consumer2 = await queue!.consume();
      consumer2?.listen((am.AmqpMessage message) {
        log("Consume the rabbitm queue11");
        log("datata11 : " + jsonDecode(message.payloadAsString).toString());
        validateQueue(message);
      });
    } else if (queue!.consumerCount == 1) {
      consumer2?.listen((am.AmqpMessage message) {
        log("Consume the rabbitm queue222");
        log("datata22 : " + jsonDecode(message.payloadAsString).toString());
        validateQueue(message);
      });
    } else {
      await consumer2?.cancel();
      await channel?.close();
      await client?.close();
    }
  }
}

Future<String?> getIP() async {
  String? ip = await SharedPref.getHostDSP();
  return ip;
}

Future<String?> getBranch() async {
  String? branch = await SharedPref.getBranchSSP();
  return branch;
}

Future<String?> getTerminal() async {
  String? terminal = await SharedPref.getTerminal();
  return terminal;
}

void validateQueue(AmqpMessage message) async {
  //print("Response: " + message.payloadAsString);
  var data = jsonDecode(message.payloadAsString);

  if (data["ObjectType"] == 1) {
    print("data ActionType::" + data["ActionType"].toString());
    if (data["ActionType"] == 'Update') {
      await updateInvoice(message);
    } else if (data["ActionType"] == 'Add') {
      await salesInvoice(message);
    }
  } else if (data["ObjectType"] == 2) {
    if (data["ActionType"] == 'Update') {
      log("Return updated");
      await updateReturn(message);
    } else if (data["ActionType"] == 'Add') {
      log("Return Added");

      await salesReturn(message);
    }
  } else if (data["ObjectType"] == 10) {
    if (data["ActionType"] == 'Update') {
      await updateSalesOrder(message);
    }
    if (data["ActionType"] == 'Edit') {
      await updateSalesOrder(message);
    } else if (data["ActionType"] == 'Add') {
      await salesOrder(message);
    }
  } else if (data["ObjectType"] == 14) {
    if (data["ActionType"] == 'Update') {
      await updatesalesQuotation(message);
    }
    if (data["ActionType"] == 'Edit') {
      await updatesalesQuotation(message);
    } else if (data["ActionType"] == 'Add') {
      salesQuotation(message);
    }
  } else if (data["ObjectType"] == 7) {
    if (data["ActionType"] == 'Update') {
      await updatePayReceipt(message);
    } else if (data["ActionType"] == 'Add') {
      paymentReceipt(message);
    }
  } else if (data["ObjectType"] == 19) {
    if (data["ActionType"] == 'Update') {
      await updateRefund(message);
    } else if (data["ActionType"] == 'Add') {
      await refund(message);
    }
  } else if (data["ObjectType"] == 4) {
    if (data["ActionType"] == 'Update') {
      await updateStockReq(message);
    } else if (data["ActionType"] == 'Add') {
      await stockRequest(message);
    }
  } else if (data["ObjectType"] == 5) {
    if (data["ActionType"] == 'Update') {
      log("data ActionType111::${data["ActionType"]}");
      await updateOutward(message);
    } else if (data["ActionType"] == 'Add') {
      log("data ActionType222::${data["ActionType"]}");
      await stkAddOutward(message);
    }
  } else if (data["ObjectType"] == 6) {
    if (data["ActionType"] == 'Update') {
      await updateINward(message);
    } else if (data["ActionType"] == 'Add') {
      await stkInward(message);
    }
  } else if (data["ObjectType"] == 8) {
    if (data["ActionType"] == 'Update') {
      await updateExpense(message);
      (message);
    } else if (data["ActionType"] == 'Add') {
      await expense(message);
    }
  } else if (data["ObjectType"] == 9) {
    if (data["ActionType"] == 'Update') {
      await updateSettlement(message);
    } else if (data["ActionType"] == 'Add') {
      await settlement(message);
    }
  }
}

expense(message) async {
  final Database db = (await DBHelper.getInstance())!;
  ExpenseQueue salerequest =
      ExpenseQueue.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "Expense",
      int.parse(salerequest.salesHeader[0].docentry.toString()),
      salerequest.salesHeader[0].branch!,
      salerequest.salesHeader[0].terminal);
  if (alrdyhv! < 1) {
    await DBOperation.insertExpense(db, salerequest.salesHeader);
  } else {
    if (salerequest.salesHeader[0].sapDocentry != null) {
      await DBOperation.UpdtSapDetSalHead(
          db,
          salerequest.salesHeader[0].sapDocentry!,
          //
          salerequest.salesHeader[0].sapDocNo!,
          int.parse(salerequest.salesHeader[0].docentry.toString()),
          'Expense');
    } else {
      await DBOperation.UpdtQstatus(
          db, int.parse(salerequest.salesHeader[0].docentry!), 'Expense');
    }
  }
}

updateExpense(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    //print("updateData: doc: " + updateData.DocEntry.toString());

    if (updateData.DocEntry == null) {
      await DBOperation.UpdtExcepSapDetSalHead(db, updateData.TransId!,
          updateData.ErrorMessage!.replaceAll("'", ""), 'Expense');
    } else {
      ExpenseController Expense = new ExpenseController();
      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'Expense');
      Expense.PostRabitMqExpense2(int.parse(updateData.TransId!.toString()));
    }
  } catch (e) {
    //print("E: $e");
  }
}

stkInward(message) async {
  final Database db = (await DBHelper.getInstance())!;
  StockInward stockinw =
      StockInward.fromjson(jsonDecode(message.payloadAsString));

  //print("StockInward: " + stockinw.salesHeader[0].docentry.toString());
  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "StockInHeaderDB",
      int.parse(stockinw.salesHeader[0].docentry.toString()),
      stockinw.salesHeader[0].branch!,
      stockinw.salesHeader[0].terminal);
  //print("alrdyhv: " + alrdyhv.toString());
  if (alrdyhv! < 1) {
    //print("Insert stock inward table");
    await DBOperation.insertStockInheader(db, stockinw.salesHeader);
    await DBOperation.insertStInLine(db, stockinw.salesLine);
    await DBOperation.insertStInBatch(db, stockinw.stInbatch);
  } else {
    //print("AAAAAAAAAAAAAAAAAAA1");
    if (stockinw.salesHeader[0].sapDocentry != null) {
      await DBOperation.UpdtSapDetSalHead(
          db,
          stockinw.salesHeader[0].sapDocentry!,
          //
          stockinw.salesHeader[0].sapDocNo!,
          int.parse(stockinw.salesHeader[0].docentry.toString()),
          'StockInHeaderDB');
    } else {
      await DBOperation.UpdtQstatus(
          db, int.parse(stockinw.salesHeader[0].docentry!), 'StockInHeaderDB');
    }
  }
}

updateINward(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    //print("updateData: doc: " + updateData.DocEntry.toString());

    if (updateData.DocEntry == null) {
      await DBOperation.UpdtExcepSapDetSalHead(db, updateData.TransId!,
          updateData.ErrorMessage!.replaceAll("'", ""), 'StockInHeaderDB');
    } else {
      StockInwrdController stIn = new StockInwrdController();

      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'StockInHeaderDB');
      List<Map<String, Object?>> getStInDetails =
          await DBOperation.getRabitMqStInDetails(
              db, int.parse(updateData.TransId!.toString()));
      await updateInWrdStkSnaptab(int.parse(updateData.TransId!.toString()),
          int.parse(getStInDetails[0]["baseDocentry"].toString()));

      stIn.PostRabitMq2(
          int.parse(updateData.TransId!.toString()),
          int.parse(getStInDetails[0]['baseDocentry'].toString()),
          getStInDetails[0]['reqtoWhs'].toString());
    }
  } catch (e) {
    //print("E: $e");
  }
}
//

stkAddOutward(message) async {
  final Database db = (await DBHelper.getInstance())!;
  StockOutward salerequest =
      StockOutward.fromjson(jsonDecode(message.payloadAsString));
  print("StockOutward: " + salerequest.salesHeader[0].docentry.toString());
  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "StockOutHeaderDataDB",
      int.parse(salerequest.salesHeader[0].docentry.toString()),
      salerequest.salesHeader[0].branch!,
      salerequest.salesHeader[0].terminal);
  print("alrdyhv StockOutHeaderDataDB: " + alrdyhv.toString());
  if (alrdyhv! < 1) {
    await DBOperation.insertStockOutheader(db, salerequest.salesHeader);
    await DBOperation.insertStOutLine(db, salerequest.salesLine);
    await DBOperation.insertStOutBatch(db, salerequest.stoutBatchlist);
  } else {
    if (salerequest.salesHeader[0].sapDocentry != null) {
      await DBOperation.UpdtSapDetSalHead(
          db,
          salerequest.salesHeader[0].sapDocentry!,
          //
          salerequest.salesHeader[0].sapDocNo!,
          int.parse(salerequest.salesHeader[0].docentry.toString()),
          'StockOutHeaderDataDB');
    } else {
      await DBOperation.UpdtQstatus(
          db,
          int.parse(salerequest.salesHeader[0].docentry!),
          'StockOutHeaderDataDB');
    }
  }
}

updateOutward(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    print("updateData: doc: " + updateData.DocEntry.toString());
    if (updateData.DocEntry == null) {
      print(
          "updateData.DocEntryupdateData.DocEntry11:::${updateData.ErrorMessage}");

      await DBOperation.UpdtExcepSapDetSalHead(db, updateData.TransId!,
          updateData.ErrorMessage!.replaceAll("'", ""), 'StockOutHeaderDataDB');
    } else {
      print(
          "updateData.DocEntryupdateData.DocEntry222:::${updateData.DocEntry}");
      StockOutwardController stOut = new StockOutwardController();

      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'StockOutHeaderDataDB');
      List<Map<String, Object?>> getStOutDetails =
          await DBOperation.getRabitMqStOutDetails(
              db, updateData.TransId!.toString());

      await updateOutWrdStkSnaptab(int.parse(updateData.TransId!.toString()),
          int.parse(getStOutDetails[0]["baseDocentry"].toString()));

      await stOut.PostRabitMq2(
          int.parse(updateData.TransId!.toString()),
          getStOutDetails[0]["baseDocentry"].toString(),
          getStOutDetails[0]["reqfromWhs"].toString());
    }
  } catch (e) {
    //print("E: $e");
  }
}

///

stockRequest(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  StockRequest salerequest =
      StockRequest.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "StockReqHDT",
      int.parse(salerequest.salesHeader![0].docentry.toString()),
      salerequest.salesHeader![0].branch!,
      salerequest.salesHeader![0].terminal);
  print("StockReqHDT alrdyhv: " + alrdyhv.toString());
  if (alrdyhv! < 1) {
    await DBOperation.insertStkReq(db, salerequest.salesHeader!);
    await DBOperation.insertStkReqLin(db, salerequest.salesLine!,
        int.parse(salerequest.salesHeader![0].docentry!));
  } else {
    if (salerequest.salesHeader![0].sapDocentry != null) {
      await DBOperation.UpdtSapDetSalHead(
          db,
          salerequest.salesHeader![0].sapDocentry!,
          //
          salerequest.salesHeader![0].sapDocNo!,
          int.parse(salerequest.salesHeader![0].docentry.toString()),
          'StockReqHDT');
    } else {
      await DBOperation.UpdtQstatus(
          db, int.parse(salerequest.salesHeader![0].docentry!), 'StockReqHDT');
    }
  }
}

updateStockReq(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    print("Return updateData: doc: " + updateData.DocEntry.toString());

    if (updateData.DocEntry == null) {
      await DBOperation.UpdtExcepSapDetSalHead(db, updateData.TransId!,
          updateData.ErrorMessage!.replaceAll("'", ""), 'StockReqHDT');
    } else {
      StockReqController StockReq = new StockReqController();
      String? whsCode = await DBOperation.getStockReq_WhsCode(
          db, int.parse(updateData.TransId!.toString()));

      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'StockReqHDT');
      StockReq.PostRabitMqStockReq2(
          int.parse(updateData.TransId!.toString()), whsCode.toString());
    }
  } catch (e) {
    print("E: $e");
  }
}

///
salesReturn(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  SalesRetrun saleret =
      SalesRetrun.fromjson(jsonDecode(message.payloadAsString));
  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "SalesReturnHeader",
      int.parse(saleret.salesHeader![0].docentry.toString()),
      saleret.salesHeader![0].branch!,
      saleret.salesHeader![0].terminal);
  print("alrdyhv: " + alrdyhv.toString());
  if (alrdyhv! < 1) {
    await DBOperation.insertSaleReturnheader(db, saleret.salesHeader!);
    await DBOperation.insertSalesReturnLine(
        db, saleret.salesLine!, int.parse(saleret.salesHeader![0].docentry!));
  } else {
    if (saleret.salesHeader![0].sapDocentry != null) {
      await DBOperation.UpdtSapDetSalHead(
          db,
          int.parse(saleret.salesHeader![0].sapDocentry!),
          //
          int.parse(saleret.salesHeader![0].sapDocNo!),
          int.parse(saleret.salesHeader![0].docentry.toString()),
          'SalesReturnHeader');
    } else {
      await DBOperation.UpdtQstatus(
        db,
        int.parse(saleret.salesHeader![0].docentry!),
        'SalesReturnHeader',
      );
    }
  }
}

updateReturn(AmqpMessage message) async {
  List<SyncData> syncData1 = [];

  final Database db = (await DBHelper.getInstance())!;

  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    // print("updateData: doc: " + updateData.DocEntry.toString());

    if (updateData.DocEntry == null) {
      log("updateData.DocEntry is null");
      await DBOperation.UpdtExcepSapDetSalHead(db, updateData.TransId!,
          updateData.ErrorMessage!.replaceAll("'", ""), 'SalesReturnHeader');
    } else {
      List<Map<String, Object?>> getdbSaleretheader1 =
          await DBOperation.getSalesRetHeadDB(db, updateData.TransId);
      log("updateData.DocEntry isNot null::${updateData.DocEntry}");
      SalesReturnController salesRet = new SalesReturnController();
      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'SalesReturnHeader');
      updateRetStkSnaptab(updateData.TransId!);
      await salesRet.postRabitMqSalesRet2(
          int.parse(updateData.TransId!.toString()),
          getdbSaleretheader1[0]['basedocentry'].toString());
    }
  } catch (e) {
    print("E: $e");
  }
}

salesQuotation(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;

  SalesQuotationQueue saleQuotation =
      SalesQuotationQueue.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "SalesQuotationHeader",
      int.parse(saleQuotation.salesQuotHeader![0].docentry.toString()),
      saleQuotation.salesQuotHeader![0].branch!,
      saleQuotation.salesQuotHeader![0].terminal);
  print("alrdyhv: " + alrdyhv.toString());
  if (alrdyhv! < 1) {
    await DBOperation.insertSaleQuoheader(db, saleQuotation.salesQuotHeader!);
    await DBOperation.insertSalesQuoLine(db, saleQuotation.salesQuotLine!,
        int.parse(saleQuotation.salesQuotHeader![0].docentry!));
  } else {
    if (saleQuotation.salesQuotHeader![0].sapDocentry != null) {
      await DBOperation.UpdtSapDetSalHead(
          db,
          saleQuotation.salesQuotHeader![0].sapDocentry!,
          //
          saleQuotation.salesQuotHeader![0].sapDocNo!,
          int.parse(saleQuotation.salesQuotHeader![0].docentry.toString()),
          'SalesQuotationHeader');
    } else {
      await DBOperation.UpdtQstatus(
          db,
          int.parse(saleQuotation.salesQuotHeader![0].docentry!),
          'SalesQuotationHeader');
    }
  }
}

updatesalesQuotation(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    log("updateData: doc: " + updateData.DocEntry.toString());
    // log("updateData: Act type: " + updateData.ActionType.toString());
    SalesQuotationCon salesQuot = new SalesQuotationCon();

    if (updateData.DocEntry == null) {
      await DBOperation.UpdtExcepSapDetSalHead(db, updateData.TransId!,
          updateData.ErrorMessage!.replaceAll("'", ""), 'SalesQuotationHeader');
    } else if (updateData.DocEntry != null && updateData.ActionType == "Edit") {
      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'SalesQuotationHeader');
      await salesQuot.pushRabiMqSO2(int.parse(updateData.TransId!.toString()));
    } else if (updateData.ActionType == "Update") {
      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'SalesQuotationHeader');
      await salesQuot.pushRabiMqSO2(int.parse(updateData.TransId!.toString()));
    }
  } catch (e) {
    print("E: $e");
  }
}

salesOrder(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;

  SalesOrderQueue saleinvc =
      SalesOrderQueue.fromjson(jsonDecode(message.payloadAsString));
  print("saleinvc.salesOrderHeader!.docentry: " +
      saleinvc.salesOrderHeader![0].docentry.toString());

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "SalesOrderHeader",
      int.parse(saleinvc.salesOrderHeader![0].docentry.toString()),
      saleinvc.salesOrderHeader![0].branch!,
      saleinvc.salesOrderHeader![0].terminal);
  print("alrdyhv: " + alrdyhv.toString());
  if (alrdyhv! < 1) {
    await DBOperation.insertSaleOrderheader(db, saleinvc.salesOrderHeader!);
    await DBOperation.insertSalesOrderLine(db, saleinvc.salesOrderLine!,
        int.parse(saleinvc.salesOrderHeader![0].docentry!));
    await DBOperation.insertSalesOrderPay(db, saleinvc.salesOrderPayDB!,
        int.parse(saleinvc.salesOrderHeader![0].docentry.toString()));
  } else {
    if (saleinvc.salesOrderHeader![0].sapDocentry != null) {
      await DBOperation.UpdtSapDetSalHead(
          db,
          saleinvc.salesOrderHeader![0].sapDocentry!,
          //
          saleinvc.salesOrderHeader![0].sapDocNo!,
          int.parse(saleinvc.salesOrderHeader![0].docentry.toString()),
          'SalesOrderHeader');
    } else {
      await DBOperation.UpdtQstatus(
          db,
          int.parse(saleinvc.salesOrderHeader![0].docentry!),
          'SalesOrderHeader');
    }
  }
}

updateSalesOrder(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    print("updateData: doc: " + updateData.DocEntry.toString());
    SOCon salesOrder = new SOCon();

    if (updateData.DocEntry == null) {
      await DBOperation.UpdtExcepSapDetSalHead(db, updateData.TransId!,
          updateData.ErrorMessage!.replaceAll("'", ""), 'SalesOrderHeader');
    } else if (updateData.DocEntry != null && updateData.ActionType == "Edit") {
      // await salesOrder.pushRabiMqSO3(int.parse(updateData.TransId!.toString()));
      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'SalesOrderHeader');
      await salesOrder.pushRabiMqSO2(int.parse(updateData.TransId!.toString()));
    } else if (updateData.DocEntry != null &&
        updateData.ActionType == "Update") {
      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'SalesOrderHeader');
      await salesOrder.pushRabiMqSO2(int.parse(updateData.TransId!.toString()));
    }
  } catch (e) {
    print("E: $e");
  }
}

//
salesInvoice(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  SalesInvoice saleinvc =
      SalesInvoice.fromjson(jsonDecode(message.payloadAsString));
  print("saleinvc.salesHeader!.docentry: " +
      saleinvc.salesHeader![0].docentry.toString());

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "SalesHeader",
      int.parse(saleinvc.salesHeader![0].docentry.toString()),
      saleinvc.salesHeader![0].branch!,
      saleinvc.salesHeader![0].terminal);
  print("alrdyhv: " + alrdyhv.toString());
  if (alrdyhv! < 1) {
    await DBOperation.insertSaleheader(db, saleinvc.salesHeader!);
    await DBOperation.insertSalesLine(
        db, saleinvc.salesLine!, int.parse(saleinvc.salesHeader![0].docentry!));
    await DBOperation.insertSalesPay(db, saleinvc.salesPayDB!,
        int.parse(saleinvc.salesHeader![0].docentry.toString()));
  } else {
    if (saleinvc.salesHeader![0].sapDocentry != null) {
      await DBOperation.UpdtSapDetSalHead(
          db,
          saleinvc.salesHeader![0].sapDocentry!,
          //
          saleinvc.salesHeader![0].sapDocNo!,
          int.parse(saleinvc.salesHeader![0].docentry.toString()),
          'SalesHeader');
    } else {
      await DBOperation.UpdtQstatus(
          db, int.parse(saleinvc.salesHeader![0].docentry!), 'SalesHeader');
    }
  }
}

updateInvoice(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    print(
        "updateData doc ActionType & updateData.DocEntry: ${updateData.ActionType}: " +
            updateData.DocEntry.toString());

    if (updateData.DocEntry == null) {
      await DBOperation.UpdtExcepSapDetSalHead(db, updateData.TransId!,
          updateData.ErrorMessage!.replaceAll("'", ""), 'SalesHeader');
    } else {
      PosController salesInvoice = new PosController();
      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'SalesHeader');
      await updateInvStkSnaptab(updateData.TransId!);
      // await salesInvoice
      //     .pushRabitmqSales2(int.parse(updateData.TransId!.toString()));
    }
  } catch (e) {
    print("E: $e");
  }
}

settlement(message) async {
  final Database db = (await DBHelper.getInstance())!;
  DepositQueue salerequest =
      DepositQueue.fromjson(jsonDecode(message.payloadAsString));
  //print("UUUUUUUUUUUUUU");

  //print("Settlement: " + salerequest.salesHeader[0].docentry.toString());
  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "tableDepositHeader",
      int.parse(salerequest.salesHeader[0].docentry.toString()),
      salerequest.salesHeader[0].branch!,
      salerequest.salesHeader[0].terminal);
  //print(" salerequest.salesHeader[0].branch!::" +
  // salerequest.salesHeader[0].branch!);
  //print("alrdyhv: " + alrdyhv.toString());
  if (alrdyhv! < 1) {
    //print("Insert Settlemnt table");
    await DBOperation.insertDepositHeader(db, salerequest.salesHeader);
    await DBOperation.insertDepositLine(db, salerequest.salesLine,
        int.parse(salerequest.salesHeader[0].docentry.toString()));
  } else {
    if (salerequest.salesHeader[0].sapDocentry != null) {
      await DBOperation.UpdtSapDetSalHead(
          db,
          salerequest.salesHeader[0].sapDocentry!,
          //
          salerequest.salesHeader[0].sapDocNo!,
          int.parse(salerequest.salesHeader[0].docentry.toString()),
          'tableDepositHeader');
    } else {
      await DBOperation.UpdtQstatus(
          db,
          int.parse(salerequest.salesHeader[0].docentry!.toString()),
          'tableDepositHeader');
    }
  }
}

updateSettlement(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    //print("updateData: doc: " + updateData.DocEntry.toString());

    if (updateData.DocEntry == null) {
      await DBOperation.UpdtExcepSapDetSalHead(db, updateData.TransId!,
          updateData.ErrorMessage!.replaceAll("'", ""), 'tableDepositHeader');
    } else {
      DepositsController Settle = new DepositsController();
      List<Map<String, Object?>> getDBSettlementHeader =
          await DBOperation.getDepositHeadDB(
              db, int.parse(updateData.TransId!.toString()));

      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'tableDepositHeader');
      // await Settle.PostRabitMqSettle2(int.parse(updateData.TransId!.toString()),
      //     getDBSettlementHeader[0]['typedeposit'].toString());
    }
  } catch (e) {
    //print("E: $e");s
  }
}

paymentReceipt(AmqpMessage message) async {
  print("not update");
  final Database db = (await DBHelper.getInstance())!;
  ReceiptQueue saleinvc =
      ReceiptQueue.fromjson(jsonDecode(message.payloadAsString));
  //print("saleinvc.salesHeader!.docentry: " +
  // saleinvc.salesHeader![0].docentry.toString());
  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "ReceiptHeader",
      int.parse(saleinvc.salesHeader![0].docentry.toString()),
      saleinvc.salesHeader![0].branch!,
      saleinvc.salesHeader![0].terminal);
  //print("alrdyhv: " + alrdyhv.toString());
  if (alrdyhv! < 1) {
    await DBOperation.insertRecieptHeader(db, saleinvc.salesHeader!);
    await DBOperation.insertRecieptLine(db, saleinvc.salesLine!,
        int.parse(saleinvc.salesHeader![0].docentry!.toString()));
    await DBOperation.insertReciepLine2(db, saleinvc.salesPayDB!,
        int.parse(saleinvc.salesHeader![0].docentry.toString()));
  } else {
    if (saleinvc.salesHeader![0].sapDocentry != null) {
      await DBOperation.UpdtSapDetSalHead(
          db,
          saleinvc.salesHeader![0].sapDocentry!,
          //
          saleinvc.salesHeader![0].sapDocNo!,
          int.parse(saleinvc.salesHeader![0].docentry.toString()),
          'ReceiptHeader');
    } else {
      await DBOperation.UpdtQstatus(
          db,
          int.parse(saleinvc.salesHeader![0].docentry!.toString()),
          'ReceiptHeader');
    }
  }
}

updatePayReceipt(AmqpMessage message) async {
  print("JJJJJJJJJ 11");
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    //print("updateData: doc: " + updateData.DocEntry.toString());

    if (updateData.DocEntry == null) {
      // print("JJJJJJJJJ 222");

      await DBOperation.UpdtExcepSapDetSalHead(db, updateData.TransId!,
          updateData.ErrorMessage!.replaceAll("'", ""), 'ReceiptHeader');
      await DBOperation.getReceiptHeaderDB(db, updateData.TransId!);
    } else {
      // print("JJJJJJJJJ 333");
      PayreceiptController PayRecipt = new PayreceiptController();
      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'ReceiptHeader');
      // PayRecipt.postRabitMqPaymentReceipt2(
      //     int.parse(updateData.TransId!.toString()));
    }
  } catch (e) {
    //print("E: $e");
  }
}

//refund
refund(AmqpMessage message) async {
  //print("KKKKKKKKK");
  final Database db = (await DBHelper.getInstance())!;
  RefundQueue saleinvc =
      RefundQueue.fromjson(jsonDecode(message.payloadAsString));
  //print("saleinvc.refundHeader!.docentry: " +
  // saleinvc.refundHeader![0].docentry.toString());
  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "RefundHeader",
      int.parse(saleinvc.refundHeader![0].docentry.toString()),
      saleinvc.refundHeader![0].branch!,
      saleinvc.refundHeader![0].terminal);
  //print("alrdyhv: " + alrdyhv.toString());
  if (alrdyhv! < 1) {
    await DBOperation.insertRefundHeader(db, saleinvc.refundHeader!);
    await DBOperation.insertRefundLine(db, saleinvc.refundLine!,
        int.parse(saleinvc.refundHeader![0].docentry!.toString()));
    await DBOperation.insertRefundPay(db, saleinvc.refundPayDB!,
        int.parse(saleinvc.refundHeader![0].docentry.toString()));
  } else {
    await DBOperation.UpdtQstatus(
        db,
        int.parse(saleinvc.refundHeader![0].docentry!.toString()),
        'RefundHeader');
  }
}

updateInvStkSnaptab(int docentry) async {
  final Database db = (await DBHelper.getInstance())!;
  List<Map<String, Object?>> getDBSalesHeader =
      await DBOperation.getSalesHeaderDB(db, docentry);
  List<Map<String, Object?>> getDBSalesLine = await DBOperation.holdSalesLineDB(
      db, int.parse(getDBSalesHeader[0]['docentry'].toString()));

  for (int i = 0; i < getDBSalesLine.length; i++) {
    List<Map<String, Object?>> serialbatchCheck =
        await DBOperation.serialBatchCheck(
            db,
            getDBSalesLine[i]['serialbatch'].toString(),
            getDBSalesLine[i]['itemcode'].toString());
    for (int ij = 0; ij < serialbatchCheck.length; ij++) {
      if (getDBSalesLine[i]['serialbatch'].toString() ==
              serialbatchCheck[ij]['serialbatch'].toString() &&
          getDBSalesLine[i]['itemcode'].toString() ==
              serialbatchCheck[ij]['itemcode'].toString()) {
        List<StockSnapTModelDB> stkSnpValues = [];

        int stksnpqty = int.parse(serialbatchCheck[ij]['quantity'].toString()) -
            int.parse(getDBSalesLine[i]['quantity'].toString());

        stkSnpValues.add(StockSnapTModelDB(
          uPackSize: serialbatchCheck[ij]['uPackSize'].toString(),
          uTINSPERBOX: serialbatchCheck[ij]['uTINSPERBOX'] != null
              ? int.parse(serialbatchCheck[ij]['uTINSPERBOX'].toString())
              : 0,
          uSpecificGravity: serialbatchCheck[ij]['uSpecificGravity'].toString(),
          branch: serialbatchCheck[ij]['branch'].toString(),
          terminal: serialbatchCheck[ij]['terminal'].toString(),
          itemname: serialbatchCheck[ij]['itemname'].toString(),
          branchcode: serialbatchCheck[ij]['branchcode'].toString(),
          createdUserID:
              int.parse(serialbatchCheck[ij]['createdUserID'].toString()),
          createdateTime: serialbatchCheck[ij]['createdateTime'].toString(),
          itemcode: serialbatchCheck[ij]['itemcode'].toString(),
          lastupdateIp: serialbatchCheck[ij]['lastupdateIp'].toString(),
          maxdiscount: serialbatchCheck[ij]['maxdiscount'].toString(),
          taxrate: serialbatchCheck[ij]['taxrate'].toString(),
          mrpprice: serialbatchCheck[ij]['mrpprice'].toString(),
          sellprice: serialbatchCheck[ij]['sellprice'].toString(),
          purchasedate: serialbatchCheck[ij]['purchasedate'].toString(),
          quantity: stksnpqty.toString(),
          serialbatch: serialbatchCheck[ij]['serialbatch'].toString(),
          snapdatetime: serialbatchCheck[ij]['snapdatetime'].toString(),
          specialprice: serialbatchCheck[ij]['specialprice'].toString(),
          updatedDatetime: serialbatchCheck[ij]['updatedDatetime'].toString(),
          updateduserid:
              int.parse(serialbatchCheck[ij]['updateduserid'].toString()),
          liter: double.parse(serialbatchCheck[ij]['liter'].toString()),
          weight: double.parse(serialbatchCheck[ij]['weight'].toString()),
          uPackSizeuom: serialbatchCheck[ij]['UPackSizeUom'].toString(),
        ));

        await DBOperation.updateStkSnap(db, stkSnpValues, ij);
      }
    }
  }
}

updateRetStkSnaptab(int docentry) async {
  final Database db = (await DBHelper.getInstance())!;
  List<Map<String, Object?>> getDBSalesHeader =
      await DBOperation.getSalesRetHeadDB(db, docentry);
  List<Map<String, Object?>> getDBSalesLine =
      await DBOperation.grtSalesRetLineDB(
          db, int.parse(getDBSalesHeader[0]['docentry'].toString()));
  for (int i = 0; i < getDBSalesLine.length; i++) {
    List<Map<String, Object?>> serialbatchCheck =
        await DBOperation.serialBatchCheck(
            db,
            getDBSalesLine[i]['serialbatch'].toString(),
            getDBSalesLine[i]['itemcode'].toString());
    for (int ij = 0; ij < serialbatchCheck.length; ij++) {
      if (getDBSalesLine[i]['serialbatch'].toString() ==
              serialbatchCheck[ij]['serialbatch'].toString() &&
          getDBSalesLine[i]['itemcode'].toString() ==
              serialbatchCheck[ij]['itemcode'].toString()) {
        List<StockSnapTModelDB> stkSnpValues = [];

        int stksnpqty = int.parse(serialbatchCheck[ij]['quantity'].toString()) +
            int.parse(getDBSalesLine[i]['quantity'].toString());

        stkSnpValues.add(StockSnapTModelDB(
          uPackSizeuom: serialbatchCheck[ij]['UPackSizeUom'].toString(),
          uPackSize: serialbatchCheck[ij]['uPackSize'].toString(),
          uTINSPERBOX: serialbatchCheck[ij]['uTINSPERBOX'] != null
              ? int.parse(serialbatchCheck[ij]['uTINSPERBOX'].toString())
              : 0,
          uSpecificGravity: serialbatchCheck[ij]['uSpecificGravity'].toString(),
          branch: serialbatchCheck[ij]['branch'].toString(),
          terminal: serialbatchCheck[ij]['terminal'].toString(),
          itemname: serialbatchCheck[ij]['itemname'].toString(),
          branchcode: serialbatchCheck[ij]['branchcode'].toString(),
          createdUserID:
              int.parse(serialbatchCheck[ij]['createdUserID'].toString()),
          createdateTime: serialbatchCheck[ij]['createdateTime'].toString(),
          itemcode: serialbatchCheck[ij]['itemcode'].toString(),
          lastupdateIp: serialbatchCheck[ij]['lastupdateIp'].toString(),
          maxdiscount: serialbatchCheck[ij]['maxdiscount'].toString(),
          taxrate: serialbatchCheck[ij]['taxrate'].toString(),
          mrpprice: serialbatchCheck[ij]['mrpprice'].toString(),
          sellprice: serialbatchCheck[ij]['sellprice'].toString(),
          purchasedate: serialbatchCheck[ij]['purchasedate'].toString(),
          quantity: stksnpqty.toString(),
          serialbatch: serialbatchCheck[ij]['serialbatch'].toString(),
          snapdatetime: serialbatchCheck[ij]['snapdatetime'].toString(),
          specialprice: serialbatchCheck[ij]['specialprice'].toString(),
          updatedDatetime: serialbatchCheck[ij]['updatedDatetime'].toString(),
          updateduserid:
              int.parse(serialbatchCheck[ij]['updateduserid'].toString()),
          liter: double.parse(serialbatchCheck[ij]['liter'].toString()),
          weight: double.parse(serialbatchCheck[ij]['weight'].toString()),
        ));

        await DBOperation.updateStkSnap(db, stkSnpValues, ij);
      }
    }
  }
}

updateOutWrdStkSnaptab(int docentry, int baseDocentry) async {
  final Database db = (await DBHelper.getInstance())!;

  List<Map<String, Object?>> getDB_StoutHeader =
      await DBOperation.getStockOutHeader(db, docentry); //com
  // List<Map<String, Object?>> getDB_StoutLine = await DBOperation.holdStOutLineDB(db, docentry, baseDocentry.toString()); //com
  List<Map<String, Object?>> getDB_StOutBatch =
      await DBOperation.getStockOutBatch(
          db, docentry, baseDocentry.toString()); //com
  if (getDB_StoutHeader[0]['branch'] == AppConstant.branch) {
    for (int i = 0; i < getDB_StOutBatch.length; i++) {
      List<Map<String, Object?>> serialbatchCheck =
          await DBOperation.serialBatchCheck(
              db,
              getDB_StOutBatch[i]['serialBatch'].toString(),
              getDB_StOutBatch[i]['itemcode'].toString());
      log(getDB_StOutBatch[i]['serialBatch'].toString());

      for (int ij = 0; ij < serialbatchCheck.length; ij++) {
        if (getDB_StOutBatch[i]['serialBatch'].toString() ==
                serialbatchCheck[ij]['serialbatch'].toString() &&
            getDB_StOutBatch[i]['itemcode'].toString() ==
                serialbatchCheck[ij]['itemcode'].toString()) {
          List<StockSnapTModelDB> stkSnpValues = [];

          int stksnpqty =
              int.parse(serialbatchCheck[ij]['quantity'].toString()) -
                  int.parse(getDB_StOutBatch[i]['quantity'].toString());

          stkSnpValues.add(StockSnapTModelDB(
            uPackSize: serialbatchCheck[ij]['uPackSize'].toString(),
            uTINSPERBOX: serialbatchCheck[ij]['uTINSPERBOX'] != null
                ? int.parse(serialbatchCheck[ij]['uTINSPERBOX'].toString())
                : 0,
            uSpecificGravity:
                serialbatchCheck[ij]['uSpecificGravity'].toString(),
            branch: serialbatchCheck[ij]['branch'].toString(),
            terminal: serialbatchCheck[ij]['terminal'].toString(),
            itemname: serialbatchCheck[ij]['itemname'].toString(),
            branchcode: serialbatchCheck[ij]['branchcode'].toString(),
            createdUserID:
                int.parse(serialbatchCheck[ij]['createdUserID'].toString()),
            createdateTime: serialbatchCheck[ij]['createdateTime'].toString(),
            itemcode: serialbatchCheck[ij]['itemcode'].toString(),
            lastupdateIp: serialbatchCheck[ij]['lastupdateIp'].toString(),
            maxdiscount: serialbatchCheck[ij]['maxdiscount'].toString(),
            taxrate: serialbatchCheck[ij]['taxrate'].toString(),
            mrpprice: serialbatchCheck[ij]['mrpprice'].toString(),
            sellprice: serialbatchCheck[ij]['sellprice'].toString(),
            purchasedate: serialbatchCheck[ij]['purchasedate'].toString(),
            quantity: stksnpqty.toString(),
            serialbatch: serialbatchCheck[ij]['serialbatch'].toString(),
            snapdatetime: serialbatchCheck[ij]['snapdatetime'].toString(),
            specialprice: serialbatchCheck[ij]['specialprice'].toString(),
            updatedDatetime: serialbatchCheck[ij]['updatedDatetime'].toString(),
            updateduserid:
                int.parse(serialbatchCheck[ij]['updateduserid'].toString()),
            liter: double.parse(serialbatchCheck[ij]['liter'].toString()),
            weight: double.parse(serialbatchCheck[ij]['weight'].toString()),
            uPackSizeuom: serialbatchCheck[ij]['UPackSizeUom'].toString(),
          ));

          await DBOperation.updateStkSnap(db, stkSnpValues, ij);
        } else {
          log('not outward updated');
        }
      }
    }
  }
}

updateInWrdStkSnaptab(int docentry, int baseDocentry) async {
  final Database db = (await DBHelper.getInstance())!;
  List<Map<String, Object?>> getDB_StInHeader =
      await DBOperation.getStockInHeader(db, docentry);
  List<Map<String, Object?>> getDB_StInLine =
      await DBOperation.holdStInLineDB(db, baseDocentry, docentry);

  List<Map<String, Object?>> getDB_StInBatch =
      await DBOperation.getStockInBatch(db, baseDocentry, docentry);

  List<StockSnapTModelDB> stkSnpValues = [];
  if (getDB_StInHeader[0]['branch'] == AppConstant.branch) {
    for (int i = 0; i < getDB_StInBatch.length; i++) {
      List<Map<String, Object?>> serialbatchCheck =
          await DBOperation.serialBatchCheck(
              db,
              getDB_StInBatch[i]['serialBatch'].toString(),
              getDB_StInBatch[i]['itemcode'].toString());
      log(getDB_StInBatch[i]['serialBatch'].toString());

      if (serialbatchCheck.isNotEmpty) {
        for (int ij = 0; ij < serialbatchCheck.length; ij++) {
          if (getDB_StInBatch[i]['serialBatch'].toString() ==
                  serialbatchCheck[ij]['serialbatch'].toString() &&
              getDB_StInBatch[i]['itemcode'].toString() ==
                  serialbatchCheck[ij]['itemcode'].toString()) {
            int stksnpqty =
                int.parse(serialbatchCheck[ij]['quantity'].toString()) +
                    int.parse(getDB_StInBatch[i]['quantity'].toString());

            stkSnpValues.add(StockSnapTModelDB(
              uPackSize: serialbatchCheck[ij]['uPackSize'].toString(),
              uPackSizeuom: serialbatchCheck[ij]['UPackSizeUom'].toString(),
              uTINSPERBOX: serialbatchCheck[ij]['uTINSPERBOX'] != null
                  ? int.parse(serialbatchCheck[ij]['uTINSPERBOX'].toString())
                  : 0,
              uSpecificGravity:
                  serialbatchCheck[ij]['uSpecificGravity'].toString(),
              branch: serialbatchCheck[ij]['branch'].toString(),
              terminal: serialbatchCheck[ij]['terminal'].toString(),
              itemname: serialbatchCheck[ij]['itemname'].toString(),
              branchcode: serialbatchCheck[ij]['branchcode'].toString(),
              createdUserID:
                  int.parse(serialbatchCheck[ij]['createdUserID'].toString()),
              createdateTime: serialbatchCheck[ij]['createdateTime'].toString(),
              itemcode: serialbatchCheck[ij]['itemcode'].toString(),
              lastupdateIp: serialbatchCheck[ij]['lastupdateIp'].toString(),
              maxdiscount: serialbatchCheck[ij]['maxdiscount'].toString(),
              taxrate: 18.toString(),
              mrpprice: serialbatchCheck[ij]['mrpprice'].toString(),
              sellprice: serialbatchCheck[ij]['sellprice'].toString(),
              purchasedate: serialbatchCheck[ij]['purchasedate'].toString(),
              quantity: stksnpqty.toString(),
              serialbatch: serialbatchCheck[ij]['serialbatch'].toString(),
              snapdatetime: serialbatchCheck[ij]['snapdatetime'].toString(),
              specialprice: serialbatchCheck[ij]['specialprice'].toString(),
              updatedDatetime:
                  serialbatchCheck[ij]['updatedDatetime'].toString(),
              updateduserid:
                  int.parse(serialbatchCheck[ij]['updateduserid'].toString()),
              liter: double.parse(serialbatchCheck[ij]['liter'].toString()),
              weight: double.parse(serialbatchCheck[ij]['weight'].toString()),
            ));

            await DBOperation.updateStkSnap(db, stkSnpValues, ij);
          }
        }
      } else {
        List<Map<String, Object?>> serialbatchItemCheck =
            await DBOperation.itemmastercheckitemcode(
                db, getDB_StInBatch[i]['itemcode'].toString());

        // List<Map<String, Object?>> serialbatchItemCheck =     await DBOperation. cfoserialBatchCheck(db,getDB_StInBatch[i]['itemname'].toString())
        //  if( getDB_StInBatch[i]['serialBatch'].toString() != serialbatchCheck[ij]['serialbatch'].toString() && getDB_StInBatch[i]['itemcode'].toString() == serialbatchCheck[ij]['itemcode'].toString()){

        if (serialbatchItemCheck.isNotEmpty) {
          stkSnpValues.add(StockSnapTModelDB(
            uPackSize: serialbatchItemCheck[0]['UPackSize'] == null
                ? ''
                : serialbatchItemCheck[0]['UPackSize'].toString(),

            uTINSPERBOX: serialbatchItemCheck[0]['UTINSPERBOX'] != null
                ? int.parse(serialbatchItemCheck[0]['UTINSPERBOX'].toString())
                : 0,
            uSpecificGravity:
                serialbatchItemCheck[0]['USpecificGravity'].toString(),
            branch: AppConstant.branch,
            terminal: AppConstant.terminal.toString(),
            itemname: serialbatchItemCheck[0]['itemname_short'].toString(),
            branchcode: serialbatchItemCheck[0]['branchcode'].toString(),
            createdUserID: UserValues.userID,
            // int.parse(getDB_StInBatch[i]['createdUserID'].toString()),
            createdateTime: config.currentDate(),
            // getDB_StInBatch[i]['createdateTime'].toString(),
            itemcode: serialbatchItemCheck[0]['Itemcode'].toString(),
            lastupdateIp: UserValues.lastUpdateIp,
            maxdiscount: serialbatchItemCheck[0]['maxdiscount'].toString(),
            taxrate: serialbatchItemCheck[0]['taxrate'].toString(),
            mrpprice: serialbatchItemCheck[0]['mrpprice'].toString(),
            sellprice: serialbatchItemCheck[0]['sellprice'].toString(),
            purchasedate: serialbatchItemCheck[0]['purchasedate'].toString(),
            quantity: getDB_StInBatch[i]['quantity'].toString(),
            serialbatch: getDB_StInBatch[i]['serialBatch'].toString(),
            snapdatetime: serialbatchItemCheck[0]['snapdatetime'].toString(),
            specialprice: serialbatchItemCheck[0]['specialprice'].toString(),

            updatedDatetime: config.currentDate(),
            updateduserid: UserValues.userID,
            liter: serialbatchItemCheck[0]['liter'] != null
                ? double.parse(serialbatchItemCheck[0]['liter'].toString())
                : 0,
            weight: serialbatchItemCheck[0]['weight'] != null
                ? double.parse(serialbatchItemCheck[0]['weight'].toString())
                : 0,
            uPackSizeuom: serialbatchItemCheck[0]['UPackSizeUom'].toString(),
          ));
          await DBOperation.insertStockSnap(db, stkSnpValues);

          List<Map<String, Object?>> serialbatchCheck =
              await DBOperation.serialBatchCheck(
                  db,
                  stkSnpValues[0].serialbatch.toString(),
                  stkSnpValues[0].itemcode.toString());
        }
      }
    }
  }
}

updateRefund(AmqpMessage message) async {
  //print("JJJJJJJJJ");
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    //print("updateData: doc: " + updateData.DocEntry.toString());

    if (updateData.DocEntry == null) {
      await DBOperation.UpdtExcepSapDetSalHead(db, updateData.TransId!,
          updateData.ErrorMessage!.replaceAll("'", ""), 'RefundHeader');
    } else {
      await DBOperation.UpdtSapDetSalHead(db, updateData.DocEntry!,
          updateData.DocNumber!, updateData.TransId!, 'RefundHeader');
    }
  } catch (e) {
    //print("E: $e");
  }
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.isLogged, required this.isdonload});
  bool? isLogged;
  bool? isdonload;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return ChangeNotifierProvider(
    //     create: (_) => LocaleProvider(),
    //     builder: (context, child) {
    //       final localPd = Provider.of<LocaleProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => DashBoardController()),
        ChangeNotifierProvider(create: (_) => StockReqController()),
        ChangeNotifierProvider(create: (_) => StockInwrdController()),
        ChangeNotifierProvider(create: (_) => StockOutwardController()),
        ChangeNotifierProvider(create: (_) => ExpenseController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => DownLoadController()),
        ChangeNotifierProvider(create: (_) => DepositsController()),
        ChangeNotifierProvider(create: (_) => SalesQuotationCon()),
        ChangeNotifierProvider(create: (_) => SOCon()),
        ChangeNotifierProvider(create: (_) => PosController()),
        ChangeNotifierProvider(create: (_) => SalesReturnController()),
        ChangeNotifierProvider(create: (_) => PayreceiptController()),
        ChangeNotifierProvider(create: (_) => PendingOrderController()),
        ChangeNotifierProvider(create: (_) => PayreceiptController()),
        ChangeNotifierProvider(create: (_) => StRegCon()),
        ChangeNotifierProvider(create: (_) => CustomerController()),
        ChangeNotifierProvider(create: (_) => RetnRegCon()),
        ChangeNotifierProvider(create: (_) => CashStateCon()),
        ChangeNotifierProvider(create: (_) => ApiSettingsController()),
        ChangeNotifierProvider(create: (_) => StockReplenishController()),
        ChangeNotifierProvider(create: (_) => StockCheckController()),
        ChangeNotifierProvider(create: (_) => StockController()),
        ChangeNotifierProvider(create: (_) => NumberSeriesCtrl()),
        ChangeNotifierProvider(
          create: (_) => TransactionSyncController(),
        ),
        ChangeNotifierProvider(
            create: (_) => RefundController()), //RefundController
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: generateMaterialColor(Color(0xFF750537)),
          fontFamily: 'NunitoRegular',
        ),
        home: (widget.isLogged == null || widget.isLogged == false) &&
                (widget.isdonload == null || widget.isdonload == false)
            ? LoginScreen()
            : (widget.isLogged != null && widget.isLogged != false) &&
                    (widget.isdonload != null && widget.isdonload != false)
                ? DashBoardScreen()
                : DownloadScreen(),
        supportedLocales: L10n.all,
        getPages: Routes.allRoutes,
        // locale: localPd.locale,
        // localizationsDelegates: const [
        //   AppLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   // GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate, //192.198.182.1:5672
        // ],
      ),
    );
    // });
  }
}

//test
