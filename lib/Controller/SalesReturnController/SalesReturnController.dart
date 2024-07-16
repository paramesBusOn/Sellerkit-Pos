// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/DB%20Helper/DBhelper.dart';
import 'package:posproject/Models/DataModel/SalesOrderModel.dart';
import 'package:posproject/Models/ServiceLayerModel/SapInvoiceModel/Sapinvoicesmodel.dart';
import 'package:posproject/Service/AccountBalanceAPI.dart';
import 'package:posproject/ServiceLayerAPIss/InvoiceAPI/GetInvoicerAPI.dart';
import 'package:posproject/Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Screen.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DBModel/SalesReturnHeadT.dart';
import '../../DBModel/SalesReturnLineT.dart';
import '../../DBModel/SalesReturnPayT.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import '../../Models/DataModel/SalespaytoSalesRetPayModel/SalesPaytoSalesReturnpayModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';
import '../../Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
import '../../Models/ServiceLayerModel/SapInvoiceModel/InvPostingLineModel.dart';
import '../../Models/ServiceLayerModel/SapSalesReturnModel/ReturnPostingListModel.dart';
import '../../Models/ServiceLayerModel/SapSalesReturnModel/SapSaleReturnmodel.dart';
import '../../Pages/Sales Screen/Screens/MobileScreenSales/WidgetsMob/ContentcontainerMob.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/PostingReturnData.dart';
import '../../Widgets/AlertBox.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/GetReturnAPI.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/ReturnCloseAPI.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/ReturnLoginnAPI.dart';
import '../SalesInvoice/SalesInvoiceController.dart';

class SalesReturnController extends ChangeNotifier {
  Configure config = Configure();
  init() {
    clearAllData();
    getdraftindex();
    notifyListeners();
  }

  String? invDocumentStatus;
  List<TextEditingController> srmycontroller =
      List.generate(100, (i) => TextEditingController());
  PosController? posC;
  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  List<TextEditingController> mycontroller2 =
      List.generate(150, (i) => TextEditingController());

  List<TextEditingController> qtymycontroller =
      List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> qtymycontroller2 =
      List.generate(100, (ij) => TextEditingController());
  int selectedBillAdress = 0;
  int? get getselectedBillAdress => selectedBillAdress;
  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;

  bool enableModeBtn = true;
  bool freezeScrn = false;
  // bool
  bool searchbool = false;

  List<SalesModel> salesModel = [];
  List<StocksnapModelData> scannData = [];
  List<searchModel> searchData = [];
  bool validateqty = true;
  bool cancelbtn = false;
  List<searchModel> filtersearchData = [];
  List<StocksnapModelData> scanneditemData2 = [];
  List<StocksnapModelData> get getScanneditemData2 => scanneditemData2;
  TotalPayment? totalPayment2;
  List<PaymentWay> paymentWay2 = [];
  List<PaymentWay> get getpaymentWay2 => paymentWay2;

  double? totwieght2 = 0.0;
  double? totLiter2 = 0.0;
  double? totwieght = 0.0;
  double? totLiter = 0.0;
  String holddocentry = '';

  CustomerDetals? selectedcust;
  CustomerDetals? get getselectedcust => selectedcust;

  CustomerDetals? selectedcust55;
  CustomerDetals? get getselectedcust55 => selectedcust55;
  CustomerDetals? selectedcust2;
  CustomerDetals? get getselectedcust2 => selectedcust2;
  List<SalesModel> onHold = [];
  List<SalesModel>? onHoldFilter = [];
  String? totquantity;
  TextEditingController remarkcontroller3 = TextEditingController();

  List<StocksnapModelData> scanneditemData = [];
  List<StocksnapModelData> get getScanneditemData => scanneditemData;
  int? adddiscperunit;
  double adjustAmt = 0;
  List<SalesPaytoSalesRetModel> salespaytosalesreturn = [];
  String? sameInvNum;
  String? baldocentry;
  String? baseDocentry;

  String? balquantity;

  TotalPayment? totalPayment;
  TotalPayment? get gettotalPayment => totalPayment;

  PaymentWay? payment;
  PaymentWay? get getpayment => payment;
  List<PaymentWay> paymentWay = [];
  List<PaymentWay> get getpaymentWay => paymentWay;
  String? msgforAmount;
  String? get getmsgforAmount => msgforAmount;
  double? mycontlr;
  double salesretrcamt = 0;
  double salesCreditamt = 0;
  double accbal = 0;

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  String sapDocentry = '';
  int? sapBaseDocentry;

  String sapDocuNumber = '';
  String? seriesValue;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;

  List<ReturnDocumentLine> sapReturnLineData = [];
  List<Valuess> sapReturValuesData = [];

  List<ErrorModel> sererrorlist = [];

  clearAllData() {
    cancelbtn = false;
    onHoldFilter = [];
    selectedcust = null;
    validateqty = false;
    remarkcontroller3.text = '';
    invDocumentStatus = null;
    srmycontroller[1].text = '';
    salesCreditamt = 0.00;
    srmycontroller = List.generate(100, (i) => TextEditingController());
    formkey = List.generate(100, (i) => GlobalKey<FormState>());
    mycontroller = List.generate(150, (i) => TextEditingController());
    mycontroller2 = List.generate(150, (i) => TextEditingController());
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    qtymycontroller2 = List.generate(100, (ij) => TextEditingController());
    salespaytosalesreturn.clear();
    selectedcust = null;
    paymentWay.clear();
    // getSumTotalPaid2();
    // getBalancePaid2();
    scanneditemData.clear();
    srmycontroller[1].clear();
    // calCulateDocVal();
    accbal = 0;
    mycontlr = null;
    msgforAmount = null;
    holddocentry = '';
    paymentWay.clear();
    payment = null;
    totalPayment = null;
    salesCreditamt = 0;
    salesretrcamt = 0;
    balquantity = null;
    sameInvNum = null;
    adjustAmt = 0;
    adddiscperunit = null;
    scanneditemData2.clear();
    totquantity = null;
    onHold.clear();
    onHoldFilter = [];
    salesModel = [];
    selectedcust2 = null;
    totLiter = null;
    selectedShipAdress = 0;
    selectedBillAdress = 0;
    totwieght = null;
    totLiter2 = null;
    totwieght2 = null;
    paymentWay2.clear();
    totalPayment2 = null;
    filtersearchData.clear();
    searchbool = false;
    searchData.clear();
    enableModeBtn = true;
    freezeScrn = false;
    salesModel.clear();
    scannData.clear();
    sapBaseDocentry = null;

    itemsValetails = [];
    itemsDocDetails = [];
    clearbutton();
    nullErrorMsg();
  }

  // getsalesreturn() async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   DBOperation.getsalesreturnforSalesLine(db);
  //   notifyListeners();
  // }

//customer add

  getDate2(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (pickedDate != null && datetype == "From") {
      //print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[100].text = datetype!;
      //print(datetype);
    } else if (pickedDate != null && datetype == "To") {
      //print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[101].text = datetype!;
      //print(datetype);
    } else {
      //print("Date is not selected");
    }
  }

  filterSearchBoxList(String v) {
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

  searchInitMethod() {
    mycontroller[100].text = config.alignDate(config.currentDate());
    mycontroller[101].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  fixDataMethod(int docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getdbSaleretheader =
        await DBOperation.getSalesRetHeadDB(db, docentry);
    List<Map<String, Object?>> getdbSaleretline =
        await DBOperation.grtSalesRetLineDB(
            db, int.parse(getdbSaleretheader[0]['docentry'].toString()));
    List<Map<String, Object?>> getdbSaleretpay =
        await DBOperation.getSalesRetPayDB(
            db, int.parse(getdbSaleretheader[0]['docentry'].toString()));
    scanneditemData2.clear();
    sapDocuNumber = '';
    sapDocentry = '';
    totalPayment2 = null;
    totwieght2 = 0.0;
    totLiter2 = 0.0;
    selectedcust2 = null;
    mycontroller2[50].text = "";
    paymentWay2.clear();
    //  //log("header" + getDB_SaleRetHeader.length.toString());
    //  //log("line" + getDB_SaleRetLine.length.toString());
    //  //log("pay" + getDB_SaleRetPay.length.toString());
    if (getdbSaleretheader.isNotEmpty) {
      totwieght2 =
          double.parse(getdbSaleretheader[0]["totalweight"].toString());
      totLiter2 = double.parse(getdbSaleretheader[0]["totalltr"].toString());

      mycontroller2[50].text = getdbSaleretheader[0]["remarks"].toString();

      sapDocentry = getdbSaleretheader[0]["sapDocentry"] != null
          ? getdbSaleretheader[0]["sapDocentry"].toString()
          : "";
      //log(" getdbSaleretheade sapDocentry ::${getdbSaleretheader[0]["sapDocentry"].toString()}");
      sapDocuNumber = getdbSaleretheader[0]["sapDocNo"] != null
          ? getdbSaleretheader[0]["sapDocNo"].toString()
          : "";
      for (int i = 0; i < getdbSaleretline.length; i++) {
        scanneditemData2.add(StocksnapModelData(
            invoiceNo: getdbSaleretline[i]['documentno'].toString(),
            TransID: int.parse(getdbSaleretline[i]['lineID'].toString()),
            Branch: getdbSaleretline[i]['branch'].toString(),
            ItemCode: getdbSaleretline[i]['itemcode'].toString(),
            ItemName: getdbSaleretline[i]['itemcode'].toString(),
            SerialBatch: getdbSaleretline[i]['serialbatch'].toString(),
            OpenQty: int.parse(getdbSaleretline[i]['quantity'].toString()),
            Qty: int.parse(getdbSaleretline[i]['quantity'].toString()),
            InDate: getdbSaleretline[i][''].toString(),
            InType: getdbSaleretline[i][''].toString(),
            VenCode: getdbSaleretline[i][''].toString(),
            VenName: getdbSaleretline[i][''].toString(),
            MRP: 0,
            SellPrice: double.parse(getdbSaleretline[i]['price'].toString()),
            Cost: 0,
            TaxRate: double.parse(getdbSaleretline[i]['taxrate'].toString()),
            TaxType: '',
            Maxdiscount: getdbSaleretline[i]['discperc'] != null
                ? getdbSaleretline[i]['discperc'].toString()
                : '',
            discountper: getdbSaleretline[i]['discperc'] != null
                ? double.parse(getdbSaleretline[i]['discperc'].toString())
                : null,
            taxvalue: getdbSaleretline[i]['taxtotal'] != null
                ? double.parse(getdbSaleretline[i]['taxtotal'].toString())
                : 0.0,
            liter: getdbSaleretline[i]['liter'] != null
                ? double.parse(getdbSaleretline[i]['liter'].toString())
                : 0.0,
            weight: getdbSaleretline[i]['weight'] != null
                ? double.parse(getdbSaleretline[i]['weight'].toString())
                : 0.0));
        qtymycontroller2[i].text = getdbSaleretline[i]['quantity'].toString();
        notifyListeners();
      }
      int? totalPay = 0;
      for (int iss = 0; iss < scanneditemData2.length; iss++) {
        totalPay = totalPay! + scanneditemData2[iss].Qty!;
        notifyListeners();
      }
      // List<Address>? address2 = [];
      // List<CustomerAddressModelDB> csadresdataDB =
      //     await DBOperation.getCstmMasAddDB(
      //   db,
      // );
      // for (int k = 0; k < csadresdataDB.length; k++) {
      //   if (csadresdataDB[k].custcode.toString() ==
      //       getDBSalesHeader[0]['customercode'].toString()) {
      //     address2 = [
      //       Address(
      //           autoId: int.parse(csadresdataDB[k].autoid.toString()),
      //           address1: csadresdataDB[k].custcode,
      //           address2: csadresdataDB[k].custcode,
      //           address3: csadresdataDB[k].custcode,
      //           custcode: csadresdataDB[k].custcode,
      //           billCity: csadresdataDB[k].city!, //city
      //           billCountry: csadresdataDB[k].countrycode!, //country
      //           billPincode: csadresdataDB[k].pincode!, //pinno
      //           billstate: csadresdataDB[k].statecode)
      //     ];
      //   }
      // }
      //  //log("total quantity::" + totalPay.toString());
      selectedcust2 = CustomerDetals(
          name: getdbSaleretheader[0]["customername"].toString(),
          phNo: getdbSaleretheader[0]["customerphono"].toString(),
          cardCode: getdbSaleretheader[0]["customercode"].toString(),
          accBalance:
              double.parse(getdbSaleretheader[0]["customeraccbal"].toString()),
          point: getdbSaleretheader[0]["customerpoint"].toString(),
          address: [
            Address(
                address1: getdbSaleretheader[0]['billaddressid'].toString(),
                billCity: getdbSaleretheader[0]['city'].toString(),
                billCountry: getdbSaleretheader[0]['country'].toString(),
                billPincode: getdbSaleretheader[0]['pinno'].toString(),
                billstate: getdbSaleretheader[0]['state'].toString())
          ],
          tarNo: getdbSaleretheader[0]["taxno"].toString(),
          email: getdbSaleretheader[0]["customeremail"].toString(),
          invoiceDate: getdbSaleretheader[0]["createdateTime"].toString(),
          invoicenum: getdbSaleretheader[0]["documentno"].toString(),
          docentry: getdbSaleretheader[0]["docentry"].toString(),
          totalPayment: getdbSaleretheader[0]["doctotal"] == null
              ? 0.0
              : double.parse(getdbSaleretheader[0]["doctotal"]
                  .toString()
                  .replaceAll(',', '')));

      totalPayment2 = TotalPayment(
        subtotal: double.parse(getdbSaleretheader[0]['docbasic'] == null
            ? '0'
            : getdbSaleretheader[0]['docbasic']
                .toString()
                .replaceAll(',', '')), //doctotal
        discount2: double.parse(
            getdbSaleretheader[0]['docdiscamt'].toString().replaceAll(',', '')),
        totalTX: double.parse(
            getdbSaleretheader[0]['taxamount'].toString().replaceAll(',', '')),
        discount: double.parse(
            getdbSaleretheader[0]['docdiscamt'].toString().replaceAll(',', '')),
        total: totalPay != 0 ? totalPay : 0,
        // totalPayment!.total == null
        //     ? 0
        //     : double.parse(
        //         totalPayment!.total!.toString().replaceAll(',', '')),quantity

        totalDue: double.parse(getdbSaleretheader[0]['amtpaid'] == null
            ? '0'
            : getdbSaleretheader[0]['amtpaid'].toString().replaceAll(',', '')),
        totpaid: double.parse(getdbSaleretheader[0]['amtpaid'] == null
            ? '0'
            : getdbSaleretheader[0]['amtpaid'].toString().replaceAll(',', '')),
        balance: double.parse(
            getdbSaleretheader[0]['baltopay'].toString().replaceAll(',', '')),
      );

      for (int j = 0; j < getdbSaleretpay.length; j++) {
        paymentWay2.add(PaymentWay(
          amt: getdbSaleretpay[j]['rcamount'] != null
              ? double.parse(getdbSaleretpay[j]['rcamount'].toString())
              : null,
          type: getdbSaleretpay[j]['rcmode'].toString(),
          // dateTime: getDB_SaleRetPay[j]['createdateTime'].toString(),
          reference: getdbSaleretpay[j]['reference'] != null
              ? getdbSaleretpay[j]['reference'].toString()
              : '',
          // cardApprno: getDB_SaleRetPay[j]['cardApprno'] != null
          //     ? getDB_SaleRetPay[j]['cardApprno'].toString()
          //     : '',
          // cardref: getDB_SaleRetPay[j]['cardref'].toString(),
          // cardterminal: getDB_SaleRetPay[j]['cardterminal'].toString(),
          // chequedate: getDB_SaleRetPay[j]['chequedate'].toString(),
          // chequeno: getDB_SaleRetPay[j]['chequeno'].toString(),
          // couponcode: getDB_SaleRetPay[j]['couponcode'].toString(),
          // coupontype: getDB_SaleRetPay[j]['coupontype'].toString(),
          // discountcode: getDB_SaleRetPay[j]['discountcode'].toString(),
          // discounttype: getDB_SaleRetPay[j]['discounttype'].toString(),
          // // creditref: getDBholdSalespay[kk]['creditref'].toString(),
          // recoverydate: getDB_SaleRetPay[j]['recoverydate'].toString(),
          // redeempoint: getDB_SaleRetPay[j]['redeempoint'].toString(),
          // availablept: getDB_SaleRetPay[j]['rcmode'].toString(),
          // remarks: getDB_SaleRetPay[j]['remarks'].toString(),
          // // transref: getDBholdSalespay[kk]['transref'].toString(),
          // transtype: getDB_SaleRetPay[j]['transtype'].toString(),
          // walletid: getDB_SaleRetPay[j]['walletid'].toString(),
          // // walletref: getDBholdSalespay[kk]['walletref'].toString(),
          // wallettype: getDB_SaleRetPay[j]['wallettype'].toString(),
        ));
      }
    }
    notifyListeners();
  }

  clickacancelbtn(BuildContext context, ThemeData theme) async {
    if (sapDocentry.isEmpty || sapDocentry == null) {
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
        selectedcust2 = null;
        paymentWay2.clear();
        scanneditemData2.clear();
        notifyListeners();
        notifyListeners();
      });
    } else {
      await sapReturnLoginApi();
      await callSerlaySalesReturnAPI(context, theme);
      await callReturnCancelAPI(context, theme);
      notifyListeners();
    }
  }

  sapReturnLoginApi() async {
    final pref2 = await pref;

    await PostReturnLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          AppConstant.sapSessionID = '';
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          //print("sessionID: ${value.sessionId}");
          await getSession();
        }
      } else if (value.stCode! >= 400 && value.stCode! <= 410) {
        if (value.error!.code != null) {
          loadingscrn = false;
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            // margin: EdgeInsets.only(
            //   bottom: Screens.bodyheight(context) * 0.3,
            // ),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
            content: Text(
              "${value.error!.message!.value}\nCheck Your Sap Details !!..",
              style: const TextStyle(color: Colors.white),
            ),
          );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(const Duration(seconds: 5), () {
            exit(0);
          });
        }
      } else if (value.stCode == 500) {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          // margin: EdgeInsets.only(
          //   bottom: Screens.bodyheight(context) * 0.3,
          // ),
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
          // margin: EdgeInsets.only(
          //   bottom: Screens.bodyheight(context) * 0.3,
          // ),
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
    notifyListeners();
  }

  callSerlaySalesReturnAPI(BuildContext context, ThemeData theme) async {
    log("sapDocentrysapDocentrysapDocentry:::$sapDocentry");

    await SerlaySalesReturnAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.returnvalue!.isNotEmpty) {
          sapReturnLineData = value.returnvalue!;

          for (int i = 0; i < sapReturValuesData.length; i++) {
            // sapReturnLineData = sapReturValuesData[i].returnDocumentLines;

            //log("SapSaleReturnModelDataSapSaleReturnModelData::${sapReturnLineData[0].lineStatus}");

            custserieserrormsg = '';
          }
        } else {
          //log("Error11");
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        //log("Error22");
        cancelbtn = false;

        custserieserrormsg = value.error!.message!.value.toString();
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
          sapDocuNumber = '';
          selectedcust2 = null;
          paymentWay2.clear();
          scanneditemData2.clear();

          notifyListeners();
        });
        //log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
        notifyListeners();
        //log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
      } else {
        //log("Error33");
      }
    });
  }

  callReturnCancelAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    if (sapReturnLineData.isNotEmpty) {
      if (sapReturnLineData[0].lineStatus.toString() == "bost_Open") {
        //:bost_Close
        await SerlayReturnCancelAPI.getData(sapDocentry.toString())
            .then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 204) {
            cancelbtn = false;
            //log("sapReturnLineDatasapReturnLineDatasapReturnLineData::${sapReturnLineData[0].lineStatus}");

            await DBOperation.updateSaleRetclosedocsts(
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
              selectedcust2 = null;
              scanneditemData2.clear();
              selectedcust55 = null;
            });
            custserieserrormsg = '';
            // }
            //  else {
            //   log("Error11");

            //   // custserieserrormsg = value.message!.toString();
            // }
          } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
            cancelbtn = false;
            //log("Error22");
            custserieserrormsg = value.exception!.message!.value.toString();
            showDialog(
                context: context,
                barrierDismissible: false,
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
              sapDocuNumber = '';
            });
            //log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
          } else {
            //log("Error33");

            // custserieserrormsg = value.message!.toString();
          }
        });
      } else if (sapReturnLineData[0].lineStatus == "bost_Close") {
        cancelbtn = false;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: 'Document is already closed',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          sapDocentry = '';
          sapDocuNumber = '';

          selectedcust2 = null;
          paymentWay2.clear();
          scanneditemData2.clear();
          notifyListeners();
        });
        notifyListeners();
      }
    }
  }

  getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;
    ////log(fromdate);
    ////log(todate);

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getSalesRetHeaderDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));
    // List<Map<String, Object?>> getSalesLine =
    //     await DBOperation.getSalesRetLineDateWise(
    //         db, config.alignDate2(fromdate), config.alignDate2(todate));
    // List<Map<String, Object?>> getSalesPay =
    //     await DBOperation.getSalesRetPayDateWise(
    //         db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();

    for (int i = 0; i < getSalesHeader.length; i++) {
      searchdata2.add(searchModel(
          username: UserValues.username,
          terminal: AppConstant.terminal,
          // sapDocNo: getSalesHeader[i]["sapDocNo"] == null
          //     ? 0
          //     : int.parse(getSalesHeader[i]["sapDocNo"].toString()),
          qStatus: getSalesHeader[i]["qStatus"] == null
              ? ""
              : getSalesHeader[i]["qStatus"].toString(),
          docentry: getSalesHeader[i]["docentry"] == null
              ? 0
              : int.parse(getSalesHeader[i]["docentry"].toString()),
          docNo: getSalesHeader[i]["documentno"] == null
              ? "0"
              : getSalesHeader[i]["documentno"].toString(),
          docDate: getSalesHeader[i]["createdateTime"].toString(),
          sapNo: getSalesHeader[i]["sapDocNo"] == null
              ? 0
              : int.parse(getSalesHeader[i]["sapDocNo"].toString()),
          sapDate: getSalesHeader[i]["createdateTime"] == null
              ? ""
              : getSalesHeader[i]["createdateTime"].toString(),
          customeraName: getSalesHeader[i]["customername"].toString(),
          doctotal: getSalesHeader[i]["doctotal"] == null
              ? 0
              : double.parse(getSalesHeader[i]["doctotal"].toString())));
    }
    searchData.addAll(searchdata2);
    filtersearchData = searchData;

    //  //log("header::" + getSalesHeader.toString());
    //  //log("Line::" + getSalesLine.toString());
    //  //log("Pay::" + getSalesPay.toString());
    searchbool = false;
    notifyListeners();
  }
// addCustomer(BuildContext context) {
//     for (int i = 0; i < salesModel.length; i++) {
//       CustomerDetals selecust = CustomerDetals();
//       selecust.cardCode = salesModel[i].cardCode;
//       selecust.accBalance = double.parse(salesModel[i].accBalance.toString());
//       selecust.address = salesModel[i].address;
//       selecust.email = salesModel[i].email;
//       selecust.name = salesModel[i].custName;
//       selecust.phNo = salesModel[i].phNo;
//       selecust.point = salesModel[i].point;
//       selecust.tarNo = salesModel[i].tarNo;
  // selecust.invoicenum = salesModel[i].invoiceNum.toString();
  // selecust.invoiceDate = salesModel[i].invoceDate;
  // selecust.docentry = salesModel[i].transdocentry.toString();

//       //  //log("based doc entry::" + salesModel[i].docentry.toString());
//       //  //log("based doc num::" + selecust.invoicenum.toString());
//       //  //log("based basedoc entry::" + salesModel[i].transdocentry.toString());

//       //docentry
  // selecust.totalPayment = salesModel[i].totaldue != null
  //     ? double.parse(salesModel[i].totaldue.toString())
  //     : 00;
//       selectedcust = selecust;
//  //log("selectedcust!.email:::" + selectedcust!.email.toString());
//  //log("selectedcust!.tarno:::" + selectedcust!.tarNo.toString());
//       FocusScopeNode focus = FocusScope.of(context);
//       if (!focus.hasPrimaryFocus) {
//         focus.unfocus();
//       }
//       notifyListeners();
//     }
//   }
  String? basedocentryonqtyck;
  addCustomer() async {
    double? updateCustBal;
    final Database db = (await DBHelper.getInstance())!;
    for (int i = 0; i < salesModel.length; i++) {
      List<Map<String, Object?>> getDBholddata1 =
          await DBOperation.salestosalesret(
              db, salesModel[i].invoiceNum.toString());
      List<Map<String, Object?>> getcustaddd =
          await DBOperation.addgetCstmMasAddDB(
              db, salesModel[i].cardCode.toString());

      List<Map<String, Object?>> custData =
          await DBOperation.getCstmMasDatabyautoid(
              db, salesModel[i].cardCode.toString());
      //log("step1");
      selectedcust = CustomerDetals(
        autoId: custData[0]['autoid'].toString(),
        name: custData[0]['customername'].toString(),
        phNo: custData[0]['phoneno1'].toString(),
        cardCode: custData[0]['customercode'].toString(),
        accBalance: double.parse(custData[0]['balance'].toString()),
        point: custData[0]['points'].toString(),
        address: [],
        email: custData[0]['emalid'].toString(),
        tarNo: custData[0]['taxno'].toString(),
        invoicenum: salesModel[i].invoiceNum.toString(),
        invoiceDate: salesModel[i].invoceDate,
        docentry: salesModel[i].transdocentry.toString(),
      );
      notifyListeners();

      selectedcust55 = CustomerDetals(
        autoId: custData[0]['autoid'].toString(),
        name: custData[0]['customername'].toString(),
        phNo: custData[0]['phoneno1'].toString(),
        cardCode: custData[0]['customercode'].toString(),
        accBalance: double.parse(custData[0]['balance'].toString()),
        point: custData[0]['points'].toString(),
        address: [],
        email: custData[0]['emalid'].toString(),
        tarNo: custData[0]['taxno'].toString(),
      );
      notifyListeners();

      // selectedcust = selectedcust2;
      for (int ik = 0; ik < getDBholddata1.length; ik++) {
        basedocentryonqtyck = getDBholddata1[ik]['docentry'].toString();

        for (int i = 0; i < getcustaddd.length; i++) {
          if (getDBholddata1[ik]['billaddressid'].toString() != null ||
              getDBholddata1[ik]['billaddressid'].toString().isNotEmpty) {
            // log("step4");

            if (getDBholddata1[ik]['billaddressid'].toString() ==
                getcustaddd[i]['autoid'].toString()) {
              // log("step5");

              selectedcust!.address!.add(Address(
                autoId: int.parse(getcustaddd[i]['autoid'].toString()),
                addresstype: getcustaddd[i]['addresstype'].toString(),
                address1: getcustaddd[i]['address1'].toString(),
                address2: getcustaddd[i]['address2'].toString(),
                address3: getcustaddd[i]['address3'].toString(),
                billCity: getcustaddd[i]['city'].toString(),
                billCountry: getcustaddd[i]['countrycode'].toString(),
                billPincode: getcustaddd[i]['pincode'].toString(),
                billstate: getcustaddd[i]['statecode'].toString(),
              ));
              notifyListeners();
            }
          }
          notifyListeners();

          if (getDBholddata1[ik]['shipaddresid'].toString().isNotEmpty) {
            if (getDBholddata1[ik]['shipaddresid'].toString() ==
                getcustaddd[i]['autoid'].toString()) {
              selectedcust55!.address!.add(Address(
                autoId: int.parse(getcustaddd[i]['autoid'].toString()),
                addresstype: getcustaddd[i]['addresstype'].toString(),
                address1: getcustaddd[i]['address1'].toString(),
                address2: getcustaddd[i]['address2'].toString(),
                address3: getcustaddd[i]['address3'].toString(),
                billCity: getcustaddd[i]['city'].toString(),
                billCountry: getcustaddd[i]['countrycode'].toString(),
                billPincode: getcustaddd[i]['pincode'].toString(),
                billstate: getcustaddd[i]['statecode'].toString(),
              ));
            }
            notifyListeners();
          }
        }
        // log("step8");
      }
      notifyListeners();

      await AccountBalApi.getData(selectedcust!.cardCode.toString())
          .then((value) {
        loadingscrn = false;
        if (value.statuscode >= 200 && value.statuscode <= 210) {
          updateCustBal =
              double.parse(value.accBalanceData![0].balance.toString());
          // selectedcust55!.accBalance = double.parse(value.accBalanceData![0].balance.toString());
          notifyListeners();
        }
      });
      selectedcust!.accBalance =
          updateCustBal ?? double.parse(custData[0]['balance'].toString());
      selectedcust55!.accBalance =
          updateCustBal ?? double.parse(custData[0]['balance'].toString());
      notifyListeners();
      //log("step2");
      selectedcust!.totalPayment = salesModel[i].totaldue != null
          ? double.parse(salesModel[i].totaldue.toString())
          : 00;
      notifyListeners();
    }

    notifyListeners();
  }
//   /// product add

  invoiceScan(BuildContext context, ThemeData theme) async {
    salesCreditamt = 0;
    print("Step1");
    int? indx = await invoiceBatchAvail(
        srmycontroller[1].text.toString().toUpperCase().trim(), context, theme);
    if (indx != null) {
      //print("Step2");

      if (scanneditemData.isEmpty) {
        //print("Step3");

        await addCustomer();
        await addProductValue(indx);
        calCulateDocVal();
        btnEnabledfn();
        notifyListeners();
      }
    } else {
      //print("Step4");

      final Database db = (await DBHelper.getInstance())!;
      List<Map<String, Object?>> getsalesretrunvaltDB =
          await DBOperation.getsalesretrunalertDB(
              db, srmycontroller[1].text.toString().toUpperCase().trim());
      if (getsalesretrunvaltDB.isNotEmpty) {
        log("Step51::${getsalesretrunvaltDB[0]['basedocnum'].toString()} && ${srmycontroller[1].text.toString().toUpperCase().trim()}");

        if (srmycontroller[1].text.toString().toUpperCase().trim() ==
            getsalesretrunvaltDB[0]['basedocnum'].toString().trim()) {
          //print("Step6");
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
                        content: 'This Document is Already Returned..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
        }
      } else {
        //print("Step7");

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
                      content: 'Wrong Document Scanned..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }

      //     int? arSc = await checkSameSerialBatchScnd(sameInvNum!.toString());
      //     //  //log("arSc $arSc");
      //     if (arSc != null) {
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
      //               content: 'This Document is Already Returned..!!',
      //               theme: theme,
      //             )),
      //             buttonName: null,
      //           ));
      //     });
      //     } else {
      //       addProductValue(indx);
      //       calCulateDocVal();
      //     }
      //     notifyListeners();
    }
    // } else if (indx == null) {
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
    //               content: 'Wrong Invoice scanned..!!',
    //               theme: theme,
    //             )),
    //             buttonName: null,
    //           ));
    //     });
    totalcalculate();
    srmycontroller[1].text = '';
  }

  clearData() {
    selectedcust = null;
    notifyListeners();
  }

  clearSuspendedData(BuildContext context, ThemeData theme) {
    selectedcust = null;
    selectedcust55 = null;
    validateqty = false;
    remarkcontroller3.text = '';
    mycontroller[50].clear();
    paymentWay.clear();
    totalPayment = null;
    srmycontroller[1].text = "";
    scanneditemData = [];
    notifyListeners();
    Get.defaultDialog(
            title: "Success",
            middleText: "Suspended Sucessfully..!!",
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
      freezeScrn = false;
      notifyListeners();
    });
//  showDialog(
//               context: context,
//               barrierDismissible: true,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                     contentPadding: EdgeInsets.all(0),
//                     content: AlertBox(
//                       payMent: 'Alert',
//                       errormsg: true,
//                       widget: Center(
//                           child: ContentContainer(
//                         content: 'No more qty to add..!!',
//                         theme: theme,
//                       )),
//                       buttonName: null,
//                     ));
//               }).then((value) {

//     scanneditemData.clear();
//     paymentWay.clear();
//     totalPayment = null;
//     mycontroller[1].clear();
//     srmycontroller[1].clear();
//     selectedcust = null;
//     notifyListeners();
//               });
  }

  Future<int?> checkSameSerialBatchScnd(String invc) async {
    print(invc);
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].invoiceNo == invc) {
        if (scanneditemData[i].Qty == null) {
          return Future.value(i);
        }
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  addProductValue(ik) async {
    // for (int i = 0; i < salesModel.length; i++) {
    //  //log("ins ins ins:$ik");

    addProductItem(ik);
    notifyListeners();
    // }
    calCulateDocVal();

    notifyListeners();
    // paymentDetails();
  }

  addProductItem(int ins) {
    for (int i = 0; i < salesModel[ins].item!.length; i++) {
      scanneditemData.add(StocksnapModelData(
          basedocentry: salesModel[ins].item![i].basedocentry,
          baselineid: salesModel[ins].item![i].baselineid,
          basic: salesModel[ins].item![i].basic,
          discount: salesModel[ins].item![i].discount,
          netvalue: salesModel[ins].item![i].netvalue,
          taxable: salesModel[ins].item![i].taxable,
          taxvalue: salesModel[ins].item![i].taxvalue ?? 00,
          TransID: salesModel[ins].item![i].TransID,
          Branch: salesModel[ins].item![i].Branch,
          ItemCode: salesModel[ins].item![i].ItemCode,
          ItemName: salesModel[ins].item![i].ItemName,
          SerialBatch: salesModel[ins].item![i].SerialBatch,
          OpenQty: salesModel[ins].item![i].OpenQty,
          Qty: salesModel[ins].item![i].Qty,
          InDate: salesModel[ins].item![i].InDate,
          InType: salesModel[ins].item![i].InType,
          VenCode: salesModel[ins].item![i].VenCode,
          VenName: salesModel[ins].item![i].VenName,
          MRP: salesModel[ins].item![i].MRP,
          SellPrice: salesModel[ins].item![i].SellPrice,
          Cost: salesModel[ins].item![i].Cost,
          TaxRate: salesModel[ins].item![i].TaxRate,
          TaxType: salesModel[ins].item![i].TaxType,
          invoiceNo: salesModel[ins].item![i].invoiceNo,
          Maxdiscount: salesModel[ins].item![i].Maxdiscount,
          discountper: salesModel[ins].item![i].discountper,
          liter: salesModel[ins].item![i].liter,
          weight: salesModel[ins].item![i].weight));

      notifyListeners();
    }
    qtychangemtd(ins);
    // paymentDetails();
    calCulateDocVal();
    notifyListeners();
  }

  qtychangemtd(int ind) {
    for (int ir = 0; ir < scanneditemData.length; ir++) {
      qtymycontroller[ir].text = scanneditemData[ir].Qty.toString();
    }
  }

  callSerlaySalesQuoAPI() async {
    invDocumentStatus = null;
    await SerlaySalesInvoiceAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        invDocumentStatus = value.documentStatus;
        //log("sapInvocieModelDatasapInvocieModelData::$invDocumentStatus");
        custserieserrormsg = '';
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        //log("Error22");
        custserieserrormsg = value.error!.message!.value.toString();
        Get.defaultDialog(
                title: "Alert",
                middleText: '$custserieserrormsg',
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
          freezeScrn = false;

          notifyListeners();
        });
        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //           contentPadding: const EdgeInsets.all(0),
        //           content: AlertBox(
        //             payMent: 'Alert',
        //             errormsg: true,
        //             widget: Center(
        //                 child: ContentContainer(
        //               content: '$custserieserrormsg',
        //               theme: theme,
        //             )),
        //             buttonName: null,
        //           ));
        //     }).then((value) {
        //   sapDocentry = '';
        //   sapDocuNumber = '';
        //   selectedcust2 = null;
        //   paymentWay2.clear();
        //   scanneditemData2.clear();
        //   notifyListeners();
        // });

        // custserieserrormsg = value.message!.toString();
      }
    });
  }

  // deleteHldFullyRetData() async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   int balqty = 0;
  //   int salesBalqty = 0;

  //   List<Map<String, Object?>> getDBReturnData1 = await DBOperation.getSalesRetCkoutHeadDB(db);
  //   log("getDBReturnData1.length::${getDBReturnData1.length}");
  //   if (getDBReturnData1.length > 0) {
  //     for (int im = 0; im < getDBReturnData1.length; im++) {
  //       balqty = 0;
  //       salesBalqty = 0;
  //  //log("getDBReturnData basedocentry::${getDBReturnData1[im]['basedocentry']}");
  //       List<Map<String, Object?>> getDBReturnLineData1 = await DBOperation.grtSalesRetLineDB(db, int.parse(getDBReturnData1[im]['docentry'].toString()));
  //       for (int ik = 0; ik < getDBReturnLineData1.length; ik++) {
  //         List<Map<String, Object?>> getDBSalesLineData1 = await DBOperation.holdSalesLineDB(db, int.parse(getDBReturnData1[im]['basedocentry'].toString()));
  //         for (int ij = 0; ij < getDBSalesLineData1.length; ij++) {
  //           if (getDBReturnData1[im]['basedocentry'] == getDBSalesLineData1[ij]['docentry']) {
  //             balqty = balqty + int.parse(getDBReturnLineData1[ik]['quantity'].toString());
  //             salesBalqty = int.parse(getDBSalesLineData1[ik]['quantity'].toString());
  //             notifyListeners();
  //             break;
  //           }
  //         }
  //       }
  //       notifyListeners();
  //     }

  ////log("balqty::${balqty}-----------salesBalqty::${salesBalqty}");
  //     if (balqty == salesBalqty) {
  //       notifyListeners();

  //  //log("delete draft");
  //     } else {
  //  //log('not Deleted');
  //     }
  //   } else {}
  // }

  Future<int?> invoiceBatchAvail(
      String invcno, BuildContext context, ThemeData theme) async {
    salesModel = [];
    scannData = [];
    scanneditemData = [];
    selectedcust = null;
    totLiter = 0.00;
    totwieght = 0.00;
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.salestosalesret(db, invcno.toString().trim());
    for (int i = 0; i < getDBholddata1.length; i++) {
      //log('invoice invoice invoice:$invcno:::${getDBholddata1.length}');
      if (getDBholddata1[i]['sapDocNo'].toString() == invcno) {
        List<Map<String, Object?>> getDBholdSalesLine =
            await DBOperation.saleslinegetbalqty(
                db, getDBholddata1[i]['docentry'].toString());
        if (getDBholdSalesLine.isNotEmpty) {
          baldocentry = getDBholddata1[i]['docentry'].toString();
          //log(" baldocentry ::${baldocentry}");
          sameInvNum = getDBholddata1[i]['documentno'].toString();
          sapDocentry = getDBholddata1[i]['sapDocentry'].toString();
          sapDocuNumber = getDBholddata1[i]['sapDocNo'].toString();
          sapBaseDocentry =
              int.parse(getDBholddata1[i]['sapDocentry'].toString());
          // await sapReturnLoginApi();
          // await callSerlaySalesQuoAPI();
          totLiter = double.parse(getDBholddata1[i]['totalltr'].toString());
          totwieght = double.parse(getDBholddata1[i]['totalweight'].toString());
          for (int ik = 0; ik < getDBholdSalesLine.length; ik++) {
            scannData.add(StocksnapModelData(
              basedocentry: getDBholddata1[i]['docentry'].toString(),
              baselineid: getDBholdSalesLine[ik]['lineID'].toString(),
              // basedocentry: invDocumentStatus.toString() == "bost_Open" ? getDBholddata1[i]['docentry'].toString() : null,
              // baselineid: invDocumentStatus.toString() == "bost_Open" ? getDBholdSalesLine[ik]['lineID'].toString() : null,
              invoiceNo: getDBholddata1[i]['documentno'].toString(),
              TransID: int.parse(getDBholdSalesLine[ik]['lineID'].toString()),
              Branch: getDBholdSalesLine[ik]['branch'].toString(),
              ItemCode: getDBholdSalesLine[ik]['itemcode'].toString(),
              ItemName: getDBholdSalesLine[ik]['itemname'].toString(),
              SerialBatch: getDBholdSalesLine[ik]['serialbatch'].toString(),
              OpenQty: int.parse(getDBholdSalesLine[ik]['quantity'].toString()),
              Qty: int.parse(getDBholdSalesLine[ik]['balqty'].toString()),
              InDate: getDBholdSalesLine[ik][''].toString(),
              InType: getDBholdSalesLine[ik][''].toString(),
              VenCode: getDBholdSalesLine[ik][''].toString(),
              VenName: getDBholdSalesLine[ik][''].toString(),
              MRP: 0,
              SellPrice:
                  double.parse(getDBholdSalesLine[ik]['price'].toString()),
              Cost: 0,
              TaxRate:
                  double.parse(getDBholdSalesLine[ik]['taxrate'].toString()),
              TaxType: '',
              Maxdiscount: getDBholdSalesLine[ik]['discperc'] != null
                  ? getDBholdSalesLine[ik]['discperc'].toString()
                  : '',
              discountper: getDBholdSalesLine[ik]['discperc'] != null
                  ? double.parse(getDBholdSalesLine[ik]['discperc'].toString())
                  : null,
              liter: getDBholdSalesLine[ik]['liter'] == null
                  ? 0.00
                  : double.parse(getDBholdSalesLine[ik]['liter'].toString()),
              weight: getDBholdSalesLine[ik]['weight'] == null
                  ? 0.00
                  : double.parse(getDBholdSalesLine[ik]['weight'].toString()),
            ));
          }
          notifyListeners();

          List<Map<String, Object?>> getDBholdSalespaydk =
              await DBOperation.getSalespaycreditCkout(
            db,
            int.parse(getDBholddata1[i]['docentry'].toString()),
          );
          for (int ii = 0; ii < getDBholdSalespaydk.length; ii++) {
            if (getDBholddata1[i]['docentry'].toString() ==
                getDBholdSalespaydk[ii]['docentry'].toString()) {
              salespaytosalesreturn.add(SalesPaytoSalesRetModel(
                  salesrcmode: getDBholdSalespaydk[ii]['rcmode'].toString(),
                  salesrcamt: double.parse(
                      getDBholdSalespaydk[ii]['rcamount'].toString()),
                  docentry: getDBholddata1[i]['docentry'].toString()));
              notifyListeners();
            }
          }

          List<Map<String, Object?>> getadjustamt =
              await DBOperation.adjustcreditamt(
                  db, int.parse(getDBholddata1[i]['docentry'].toString()));
          for (int iv = 0; iv < getadjustamt.length; iv++) {
            //  //log("Adjust Credit Amt");
            adjustAmt =
                double.parse(getadjustamt[iv]['adjustedamt'].toString());

            //  //log("Get Adjusted Amount:$adjustAmt");
          }
          List<Address> addressadd = [];
          List<Map<String, Object?>> csadresdataDB =
              await DBOperation.addgetCstmMasAddDB(
                  db, getDBholddata1[i]['customercode'].toString());
          for (int ia = 0; ia < csadresdataDB.length; ia++) {
            addressadd.add(Address(
              autoId: int.parse(csadresdataDB[ia]['autoid'].toString()),
              address1: csadresdataDB[ia]['address1'].toString(),
              address2: csadresdataDB[ia]['address2'].toString(),
              address3: csadresdataDB[ia]['address3'].toString(),
              billCity: csadresdataDB[ia]['city'].toString(),
              billCountry: csadresdataDB[ia]['countrycode'].toString(),
              billPincode: csadresdataDB[ia]['pincode'].toString(),
              billstate: csadresdataDB[ia]['statecode'].toString(),
            ));
          }

          SalesModel salesM = SalesModel(
            totaldue: double.parse(getDBholddata1[i]['doctotal'] == null
                ? '0'
                : getDBholddata1[i]['doctotal'].toString().replaceAll(',', '')),
            docentry: int.parse(getDBholddata1[i]['docentry'].toString()),
            transdocentry: getDBholddata1[i]['docentry'].toString(),
            custName: getDBholddata1[i]['customername'].toString(),
            phNo: getDBholddata1[i]['customerphono'].toString(),
            cardCode: getDBholddata1[i]['customercode'].toString(),
            accBalance: getDBholddata1[i]['customeraccbal'].toString(),
            point: getDBholddata1[i]['customerpoint'].toString(),
            tarNo: getDBholddata1[i]['taxno'] != null
                ? getDBholddata1[i]['taxno'].toString()
                : '',
            email: getDBholddata1[i]['customeremail'] != null
                ? getDBholddata1[i]['customeremail'].toString()
                : "",
            invoceDate: getDBholddata1[i]['createdateTime'].toString(),
            invoiceNum: getDBholddata1[i]['documentno'].toString(),
            invoceAmount: double.parse(getDBholddata1[i]['doctotal'] == null
                ? '0'
                : getDBholddata1[i]['doctotal'].toString().replaceAll(',', '')),
            address: addressadd,
            totalPayment: TotalPayment(
              totalTX: double.parse(getDBholddata1[i]['taxamount'] == null
                  ? '0'
                  : getDBholddata1[i]['taxamount'].toString()),
              subtotal: double.parse(getDBholddata1[i]['docbasic'] == null
                  ? '0'
                  : getDBholddata1[i]['docbasic']
                      .toString()
                      .replaceAll(',', '')), //doctotal
              discount2: double.parse(getDBholddata1[i]['docdiscamt'] != null
                  ? getDBholddata1[i]['docdiscamt'].toString()
                  : '0'),
              discount: double.parse(getDBholddata1[i]['docdiscamt'] != null
                  ? getDBholddata1[i]['docdiscamt'].toString()
                  : '0'),
              totalDue: double.parse(getDBholddata1[i]['doctotal'] == null
                  ? '0'
                  : getDBholddata1[i]['doctotal']
                      .toString()
                      .replaceAll(',', '')),
              totpaid: double.parse(getDBholddata1[i]['amtpaid'] == null
                  ? '0'
                  : getDBholddata1[i]['amtpaid']
                      .toString()
                      .replaceAll(',', '')),
              balance: double.parse(getDBholddata1[i]['baltopay'] != null
                  ? getDBholddata1[i]['baltopay'].toString().replaceAll(',', '')
                  : '0'),
            ),
            item: scannData,
          );
          notifyListeners();

          salesModel.add(salesM);
          notifyListeners();

          return Future.value(i);
        }
        // }
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  balanceqtycheck(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    log("basedocentryonqtyck::$basedocentryonqtyck");
    validateqty = true;
    List<Map<String, Object?>> getSalRethead =
        await DBOperation.getSalesRetHeaderDB(db, baldocentry.toString());
    if (getSalRethead.isNotEmpty) {
      List<Map<String, Object?>> getDBSalesLine =
          await DBOperation.saleslinegetbalqty(db, baldocentry.toString());
      if (getDBSalesLine.isNotEmpty) {
        for (int i = 0; i < scanneditemData.length; i++) {
          //log("step1");

          for (int ik = 0; ik < getDBSalesLine.length; ik++) {
            //log("step2:getDBSalesLine[ik]['balqty:${getDBSalesLine[ik]['balqty']}");
            //log("qtymycontroller[ik].text::${qtymycontroller[i].text}");

            if (int.parse(getDBSalesLine[ik]['balqty'].toString()) >=
                int.parse(qtymycontroller[i].text)) {
              //log("step3");

              validateqty = true;
            } else {
              //log("step4");
              validateqty = false;
              break;
            }
          }
          // return ik;
        }
      }
    } else {
      List<Map<String, Object?>> getDBholdSalesLine =
          await DBOperation.saleslinegetbalqty(db, baldocentry.toString());
      for (int i = 0; i < scanneditemData.length; i++) {
        for (int ih = 0; ih < getDBholdSalesLine.length; ih++) {
          //log("getDBholdSalesLine[ih]['balqty'].toString():${getDBholdSalesLine[ih]['balqty']}");
          //log('qtymycontroller[i].text:${qtymycontroller[i].text}');
          if (int.parse(getDBholdSalesLine[ih]['balqty'].toString()) >=
              int.parse(qtymycontroller[i].text)) {
            validateqty = true;
          } else {
            validateqty = false;
            break;
          }
        }
      }
    }

    // List<Map<String, Object?>> getadjustqty =
    //     await DBOperation.getSalesRetbalamtDB(
    //         db,
    //         getSalRetlinet[i]['basedocentry'].toString(),
    // getSalRetlinet[i]['baselineID'].toString());
    // for (int ik = 0; ik < scanneditemData.length; ik++) {

    //   for (int ig = 0; ig < getadjustqty.length; ig++) {
    //     if (validateqty = false) {
    //       if (int.parse(getadjustqty[ig]['balqty'].toString()) >
    //           int.parse(qtymycontroller[ik].text.toString())) {
    //         // saveSalRetValuesTODB('confirm return', context, theme);
    //       }
    //       else{
    //         validateqty = true;
    //       }
    //     }
    //   }
    //   // else if (validateqty = true) {
    //   //   showDialog(
    //   //       context: context,
    //   //       barrierDismissible: true,
    //   //       builder: (BuildContext context) {
    //   //         return AlertDialog(
    //   //             contentPadding: EdgeInsets.all(0),
    //   //             content: AlertBox(
    //   //               payMent: 'Alert',
    //   //               errormsg: true,
    //   //               widget: Center(
    //   //                   child: ContentContainer(
    //   //                 content: "Can't Return  More Qty than Invoiced",
    //   //                 theme: theme,
    //   //               )),
    //   //               buttonName: null,
    //   //             ));
    //   //       });
    //   // } else {
    //   //   log("KKKKKKKKKKKKKKKKK");
    //   // }
    //   // }
    // }
    // }
  }

  itemIncrement(int ind, BuildContext context, ThemeData theme) {
    int qtyctrl = int.parse(qtymycontroller[ind].text);
    for (int i = 0; i < scannData.length; i++) {
      if (scannData[i].SerialBatch == scanneditemData[ind].SerialBatch) {
        if (scannData[i].Qty! > qtyctrl) {
          //  //log("data qty greater");
          qtyctrl = qtyctrl + 1;
          //  //log("qtyctrlqtyctrl::" + qtyctrl.toString());
          qtymycontroller[ind].text = qtyctrl.toString();
          FocusScopeNode focus = FocusScope.of(context);
          calCulateDocVal();

          if (!focus.hasPrimaryFocus) {
            focus.unfocus();
          }
          notifyListeners();
          break;
        } else {
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
                        content: 'No more qty to add..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
          notifyListeners();

          break;
        }
      }
    }
    // paymentDetails();
    notifyListeners();
  }

  // itemIncrement11(int ind, BuildContext context, ThemeData theme) {
  //   // int qtyctrl = int.parse(qtymycontroller[ind].text);
  //   for (int i = 0; i < scannData.length; i++) {
  //     // //  //log("-----itemdata"+itemData[i].SerialBatch.toString());
  //     // //  //log("-----scanitemdate"+scanneditemData[ind].SerialBatch.toString());
  //     //       //  //log("-----index"+ind.toString());

  //     if (scannData[i].SerialBatch == scanneditemData[ind].SerialBatch) {
  //     //  //log("------------------------------------------------------------------");
  //       if (itemData[i].Qty! > int.parse(qtymycontroller[ind].text)) {
  //         if (int.parse(qtymycontroller[ind].text) != 0) {
  //           //   // //log("data qty greater");
  //           //   // //log("qtyctrlqtyctrl::" +
  //           //   //     int.parse(qtymycontroller[ind].text).toString());
  //           //   qtymycontroller[ind].text =
  //           //       (int.parse(qtymycontroller[ind].text)).toString();
  //           calCulateDocVal();
  //           //   FocusScopeNode focus = FocusScope.of(context);
  //           // if (!focus.hasPrimaryFocus) {
  //           //   focus.unfocus();
  //           // }
  //           //   notifyListeners();
  //           //   break;
  //         } else if (int.parse(qtymycontroller[ind].text) == 0) {
  //         //  //log("----------------" + qtymycontroller[ind].text);
  //           qtymycontroller.removeAt(ind);
  //           scanneditemData.removeAt(ind);

  //           calCulateDocVal();

  //           notifyListeners();
  //         }
  //       } else {
  //         qtymycontroller[ind].text = "";
  //         showDialog(
  //             context: context,
  //             barrierDismissible: true,
  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                   contentPadding: EdgeInsets.all(0),
  //                   content: AlertBox(
  //                     payMent: 'Alert',
  //                     errormsg: true,
  //                     widget: Center(
  //                         child: ContentContainer(
  //                       content: 'No more qty to add..!!',
  //                       theme: theme,
  //                     )),
  //                     buttonName: null,
  //                   ));
  //             });
  //         notifyListeners();

  //         // break;
  //       }
  //     }
  //   }

  //   notifyListeners();
  // }
  itemIncrement11(int ind, BuildContext context, ThemeData theme) {
    // int qtyctrl = int.parse(qtymycontroller[ind].text);
    for (int i = 0; i < scannData.length; i++) {
      //log("scannData[i].Qty::${scannData[i].Qty}");
      if (scannData[i].SerialBatch.toString() ==
          scanneditemData[ind].SerialBatch.toString()) {
        if (scannData[i].Qty! >= int.parse(qtymycontroller[ind].text)) {
          if (int.parse(qtymycontroller[ind].text) != 0) {
            calCulateDocVal();
            FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus) {
              focus.unfocus();
            }
            notifyListeners();
            // break;
          } else if (int.parse(qtymycontroller[ind].text) == 0) {
            scanneditemData.removeAt(ind);
            qtymycontroller.removeAt(ind);
            mycontroller.removeAt(ind);
            calCulateDocVal();
            notifyListeners();
          }
        } else {
          qtymycontroller[ind].text = 1.toString();
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
                        content: 'No more qty to add..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
          notifyListeners();

          break;
        }
      }
    }

    notifyListeners();
  }
  // itemIncrement(int ind, BuildContext context, ThemeData theme) {
  //   print("YYYYY");
  // //  //log("scannData.length::::" + scannData.length.toString());
  //   for (int i = 0; i < scannData.length; i++) {
  //     if (scannData[i].SerialBatch == scanneditemData[ind].SerialBatch) {
  //     //  //log("data serial same");
  //       if (scannData[i].Qty! > scanneditemData[ind].Qty!) {
  //       //  //log("data qty greater");
  //         scanneditemData[ind].Qty = scanneditemData[ind].Qty! + 1;
  //         FocusScopeNode focus = FocusScope.of(context);
  //         if (!focus.hasPrimaryFocus) {
  //           focus.unfocus();
  //         }
  //         notifyListeners();
  //         break;
  //       } else {
  //         // config.showDialogBox('Alert', 'No  more Qty to add..!!', context);
  //         showDialog(
  //             context: context,
  //             barrierDismissible: true,
  //             builder: (BuildContext context) {
  //               return AlertDialog(
  //                   contentPadding: EdgeInsets.all(0),
  //                   content: AlertBox(
  //                     payMent: 'Alert',
  //                     errormsg: true,
  //                     widget: Center(
  //                         child: ContentContainer(
  //                       content: 'No more qty to add..!!',
  //                       theme: theme,
  //                     )),
  //                     buttonName: null,
  //                   ));
  //             });
  //         notifyListeners();

  //         break;
  //       }
  //     }
  //   }

  //   calCulateDocVal();
  //   // paymentDetails();
  //   notifyListeners();
  // }

  itemdecrement(int ind) {
    if (scanneditemData[ind].Qty! > 1) {
      scanneditemData[ind].Qty = scanneditemData[ind].Qty! - 1;
      notifyListeners();
    } else {
      scanneditemData.removeAt(ind);
      notifyListeners();
    }
    // paymentDetails();
    calCulateDocVal();
  }

  nullErrorMsg() {
    msgforAmount = null;
    paymentterm = null;
    wallet = null;
    selectedType = null;
    coupon = null;
    discount = null;
    clearTextField();
    notifyListeners();
  }

  //drop downs
  String? selectedType;
  List<String> transType = ['NEFT', 'RTGS', 'IMPS', 'UPI'];
  List<String> get gettransType => transType;

  bool hintcolor = false;
  bool get gethintcolor => hintcolor;
  List payTerminal = [
    "HDFC Machine",
    'Pinelabs Machine - 1',
    'Pinelabs - Accessories',
    'Pinelabs - 2nd Counter'
  ];
  List get getpayTerminal => payTerminal;
  String? paymentterm;

  List walletlist = ['GPAY', 'PAYTM', 'UPI', 'PHONEPE', 'BAHRAT PE'];
  List get getwalletlist => walletlist;
  String? wallet;

  List couponlist = [
    'GROUPON',
    'AMAZON PAY',
    'FLIPKART CORPORATE',
    'HDFC GIFTPLUS',
    'ICICI GIFT COUPON',
    'UNILET COUPONS',
    'INSIGNIA COUPONS'
  ];
  List get getcouponlist => couponlist;
  String? coupon;
  List discountType = [
    'Credit Note Discount',
    'Manager Discount',
    'Sellout Benefit',
    'Volume Discount',
    'ICICI GIFT COUPON',
    'Kitty Discount',
    'BuyBack Discount'
  ];
  List get getdiscountType => discountType;
  String? discount;

  clearTextField() {
    mycontroller[13].clear();
    mycontroller[14].clear();
    mycontroller[15].clear();
    mycontroller[16].clear();
    mycontroller[17].clear();
    mycontroller[18].clear();
    mycontroller[19].clear();
    mycontroller[21].clear();
    mycontroller[22].clear();
    mycontroller[23].clear();
    mycontroller[24].clear();
    mycontroller[25].clear();
    mycontroller[26].clear();
    mycontroller[27].clear();
    mycontroller[28].clear();
    mycontroller[29].clear();
    mycontroller[30].clear();
    mycontroller[31].clear();
    mycontroller[32].clear();
    mycontroller[33].clear();
    mycontroller[34].clear();
    mycontroller[35].clear();
    mycontroller[36].clear();
    mycontroller[37].clear();
    mycontroller[38].clear();
    mycontroller[39].clear();
    mycontroller[40].clear();
    mycontroller[41].clear();
    mycontroller[42].clear();
    mycontroller[43].clear();
    mycontroller[44].clear();
    mycontroller[45].clear();

    selectedType = null;
    notifyListeners();
  }
// payment

  // paymentDetails() {
  //   if (scanneditemData.length < 1) {
  //     TotalPayment totalPay = new TotalPayment();
  //     totalPay.total = 0.00;
  //     totalPay.discount = 0.00;
  //     totalPay.discount2 = 0.00;
  //     totalPay.subtotal = 0.00;
  //     totalPay.totalTX = 0.00;
  //     totalPay.totalDue = 0.00;
  //     totalPayment = totalPay;
  //     notifyListeners();
  //   } else {
  //     TotalPayment totalPay = new TotalPayment();
  //     totalPay.total = getNoOfQty();
  //     totalPay.discount = getDiscount();
  //     totalPay.discount2 = getDiscount();
  //     totalPay.subtotal = getNoSubTotal();
  //     totalPay.totalTX = getTotalTax();
  //     totalPay.totalDue = ((getNoSubTotal() + getTotalTax()) - getDiscount());
  //     totalPayment = totalPay;
  //     notifyListeners();
  //   }
  // }
  // double totallamountt = 0;
  clearbutton() {
    scanneditemData2.clear();
    selectedcust2 = null;
    totalPayment2 = null;
    paymentWay2.clear();
    scanneditemData.clear();
    selectedcust = null;
    totalPayment = null;
    paymentWay.clear();
    // getdraftindex();
    // getsalesreturn();
    mycontroller2[50].text = "";
    notifyListeners();
  }

  double totalcalculate() {
    double totallamountt = 0;
    totallamountt = getBalancePaid2() - salesCreditamt;
    //  //log("totallamountttotallamountt11111:::" +
    // totallamountt.toStringAsFixed(2));
    if (paymentWay.isNotEmpty) {
      for (int i = 0; i < paymentWay.length; i++) {
        if (paymentWay[i].type == "OnAccount") {
          totallamountt = (totallamountt + salesCreditamt);
          //  //log("totalamountttotalamountt::" + totallamountt.toStringAsFixed(2));
          return totallamountt;
        }
      }
    } else {
      //  //log("totallamountttotallamountt2222:::" +
      // totallamountt.toStringAsFixed(2));
      return totallamountt;
    }
    //  //log("totallamountttotallamountt33333:::" +
    // totallamountt.toStringAsFixed(2));
    return totallamountt;
  }

  calCulateDocVal() async {
    salesCreditRcAmt();
    calculateLineVal();
    TotalPayment totalPay = TotalPayment();
    totalPay.total = 0;
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.totalDue = 0.00;
    for (int iss = 0; iss < scanneditemData.length; iss++) {
      totalPay.total = totalPay.total! + scanneditemData[iss].Qty!;
      totalPay.subtotal = (totalPay.subtotal! + scanneditemData[iss].basic!);
      totalPay.discount = totalPay.discount! + scanneditemData[iss].discount!;
      totalPay.totalTX = totalPay.totalTX! + scanneditemData[iss].taxvalue!;
      totalPay.totalDue = (totalPay.totalDue! + scanneditemData[iss].netvalue!);
      //  //log("qty::::" + scanneditemData[iss].Qty!.toString());
      //  //log("liter::::" + scanneditemData[iss].liter.toString());
      final Database db = (await DBHelper.getInstance())!;
      double weight = 0.0;
      double liter = 0.0;

      List<Map<String, Object?>> getWeightLiter =
          await DBOperation.getWeightLiterStockSnap(db,
              scanneditemData[iss].ItemCode, scanneditemData[iss].SerialBatch);
      if (getWeightLiter.isNotEmpty) {
        weight = getWeightLiter[0]["weight"] == null
            ? 0.00
            : double.parse(getWeightLiter[0]["weight"].toString());
        liter = getWeightLiter[0]["liter"] == null
            ? 0.00
            : double.parse(getWeightLiter[0]["liter"].toString());
        totLiter = (scanneditemData[iss].Qty! * liter);
        totwieght = (scanneditemData[iss].Qty! * weight);
        notifyListeners();
      } else {
        weight = 0.0;
        liter = 0.0;
      }
      notifyListeners();
    }
    totalPayment = totalPay;
    notifyListeners();

    btnEnabledfn();
    totalcalculate();
  }

  calculateLineVal() {
    for (int iss = 0; iss < scanneditemData.length; iss++) {
      scanneditemData[iss].Qty =
          int.parse(qtymycontroller[iss].text.toString());
      // String ans = (scanneditemData[iss].SellPrice! * scanneditemData[iss].Qty!)
      // .toString();

      // scanneditemData[iss].discountper =
      //     int.parse(srmycontroller[iss].text.toString());

      scanneditemData[iss].basic =
          (scanneditemData[iss].SellPrice! * scanneditemData[iss].Qty!);
      // double.parse(ans);
      scanneditemData[iss].discount = (scanneditemData[iss].basic! *
          scanneditemData[iss].discountper! /
          100);
      // //log("discount Amount:${scanneditemData[iss].discount.toString()}: ${scanneditemData[iss].basic.toString()}:${scanneditemData[iss].discountper!.toString()}");
      scanneditemData[iss].taxable =
          scanneditemData[iss].basic! - scanneditemData[iss].discount!;

      scanneditemData[iss].taxvalue =
          scanneditemData[iss].taxable! * scanneditemData[iss].TaxRate! / 100;

      scanneditemData[iss].netvalue = scanneditemData[iss].basic! -
          scanneditemData[iss].discount! +
          scanneditemData[iss].taxvalue!;
      notifyListeners();
    }
    notifyListeners();
  }

  double getNoOfQty() {
    var getQty = scanneditemData.map((itemdet) => itemdet.Qty.toString());
    var getSum = getQty.map(double.parse).toList();
    var totalqty = getSum.reduce((a, b) => a + b);
    return totalqty;
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
    int totalQty = 0; // getNoOfQty();
    double totalPrice = 0; //getSumPrice();
    double sumTotal = 0; //(totalQty * totalPrice);

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      totalPrice = double.parse(scanneditemData[iss].SellPrice.toString());
      totalQty = scanneditemData[iss].Qty!;
      sumTotal = (sumTotal + (totalQty * totalPrice));

      //  print(totalPrice);
      //  print(totalQty);
      //  print(sumTotal);
    }

    return sumTotal;
  }

  double getTotalTax() {
    int totalQty = 0; // getNoOfQty();
    double totalPrice = 0; //getSumPrice();
    double tax = 0; //getSumTotalTax();
    double totalTax = 0; // ((totalQty * totalPrice) * (tax / 100));

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      totalPrice = double.parse(scanneditemData[iss].SellPrice.toString());
      totalQty = scanneditemData[iss].Qty!;
      tax = double.parse(scanneditemData[iss].TaxRate.toString());
      totalTax = (totalTax + ((totalQty * totalPrice) * (tax / 100)));
    }
    return totalTax;
  }

  double getDiscount() {
    return 0;
  }

  ///
  ///

  // double getSumTotalPaid() {
  //   if (paymentWay.length > 0) {
  //     for (int i = 0; i < paymentWay.length; i++) {
  //       var getTotalPaid = paymentWay.map((itemdet) => itemdet.amt.toString());
  //       var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
  //       var toalPaid = getTotalPaidSum.reduce((a, b) => a + b);
  //       return toalPaid;
  //     }
  //   }
  //   return 0.00;
  // }

  double getSumTotalPaid2() {
    double toalPaid = 0.0;
    if (paymentWay.isNotEmpty) {
      for (int i = 0; i < paymentWay.length; i++) {
        // if (paymentWay[i].type != "OnAccount") {
        toalPaid = toalPaid + paymentWay[i].amt!;
      }
      // }
      //  //log("toalPaidtoalPaid:::::" + toalPaid.toString());

      return toalPaid;
    } else {
      return 0.00;
    }
  }

  double getSumTotalPaid3() {
    double toalPaid = 0.0;
    if (paymentWay2.isNotEmpty) {
      for (int i = 0; i < paymentWay2.length; i++) {
        // if (paymentWay[i].type != "OnAccount") {
        toalPaid = toalPaid + paymentWay2[i].amt!;
      }
      // }
      //  //log("toalPaidtoalPaid:::::" + toalPaid.toString());

      return toalPaid;
    } else {
      return 0.00;
    }
  }
  // double getBalancePaid() {
  //   if (paymentWay.length > 0) {
  //     for (int i = 0; i < paymentWay.length; i++) {
  //       // //log("balance Not a OnAccount:::::::::::::::"i.toString());
  //     //  //log("balance Not AAAA:::::::::::::::" + paymentWay[i].type.toString());
  //       if (paymentWay[i].type != "OnAccount") {
  //       //  //log("---------------------------------------------------------");
  //       //  //log("balance Not a totalDue" +
  //             config
  //                 .slpitCurrency2(totalPayment!.totalDue!.toStringAsFixed(2))
  //                 .replaceAll(',', '')
  //                 .toString());
  //       //  //log("balance Not a totalDue" +
  //             double.parse(getSumTotalPaid2().toStringAsFixed(2)).toString());
  //         return double.parse(config
  //                 .slpitCurrency2(totalPayment!.totalDue!.toStringAsFixed(2))
  //                 .replaceAll(',', '')) -
  //             double.parse(getSumTotalPaid2().toStringAsFixed(2));
  //       }
  //     }
  //   }
  //   return totalPayment != null
  //       ? double.parse(config
  //           .slpitCurrency2(totalPayment!.totalDue!.toStringAsFixed(2))
  //           .replaceAll(',', ''))
  //       : 0.00;
  // }

  double getBalancePaid3() {
    double totalBalance = 0.0;
    salesCreditRcAmt();
    if (paymentWay2.isNotEmpty) {
      return double.parse(config
              .splitValues(totalPayment2!.totalDue!.toStringAsFixed(2))
              .replaceAll(',', '')) -
          double.parse(getSumTotalPaid2().toStringAsFixed(2));
    }
    return totalPayment2 != null
        ? double.parse(config
            .splitValues(totalPayment2!.totalDue!.toStringAsFixed(2))
            .replaceAll(',', ''))
        : 0.00;
  }

  double getBalancePaid2() {
    double totalBalance = 0.0;
    salesCreditRcAmt();
    if (paymentWay.isNotEmpty) {
      return double.parse(config
              .splitValues(totalPayment!.totalDue!.toStringAsFixed(2))
              .replaceAll(',', '')) -
          double.parse(getSumTotalPaid2().toStringAsFixed(2));
    }
    return totalPayment != null
        ? double.parse(config
            .splitValues(totalPayment!.totalDue!.toStringAsFixed(2))
            .replaceAll(',', ''))
        : 0.00;
  }

  // }

  salesCreditRcAmt() {
    for (int i = 0; i < salespaytosalesreturn.length; i++) {
      if (salespaytosalesreturn[i].salesrcmode == "Credit") {
        salesCreditamt = double.parse(
            salespaytosalesreturn[i].salesrcamt!.toStringAsFixed(2).toString());

        if (adjustAmt != 0) {
          salesCreditamt = double.parse(
              (salesCreditamt - adjustAmt).toStringAsFixed(2).toString());
          //  //log("After salesCreditamt::" +
          // salesCreditamt.toStringAsFixed(2).toString());
        } else {
          salesCreditamt = double.parse(salespaytosalesreturn[i]
              .salesrcamt!
              .toStringAsFixed(2)
              .toString());
        }
      }
    }
    //  //log("salesCreditamtAAAAAAA::" + salesCreditamt.toString());
  }

  btnEnabledfn() {
    salesCreditRcAmt();
    totalcalculate();
    if (salesCreditamt != 0) {
      //  //log("PPPPP");
      if (getBalancePaid2() < salesCreditamt) {
        //  //log("QQQQ::" + getBalancePaid2().toString());
        //  //log("WWWW::" + salesCreditamt.toString());
        enableModeBtn = false;
        notifyListeners();
      } else {
        enableModeBtn = true;
      }
    } else if (adjustAmt != 0) {
      //  //log("VVVVVVV");
      enableModeBtn = false;
      notifyListeners();
    }
  }

//payment options

  fullamt(String type, BuildContext context, ThemeData theme) {
    PaymentWay fpaymt = PaymentWay();

    mycontroller[22].text = totalcalculate().toStringAsFixed(2);
    // "${(getBalancePaid2() - salesCreditamt).toStringAsFixed(2)}";
    // config
    //     .slpitCurrency2(getBalancePaid().toStringAsFixed(2))
    //     .replaceAll(',', '');

    fpaymt.amt = double.parse(mycontroller[22].text.toString());
    fpaymt.dateTime = config.currentDate();
    fpaymt.type = type;
    if (fpaymt.amt! < 100000) {
      if (fpaymt.amt != null) {
        int check = checkAlreadyUsed(fpaymt.type!);
        if (check == 0) {
          addPayAmount(fpaymt, context);
        } else if (check == 1) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    content: SizedBox(
                      width: Screens.width(context) * 0.5,
                      height: Screens.bodyheight(context) * 0.15,
                      child: ContentWidgetMob(
                          theme: theme,
                          msg:
                              "Already you used ${fpaymt.type!} mode of payment..!!"),
                    ));
              });
        }
      }
    } else {
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
                    content: 'Choose Correct Amount of Below 1,00,000..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
  }

  double getSumTotalOnAccountPaid() {
    if (paymentWay.isNotEmpty) {
      for (int i = 0; i < paymentWay.length; i++) {
        if (paymentWay[i].type == "OnAccount") {
          var getTotalPaid =
              paymentWay.map((itemdet) => itemdet.amt.toString());
          var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
          var toalPaid = getTotalPaidSum.reduce((a, b) => a + b);
          //  //log("onaccount  toalPaid toalPaid::" + toalPaid.toString());
          return toalPaid;
        }
      }
    }
    return 0.00;
  }

  // double getonaccbalPaid() {
  //   if (paymentWay.length > 0) {
  //     for (int i = 0; i < paymentWay.length; i++) {
  //     //  //log("::::::::::::::::::::::::::::" + paymentWay[i].type.toString());
  //       if (paymentWay[i].type == "OnAccount") {
  //         return double.parse(config
  //                 .slpitCurrency2(salesCreditamt.toStringAsFixed(2))
  //                 .replaceAll(',', '')) -
  //             double.parse(getSumTotalOnAccountPaid().toStringAsFixed(2));
  //       }
  //     }
  //   }
  //   return salesCreditamt != 0
  //       ? double.parse(config
  //           .slpitCurrency2(salesCreditamt.toStringAsFixed(2))
  //           .replaceAll(',', ''))
  //       : 0.00;
  // }

  double getonaccbalPaid2() {
    double creditAmount = 0.0;

    if (paymentWay.isNotEmpty) {
      for (int i = 0; i < paymentWay.length; i++) {
        //  //log("::::::::::::::::::::::::::::" + paymentWay[i].type.toString());
        if (paymentWay[i].type == "OnAccount") {
          creditAmount = creditAmount + paymentWay[i].amt!;
          // return double.parse(config
          //         .slpitCurrency2(salesCreditamt.toStringAsFixed(2))
          //         .replaceAll(',', '')) -
          //     double.parse(getSumTotalOnAccountPaid().toStringAsFixed(2));
        }
      }
      creditAmount = double.parse(config
              .splitValues(salesCreditamt.toStringAsFixed(2))
              .replaceAll(',', '')) -
          creditAmount;
      return creditAmount;
    } else {
      return getBalancePaid2() != 0
          ? double.parse(config
              .splitValues(getBalancePaid2().toStringAsFixed(2))
              .replaceAll(',', ''))
          : 0.00;
    }
  }

  addOnAccAmtType(String type, BuildContext context, int i, ThemeData theme) {
    PaymentWay paymt = PaymentWay();

    if (formkey[i].currentState!.validate()) {
      if (type == 'OnAccount') {
        paymt.amt = double.parse(mycontroller[38].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      }
    }

    if (paymt.amt != null) {
      int check = checkAlreadyUsed(paymt.type!);
      notifyListeners();

      if (check == 0) {
        //  //log("check: $check");
        addPayAmount(paymt, context);
        // addToOnAccPaymentWay(paymt, context);
      } else if (check == 1) {
        hintcolor = false;
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: ContentWidgetMob(
                      theme: theme,
                      msg:
                          "Already you used ${paymt.type!} mode of payment..!!"));
            });
      }
    }
    //  else {
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
    //                 content: 'Choose Correct Amount..!!',
    //                 theme: theme,
    //               )),
    //               buttonName: null,
    //             ));
    //       });
    // }
  }

  checkstocksetqty() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.checkqty(db, '');
    notifyListeners();
  }

  addEnteredAmtType(String type, BuildContext context, int i, ThemeData theme) {
    PaymentWay paymt = PaymentWay();

    if (formkey[i].currentState!.validate()) {
      //log('type: $type');

      if (type == 'Cash') {
        //  //log("Cash: ${mycontroller[22].text.toString().trim()}");
        mycontlr = double.parse(mycontroller[22].text.toString().trim());

        paymt.amt = double.parse(mycontroller[22].text.toString().trim());
        paymt.dateTime = config.currentDate();

        paymt.type = type;
      } else if (type == 'Cheque') {
        //  //log("cheque: ${mycontroller[25].text.toString().trim()}");
        paymt.amt = double.parse(mycontroller[25].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.chequedate = mycontroller[24].text;
        paymt.chequeno = mycontroller[23].text;
        paymt.remarks = mycontroller[26].text;
        paymt.type = type;
      } else if (type == 'Coupons') {
        paymt.amt = double.parse(mycontroller[36].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        paymt.couponcode = mycontroller[35].text;
        paymt.coupontype = coupon;
      }
      //  else if (type == 'OnAccount') {
      //   paymt.amt = double.parse(mycontroller[38].text.toString().trim());
      //   paymt.dateTime = config.currentDate();
      //   paymt.type = type;
      // }
    }

    if (paymt.amt != null) {
      // addPayAmount(paymt, context);
      notifyListeners();
      int check = checkAlreadyUsed(paymt.type!);
      notifyListeners();

      if (check == 0) {
        //  //log("check: $check");

        addPayAmount(paymt, context);
      } else if (check == 1) {
        hintcolor = false;
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: ContentWidgetMob(
                      theme: theme,
                      msg:
                          "Already you used ${paymt.type!} mode of payment..!!")
                  //  AlertBox(
                  //   payMent: 'Alert',
                  //   errormsg: true,
                  //   widget: Center(
                  //       child: ContentContainer(
                  //     content: 'Already you used ${fpaymt.type!} mode of payment..!!',
                  //     theme: theme,
                  //   )),
                  //   buttonName: null,
                  // )
                  );
            });
      }
    }
  }

  int checkAlreadyUsed(String typeofMoney) {
    for (int ip = 0; ip < paymentWay.length; ip++) {
      if (paymentWay[ip].type == typeofMoney) {
        return 1;
      }
      notifyListeners();
    }
    return 0;
  }

  addPayAmount(PaymentWay paymt, BuildContext context) {
    print(
        " getBalancePaid2()  getBalancePaid2()${double.parse(getBalancePaid2().toStringAsFixed(2))}");
    if (paymentWay.isEmpty) {
      if (double.parse(config
                  .splitValues(totalPayment!.totalDue!.toStringAsFixed(2))
                  .replaceAll(',', '')) >
              getSumTotalPaid2() &&
          double.parse(getBalancePaid2().toStringAsFixed(2)) >= paymt.amt!) {
        addToPaymentWay(paymt, context);
      } else {
        //print("ErroAmt1111: ${paymt.amt}");
        msgforAmount = 'Enter Correct amount..!!';
        notifyListeners();
      }
    } else {
      if (double.parse(config
                  .splitValues(totalPayment!.totalDue!.toStringAsFixed(2))
                  .replaceAll(',', '')) >
              getSumTotalPaid2() &&
          double.parse(getBalancePaid2().toStringAsFixed(2)) >= paymt.amt!) {
        addToPaymentWay(paymt, context);
      } else {
        log("ErroAmt222: ${paymt.amt!.toStringAsFixed(2).replaceAll(',', '')}");

        msgforAmount = 'Enter Correct amount..!!';
        notifyListeners();
        //config.showDialogBox('Alert', 'Enter Correct amount..!!', context);
      }
    }
  }

  addToOnAccPaymentWay(
    payment,
    BuildContext context,
  ) {
    paymentWay.add(PaymentWay(
      amt: payment.amt,
      dateTime: payment.dateTime,
      type: payment.type,
      chequedate: payment.chequedate,
      chequeno: payment.chequeno,
      reference: payment.reference ?? '',
      remarks: payment.remarks,
      couponcode: payment.couponcode,
      coupontype: payment.coupontype,
    ));
    if (payment.type == "OnAccount") {
      getSumTotalOnAccountPaid();
      // getonaccbalPaid();
    }
    Navigator.pop(context);
    notifyListeners();
  }

  addToPaymentWay(
    PaymentWay paymt,
    BuildContext context,
  ) {
    paymentWay.add(PaymentWay(
      amt: paymt.amt,
      dateTime: paymt.dateTime,
      type: paymt.type,
      chequedate: paymt.chequedate,
      chequeno: paymt.chequeno,
      reference: paymt.reference ?? '',
      remarks: paymt.remarks,
      couponcode: paymt.couponcode,
      coupontype: paymt.coupontype,
    ));
    getSumTotalPaid2();
    getBalancePaid2();

    //  //log(" paymentWay amt:${paymt.amt}");
    //  //log("paymt.reference:${paymt.reference}");
    //  //log("paymt.type:${paymt.type}");
    Navigator.pop(context);
    notifyListeners();
  }

  removePayment(int i) {
    paymentWay.removeAt(i);
    getSumTotalPaid2();
    getBalancePaid2();
    accbal = 0;
    notifyListeners();
  }
  //

  //cash

// chqu
  getDate(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      //print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[24].text = datetype!;
      mycontroller[44].text = datetype!;
      //print(datetype);
    } else {
      //print("Date is not selected");
    }
  }

  cpyBtnclik(int i) {
    totalcalculate();
    mycontroller[i].text = totalcalculate().toStringAsFixed(2).toString();
    notifyListeners();
    //  //log(" mycontroller[i].text ::" + mycontroller[i].text);
  }

  onAcccpyBtnclik(ik) {
    totalcalculate();

    if (totalPayment!.totalDue! < salesCreditamt) {
      mycontroller[ik].text = totalPayment!.totalDue.toString();
    } else {
      mycontroller[ik].text = (salesCreditamt).toStringAsFixed(2).toString();
      notifyListeners();
    }
  }
  // onAcccpyBtnclik(ik) {
  //   totalcalculate();

  //   if (totalPayment!.totalDue! > salesCreditamt) {
  //     if (paymentWay.length > 0) {
  //       for (int ii = 0; ii < paymentWay.length; ii++) {
  //         if (paymentWay[ii].type == "OnAccount") {
  //           double payamt = paymentWay[ii].amt!;
  //           mycontroller[ik].text = (salesCreditamt - payamt).toStringAsFixed(2).toString()
  //           notifyListeners();
  //         }
  //       }
  //     } else {
  //       mycontroller[ik].text = salesCreditamt.toString();
  //     }
  //   } else {
  //     mycontroller[ik].text =
  //         // totalcalculate()
  //         // getBalancePaid2()
  //         (salesCreditamt - totalPayment!.totalDue!)
  //             .toStringAsFixed(2)
  //             .toString();
  //     notifyListeners();
  //   }
  // }

  custAccBal() {
    PaymentWay payment = PaymentWay();
    double mycontrol = 0;
    accbal = 0;
    //  //log("selectedcust!.accBalance111:::${selectedcust!.accBalance}");
    accbal = double.parse(selectedcust!.accBalance.toString());
    mycontrol = double.parse(mycontroller[38].text);
    print("AAAAAAAA");
    accbal = accbal + mycontrol;
    // selectedcust!.accBalance = accbal.toString();
    //  //log("selectedcust!.accBalance222:::${accbal}");
    notifyListeners();
    // } else {
    //   print("PPPP");
    //   selectedcust!.accBalance = selectedcust!.accBalance;
    //   notifyListeners();
    // }
  }

  onHoldClicked(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    freezeScrn = true;
    if (selectedcust == null) {
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
                    content: 'Choose customer..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        freezeScrn = false;
        notifyListeners();
      });
    } else {
      saveSalRetValuesTODB('hold', context, theme);

      if (holddocentry.isNotEmpty) {
        await DBOperation.deleteSalesRetHold(db, holddocentry.toString())
            .then((value) {
          onHoldFilter!.clear();
          holddocentry = '';
          getdraftindex();
          notifyListeners();
        });
      }
      notifyListeners();

      // SaveOnHold();

      // showDialog(
      //     context: context,
      //     barrierDismissible: true,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //           contentPadding: EdgeInsets.all(0),
      //           content: AlertBox(
      //               payMent: 'Alert',
      //               widget: Center(
      //                   child: ContentContainer(
      //                 // content: 'This sales transactions saved as draft..!!',
      //                 theme: theme,
      //               )),
      //               buttonName: null));
      //     }).then((value) {
      //   // clearAllData();
      // });
    }
    notifyListeners();
  }

  ///
  ///

  filterListOnHold(String v) {
    log("salesModelsalesModel.length:${salesModel.length}");

    if (v.isNotEmpty) {
      onHoldFilter = salesModel
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.custName!.toLowerCase().contains(v.toLowerCase()) ||
              e.invoceDate!.toLowerCase().contains(v.toLowerCase()) ||
              e.invoiceNum!.toLowerCase().contains(v.toLowerCase()) ||
              e.phNo!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      //  //log("On hold Filter.length:${onHoldFilter!.length.toString()}");
      notifyListeners();
    } else if (v.isEmpty) {
      onHoldFilter = salesModel;
      notifyListeners();
    }
  }
  // SaveOnHold() {
  //   List<SalesModel> onHoldValue = [];
  //   List<StocksnapModelData>? itemMaster = [];
  //   List<PaymentWay>? paymentwa = [];
  //   for (int ii = 0; ii < scanneditemData.length; ii++) {
  //     itemMaster.add(scanneditemData[ii]);
  //   }
  //   for (int ii = 0; ii < paymentWay.length; ii++) {
  //     paymentwa.add(paymentWay[ii]);
  //   }
  //   SalesModel salesValue = SalesModel(
  //       custName: selectedcust!.name!,
  //       address: selectedcust!.address!,
  //       phNo: selectedcust!.phNo,
  //       item: itemMaster,
  //       cardCode: selectedcust!.cardCode,
  //       accBalance: selectedcust!.accBalance,
  //       point: selectedcust!.point,
  //       tarNo: selectedcust!.tarNo,
  //       email: selectedcust!.email,
  //       invoceDate: "12-01-2023",
  //       invoiceNum: "2adjie1223",
  //       paymentway: paymentwa,
  //       totalPayment: totalPayment);
  //   onHoldValue.add(salesValue);
  //   onHold!.add(salesValue);
  //   onHoldFilter = onHold;
  //   print("dtatata: :${onHold![0].item!.length}");
  // }

  mapHoldValues(int ih, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    selectedcust = null;
    selectedcust55 = null;
    scanneditemData = [];
    print("Map Values");
    holddocentry = '';
    basedocentryonqtyck = '';
    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.getSalesRetheadholdDB(db);
    for (int ik = 0; ik < getDBholddata1.length; ik++) {
      List<Map<String, Object?>> getcustaddd =
          await DBOperation.addgetCstmMasAddDB(
              db, getDBholddata1[ik]['customercode'].toString().toString());
      List<Map<String, Object?>> custData =
          await DBOperation.getCstmMasDatabyautoid(
              db, getDBholddata1[ik]['customercode'].toString()); //customercode
      //log("step1");
      selectedcust = CustomerDetals(
          name: custData[0]['customername'].toString(),
          phNo: custData[0]['phoneno1'].toString(),
          cardCode: custData[0]['customercode'].toString(),
          accBalance: double.parse(custData[0]['balance'].toString()),
          point: custData[0]['points'].toString(),
          address: [],
          email: custData[0]['emalid'].toString(),
          tarNo: custData[0]['taxno'].toString(),
          invoiceDate: salesModel[ih].invoceDate,
          invoicenum: salesModel[ih].invoiceNum,
          docentry: salesModel[ih].transdocentry,
          totalPayment: salesModel[ih].totalPayment!.totalDue);
      notifyListeners();

      selectedcust55 = CustomerDetals(
        name: custData[0]['customername'].toString(),
        phNo: custData[0]['phoneno1'].toString(),
        cardCode: custData[0]['customercode'].toString(),
        accBalance: double.parse(custData[0]['balance'].toString()),
        point: custData[0]['points'].toString(),
        address: [],
        email: custData[0]['emalid'].toString(),
        tarNo: custData[0]['taxno'].toString(),
      );
      //log("step2");
      notifyListeners();

      remarkcontroller3.text = getDBholddata1[ik]['remarks'].toString();
      for (int i = 0; i < getcustaddd.length; i++) {
        //log("getDBholddata1[ik]['billaddressid'].toString()::${getDBholddata1[ik]['billaddressid']}:::${getcustaddd[i]['autoid']}");

        if (getDBholddata1[ik]['billaddressid'].toString() != null ||
            getDBholddata1[ik]['billaddressid'].toString().isNotEmpty) {
          if (getDBholddata1[ik]['billaddressid'].toString() ==
              getcustaddd[i]['autoid'].toString()) {
            //log("step5");

            selectedcust!.address!.add(Address(
              autoId: int.parse(getcustaddd[i]['autoid'].toString()),
              addresstype: getcustaddd[i]['addresstype'].toString(),
              address1: getcustaddd[i]['address1'].toString(),
              address2: getcustaddd[i]['address2'].toString(),
              address3: getcustaddd[i]['address3'].toString(),
              billCity: getcustaddd[i]['city'].toString(),
              billCountry: getcustaddd[i]['countrycode'].toString(),
              billPincode: getcustaddd[i]['pincode'].toString(),
              billstate: getcustaddd[i]['statecode'].toString(),
            ));
            notifyListeners();
          }
        }
        notifyListeners();

        if (getDBholddata1[ik]['shipaddresid'].toString().isNotEmpty) {
          // log("step7");

          if (getDBholddata1[ik]['shipaddresid'].toString() ==
              getcustaddd[i]['autoid'].toString()) {
            // log("step7");

            selectedcust55!.address!.add(Address(
              autoId: int.parse(getcustaddd[i]['autoid'].toString()),
              addresstype: getcustaddd[i]['addresstype'].toString(),
              address1: getcustaddd[i]['address1'].toString(),
              address2: getcustaddd[i]['address2'].toString(),
              address3: getcustaddd[i]['address3'].toString(),
              billCity: getcustaddd[i]['city'].toString(),
              billCountry: getcustaddd[i]['countrycode'].toString(),
              billPincode: getcustaddd[i]['pincode'].toString(),
              billstate: getcustaddd[i]['statecode'].toString(),
            ));
            notifyListeners();
          }
        }
      }
      notifyListeners();
    }

    print("salesModel[ih].transdocentry: ${salesModel[ih].transdocentry}");
    print("salesModel[ih].invoiceNum: ${salesModel[ih].invoiceNum}");
    print("len: ${salesModel[ih].item!.length}");
    notifyListeners();

    // scanneditemData = salesModel[ih].item!;
    for (int i = 0; i < salesModel[ih].item!.length; i++) {
      scanneditemData.add(StocksnapModelData(
          Maxdiscount: salesModel[ih].item![i].Maxdiscount,
          discountper: salesModel[ih].item![i].discountper,
          Branch: salesModel[ih].item![i].Branch,
          ItemCode: salesModel[ih].item![i].ItemCode,
          ItemName: salesModel[ih].item![i].ItemName,
          SerialBatch: salesModel[ih].item![i].SerialBatch,
          Qty: salesModel[ih].item![i].Qty,
          OpenQty: salesModel[ih].item![i].OpenQty,
          MRP: salesModel[ih].item![i].MRP,
          SellPrice: salesModel[ih].item![i].SellPrice,
          TaxRate: salesModel[ih].item![i].TaxRate,
          weight: salesModel[ih].item![i].weight,
          basedocentry: salesModel[ih].item![i].basedocentry,
          baselineid: salesModel[ih].item![i].baselineid,
          TransID: salesModel[ih].item![i].TransID,
          liter: salesModel[ih].item![i].liter));
      notifyListeners();
    }
    for (int i = 0; i < scanneditemData.length; i++) {
      qtymycontroller[i].text = scanneditemData[i].Qty.toString();

      notifyListeners();
    }
    basedocentryonqtyck = salesModel[ih].transdocentry;

    // paymentWay = salesModel[ih].paymentway!;
    totalPayment = salesModel[ih].totalPayment;
    notifyListeners();
    holddocentry = salesModel[ih].docentry.toString();
    //  //log("salesModel[ih].docentry:" + salesModel[ih].docentry.toString());
    // await DBOperation.deleteSalesRetHold(db, salesModel[ih].docentry.toString())
    //     .then((value) {
    //   onHoldFilter!.clear();
    //   getdraftindex();
    //   notifyListeners();
    // });
    calCulateDocVal();
    totalcalculate();
    salesCreditRcAmt();
    enableModeBtn = true;
    btnEnabledfn();
    notifyListeners();
  }

//checkout
  confirmReturn(BuildContext context, ThemeData theme) async {
    freezeScrn = true;
    final Database db = (await DBHelper.getInstance())!;
    validateqty = false;
    if (selectedcust == null) {
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
                    content: 'Choose customer..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        freezeScrn = false;

        notifyListeners();
      });
    } else if (scanneditemData.isEmpty) {
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
                      content: 'Choose Product..!!',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        freezeScrn = false;

        notifyListeners();
      });
      // } else if ((double.parse(config
      //         .slpitCurrency2(totalPayment!.totalDue!.toStringAsFixed(2))
      //         .replaceAll(',', '')) !=
      //     getBalancePaid2())) {
      //   //     &&
      //   // (getBalancePaid2() != 0)) {
      //   showDialog(
      //       context: context,
      //       barrierDismissible: true,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //             contentPadding: EdgeInsets.all(0),
      //             content: AlertBox(
      //                 payMent: 'Alert',
      //                 errormsg: true,
      //                 widget: Center(
      //                     child: ContentContainer(
      //                   content: 'Pay the full amount..!!',
      //                   theme: theme,
      //                 )),
      //                 buttonName: null));
      //       });
    } else {
      await balanceqtycheck(context, theme);
      if (validateqty == false) {
        //log('step6');
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
                      content: "Can't Return  More Qty than Invoiced",
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          validateqty = true;
          freezeScrn = false;
        });
      } else {
        //log("VVVVVVVVVVVVVVVVVVVVV");
        saveSalRetValuesTODB('confirm return', context, theme);
        if (holddocentry.isNotEmpty) {
          await DBOperation.deleteSalesRetHold(db, holddocentry.toString())
              .then((value) {
            onHoldFilter!.clear();
            holddocentry = '';
            getdraftindex();
            notifyListeners();
          });
        }
        validateqty = false;
      }
      // saveSalRetValuesTODB('confirm return', context, theme);
    }
    // SaveSalesOrder();

    // showDialog(
    //     context: context,
    //     barrierDismissible: true,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //           contentPadding: EdgeInsets.all(0),
    //           content: AlertBox(
    //               payMent: 'Alert',
    //               widget: Center(
    //                   child: ContentContainer(
    //                 content: 'Successfully Done..!!',
    //                 theme: theme,
    //               )),
    //               buttonName: null));
    //     }).then((value) {
    //   clearAllData();
    // });
    // }

    notifyListeners();
  }

  saveSalRetValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      insertSalesRetHeaderToDB(docstatus, context, theme);
      notifyListeners();
    } else if (docstatus.toLowerCase() == "confirm return") {
      insertSalesRetHeaderToDB(docstatus, context, theme);
    }

    notifyListeners();
  }

  viewSalesRet() async {
    final Database db = (await DBHelper.getInstance())!;

    DBOperation.dltsalesret(db);
    print(' viewSalesRet msg');
  } //dltsalesret

  // double totalLiter() {
  //   double total = 0.0;
  //   if (scanneditemData.isNotEmpty) {
  //     for (int i = 0; i < scanneditemData.length; i++) {
  //       total = total +
  //           (scanneditemData[i].liter *
  //               double.parse(scanneditemData[i].Qty.toString()));
  //     }
  //     return total;
  //   }
  //   return 0.00;
  // }

  // double totalLiter2() {
  //   double total = 0.0;
  //   if (scanneditemData2.isNotEmpty) {
  //     for (int i = 0; i < scanneditemData2.length; i++) {
  //       total = total +
  //           (scanneditemData2[i].liter *
  //               double.parse(scanneditemData2[i].Qty.toString()));
  //     }
  //     return total;
  //   }
  //   return 0.00;
  // }

  // double totalWeight() {
  //   double totalWeight = 0.0;
  //   if (scanneditemData.isNotEmpty) {
  //     for (int i = 0; i < scanneditemData.length; i++) {
  //       totalWeight = totalWeight +
  //           (scanneditemData[i].weight *
  //               double.parse(scanneditemData[i].Qty.toString()));
  //     }
  //     return totalWeight;
  //   }
  //   return 0.00;
  // }

  // double totalWeight2() {
  //   double totalWeight = 0.0;
  //   if (scanneditemData2.isNotEmpty) {
  //     for (int i = 0; i < scanneditemData2.length; i++) {
  //       totalWeight = totalWeight +
  //           (scanneditemData2[i].weight *
  //               double.parse(scanneditemData2[i].Qty.toString()));
  //     }

  //     return totalWeight;
  //   }
  //   return 0.00;
  // }

  deletealesRet() async {
    final Database db = (await DBHelper.getInstance())!;

    DBOperation.dltsalesret(db);
    //log(' deleteSalesRet msg');
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

    return listdata; // int.parse(data.substring(8));
  }

  insertSalesRetHeaderToDB(
      String docstatus, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<SalesReturnTModelDB> salesRHeaderValues1 = [];
    List<SalesReturnPayTDB> salesPayValues = [];
    List<SalesReturnLineTDB> salesLineValues = [];
    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "SalesReturnHeader");
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
      docEntryCreated = await DBOperation.generateDocentr(
          db, "docentry", "SalesReturnHeader");
    }

    // docnumber generatiom
    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 3);

    List<String> getseriesvalue = await checkingdoc(3);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    documentNum = finlDocnum + documentN0.toString();
    // docnumber generatiom

    // List<Map<String, Object?>> sapdetails = await DBOperation.getSaleHeadSapDet(db, int.parse(selectedcust!.docentry!.toString()), 'SalesHeader');

    SalesReturnTModelDB salesRetTable = SalesReturnTModelDB(
        doctype: "Sales Return",
        docentry: docEntryCreated.toString(),
        amtpaid: totalPayment != null
            ? config.splitValues(getSumTotalPaid2().toStringAsFixed(2))
            : '',
        baltopay: totalPayment != null
            ? config.splitValues(getBalancePaid2().toStringAsFixed(2))
            : '',
        billaddressid: selectedcust != null && selectedcust!.address!.isNotEmpty
            ? selectedcust!.address![selectedBillAdress].autoId.toString()

            // ? " ${selectedcust!.address![selectedBillAdress].address1.toString()}"
            // ${selectedcust!.address![selectedBillAdress].address2.toString()}, ${selectedcust!.address![selectedBillAdress].address3.toString()}"
            : '',
        billtype: '',
        branch: UserValues.branch!,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        createdbyuser: UserValues.userType,
        customercode: selectedcust != null ? selectedcust!.cardCode! : "",
        customername: selectedcust != null ? selectedcust!.name : "",
        customertype: UserValues.userType,
        docbasic: totalPayment != null
            ? config.splitValues(totalPayment!.subtotal!.toStringAsFixed(2))
            : "",
        docdiscamt: totalPayment != null
            ? config.splitValues(totalPayment!.discount!.toStringAsFixed(2))
            : "",
        docdiscuntpercen: '',
        documentno: documentNum.toString(),
        docstatus: docstatus == "hold"
            ? "1"
            : docstatus == "confirm return"
                ? "3"
                : "null",
        doctotal: selectedcust!.totalPayment!.toStringAsFixed(2),
        lastupdateIp: UserValues.lastUpdateIp,
        premiumid: "",
        remarks: remarkcontroller3.text,
        // mycontroller[50].text.toString(),
        salesexec: "",
        seresid: "",
        seriesnum: "",
        shipaddresid: selectedcust55 != null &&
                selectedcust55!.address!.isNotEmpty
            ? selectedcust55!.address![selectedShipAdress].autoId.toString()
            // ? '${selectedcust!.address![selectedShipAdress].address1.toString()},'
            //         '${selectedcust!.address![selectedShipAdress].address2.toString()},' +
            //     selectedcust!.address![selectedShipAdress].address3.toString()
            : "",
        sodocno: "",
        sodocseries: "",
        sodocseriesno: '',
        sodoctime: config.currentDate(),
        sosystime: config.currentDate(),
        sotransdate: config.currentDate(),
        sysdatetime: config.currentDate(),
        taxamount: totalPayment != null
            ? config.splitValues(totalPayment!.totalTX!.toStringAsFixed(2))
            : '',
        taxno: selectedcust != null ? selectedcust!.tarNo.toString() : "",
        transactiondate: '',
        transtime: config.currentDate(),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        paystatus: '',
        customeraccbal:
            selectedcust != null ? selectedcust!.accBalance!.toString() : '',
        customeremail: selectedcust != null ? selectedcust!.email : '',
        customerphono: selectedcust != null ? selectedcust!.phNo : '',
        customerpoint: selectedcust != null ? selectedcust!.point : '',
        city: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].billCity,
        gst: selectedcust != null ? selectedcust!.tarNo : '',
        pinno: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].billPincode,
        state: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].billstate,
        country: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].billCountry,
        basedocentry: selectedcust!.docentry.toString(),
        basedocnum: selectedcust!.invoicenum.toString(),
        terminal: UserValues.terminal,
        sapDocentry: null,
        sapDocNo: null,
        qStatus: "No",
        sapInvoicedocentry: sapDocentry.toString(),
        // "488566",
        // sapdetails[0]['sapDocentry'].toString(),
        sapInvoicedocnum: sapDocuNumber.toString(),
        // "7041354",
        // sapdetails[0]['sapDocNo'].toString(),
        totalltr: totLiter,
        totalweight: totwieght);

    //  //log("SalesReturnTModelDB!.basedocnum," +
    // selectedcust!.invoicenum.toString());
    salesRHeaderValues1.add(salesRetTable);

    int? docentry2 =
        await DBOperation.insertSaleReturnheader(db, salesRHeaderValues1);

    await DBOperation.updatenextno(db, 3, nextno);
    for (int i = 0; i < scanneditemData.length; i++) {
      salesLineValues.add(SalesReturnLineTDB(
        basedocentry: scanneditemData[i].basedocentry,
        baselineID: scanneditemData[i].baselineid,
        basic: scanneditemData[i].basic.toString(),
        terminal: UserValues.terminal,
        // totalPayment != null
        //     ? totalPayment!.subtotal.toString().replaceAll(',', '')
        //     : null,
        branch: UserValues.branch,
        createdUser: UserValues.userType,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        discamt: scanneditemData[i].discount.toString(),
        discperc: scanneditemData[i].discountper.toString(),
        discperunit: (scanneditemData[i].SellPrice! *
                scanneditemData[i].discountper! /
                100)
            .toString(),

        docentry: docentry2.toString(),
        itemcode: scanneditemData[i].ItemCode,
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        lineID: i.toString(),
        itemname: scanneditemData[i].ItemName,
        linetotal: scanneditemData[i].basic.toString(),
        // totalPayment != null ? totalPayment!.subtotal.toString() : null,
        netlinetotal: scanneditemData[i].netvalue.toString(),
        // totalPayment != null
        //     ? totalPayment!.totalDue.toString().replaceAll(',', '')
        //     : null,
        price: scanneditemData[i].SellPrice.toString(),
        quantity: scanneditemData[i].Qty.toString(),
        serialbatch: scanneditemData[i].SerialBatch,
        taxrate: scanneditemData[i].TaxRate.toString(),
        taxtotal: scanneditemData[i].taxvalue.toString(),
        // totalPayment != null
        //     ? config.slpitCurrency2(totalPayment!.totalTX!.toStringAsFixed(2))
        //     : '',
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),

        // sapdetails[0]['sapDocentry'].toString(),
      ));
      notifyListeners();
      // salesLineValues.add(salesLine);
    }

    for (int ij = 0; ij < getpaymentWay.length; ij++) {
      salesPayValues.add(SalesReturnPayTDB(
          createdUserID: UserValues.userID.toString(),
          createdateTime: config.currentDate(),
          docentry: docentry2.toString(),
          lastupdateIp: UserValues.lastUpdateIp,
          rcamount: getpaymentWay[ij].amt != null
              ? getpaymentWay[ij].amt!.toString().replaceAll(',', '')
              : "",
          amt: getpaymentWay[ij].amt != null
              ? getpaymentWay[ij].amt!.toString().replaceAll(',', '')
              : "",
          rcdatetime: config.currentDate(),
          rcdocentry: "",
          rcmode: 'OnAccount',
          rcnumber: "",
          updatedDatetime: config.currentDate(),
          updateduserid: UserValues.userID.toString(),
          chequedate: getpaymentWay[ij].chequedate,
          chequeno: getpaymentWay[ij].chequeno,
          couponcode: getpaymentWay[ij].couponcode,
          coupontype: getpaymentWay[ij].coupontype,
          reference: '',
          remarks: '',
          branch: UserValues.branch,
          terminal: UserValues.terminal,
          lineId: ij.toString()));
      notifyListeners();

      // SalesPayValues.add(SalesPayValues1);
    }
    if (salesPayValues.isNotEmpty) {
      DBOperation.insertSalesReturnPay(db, salesPayValues, docentry2!);
      notifyListeners();
    }
    if (salesLineValues.isNotEmpty) {
      DBOperation.insertSalesReturnLine(db, salesLineValues, docentry2!);
      notifyListeners();
    }

    if (docstatus == "hold") {
      getdraftindex();

      scanneditemData.clear();
      mycontroller = List.generate(150, (i) => TextEditingController());
      selectedcust = null;
      mycontroller[50].clear();
      paymentWay.clear();
      totalPayment = null;
      srmycontroller[1].text = "";
      remarkcontroller3.text = '';
      notifyListeners();

      await Get.defaultDialog(
              title: "Success",
              middleText: docstatus == "confirm return"
                  ? 'Successfully Returned..!!, Document Number is $documentNum'
                  : docstatus == "hold"
                      ? "Saved as draft"
                      : "null",
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
        freezeScrn = false;
        notifyListeners();
      });
    }
    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      if (docstatus == "confirm return") {
        callReturnPostApi(
          context,
          theme,
          docentry2!,
          selectedcust!.docentry.toString(),
          docstatus,
        );
        notifyListeners();
        // await PostRabitMqSalesRet(docentry2!, baldocentry.toString());
      }
    }

    // scanneditemData.clear();
    // mycontroller = List.generate(150, (i) => TextEditingController());
    // selectedcust = null;
    // mycontroller[50].clear();
    // paymentWay.clear();
    // totalPayment = null;
    // srmycontroller[1].text = "";
    // remarkcontroller3.text = '';
    // notifyListeners();

    // await Get.defaultDialog(
    //         title: "Success",
    //         middleText: docstatus == "confirm return"
    //             ? 'Successfully Returned..!!, Document Number is $documentNum'
    //             : docstatus == "hold"
    //                 ? "Saved as draft"
    //                 : "null",
    //         backgroundColor: Colors.white,
    //         titleStyle: const TextStyle(color: Colors.red),
    //         middleTextStyle: const TextStyle(color: Colors.black),
    //         actions: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               TextButton(
    //                 child: const Text("Close"),
    //                 onPressed: () => Get.back(),
    //               ),
    //             ],
    //           ),
    //         ],
    //         radius: 5)
    //     .then((value) {
    //   if (docstatus == "confirm return") {
    //     Get.offAllNamed(ConstantRoutes.dashboard);
    //   }

    //   freezeScrn = false;
    //   notifyListeners();
    // });
    notifyListeners();
  }

  callReturnPostApi(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String baseDocentry,
    String docstatus,
  ) async {
    await sapReturnLoginApi();
    await postingreturn(
      context,
      theme,
      docEntry,
      baseDocentry,
      docstatus,
    );
    notifyListeners();
  }

  List<Invbatch>? batchTable;
  addBatchtable(int ik) {
    batchTable = [];

    batchTable!.add(Invbatch(
      quantity: double.parse(scanneditemData[ik].Qty.toString()),
      batchNumberProperty: scanneditemData[ik].SerialBatch.toString(),
    ));
    notifyListeners();
  }

  List<ReturnPostingtLine> itemsDocDetails = [];
  List<ReturnValuess> itemsValetails = [];

  adddocValues() {
    itemsValetails = [];
    addDocLine();
    itemsValetails.add(ReturnValuess(
        docDate: config.currentDate().toString(),
        docDueDate: config.currentDate().toString(),
        cardCode: selectedcust!.cardCode.toString(),
        cardName: selectedcust!.name.toString(),
//  docTotal: docTotal, docRate: docRate,
        reference1: remarkcontroller3.text,
        returnDocumentLines: itemsDocDetails));
  }

  addDocLine() {
    itemsDocDetails = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      addBatchtable(i);
      itemsDocDetails.add(ReturnPostingtLine(
          lineNum: i,
          itemCode: scanneditemData[i].ItemCode.toString(),
          itemDescription: scanneditemData[i].ItemName.toString(),
          quantity: scanneditemData[i].Qty!,
          price: scanneditemData[i].SellPrice!,
          discountPercent: scanneditemData[i].discountper!,
          warehouseCode: UserValues.branch!,
          batchNumbers: batchTable!,
          baseType: 13,
          basedocentry: sapBaseDocentry!,
          baseline: int.parse(scanneditemData[i].baselineid.toString())));
      notifyListeners();
    }
    notifyListeners();
  }

  postingreturn(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String baseDocentry,
    String docstatus,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    addDocLine();
    log(docstatus);
    SalesReurnPostAPi.cardCodePost = selectedcust!.cardCode;
    SalesReurnPostAPi.docLineQout = itemsDocDetails;
    SalesReurnPostAPi.docDate = config.currentDate();
    SalesReurnPostAPi.dueDate = config.currentDate().toString();
    SalesReurnPostAPi.remarks = remarkcontroller3.text;
    var uuid = Uuid();
    String? uuidg = uuid.v1();
    SalesReurnPostAPi.method(uuidg);
    await SalesReurnPostAPi.getGlobalData(uuidg).then((value) async {
      // SalesOrderAfterAPi.baseEntry = value.docEntry.toString();
      //log("object:" + value.stsCode.toString());
      if (value.stsCode == null) {
        return;
      }
      if (value.stsCode >= 200 && value.stsCode! <= 210) {
        if (value.docEntry != null) {
          sapDocentry = value.docEntry.toString();
          sapDocuNumber = value.docNum.toString();
          await DBOperation.UpdtSapDetSalHead(
              db,
              int.parse(sapDocentry),
              int.parse(value.docNum.toString()),
              docEntry,
              'SalesReturnHeader');

          await postRabitMqSalesRet2(
              int.parse(docEntry.toString()), baseDocentry);

          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(150, (i) => TextEditingController());

          selectedcust = null;

          paymentWay.clear();
          totalPayment = null;

          remarkcontroller3.text = "";
          scanneditemData.clear();

          notifyListeners();
          await Get.defaultDialog(
                  title: "Success",
                  middleText: docstatus == "confirm return"
                      ? 'Successfully Done, Document Number is ${value.docNum}'
                      : docstatus == "hold"
                          ? "Saved as draft"
                          // : docstatus == "suspend"
                          //     ? "This Sales Transaction Suspended Sucessfully..!!"
                          : "null",
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
            if (docstatus == "confirm return") {
              Get.offAllNamed(ConstantRoutes.dashboard);
            }
            freezeScrn = false;
            notifyListeners();
          });
          custserieserrormsg = '';
        } else {
          //log("Error11");

          custserieserrormsg = value.erroe!.message.toString();
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(150, (i) => TextEditingController());
          scanneditemData = [];
          selectedcust = null;
          sapBaseDocentry = null;
          paymentWay.clear();
          totalPayment = null;
          scanneditemData.clear();
          remarkcontroller3.text = "";
          scanneditemData.clear();
          freezeScrn = false;
        }
      } else if (value.stsCode >= 400 && value.stsCode <= 410) {
        //log("Error22");
        cancelbtn = false;
        mycontroller = List.generate(150, (i) => TextEditingController());
        qtymycontroller = List.generate(150, (i) => TextEditingController());
        scanneditemData = [];

        selectedcust = null;

        paymentWay.clear();
        totalPayment = null;

        remarkcontroller3.text = "";
        scanneditemData.clear();
        freezeScrn = false;
        custserieserrormsg = value.erroe!.message!.value.toString();
        showDialog(
            context: context,
            barrierDismissible: false,
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
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(150, (i) => TextEditingController());
          scanneditemData = [];

          selectedcust = null;

          paymentWay.clear();
          totalPayment = null;

          remarkcontroller3.text = "";
          scanneditemData.clear();
          freezeScrn = false;
        });
      }
    });
    notifyListeners();
  }

  PostRabitMqSalesRet(int docentry, String basedocentry) async {
    final Database db = (await DBHelper.getInstance())!;
    String? salesRetHeader;
    String? salesRetLine;
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(
            db, int.parse(basedocentry.toString()));
    baldocentry = getDBSalesHeader[0]['docentry'].toString();
    sameInvNum = getDBSalesHeader[0]['documentno'].toString();
    sapDocentry = getDBSalesHeader[0]['sapDocentry'].toString();
    sapDocuNumber = getDBSalesHeader[0]['sapDocNo'].toString();
    await sapReturnLoginApi();
    await callSerlaySalesQuoAPI();

    if (invDocumentStatus.toString() == "bost_Open") {
      salesRetHeader = null;
      salesRetLine = null;
      //log("PostRabitMqSalesRet(docentry2!);");
      List<Map<String, Object?>> getdbSaleretheader1 =
          await DBOperation.getSalesRetHeadDB(db, docentry);
      List<Map<String, Object?>> getdbSaleretline1 =
          await DBOperation.grtSalesRetLineDB(db, docentry);
      salesRetHeader = jsonEncode(getdbSaleretheader1);
      salesRetLine = jsonEncode(getdbSaleretline1);
      //log("salesRetHeader11::$salesRetHeader");
      //log("salesRetLine11::$salesRetLine");
      // salesRetLine = json.encode(getdbSaleretline1);
    } else {
      //log(invDocumentStatus.toString());
      salesRetHeader = null;
      salesRetLine = null;
      List<SalesReturnTModelDB> getdbSaleretheader =
          await DBOperation.salesretrunupdate(db, docentry.toString());
      //log("getdbSaleretheader::::${getdbSaleretheader.length}");
      //log(getdbSaleretheader[0].documentno.toString() +
      // getdbSaleretheader[0].sapDocentry.toString());
      List<SalesReturnTModelDB> salesReturnTModelDBuser = [];
      salesReturnTModelDBuser.add(SalesReturnTModelDB(
        docentry: getdbSaleretheader[0].docentry,
        doctype: getdbSaleretheader[0].doctype,
        documentno: getdbSaleretheader[0].documentno,
        amtpaid: getdbSaleretheader[0].amtpaid,
        country: getdbSaleretheader[0].country,
        city: getdbSaleretheader[0].city,
        state: getdbSaleretheader[0].state,
        gst: getdbSaleretheader[0].gst,
        pinno: getdbSaleretheader[0].pinno,
        baltopay: getdbSaleretheader[0].baltopay,
        billaddressid: getdbSaleretheader[0].billaddressid,
        shipaddresid: getdbSaleretheader[0].shipaddresid,
        billtype: getdbSaleretheader[0].billtype,
        branch: getdbSaleretheader[0].branch,
        createdUserID: getdbSaleretheader[0].createdUserID,
        createdateTime: getdbSaleretheader[0].createdateTime,
        createdbyuser: getdbSaleretheader[0].createdbyuser,
        customerphono: getdbSaleretheader[0].customerphono,
        customeremail: getdbSaleretheader[0].customeremail,
        customerpoint: getdbSaleretheader[0].customerpoint,
        customeraccbal: getdbSaleretheader[0].customeraccbal,
        customercode: getdbSaleretheader[0].customercode,
        customername: getdbSaleretheader[0].customername,
        customertype: getdbSaleretheader[0].customertype,
        docbasic: getdbSaleretheader[0].docbasic,
        docdiscamt: getdbSaleretheader[0].docdiscamt,
        docdiscuntpercen: getdbSaleretheader[0].docdiscuntpercen,
        terminal: getdbSaleretheader[0].terminal,
        basedocentry:
            // null,
            getdbSaleretheader[0].basedocentry,
        basedocnum:
            // null,
            getdbSaleretheader[0].basedocnum,
        docstatus: getdbSaleretheader[0].docstatus,
        doctotal: getdbSaleretheader[0].doctotal,
        lastupdateIp: getdbSaleretheader[0].lastupdateIp,
        paystatus: getdbSaleretheader[0].paystatus,
        premiumid: getdbSaleretheader[0].premiumid,
        remarks: getdbSaleretheader[0].remarks,
        salesexec: getdbSaleretheader[0].salesexec,
        seresid: getdbSaleretheader[0].seresid,
        seriesnum: getdbSaleretheader[0].seriesnum,
        sodocno: getdbSaleretheader[0].sodocno,
        sodocseries: getdbSaleretheader[0].sodocseries,
        sodocseriesno: getdbSaleretheader[0].sodocseriesno,
        sodoctime: getdbSaleretheader[0].sodoctime,
        sosystime: getdbSaleretheader[0].sosystime,
        sotransdate: getdbSaleretheader[0].sotransdate,
        sysdatetime: getdbSaleretheader[0].sysdatetime,
        taxamount: getdbSaleretheader[0].taxamount,
        taxno: getdbSaleretheader[0].taxno,
        transactiondate: getdbSaleretheader[0].transactiondate,
        transtime: getdbSaleretheader[0].transtime,
        updatedDatetime: getdbSaleretheader[0].updatedDatetime,
        updateduserid: getdbSaleretheader[0].updateduserid,
        sapInvoicedocentry: getdbSaleretheader[0].sapInvoicedocentry,
        sapInvoicedocnum: getdbSaleretheader[0].sapInvoicedocnum,
        totalltr: double.parse(getdbSaleretheader[0].totalltr.toString()),
        totalweight: double.parse(getdbSaleretheader[0].totalweight.toString()),
        qStatus: 'No',
        sapDocentry: getdbSaleretheader[0].sapDocentry,
        sapDocNo: getdbSaleretheader[0].sapDocNo,
      ));
      notifyListeners();
      List<SalesReturnLineTDB> getdbSaleretline =
          await DBOperation.salesRetrunLineUpdate(db, docentry.toString());
      //log("salesRetLine.lengt::${getdbSaleretline.length}");

      List<SalesReturnLineTDB> saleretlineuser = [];
      for (int i = 0; i < getdbSaleretline.length; i++) {
        //log(getdbSaleretline[0].updatedDatetime.toString());
        saleretlineuser.add(SalesReturnLineTDB(
          createdUser: getdbSaleretline[i].createdUser,
          docentry: getdbSaleretline[i].docentry,
          baselineID: getdbSaleretline[i].baselineID,
          basedocentry:
              // null,
              getdbSaleretline[i].basedocentry,
          basic: getdbSaleretline[i].basic,
          itemname: getdbSaleretline[i].itemname.toString(),
          branch: getdbSaleretline[i].branch.toString(),
          terminal: getdbSaleretline[i].terminal.toString(),
          createdUserID: getdbSaleretline[i].createdUserID.toString(),
          createdateTime: getdbSaleretline[i].createdateTime.toString(),
          discamt: getdbSaleretline[i].discamt.toString(),
          discperc: getdbSaleretline[i].discperc.toString(),
          discperunit: getdbSaleretline[i].discperunit.toString(),
          itemcode: getdbSaleretline[i].itemcode.toString(),
          lastupdateIp: getdbSaleretline[i].lastupdateIp.toString(),
          lineID: getdbSaleretline[i].lineID.toString(),
          linetotal: getdbSaleretline[i].linetotal.toString(),
          netlinetotal: getdbSaleretline[i].netlinetotal.toString(),
          price: getdbSaleretline[i].price.toString(),
          quantity: getdbSaleretline[i].quantity.toString(),
          serialbatch: getdbSaleretline[i].serialbatch.toString(),
          taxrate: getdbSaleretline[i].taxrate.toString(),
          taxtotal: getdbSaleretline[i].taxtotal.toString(),
          updatedDatetime: getdbSaleretline[i].updatedDatetime.toString(),
          updateduserid: getdbSaleretline[i].updateduserid.toString(),
        ));
        notifyListeners();
      }
      //log("salesReturnTModelDBuser::${salesReturnTModelDBuser[0].sapDocNo.toString()}");

      //log("${salesReturnTModelDBuser[0].documentno}:::${salesReturnTModelDBuser[0].sapDocNo}");
      salesRetHeader = jsonEncode(salesReturnTModelDBuser);
      salesRetLine = jsonEncode(saleretlineuser);
      //log("salesRetHeadersalesRetHeader22::$salesRetHeader");
      //log("salesRetLinesalesRetLine22::$salesRetLine");
      notifyListeners();
    }

    List<Map<String, Object?>> getdbSaleretpay =
        await DBOperation.getSalesRetPayDB(db, docentry);
    // String salesRetHeader = json.encode(getdbSaleretheader);
    String salesRetPay = json.encode(getdbSaleretpay);

    var ddd = json.encode({
      "ObjectType": 2,
      "ActionType": "Add",
      "SalesReturnHeader": salesRetHeader,
      "SalesReturnLine": salesRetLine,
      "SalesReturntPay": salesRetPay,
    });
    log("payload11 : $ddd");

    // RabitMQ
    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //AppConstant.ip
        // "102.69.167.106"
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    // properties.headers = {"Branch": UserValues.branch};
    // exchange.publish(ddd, "", properties: properties);

    //cs

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  postRabitMqSalesRet2(int docentry, String basedocentry) async {
    final Database db = (await DBHelper.getInstance())!;

    String? salesRetHeader;
    String? salesRetLine;
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(db, int.parse(basedocentry));

    baldocentry = getDBSalesHeader[0]['docentry'].toString();
    sameInvNum = getDBSalesHeader[0]['documentno'].toString();
    sapDocentry = getDBSalesHeader[0]['sapDocentry'].toString();
    sapDocuNumber = getDBSalesHeader[0]['sapDocNo'].toString();

    await sapReturnLoginApi();
    await callSerlaySalesQuoAPI();
    if (invDocumentStatus.toString() == "bost_Open") {
      //log("PostRabitMqSalesRet(docentry2!);");
      List<Map<String, Object?>> getdbSaleretheader1 =
          await DBOperation.getSalesRetHeadDB(db, docentry);
      salesRetHeader = json.encode(getdbSaleretheader1);
      List<Map<String, Object?>> getdbSaleretline1 =
          await DBOperation.grtSalesRetLineDB(db, docentry);
      salesRetLine = json.encode(getdbSaleretline1);
      //log("salesRetHeadersalesRetHeaderxx::$salesRetHeader");
      //log("salesRetLinesalesRetLineyy::$salesRetLine");
    } else {
      List<SalesReturnTModelDB> getdbSaleretheader =
          await DBOperation.salesretrunupdate(db, docentry.toString());
      //log("getdbSaleretheader::::${getdbSaleretheader[0].docentry.toString()}");
      List<SalesReturnTModelDB> salesReturnTModelDBuser = [];
      salesReturnTModelDBuser.add(SalesReturnTModelDB(
        qStatus: 'No',
        sapDocentry: null,
        sapDocNo: null,
        docentry: getdbSaleretheader[0].docentry.toString(),
        doctype: getdbSaleretheader[0].doctype.toString(),
        documentno: getdbSaleretheader[0].documentno.toString(),
        amtpaid: getdbSaleretheader[0].amtpaid.toString(),
        country: getdbSaleretheader[0].country.toString(),
        city: getdbSaleretheader[0].city.toString(),
        state: getdbSaleretheader[0].state.toString(),
        gst: getdbSaleretheader[0].gst.toString(),
        pinno: getdbSaleretheader[0].pinno.toString(),
        baltopay: getdbSaleretheader[0].baltopay.toString(),
        billaddressid: getdbSaleretheader[0].billaddressid.toString(),
        billtype: getdbSaleretheader[0].billtype.toString(),
        branch: getdbSaleretheader[0].branch.toString(),
        createdUserID: getdbSaleretheader[0].createdUserID.toString(),
        createdateTime: getdbSaleretheader[0].createdateTime.toString(),
        createdbyuser: getdbSaleretheader[0].createdbyuser.toString(),
        customerphono: getdbSaleretheader[0].customerphono.toString(),
        customeremail: getdbSaleretheader[0].customeremail.toString(),
        customerpoint: getdbSaleretheader[0].customerpoint.toString(),
        customeraccbal: getdbSaleretheader[0].customeraccbal.toString(),
        customercode: getdbSaleretheader[0].customercode.toString(),
        customername: getdbSaleretheader[0].customername.toString(),
        customertype: getdbSaleretheader[0].customertype.toString(),
        docbasic: getdbSaleretheader[0].docbasic.toString(),
        docdiscamt: getdbSaleretheader[0].docdiscamt.toString(),
        docdiscuntpercen: getdbSaleretheader[0].docdiscuntpercen.toString(),
        terminal: getdbSaleretheader[0].terminal.toString(),
        basedocentry: getdbSaleretheader[0].basedocentry.toString(),
        basedocnum: getdbSaleretheader[0].basedocnum.toString(),
        docstatus: getdbSaleretheader[0].docstatus.toString(),
        doctotal: getdbSaleretheader[0].doctotal.toString(),
        lastupdateIp: getdbSaleretheader[0].lastupdateIp.toString(),
        paystatus: getdbSaleretheader[0].paystatus.toString(),
        premiumid: getdbSaleretheader[0].premiumid.toString(),
        remarks: getdbSaleretheader[0].remarks.toString(),
        salesexec: getdbSaleretheader[0].salesexec.toString(),
        seresid: getdbSaleretheader[0].seresid.toString(),
        seriesnum: getdbSaleretheader[0].seriesnum.toString(),
        shipaddresid: getdbSaleretheader[0].shipaddresid.toString(),
        sodocno: getdbSaleretheader[0].sodocno.toString(),
        sodocseries: getdbSaleretheader[0].sodocseries.toString(),
        sodocseriesno: getdbSaleretheader[0].sodocseriesno.toString(),
        sodoctime: getdbSaleretheader[0].sodoctime.toString(),
        sosystime: getdbSaleretheader[0].sosystime.toString(),
        sotransdate: getdbSaleretheader[0].sotransdate.toString(),
        sysdatetime: getdbSaleretheader[0].sysdatetime.toString(),
        taxamount: getdbSaleretheader[0].taxamount.toString(),
        taxno: getdbSaleretheader[0].taxno.toString(),
        transactiondate: getdbSaleretheader[0].transactiondate.toString(),
        transtime: getdbSaleretheader[0].transtime.toString(),
        updatedDatetime: getdbSaleretheader[0].updatedDatetime.toString(),
        updateduserid: getdbSaleretheader[0].updateduserid.toString(),
        sapInvoicedocentry: getdbSaleretheader[0].sapInvoicedocentry.toString(),
        sapInvoicedocnum: getdbSaleretheader[0].sapInvoicedocnum.toString(),
        totalltr: double.parse(getdbSaleretheader[0].totalltr.toString()),
        totalweight: double.parse(getdbSaleretheader[0].totalweight.toString()),
      ));

      List<SalesReturnLineTDB> getdbSaleretline =
          await DBOperation.salesRetrunLineUpdate(db, docentry.toString());
      //log("salesRetLine.lengt::${getdbSaleretline.length}");
      SalesReturnLineTDB? saleretlineuser;
      for (int i = 0; i < getdbSaleretline.length; i++) {
        saleretlineuser = SalesReturnLineTDB(
          docentry: getdbSaleretline[i].docentry.toString(),

          baselineID: getdbSaleretline[i].baselineID.toString(),
          basedocentry: null,
          //  getdbSaleretline[i].basedocentry.toString(),
          basic: getdbSaleretline[i].basic.toString(),
          itemname: getdbSaleretline[i].itemname.toString(),
          branch: getdbSaleretline[i].branch.toString(),
          terminal: getdbSaleretline[i].terminal.toString(),
          createdUserID: getdbSaleretline[i].createdUserID.toString(),
          createdateTime: getdbSaleretline[i].createdateTime.toString(),
          discamt: getdbSaleretline[i].discamt.toString(),
          discperc: getdbSaleretline[i].discperc.toString(),
          discperunit: getdbSaleretline[i].discperunit.toString(),
          itemcode: getdbSaleretline[i].itemcode.toString(),
          lastupdateIp: getdbSaleretline[i].lastupdateIp.toString(),
          lineID: getdbSaleretline[i].lineID.toString(),
          linetotal: getdbSaleretline[i].linetotal.toString(),
          netlinetotal: getdbSaleretline[i].netlinetotal.toString(),
          price: getdbSaleretline[i].price.toString(),
          quantity: getdbSaleretline[i].quantity.toString(),
          serialbatch: getdbSaleretline[i].serialbatch.toString(),
          taxrate: getdbSaleretline[i].taxrate.toString(),
          taxtotal: getdbSaleretline[i].taxtotal.toString(),
          updatedDatetime: getdbSaleretline[i].updatedDatetime.toString(),
          updateduserid: getdbSaleretline[i].updateduserid.toString(),
        );
      }
      salesRetHeader = jsonEncode(salesReturnTModelDBuser);
      salesRetLine = jsonEncode(saleretlineuser);
    }
    log("salesRetHeadersalesRetHeader::$salesRetHeader");
    log("salesRetLinesalesRetLine::$salesRetLine");
    // List<Map<String, Object?>> getdbSaleretheader = await DBOperation.getSalesRetHeadDB(db, docentry);
    // List<Map<String, Object?>> getdbSaleretline = await DBOperation.grtSalesRetLineDB(db, docentry);
    List<Map<String, Object?>> getdbSaleretpay =
        await DBOperation.getSalesRetPayDB(db, docentry);

    // String salesRetHeader = json.encode(getdbSaleretheader);
    // String salesRetLine = json.encode(getdbSaleretline);
    String salesRetPay = json.encode(getdbSaleretpay);

    var ddd = json.encode({
      "ObjectType": 2,
      "ActionType": "Add",
      "SalesReturnHeader": salesRetHeader,
      "SalesReturnLine": salesRetLine,
      "SalesReturntPay": salesRetPay,
    });
    log("payload2 : $ddd");

    //RabitMQ
    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //AppConstant.ip
        // "102.69.167.106"
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    properties.headers = {"Branch": UserValues.branch};
    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    exchange.publish(ddd, "", properties: properties);

    //cs

    // properties.headers = {"Branch": "Server"};
    // exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getSalesRetheadholdDB(db);
    log("getDBholddata5 lenght:${getDBholddata5.length.toString()}");
    onHoldFilter = [];
    onHold = [];
    salesModel = [];
    holddocentry = '';

    for (int i = 0; i < getDBholddata5.length; i++) {
      //log("iii:$i");
      getdraft(i);
    }
    notifyListeners();
  }

  getdraft(int ji) async {
    print('onholdpart onholdpartonholdpart');
    holddocentry = '';

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.getSalesRetheadholdDB(db);

    salesModel = [];
    onHoldFilter = [];
    onHold = [];

    List<StocksnapModelData> scannDataaa = [];
    List<PaymentWay> payment = [];
    List<Map<String, Object?>> getDBholdSalespay =
        await DBOperation.getSalesRetPayDB(
            db, int.parse(getDBholddata1[ji]['docentry'].toString()));
    log('getDBholdSalespaygetDBholdSalespay.length::${getDBholdSalespay.length}');
    List<Map<String, Object?>> getDBholdSalesLine =
        await DBOperation.grtSalesRetLineDB(
            db, int.parse(getDBholddata1[ji]['docentry'].toString()));
    log('getDBholdSalesLinegetDBholdSalesLine.length::${getDBholdSalesLine.length}');

    for (int kk = 0; kk < getDBholdSalespay.length; kk++) {
      if (getDBholddata1[ji]['docentry'].toString() ==
          getDBholdSalespay[kk]['docentry'].toString()) {
        payment.add(PaymentWay(
          amt: getDBholdSalespay[kk]['rcamount'] != null
              ? double.parse(getDBholdSalespay[kk]['rcamount'].toString())
              : null,
          type: getDBholdSalespay[kk]['rcmode'].toString(),
          dateTime: getDBholdSalespay[kk]['createdateTime'].toString(),
          reference: getDBholdSalespay[kk]['reference'] != null
              ? getDBholdSalespay[kk]['reference'].toString()
              : '',
          cardApprno: getDBholdSalespay[kk]['cardApprno'] != null
              ? getDBholdSalespay[kk]['cardApprno'].toString()
              : '',
          cardref: getDBholdSalespay[kk]['cardref'].toString(),
          cardterminal: getDBholdSalespay[kk]['cardterminal'].toString(),
          chequedate: getDBholdSalespay[kk]['chequedate'].toString(),
          chequeno: getDBholdSalespay[kk]['chequeno'].toString(),
          couponcode: getDBholdSalespay[kk]['couponcode'].toString(),
          coupontype: getDBholdSalespay[kk]['coupontype'].toString(),
          discountcode: getDBholdSalespay[kk]['discountcode'].toString(),
          discounttype: getDBholdSalespay[kk]['discounttype'].toString(),
          // creditref: getDBholdSalespay[kk]['creditref'].toString(),
          recoverydate: getDBholdSalespay[kk]['recoverydate'].toString(),
          redeempoint: getDBholdSalespay[kk]['redeempoint'].toString(),
          availablept: getDBholdSalespay[kk]['rcmode'].toString(),
          remarks: getDBholdSalespay[kk]['remarks'].toString(),
          // transref: getDBholdSalespay[kk]['transref'].toString(),
          transtype: getDBholdSalespay[kk]['transtype'].toString(),
          walletid: getDBholdSalespay[kk]['walletid'].toString(),
          // walletref: getDBholdSalespay[kk]['walletref'].toString(),
          wallettype: getDBholdSalespay[kk]['wallettype'].toString(),
        ));
      }
      notifyListeners();
    }
    for (int ik = 0; ik < getDBholdSalesLine.length; ik++) {
      //  //log("getDBholdSalesLine.length:${getDBholdSalesLine.length}");
      if (getDBholddata1[ji]['docentry'] ==
          getDBholdSalesLine[ik]['docentry']) {
        //log(getDBholddata1[ji]['docentry'].toString() +
        // getDBholdSalesLine[ik]['docentry'].toString());
        scannDataaa.add(StocksnapModelData(
            baselineid: getDBholdSalesLine[ik]['baselineID'].toString(),
            basedocentry: getDBholdSalesLine[ik]['basedocentry'].toString(),
            TransID: int.parse(getDBholdSalesLine[ik]['baselineID'].toString()),
            Branch: getDBholdSalesLine[ik]['branch'].toString(),
            ItemCode: getDBholdSalesLine[ik]['itemcode'].toString(),
            ItemName: getDBholdSalesLine[ik]['itemname'].toString(),
            SerialBatch: getDBholdSalesLine[ik]['serialbatch'].toString(),
            OpenQty: int.parse(getDBholdSalesLine[ik]['quantity'].toString()),
            Qty: int.parse(getDBholdSalesLine[ik]['quantity'].toString()),
            InDate: getDBholdSalesLine[ik][''].toString(),
            InType: getDBholdSalesLine[ik][''].toString(),
            VenCode: getDBholdSalesLine[ik][''].toString(),
            VenName: getDBholdSalesLine[ik][''].toString(),
            taxvalue:
                double.parse(getDBholdSalesLine[ik]['taxtotal'].toString()),
            discount:
                double.parse(getDBholdSalesLine[ik]['discamt'].toString()),
            MRP: 0,
            SellPrice: double.parse(getDBholdSalesLine[ik]['price'].toString()),
            Cost: 0,
            TaxRate: double.parse(getDBholdSalesLine[ik]['taxrate'].toString()),
            Maxdiscount: getDBholdSalesLine[ik]['Maxdiscount'] != null
                ? getDBholdSalesLine[ik]['Maxdiscount'].toString()
                : '',
            TaxType: getDBholdSalesLine[ik]['taxtype'].toString(),
            discountper:
                double.parse(getDBholdSalesLine[ik]['discperc'].toString()),
            liter: getDBholdSalesLine[ik]['liter'] == null
                ? 0.00
                : double.parse(getDBholdSalesLine[ik]['liter'].toString()),
            weight: getDBholdSalesLine[ik]['weight'] == null
                ? 0.00
                : double.parse(getDBholdSalesLine[ik]['weight'].toString())));
        totquantity = getDBholdSalesLine[ik]['quantity'].toString();
      }
      //  //log("scannDatascannDatascannDatascannData length:${scannDataaa.length}");
      notifyListeners();
    }
    List<Address> addressadd = [];
    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(
            db, getDBholddata1[ji]['customercode'].toString());
    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      addressadd.add(Address(
        address1: csadresdataDB[ia]['address1'].toString(),
        address2: csadresdataDB[ia]['address2'].toString(),
        address3: csadresdataDB[ia]['address3'].toString(),
        billCity: csadresdataDB[ia]['city'].toString(),
        billCountry: csadresdataDB[ia]['countrycode'].toString(),
        billPincode: csadresdataDB[ia]['pincode'].toString(),
        billstate: csadresdataDB[ia]['statecode'].toString(),
      ));
    }
    SalesModel salesM = SalesModel(
        docentry: int.parse(getDBholddata1[ji]['docentry'].toString()),
        transdocentry: getDBholddata1[ji]['basedocentry'].toString(),
        custName: getDBholddata1[ji]['customername'].toString(),
        phNo: getDBholddata1[ji]['customerphono'].toString(),
        cardCode: getDBholddata1[ji]['customercode'].toString(),
        accBalance: getDBholddata1[ji]['customeraccbal'].toString(),
        point: getDBholddata1[ji]['customerpoint'].toString(),
        tarNo: getDBholddata1[ji]['taxno'].toString(),
        email: getDBholddata1[ji]['customeremail'].toString(),
        invoceDate: getDBholddata1[ji]['createdateTime'].toString(),
        invoiceNum: getDBholddata1[ji]['basedocnum'].toString(),
        createdateTime: getDBholddata1[ji]['createdateTime'].toString(),
        invoceAmount: double.parse(getDBholddata1[ji]['doctotal']
            .toString()
            .replaceAll(",", '')), // doctotal,

        address: addressadd,
        //  [
        //   Address(
        //       address1: getDBholddata1[ji]['billaddressid'].toString(),
        //       billCity: getDBholddata1[ji]['city'].toString(),
        //       billCountry: getDBholddata1[ji]['country'].toString(),
        //       billPincode: getDBholddata1[ji]['pinno'].toString(),
        //       billstate: getDBholddata1[ji]['state'].toString())
        // ],
        totalPayment: TotalPayment(
          subtotal: double.parse(getDBholddata1[ji]['docbasic'] == null
              ? '0'
              : getDBholddata1[ji]['docbasic']
                  .toString()
                  .replaceAll(',', '')), //doctotal
          discount2: getDBholddata1[ji]['docdiscamt'] != null
              ? double.parse(getDBholddata1[ji]['docdiscamt']
                  .toString()
                  .replaceAll(',', ''))
              : 0,
          totalTX: double.parse(
              getDBholddata1[ji]['taxamount'].toString().replaceAll(',', '')),
          discount: double.parse(
              getDBholddata1[ji]['docdiscamt'].toString().replaceAll(',', '')),
          total: getDBholddata1[ji]['quantity'] != null
              ? int.parse(getDBholddata1[ji]['quantity'].toString())
              : 0,
          // totalPayment!.total == null
          //     ? 0
          //     : double.parse(
          //         totalPayment!.total!.toString().replaceAll(',', '')),quantity

          totalDue: double.parse(getDBholddata1[ji]['doctotal'] == null
              ? '0'
              : getDBholddata1[ji]['doctotal'].toString().replaceAll(',', '')),
          totpaid: double.parse(getDBholddata1[ji]['amtpaid'] == null
              ? '0'
              : getDBholddata1[ji]['amtpaid'].toString().replaceAll(',', '')),
          balance: double.parse(
              getDBholddata1[ji]['baltopay'].toString().replaceAll(',', '')),
        ),
        item: scannDataaa,
        paymentway: payment);
    notifyListeners();
    log("salesModel.length 444444:${salesModel.length}");

    salesModel.add(salesM);

    //  //log("getdraftsalesModel.item.length:${salesM.item!.length}");
    //  //log("salesM transdocentry" +
    // getDBholddata1[ji]['basedocentry']
    //     .toString()); //getDBholddata1[ji]['basedocnum'].toString(),
    //  //log("salesM basedocnum" + getDBholddata1[ji]['basedocnum'].toString());
    notifyListeners();
    //  //log("getSalesHeadHoldvalueDBgetSalesHeadHoldvalueDB:${getDBholddata1.length}");
    log("salesModel.length 666:${salesModel.length}");
    // onHold.add(salesM);
    onHoldFilter = salesModel;
    log("onHoldFilter.length:${onHoldFilter!.length}");

    notifyListeners();
  }
}
