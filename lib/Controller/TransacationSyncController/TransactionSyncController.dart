// ignore_for_file: unnecessary_new, non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Controller/DashBoardController/DashboardController.dart';
import 'package:posproject/Controller/ExpenseController/ExpenseController.dart';
import 'package:posproject/Controller/PaymentReceiptController/PayReceiptController.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Controller/SalesOrderController/SalesOrderController.dart';
import 'package:posproject/Controller/SalesQuotationController/SalesQuotationController.dart';
import 'package:posproject/Controller/SalesReturnController/SalesReturnController.dart';
import 'package:posproject/Controller/DepositController/DepositsController.dart';
import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import 'package:posproject/Controller/StockOutwardController/StockOutwardController.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';

class TransactionSyncController extends ChangeNotifier {
  Configure config = Configure();
  bool syncdataBool = false;
  List<SyncData> syncData1 = [];
  List<SyncData> filtersyncData1 = [];
  bool syncbool = false;
  bool loadingbtn = false;
  init() {
    clearDataAll();
    getDataMethod();
  }

  clearDataAll() {
    syncData1.clear();
    filtersyncData1.clear();
    syncdataBool = false;
    syncbool = false;
    loadingbtn = false;
  }

  getDataMethod() async {
    final Database db = (await DBHelper.getInstance())!;

    syncdataBool = true;
    syncData1.clear();

    List<Map<String, Object?>> getsyncedData =
        await DBOperation.getSynceData(db);
    if (getsyncedData.isNotEmpty) {
      for (int j = 0; j < getsyncedData.length; j++) {
        // log("getsyncedData UpdatedDatetime:::${getsyncedData[j]["UpdatedDatetime"].toString()}");

        syncData1.add(
          SyncData(
            basedocentry: getsyncedData[j]["basedocentry"].toString(),
            doctype: getsyncedData[j]["doctype"].toString(),
            DocNo: getsyncedData[j]["documentno"] == null
                ? "0"
                : getsyncedData[j]["documentno"].toString(),
            // itemname: getsyncedData[j]["itemname"].toString(),
            Docdate: getsyncedData[j]["createdateTime"].toString(),
            // qty: 1,
            sapDate: getsyncedData[j]["UpdatedDatetime"] == null
                ? ""
                : getsyncedData[j]["UpdatedDatetime"].toString(),
            customername: getsyncedData[j]["customername"].toString(),
            sapNo: getsyncedData[j]["sapDocNo"] == null
                ? 0
                : int.parse(
                    getsyncedData[j]["sapDocNo"].toString(),
                  ),
            sapStatus: getsyncedData[j]["qStatus"].toString(),
            sapDocentry: getsyncedData[j]["sapDocentry"] == null
                ? ""
                : getsyncedData[j]["sapDocentry"].toString(),
            reqfromwhs: getsyncedData[j]["reqfromWhs"].toString(),
            reqtowhs: getsyncedData[j]["reqtoWhs"].toString(),
            docentry: getsyncedData[j]["docentry"].toString(),
            editType: getsyncedData[j]["editType"].toString(),
          ),
        );
        notifyListeners();
      }
      filtersyncData1 = syncData1;
    } else {
      syncdataBool = false;
      notifyListeners();
    }
    notifyListeners();
  }

  filterListSearched(String v) {
    //y
    syncdataBool = false;
    if (v.isNotEmpty) {
      filtersyncData1 = syncData1
          .where((e) =>
              e.doctype!.toLowerCase().contains(v.toLowerCase()) ||
              e.customername!.toLowerCase().contains(v.toLowerCase()) ||
              e.sapStatus!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersyncData1 = syncData1;
      notifyListeners();
    }
  }

  refreshQueue22() async {
    loadingbtn = true;
    bool? netbool = await config.haveInterNet();
    if (netbool == true) {
      log("MMMMMMMMMMMMM");
      final Database db = (await DBHelper.getInstance())!;
      List<Map<String, Object?>> getQstatusData =
          await DBOperation.get_QstatusData33(db);

      if (getQstatusData.isNotEmpty) {
        for (int i = 0; i < getQstatusData.length; i++) {
          // log("getQstatusData sapDocentry::${getQstatusData[i]["sapDocNo"]}");
          if (getQstatusData[i]["doctype"].toString() == "Sales Invoice") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesHeader');
              notifyListeners();
            }
            //
          } else if (getQstatusData[i]["doctype"].toString() == "Sales Order") {
            // SOCon SalesOrder = new SOCon();

            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesOrderHeader');
              notifyListeners();
            }
            //
          } else if (getQstatusData[i]["sapDocentry"] != null &&
              getQstatusData[i]["doctype"].toString() == "Sales Quotation") {
            log("sales quo doc entry::${getQstatusData[i]["sapDocNo"]}");
            // SalesQuotationCon SalesQuot = new SalesQuotationCon();

            if (getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesQuotationHeader');

              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Sales Return") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesReturnHeader');
              notifyListeners();
            }
            //
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Payment Receipt") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'ReceiptHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Stock Request") {
            print("Stock Req");

            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'StockReqHDT');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Stock Outward") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'StockOutHeaderDataDB');
            }
//
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Stock Inward") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'StockInHeaderDB');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Expense") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'Expense');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Settlement") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.UpdtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'tableDepositHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Refund") {
            notifyListeners();
          }
        }
        notifyListeners();
      }
    }
    //  getDataMethod();
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      getDataMethod();
      loadingbtn = false;

      notifyListeners();
    });
    notifyListeners();
  }

  refreshQueue(SyncData? syncData2, BuildContext context) async {
    syncbool = true;
    bool? netbool = await config.haveInterNet();
    if (netbool == true) {
      final Database db = (await DBHelper.getInstance())!;

      if (syncData2!.doctype == "Sales Invoice") {
        PosController SalesInvoice = new PosController();
        SalesInvoice.pushRabitmqSales(int.parse(syncData2.docentry.toString()));

        print("sales invoice Docentry::${syncData2.sapDocentry}");
        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.UpdtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'SalesHeader');
          notifyListeners();
        }
        //
      } else if (syncData2.doctype == "Sales Order") {
        SOCon SalesOrder = new SOCon();
        if (syncData2.editType == "Edit") {
          SalesOrder.pushRabiMqSO3(int.parse(syncData2.docentry.toString()));
          if (syncData2.sapDocentry != null &&
              syncData2.sapDocentry!.isNotEmpty) {
            await DBOperation.UpdtSapDetSalHead(
                db,
                int.parse(syncData2.sapDocentry.toString()),
                int.parse(syncData2.sapNo.toString()),
                int.parse(syncData2.docentry.toString()),
                'SalesOrderHeader');
            notifyListeners();
          }
        } else {
          SalesOrder.pushRabiMqSO(int.parse(syncData2.docentry.toString()));
          if (syncData2.sapDocentry != null &&
              syncData2.sapDocentry!.isNotEmpty) {
            await DBOperation.UpdtSapDetSalHead(
                db,
                int.parse(syncData2.sapDocentry.toString()),
                int.parse(syncData2.sapNo.toString()),
                int.parse(syncData2.docentry.toString()),
                'SalesOrderHeader');
            notifyListeners();
          }
        }

        //
      } else if (syncData2.doctype == "Sales Quotation") {
        SalesQuotationCon SalesQuot = new SalesQuotationCon();
        if (syncData2.editType == "Edit") {
          SalesQuot.pushRabiMqSO3(int.parse(syncData2.docentry.toString()));
          if (syncData2.sapDocentry != null &&
              syncData2.sapDocentry!.isNotEmpty) {
            await DBOperation.UpdtSapDetSalHead(
                db,
                int.parse(syncData2.sapDocentry.toString()),
                int.parse(syncData2.sapNo.toString()),
                int.parse(syncData2.docentry.toString()),
                'SalesQuotationHeader');

            notifyListeners();
          }
        } else {
          SalesQuot.pushRabiMqSO(int.parse(syncData2.docentry.toString()));
          if (syncData2.sapDocentry != null &&
              syncData2.sapDocentry!.isNotEmpty) {
            await DBOperation.UpdtSapDetSalHead(
                db,
                int.parse(syncData2.sapDocentry.toString()),
                int.parse(syncData2.sapNo.toString()),
                int.parse(syncData2.docentry.toString()),
                'SalesQuotationHeader');

            notifyListeners();
          }
          print("sales Quatation Docentry::${syncData2.sapDocentry}");
        }
      } else if (syncData2.doctype == "Sales Return") {
        SalesReturnController SalesRet = new SalesReturnController();
        SalesRet.PostRabitMqSalesRet(int.parse(syncData2.docentry.toString()),
            syncData2.basedocentry.toString());
        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.UpdtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'SalesReturnHeader');
          notifyListeners();
        }
        //
      } else if (syncData2.doctype == "Payment Receipt") {
        PayreceiptController PayRecipt = new PayreceiptController();
        PayRecipt.postRabitMqPaymentReceipt(
            int.parse(syncData2.docentry.toString()));
        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.UpdtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'ReceiptHeader');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Stock Request") {
        StockReqController StockReq = new StockReqController();
        String? whsCode = await DBOperation.getStockReq_WhsCode(
            db, int.parse(syncData2.docentry.toString()));
        StockReq.PostRabitMqStockReq(
            int.parse(syncData2.docentry.toString()), whsCode.toString());

        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.UpdtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'StockReqHDT');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Stock Outward") {
        print("Stock Outward:::syncData2.docentry:::${syncData2.docentry}");
        StockOutwardController stOut = new StockOutwardController();
        List<Map<String, Object?>> getStOutDetails =
            await DBOperation.getRabitMqStOutDetails(
                db, syncData2.docentry.toString());
        // log("getQstatusDatabaseDocentry::${getQstatusData[i]["basedocentry"].toString()}");
        stOut.PostRabitMq(
            int.parse(syncData2.docentry.toString()),
            int.parse(getStOutDetails[0]["baseDocentry"].toString()),
            getStOutDetails[0]["reqfromWhs"].toString());
        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.UpdtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'StockOutHeaderDataDB');
        }
//
      } else if (syncData2.doctype == "Stock Inward") {
        StockInwrdController stIn = new StockInwrdController();
        List<Map<String, Object?>> getStInDetails =
            await DBOperation.getRabitMqStInDetails(
                db, int.parse(syncData2.docentry.toString()));
        stIn.PostRabitMq(
            int.parse(syncData2.docentry.toString()),
            int.parse(getStInDetails[0]['baseDocentry'].toString()),
            getStInDetails[0]['reqtoWhs'].toString());
        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.UpdtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'StockInHeaderDB');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Expense") {
        ExpenseController Expense = new ExpenseController();
        Expense.PostRabitMqExpense(int.parse(syncData2.docentry.toString()));
        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.UpdtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'Expense');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Settlement") {
        DepositsController Settle = new DepositsController();
        List<Map<String, Object?>> getDBSettlementHeader =
            await DBOperation.getDepositHeadDB(
                db, int.parse(syncData2.docentry.toString()));
        await Settle.PostRabitMqSettle(int.parse(syncData2.docentry.toString()),
            getDBSettlementHeader[0]['typedeposit'].toString());

        if (syncData2.sapDocentry != null &&
            syncData2.sapDocentry!.isNotEmpty) {
          await DBOperation.UpdtSapDetSalHead(
              db,
              int.parse(syncData2.sapDocentry.toString()),
              int.parse(syncData2.sapNo.toString()),
              int.parse(syncData2.docentry.toString()),
              'tableDepositHeader');
          notifyListeners();
        }
      } else if (syncData2.doctype == "Refund") {
        notifyListeners();
      }
      notifyListeners();
    }

    // await getDataMethod();
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      getDataMethod();
      notifyListeners();
    });
    syncbool = false;
    Navigator.pop(context);
    notifyListeners();
  }

  notifyListeners();
}

class stockCheckList {
  String? itemname;
  String? itemCode;
  String? serialbatch;
  String? branch;
  int? qty;
  stockCheckList({
    this.branch,
    this.itemCode,
    this.itemname,
    this.qty,
    this.serialbatch,
  });
}
