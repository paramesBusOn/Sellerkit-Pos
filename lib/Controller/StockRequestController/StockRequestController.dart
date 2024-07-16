// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, empty_constructor_bodies, unnecessary_new, non_constant_identifier_names, use_build_context_synchronously, unnecessary_import, unused_local_variable, unnecessary_null_comparison, prefer_if_null_operators, dead_code

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Models/DataModel/StockReqModel/branchModel.dart';
import 'package:posproject/Models/DataModel/StockReqModel/orderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Screen.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/ItemMaster.dart';
import '../../DBModel/StockReqLine.dart';
import '../../DBModel/StockRequestHD.dart';
import '../../Models/DataModel/StockReqModel/warehouseModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';
import '../../Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
import '../../Models/ServiceLayerModel/SAPStockRequest/SapStkRequestModel.dart';
import '../../Models/ServiceLayerModel/SAPStockRequest/StockReqPostringModel.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';
import '../../ServiceLayerAPIss/STockRequest/PostRequestAPI.dart';
import '../../Widgets/AlertBox.dart';
import '../../ServiceLayerAPIss/STockRequest/GetRequestAPI.dart';
import '../../ServiceLayerAPIss/STockRequest/RequestCancelAPI.dart';
import '../../ServiceLayerAPIss/STockRequest/RequestLoginnAPI.dart';
import '../../Service/StockSnapApi.dart';
import '../../Service/productMasterApi.dart';
import '../../Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';

class StockReqController extends ChangeNotifier {
  Configure config = Configure();
  //
  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  TextEditingController remarkscontroller = new TextEditingController();
  TextEditingController remarkscontroller2 = TextEditingController();

  List<TextEditingController> qtyCont =
      List.generate(500, (i) => TextEditingController());

  FocusNode inven = new FocusNode();
  String holddocentry = '';
  TextEditingController searchcon = TextEditingController();
  List<StocksnapModelData> scanneditemData = [];
  List<StocksnapModelData> get getScanneditemData => scanneditemData;
  List<StocksnapModelData> itemData = [];
  List<StocksnapModelData> get getitemData => itemData;
  bool? onclickDisable = false;
  List<StocksnapModelData> scanneditemData2 = [];
  List<StocksnapModelData> get getScanneditemData2 => scanneditemData2;
  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());
  List<WhsDetails> filsterwhsList = [];
  List<WhsDetails> whsList = [];
  String sapDocentry = '';
  String sapDocuNumber = '';
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  bool cancelbtn = false;
  String? seriesValue;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  List<ErrorModel> sererrorlist = [];
  List<StockTransferReqLine> sapReaqModelData = [];

  // StockReqController() {
  //   callList();
  //   callDB();
  // }

  void init() {
    searchclear();
    callList();
    callDB();
  }

  // List<WhsDetails> filsterwhsList = [];
  WhsDetails? fromAddressList;
  WhsDetails? get getFromAddressList => fromAddressList;
  WhsDetails? fromAddressList2;
  WhsDetails? get getFromAddressList2 => fromAddressList2;

  callDB() async {
    final Database db = (await DBHelper.getInstance())!;
    await getValues(db);
    await getHoldStReq(db);
    //
    //  final Database db = (await DBHelper.getInstance())!;
    // List<Map<String, Object?>> getDB_SaleReqHeader =
    //     await DBOperation.getStockHDReq2(db,1000000);
    // List<Map<String, Object?>> getDB_SaleReqLine =
    //     await DBOperation.getStockLReqHold(db, 1000000);
    // String salesReqHeader = json.encode(getDB_SaleReqHeader);
    // String salesReqLine = json.encode(getDB_SaleReqLine);

    // var ddd = json.encode({
    //   "ObjectType": 4,
    //   "ActionType": "Add",
    //   "StockRequestHeader": salesReqHeader,
    //   "StockRequestLine": salesReqLine,
    // });
    // log("payload : $ddd");
  }

  Future getHoldStReq(Database db) async {
    holddocentry = '';
    savedraftBill = [];
    WhsselectedList = null;
    // whsList = [];
    List<Map<String, Object?>> holdDataHD =
        await DBOperation.getStockHDReqHold(db);

    WhsDetails? whsDet;

    for (int i = 0; i < holdDataHD.length; i++) {
      List<StocksnapModelData> scannData = [];

      List<Map<String, Object?>> branchdata = await DBOperation.getBrnachbyCode(
          db, holdDataHD[i]['reqtoWhs'].toString());
      List<Map<String, Object?>> holdDataLn =
          await DBOperation.getStockLReqHold(
              db, int.parse(holdDataHD[i]['docentry'].toString()));

      for (int j = 0; j < branchdata.length; j++) {
        WhsDetails whs = WhsDetails(
            dbDocEntry: int.parse(holdDataHD[i]['docentry'].toString()),
            whsName: branchdata[j]['WhsName'].toString(),
            whsCode: branchdata[j]['WhsCode'].toString(),
            whsmailID: branchdata[j]['E_Mail'].toString(),
            whsPhoNo: '',
            whsGst: branchdata[j]['GSTNo'].toString(),
            whsAddress: branchdata[j]['Address1'].toString(),
            whsDistric: branchdata[j]['DisAcct1'].toString(),
            pinCode: branchdata[j]['Pincode'].toString(),
            whsState: branchdata[j]['StateCode'].toString(),
            whsCity: branchdata[j]['City'].toString(),
            createdateTime: holdDataHD[i]['createdateTime'].toString());
        whsDet = whs;
      }

      for (int k = 0; k < holdDataLn.length; k++) {
        if (holdDataLn[k]['docentry'].toString() ==
            holdDataHD[i]['docentry'].toString()) {
          scannData.add(StocksnapModelData(
            TransID: int.parse(holdDataLn[k]['docentry'].toString()),
            Branch: holdDataLn[k][''].toString(),
            ItemCode: holdDataLn[k]['itemcode'].toString(),
            ItemName: holdDataLn[k]['dscription'].toString(),
            SerialBatch: holdDataLn[k]['serialBatch'].toString(),
            OpenQty: int.parse(holdDataLn[k]['quantity'] == null
                ? '0'
                : holdDataLn[k]['quantity'].toString()),
            Qty: int.parse(holdDataLn[k]['quantity'] == null
                ? '0'
                : holdDataLn[k]['quantity'].toString()),
            InDate: holdDataLn[k][''].toString(),
            InType: holdDataLn[k][''].toString(),
            VenCode: holdDataLn[k][''].toString(),
            VenName: holdDataLn[k][''].toString(),
            MRP: 0, // int.parse( holdDataLn[k][''].toString()),
            SellPrice: double.parse(holdDataLn[k]['price'] == null
                ? '0'
                : holdDataLn[k]['price'].toString()),
            Cost: 0, // int.parse(holdDataLn[k][''].toString()),
            TaxRate: double.parse(holdDataLn[k]['taxRate'] == null
                ? '0'
                : holdDataLn[k]['taxRate'].toString()),
            TaxType: holdDataLn[k]['taxType'].toString(),
            Maxdiscount: '',
            liter: holdDataLn[k]['liter'] == null
                ? 0.0
                : double.parse(holdDataLn[k]['liter'].toString()),
            weight: holdDataLn[k]['weight'] == null
                ? 0.0
                : double.parse(holdDataLn[k]['weight'].toString()),
          ));
        }
      }
      savedraftBill.add(Orderdetails(
          whsAdd: whsDet,
          orderType: "Hold",
          scannData: scannData,
          remarks: holdDataHD[i]['remarks'].toString()));
    }

    await calculateDetails();

    notifyListeners();
  }

  filterList(String v) {
    log(whsList.length.toString());
    if (v.isNotEmpty) {
      filsterwhsList = whsList
          .where((e) =>
              e.whsCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.whsName!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filsterwhsList = whsList;
      notifyListeners();
    }
  }

  filterbranchList(String v) {
    // if (v.isNotEmpty) {
    //   filterShipAddressList = shipAddressList
    //       .where((e) =>
    //           e.billAddress!.toLowerCase().contains(v.toLowerCase()) ||
    //           e.billCity!.toLowerCase().contains(v.toLowerCase()))
    //       .toList();
    //   notifyListeners();
    // } else if (v.isEmpty) {
    //   filterShipAddressList = shipAddressList;
    //   notifyListeners();
    // }
  }

  WhsDetails? WhsselectedList;
  WhsDetails? get get_WhsselectedList => WhsselectedList;
  WhsSelected(WhsDetails whsDetails, BuildContext context) {
    WhsDetails WhsselectedList2 = WhsDetails(
        whsName: whsDetails.whsName,
        whsCode: whsDetails.whsCode,
        whsPhoNo: whsDetails.whsPhoNo,
        whsmailID: whsDetails.whsmailID,
        whsGst: whsDetails.whsGst,
        whsAddress: whsDetails.whsAddress,
        whsDistric: whsDetails.whsDistric,
        pinCode: whsDetails.pinCode,
        whsState: whsDetails.whsState,
        whsCity: whsDetails.whsCity);
    WhsselectedList = WhsselectedList2;
    notifyListeners();
  }

  branchSelected(ShipAddress branchDetails, BuildContext context) {
    ShipAddress ShipSelectedList2 = ShipAddress(
        billAddress: branchDetails.billAddress,
        billCity: branchDetails.billCity,
        billCountry: branchDetails.billCountry,
        billPincode: branchDetails.billPincode,
        billstate: branchDetails.billstate);
    ShipSelectedList = ShipSelectedList2;
    notifyListeners();
  }

  callList() {
    filsterwhsList = whsList;
    // filterShipAddressList =
    // shipAddressList;
    notifyListeners();
  }

  clearData() {
    WhsselectedList = null;
    notifyListeners();
  }

  List<searchModel> searchData = [];
  List<searchModel> filtersearchData = [];
  bool searchbool = false;
  searchInitMethod() {
    mycontroller[100].text = config.alignDate(config.currentDate());
    mycontroller[101].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  filterContactList(String v) {
    if (v.isNotEmpty) {
      filtersearchData = searchData
          .where((e) =>
              e.customeraName.toLowerCase().contains(v.toLowerCase()) ||
              e.docNo.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersearchData = searchData;
      notifyListeners();
    }
  }

  getDate2(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (pickedDate != null && datetype == "From") {
      print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[100].text = datetype!;
      print(datetype);
    } else if (pickedDate != null && datetype == "To") {
      print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[101].text = datetype!;
      print(datetype);
    } else {
      print("Date is not selected");
    }
  }

  WhsDetails? WhsselectedList2;
  WhsDetails? get get_WhsselectedList2 => WhsselectedList2;
  double? totwieght = 0.0;
  double? totLiter = 0.0;

  fixDataMethod(int docentry) async {
    sapDocentry = '';
    sapDocuNumber = '';
    final Database db = (await DBHelper.getInstance())!;
    scanneditemData2.clear();
    WhsselectedList2 = null;
    totwieght = 0.0;
    totLiter = 0.0;
    remarkscontroller2.text = "";
    fromAddressList2 = null;
    List<Map<String, Object?>> getDB_SaleReqHeader2 =
        await DBOperation.getStockHDReq(db, docentry);
    List<Map<String, Object?>> getDB_SaleReqLine2 =
//sapDocentry
        await DBOperation.getStockLReqHold(db, docentry);
    if (getDB_SaleReqHeader2.isNotEmpty) {
      print(
          "getDB_SaleReqHeader sapDocentry::${getDB_SaleReqHeader2[0]["sapDocentry"]} ");
      sapDocentry = getDB_SaleReqHeader2[0]["sapDocentry"] != null
          ? getDB_SaleReqHeader2[0]["sapDocentry"].toString()
          : '';
      sapDocuNumber = getDB_SaleReqHeader2[0]["sapDocNo"] != null
          ? getDB_SaleReqHeader2[0]["sapDocNo"].toString()
          : '';

      remarkscontroller2.text = getDB_SaleReqHeader2[0]["remarks"].toString();
      totwieght =
          double.parse(getDB_SaleReqHeader2[0]["totalweight"].toString());
      totLiter = double.parse(getDB_SaleReqHeader2[0]["totalltr"].toString());

      for (int i = 0; i < getDB_SaleReqLine2.length; i++) {
        scanneditemData2.add(StocksnapModelData(
          Maxdiscount: "",
          Branch: "",
          ItemCode: getDB_SaleReqLine2[i]["itemcode"].toString(),
          ItemName: getDB_SaleReqLine2[i]["dscription"].toString(),
          SerialBatch: getDB_SaleReqLine2[i]["serialBatch"].toString(),
          Qty: int.parse(getDB_SaleReqLine2[i]["quantity"].toString()),
          MRP: 0.0,
          SellPrice: double.parse(getDB_SaleReqLine2[i]["price"].toString()),
          TaxRate: 0.0,
          liter: getDB_SaleReqLine2[i]['liter'] == null
              ? 0.0
              : double.parse(getDB_SaleReqLine2[i]['liter'].toString()),
          weight: getDB_SaleReqLine2[i]['weight'] == null
              ? 0.0
              : double.parse(getDB_SaleReqLine2[i]['weight'].toString()),
        ));
      }

      List<Map<String, Object?>> branchData = await DBOperation.getBranch(db);
      for (int i = 0; i < branchData.length; i++) {
        // log("--------------------------------" +
        //     getDB_SaleReqHeader2[0]["reqtoWhs"].toString());
        // log("--------------------------------" +
        // branchData[i]['WhsCode'].toString());

        if (getDB_SaleReqHeader2[0]["reqtoWhs"].toString() ==
            branchData[i]['WhsCode'].toString()) {
          WhsselectedList2 = WhsDetails(
              whsName: branchData[i]['WhsName'].toString(),
              whsCode: branchData[i]['WhsCode'].toString(),
              whsmailID: branchData[i]['E_Mail'].toString(),
              whsPhoNo: '',
              whsGst: branchData[i]['GSTNo'].toString(),
              whsAddress: branchData[i]['Address1'].toString(),
              whsDistric: branchData[i]['DisAcct1'].toString(),
              pinCode: branchData[i]['Pincode'].toString(),
              whsState: branchData[i]['StateCode'].toString(),
              whsCity: branchData[i]['City'].toString());
        }

        if (UserValues.branch == branchData[i]['WhsCode'].toString()) {
          WhsDetails WhsselectedList3 = WhsDetails(
              whsName: branchData[i]['WhsName'].toString(),
              whsCode: branchData[i]['WhsCode'].toString(),
              whsmailID: branchData[i]['E_Mail'].toString(),
              whsPhoNo: '',
              whsGst: branchData[i]['GSTNo'].toString(),
              whsAddress: branchData[i]['Address1'].toString(),
              whsDistric: branchData[i]['DisAcct1'].toString(),
              pinCode: branchData[i]['Pincode'].toString(),
              whsState: branchData[i]['StateCode'].toString(),
              whsCity: branchData[i]['City'].toString());
          fromAddressList2 = WhsselectedList3;
        }
      }
    } else if (getDB_SaleReqHeader2.isEmpty) {
      scanneditemData2.clear();
    }
    notifyListeners();
  }

  getSalesDataDatewise(String fromdate, String todate) async {
    log(fromdate);
    log(todate);

    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getStockReqHeader =
        await DBOperation.getStockReqHeaderDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();
    filtersearchData.clear();

    if (getStockReqHeader.isNotEmpty) {
      for (int i = 0; i < getStockReqHeader.length; i++) {
   //log("getStockReqHeader.documentno:" +
            // getStockReqHeader[i]["documentno"].toString());
        searchdata2.add(searchModel(
            username: UserValues.username,
            terminal: AppConstant.terminal,
            type: getStockReqHeader[i]["docstatus"] == null
                ? ""
                : getStockReqHeader[i]["docstatus"].toString() == "2"
                    ? "Against Order"
                    : getStockReqHeader[i]["docstatus"].toString() == "2"
                        ? "Against Stock"
                        : "",
            // sapDocNo: getStockReqHeader[i]["sapDocNo"] == null
            //     ? 0
            //     : int.parse(getStockReqHeader[i]["sapDocNo"].toString()),
            qStatus: getStockReqHeader[i]["qStatus"] == null
                ? ""
                : getStockReqHeader[i]["qStatus"].toString(),
            docentry: getStockReqHeader[i]["docentry"] == null
                ? 0
                : int.parse(getStockReqHeader[i]["docentry"].toString()),
            docNo: getStockReqHeader[i]["documentno"] == null
                ? "0"
                : getStockReqHeader[i]["documentno"].toString(), //documentno
            //  getStockReqHeader[i]["reqdocno"] == null
            //     ? "0"
            //     : getStockReqHeader[i]["reqdocno"].toString(),
            docDate: getStockReqHeader[i]["createdateTime"].toString(),
            sapNo: getStockReqHeader[i]["sapDocNo"] == null
                ? 0
                : int.parse(getStockReqHeader[i]["sapDocNo"].toString()),
            sapDate: getStockReqHeader[i]["createdateTime"] == null
                ? ""
                : getStockReqHeader[i]["createdateTime"].toString(),
            customeraName: getStockReqHeader[i]["reqtoWhs"].toString(),
            doctotal: getStockReqHeader[i][""] == null
                ? 0
                : double.parse(getStockReqHeader[i][""].toString())));
        notifyListeners();
      }
      searchData.addAll(searchdata2);
      filtersearchData = searchData;
    } else {
      searchbool = false;
      searchData.clear();
      notifyListeners();
    }
    notifyListeners();
  }

  clickcancelbtn(BuildContext context, ThemeData theme) async {
    if (sapDocentry.isNotEmpty) {
      await sapLoginApi(context);
      await callSerlaySalesQuoAPI(context, theme);
      await callSerlaySalesCancelQuoAPI(context, theme);
      notifyListeners();
    } else {
 //log("BBBBBBBBBBBBBBBBBBBBBB");
      cancelbtn = false;
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Something went Wrong',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        sapDocentry = '';
        sapDocuNumber = '';
        scanneditemData2 = [];
        fromAddressList2 = null;
        totwieght = null;
        WhsselectedList2 = null;
        totLiter = null;
        searchclear();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  sapLoginApi(BuildContext context) async {
    final pref2 = await pref;

    await PostRequestLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          print("sessionID: " + value.sessionId.toString());
          await getSession();
        }
      } else if (value.stCode! >= 400 && value.stCode! <= 410) {
        if (value.error!.code != null) {
          loadingscrn = false;
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: Screens.bodyheight(context) * 0.3,
            ),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
            content: Text(
              "${value.error!.message!.value}\nCheck Your Sap Details !!..",
              style: const TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(const Duration(seconds: 5), () {
            exit(0);
          });
        }
      } else if (value.stCode == 500) {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.bodyheight(context) * 0.3,
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: const Text(
            "Opps Somthing went wrong !!..",
            style: TextStyle(color: Colors.white),
          ),
        );
      } else {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.bodyheight(context) * 0.3,
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: const Text(
            "Opps Somthing went wrong !!..",
            style: TextStyle(color: Colors.white),
          ),
        );
      }
    });
  }

  getSession() async {
    var preff = await SharedPreferences.getInstance();
    AppConstant.sapSessionID = preff.getString('sessionId')!;
    log("  AppConstant.sapSessionID::${AppConstant.sapSessionID}");
  }

  callSerlaySalesQuoAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    // List<Map<String, Object?>> getqstatusdata =
    //     await DBOperation.getSaleQuorQstatusDB(db);

    log("sapDocentrysapDocentrysapDocentry:::$sapDocentry");

    await SerlayStkRequestAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.stockTransferReqLines.isNotEmpty) {
          sapReaqModelData = value.stockTransferReqLines;

     //log("sapInvocieModelDatasapInvocieModelData::${sapReaqModelData[0].lineStatus}");

          custserieserrormsg = '';
          notifyListeners();
        } else {
     //log("Error11");

          // custserieserrormsg = value.message!.toString();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
   //log("Error22");
        custserieserrormsg = value.error!.message!.value.toString();
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Success',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: value.error!.message!.value.toString(),
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          sapDocentry = '';
          sapDocuNumber = '';
          scanneditemData2 = [];
          fromAddressList2 = null;
          WhsselectedList2 = null;
          totwieght = null;
          totLiter = null;
          notifyListeners();
        });
        notifyListeners();

        custserieserrormsg = '';
   //log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
      } else {
   //log("Error33");

        // custserieserrormsg = value.message!.toString();
      }
    });
  }

  callSerlaySalesCancelQuoAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    if (sapReaqModelData.isNotEmpty) {
      for (int i = 0; i < sapReaqModelData.length; i++) {
        if (sapReaqModelData[i].lineStatus == "bost_Open") {
          await SerlayRequestCancelAPI.getData(sapDocentry.toString())
              .then((value) async {
            if (value.statusCode! >= 200 && value.statusCode! <= 204) {
              cancelbtn = false;
         //log("SapSaleOrderModelDataSapSaleOrderModelData::${sapReaqModelData[0].lineStatus}");
              await DBOperation.updateStkReqclosedocsts(
                  db, sapDocentry.toString());

              await Get.defaultDialog(
                      title: "Success",
                      middleText: 'Document is successfully cancelled ..!!',
                      backgroundColor: Colors.white,
                      titleStyle: TextStyle(color: Colors.red),
                      middleTextStyle: TextStyle(color: Colors.black),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text("Close"),
                              onPressed: () => Get.back(),
                            ),
                          ],
                        ),
                      ],
                      radius: 5)
                  .then((value) {
                sapDocentry = '';
                sapDocuNumber = '';
                scanneditemData2 = [];
                fromAddressList2 = null;
                WhsselectedList2 = null;
                totwieght = null;
                totLiter = null;
                notifyListeners();
              });
              custserieserrormsg = '';
              // }
              //  else {
              //   log("Error11");

              //   // custserieserrormsg = value.message!.toString();
              // }
            } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
              cancelbtn = false;
              custserieserrormsg = value.exception!.message!.value.toString();

              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        contentPadding: const EdgeInsets.all(0),
                        content: AlertBox(
                          payMent: 'Alert',
                          errormsg: true,
                          widget: Center(
                              child: ContentContainer(
                            content: '$custserieserrormsg',
                            theme: theme,
                          )),
                          buttonName: null,
                        ));
                  }).then((value) {
                sapDocentry = '';
                WhsselectedList2 = null;
                sapDocuNumber = '';
                scanneditemData2 = [];
                fromAddressList2 = null;
                totwieght = null;
                WhsselectedList2 = null;
                totLiter = null;
                notifyListeners();
              });
         //log("Error22:;$custserieserrormsg");

              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        contentPadding: const EdgeInsets.all(0),
                        content: AlertBox(
                          payMent: 'Alert',
                          errormsg: true,
                          widget: Center(
                              child: ContentContainer(
                            content: '$custserieserrormsg',
                            theme: theme,
                          )),
                          buttonName: null,
                        ));
                  }).then((value) {
                sapDocentry = '';
                WhsselectedList2 = null;
                sapDocuNumber = '';
                scanneditemData2 = [];
                fromAddressList2 = null;
                totwieght = null;
                WhsselectedList2 = null;
                totLiter = null;
                notifyListeners();
              });
         //log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
            } else {
         //log("Error33");

              // custserieserrormsg = value.message!.toString();
            }
          });
        } else if (sapReaqModelData[i].lineStatus == "bost_Close") {
          //:bost_Close
          cancelbtn = false;
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    content: AlertBox(
                      payMent: 'Alert',
                      errormsg: true,
                      widget: Center(
                          child: ContentContainer(
                        content: 'Document is already closed..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            sapDocentry = '';
            sapDocuNumber = '';
            WhsselectedList2 = null;
            scanneditemData2 = [];
            fromAddressList2 = null;
            totwieght = null;
            totLiter = null;
            notifyListeners();
          });
          notifyListeners();
        }
      }
    }
  }
  // callSerlaySalesCancelQuoAPI(BuildContext context, ThemeData theme) async {
  //   int? ressCode = 500;

  //   try {
  ////log("http://102.69.167.106:50001/b1s/v1/InventoryTransferRequests($sapDocentry)/Cancel");
  //     final response = await http.post(
  //       Uri.parse(URL.sapUrl + '/InventoryTransferRequests(${sapDocentry})/Cancel'),
  //       headers: {
  //         "content-type": "application/json",
  //         "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
  //       },
  //     );
  //     ressCode = response.statusCode;
  ////log("Invoice stscode::${response.statusCode}");

  //     if (response.statusCode == 204) {
  //  //log("Successfully Cancelled");
  //       showDialog(
  //           context: context,
  //           barrierDismissible: true,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //                 contentPadding: EdgeInsets.all(0),
  //                 content: AlertBox(
  //                   payMent: 'Alert',
  //                   errormsg: true,
  //                   widget: Center(
  //                       child: ContentContainer(
  //                     content: 'Document is closed successfully..!!',
  //                     theme: theme,
  //                   )),
  //                   buttonName: null,
  //                 ));
  //           }).then((value) {
  //         sapDocentry = '';
  //         sapDocuNumber = '';
  //       });
  //       // return Cancelmodel.fromJson(
  //       //     json.decode(response.body), response.statusCode);
  //     } else {
  //       print("Invoicecancel Exception: Error");

  //       showDialog(
  //           context: context,
  //           barrierDismissible: true,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //                 contentPadding: EdgeInsets.all(0),
  //                 content: AlertBox(
  //                   payMent: 'Alert',
  //                   errormsg: true,
  //                   widget: Center(
  //                       child: ContentContainer(
  //                     content: 'Document is already closed',
  //                     theme: theme,
  //                   )),
  //                   buttonName: null,
  //                 ));
  //           }).then((value) {
  //         sapDocentry = '';
  //         sapDocuNumber = '';
  //       });
  //       notifyListeners();
  //       // throw Exception("Error");
  //       // return Servicrlayerquotation.issue(
  //       //     json.decode(response.body), response.statusCode);
  //     }
  //   } catch (e) {
  ////log("Exception:: $e");
  //     // throw Exception("Error");
  //     // return AccountBalanceModel.exception(e.toString(), ressCode);

  //   }
  // }

  // List<WhsDetails> whsList2 = [
  //   WhsDetails(
  //       whsName: "Dodfg",
  //       whsCode: "Dodfg",
  //       whsPhoNo: "1234567890",
  //       whsmailID: "jcoretails@gmail.com",
  //       whsGst: "A43216T8B01PP45",
  //       whsAddress: "JcoRetails,Devarajan Layouts,Ram Nagar",
  //       whsDistric: "Coimbatore",
  //       pinCode: "620002",
  //       whsState: "TamilNadu",
  //       whsCity: "Coimbatore"),
  //   WhsDetails(
  //       whsName: "Hofg",
  //       whsCode: "Hofg",
  //       whsPhoNo: "9876543210",
  //       whsmailID: "tvcelctronics@gmail.com",
  //       whsGst: "B43216C8B01CC45",
  //       whsAddress: "Tvc Electronics,RRR Complex,KK Nagar",
  //       whsDistric: "Chennai",
  //       pinCode: "600028",
  //       whsState: "TamilNadu",
  //       whsCity: "Chennai"),
  // ];

  // Future insertWarHos(Database db) async {
  //   List<BranchTModelDB> valBranch = [];

  //   for (int i = 0; i < whsList2.length; i++) {
  //     valBranch.add(BranchTModelDB(
  //         address1: whsList2[i].whsAddress,
  //         address2: whsList2[i].whsAddress,
  //         address3: whsList2[i].whsAddress,
  //         branchID: whsList2[i].whsCode,
  //         branchname: whsList2[i].whsName,
  //         businessname: "",
  //         city: whsList2[i].whsCity!,
  //         countrycode: "IN",
  //         createdUserID: UserValues.userID,
  //         createdateTime: config.currentDate(),
  //         emalid: whsList2[i].whsmailID,
  //         geolocation1: '',
  //         geolocation2: '',
  //         httplogo: '',
  //         lastupdateIp: UserValues.userID.toString(),
  //         phoneno1: whsList2[i].whsPhoNo,
  //         phoneno2: whsList2[i].whsPhoNo,
  //         stateCode: whsList2[i].whsState,
  //         status: "Active",
  //         taxno: whsList2[i].whsGst,
  //         updatedDatetime: config.currentDate(),
  //         updateduserid: UserValues.userID,
  //         defaultcurrency: ""));
  //   }
  //   await DBOperation.insertBranch(db, valBranch);

  //   await getValues(db).then((value) {
  //     callList();
  //   });
  // }

  Future getValues(Database db) async {
    filsterwhsList = [];
    whsList = [];
    List<Map<String, Object?>> branchData = await DBOperation.getBranch(db);
    for (int i = 0; i < branchData.length; i++) {
      if (UserValues.branch != branchData[i]['WhsCode'].toString()) {
        whsList.add(WhsDetails(
            whsName: branchData[i]['WhsName'].toString(),
            whsCode: branchData[i]['WhsCode'].toString(),
            whsmailID: branchData[i]['E_Mail'].toString(),
            whsPhoNo: '',
            whsGst: branchData[i]['GSTNo'].toString(),
            whsAddress: branchData[i]['Address1'].toString(),
            whsDistric: branchData[i]['DisAcct1'].toString(),
            pinCode: branchData[i]['Pincode'].toString(),
            whsState: branchData[i]['StateCode'].toString(),
            whsCity: branchData[i]['City'].toString()));
      } else {
        WhsDetails WhsselectedList3 = WhsDetails(
            whsName: branchData[i]['WhsName'].toString(),
            whsCode: branchData[i]['WhsCode'].toString(),
            whsmailID: branchData[i]['E_Mail'].toString(),
            whsPhoNo: '',
            whsGst: branchData[i]['GSTNo'].toString(),
            whsAddress: branchData[i]['Address1'].toString(),
            whsDistric: branchData[i]['DisAcct1'].toString(),
            pinCode: branchData[i]['Pincode'].toString(),
            whsState: branchData[i]['StateCode'].toString(),
            whsCity: branchData[i]['City'].toString());
        fromAddressList = WhsselectedList3;
      }
    }
    filsterwhsList = whsList;
    notifyListeners();
  }

  ShipAddress? ShipSelectedList;
  ShipAddress? get get_ShipSelectedList => ShipSelectedList;
  List<ShipAddress> filterShipAddressList = [];
  // List<ShipAddress> shipAddressList = [
  //   ShipAddress(
  //       billAddress: "Jco Retails,West Street,T nagar,",
  //       billCity: "Chennai",
  //       billCountry: "IND",
  //       billPincode: "620008",
  //       billstate: "Tamil Nadu"),
  //   ShipAddress(
  //       billAddress: "TVC Electronics,Saibaba Street,KK nagar,",
  //       billCity: "Trichy",
  //       billCountry: "IND",
  //       billPincode: "620006",
  //       billstate: "Tamil Nadu")
  // ];

  String exception = '';
  getAllData() async {
    StockSnapModelApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.stocksnapitemdata != null) {
          itemData = value.stocksnapitemdata!;
          // dbHelper.insertPos(itemData).then((value) {
          //   print("came here..!!");
          // });
        } else if (value.stocksnapitemdata == null) {
          exception = value.message!;
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        exception = value.exception!;
      } else {
        exception = value.exception!;
      }
    });
  }

  /// list searched data to choose
  List<ItemMasterModelDB> getSearchedData = [];
  List<ItemMasterModelDB> getfilterSearchedData = [];

  List<ItemMasterModelDB> getAllSelect = [];

  Future<List<ItemMasterModelDB>> getAllList(String data) async {
    final Database db = (await DBHelper.getInstance())!;
    getSearchedData = await DBOperation.getSearchedStockList(db, data);
    getfilterSearchedData = getSearchedData;
    return getSearchedData;
  }

  filterListSearched(String v) {
    if (v.isNotEmpty) {
      getfilterSearchedData = getSearchedData
          .where((e) =>
              e.itemcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemnameshort!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      getfilterSearchedData = getSearchedData;
      notifyListeners();
    }
  }

  bool? loadLastSoldItemsbool = false;
  String? loadLastSoldItemsmsg = "";
  loadLastSoldItemsData(ThemeData theme) async {
    if (
        // ShipSelectedList == null &&
        WhsselectedList == null && scanneditemData.isEmpty) {
      Get.defaultDialog(
              // content: Container(
              //   width: Screens.width(context) * 0.4,
              //   height: Screens.bodyheight(context) * 0.1,
              // ),
              title: "Alert",
              middleText: "Choose WareHouse details..!!",
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text("Close"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ],
              radius: 5)
          .then((value) {
        onclickDisable = false;
        notifyListeners();
      });
    } else {
      loadLastSoldItemsbool = true;
      loadLastSoldItemsmsg = "";
      scanneditemData.clear();
      final Database db = (await DBHelper.getInstance())!;

      List<Map<String, Object?>> getShelfReqData =
          await DBOperation.getLastdaySoldData(db);
      if (getShelfReqData.isNotEmpty) {
        loadLastSoldItemsbool = false;
        loadLastSoldItemsmsg = "";
        for (int i = 0; i < getShelfReqData.length; i++) {
          scanneditemData.add(StocksnapModelData(
              TransID: 1,
              //  int.parse(selectdata.transentry != null
              //     ? selectdata.transentry.toString()
              //     : '0')

              Branch: "", //selectdata.branchcode,
              ItemCode: getShelfReqData[i]["itemcode"].toString(),
              ItemName: getShelfReqData[i]["itemname"].toString(),
              SerialBatch: getShelfReqData[i]["serialbatch"].toString(),
              OpenQty: 1, //int.parse(selectdata.quantity!),
              Qty: getShelfReqData[i]["quantity"] == null
                  ? 0
                  : int.parse(getShelfReqData[i]["quantity"]
                      .toString()), //int.parse(selectdata.quantity!),
              InDate: '',
              InType: '',
              VenCode: '',
              VenName: '',
              MRP: 0,
              SellPrice: 0.0, //double.parse(selectdata.sellprice!),
              Cost: 0,
              TaxRate: 0,
              TaxType: '',
              Maxdiscount: '',
              liter: getShelfReqData[i]["totalltr"] == null
                  ? 0.0
                  : double.parse(getShelfReqData[i]["totalltr"].toString()),
              weight: getShelfReqData[i]["totalweight"] == null
                  ? 0
                  : double.parse(
                      getShelfReqData[i]["totalweight"].toString())));
          qtyCont[scanneditemData.length - 1].text =
              getShelfReqData[i]["quantity"] == null
                  ? "0"
                  : getShelfReqData[i]["quantity"].toString();
        }

        notifyListeners();
        calculateDetails();
      } else {
        scanneditemData = [];
        loadLastSoldItemsmsg = "Does Not Have No data..!!";
        notifyListeners();
      }
      Future.delayed(const Duration(seconds: 5), () {
        loadLastSoldItemsbool = false;
        loadLastSoldItemsmsg = "";
        notifyListeners();
      });
      notifyListeners();
    }
  }

  bool? loadMiniMaxbool = false;
  String? loadMiniMaxmsg = "";
  loadMiniMaxData(ThemeData theme) async {
    if (
        // ShipSelectedList == null &&
        WhsselectedList == null && scanneditemData.isEmpty) {
      Get.defaultDialog(
              // content: Container(
              //   width: Screens.width(context) * 0.4,
              //   height: Screens.bodyheight(context) * 0.1,
              // ),
              title: "Alert",
              middleText: "Choose WareHouse details..!!",
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text("Close"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ],
              radius: 5)
          .then((value) {
        onclickDisable = false;
        notifyListeners();
      });
    } else {
      loadMiniMaxbool = true;
      loadMiniMaxmsg = "";
      scanneditemData.clear();
      final Database db = (await DBHelper.getInstance())!;

      List<Map<String, Object?>> getShelfReqData =
          await DBOperation.getoutofDataData(db);
      if (getShelfReqData.isNotEmpty) {
        loadMiniMaxbool = false;
        loadMiniMaxmsg = "";
        for (int i = 0; i < getShelfReqData.length; i++) {
          if (getShelfReqData[i]["shortageQty"] != 0) {
            scanneditemData.add(StocksnapModelData(
                TransID: 1,
                //  int.parse(selectdata.transentry != null
                //     ? selectdata.transentry.toString()
                //     : '0')

                Branch: "", //selectdata.branchcode,
                ItemCode: getShelfReqData[i]["Itemcode"].toString(),
                ItemName: getShelfReqData[i]["itemname_short"].toString(),
                SerialBatch: getShelfReqData[i]["serialbatch"].toString(),
                OpenQty: 1, //int.parse(selectdata.quantity!),
                Qty: getShelfReqData[i]["shortageQty"] == null
                    ? 0
                    : int.parse(getShelfReqData[i]["shortageQty"]
                        .toString()), //int.parse(selectdata.quantity!),
                InDate: '',
                InType: '',
                VenCode: '',
                VenName: '',
                MRP: 0,
                SellPrice: 0.0, //double.parse(selectdata.sellprice!),
                Cost: 0,
                TaxRate: 0,
                TaxType: '',
                Maxdiscount: '',
                liter: getShelfReqData[i]["totalltr"] == null
                    ? 0.0
                    : double.parse(getShelfReqData[i]["totalltr"].toString()),
                weight: getShelfReqData[i]["totalweight"] == null
                    ? 0
                    : double.parse(
                        getShelfReqData[i]["totalweight"].toString())));
            qtyCont[scanneditemData.length - 1].text =
                getShelfReqData[i]["shortageQty"] == null
                    ? "0"
                    : getShelfReqData[i]["shortageQty"].toString();
          }
        }

        notifyListeners();
        calculateDetails();
      } else {
        scanneditemData = [];
        loadMiniMaxmsg = "Does Not Have No data..!!";
        notifyListeners();
      }
      Future.delayed(const Duration(seconds: 5), () {
        loadMiniMaxbool = false;
        loadMiniMaxmsg = "";
        notifyListeners();
      });
      notifyListeners();
    }
  }

//
  bool? loadShelfReqbool = false;
  String? loadShelfReqmsg = "";
  loadShelfReqData(ThemeData theme) async {
    if (
        // ShipSelectedList == null &&
        WhsselectedList == null && scanneditemData.isEmpty) {
      Get.defaultDialog(
              // content: Container(
              //   width: Screens.width(context) * 0.4,
              //   height: Screens.bodyheight(context) * 0.1,
              // ),
              title: "Alert",
              middleText: "Choose WareHouse details..!!",
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text("Close"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ],
              radius: 5)
          .then((value) {
        onclickDisable = false;
        notifyListeners();
      });
    } else {
      loadShelfReqbool = true;
      loadShelfReqmsg = "";
      scanneditemData.clear();
      final Database db = (await DBHelper.getInstance())!;

      List<Map<String, Object?>> getShelfReqData =
          await DBOperation.getShelfReqData(db);
      if (getShelfReqData.isNotEmpty) {
        loadShelfReqbool = false;
        loadShelfReqmsg = "";
        for (int i = 0; i < getShelfReqData.length; i++) {
          if (getShelfReqData[i]["shortageQty"] != 0) {
            scanneditemData.add(StocksnapModelData(
                TransID: 1,
                //  int.parse(selectdata.transentry != null
                //     ? selectdata.transentry.toString()
                //     : '0')

                Branch: "", //selectdata.branchcode,
                ItemCode: getShelfReqData[i]["Itemcode"].toString(),
                ItemName: getShelfReqData[i]["itemname_short"].toString(),
                SerialBatch: getShelfReqData[i]["serialbatch"].toString(),
                OpenQty: 1, //int.parse(selectdata.quantity!),
                Qty: getShelfReqData[i]["shortageQty"] == null
                    ? 0
                    : int.parse(getShelfReqData[i]["shortageQty"]
                        .toString()), //int.parse(selectdata.quantity!),
                InDate: '',
                InType: '',
                VenCode: '',
                VenName: '',
                MRP: 0,
                SellPrice: 0.0, //double.parse(selectdata.sellprice!),
                Cost: 0,
                TaxRate: 0,
                TaxType: '',
                Maxdiscount: '',
                liter: getShelfReqData[i]["totalltr"] == null
                    ? 0.0
                    : double.parse(getShelfReqData[i]["totalltr"].toString()),
                weight: getShelfReqData[i]["totalweight"] == null
                    ? 0
                    : double.parse(
                        getShelfReqData[i]["totalweight"].toString())));
            qtyCont[scanneditemData.length - 1].text =
                getShelfReqData[i]["shortageQty"] == null
                    ? "0"
                    : getShelfReqData[i]["shortageQty"].toString();
          }
        }

        notifyListeners();
        calculateDetails();
      } else {
        scanneditemData = [];
        loadShelfReqmsg = "Does Not Have No data..!!";
        notifyListeners();
      }
      Future.delayed(const Duration(seconds: 5), () {
        loadShelfReqbool = false;
        loadShelfReqmsg = "";
        notifyListeners();
      });
    }
    notifyListeners();
  }

  onseletFst(BuildContext context, ThemeData theme,
      ItemMasterModelDB selectdata) async {
    // Navigator.pop(context);

    if (WhsselectedList == null) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Choose warehuse address..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    } else if (WhsselectedList != null) {
      // int? indx = await checkBatchAvail(
      //    selectdata.itemcode.toString().toUpperCase().trim());
      // if (indx != null) {
      addScannedData2(selectdata, context, theme);
      // addScndData2(selectdata, context, theme);
      // } else if (indx == null) {
      //   showDialog(
      //       context: context,
      //       barrierDismissible: true,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //             contentPadding: EdgeInsets.all(0),
      //             content: AlertBox(
      //               payMent: 'Alert',
      //               errormsg: true,
      //               widget: Center(
      //                   child: ContentContainer(
      //                 content: 'Wrong batch scanned..!!',
      //                 theme: theme,
      //               )),
      //               buttonName: null,
      //             ));
      //       });
      //   // config.showDialogBox('Alert', 'Wrong batch scanned..!!', context);
      // }
    }
  }

  addScannedData2(
      ItemMasterModelDB data, BuildContext context, ThemeData theme) async {
    allselectedData(data);
    if (scanneditemData.isEmpty) {
      onselectedItemasFst(data);
    } else {
      addScndData2(data, context, theme);
    }
    restartFocus(context);
  }

  restartFocus(BuildContext context) {
    searchcon.clear();
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
    inven.requestFocus();
    notifyListeners();
  }

  refereshItemMaster() async {
    final Database db = (await DBHelper.getInstance())!;
    List<String> catchmsg = [];
    List<ItemMasterModelDB> itemMasterDB = [];
    await DBOperation.truncateItemMaster(db);

    await ProductMasterApi.getData(AppConstant.branch, AppConstant.terminal)
        .then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.itemdata != null) {
          for (int i = 0; i < value.itemdata!.length; i++) {
            itemMasterDB.add(ItemMasterModelDB(
              isselected: 0,
              autoId: value.itemdata![i].autoId,
              maximumQty: value.itemdata![i].maximumQty,
              minimumQty: value.itemdata![i].minimumQty,
              weight: value.itemdata![i].weight,
              liter: value.itemdata![i].liter,
              displayQty: value.itemdata![i].displayQty,
              searchString: value.itemdata![i].searchString,
              brand: UserValues.branch,
              category: value.itemdata![i].category,
              createdUserID: value.itemdata![i].createdUserID.toString(),
              createdateTime: value.itemdata![i].createdateTime,
              hsnsac: value.itemdata![i].hsnsac,
              isActive: value.itemdata![i].isActive,
              isfreeby: value.itemdata![i].isfreeby,
              isinventory: value.itemdata![i].isinventory,
              issellpricebyscrbat: value.itemdata![i].issellpricebyscrbat,
              isserialBatch: value.itemdata![i].isserialBatch,
              itemcode: value.itemdata![i].itemcode,
              itemnamelong: value.itemdata![i].itemnamelong,
              itemnameshort: value.itemdata![i].itemnameshort,
              lastupdateIp: UserValues.lastUpdateIp,
              maxdiscount: value.itemdata![i].maxdiscount == null
                  ? 0.00
                  : double.parse(value.itemdata![i].maxdiscount.toString()),
              skucode: value.itemdata![i].skucode,
              subcategory: value.itemdata![i].subcategory,
              taxrate: value.itemdata![i].taxrate.toString(),
              updatedDatetime: value.itemdata![i].updatedDatetime,
              updateduserid: value.itemdata![i].updateduserid.toString(),
              mrpprice: value.itemdata![i].mrpprice!.toString(),
              sellprice: value.itemdata![i].sellprice!.toString(),
              quantity: value.itemdata![i].quantity == null
                  ? 0
                  : int.parse(value.itemdata![i].quantity.toString()),
              uPackSizeuom: value.itemdata![i].uPackSizeuom!.toString(),
              uPackSize: value.itemdata![i].uPackSize.toString(),
              uTINSPERBOX: value.itemdata![i].uTINSPERBOX!,
              uSpecificGravity: value.itemdata![i].uSpecificGravity.toString(),
            ));
          }
          notifyListeners();
        } else if (value.itemdata == null) {
          // exception = value.message!;
          catchmsg.add("Product details: " + value.exception!);
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // exception = value.exception!;
        catchmsg.add("Product details: " + value.exception!);
      } else {
        // exception = value.exception!;
        catchmsg.add("Product details: " + value.exception!);
      }
    });
    await DBOperation.insertItemter(db, itemMasterDB).then((value) {
 //log("---------------2 inseted insertItemter");
      notifyListeners();
    });
  }

  allselectedData(ItemMasterModelDB data) async {
    getAllSelect.add(data);
    notifyListeners();
  }

  addScndData2(
      ItemMasterModelDB data, BuildContext context, ThemeData theme) async {
    int? ins = await checkSameSerialBatchScnd(
        data.itemcode.toString().toUpperCase().trim());

    if (ins != null) {
      print("DDDDDDD");
      itemIncrement2(data, context, theme);
      notifyListeners();
    } else {
      onselectedItemasFst(data);
      notifyListeners();
    }
    notifyListeners();
  }

  itemIncrement2(
      ItemMasterModelDB data, BuildContext context, ThemeData theme) {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].ItemCode == data.itemcode) {
        scanneditemData[i].Qty = (scanneditemData[i].Qty! + 1);
        qtyCont[i].text = scanneditemData[i].Qty.toString();
   //log("QTY INC_____:" + scanneditemData[i].Qty.toString());
   //log("QTY INC_____:" + scanneditemData[i].ItemCode.toString());

        notifyListeners();
      }
    }
    calculateDetails();
    notifyListeners();
  }

  itemIncrementClick(int ind, BuildContext context, ThemeData theme) {
    log("getAllSelect: " + getAllSelect.length.toString());
    for (int i = 0; i < getAllSelect.length; i++) {
      if (getAllSelect[i].isserialBatch == scanneditemData[ind].SerialBatch) {
        scanneditemData[ind].Qty = scanneditemData[ind].Qty! + 1;
        notifyListeners();
      }
    }
    calculateDetails();
    notifyListeners();
  }

  editqty(int indx) {
    log("message");
    if (qtyCont[indx].text.isEmpty || int.parse(qtyCont[indx].text) == 0) {
 //log("message2");
      scanneditemData.removeAt(indx);
      qtyCont.removeAt(indx);
      // qtyCont[indx].text = scanneditemData[indx+2].Qty.toString();
      // // scanneditemData[indx].Qty = int.parse(qtyCont[indx].text);
      // // qtyCont[indx + 1].text = qtyCont[indx + 2].text.toString();
      notifyListeners();
    } else {
      scanneditemData[indx].Qty = int.parse(qtyCont[indx].text);
      notifyListeners();
    }
  }

  double totalLiter() {
    double total = 0.0;
    if (scanneditemData.isNotEmpty) {
      for (int i = 0; i < scanneditemData.length; i++) {
        total = total +
            (scanneditemData[i].liter! *
                double.parse(scanneditemData[i].Qty.toString()));
      }
      return total;
    }
    return 0.00;
  }

  double totalLiter2() {
    double total = 0.0;
    if (scanneditemData2.isNotEmpty) {
      for (int i = 0; i < scanneditemData2.length; i++) {
        total = total +
            (scanneditemData2[i].liter! *
                double.parse(scanneditemData2[i].Qty.toString()));
      }
      return total;
    }
    return 0.00;
  }

  double totalWeight() {
    double totalWeight = 0.0;
    if (scanneditemData.isNotEmpty) {
      for (int i = 0; i < scanneditemData.length; i++) {
        totalWeight = totalWeight +
            (scanneditemData[i].weight! *
                double.parse(scanneditemData[i].Qty.toString()));
      }
      return totalWeight;
    }
    return 0.00;
  }

  double totalWeight2() {
    double totalWeight = 0.0;
    if (scanneditemData2.isNotEmpty) {
      for (int i = 0; i < scanneditemData2.length; i++) {
        totalWeight = totalWeight +
            (scanneditemData2[i].weight! *
                double.parse(scanneditemData2[i].Qty.toString()));
      }

      return totalWeight;
    }
    return 0.00;
  }

  onselectedItemasFst(ItemMasterModelDB selectdata) {
    scanneditemData.add(StocksnapModelData(
        TransID: 1,
        //  int.parse(selectdata.transentry != null
        //     ? selectdata.transentry.toString()
        //     : '0')

        Branch: "", //selectdata.branchcode,
        ItemCode: selectdata.itemcode,
        ItemName: selectdata.itemnameshort,
        SerialBatch: selectdata.isserialBatch,
        OpenQty: 1, //int.parse(selectdata.quantity!),
        Qty: 1, //int.parse(selectdata.quantity!),
        InDate: '',
        InType: '',
        VenCode: '',
        VenName: '',
        MRP: 0,
        SellPrice: 0.0, //double.parse(selectdata.sellprice!),
        Cost: 0,
        TaxRate: 0,
        TaxType: '',
        Maxdiscount: '',
        liter: selectdata.liter!,
        weight: selectdata.weight!));
    qtyCont[scanneditemData.length - 1].text = '1';
    notifyListeners();
    calculateDetails();
  }
  ////

  scannBAtch(BuildContext context, ThemeData theme) async {
    //  FocusScopeNode focus = FocusScope.of(context);
    // if (!focus.hasPrimaryFocus) {
    //   focus.unfocus();
    // }

    if (WhsselectedList == null) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Choose warehuse address..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    } else if (WhsselectedList != null) {
      int? indx = await checkBatchAvail(
          mycontroller[0].text.toString().toUpperCase().trim());
      if (indx != null) {
        addScannedData(indx, context, theme);
      } else if (indx == null) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: 'Wrong batch scanned..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
        // config.showDialogBox('Alert', 'Wrong batch scanned..!!', context);
      }
    }
  }

  Future<int?> checkBatchAvail(String sBatch) {
    for (int i = 0; i < itemData.length; i++) {
      if (itemData[i].ItemCode == sBatch || itemData[i].ItemName == sBatch) {
        return Future.value(i);
        break;
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  addScannedData(int ind, BuildContext context, ThemeData theme) async {
    if (scanneditemData.isEmpty) {
      addScndDataFst(ind);
    } else {
      addScndData(ind, context, theme);
    }
  }

  addScndData(int indx, BuildContext context, ThemeData theme) async {
    int? ins = await checkSameSerialBatchScnd(
        mycontroller[0].text.toString().toUpperCase().trim());

    if (ins != null) {
      print("DDDDDDD");
      itemIncrement(ins, context, theme);
      notifyListeners();
    } else {
      addScndDataFst(indx);
      notifyListeners();
    }
    notifyListeners();
  }

  Future<int?> checkSameSerialBatchScnd(String sBatch) async {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].ItemCode == sBatch ||
          scanneditemData[i].ItemName == sBatch) {
   //log("Sucess");
        return Future.value(i);
        break;
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  // addScndSrlBtchQty(int ind) {
  //   scanneditemData[ind].Qty = (scanneditemData[ind].Qty! + 1);
  // }

  addScndDataFst(int ind) {
    scanneditemData.add(StocksnapModelData(
        TransID: itemData[ind].TransID,
        Branch: itemData[ind].Branch,
        ItemCode: itemData[ind].ItemCode,
        ItemName: itemData[ind].ItemName,
        SerialBatch: itemData[ind].SerialBatch,
        OpenQty: itemData[ind].OpenQty,
        Qty: 1,
        InDate: itemData[ind].InDate,
        InType: itemData[ind].InType,
        VenCode: itemData[ind].VenCode,
        VenName: itemData[ind].VenName,
        MRP: itemData[ind].MRP,
        SellPrice: itemData[ind].SellPrice,
        Cost: itemData[ind].Cost,
        TaxRate: itemData[ind].TaxRate,
        TaxType: itemData[ind].TaxType,
        Maxdiscount: '',
        liter: itemData[ind].liter,
        weight: itemData[ind].weight));
    notifyListeners();
    calculateDetails();
  }

  CalCulteStReq? calCulteStReq;
  calculateDetails() {
    if (scanneditemData.isEmpty) {
      CalCulteStReq totalPay = new CalCulteStReq(
          qty: 0, totalItem: 0, totalLiter: 0, totalweight: 0);
      calCulteStReq = totalPay;
      notifyListeners();
    } else {
      CalCulteStReq totalPay = new CalCulteStReq(
          qty: getNoOfQty(),
          totalItem: double.parse(scanneditemData.length.toString()),
          totalLiter: totalLiter(),
          totalweight: totalWeight());
      calCulteStReq = totalPay;
      notifyListeners();
    }
  }

  double getNoOfQty() {
    double totalqty2 = 0.0;
    if (scanneditemData.isNotEmpty) {
      for (int i = 0; i < scanneditemData.length; i++) {
        if (qtyCont[i].text.isNotEmpty) {
          totalqty2 = totalqty2 +
              int.parse(qtyCont[i].text.isEmpty
                  ? "0.00"
                  : qtyCont[i].text.toString());
        } else {
          totalqty2 = 0.00;
        }
      }

      // var getQty = scanneditemData.map((itemdet) => itemdet.Qty.toString());
      // var getSum = getQty.map(double.parse).toList();
      // var totalqty = getSum.reduce((a, b) => a + b);
      return totalqty2;
    }
    return 0;
  }

  removeEmptyList(BuildContext context) {
    List<int>? removeI = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      if (qtyCont[i].text.isEmpty) {
        // removeI.add(i);
        qtyCont.removeAt(i);
        scanneditemData.removeAt(i);
        // log(scanneditemData[i].Qty.toString());
        // disableKeyBoard(context);
        // break;
        // qtyCont[i].text=scanneditemData[i-1].Qty.toString();
      }
      // else {
      //   scanneditemData[i].Qty = int.parse(qtyCont[i].text.toString());
      // }
    }
    // if (removeI != null) {
    //   for (int j = 0; j < removeI.length; j++) {
    //     scanneditemData.removeAt(j);
    //   }
    // }
    // setvalues();
  }

  setvalues() {
    for (int i = 0; i < scanneditemData.length; i++) {
      // if (qtyCont[i].text.isEmpty) {
      //   scanneditemData.removeAt(i);
      //   log(scanneditemData[i].Qty.toString());
      //   break;
      // qtyCont[i].text = scanneditemData[i].Qty.toString();
      // }else{
      //   scanneditemData[i].Qty=int.parse(qtyCont[i].text.toString());
      // }
    }
  }

  double getNoOfQty2() {
    if (scanneditemData2.isNotEmpty) {
      var getQty = scanneditemData2.map((itemdet) => itemdet.Qty.toString());
      var getSum = getQty.map(double.parse).toList();
      var totalqty = getSum.reduce((a, b) => a + b);
      return totalqty;
    }
    return 0;
  }

  double getSumPrice() {
    var getprice =
        scanneditemData.map((itemdet) => itemdet.SellPrice.toString());
    var getpriceSum = getprice.map(double.parse).toList();
    var toalPrice = getpriceSum.reduce((a, b) => a + b);
    return toalPrice;
  }

  double getSumTotalTax() {
    var getTax = scanneditemData.map((itemdet) => itemdet.TaxRate.toString());
    var getTaxSum = getTax.map(double.parse).toList();
    var toalTax = getTaxSum.reduce((a, b) => a + b);
    return toalTax;
  }

  double getNoSubTotal() {
    double totalQty = getNoOfQty();
    double totalPrice = getSumPrice();
    double sumTotal = (totalQty * totalPrice);
    return sumTotal;
  }

  double getTotalTax() {
    double totalQty = getNoOfQty();
    double totalPrice = getSumPrice();
    double tax = getSumTotalTax();
    double totalTax = ((totalQty * totalPrice) * (tax / 100));
    return totalTax;
  }

  double getDiscount() {
    return 0;
  }

  itemIncrement(int ind, BuildContext context, ThemeData theme) {
    for (int i = 0; i < itemData.length; i++) {
      if (itemData[i].SerialBatch == scanneditemData[ind].SerialBatch) {
        // if (itemData[i].Qty! > scanneditemData[ind].Qty!) {
        scanneditemData[ind].Qty = scanneditemData[ind].Qty! + 1;
        notifyListeners();
        // break;
        // } else {
        //   showDialog(
        //       context: context,
        //       barrierDismissible: true,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //             contentPadding: EdgeInsets.all(0),
        //             content: AlertBox(
        //               payMent: 'Alert',
        //               errormsg: true,
        //               widget: Center(
        //                   child: ContentContainer(
        //                 content: 'No more qty to add..!!',
        //                 theme: theme,
        //               )),
        //               buttonName: null,
        //             ));
        //       });
        //   break;
        // }
      }
    }
    calculateDetails();
    notifyListeners();
  }

  // int i = 1;
  // int get geti => i;

  itemdecrement(int ind) {
    if (scanneditemData[ind].Qty! > 1) {
      scanneditemData[ind].Qty = scanneditemData[ind].Qty! - 1;
      qtyCont[ind].text = scanneditemData[ind].Qty.toString();
      notifyListeners();
    } else {
      scanneditemData.removeAt(ind);
      notifyListeners();
    }
    calculateDetails();
  }

  // SuspendMethod(BuildContext context, ThemeData theme) {
  //   // if (scanneditemData.isNotEmpty ||
  //   //     WhsselectedList != null ||
  //   //     ShipSelectedList != null) {
  //   scanneditemData.clear();
  //   WhsselectedList = null;
  //   ShipSelectedList = null;
  //   calCulteStReq = null;
  //   mycontroller[0].text = "";
  //   showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //             contentPadding: EdgeInsets.all(0),
  //             content: AlertBox(
  //               payMent: '',
  //               errormsg: false,
  //               widget: Center(
  //                   child: StReq_SuccessAlertbox(
  //                 content: 'All Details clear successfully!!',
  //                 theme: theme,
  //               )),
  //               buttonName: null,
  //             ));
  //       });
  //   notifyListeners();
  //   // } else {

  //   // }
  // }

  SuspendMethodDB(
      BuildContext context, ThemeData theme, String Ordertype) async {
    final Database db = (await DBHelper.getInstance())!;
    // searchclear();
    clearSuspendedData(context, theme);
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  clearSuspendedData(BuildContext context, ThemeData theme) {
    onclickDisable = true;
    scanneditemData2.clear();
    scanneditemData.clear();
    fromAddressList2 = null;
    fromAddressList = null;
    WhsselectedList = null;
    WhsselectedList2 = null;
    remarkscontroller2.text = "";
    remarkscontroller.text = "";
    notifyListeners();
    Get.defaultDialog(
            title: "Success",
            middleText: " Suspended Sucessfully..!!",
            backgroundColor: Colors.white,
            titleStyle: const TextStyle(color: Colors.red),
            middleTextStyle: const TextStyle(color: Colors.black),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ],
            radius: 5)
        .then((value) {
      onclickDisable = false;
      notifyListeners();

      callList();
      callDB();
      notifyListeners();
    });
  }

  searchclear() {
    stockReqLines = [];
    searchcon.text = '';
    onclickDisable = false;
    cancelbtn = false;
    scanneditemData2.clear();
    scanneditemData.clear();
    fromAddressList2 = null;
    fromAddressList = null;
    WhsselectedList = null;
    WhsselectedList2 = null;
    holddocentry = '';
    savedraftBill = [];
    remarkscontroller2.text = "";
    remarkscontroller.text = "";
    callList();
    // callDB();
  }

  List<Orderdetails> savedraftBill = [];
  Orderdetails? orderDetailsList;
  // saveOrder(String ordertype) {
  //   orderdetails orderDetailsList2 = orderdetails(
  //       // shipAdd: ShipSelectedList,
  //       whsAdd: WhsselectedList!,
  //       totalPayment: totalPayment,
  //       orderType: ordertype,
  //       scannData: scanneditemData);
  //   orderDetailsList = orderDetailsList2;
  //   notifyListeners();
  // }

  saveButton(BuildContext context, ThemeData theme, String Ordertype) async {
    onclickDisable = true;
    final Database db = (await DBHelper.getInstance())!;
    if (
        // ShipSelectedList == null ||
        WhsselectedList == null || scanneditemData.isEmpty) {
      Get.defaultDialog(
              title: "Alert",
              middleText: "Please Choose All details..!!",
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text("Close"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ],
              radius: 5)
          .then((value) {
        onclickDisable = false;
        notifyListeners();
      });

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
      //               content: 'Please Choose All details..!!',
      //               theme: theme,
      //             )),
      //             buttonName: null,
      //           ));
      //     });
    } else if (
        // ShipSelectedList != null &&
        WhsselectedList != null && scanneditemData.isNotEmpty) {
      print(scanneditemData.length);
 //log("WhsselectedList.dbDocEntry" +
          // WhsselectedList!.dbDocEntry.toString());
      //   await DBOperation.exec(db);

      saveValuesTODB(Ordertype, WhsselectedList!, db, context, theme);
      if (holddocentry.isNotEmpty) {
        await DBOperation.deletereqHold(db, holddocentry.toString());
        await getHoldStReq(db);
      }
      holddocentry = '';

      //old
      //   saveOrder(Ordertype);
      // scanneditemData.clear();
      // WhsselectedList = null;
      // ShipSelectedList = null;
      // totalPayment = null;
      // mycontroller[0].text = "";
      // notifyListeners();
    }

    notifyListeners();
  }

  HoldButton(BuildContext context, ThemeData theme) async {
    onclickDisable = true;
    if (
        // ShipSelectedList == null &&
        WhsselectedList == null) {
      Get.defaultDialog(
              // content: Container(
              //   width: Screens.width(context) * 0.4,
              //   height: Screens.bodyheight(context) * 0.1,
              // ),
              title: "Alert",
              middleText: "Choose WareHouse details..!!",
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text("Close"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ],
              radius: 5)
          .then((value) {
        onclickDisable = false;
        notifyListeners();
      });
    } else {
      print("object");
      final Database db = (await DBHelper.getInstance())!;
      // await DBOperation.exec(db);

      saveValuesTODB("hold", WhsselectedList!, db, context, theme);
      if (holddocentry.isNotEmpty) {
        await DBOperation.deletereqHold(db, holddocentry.toString());
        await getHoldStReq(db);
      }
      holddocentry = '';
    onclickDisable = false;

    }
    notifyListeners();
  }

  mapData(List<Orderdetails> orderdetails, int i, BuildContext context,
      ThemeData theme) async {
    searchclear();
    scanneditemData = [];
    onclickDisable = false;
    WhsDetails map_WhsList = WhsDetails(
        dbDocEntry: orderdetails[i].whsAdd!.dbDocEntry,
        whsName: orderdetails[i].whsAdd!.whsName,
        whsCode: orderdetails[i].whsAdd!.whsCode,
        whsPhoNo: orderdetails[i].whsAdd!.whsPhoNo,
        whsmailID: orderdetails[i].whsAdd!.whsmailID,
        whsGst: orderdetails[i].whsAdd!.whsGst,
        whsAddress: orderdetails[i].whsAdd!.whsAddress,
        whsDistric: orderdetails[i].whsAdd!.whsDistric,
        pinCode: orderdetails[i].whsAdd!.pinCode,
        whsState: orderdetails[i].whsAdd!.whsState,
        whsCity: orderdetails[i].whsAdd!.whsCity);
    WhsselectedList = map_WhsList;
    remarkscontroller.text = orderdetails[i].remarks;
    if (orderdetails[i].scannData.isNotEmpty) {
      for (int ij = 0; ij < orderdetails[i].scannData.length; ij++) {
   //log("orderdetails[i].scannData[ij].Qty::" +
            // orderdetails[i].scannData[ij].Qty.toString());
        scanneditemData.add(StocksnapModelData(
            TransID: orderdetails[i].scannData[ij].TransID,
            Branch: orderdetails[i].scannData[ij].Branch,
            ItemCode: orderdetails[i].scannData[ij].ItemCode,
            ItemName: orderdetails[i].scannData[ij].ItemName,
            SerialBatch: orderdetails[i].scannData[ij].SerialBatch,
            OpenQty: orderdetails[i].scannData[ij].OpenQty,
            Qty: orderdetails[i].scannData[ij].Qty,
            InDate: orderdetails[i].scannData[ij].InDate,
            InType: orderdetails[i].scannData[ij].InType,
            VenCode: orderdetails[i].scannData[ij].VenCode,
            VenName: orderdetails[i].scannData[ij].VenName,
            MRP: orderdetails[i].scannData[ij].MRP,
            SellPrice: orderdetails[i].scannData[ij].SellPrice,
            Cost: orderdetails[i].scannData[ij].Cost,
            TaxRate: orderdetails[i].scannData[ij].TaxRate,
            TaxType: orderdetails[i].scannData[ij].TaxType,
            liter: orderdetails[i].scannData[ij].liter == null
                ? 0.0
                : orderdetails[i].scannData[ij].liter,
            weight: orderdetails[i].scannData[ij].weight == null
                ? 0.0
                : orderdetails[i].scannData[ij].weight,
            Maxdiscount: ''));
      }
    }

    for (int ik = 0; ik < scanneditemData.length; ik++) {
      qtyCont[ik].text = scanneditemData[ik].Qty.toString();
    }
    holddocentry = WhsselectedList!.dbDocEntry!.toString();
    calculateDetails();
//
    final Database db = (await DBHelper.getInstance())!;
    // await DBOperation.deletereqHold(db, WhsselectedList!.dbDocEntry!);
    // await getHoldStReq(db);

    notifyListeners();
  }

  // getItemFromDB(Database db) async {
  //   List<ItemMasterModelDB> itemMasdata = await DBOperation.getItemMasData(db);
  //   log("itemData itemMasdata11:  ${itemMasdata.length}");
  //   for (int i = 0; i < itemMasdata.length; i++) {
  //     itemData.add(StocksnapModelData(
  //         TransID: int.parse(itemMasdata[i].transentry != null
  //             ? itemMasdata[i].transentry.toString()
  //             : '0'),
  //         Branch: itemMasdata[i].branchcode,
  //         ItemCode: itemMasdata[i].itemcode,
  //         ItemName: '',
  //         SerialBatch: itemMasdata[i].serialbatch,
  //         OpenQty: int.parse(itemMasdata[i].quantity!),
  //         Qty: int.parse(itemMasdata[i].quantity!),
  //         InDate: '',
  //         InType: '',
  //         VenCode: '',
  //         VenName: '',
  //         MRP: 0,
  //         SellPrice: int.parse(itemMasdata[i].sellprice!),
  //         Cost: 0,
  //         TaxRate: 0,
  //         TaxType: ''));
  //   }
  //   log("itemData len11:  ${itemData.length}");
  // }

  /// get item master from db

  Future getItemFromDB(Database db) async {
    List<ItemMasterModelDB> itemMasdata =
        await DBOperation.getItemMasData2(db, "");
    // log("itemData itemMasdata11:  ${itemMasdata.length}");
    for (int i = 0; i < itemMasdata.length; i++) {
      itemData.add(StocksnapModelData(
          TransID: 1, //int.parse(itemMasdata[i].transentry != null
          // ? itemMasdata[i].transentry.toString()
          // : '0'),
          Branch: "", //itemMasdata[i].branchcode,
          ItemCode: itemMasdata[i].itemcode,
          ItemName: itemMasdata[i].itemnameshort,
          SerialBatch: itemMasdata[i].isserialBatch,
          OpenQty: 1, //int.parse(itemMasdata[i].quantity!),
          Qty: 1, //int.parse(itemMasdata[i].quantity!),
          InDate: '',
          InType: '',
          VenCode: '',
          VenName: '',
          MRP: 0,
          SellPrice: 0.0, //double.parse(itemMasdata[i].sellprice!),
          Cost: 0,
          TaxRate: 0,
          TaxType: '',
          Maxdiscount: '',
          liter: itemMasdata[i].liter!,
          weight: itemMasdata[i].weight!));
    }
    // log("itemData len11:  ${itemData.length}");
  }

  saveValuesTODB(String docstatus, WhsDetails whsDetails, Database db,
      BuildContext context, ThemeData theme) async {
    if (docstatus == "hold") {
      insdertStockReqdata(docstatus, whsDetails, db, context, theme);
    } else if (docstatus == "against order") {
      insdertStockReqdata(docstatus, whsDetails, db, context, theme);
    } else if (docstatus == "against stock") {
      insdertStockReqdata(docstatus, whsDetails, db, context, theme);
    }
    // else if (docstatus == "suspend") {
    //   insdertStockReqdata(docstatus, whsDetails, db, context, theme);
    // }
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

    log("datattata doc : " + data.substring(8));
    return listdata; // int.parse(data.substring(8));
  }

  insdertStockReqdata(String docstatus, WhsDetails whsDetails, Database db,
      BuildContext context, ThemeData theme) async {
    for (int i = 0; i < scanneditemData.length; i++) {
      scanneditemData[i].Qty = int.parse(qtyCont[i].text.toString());

      notifyListeners();
      // }
    }
    // if (docstatus == "against order" || docstatus == "against stock") {
    //   onclickDisable = true;
    //   notifyListeners();
    // }

    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "StockReqHDT");
    int? docEntryCreated = 0;
    if (counofData == 0) {
      if (AppConstant.terminal == 'T1') {
        docEntryCreated = 1000000;
      } else if (AppConstant.terminal == 'T2') {
        docEntryCreated = 2000000;
      } else if (AppConstant.terminal == 'T3') {
        docEntryCreated = 3000000;
      } else if (AppConstant.terminal == 'T4') {
        docEntryCreated = 4000000;
      }
    } else {
      docEntryCreated =
          await DBOperation.generateDocentr(db, "docentry", "StockReqHDT");
    }

    // docnumber generatiom

    String docmntNo = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 4);

    List<String> getseriesvalue = await checkingdoc(4);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    docmntNo = finlDocnum + documentN0.toString();
    // docnumber generatiom
    List<StockReqHDTDB> stckReqDB = [];
    stckReqDB.add(StockReqHDTDB(
      doctype: "Stock Request",
      docentry: docEntryCreated.toString(),
      branch: UserValues.branch,
      createdUserID: UserValues.userID,
      createdateTime: config.currentDate(),
      docstatus: docstatus == "suspend"
          ? "0"
          : docstatus == "hold"
              ? "1"
              : docstatus == "against order"
                  ? "2"
                  : docstatus == "against stock"
                      ? "3"
                      : "null",
      documentno: docmntNo,
      isagainstorder: docstatus == "against order" ? "Y" : "N",
      isagainststock: docstatus == "against stock" ? "Y" : "N",
      lastupdateIp: UserValues.lastUpdateIp.toString(),
      reqdocno: 0,
      reqdocseries: "null",
      reqdocseriesno: 0,
      reqdoctime: config.currentDate(),
      reqfromWhs: UserValues.branch,
      reqsystime: config.currentDate(),
      reqtoWhs: whsDetails.whsCode, //cnfUserValues.branch,
      reqtransdate: config.currentDate(),
      salesexec: UserValues.salesExce,
      seresid: 0,
      seriesnum: 0,
      sysdatetime: config.currentDate(),
      totalitems: getScanneditemData.length,
      totalltr: totalLiter(),
      totalqty: getNoOfQty(),
      totalweight: totalWeight(),
      transactiondate: config.currentDate(),
      transtime: config.currentDate(),
      updatedDatetime: config.currentDate(),
      updateduserid: UserValues.userID,
      terminal: UserValues.terminal,
      sapDocNo: null,
      sapDocentry: null,
      qStatus: "No",
      remarks: remarkscontroller.text.toString(),
    ));

    List<StockReqLineTDB> stkReqLTDB = [];
    for (int i = 0; i < getScanneditemData.length; i++) {
      if (getScanneditemData[i].Qty != 0 ||
          getScanneditemData[i].Qty.toString().isNotEmpty) {
   //log("stockReq Qty::::::" + getScanneditemData[i].Qty.toString());
        stkReqLTDB.add(StockReqLineTDB(
            createdUserID: UserValues.userID,
            createdateTime: config.currentDate(),
            docentry: 0,
            dscription: getScanneditemData[i].ItemName,
            itemcode: getScanneditemData[i].ItemCode,
            lastupdateIp: UserValues.userID.toString(),
            lineNo: i,
            qty: double.parse(getScanneditemData[i].Qty.toString()),
            status:
                // docstatus == "suspend"
                //     ? "0"
                //     :
                docstatus == "hold"
                    ? "1"
                    : docstatus == "against order"
                        ? "2"
                        : docstatus == "against stock"
                            ? "3"
                            : "null",
            updatedDatetime: config.currentDate(),
            updateduserid: UserValues.userID,
            price: double.parse(getScanneditemData[i].SellPrice.toString()),
            taxRate: double.parse(getScanneditemData[i].TaxRate.toString()),
            taxType: getScanneditemData[i].TaxType,
            serialBatch: getScanneditemData[i].SerialBatch,
            branch: UserValues.branch,
            terminal: UserValues.terminal));
      }
    }

    int docEntry = await DBOperation.insertStkReq(db, stckReqDB);
    await DBOperation.updatenextno(db, 4, nextno);
    if (stkReqLTDB.isNotEmpty) {
      await DBOperation.insertStkReqLin(db, stkReqLTDB, docEntry);
    }
    if (docstatus == "against order" || docstatus == "against stock") {
      // onclickDisable = false;
      bool? netbool = await config.haveInterNet();
      if (netbool == true) {
        await postingStockRequest(
            whsDetails, docstatus, docEntry, context, theme);
        // Get.offAllNamed(ConstantRoutes.dashboard);

        notifyListeners();
      }
    }
    if (docstatus == "hold") {
      await getHoldStReq(db);
      onclickDisable = true;
      // scanneditemData.clear();
      WhsselectedList = null;
      remarkscontroller.text = "";
      ShipSelectedList = null;
      calCulteStReq = null;
      mycontroller[0].text = "";
      notifyListeners();
      await Get.defaultDialog(
        title: "Success",
        middleText: docstatus == "hold" ? "Saved as draft" : "null",
        backgroundColor: Colors.white,
        titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
        middleTextStyle: theme.textTheme.bodyLarge,
        radius: 5,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text("Close"),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ],
      ).then((value) async {
        // if (docstatus == "against order" || docstatus == "against stock") {
        //   onclickDisable = false;

        //   // Get.offAllNamed(ConstantRoutes.dashboard);

        //   notifyListeners();
        // }
        scanneditemData.clear();

        onclickDisable = false;
        notifyListeners();
      });
    }

    // onclickDisable = true;
    // // scanneditemData.clear();
    // WhsselectedList = null;
    // remarkscontroller.text = "";
    // ShipSelectedList = null;
    // calCulteStReq = null;
    // mycontroller[0].text = "";
    // notifyListeners();

    // await Get.defaultDialog(
    //   title: "Success",
    //   middleText: docstatus == "against order"
    //       ? "Against Order Sucessfully Placed"
    //       : docstatus == "against stock"
    //           ? "Against Stock Sucessfully Placed"
    //           : docstatus == "hold"
    //               ? "Saved as draft"
    //               // : docstatus == "suspend"
    //               //     ? "Suspended Sucessfully"
    //               : "null",
    //   backgroundColor: Colors.white,
    //   titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
    //   middleTextStyle: theme.textTheme.bodyLarge,
    //   radius: 5,
    //   actions: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         TextButton(
    //           child: const Text("Close"),
    //           onPressed: () => Get.back(),
    //         ),
    //       ],
    //     ),
    //   ],
    // ).then((value) async {
    //   if (docstatus == "against order" || docstatus == "against stock") {
    //     onclickDisable = false;
    //     Get.offAllNamed(ConstantRoutes.dashboard);

    //     notifyListeners();
    //   }
    // scanneditemData.clear();

    //   onclickDisable = false;
    //   notifyListeners();
    // });
  }

  // showalert() async {
  //   return Get.defaultDialog(
  //       barrierDismissible: true,
  //       title: "Alert",
  //       middleText: "null",
  //       backgroundColor: Colors.white,
  //       titleStyle: TextStyle(color: Colors.red),
  //       middleTextStyle: TextStyle(color: Colors.black),
  //       radius: 10);
  // }whsDetails.whsCode, //cnfUserValues.branch,

  postingStockRequest(WhsDetails whsDetails, String docstatus, int docEntry,
      BuildContext context, ThemeData theme) async {
    await sapLoginApi(context);
    await postRequestData(whsDetails, docstatus, docEntry, context, theme);
    notifyListeners();
  }

  List<StockReqPostiModel>? stockReqLines = [];
  addReqLinedata(WhsDetails whsDetails) {
    stockReqLines = [];
    for (int i = 0; i < getScanneditemData.length; i++) {
      stockReqLines!.add(StockReqPostiModel(
        Currency: "TZS",
        ItemDescription: getScanneditemData[i].ItemName.toString(),
        ItemCode: getScanneditemData[i].ItemCode.toString(),
        Quantity: getScanneditemData[i].Qty!,
        FromWarehouseCode: UserValues.branch.toString(),
        toWarehouseCode: whsDetails.whsCode!,
        lineNum: i,
      ));
    }
    notifyListeners();
  }

  postRequestData(WhsDetails whsDetails, String docstatus, int docEntryId,
      BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    var uuid = Uuid();
    String? uuidg = uuid.v1();
    await addReqLinedata(whsDetails);
    PostRequestAPi.fromWarehouse = UserValues.branch;
    PostRequestAPi.toWarehouse = whsDetails.whsCode;
    PostRequestAPi.comments = remarkscontroller.text;
    PostRequestAPi.docDate = config.currentDate();
    PostRequestAPi.dueDate = config.currentDate();
    PostRequestAPi.stockTransferLines = stockReqLines;
    PostRequestAPi.method(uuidg);
    notifyListeners();
    await PostRequestAPi.getGlobalData(uuidg).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.docEntry != null) {
          sapDocentry = value.docEntry.toString();
          sapDocuNumber = value.docNum.toString();
          await DBOperation.UpdtSapDetSalHead(db, int.parse(sapDocentry),
              int.parse(sapDocuNumber), docEntryId, 'StockReqHDT');
          PostRabitMqStockReq2(
              int.parse(docEntryId.toString()), whsDetails.whsCode!);
          scanneditemData.clear();
          WhsselectedList = null;
          remarkscontroller.text = "";
          ShipSelectedList = null;
          calCulteStReq = null;
          mycontroller[0].text = "";
          stockReqLines = [];
          notifyListeners();

          await Get.defaultDialog(
            title: "Success",
            middleText: docstatus == "against order"
                ? "Against Order Sucessfully Placed"
                : docstatus == "against stock"
                    ? "Against Stock Sucessfully Placed"
                    : docstatus == "hold"
                        ? "Saved as draft"
                        : "null",
            backgroundColor: Colors.white,
            titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
            middleTextStyle: theme.textTheme.bodyLarge,
            radius: 5,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ],
          ).then((value) async {
            if (docstatus == "against order" || docstatus == "against stock") {
              onclickDisable = false;
              Get.offAllNamed(ConstantRoutes.dashboard);

              notifyListeners();
            }

            scanneditemData.clear();
            WhsselectedList = null;
            remarkscontroller.text = "";
            ShipSelectedList = null;
            calCulteStReq = null;
            mycontroller[0].text = "";
            onclickDisable = false;

            notifyListeners();
          });
        }
      }
      if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        await Get.defaultDialog(
          title: "Alert",
          middleText: value.error!.message.toString(),
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyLarge,
          radius: 5,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text("Close"),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ],
        );
      }
    });
  }

  PostRabitMqStockReq(int docentry, String toWhs) async {
    log("From Whs----" + UserValues.branch.toString());
    log("To Whs----" + toWhs.toString());

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDB_SaleReqHeader =
        await DBOperation.getStockHDReq(db, docentry);
    List<Map<String, Object?>> getDB_SaleReqLine =
        await DBOperation.getStockLReqHold(db, docentry);
    String salesReqHeader = json.encode(getDB_SaleReqHeader);
    String salesReqLine = json.encode(getDB_SaleReqLine);

    var ddd = json.encode({
      "ObjectType": 4,
      "ActionType": "Add",
      "StockRequestHeader": salesReqHeader,
      "StockRequestLine": salesReqLine,
    });
    log("payload : $ddd");

    //RabitMQ
    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();
//from
    // properties.headers = {"Branch": UserValues.branch};
    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    // exchange.publish(ddd, "", properties: properties);

    //cs

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);

    //ToBranch

    // properties.headers = {"Branch": toWhs};
    // exchange.publish(ddd, "", properties: properties);

    client1.close();
  }

  PostRabitMqStockReq2(int docentry, String toWhs) async {
    log("From Whs----" + UserValues.branch.toString());
    log("To Whs----" + toWhs.toString());

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDB_SaleReqHeader =
        await DBOperation.getStockHDReq(db, docentry);
    List<Map<String, Object?>> getDB_SaleReqLine =
        await DBOperation.getStockLReqHold(db, docentry);
    String salesReqHeader = json.encode(getDB_SaleReqHeader);
    String salesReqLine = json.encode(getDB_SaleReqLine);
    var ddd = json.encode({
      "ObjectType": 4,
      "ActionType": "Add",
      "StockRequestHeader": salesReqHeader,
      "StockRequestLine": salesReqLine,
    });
    log("payload : $ddd");

    //RabitMQ
    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();
//from
    properties.headers = {"Branch": UserValues.branch};
    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    exchange.publish(ddd, "", properties: properties);

    //cs

    // properties.headers = {"Branch": "Server"};
    // exchange.publish(ddd, "", properties: properties);

    //ToBranch

    properties.headers = {"Branch": toWhs};
    exchange.publish(ddd, "", properties: properties);

    client1.close();
  }
}
