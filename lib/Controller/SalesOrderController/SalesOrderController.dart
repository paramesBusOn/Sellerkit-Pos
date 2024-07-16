// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_comparison, unused_local_variable, prefer_const_constructors, prefer_null_aware_operators

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';

// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:posproject/Controller/SalesQuotationController/SalesQuotationController.dart';
import 'package:posproject/DB Helper/DBhelper.dart';
import 'package:posproject/Models/DataModel/SalesOrderModel.dart';
import 'package:posproject/Models/Service%20Model/GroupCustModel.dart';
import 'package:posproject/Models/Service%20Model/PamentGroupModel.dart';
import 'package:posproject/Models/Service%20Model/TeriTeriModel.dart';
import 'package:posproject/Pages/PrintPDF/PDFInVoiceApi.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:posproject/Pages/SalesOrder/Widgets/Ordrprintinglayout.dart';
import 'package:posproject/Service/NewCustCodeCreate/CreatecustPostApi%20copy.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerGropApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerSeriesApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/FileUploadApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/PaymentGroupApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/TeritoryApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../DB Helper/DBOperation.dart';
import "package:dart_amqp/dart_amqp.dart";
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/ItemMaster.dart';
import '../../DBModel/SalesOrderHeader.dart';
import '../../DBModel/SalesOrderLineDB.dart';
import '../../DBModel/SalesOrderPay.dart';
import '../../DBModel/StockSnap.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/ItemCode/Itemcodelist.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import '../../Models/SchemeOrderModel/SchemeOrderModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/AccountBalModel.dart';
import '../../Models/Service Model/SeriesModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';
import '../../Models/ServiceLayerModel/ReceiptModel/PostReceiptLineMode.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/GetSapOrderstatusModel.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_details.modal.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_order_modal.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';
import '../../Pages/Sales Screen/Screens/MobileScreenSales/WidgetsMob/ContentcontainerMob.dart';
import '../../Service/NewCustCodeCreate/NewAddCreatePatchApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/AfterApvlToDocNumApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/ApprovalQueryApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/DraftToDocOrderApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/OrderPatchApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/PostOrderAPI2.dart';
import '../../ServiceLayerAPIss/OrderAPI/PostSalesOrder.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/approvals_details_api.dart';
import '../../ServiceLayerAPIss/OrderAPI/getCreaditDays/getBalanceCreditLimit.dart';
import '../../ServiceLayerAPIss/OrderAPI/getCreaditDays/getCreaditDaysApi.dart';
import '../../ServiceLayerAPIss/Paymentreceipt/PostpaymentDataAPI.dart';
import '../../Widgets/AlertBox.dart';
import '../../Pages/SalesOrder/Widgets/SOBar.dart';
import '../../Service/AccountBalanceAPI.dart';
import '../../Service/SchemeOrderApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/GetOrderAPI.dart';
import '../../ServiceLayerAPIss/OrderAPI/OrderCancelAPI.dart';
import '../../ServiceLayerAPIss/OrderAPI/OrderLoginnAPI.dart';
import '../../Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';

class SOCon extends ChangeNotifier {
  Configure config = Configure();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());
  GlobalKey<FormState> formkeyAd = GlobalKey<FormState>();
  GlobalKey<FormState> formkeyShipAd = GlobalKey<FormState>();
  List<HoldedHeader> holdData = [];
  List<HoldedHeader> fileterHoldData = [];
  List<String> catchmsg = [];
  List<SalesOrderScheme> schemeData = [];
  List<SchemeOrderModalData> resSchemeDataList = [];
  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  List<TextEditingController> qtymycontroller =
      List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> discountcontroller =
      List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> discountcontroller2 =
      List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> udfController =
      List.generate(100, (ij) => TextEditingController());

  TextEditingController remarkcontroller3 = TextEditingController();

  List<TextEditingController> mycontroller2 =
      List.generate(150, (i) => TextEditingController());
  List<TextEditingController> qtymycontroller2 =
      List.generate(100, (ij) => TextEditingController());
  TextEditingController searchcontroller = TextEditingController();
  List<StocksnapModelData> itemData = [];
  List<StocksnapModelData> get getitemData => itemData;
  List<StocksnapModelData> scanneditemData = [];
  List<StocksnapModelData> get getScanneditemData => scanneditemData;
  List<StocksnapModelData> scanneditemData2 = [];
  List<StocksnapModelData> get getScanneditemData2 => scanneditemData2;
  List<ItemMasterModelDB> getSearchedData = [];
  List<ItemMasterModelDB> getfilterSearchedData = [];
  List<ItemMasterModelDB> getAllSelect = [];

  CustomerDetals? selectedcust2;
  CustomerDetals? get getselectedcust2 => selectedcust2;
  CustomerDetals? selectedcust25;
  CustomerDetals? get getselectedcust25 => selectedcust25;
  List<CustomerModelDB> newCustValues = [];
  List<CustomerAddressModelDB> newBillAddrsValue = [];
  List<CustomerAddressModelDB> newShipAddrsValue = [];
  List<CustomerAddressModelDB> billcreateNewAddress = [];
  List<CustomerAddressModelDB> shipcreateNewAddress = [];

  List<searchModel> searchData = [];

  List<FocusNode> focusnode = List.generate(100, (i) => FocusNode());
  String holddocentry = '';
  ItemCodeListModel? itemcodeitem;
  List<StocksnapModelData> soData = [];
  List<StocksnapModelData> get getsoData => soData;
  List<SalesModel> soSalesmodl = [];
  List<SalesModel> salesmodl = [];

  List<StocksnapModelData> soScanItem = [];

  String cpyfrmso = '';
  bool schemebtnclk = false;
  bool cancelbtn = false;
  List<TextEditingController> soqtycontroller =
      List.generate(100, (ij) => TextEditingController());
  CustomerDetals? selectedcust;
  CustomerDetals? get getselectedcust => selectedcust;
  CustomerDetals? selectedcust55;
  CustomerDetals? get getselectedcust55 => selectedcust55;
  List<SalesModel> onHold = [];
  List<SalesModel>? onHoldFilter = [];
  String? totquantity;
  double? discountamt;
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  String sapDocentry = '';
  String sapDocuNumber = '';
  int? sapReceiptDocentry;
  int? sapBaseDocEntry;

  String cancelDocnum = '';
  int? tbDocEntry;

  String? custseriesNo;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  bool loadingBtn = false;
  bool loadingSqBtn = false;

  bool getsqdata = false;
  List<SeriesModelData> seriesData = [];

  List<OrderDocumentLine> SapSaleOrderModelData = [];
  bool? fileValidation = false;
  File? tinFiles;
  File? vatFiles;
  String? teriteriValue;
  String? codeValue;
  String? paygrpValue;
  FilePickerResult? result;
  List<FilesData> filedata = [];

  List<searchModel> filtersearchData = [];
  List<ApprovalsOrdersValue> filterAprvlData = [];
  List<ApprovalsOrdersValue> searchAprvlData = [];

  TotalPayment? totalPayment2;
  TotalPayment? get gettotalPayment2 => totalPayment2;
  List<PaymentWay> paymentWay2 = [];
  List<PaymentWay> get getpaymentWay2 => paymentWay2;

  double? totwieght = 0.0;
  double? totLiter = 0.0;
  String? shipaddress = "";

  bool searchbool = false;
  bool OndDisablebutton = false;
  TextEditingController searchcon = TextEditingController();
  List<GroupCustData> groupcData = [];
  List<GetTeriteriData> teriteritData = [];
  List<GetPayGrpData>? paygroupData = [];
  bool groCustLoad = false;
  String? custerrormsg = '';
  String cardCodexx = '';

  List<CustomerDetals> custList2 = [];
  String exception = '';
  bool loading = false;

  List<CustomerDetals> custList = [];
  List<CustomerDetals> filtercustList = [];
  List<CustomerDetals> get getfiltercustList => filtercustList;

  int selectedCustomer = 0;
  int get getselectedCustomer => selectedCustomer;
  // cus functions

  bool checkboxx = false;
  bool editqty = false;

  int selectedBillAdress = 0;
  int? get getselectedBillAdress => selectedBillAdress;

  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;
  List<Address> billadrrssItemlist = [];
  List<Address> shipadrrssItemlist = [];
  List<AccountBalanceModelData> accBalList = [];
  String textError = '';

  TotalPayment? totalPayment;
  TotalPayment? get gettotalPayment => totalPayment;

  String? msgforAmount;
  String? get getmsgforAmount => msgforAmount;
  List<PaymentWay> paymentWay = [];
  List<PaymentWay> get getpaymentWay => paymentWay;

//dropdown
  String? selectedValue;
  String? get getselectedValue => selectedValue;

  bool isLoading = false;
  bool schemeApiLoad = false;
  bool isApprove = false;
  void init(BuildContext context, ThemeData theme) {
    clearAllData(context, theme);
    clearAll(context, theme);
    injectToDb();
    getCustDetFDB();
    getdraftindex();
    CustSeriesApi();
    getLocation(context);
    notifyListeners();
  }

  clearAll(BuildContext context, ThemeData theme) {
    filtersearchData = [];
    totalPayment2 = null;
    paymentWay2 = [];
    mycontroller = List.generate(150, (i) => TextEditingController());
    searchcontroller = TextEditingController();
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    checkboxx = false;
    selectedcust = null;
    selectedcust2 = null;
    searchData.clear();
    custList.clear();
    filtercustList.clear();
    custList2.clear();
    selectedBillAdress = 0;
    getSearchedData = [];
    paymentWay.clear();
    itemData.clear();
    scanneditemData.clear();
    getfilterSearchedData = [];
    scanneditemData2.clear();
    mycontroller2 = List.generate(150, (i) => TextEditingController());
    mycontroller[99].clear();
    focusnode = List.generate(100, (i) => FocusNode());
    notifyListeners();
  }

  Future<List<ItemMasterModelDB>> getAllList(String data) async {
    //y
    final Database db = (await DBHelper.getInstance())!;
    getSearchedData = await DBOperation.getSearchedStockList(db, data);
    getfilterSearchedData = getSearchedData;
    // log("getSearchedData ${getSearchedData.length}");
    searchcon.clear();

    return getSearchedData;
  }

  filterListSearched(String v) {
    //y
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
    //log("getfilterSearchedData length:${getfilterSearchedData.length}");
  }

  singleitemsearch(BuildContext context, ThemeData theme, int indx) async {
    if (scanneditemData.isEmpty) {
      int res = checkhaveQty(indx, 0);

      if (res > 0) {
        addSannedItem(indx, context, theme);
      } else {
        Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
        searchcon.clear();
      }
    } else {
      int result = await checkalreadyScanedd(indx);
      if (result != -1) {
        int res = checkhaveQty(indx, int.parse(qtymycontroller[result].text));
        if (res > 0) {
          incrementQty(result, '1', context, theme);
        } else {
          Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
        }
      } else {
        addSannedItem(indx, context, theme);
      }
    }
  }

  onselectFst(BuildContext context, ThemeData theme, int indx) async {
    Navigator.pop(context);
    if (scanneditemData.isEmpty) {
      //log('yes ${indx}');
      int res = checkhaveQty(indx, 0);

      if (res > 0) {
        addSannedItem(indx, context, theme);
      } else {
        Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
        searchcon.clear();
      }
    } else {
      int result = await checkalreadyScanedd(indx);
      if (result != -1) {
        int res = checkhaveQty(indx, int.parse(qtymycontroller[result].text));
        if (res > 0) {
          incrementQty(result, '1', context, theme);
        } else {
          Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
        }
      } else {
        addSannedItem(indx, context, theme);
      }
    }
    calCulateDocVal(context, theme);
  }

  int checkhaveQty(int ind, int scanedQty) {
    int res = 0;
    // if(int.parse(getfilterSearchedData[ind].quantity!) > scanedQty){
    res = 1;
    //}
    return res;
  }

  incrementQty(int indxs, String qty, BuildContext context, ThemeData theme) {
    qtychangemtd(indxs, qty, context, theme);
  }

  qtyEdited(int indx, BuildContext context, ThemeData theme) async {
    //log("scaQtyyy : ${scanneditemData[indx].OpenQty!}");
    int removeqty = 0;
    if (int.parse(qtymycontroller[indx].text.toString()) == removeqty ||
        qtymycontroller[indx].text.isEmpty) {
      discountcontroller.removeAt(indx);
      qtymycontroller.removeAt(indx);
      scanneditemData.removeAt(indx);
      calCulateDocVal(context, theme);
      notifyListeners();
    } else {
      //log("GGGGGGGGGGGGGGG");
      incrementQty(indx, '0', context, theme);
      notifyListeners();
    }

    notifyListeners();
  }

  addSannedItem(
    int ind,
    BuildContext context,
    ThemeData theme,
  ) async {
    scanneditemData.add(StocksnapModelData(
        TransID: 0,
        Branch: '', //getfilterSearchedData[ind].,
        ItemCode: getfilterSearchedData.isNotEmpty
            ? getfilterSearchedData[ind].itemcode
            : getfilterSearchedData[ind].itemnameshort,
        ItemName: getfilterSearchedData[ind].itemnameshort,
        SerialBatch: getfilterSearchedData[ind].isserialBatch,
        OpenQty: getfilterSearchedData[ind].quantity,
        Qty: 1,
        InDate: '',
        InType: '',
        VenCode: '',
        VenName: '',
        MRP: double.parse(getfilterSearchedData[ind].mrpprice.toString()),
        SellPrice:
            double.parse(getfilterSearchedData[ind].sellprice.toString()),
        Cost: 0,
        TaxRate: double.parse(getfilterSearchedData[ind].taxrate.toString()),
        // 0.00, //double.parse(getfilterSearchedData[ind].taxrate.toString()), //double.parse(getfilterSearchedData[ind].taxrate!),
        TaxType: '',
        discount: 0,
        basic: 0,
        netvalue: 0,
        taxvalue: 0,
        Maxdiscount: getfilterSearchedData[ind]
            .maxdiscount
            .toString(), // getfilterSearchedData[ind].d,
        createdUserID: '',
        createdateTime: '',
        lastupdateIp: '',
        purchasedate: '',
        snapdatetime: '',
        specialprice: 0,
        updatedDatetime: '',
        updateduserid: '',
        discountper:
            double.parse(getfilterSearchedData[ind].maxdiscount.toString()),
        liter: double.parse(getfilterSearchedData[ind].liter.toString()),
        weight: double.parse(getfilterSearchedData[ind].weight.toString())));

    for (int i = 0; i < scanneditemData.length; i++) {
      scanneditemData[i].TransID = i;
      discountcontroller[i].text = 0.0.toString();
    }

    qtychangemtd(scanneditemData.length - 1, '1', context, theme);
    notifyListeners();
  }

  qtychangemtd(int ind, String qty, BuildContext context, ThemeData theme) {
    String added = (int.parse(qty) +
            int.parse(qtymycontroller[ind].text.isEmpty
                ? '0'
                : qtymycontroller[ind].text))
        .toString();
    qtymycontroller[ind].text = added;
    scanneditemData[ind].Qty = int.parse(added);
    calCulateDocVal(context, theme);
    notifyListeners();
  }

  Future<int> checkalreadyScanedd(int indx) async {
    int res = -1;
    for (int i = 0; i < scanneditemData.length; i++) {
      if (
          // getfilterSearchedData[indx].isserialBatch ==
          //       scanneditemData[i].SerialBatch &&
          getfilterSearchedData[indx].itemcode == scanneditemData[i].ItemCode) {
        res = i;
      }
    }
    return res;
  }

  removeEmptyList() {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (qtymycontroller[i].text.isEmpty) {
        scanneditemData.removeAt(i);
      }
    }
  }

  Future callgetSQValue(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    getsqdata = true;
    soData = [];
    soSalesmodl = [];
    List<StocksnapModelData> scannData = [];
    if (selectedcust != null) {
      List<Map<String, Object?>> getheaderData =
          await DBOperation.getSalesQuotationvalueDB(
              db, selectedcust!.cardCode.toString());
      soSalesmodl.clear();
      for (int ik = 0; ik < getheaderData.length; ik++) {
        // print(
        //     "getheaderData sapDocentry:::${getheaderData[ik]['sapDocentry'].toString()}");
        // print("getSalesQuotationvalueDB length:${getheaderData.length}");
        if (selectedcust!.cardCode.toString() ==
            getheaderData[ik]['customercode'].toString()) {
          List<Map<String, Object?>> lineData =
              await DBOperation.getSalesQuotationLinevalueDB(
                  db, getheaderData[ik]['docentry'].toString());
          for (int i = 0; i < lineData.length; i++) {
            if (getheaderData[ik]['docentry'].toString() ==
                lineData[i]['docentry'].toString()) {
              scannData.add(StocksnapModelData(
                  basedocentry: lineData[i]['docentry'].toString(),
                  sapbasedocentry:
                      int.parse(getheaderData[ik]['sapDocentry'].toString()),
                  baselineid: lineData[i]['lineID'].toString(),
                  basic: lineData[i]['basic'] != null
                      ? double.parse(lineData[i]['basic'].toString())
                      : 00,
                  netvalue: lineData[i]['netlinetotal'] != null
                      ? double.parse(lineData[i]['netlinetotal'].toString())
                      : null,
                  TransID: int.parse(lineData[i]['docentry'].toString()),
                  Branch: lineData[i]['branch'].toString(),
                  ItemCode: lineData[i]['itemcode'].toString(),
                  ItemName: lineData[i]['itemname'].toString(),
                  SerialBatch: lineData[i]['serialbatch'].toString(),
                  OpenQty: int.parse(lineData[i]['quantity'].toString()),
                  Qty: lineData[i]['Balanceqty'] != null
                      ? int.parse(lineData[i]['Balanceqty'].toString())
                      : int.parse(lineData[i]['quantity'].toString()),
                  InDate: lineData[i][''].toString(),
                  InType: lineData[i][''].toString(),
                  VenCode: lineData[i][''].toString(),
                  VenName: lineData[i][''].toString(),
                  MRP: 0,
                  SellPrice: double.parse(lineData[i]['price'].toString()),
                  Cost: 0,
                  discount: lineData[i]['discperunit'] != null
                      ? double.parse(lineData[i]['discperunit'].toString())
                      : 00,
                  taxvalue: lineData[i]['taxtotal'] != null
                      ? double.parse(lineData[i]['taxtotal'].toString())
                      : 00,
                  TaxRate: double.parse(lineData[i]['taxrate'].toString()),
                  TaxType: lineData[i]['taxtype'].toString(),
                  Maxdiscount: lineData[i]['maxdiscount'].toString(),
                  discountper: lineData[i]['discperc'] == null
                      ? 0.0
                      : double.parse(lineData[i]['discperc'].toString()),
                  createdUserID: '',
                  createdateTime: lineData[i]['createdateTime'].toString(),
                  lastupdateIp: '',
                  purchasedate: '',
                  snapdatetime: '',
                  specialprice: 0,
                  updatedDatetime: '',
                  updateduserid: '',
                  liter: lineData[i]['liter'] == null
                      ? 0.0
                      : double.parse(lineData[i]['liter'].toString()),
                  weight: lineData[i]['weight'] == null
                      ? 0.0
                      : double.parse(lineData[i]['weight'].toString())));

              sapBaseDocEntry =
                  int.parse(getheaderData[ik]['sapDocentry'].toString());
            }
          }
          SalesModel salesM = SalesModel(
            objname: getheaderData[ik]['objname'].toString(),
            objtype: getheaderData[ik]['objtype'].toString(),
            doctype: getheaderData[ik]['doctype'].toString(),
            docentry: int.parse(getheaderData[ik]['docentry'].toString()),
            custName: getheaderData[ik]['customername'].toString(),
            phNo: getheaderData[ik]['customerphono'].toString(),
            cardCode: getheaderData[ik]['customercode'].toString(),
            accBalance: getheaderData[ik]['customeraccbal'].toString(),
            point: getheaderData[ik]['customerpoint'].toString(),
            tarNo: getheaderData[ik]['taxno'].toString(),
            email: getheaderData[ik]['customeremail'].toString(),
            sapInvoiceNum: getheaderData[ik]['sapDocNo'].toString(),
            invoceAmount:
                double.parse(getheaderData[ik]['doctotal'].toString()),
            invoceDate: config
                .alignDate(getheaderData[ik]['createdateTime'].toString()),
            invoiceNum: getheaderData[ik]['documentno'].toString(),
            invoiceClr: 0,
            checkBClr: false,
            address: [
              Address(
                  address1: getheaderData[ik]['billaddressid'].toString(),
                  billCity: getheaderData[ik]['city'].toString(),
                  billCountry: getheaderData[ik]['country'].toString(),
                  billPincode: getheaderData[ik]['pinno'].toString(),
                  billstate: getheaderData[ik]['state'].toString())
            ],
            totalPayment: TotalPayment(
              // balance: getheaderData[j]['baltopay'] == null
              //     ? 0.00
              //     : double.parse(getheaderData[j]['baltopay'].toString()),

              discount2: getheaderData[ik]['docdiscamt'] == null
                  ? 0.00
                  : double.parse(getheaderData[ik]['docdiscamt'].toString()),
              discount: getheaderData[ik]['docdiscamt'] == null
                  ? 0.00
                  : double.parse(getheaderData[ik]['docdiscamt'].toString()),
              totalTX: double.parse(getheaderData[ik]['taxamount'] == null
                  ? '0'
                  : getheaderData[ik]['taxamount']
                      .toString()
                      .replaceAll(',', '')),

              subtotal: double.parse(getheaderData[ik]['docbasic'] == null
                  ? '0'
                  : getheaderData[ik]['docbasic']
                      .toString()
                      .replaceAll(',', '')), //doctotal

              total: totalPayment == null
                  ? 0
                  : int.parse(totalPayment!.total!.toString()),
              totalDue: double.parse(getheaderData[ik]['doctotal'] == null
                  ? '0'
                  : getheaderData[ik]['doctotal']
                      .toString()
                      .replaceAll(',', '')),
              totpaid: double.parse(getheaderData[ik]['amtpaid'] == null
                  ? '0'
                  : getheaderData[ik]['amtpaid']
                      .toString()
                      .replaceAll(',', '')),
            ),
            item: scannData,
          );
          getsqdata = false;

          soSalesmodl.add(salesM);
          print("soSalesmodl XXX::${soSalesmodl.length}");

          notifyListeners();
        }
      }
      notifyListeners();
    }
    cancelbtn = false;
  }

  itemDeSelect(int i) {
    print("HHHHHHH");
    if (soSalesmodl[i].invoiceClr == 0 && soSalesmodl[i].checkBClr == false) {
      print("AAAAA");
      soSalesmodl[i].invoiceClr = 1;
      soSalesmodl[i].checkBClr = true;

      notifyListeners();
    } else if (soSalesmodl[i].invoiceClr == 1 &&
        soSalesmodl[i].checkBClr == true) {
      print("BBBBBBB");
      soSalesmodl[i].invoiceClr = 0;
      soSalesmodl[i].checkBClr = false;
      // totalduepay = totalduepay! - scanneditemData[i].amount!;
      notifyListeners();
    }

    notifyListeners();
  }

  salesQuodata() {
    soData.clear();
    for (int ih = 0; ih < soSalesmodl.length; ih++) {
      //log("soSalesmodl[ih].item:::${soSalesmodl[ih].item!.length}");

      if (soSalesmodl[ih].invoiceClr == 1 &&
          soSalesmodl[ih].checkBClr == true) {
        for (int ik = 0; ik < soSalesmodl[ih].item!.length; ik++) {
          if (soSalesmodl[ih].item![ik].basedocentry.toString() ==
              soSalesmodl[ih].docentry.toString()) {
            if (soSalesmodl[ih].item![ik].Qty != 0) {
              soData.add(StocksnapModelData(
                docentry: soSalesmodl[ih].docentry.toString(),
                basedocentry: soSalesmodl[ih].item![ik].basedocentry,
                baselineid: soSalesmodl[ih].item![ik].baselineid,
                Branch: soSalesmodl[ih].item![ik].Branch,
                ItemCode: soSalesmodl[ih].item![ik].ItemCode,
                ItemName: soSalesmodl[ih].item![ik].ItemName,
                SerialBatch: '',
                Qty: soSalesmodl[ih].item![ik].Qty,
                MRP: double.parse(soSalesmodl[ih].item![ik].MRP.toString()),
                createdUserID:
                    soSalesmodl[ih].item![ik].createdUserID.toString(),
                createdateTime: config.alignDate(
                    soSalesmodl[ih].item![ik].createdateTime.toString()),
                lastupdateIp: soSalesmodl[ih].item![ik].lastupdateIp,
                purchasedate: soSalesmodl[ih].item![ik].purchasedate,
                snapdatetime: soSalesmodl[ih].item![ik].snapdatetime,
                sapbasedocentry: soSalesmodl[ih].item![ik].sapbasedocentry,
                specialprice: double.parse(
                    soSalesmodl[ih].item![ik].specialprice.toString()),
                updatedDatetime: soSalesmodl[ih].item![ik].updatedDatetime,
                updateduserid:
                    soSalesmodl[ih].item![ik].updateduserid.toString(),
                SellPrice: double.parse(
                    soSalesmodl[ih].item![ik].SellPrice.toString()),
                Maxdiscount: soSalesmodl[ih].item![ik].Maxdiscount != null
                    ? soSalesmodl[ih].item![ik].Maxdiscount.toString()
                    : '',
                TaxRate: soSalesmodl[ih].item![ik].TaxRate != null
                    ? double.parse(soSalesmodl[ih].item![ik].TaxRate.toString())
                    : 0.0,
                discountper: double.parse(
                    soSalesmodl[ih].item![ik].discountper!.toString()),
                OpenQty: soSalesmodl[ih].item![ik].Qty,
                InDate: '',
                Cost: 0,
                TaxType: '',
                InType: '',
                VenCode: '',
                VenName: '',
                liter: soSalesmodl[ih].item![ik].liter != null
                    ? double.parse(soSalesmodl[ih].item![ik].liter.toString())
                    : 0.0,
                weight: soSalesmodl[ih].item![ik].weight != null
                    ? double.parse(soSalesmodl[ih].item![ik].weight.toString())
                    : 0.0,
              ));
              notifyListeners();
            }
            //log("soDatasoDatasoData length::" + soData.length.toString());
          }
        }

        notifyListeners();
      }
      notifyListeners();
    }
  }

  soqtychangealertbc(int ikn, BuildContext context, ThemeData theme) {
    if (soqtycontroller[ikn].text.isNotEmpty) {
      int sqqtyyy = int.parse(soqtycontroller[ikn].text.toString());
      if (soData[ikn].Qty! >= sqqtyyy) {
        soqtycontroller[ikn].text = sqqtyyy.toString();
        notifyListeners();
      } else {
        notifyListeners();

        soqtycontroller[ikn].text = '';
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
      }
    }
    notifyListeners();

    // }
  }

  clearsQaqty() {
    soqtycontroller = List.generate(100, (ij) => TextEditingController());
  }

  // int soqty = 0;
  // mapsqqtycheck(BuildContext context, ThemeData theme) {
  //   for (int ikn = 0; ikn < soData.length; ikn++) {

  //     if (soqtycontroller[ikn].text.isNotEmpty && int.parse(soqtycontroller[ikn].text.toString()) == 0) {
  //  //log("VVVVVVVVVVVVVV");
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
  //               content: 'Your Quantity is less than 1',
  //               theme: theme,
  //             )),
  //             buttonName: null,
  //           ));
  //     });
  //       notifyListeners();
  //     } else {
  //       if (soqtycontroller[ikn].text.isEmpty &&
  //           soData[ikn].Qty! >= (int.parse(soqtycontroller[ikn].text))) {
  //         mapSQData(context, theme, ikn);
  //       }
  //       Navigator.pop(context);
  //     }
  //     notifyListeners();
  //   }
  // }
  bool cpyfrmsq = false;
  sqQtyEdited(int ind, BuildContext context, ThemeData theme) {
    for (int kn = 0; kn < soData.length; kn++) {
      if (soData[kn].docentry.toString() ==
              scanneditemData[ind].docentry.toString() &&
          soData[kn].basedocentry.toString() ==
              scanneditemData[ind].basedocentry.toString() &&
          soData[kn].ItemCode.toString() ==
              scanneditemData[ind].ItemCode.toString()) {
        if (soData[kn].Qty! >=
            int.parse(qtymycontroller[ind].text.toString())) {
          calCulateDocVal(context, theme);
          notifyListeners();
        } else {
          qtymycontroller[ind].text = scanneditemData[ind].Qty.toString();
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: EdgeInsets.all(0),
                    content: AlertBox(
                      payMent: 'Alert',
                      errormsg: true,
                      widget: Center(
                          child: ContentContainer(
                        content: 'No more qty to add!!..',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
        }
        notifyListeners();
      }
    }
  }

  mapSQData(
    BuildContext context,
    ThemeData theme,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    int? totqty;
    mycontroller[50].text = "";
    List<Address>? add5 = [];
    List<Address>? sipadd5 = [];
    totalPayment = null;
    selectedcust2 = null;
    selectedcust = null;
    selectedBillAdress = 0;
    selectedShipAdress = 0;
    scanneditemData = [];
    cpyfrmsq = true;

    for (int ih = 0; ih < soSalesmodl.length; ih++) {
      List<Map<String, Object?>> csadresdataDB =
          await DBOperation.addgetCstmMasAddDB(
              db, soSalesmodl[ih].cardCode.toString());

      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (soSalesmodl[ih].cardCode.toString() ==
            csadresdataDB[ia]['custcode'].toString()) {
          if (csadresdataDB[ia]['addresstype'] == "B") {
            add5.add(Address(
              autoId: int.parse(csadresdataDB[ia]['autoid'].toString()),
              addresstype: csadresdataDB[ia]['addresstype'].toString(),
              address1: csadresdataDB[ia]['address1'].toString(),
              address2: csadresdataDB[ia]['address2'].toString(),
              address3: csadresdataDB[ia]['address3'].toString(),
              billCity: csadresdataDB[ia]['city'].toString(),
              billCountry: csadresdataDB[ia]['countrycode'].toString(),
              billPincode: csadresdataDB[ia]['pincode'].toString(),
              billstate: csadresdataDB[ia]['statecode'].toString(),
            ));
          }

          if (csadresdataDB[ia]['addresstype'] == "S") {
            sipadd5.add(Address(
              autoId: int.parse(csadresdataDB[ia]['autoid'].toString()),
              addresstype: csadresdataDB[ia]['addresstype'].toString(),
              address1: csadresdataDB[ia]['address1'].toString(),
              address2: csadresdataDB[ia]['address2'].toString(),
              address3: csadresdataDB[ia]['address3'].toString(),
              billCity: csadresdataDB[ia]['city'].toString(),
              billCountry: csadresdataDB[ia]['countrycode'].toString(),
              billPincode: csadresdataDB[ia]['pincode'].toString(),
              billstate: csadresdataDB[ia]['statecode'].toString(),
            ));
          }
        }

        notifyListeners();
      }

      selectedcust = CustomerDetals(
        name: soSalesmodl[ih].custName,
        phNo: soSalesmodl[ih].phNo,
        cardCode: soSalesmodl[ih].cardCode,
        accBalance: double.parse(soSalesmodl[ih].accBalance.toString()),
        point: soSalesmodl[ih].point,
        address: add5,
        tarNo: soSalesmodl[ih].tarNo,
        docentry: soSalesmodl[ih].docentry.toString(),
        email: soSalesmodl[ih].email,
      );

      selectedcust55 = CustomerDetals(
        name: soSalesmodl[ih].custName,
        phNo: soSalesmodl[ih].phNo,
        cardCode: soSalesmodl[ih].cardCode,
        accBalance: double.parse(soSalesmodl[ih].accBalance.toString()),
        point: soSalesmodl[ih].point,
        address: sipadd5,
        tarNo: soSalesmodl[ih].tarNo,
        docentry: soSalesmodl[ih].docentry.toString(),
        email: soSalesmodl[ih].email,
      );
    }

    notifyListeners();
    for (int ikn = 0; ikn < soData.length; ikn++) {
      totqty = soqtycontroller[ikn].text.isEmpty
          ? 0
          : int.parse(soqtycontroller[ikn].text);
      if (totqty > 0 && soData[ikn].Qty! >= totqty) {
        //log("AAAAAAAAAAAAA:::${soData[ikn].basedocentry}::${soData[ikn].baselineid}");
        scanneditemData.add(StocksnapModelData(
          docentry: soData[ikn].docentry.toString(),
          basedocentry: soData[ikn].basedocentry,
          baselineid: soData[ikn].baselineid,
          Branch: soData[ikn].Branch,
          ItemCode: soData[ikn].ItemCode,
          ItemName: soData[ikn].ItemName,
          sapbasedocentry: soData[ikn].sapbasedocentry,
          SerialBatch: '',
          Qty: int.parse(soqtycontroller[ikn].text),
          MRP: double.parse(soData[ikn].MRP.toString()),
          createdUserID: soData[ikn].createdUserID.toString(),
          createdateTime: soData[ikn].createdateTime.toString(),
          lastupdateIp: soData[ikn].lastupdateIp,
          purchasedate: soData[ikn].purchasedate,
          snapdatetime: soData[ikn].snapdatetime,
          specialprice: double.parse(soData[ikn].specialprice.toString()),
          updatedDatetime: soData[ikn].updatedDatetime,
          updateduserid: soData[ikn].updateduserid.toString(),
          SellPrice: double.parse(soData[ikn].SellPrice.toString()),
          Maxdiscount: soData[ikn].Maxdiscount != null
              ? soData[ikn].Maxdiscount.toString()
              : '',
          TaxRate: soData[ikn].TaxRate != null
              ? double.parse(soData[ikn].TaxRate.toString())
              : 0.0,
          discountper: double.parse(soData[ikn].discountper!.toString()),
          OpenQty: soData[ikn].Qty,
          InDate: '',
          Cost: 0,
          TaxType: '',
          InType: '',
          VenCode: '',
          VenName: '',
          liter: soData[ikn].liter != null
              ? double.parse(soData[ikn].liter.toString())
              : 0.0,
          weight: soData[ikn].weight != null
              ? double.parse(soData[ikn].weight.toString())
              : 0.0,
        ));
        notifyListeners();
      }
    }

    for (int il = 0; il < scanneditemData.length; il++) {
      scanneditemData[il].TransID = il;
      qtymycontroller[il].text = scanneditemData[il].Qty.toString();
      // discountcontroller[il].text = scanneditemData[il].discountper.toString();
    }

    notifyListeners();
    await calCulateDocVal(context, theme);
    Navigator.pop(context);
    notifyListeners();
  }

// new draft hold

  calculatescheme(BuildContext context, ThemeData theme) async {
    double discount = 0;

    for (int ik = 0; ik < resSchemeDataList.length; ik++) {
      print('discount2::${resSchemeDataList.length}');

      print('discount3::${resSchemeDataList[ik].lineNum}');
      discount = 0;

      for (int i = 0; i < scanneditemData.length; i++) {
        // discountcontroller[i].text=0.toString();
        //log('discount4::${scanneditemData[i].TransID}');

        if (resSchemeDataList[ik].lineNum == scanneditemData[i].TransID) {
          discount = discount + resSchemeDataList[ik].discPer;
          discountcontroller[i].text = discount.toString();
          print('discount5::${discountcontroller[i].text}');

          notifyListeners();
        }
      }
    }
    calCulateDocVal(context, theme);
    notifyListeners();
  }

  callSchemeOrderAPi() async {
    catchmsg = [];
    resSchemeDataList = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      // discountcontroller[i].text=0.toString();
      //log('discount4::${scanneditemData[i].TransID}');

      discountcontroller[i].text = 0.0.toString();
      //log('discount5::${discountcontroller[i].text}');

      notifyListeners();
    }
    //log("schemeData::${schemeData.length}");
    await SchemeOrderAPi.getGlobalData(schemeData).then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.saleOrder != null) {
          //log("KKKKKKKKKKK1");
          for (int i = 0; i < value.saleOrder!.length; i++) {
            //log("KKKKKKKKKKK2::${value.saleOrder!.length}");
            resSchemeDataList.add(SchemeOrderModalData(
                docEntry: value.saleOrder![i].docEntry,
                schemeEntry: value.saleOrder![i].schemeEntry,
                lineNum: value.saleOrder![i].lineNum,
                discPer: value.saleOrder![i].discPer,
                discVal: value.saleOrder![i].discVal));
            notifyListeners();
          }
          //log("_______________" + resSchemeDataList.length.toString());

          notifyListeners();
        } else if (value.saleOrder == null) {
          //log("KKKKKKKKKKK3");

          // exception = value.message!;
          catchmsg.add("Stock details2: " + value.message!);
          notifyListeners();
        }
      } else if (value.statuscode >= 400 && value.statuscode <= 410) {
        // exception = value.exception!;
        catchmsg.add("Stock details3: " + value.exception!);
      } else {
        // exception = value.exception!;
        catchmsg.add("Stcok details4: " + value.exception!);
      }
    });
    notifyListeners();
  }

  salesOrderSchemeData() async {
    schemeData = [];
    //log('Step1');
    for (int i = 0; i < scanneditemData.length; i++) {
      //log('Step2');

      schemeData.add(SalesOrderScheme(
        ItemCode: scanneditemData[i].ItemCode.toString(),
        PriceBefDi: scanneditemData[i].SellPrice.toString(),
        Quantity: qtymycontroller[i].text,
        UCartons: 0.toString(),
        lineno: i.toString(),
        balance: selectedcust!.accBalance.toString(),
        customer: selectedcust!.cardCode.toString(),
        Warehouse: AppConstant.branch,
      ));
      notifyListeners();
    }

    notifyListeners();
  }

  getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;
    List<HoldedHeader> holdData = [];
    fileterHoldData = [];
    List<Map<String, Object?>> getholddata =
        await DBOperation.getSalesOrderHeadHoldvalueDB(db);
    for (int i = 0; i < getholddata.length; i++) {
      holdData.add(HoldedHeader(
          CardName: getholddata[i]['customername'].toString(),
          Cardcode: getholddata[i]['customercode'].toString(),
          docEntry: int.parse(getholddata[i]['docentry'].toString()),
          docNo: getholddata[i]['documentno'].toString(),
          date: getholddata[i]['createdateTime'].toString()));
      notifyListeners();
    }
    fileterHoldData = holdData;
    //log("fileterHoldDatafileterHoldData::${fileterHoldData.length}");
    notifyListeners();
  }

  mapHoldSelectedValues(
      HoldedHeader holddata, BuildContext context, ThemeData theme) async {
    holddocentry = '';
    loadingscrn = true;
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>>? getDBholdSalesLine =
        await DBOperation.getSalesOrderLineDB(
            db, int.parse(holddata.docEntry.toString()));

    List<Map<String, Object?>> getDBholdSalespay =
        await DBOperation.getdSalesOrderPayDB(
            db, int.parse(holddata.docEntry.toString()));

    List<Map<String, Object?>> getcustomer =
        await DBOperation.getCstmMasDatabyautoid(
            db, holddata.Cardcode.toString());

    List<Map<String, Object?>> getcustaddd =
        await DBOperation.addgetCstmMasAddDB(db, holddata.Cardcode.toString());

    mapCustomer(getcustomer, getcustaddd);
    mapPayment(getDBholdSalespay);
    mapProdcut(getDBholdSalesLine, context, theme);
    getCustDetFDB();
    holddocentry = holddata.docEntry.toString();
    calCulateDocVal(context, theme);

    // await DBOperation.deleteHoldMaped(db, holddata.docEntry!).then((value) {
    //   holdData.clear();
    // await getdraftindex();
    //   //log('datatatatatatata deleleleleleelle ');
    // });
    notifyListeners();
  }

  mapCustomer(List<Map<String, Object?>> custData,
      List<Map<String, Object?>> getcustaddd) async {
    final Database db = (await DBHelper.getInstance())!;

    selectedcust = null;
    selectedcust55 = null;
    List<Map<String, Object?>> getholddata =
        await DBOperation.getSalesOrderHeadHoldvalueDB(db);
    selectedcust = CustomerDetals(
      name: custData[0]['customername'].toString(),
      phNo: custData[0]['phoneno1'].toString(),
      cardCode: custData[0]['customercode'].toString(),
      accBalance: double.parse(custData[0]['balance'].toString()),
      point: custData[0]['points'].toString(),
      address: [],
      email: custData[0]['emalid'].toString(),
      tarNo: custData[0]['taxno'].toString(),
    );

    // selectedcust = selectedcust2;
    for (int ik = 0; ik < getholddata.length; ik++) {
      remarkcontroller3.text = getholddata[ik]['remarks'].toString();
      for (int i = 0; i < getcustaddd.length; i++) {
        if (getholddata[ik]['billaddressid'].toString() != null ||
            getholddata[ik]['billaddressid'].toString().isNotEmpty) {
          if (getholddata[ik]['billaddressid'].toString() ==
              getcustaddd[i]['autoid'].toString()) {
            // if (  getcustaddd[i]['addresstype'].toString() == 'B' ) {
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
          }
        }

        if (getholddata[ik]['shipaddresid'].toString().isNotEmpty) {
          if (getholddata[ik]['shipaddresid'].toString() ==
              getcustaddd[i]['autoid'].toString()) {
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
        }
      }
    }
    await AccountBalApi.getData(selectedcust!.cardCode.toString())
        .then((value) {
      loadingscrn = false;
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        selectedcust!.accBalance =
            double.parse(value.accBalanceData![0].balance.toString());
        // selectedcust55!.accBalance = double.parse(value.accBalanceData![0].balance.toString());
        notifyListeners();
      }
    });
    notifyListeners();
  }

  mapProdcut(List<Map<String, Object?>> lineData, BuildContext context,
      ThemeData theme) {
    //log("LineData: {} ${lineData.length}");
    scanneditemData = [];
    for (int i = 0; i < lineData.length; i++) {
      //log("lineData[i]['quantity'].toString()::${lineData[i]['quantity']}");
      scanneditemData.add(StocksnapModelData(
          basic: lineData[i]['basic'] != null
              ? double.parse(lineData[i]['basic'].toString())
              : 00,
          netvalue: lineData[i]['netlinetotal'] != null
              ? double.parse(lineData[i]['netlinetotal'].toString())
              : null,
          docentry: lineData[i]['docentry'].toString(),
          basedocentry: lineData[i]['basedocentry'].toString(),
          baselineid: lineData[i]['baselineID'].toString(),
          Branch: lineData[i]['branch'].toString(),
          ItemCode: lineData[i]['itemcode'].toString(),
          ItemName: lineData[i]['itemname'].toString(),
          SerialBatch: lineData[i]['serialbatch'].toString(),
          OpenQty: int.parse(lineData[i]['quantity'].toString()),
          Qty: int.parse(lineData[i]['quantity'].toString()),
          InDate: lineData[i][''].toString(),
          InType: lineData[i][''].toString(),
          VenCode: lineData[i][''].toString(),
          VenName: lineData[i][''].toString(),
          MRP: 0,
          SellPrice: double.parse(lineData[i]['price'].toString()),
          Cost: 0,
          discount: lineData[i]['discperunit'] != null
              ? double.parse(lineData[i]['discperunit'].toString())
              : 00,
          taxvalue: lineData[i]['taxtotal'] != null
              ? double.parse(lineData[i]['taxtotal'].toString())
              : 00,
          TaxRate: double.parse(lineData[i]['taxrate'].toString()),
          TaxType: lineData[i]['taxtype'].toString(),
          Maxdiscount: lineData[i]['maxdiscount'].toString(),
          discountper: lineData[i]['discperc'] == null
              ? 0.0
              : double.parse(lineData[i]['discperc'].toString()),
          createdUserID: '',
          createdateTime: '',
          lastupdateIp: '',
          purchasedate: '',
          snapdatetime: '',
          specialprice: 0,
          updatedDatetime: '',
          updateduserid: '',
          liter: lineData[i]['liter'] == null
              ? 0.0
              : double.parse(lineData[i]['liter'].toString()),
          weight: lineData[i]['weight'] == null
              ? 0.0
              : double.parse(lineData[i]['weight'].toString())));
    }
    notifyListeners();

    for (int ig = 0; ig < scanneditemData.length; ig++) {
      scanneditemData[ig].TransID = ig;
      discountcontroller[ig].text = scanneditemData[ig].discountper!.toString();
      qtymycontroller[ig].text = scanneditemData[ig].OpenQty!.toString();
      //log("qtymycontroller[ig].text:${qtymycontroller[ig].text}");
      notifyListeners();
    }
    calCulateDocVal(context, theme);
    notifyListeners();
  }

  mapPayment(List<Map<String, Object?>> payment) {
    paymentWay.clear();
    for (int i = 0; i < payment.length; i++) {
      paymentWay.add(PaymentWay(
        amt: double.parse(payment[i]['rcamount'].toString()),
        type: payment[i]['rcmode'].toString(),
        dateTime: payment[i]['createdateTime'].toString(),
        reference: payment[i]['reference'] != null
            ? payment[i]['reference'].toString()
            : '',
        cardApprno: payment[i]['cardApprno'] != null
            ? payment[i]['cardApprno'].toString()
            : '',
        cardref: payment[i]['cardref'].toString(),
        cardterminal: payment[i]['cardterminal'].toString(),
        chequedate: payment[i]['chequedate'].toString(),
        chequeno: payment[i]['chequeno'].toString(),
        couponcode: "",
        coupontype: "",
        discountcode: payment[i]['discountcode'].toString(),
        discounttype: payment[i]['discounttype'].toString(),
        recoverydate: payment[i]['recoverydate'].toString(),
        redeempoint: payment[i]['redeempoint'].toString(),
        availablept: payment[i]['availablept'].toString(),
        remarks: payment[i]['remarks'].toString(),
        transtype: payment[i]['transtype'].toString(),
        walletid: payment[i]['walletid'].toString(),
        wallettype: payment[i]['wallettype'].toString(),
      ));
      notifyListeners();
    }
    notifyListeners();
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

  injectToDb() async {
    final Database db = (await DBHelper.getInstance())!;
    await getItemFromDB(db);
    notifyListeners();
  }

  // insertCusToDB(Database db) async {
  //   List<CustomerModelDB> values = [];
  //   List<CustomerAddressModelDB> addrsvalue = [];
  //   for (int i = 0; i < custList2.length; i++) {
  //     values.add(CustomerModelDB(
  //         customerCode: custList2[i].cardCode,
  //         createdUserID: '1',
  //         createdateTime: config.currentDate(),
  //         lastupdateIp: 1,
  //         updatedDatetime: config.currentDate(),
  //         updateduserid: 1,
  //         balance: 20000.00,
  //         createdbybranch: "cbe1",
  //         customername: custList2[i].name,
  //         customertype: 'B',
  //         emalid: custList2[i].email,
  //         phoneno1: custList2[i].phNo,
  //         phoneno2: '',
  //         points: double.parse(custList2[i].point.toString()),
  //         premiumid: '',
  //         snapdatetime: config.currentDate(),
  //         taxno: custList2[i].tarNo));
  //     for (int ia = 0; ia < custList2[i].address!.length; ia++) {
  //       addrsvalue.add(CustomerAddressModelDB(
  //           createdUserID: "1",
  //           createdateTime: config.currentDate(),
  //           lastupdateIp: 1,
  //           updatedDatetime: config.currentDate(),
  //           updateduserid: 1,
  //           address1: custList2[i].address![ia].address1,
  //           address2: custList2[i].address![ia].address2,
  //           address3: custList2[i].address![ia].address3,
  //           city: custList2[i].address![ia].billCity,
  //           countrycode: custList2[i].address![ia].billCountry,
  //           custcode: custList2[i].cardCode,
  //           geolocation1: '',
  //           geolocation2: '',
  //           statecode: custList2[i].address![ia].billstate,
  //           pincode: custList2[i].address![ia].billPincode));
  //     }
  //   }
  //   await DBOperation.insertCustomer(db, values);
  //   await DBOperation.insertCustomerAddress(db, addrsvalue);
  //   await DBOperation.getdata(db);
  // }

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

  filterAprvlBoxList(String v) {
//log("searchAprvlData length:::${searchAprvlData.length}");
    if (v.isNotEmpty) {
      filterAprvlData = searchAprvlData
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.DocNum.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterAprvlData = searchAprvlData;
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
      // print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[100].text = datetype!;
      // print(datetype);
    } else if (pickedDate != null && datetype == "To") {
      // print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[101].text = datetype!;
      // print(datetype);
    } else {
      print("Date is not selected");
    }
  }

  getAprvlDate2(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (pickedDate != null && datetype == "From") {
      // print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[102].text = datetype!;
      // print(datetype);
    } else if (pickedDate != null && datetype == "To") {
      // print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[103].text = datetype!;
      // print(datetype);
    } else {
      print("Date is not selected");
    }
  }

  searchInitMethod() {
    mycontroller[100].text = config.alignDate(config.currentDate());
    mycontroller[101].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  searchAprvlMethod() {
    mycontroller[102].text = config.alignDate(config.currentDate());
    mycontroller[103].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  // searchMainMethod(String fromDate, String toDate) {
  //   mycontroller[100].text = config.alignDate(config.currentDate());
  //   mycontroller[101].text = config.alignDate(config.currentDate());
  //   notifyListeners();
  // }
// bool searchError=false;
  callAprvllDataDatewise(String fromdate, String todate) async {
    searchAprvlData = [];
    filterAprvlData = [];
//log("fromdate::$fromdate.$todate");
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    GetDyApprovalAPi.slpCode = '67';
    AppConstant.sapDB = "MRP T1";
    GetDyApprovalAPi.dbname = "MRP T1";
    GetDyApprovalAPi.getGlobalData(fromdate, todate).then(
      (value) {
        if (value.statusCode! >= 200 && value.statusCode! <= 204) {
          //log("value.approvedData length::${value.approvedData!.length}");
          searchAprvlData = value.approvedData!;
          filterAprvlData = searchAprvlData;
          notifyListeners();
        }
      },
    );

    notifyListeners();
  }

  mapApprovalData() async {
    selectedcust2 = null;
    selectedcust25 = null;
    scanneditemData2 = [];
    paymentWay2 = [];
    totalPayment2 = null;
    final Database db = (await DBHelper.getInstance())!;
    int totalQuantity = 0;
// approvalDetailsValue
    List<Map<String, Object?>> getsoheader = await DBOperation.getSoApprovalsts(
        db, approvalDetailsValue!.uDevicTransId.toString());
    if (getsoheader.isNotEmpty) {
      //log("etsoheader docentry::${getsoheader[0]['docentry'].toString()}");
      tbDocEntry = int.parse(getsoheader[0]['docentry'].toString());
      List<Map<String, Object?>> getsoLineData =
          await DBOperation.getSalesOrderLineDB(
              db, int.parse(getsoheader[0]['docentry'].toString()));
      List<Map<String, Object?>> getDBSalespay =
          await DBOperation.getdSalesOrderPayDB(
              db, int.parse(getsoheader[0]['docentry'].toString()));
      List<Map<String, Object?>> newcusdataDB =
          await DBOperation.getCstmMasDatabyautoid(
              db, approvalDetailsValue!.cardCode.toString());

      List<Address>? address2 = [];
      List<Address>? address25 = [];
      List<CustomerAddressModelDB> csadresdataDB =
          await DBOperation.getCstmMasAddDB(
        db,
      );
      for (int k = 0; k < csadresdataDB.length; k++) {
        if (csadresdataDB[k].custcode.toString() ==
            getsoheader[0]['customercode'].toString()) {
          if (csadresdataDB[k].autoid.toString() ==
              getsoheader[0]['billaddressid'].toString()) {
            address2 = [
              Address(
                  autoId: int.parse(csadresdataDB[k].autoid.toString()),
                  address1: csadresdataDB[k].address1,
                  address2: csadresdataDB[k].address2,
                  address3: csadresdataDB[k].address3,
                  custcode: csadresdataDB[k].custcode,
                  billCity: csadresdataDB[k].city!, //city
                  billCountry: csadresdataDB[k].countrycode!, //country
                  billPincode: csadresdataDB[k].pincode!, //pinno
                  billstate: csadresdataDB[k].statecode)
            ];
          }
          if (getsoheader[0]['shipaddresid'].toString().isNotEmpty) {
            if (csadresdataDB[k].autoid.toString() ==
                getsoheader[0]['shipaddresid'].toString()) {
              address25 = [
                Address(
                    autoId: int.parse(csadresdataDB[k].autoid.toString()),
                    address1: csadresdataDB[k].address1,
                    address2: csadresdataDB[k].address2,
                    address3: csadresdataDB[k].address3,
                    custcode: csadresdataDB[k].custcode,
                    billCity: csadresdataDB[k].city!, //city
                    billCountry: csadresdataDB[k].countrycode!, //country
                    billPincode: csadresdataDB[k].pincode!, //pinno
                    billstate: csadresdataDB[k].statecode)
              ];
            }
          }
        }
      }
      for (int ij = 0; ij < newcusdataDB.length; ij++) {
        selectedcust2 = CustomerDetals(
            docentry: getsoheader[0]['docentry'].toString(),
            autoId: newcusdataDB[ij]['autoid'].toString(),
            cardCode: newcusdataDB[ij]['customercode'].toString(),
            name: newcusdataDB[ij]['customername'].toString(),
            phNo: newcusdataDB[ij]['phoneno1'].toString(),
            accBalance: double.parse(newcusdataDB[ij]['balance'].toString()),
            point: newcusdataDB[ij]['points'].toString(),
            tarNo: newcusdataDB[ij]['taxno'].toString(),
            email: newcusdataDB[ij]['emalid'].toString(),
            invoicenum: '',
            invoiceDate: '',
            totalPayment: 00,
            address: address2);
        notifyListeners();
        selectedcust25 = CustomerDetals(
            docentry: getsoheader[0]['docentry'].toString(),
            autoId: newcusdataDB[ij]['autoid'].toString(),
            cardCode: newcusdataDB[ij]['customercode'].toString(),
            name: newcusdataDB[ij]['customername'].toString(),
            phNo: newcusdataDB[ij]['phoneno1'].toString(),
            accBalance: double.parse(newcusdataDB[ij]['balance'].toString()),
            point: newcusdataDB[ij]['points'].toString(),
            tarNo: newcusdataDB[ij]['taxno'].toString(),
            email: newcusdataDB[ij]['emalid'].toString(),
            invoicenum: '',
            invoiceDate: '',
            totalPayment: 00,
            address: address25);
        notifyListeners();
      }

      for (int kk = 0; kk < getDBSalespay.length; kk++) {
        if (getDBSalespay[0]['docentry'] == getDBSalespay[kk]['docentry']) {
          paymentWay2.add(PaymentWay(
            amt: double.parse(getDBSalespay[kk]['rcamount'].toString()),
            type: getDBSalespay[kk]['rcmode'].toString(),
            dateTime: getDBSalespay[kk]['createdateTime'].toString(),
            reference: getDBSalespay[kk]['reference'] != null
                ? getDBSalespay[kk]['reference'].toString()
                : '',
            cardApprno: getDBSalespay[kk]['cardApprno'] != null
                ? getDBSalespay[kk]['cardApprno'].toString()
                : '',
            cardref: getDBSalespay[kk]['cardref'].toString(),
            cardterminal: getDBSalespay[kk]['cardterminal'].toString(),
            chequedate: getDBSalespay[kk]['chequedate'].toString(),
            chequeno: getDBSalespay[kk]['chequeno'].toString(),
            couponcode: "", //getDBholdSalespay[kk]['couponcode'].toString(),
            coupontype: "", //getDBholdSalespay[kk]['coupontype'].toString(),
            discountcode: getDBSalespay[kk]['discountcode'].toString(),
            discounttype: getDBSalespay[kk]['discounttype'].toString(),
            recoverydate: getDBSalespay[kk]['recoverydate'].toString(),
            redeempoint: getDBSalespay[kk]['redeempoint'].toString(),
            availablept: getDBSalespay[kk]['availablept'].toString(),
            remarks: getDBSalespay[kk]['remarks'].toString(),
            transtype: getDBSalespay[kk]['transtype'].toString(),
            walletid: getDBSalespay[kk]['walletid'].toString(),
            wallettype: getDBSalespay[kk]['wallettype'].toString(),
          ));

          notifyListeners();
        }
        //log("paymentWay2paymentWay2paymentWay2:::${paymentWay2.length}");
        notifyListeners();
      }

      for (int i = 0; i < getsoLineData.length; i++) {
        scanneditemData2.add(StocksnapModelData(
          discountper: double.parse(getsoLineData[i]['discperc'].toString()),
          Maxdiscount: getsoLineData[i]['maxdiscount'].toString(),
          Branch: getsoLineData[i]['branch'].toString(),
          ItemCode: getsoLineData[i]['itemcode'].toString(),
          ItemName: getsoLineData[i]['itemname'].toString(),
          SerialBatch: '',
          Qty: int.parse(getsoLineData[i]['quantity'].toString()),
          MRP: double.parse(
            getsoLineData[i]['price'].toString(),
          ),
          SellPrice: double.parse(getsoLineData[i]['price'].toString()),
          TaxRate: double.parse(getsoLineData[i]['taxrate'].toString()),
          weight: double.parse(getsoheader[0]['totalweight'].toString()),
          liter: double.parse(getsoheader[0]['totalltr'].toString()),
        ));
        notifyListeners();
        totquantity = getsoLineData[i]['quantity'].toString();
        // totalQuantity = int.parse(getsoLineData[i]['quantity'].toString());
      }

      for (int i = 0; i < scanneditemData2.length; i++) {
        qtymycontroller2[i].text = scanneditemData2[i].Qty.toString();
        // mycontroller2[i].text = scanneditemData2[i].discountper.toString();
        discountcontroller2[i].text =
            scanneditemData2[i].discountper.toString();

        totalQuantity =
            totalQuantity! + int.parse(qtymycontroller2[i].text.toString());

        notifyListeners();
      }
      totalPayment2 = TotalPayment(
        balance: getsoheader[0]['baltopay'] == null
            ? 0.00
            : double.parse(getsoheader[0]['baltopay'].toString()),

        discount2: getsoheader[0]['docdiscamt'] == null
            ? 0.00
            : double.parse(getsoheader[0]['docdiscamt'].toString()),
        // double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
        discount: getsoheader[0]['docdiscamt'] == null
            ? 0.00
            : double.parse(getsoheader[0]['docdiscamt'].toString()),
        totalTX: double.parse(getsoheader[0]['taxamount'] == null
            ? '0'
            : getsoheader[0]['taxamount'].toString().replaceAll(',', '')),

        subtotal: double.parse(getsoheader[0]['docbasic'] == null
            ? '0'
            : getsoheader[0]['docbasic']
                .toString()
                .replaceAll(',', '')), //doctotal

        total: totalQuantity,
        totalDue: double.parse(getsoheader[0]['doctotal'] == null
            ? '0'
            : getsoheader[0]['doctotal'].toString().replaceAll(',', '')),
        totpaid: double.parse(getsoheader[0]['amtpaid'] == null
            ? '0'
            : getsoheader[0]['amtpaid'].toString().replaceAll(',', '')),
      );

      notifyListeners();
    }
    notifyListeners();
  }

  // String? docEntry;
  // String? docDueDate;
  callApprovlSaveApi() {}

  String uttransId = '';
  getdraftDocEntry(BuildContext context) async {
    approvalDetailsValue = null;
    await sapOrderLoginApi(context);
    await ApprovalsDetailsAPi.getGlobalData().then((value) async {
      if (value != null) {
        log("cardName: " + value.cardName.toString());
        log("DocDueDate: " + value.DocDueDate.toString());
        // docEntry = value.docEntry.toString();
        // docDueDate = value.DocDueDate.toString();
        // value.Customervalue![0].salesPersonCode!.toStringAsFixed(0);
        //print(value.nextLink);
        // valuesReturn(value.approvalsvalue![0].ObjType.toString());
        approvalDetailsValue = value;
        documentApprovalValue = value.documentLines!;
        await mapApprovalData();
      } else if (value.error != null) {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  ApprovalDetailsValue? approvalDetailsValue;
  List<DocumentApprovalValue> documentApprovalValue = [];

  void callApprovaltoDocApi(BuildContext context) async {
    isLoading = true;

    final Database db = (await DBHelper.getInstance())!;
    await sapOrderLoginApi(context);
    ApprovalsQuotPostAPi.docEntry = approvalDetailsValue!.docEntry.toString();
    ApprovalsQuotPostAPi.docDueDate = approvalDetailsValue!.DocDate;
    ApprovalsQuotPostAPi.orderDate = approvalDetailsValue!.U_OrderDate;
    ApprovalsQuotPostAPi.orderTime = approvalDetailsValue!.U_Received_Time;
    ApprovalsQuotPostAPi.orderType = approvalDetailsValue!.PostOrder_Type;
    ApprovalsQuotPostAPi.custREfNo = approvalDetailsValue!.numAt;
    ApprovalsQuotPostAPi.gpApproval = approvalDetailsValue!.PostGP_Approval;

    await ApprovalsQuotPostAPi.getGlobalData().then((value) async {
      if (value.statusCode >= 200 && value.statusCode <= 210) {
        ApprovalsQuotAPi.uDeviceID =
            approvalDetailsValue!.uDevicTransId.toString();

        await ApprovalsQuotAPi.getGlobalData().then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 210) {
            await DBOperation.updtAprvltoDocSalHead(
                db,
                int.parse(value.approvalsOrdersValue![0].docEntry.toString()),
                int.parse(value.approvalsOrdersValue![0].docNum.toString()),
                int.parse(selectedcust2!.docentry.toString()));

            await pushRabiMqSO2(tbDocEntry);

            await Get.defaultDialog(
                    title: "Success",
                    middleText: "Successfully Done",
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
              isLoading = true;

              isApprove = false;
              selectedcust2 = null;
              selectedcust25 = null;
              scanneditemData2 = [];
              paymentWay2 = [];
              totalPayment2 = null;
              Get.offAllNamed(ConstantRoutes.dashboard);
              notifyListeners();
            });
          }
        });
// update
        notifyListeners();
      } else if (value.statusCode >= 400 || value.statusCode <= 404) {
        ;
        await Get.defaultDialog(
                title: "Alert",
                middleText: '${value.erorrs!.message!.Value}',
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
          selectedcust2 = null;
          selectedcust25 = null;
          scanneditemData2 = [];
          paymentWay2 = [];
          totalPayment2 = null;
          isApprove = false;
        });
        // final snackBar = SnackBar(
        //   duration: Duration(seconds: 5),
        //   backgroundColor: Colors.red,
        //   content: Text(
        //     '${value.erorrs!.message!.Value}',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        notifyListeners();
      } else {
        isLoading = false;
        await Get.defaultDialog(
                title: "Alert",
                middleText: '${value.erorrs!.message!.Value}',
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
          selectedcust2 = null;
          selectedcust25 = null;
          scanneditemData2 = [];
          paymentWay2 = [];
          totalPayment2 = null;
          isApprove = false;
        });
      }
    });
    // isApprove = false;
  }

  getSalesDataDatewise(String fromdate, String todate) async {
//log("fromdate::$fromdate.$todate");
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getSalesOrderDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();
    filtersearchData.clear();
    for (int i = 0; i < getSalesHeader.length; i++) {
      //log("BBBBBBBBBBBBBBBBB:::${getSalesHeader[i]["sapDocNo"]}");
      searchdata2.add(searchModel(
          username: UserValues.username,
          terminal: AppConstant.terminal,
          type: "Sales Order",
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
          sapNo:
              // int.parse(getSalesHeader[i]["sapDocNo"].toString())??0,
              getSalesHeader[i]["sapDocNo"] == null
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
    //log("header::" + getSalesHeader.toString());
    //log("Line::" + getSalesLine.toString());
    //log("Pay::" + getSalesPay.toString());
    searchbool = false;
    notifyListeners();
  }

  fixDataMethod(int docentry) async {
    sapDocentry = '';
    sapDocuNumber = '';
    cancelDocnum = '';
    salesmodl = [];
    editqty = false;
    tbDocEntry = null;
    mycontroller2[50].text = "";
    shipaddress = "";
    paymentWay2 = [];
    totwieght = 0.0;
    totLiter = 0.0;
    scanneditemData2.clear();
    totalPayment2 = null;
    selectedcust2 = null;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesOrderHeaderDB(db, docentry);
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getdSalesOrderPayDB(db, docentry);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.getSalesOrderLineDB(db, docentry);
    List<StocksnapModelData> scannData = [];
    List<PaymentWay> payment = [];
    int? totalQuantity = 0;
//log("getDBSalespaygetDBSalespay:::${getDBSalespay.length}");
    mycontroller2[50].text = getDBSalesHeader[0]['remarks'] != null
        ? getDBSalesHeader[0]['remarks'].toString()
        : "";

    sapDocentry = getDBSalesHeader[0]['sapDocentry'] != null
        ? getDBSalesHeader[0]['sapDocentry'].toString()
        : "";
    sapDocuNumber = getDBSalesHeader[0]['sapDocNo'] != null
        ? getDBSalesHeader[0]['sapDocNo'].toString()
        : "";
    cancelDocnum = getDBSalesHeader[0]['documentno'] != null
        ? getDBSalesHeader[0]['documentno'].toString()
        : "";
    tbDocEntry = int.parse(getDBSalesHeader[0]["docentry"].toString());
    log("tbDocEntrytbDocEntry:::$tbDocEntry");

    totwieght = double.parse(getDBSalesHeader[0]['totalweight'].toString());
    totLiter = double.parse(getDBSalesHeader[0]['totalltr'].toString());
    for (int kk = 0; kk < getDBSalespay.length; kk++) {
      if (getDBSalespay[0]['docentry'] == getDBSalespay[kk]['docentry']) {
        payment.add(PaymentWay(
          amt: double.parse(getDBSalespay[kk]['rcamount'].toString()),
          type: getDBSalespay[kk]['rcmode'].toString(),
          dateTime: getDBSalespay[kk]['createdateTime'].toString(),
          reference: getDBSalespay[kk]['reference'] != null
              ? getDBSalespay[kk]['reference'].toString()
              : '',
          cardApprno: getDBSalespay[kk]['cardApprno'] != null
              ? getDBSalespay[kk]['cardApprno'].toString()
              : '',
          cardref: getDBSalespay[kk]['cardref'].toString(),
          cardterminal: getDBSalespay[kk]['cardterminal'].toString(),
          chequedate: getDBSalespay[kk]['chequedate'].toString(),
          chequeno: getDBSalespay[kk]['chequeno'].toString(),
          couponcode: "", //getDBholdSalespay[kk]['couponcode'].toString(),
          coupontype: "", //getDBholdSalespay[kk]['coupontype'].toString(),
          discountcode: getDBSalespay[kk]['discountcode'].toString(),
          discounttype: getDBSalespay[kk]['discounttype'].toString(),
          recoverydate: getDBSalespay[kk]['recoverydate'].toString(),
          redeempoint: getDBSalespay[kk]['redeempoint'].toString(),
          availablept: getDBSalespay[kk]['availablept'].toString(),
          remarks: getDBSalespay[kk]['remarks'].toString(),
          transtype: getDBSalespay[kk]['transtype'].toString(),
          walletid: getDBSalespay[kk]['walletid'].toString(),
          wallettype: getDBSalespay[kk]['wallettype'].toString(),
        ));
        paymentWay2 = payment;
        notifyListeners();
      }
      //log("paymentWay2paymentWay2paymentWay2:::${paymentWay2.length}");
      notifyListeners();
    }

    for (int ik = 0; ik < getDBSalesLine.length; ik++) {
      scanneditemData2.add(StocksnapModelData(
          basic: getDBSalesLine[ik]['basic'] != null
              ? double.parse(getDBSalesLine[ik]['basic'].toString())
              : 00,
          netvalue: getDBSalesLine[ik]['netlinetotal'] != null
              ? double.parse(getDBSalesLine[ik]['netlinetotal'].toString())
              : null,
          TransID: int.parse(getDBSalesLine[ik]['docentry'].toString()),
          Branch: getDBSalesLine[ik]['branch'].toString(),
          ItemCode: getDBSalesLine[ik]['itemcode'].toString(),
          ItemName: getDBSalesLine[ik]['itemname'].toString(),
          SerialBatch: getDBSalesLine[ik]['serialbatch'].toString(),
          OpenQty: int.parse(getDBSalesLine[ik]['quantity'].toString()),
          Qty: int.parse(getDBSalesLine[ik]['quantity'].toString()),
          InDate: getDBSalesLine[ik][''].toString(),
          InType: getDBSalesLine[ik][''].toString(),
          VenCode: getDBSalesLine[ik][''].toString(),
          VenName: getDBSalesLine[ik][''].toString(),
          MRP: 0,
          SellPrice: double.parse(getDBSalesLine[ik]['price'].toString()),
          Cost: 0,
          discount: getDBSalesLine[ik]['discperunit'] != null
              ? double.parse(getDBSalesLine[ik]['discperunit'].toString())
              : 00,
          taxvalue: getDBSalesLine[ik]['taxtotal'] != null
              ? double.parse(getDBSalesLine[ik]['taxtotal'].toString())
              : 00,
          TaxRate: double.parse(getDBSalesLine[ik]['taxrate'].toString()),
          TaxType: getDBSalesLine[ik]['taxtype'].toString(),
          Maxdiscount: getDBSalesLine[ik]['maxdiscount'].toString(),
          discountper: getDBSalesLine[ik]['discperc'] == null
              ? 0.0
              : double.parse(getDBSalesLine[ik]['discperc'].toString()),
          createdUserID: '',
          createdateTime: '',
          lastupdateIp: '',
          purchasedate: '',
          snapdatetime: '',
          specialprice: 0,
          updatedDatetime: '',
          updateduserid: '',
          liter: getDBSalesLine[ik]['liter'] == null
              ? 0.0
              : double.parse(getDBSalesLine[ik]['liter'].toString()),
          weight: getDBSalesLine[ik]['weight'] == null
              ? 0.0
              : double.parse(
                  getDBSalesLine[ik]['weight'].toString()))); //discperc
      totquantity = getDBSalesLine[ik]['quantity'].toString();

      notifyListeners();
    }
    for (int i = 0; i < scanneditemData2.length; i++) {
      qtymycontroller2[i].text = scanneditemData2[i].Qty.toString();
      // mycontroller2[i].text = scanneditemData2[i].discountper.toString();
      discountcontroller2[i].text = scanneditemData2[i].discountper.toString();

      totalQuantity =
          totalQuantity! + int.parse(qtymycontroller2[i].text.toString());

      notifyListeners();
    }

    totalPayment2 = TotalPayment(
      balance: getDBSalesHeader[0]['baltopay'] == null
          ? 0.00
          : double.parse(getDBSalesHeader[0]['baltopay'].toString()),

      discount2: getDBSalesHeader[0]['docdiscamt'] == null
          ? 0.00
          : double.parse(getDBSalesHeader[0]['docdiscamt'].toString()),
      // double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
      discount: getDBSalesHeader[0]['docdiscamt'] == null
          ? 0.00
          : double.parse(getDBSalesHeader[0]['docdiscamt'].toString()),
      totalTX: double.parse(getDBSalesHeader[0]['taxamount'] == null
          ? '0'
          : getDBSalesHeader[0]['taxamount'].toString().replaceAll(',', '')),

      subtotal: double.parse(getDBSalesHeader[0]['docbasic'] == null
          ? '0'
          : getDBSalesHeader[0]['docbasic']
              .toString()
              .replaceAll(',', '')), //doctotal

      total: totalQuantity,
      totalDue: double.parse(getDBSalesHeader[0]['doctotal'] == null
          ? '0'
          : getDBSalesHeader[0]['doctotal'].toString().replaceAll(',', '')),
      totpaid: double.parse(getDBSalesHeader[0]['amtpaid'] == null
          ? '0'
          : getDBSalesHeader[0]['amtpaid'].toString().replaceAll(',', '')),
    );

    shipaddress = getDBSalesHeader[0]['shipaddresid'].toString();

    List<Address>? address2 = [];
    List<Address>? address25 = [];
    List<CustomerAddressModelDB> csadresdataDB =
        await DBOperation.getCstmMasAddDB(
      db,
    );
    for (int k = 0; k < csadresdataDB.length; k++) {
      if (csadresdataDB[k].custcode.toString() ==
          getDBSalesHeader[0]['customercode'].toString()) {
        if (csadresdataDB[k].autoid.toString() ==
            getDBSalesHeader[0]['billaddressid'].toString()) {
          address2 = [
            Address(
                autoId: int.parse(csadresdataDB[k].autoid.toString()),
                address1: csadresdataDB[k].address1,
                address2: csadresdataDB[k].address2,
                address3: csadresdataDB[k].address3,
                custcode: csadresdataDB[k].custcode,
                billCity: csadresdataDB[k].city!, //city
                billCountry: csadresdataDB[k].countrycode!, //country
                billPincode: csadresdataDB[k].pincode!, //pinno
                billstate: csadresdataDB[k].statecode)
          ];
        }
        if (getDBSalesHeader[0]['shipaddresid'].toString().isNotEmpty) {
          if (csadresdataDB[k].autoid.toString() ==
              getDBSalesHeader[0]['shipaddresid'].toString()) {
            address25 = [
              Address(
                  autoId: int.parse(csadresdataDB[k].autoid.toString()),
                  address1: csadresdataDB[k].address1,
                  address2: csadresdataDB[k].address2,
                  address3: csadresdataDB[k].address3,
                  custcode: csadresdataDB[k].custcode,
                  billCity: csadresdataDB[k].city!, //city
                  billCountry: csadresdataDB[k].countrycode!, //country
                  billPincode: csadresdataDB[k].pincode!, //pinno
                  billstate: csadresdataDB[k].statecode)
            ];
          }
        }
      }
    }

    selectedcust2 = CustomerDetals(
      name:
          getDBSalesHeader[0]["customername"].toString(), // customername!.name
      phNo: getDBSalesHeader[0]["customerphono"].toString(), //customerphono
      docentry: getDBSalesHeader[0]["docentry"].toString(),
      cardCode: getDBSalesHeader[0]["customercode"]
          .toString(), //customercode!.cardCode
      accBalance: double.parse(
          getDBSalesHeader[0]["customeraccbal"].toString()), //customeraccbal
      point: getDBSalesHeader[0]["customerpoint"].toString(), //customerpoint
      address: address2,
      tarNo: getDBSalesHeader[0]["taxno"].toString(), //taxno
      email: getDBSalesHeader[0]["customeremail"].toString(), //customeremail
      invoicenum: getDBSalesHeader[0]["documentno"].toString(),
      invoiceDate: getDBSalesHeader[0]["createdateTime"].toString(),
      totalPayment: getDBSalesHeader[0][""] == null
          ? 0.0
          : double.parse(getDBSalesHeader[0][""].toString()),
    );
    selectedcust25 = CustomerDetals(
      name:
          getDBSalesHeader[0]["customername"].toString(), // customername!.name
      phNo: getDBSalesHeader[0]["customerphono"].toString(), //customerphono
      docentry: getDBSalesHeader[0]["docentry"].toString(),
      cardCode: getDBSalesHeader[0]["customercode"]
          .toString(), //customercode!.cardCode
      accBalance: double.parse(
          getDBSalesHeader[0]["customeraccbal"].toString()), //customeraccbal
      point: getDBSalesHeader[0]["customerpoint"].toString(), //customerpoint
      address: address25,
      tarNo: getDBSalesHeader[0]["taxno"].toString(), //taxno
      email: getDBSalesHeader[0]["customeremail"].toString(), //customeremail
      invoicenum: getDBSalesHeader[0]["documentno"].toString(),
      invoiceDate: getDBSalesHeader[0]["createdateTime"].toString(),
      totalPayment: getDBSalesHeader[0][""] == null
          ? 0.0
          : double.parse(getDBSalesHeader[0][""].toString()),
    );
    notifyListeners();

    // int? totqty;
    SalesModel salesM = SalesModel(
      ordReference: getDBSalesHeader[0]['remarks'].toString(),
      objname: getDBSalesHeader[0]['objname'].toString(),
      objtype: getDBSalesHeader[0]['objtype'].toString(),
      doctype: getDBSalesHeader[0]['doctype'].toString(),
      docentry: int.parse(getDBSalesHeader[0]['docentry'].toString()),
      custName: getDBSalesHeader[0]['customername'].toString(),
      phNo: getDBSalesHeader[0]['customerphono'].toString(),
      cardCode: getDBSalesHeader[0]['customercode'].toString(),
      accBalance: getDBSalesHeader[0]['customeraccbal'].toString(),
      point: getDBSalesHeader[0]['customerpoint'].toString(),
      tarNo: getDBSalesHeader[0]['taxno'].toString(),
      email: getDBSalesHeader[0]['customeremail'].toString(),
      invoceDate: getDBSalesHeader[0]['createdateTime'].toString(),
      invoiceNum: getDBSalesHeader[0]['documentno'].toString(),
      sapOrderNum: getDBSalesHeader[0]['basedocentry'].toString(),
      sapInvoiceNum: getDBSalesHeader[0]['sapDocNo'].toString(),
      item: scanneditemData2,
    );

    notifyListeners();
    salesmodl.add(salesM);
//log(salesmodl.length.toString());
    notifyListeners();

    selectedBillAdress = selectedcust2!.address!.length - 1;
    selectedShipAdress = selectedcust25!.address!.length - 1;
    //  getcustaddresslist();
    notifyListeners();
  }

  updateFixDataMethod(BuildContext context, ThemeData theme) async {
    mycontroller[50].text = "";
    shipaddress = "";
    paymentWay.clear();
    totwieght = 0.0;
    totLiter = 0.0;
    scanneditemData.clear();
    totalPayment = null;
    selectedcust = null;
    scanneditemData2.clear();
    paymentWay2.clear();
    totalPayment2 = null;
    selectedcust2 = null;

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesOrderHeaderDB(
            db, int.parse(tbDocEntry.toString()));
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getdSalesOrderPayDB(
            db, int.parse(tbDocEntry.toString()));
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.getSalesOrderLineDB(
            db, int.parse(tbDocEntry.toString()));
    List<StocksnapModelData> scannData = [];
    List<PaymentWay> payment = [];
    int? totalQuantity = 0;

    if (getDBSalesHeader[0]['sapDocNo'].toString() != null ||
        getDBSalesHeader[0]['sapDocNo'].toString().isNotEmpty)
    // &&
    // getDBSalesHeader[0]['qStatus'].toString() == "C")
    {
      postqtyreadonly();

      sapDocentry = getDBSalesHeader[0]['sapDocentry'] != null
          ? getDBSalesHeader[0]['sapDocentry'].toString()
          : "";
      sapDocuNumber = getDBSalesHeader[0]['sapDocNo'] != null
          ? getDBSalesHeader[0]['sapDocNo'].toString()
          : "";
      cancelDocnum = getDBSalesHeader[0]['documentno'] != null
          ? getDBSalesHeader[0]['documentno'].toString()
          : "";
      remarkcontroller3.text = getDBSalesHeader[0]['remarks'] != null
          ? getDBSalesHeader[0]['remarks'].toString()
          : "";

      tbDocEntry = int.parse(getDBSalesHeader[0]["docentry"].toString());
      totwieght = double.parse(getDBSalesHeader[0]['totalweight'].toString());
      totLiter = double.parse(getDBSalesHeader[0]['totalltr'].toString());
      for (int kk = 0; kk < getDBSalespay.length; kk++) {
        if (getDBSalespay[0]['docentry'] == getDBSalespay[kk]['docentry']) {
          payment.add(PaymentWay(
            amt: double.parse(getDBSalespay[kk]['rcamount'].toString()),
            type: getDBSalespay[kk]['rcmode'].toString(),
            dateTime: getDBSalespay[kk]['createdateTime'].toString(),
            reference: getDBSalespay[kk]['reference'] != null
                ? getDBSalespay[kk]['reference'].toString()
                : '',
            cardApprno: getDBSalespay[kk]['cardApprno'] != null
                ? getDBSalespay[kk]['cardApprno'].toString()
                : '',
            cardref: getDBSalespay[kk]['cardref'].toString(),
            cardterminal: getDBSalespay[kk]['cardterminal'].toString(),
            chequedate: getDBSalespay[kk]['chequedate'].toString(),
            chequeno: getDBSalespay[kk]['chequeno'].toString(),
            couponcode: "", //getDBholdSalespay[kk]['couponcode'].toString(),
            coupontype: "", //getDBholdSalespay[kk]['coupontype'].toString(),
            discountcode: getDBSalespay[kk]['discountcode'].toString(),
            discounttype: getDBSalespay[kk]['discounttype'].toString(),
            recoverydate: getDBSalespay[kk]['recoverydate'].toString(),
            redeempoint: getDBSalespay[kk]['redeempoint'].toString(),
            availablept: getDBSalespay[kk]['availablept'].toString(),
            remarks: getDBSalespay[kk]['remarks'].toString(),
            transtype: getDBSalespay[kk]['transtype'].toString(),
            walletid: getDBSalespay[kk]['walletid'].toString(),
            wallettype: getDBSalespay[kk]['wallettype'].toString(),
          ));
          paymentWay = payment;
          notifyListeners();
        }
        notifyListeners();
      }

      for (int ik = 0; ik < getDBSalesLine.length; ik++) {
        scanneditemData.add(StocksnapModelData(
            basic: getDBSalesLine[ik]['basic'] != null
                ? double.parse(getDBSalesLine[ik]['basic'].toString())
                : 00,
            netvalue: getDBSalesLine[ik]['netlinetotal'] != null
                ? double.parse(getDBSalesLine[ik]['netlinetotal'].toString())
                : null,
            docentry: getDBSalesLine[ik]['docentry'].toString(),
            Branch: getDBSalesLine[ik]['branch'].toString(),
            ItemCode: getDBSalesLine[ik]['itemcode'].toString(),
            ItemName: getDBSalesLine[ik]['itemname'].toString(),
            SerialBatch: getDBSalesLine[ik]['serialbatch'].toString(),
            OpenQty: int.parse(getDBSalesLine[ik]['quantity'].toString()),
            Qty: int.parse(getDBSalesLine[ik]['quantity'].toString()),
            InDate: getDBSalesLine[ik][''].toString(),
            InType: getDBSalesLine[ik][''].toString(),
            VenCode: getDBSalesLine[ik][''].toString(),
            VenName: getDBSalesLine[ik][''].toString(),
            MRP: 0,
            SellPrice: double.parse(getDBSalesLine[ik]['price'].toString()),
            Cost: 0,
            discount: getDBSalesLine[ik]['discperunit'] != null
                ? double.parse(getDBSalesLine[ik]['discperunit'].toString())
                : 00,
            taxvalue: getDBSalesLine[ik]['taxtotal'] != null
                ? double.parse(getDBSalesLine[ik]['taxtotal'].toString())
                : 00,
            TaxRate: double.parse(getDBSalesLine[ik]['taxrate'].toString()),
            TaxType: getDBSalesLine[ik]['taxtype'].toString(),
            Maxdiscount: getDBSalesLine[ik]['maxdiscount'].toString(),
            discountper: getDBSalesLine[ik]['discperc'] == null
                ? 0.0
                : double.parse(getDBSalesLine[ik]['discperc'].toString()),
            createdUserID: '',
            createdateTime: '',
            lastupdateIp: '',
            purchasedate: '',
            snapdatetime: '',
            specialprice: 0,
            updatedDatetime: '',
            updateduserid: '',
            liter: getDBSalesLine[ik]['liter'] == null
                ? 0.0
                : double.parse(getDBSalesLine[ik]['liter'].toString()),
            weight: getDBSalesLine[ik]['weight'] == null
                ? 0.0
                : double.parse(
                    getDBSalesLine[ik]['weight'].toString()))); //discperc
        totquantity = getDBSalesLine[ik]['quantity'].toString();
        notifyListeners();
      }
      for (int i = 0; i < scanneditemData.length; i++) {
        qtymycontroller[i].text = scanneditemData[i].Qty.toString();
        discountcontroller[i].text = scanneditemData[i].discountper.toString();
        scanneditemData[i].TransID = i;
        totalQuantity =
            totalQuantity! + int.parse(qtymycontroller[i].text.toString());

        notifyListeners();
      }

      totalPayment = TotalPayment(
        balance: getDBSalesHeader[0]['baltopay'] == null
            ? 0.00
            : double.parse(getDBSalesHeader[0]['baltopay'].toString()),

        discount2: getDBSalesHeader[0]['docdiscamt'] == null
            ? 0.00
            : double.parse(getDBSalesHeader[0]['docdiscamt'].toString()),
        // double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
        discount: getDBSalesHeader[0]['docdiscamt'] == null
            ? 0.00
            : double.parse(getDBSalesHeader[0]['docdiscamt'].toString()),
        totalTX: double.parse(getDBSalesHeader[0]['taxamount'] == null
            ? '0'
            : getDBSalesHeader[0]['taxamount'].toString().replaceAll(',', '')),

        subtotal: double.parse(getDBSalesHeader[0]['docbasic'] == null
            ? '0'
            : getDBSalesHeader[0]['docbasic']
                .toString()
                .replaceAll(',', '')), //doctotal

        total: totalQuantity,
        totalDue: double.parse(getDBSalesHeader[0]['doctotal'] == null
            ? '0'
            : getDBSalesHeader[0]['doctotal'].toString().replaceAll(',', '')),
        totpaid: double.parse(getDBSalesHeader[0]['amtpaid'] == null
            ? '0'
            : getDBSalesHeader[0]['amtpaid'].toString().replaceAll(',', '')),
      );
      shipaddress = getDBSalesHeader[0]['shipaddresid'].toString();

      List<Address>? address2 = [];
      List<Address>? address25 = [];
      List<CustomerAddressModelDB> csadresdataDB =
          await DBOperation.getCstmMasAddDB(
        db,
      );
      addCardCode = getDBSalesHeader[0]['customercode'].toString();

      for (int k = 0; k < csadresdataDB.length; k++) {
        if (csadresdataDB[k].custcode.toString() ==
            getDBSalesHeader[0]['customercode'].toString()) {
          if (csadresdataDB[k].autoid.toString() ==
              getDBSalesHeader[0]['billaddressid'].toString()) {
            address2 = [
              Address(
                  autoId: int.parse(csadresdataDB[k].autoid.toString()),
                  address1: csadresdataDB[k].address1,
                  address2: csadresdataDB[k].address2,
                  address3: csadresdataDB[k].address3,
                  custcode: csadresdataDB[k].custcode,
                  billCity: csadresdataDB[k].city!, //city
                  billCountry: csadresdataDB[k].countrycode!, //country
                  billPincode: csadresdataDB[k].pincode!, //pinno
                  billstate: csadresdataDB[k].statecode)
            ];
          }
          if (getDBSalesHeader[0]['shipaddresid'].toString().isNotEmpty) {
            if (csadresdataDB[k].autoid.toString() ==
                getDBSalesHeader[0]['shipaddresid'].toString()) {
              address25 = [
                Address(
                    autoId: int.parse(csadresdataDB[k].autoid.toString()),
                    address1: csadresdataDB[k].address1,
                    address2: csadresdataDB[k].address2,
                    address3: csadresdataDB[k].address3,
                    custcode: csadresdataDB[k].custcode,
                    billCity: csadresdataDB[k].city!, //city
                    billCountry: csadresdataDB[k].countrycode!, //country
                    billPincode: csadresdataDB[k].pincode!, //pinno
                    billstate: csadresdataDB[k].statecode)
              ];
            }
          }
        }
        notifyListeners();
      }
      selectedcust = CustomerDetals(
        autoId: getDBSalesHeader[0]["billaddressid"].toString(),
        name: getDBSalesHeader[0]["customername"]
            .toString(), // customername!.name
        phNo: getDBSalesHeader[0]["customerphono"].toString(), //customerphono
        docentry: getDBSalesHeader[0]["docentry"].toString(),
        cardCode: getDBSalesHeader[0]["customercode"]
            .toString(), //customercode!.cardCode
        accBalance: double.parse(
            getDBSalesHeader[0]["customeraccbal"].toString()), //customeraccbal
        point: getDBSalesHeader[0]["customerpoint"].toString(), //customerpoint
        address: address2,
        tarNo: getDBSalesHeader[0]["taxno"].toString(), //taxno
        email: getDBSalesHeader[0]["customeremail"].toString(), //customeremail
        invoicenum: getDBSalesHeader[0]["documentno"].toString(),
        invoiceDate: getDBSalesHeader[0]["createdateTime"].toString(),
        totalPayment: getDBSalesHeader[0][""] == null
            ? 0.0
            : double.parse(getDBSalesHeader[0][""].toString()),

        uDeviceId: getDBSalesHeader[0]["U_DeviceId"].toString(),
        uGPApproval: getDBSalesHeader[0]["U_GP_Approval"].toString(),
        uOrderDate: getDBSalesHeader[0]["U_OrderDate"].toString(),
        uOrderType: getDBSalesHeader[0]["U_Order_Type"].toString(),
        uReceivedTime: getDBSalesHeader[0]["U_Received_Time"].toString(),
      );
      selectedcust55 = CustomerDetals(
        autoId: getDBSalesHeader[0]["shipaddresid"].toString(),

        name: getDBSalesHeader[0]["customername"]
            .toString(), // customername!.name
        phNo: getDBSalesHeader[0]["customerphono"].toString(), //customerphono
        docentry: getDBSalesHeader[0]["docentry"].toString(),
        cardCode: getDBSalesHeader[0]["customercode"]
            .toString(), //customercode!.cardCode
        accBalance: double.parse(
            getDBSalesHeader[0]["customeraccbal"].toString()), //customeraccbal
        point: getDBSalesHeader[0]["customerpoint"].toString(), //customerpoint
        address: address25,
        tarNo: getDBSalesHeader[0]["taxno"].toString(), //taxno
        email: getDBSalesHeader[0]["customeremail"].toString(), //customeremail
        invoicenum: getDBSalesHeader[0]["documentno"].toString(),
        invoiceDate: getDBSalesHeader[0]["createdateTime"].toString(),
        totalPayment: getDBSalesHeader[0][""] == null
            ? 0.0
            : double.parse(getDBSalesHeader[0][""].toString()),
      );
      notifyListeners();

      selectedBillAdress = selectedcust!.address!.length - 1;
      selectedShipAdress = selectedcust55!.address!.length - 1;
      //  getcustaddresslist();
      notifyListeners();
    } else {
      editqty = false;

      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Something went wrong..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        // OndDisablebutton = false;
        notifyListeners();
      });
    }
  }

  postqtyreadonly() {
    editqty = true;
    notifyListeners();
  }

  Uuid uuid = Uuid();
  saveValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      insertSalesHeaderToDB(docstatus, context, theme);
    } else if (docstatus.toLowerCase() == "check out") {
      insertSalesHeaderToDB(docstatus, context, theme);
    }
    notifyListeners();
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

    //log("datattata doc : " + data.substring(8));
    return listdata; // int.parse(data.substring(8));
  }

  viewSalesRet() async {
    final Database db = (await DBHelper.getInstance())!;

    // DBOperation.viewsalesret(db);
    print(' viewSalesRet msg');
  }

  String? uuiDeviceId;
  insertSalesHeaderToDB(
      String docstatus, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<SalesOrderHeaderModelDB> salesHeaderValues1 = [];
    List<SalesOrderPayTDB> SalesPayValues = [];
    List<SalesOrderLineTDB> salesLineValues = [];
    uuiDeviceId = uuid.v1();
    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "SalesOrderHeader");
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
          await DBOperation.generateDocentr(db, "docentry", "SalesOrderHeader");
    }

    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 1);
//log("documentN0:::${documentN0}");
    List<String> getseriesvalue = await checkingdoc(1);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    documentNum = finlDocnum + documentN0.toString();

    print("documentNum:$documentNum");
    // docnumber generatiom
    salesHeaderValues1.add(SalesOrderHeaderModelDB(
        doctype: 'Sales Order',
        docentry: docEntryCreated.toString(),
        objname: '',
        objtype: '',
        amtpaid: totalPayment != null
            ? getSumTotalPaid().toString().replaceAll(',', '')
            : null,
        baltopay: totalPayment != null
            ? getBalancePaid().toString().replaceAll(',', '')
            : null,
        billaddressid: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].autoId.toString(),
        billtype: null,
        branch: UserValues.branch!,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        createdbyuser: UserValues.userType,
        customercode: selectedcust!.cardCode != null
            ? selectedcust!.cardCode.toString()
            : '',
        customername: selectedcust != null ? selectedcust!.name : "",
        customertype: UserValues.userType,
        docbasic: totalPayment != null
            ? totalPayment!.subtotal!.toString().replaceAll(',', '')
            : null,
        docdiscamt: totalPayment != null
            ? totalPayment!.discount!.toString().replaceAll(',', '')
            : null,
        docdiscuntpercen: mycontroller[i].text.isNotEmpty
            ? mycontroller[i].text.toString()
            : '0',
        documentno: (documentNum).toString(),
        docstatus: docstatus == "hold"
            ? "1"
            : docstatus == "save as order"
                ? "2"
                : docstatus == "check out"
                    ? "3"
                    : "null",
        doctotal: totalPayment != null
            ? totalPayment!.totalDue!.toStringAsFixed(0)
            : null,
        lastupdateIp: UserValues.lastUpdateIp,
        premiumid: '',
        remarks: remarkcontroller3.text.toString(),
        salesexec: '',
        seresid: "",
        seriesnum: '',
        shipaddresid:
            selectedcust55 != null && selectedcust55!.address!.isNotEmpty
                ? selectedcust55!.address![selectedShipAdress].autoId.toString()
                // ? '${selectedcust!.address![selectedShipAdress].address1.toString()},${selectedcust!.address![selectedShipAdress].address2.toString()},${selectedcust!.address![selectedShipAdress].address3}'
                : "",
        sodocno: "",
        sodocseries: "",
        sodocseriesno: '',
        sodoctime: config.currentDate(),
        sosystime: config.currentDate(),
        sotransdate: config.currentDate(),
        sysdatetime: config.currentDate(),
        taxamount:
            totalPayment != null ? totalPayment!.totalTX!.toString() : null,
        taxno: selectedcust != null ? selectedcust!.tarNo.toString() : "",
        transactiondate: '',
        transtime: config.currentDate(),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        paystatus: '',
        customeraccbal:
            selectedcust != null ? selectedcust!.accBalance!.toString() : "",
        customeremail: selectedcust != null ? selectedcust!.email : '',
        customerphono: selectedcust != null ? selectedcust!.phNo : '',
        customerpoint: selectedcust != null ? selectedcust!.point : '',
        city: selectedcust == null && selectedcust!.address == null || selectedcust!.address!.isEmpty
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
        terminal: UserValues.terminal,
        sapDocNo: null,
        sapDocentry: null,
        qStatus: "No",
        totalltr: totalLiter(),
        totalweight: totalWeight(),
        basedocentry: selectedcust!.docentry != null ? selectedcust!.docentry.toString() : '',
        customerSeriesNum: '',
        editType: '',
        uOrderDate: udfController[2].text,
        uOrderType: valueSelectedOrder,
        uGPApproval: valueSelectedGPApproval,
        uReceivedTime: udfController[1].text,
        uDeviceId: uuiDeviceId!,
        custRefNo: udfController[0].text));
//         orderDate = config.alignDate2(udfCon
// orderType = valueSelectedOrder;

// gpApproval = valueSelectedGPApproval
// orderTime = udfController[1].text;

    int? docentry2 =
        await DBOperation.insertSaleOrderheader(db, salesHeaderValues1);

    await DBOperation.updatenextno(db, 1, nextno);

    for (int i = 0; i < scanneditemData.length; i++) {
      double? mycontamount = mycontroller[i].text.toString().isNotEmpty
          ? double.parse(mycontroller[i].text.toString())
          : 00;
      salesLineValues.add(SalesOrderLineTDB(
        basic: scanneditemData[i].basic.toString(),
        branch: UserValues.branch,
        createdUser: UserValues.userType,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        discamt: scanneditemData[i].discount.toString(),
        // totalPayment != null
        //     ? totalPayment!.discount.toString().replaceAll(',', '')
        //     : null,mycontroller[iss].text.toString()
        discperc: discountcontroller[i].text.isNotEmpty
            ? discountcontroller[i].text.toString()
            : '0',
        discperunit: scanneditemData[i].discount.toString(),
        //     (scanneditemData[i].SellPrice! * mycontamount / 100).toString(),
        maxdiscount: scanneditemData[i].Maxdiscount.toString(),
        docentry: docentry2.toString(),
        itemcode: scanneditemData[i].ItemCode,
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        lineID: i.toString(),
        linetotal: scanneditemData[i].basic.toString(),
        netlinetotal: scanneditemData[i].netvalue!.toStringAsFixed(0),
        // totalPayment != null
        //     ? totalPayment!.totalDue.toString().replaceAll(',', '')
        //     : null,
        price: scanneditemData[i].SellPrice.toString(),
        quantity: scanneditemData[i].Qty.toString(),
        serialbatch: scanneditemData[i].SerialBatch,
        taxrate: scanneditemData[i].TaxRate.toString(),
        taxtotal: scanneditemData[i].taxvalue!.toStringAsFixed(0),
        // totalPayment != null
        //     ? totalPayment!.totalTX!.toString().replaceAll(',', '')
        //     : null,
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        terminal: UserValues.terminal,
        itemname: scanneditemData[i].ItemName,
        basedocentry: scanneditemData[i].basedocentry ?? '',
        baselineID: scanneditemData[i].baselineid ?? '',
      ));

      notifyListeners();
// salesLineValues.add(salesLine);
    }
    for (int ij = 0; ij < getpaymentWay.length; ij++) {
      print(" paymentWay[ij].amt::${paymentWay[ij].amt!.toString()}");
      SalesPayValues.add(SalesOrderPayTDB(
          createdUserID: UserValues.userID.toString(),
          createdateTime: config.currentDate(),
          docentry: docentry2.toString(),
          lastupdateIp: UserValues.lastUpdateIp,
          rcamount: paymentWay[ij].amt != null
              ? paymentWay[ij].amt!.toString().replaceAll(',', '')
              : "",
          rcdatetime: config.currentDate(),
          rcdocentry: "",
          rcmode: paymentWay[ij].type ?? '',
          rcnumber: "",
          updatedDatetime: config.currentDate(),
          reference: paymentWay[ij].reference,
          updateduserid: UserValues.userID.toString(),
          cardApprno: paymentWay[ij].cardApprno,
          cardterminal: paymentWay[ij].cardterminal,
          chequedate: paymentWay[ij].chequedate,
          chequeno: paymentWay[ij].chequeno,
          couponcode: "", //paymentWay[ij].couponcode,
          coupontype: "", //paymentWay[ij].coupontype,
          discountcode: paymentWay[ij].discountcode,
          discounttype: paymentWay[ij].discounttype,
          recoverydate: paymentWay[ij].recoverydate,
          redeempoint: paymentWay[ij].redeempoint,
          availablept: paymentWay[ij].availablept,
          remarks: paymentWay[ij].remarks,
          transtype: paymentWay[ij].transtype,
          walletid: paymentWay[ij].walletid,
          wallettype: paymentWay[ij].wallettype,
          branch: UserValues.branch,
          terminal: UserValues.terminal,
          lineid: ij.toString()));
      notifyListeners();

      // SalesPayValues.add(SalesPayValues1);
    }
    if (SalesPayValues.isNotEmpty) {
      DBOperation.insertSalesOrderPay(db, SalesPayValues, docentry2!);
      notifyListeners();
    }
    if (salesLineValues.isNotEmpty) {
      DBOperation.insertSalesOrderLine(db, salesLineValues, docentry2!);
      notifyListeners();
    }

    bool? netbool = await config.haveInterNet();

    //log("config.haveInterNet():::" + netbool.toString());
    if (netbool == true) {
      if (docstatus == "check out") {
        await callOrdPostApi(
          context,
          theme,
          docentry2!,
          docstatus,
          documentNum,
        );
        notifyListeners();
        // pushRabiMqSO(docentry2!);
      }
    }
    if (docstatus == "hold") {
      getdraftindex();

      await Get.defaultDialog(
              title: "Success",
              middleText: docstatus == "hold" ? "Saved as draft" : "null",
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
        cashType = '';
        creditType = '';
        cardType = '';
        chequeType = '';
        transferType = '';
        walletType = '';
        pointType = '';
        accType = '';
        cashpayment = null;
        cashpayment = null;

        cqpayment = null;

        transpayment = null;
        chqnum = null;

        transrefff = null;
        addCardCode = '';
        cpyfrmsq = false;
        selectedcust55 = null;
        selectedcust = null;
        scanneditemData.clear();
        schemebtnclk = false;
        paymentWay.clear();
        newShipAddrsValue = [];
        newBillAddrsValue = [];
        newCustValues = [];
        totalPayment = null;
        mycontroller[50].text = "";
        discountcontroller = List.generate(100, (i) => TextEditingController());
        mycontroller = List.generate(150, (i) => TextEditingController());
        qtymycontroller = List.generate(100, (i) => TextEditingController());
        remarkcontroller3.text = '';
        injectToDb();
        OndDisablebutton = false;
        notifyListeners();
      });
    }

    notifyListeners();
  }

  static List<QuatationLines> itemsDocDetails = [];

  Future<bool> isLocationAvailable(BuildContext context) async {
    bool? serviceEnabled;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled == true) {
        //  print("serviceEnabled1111 $serviceEnabled");
        return Future.value(true);
      } else if (serviceEnabled == false) {
        //  print("serviceEnabled2222 $serviceEnabled");
        notifyListeners();

        return Future.value(false);
      }
    } catch (e) {
      const snackBar = SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text("Please turn on the Location!!.."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Future.delayed(
      //   const Duration(seconds: 2),
      //   () => Get.back<dynamic>(),
      // );
    }
    notifyListeners();

    return Future.value(false);
  }

  void showsnb(BuildContext context) {
    const snackBar = SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        content: Text(
            "Please give location permission to pos app & turn on the Location!!.."));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // Future.delayed(
    //   const Duration(seconds: 3),
    //   () => Get.back<dynamic>(),
    // );
    notifyListeners();
  }

  LocationPermission? permission;
  static String? latitude;
  static String? longitude;
  void getLocation(BuildContext context) async {
    final bool checkper = await checkPermision();
    if (checkper == false) {
      showsnb(context);
    } else if (checkper == true) {
      final bool isa = await isLocationAvailable(context);
      notifyListeners();

      print("isa $isa");
      if (isa == false) {
        showsnb(context);
      } else if (isa == true) {
        Position? pos = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        log("lattitude: ${pos.latitude}");
        latitude = pos.latitude.toString();
        longitude = pos.longitude.toString();
        log("latitude:;${latitude} and longitude::${longitude}");
        isLoading = false;
        notifyListeners();
      }
      notifyListeners();
    }
  }

  Future<bool> checkPermision() async {
//log("permission11 $permission");
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      //log("permission2 $permission");
      // showsnb();
      return Future.value(false);
    } else if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      //log("permission3 deniedForever  $permission");
      //showsnb();
      // permission = await Geolocator.checkPermission();
      return Future.value(false);
    } else if (permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();
      //log("permission4 unableToDetermine  $permission");
      return Future.value(false);
    } else if (permission == LocationPermission.always) {
      permission = await Geolocator.requestPermission();
      //log("permission5 always  $permission");
      return Future.value(true);
    } else if (permission == LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
      //log("permission5 always  $permission");
      return Future.value(true);
    }
    notifyListeners();

    return Future.value(false);
  }

  getOrderDocList() {
    itemsDocDetails = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      itemsDocDetails.add(
        QuatationLines(
          Currency: "TZS",
          DiscPrcnt: scanneditemData[i].discountper.toString(),
          ItemCode: scanneditemData[i].ItemCode,
          Price: scanneditemData[i].SellPrice.toString(),
          Quantity: scanneditemData[i].Qty.toString(),
          TaxCode: scanneditemData[i].TaxRate.toString(),
          UnitPrice: scanneditemData[i].netvalue!.toStringAsFixed(2),
          WhsCode: scanneditemData[i].Branch,
          itemName: scanneditemData[i].ItemName.toString(),
          baseline: scanneditemData[i].baselineid == null ||
                  scanneditemData[i].baselineid!.isEmpty
              ? null
              : int.parse(scanneditemData[i].baselineid.toString()),
          basedocentry: scanneditemData[i].sapbasedocentry != null
              ? scanneditemData[i].sapbasedocentry
              : null,
        ),

        // basedocentry:itemsDetails3[i].basedocentry ,
        // baseline:itemsDetails3[i].baseline
      );
    }
    notifyListeners();
  }

  final TimeOfDay _selectTime = TimeOfDay.now();
  String? installTime;
  void selecTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectTime,
      //  builder: (BuildContext context, Widget? child){
      //     return MediaQuery(
      //       data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
      //       child: child!);
    );
    MaterialLocalizations localizations = MaterialLocalizations.of(context);

    if (picked != null) {
      String format = localizations.formatTimeOfDay(picked);
      udfController[1].text = format;
      //  hour = _selectTime.hour.toString();
      String time, postTime, postTime2;
      time = picked.toString();
      postTime = time.replaceAll("TimeOfDay", "");
      postTime2 = postTime.replaceAll("(", "");
      installTime = postTime2.replaceAll(")", "");
      udfController[1].clear();
      udfController[1].text = installTime!;
      // print(installTime);
      notifyListeners();
    }
  }

  String? valueSelectedOrder;
  String? valueSelectedGPApproval;

  List<Map<String, String>> salesOrderType = [
    {"name": "Select", "value": '0'},
    {"name": "Normal", "value": '1'},
    {"name": "Depot transfer", "value": "2"},
    {"name": "Root Sale", "value": "3"},
    {"name": "Project sale", "value": "4"},
    {"name": "Special Order", "value": "5"},
  ];
  List get getSalesOrderType => salesOrderType;
  List<Map<String, String>> grpApprovalRequired = [
    {"name": "NO", "value": '0'},
    {"name": "YES", "value": '1'},
  ];
  List get getgrpApprovalRequired => grpApprovalRequired;
  List<PostPaymentCheck> itemsPaymentCheckDet = [];

  postingReceipt22(
    BuildContext context,
    ThemeData theme,
    int docEntry,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    await addChequeValues22();
    // await addInvoiceLine();
    ReceiptPostAPi.docType = "rCustomer";
    ReceiptPostAPi.checkAccount = "_SYS00000000136";
    ReceiptPostAPi.cardCodePost = selectedcust!.cardCode;
    ReceiptPostAPi.docPaymentChecks = itemsPaymentCheckDet;
    ReceiptPostAPi.docPaymentInvoices = [];
    ReceiptPostAPi.docDate = config.currentDate();
    ReceiptPostAPi.dueDate = config.currentDate().toString();
    ReceiptPostAPi.remarks = remarkcontroller3.text;
    if (cashType == 'Cash') {
      log("chequeno:::" + mycontroller[22].text);

      ReceiptPostAPi.cashAccount = "_SYS00000000136";
      ReceiptPostAPi.cashSum = cashpayment;

      notifyListeners();
    }
    if (transferType == 'Transfer') {
      ReceiptPostAPi.transferAccount = "_SYS00000000136";
      ReceiptPostAPi.transferSum = transpayment;
      ReceiptPostAPi.transferReference = transrefff;
      ReceiptPostAPi.transferDate = config.currentDate.toString();
      notifyListeners();
    }
    notifyListeners();

    ReceiptPostAPi.method();
    await ReceiptPostAPi.getGlobalData().then((value) async {
      // SalesOrderAfterAPi.baseEntry = value.docEntry.toString();
      //log("object:" + value.stscode.toString());
      if (value.stscode == null) {
        return;
      }
      if (value.stscode! >= 200 && value.stscode! <= 210) {
        if (value.docNum != null) {
          sapReceiptDocentry = value.docEntry;
          await DBOperation.updateRcSapDetSalpay(
              db,
              docEntry,
              int.parse(value.docNum.toString()),
              int.parse(value.docEntry.toString()),
              "SalesOrderPay");
          cashType = '';
          creditType = '';
          cardType = '';
          chequeType = '';
          transferType = '';
          walletType = '';
          pointType = '';
          accType = '';
          addCardCode = '';
          // await pushRabiMqSO2(docEntry);
        }
      } else {
        custserieserrormsg = value.exception.toString();
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
                      content: '${value.error!.message!.value}',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          mycontroller = List.generate(150, (i) => TextEditingController());
          selectedcust = null;
          paymentWay.clear();
          remarkcontroller3.text = "";
          scanneditemData.clear();
          OndDisablebutton = false;
          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  addChequeValues22() {
    itemsPaymentCheckDet = [];
    if (chequeType == "Cheque") {
      log("chequeno:::" + mycontroller[23].text);
      itemsPaymentCheckDet.add(PostPaymentCheck(
        dueDate: config.currentDate(),
        checkNumber: chqnum,
        // int.parse(paymentWay[ik].chequeno.toString()),
        //  int.parse(mycontroller[23].text),
        bankCode: "NBC TZS",
        accounttNum: '',
        details: remarkcontroller3.text,
        checkSum: cqpayment,
        // paymentWay[ik].amt
      ));
      notifyListeners();
    }
    notifyListeners();
  }

  addChequeValues(int ik) {
    itemsPaymentCheckDet = [];
    if (paymentWay[ik].type == "Cheque") {
      log("chequeno:::" + mycontroller[23].text);
      itemsPaymentCheckDet.add(PostPaymentCheck(
          dueDate: config.currentDate(),
          checkNumber: int.parse(paymentWay[ik].chequeno.toString()),
          //  int.parse(mycontroller[23].text),
          bankCode: "NBC TZS",
          accounttNum: '',
          details: remarkcontroller3.text,
          checkSum: paymentWay[ik].amt));
      notifyListeners();
    }
    notifyListeners();
  }

  postingReceipt(
      BuildContext context, ThemeData theme, int docEntry, int ik) async {
    final Database db = (await DBHelper.getInstance())!;
    await addChequeValues(ik);
    // await addInvoiceLine();
    ReceiptPostAPi.docType = "rCustomer";
    ReceiptPostAPi.checkAccount = "_SYS00000000136";
    ReceiptPostAPi.cardCodePost = selectedcust!.cardCode;
    ReceiptPostAPi.docPaymentChecks = itemsPaymentCheckDet;
    ReceiptPostAPi.docPaymentInvoices = [];
    ReceiptPostAPi.docDate = config.currentDate();
    ReceiptPostAPi.dueDate = config.currentDate().toString();
    ReceiptPostAPi.remarks = remarkcontroller3.text;
    if (paymentWay[ik].type == 'Cash') {
      log("chequeno:::" + mycontroller[22].text);

      ReceiptPostAPi.cashAccount = "_SYS00000000136";
      ReceiptPostAPi.cashSum = paymentWay[ik].amt;

      notifyListeners();
    }
    if (paymentWay[ik].type == 'Transfer') {
      ReceiptPostAPi.transferAccount = "_SYS00000000136";
      ReceiptPostAPi.transferSum = paymentWay[ik].amt;
      ReceiptPostAPi.transferReference = paymentWay[ik].transref;
      ReceiptPostAPi.transferDate = config.currentDate.toString();
      notifyListeners();
    }
    exit;
    notifyListeners();

    ReceiptPostAPi.method();
    await ReceiptPostAPi.getGlobalData().then((value) async {
      // SalesOrderAfterAPi.baseEntry = value.docEntry.toString();
      //log("object:" + value.stscode.toString());
      if (value.stscode == null) {
        return;
      }
      if (value.stscode! >= 200 && value.stscode! <= 210) {
        if (value.docNum != null) {
          sapReceiptDocentry = value.docEntry;
          await DBOperation.updateRcSapDetSalpay(
              db,
              docEntry,
              int.parse(value.docNum.toString()),
              int.parse(value.docEntry.toString()),
              "SalesOrderPay");
          cashType = '';
          creditType = '';
          cardType = '';
          chequeType = '';
          transferType = '';
          walletType = '';
          pointType = '';
          accType = '';
          addCardCode = '';
          // await pushRabiMqSO2(docEntry);
        }
      } else {
        custserieserrormsg = value.exception.toString();
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
                      content: '${value.error!.message!.value}',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          mycontroller = List.generate(150, (i) => TextEditingController());
          selectedcust = null;
          paymentWay.clear();
          remarkcontroller3.text = "";
          scanneditemData.clear();
          OndDisablebutton = false;
          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  checkcashcust() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getCashCust =
        await DBOperation.getMoreCstgroups(db, selectedcust!.cardCode!);
    notifyListeners();
  }

  void validateAndCallApi(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
    String documentNum,
  ) async {
    final Database db = (await DBHelper.getInstance())!;

    await getOrderDocList();
    SalesOrderPostAPi.sessionID = AppConstant.sapSessionID.toString();
    SalesOrderPostAPi.cardCodePost = selectedcust!.cardCode;
    SalesOrderPostAPi.cardNamePost = selectedcust!.name;
    SalesOrderPostAPi.docLineQout = itemsDocDetails;
    SalesOrderPostAPi.docDate = config.currentDate();
    SalesOrderPostAPi.dueDate = config.currentDate();
    SalesOrderPostAPi.remarks = remarkcontroller3.text;
    SalesOrderPostAPi.orderDate = config.alignDate2(udfController[2].text);
    SalesOrderPostAPi.orderType = valueSelectedOrder;
    SalesOrderPostAPi.gpApproval = valueSelectedGPApproval;
    SalesOrderPostAPi.orderTime = udfController[1].text;
    SalesOrderPostAPi.custREfNo = udfController[0].text;
    SalesOrderPostAPi.deviceTransID = uuiDeviceId!;
    SalesOrderPostAPi.deviceCode = AppConstant.ip;
    SalesOrderPostAPi.slpCode = '67';
    SalesOrderPostAPi.method(latitude!, longitude!);
    double getcreditLimit;

    List<Map<String, Object?>> getCashCust =
        await DBOperation.getMoreCstgroups(db, selectedcust!.cardCode!);
    if (getCashCust.isNotEmpty) {
// for(int i =0;i<getCashCust.length;i++){
      if (selectedcust!.cardCode.toString() ==
          getCashCust[0]['customercode'].toString()) {
        // for (int i = 0; i < paymentWay.length; i++) {
        //   if (paymentWay[i].type.toString().toLowerCase() == "cash") {
        SalesOrderPostAPi.sessionID = AppConstant.sapSessionID;
        callPostSalesOrderApi(
          context,
          theme,
          docEntry,
          docstatus,
          documentNum,
        );
        notifyListeners();
      }
    } else {
      //log("XXXXXXX:::" + AppConstant.sapSessionID.toString());

      GetBalanceCreditAPi.cardCode = selectedcust!.cardCode;
      await GetBalanceCreditAPi.getGlobalData().then((value) {
        if (value.balanceCreaditValue!.isNotEmpty) {
          //log("Step::1");
          getcreditLimit = value.balanceCreaditValue![0].CreditLimit!;
          callSaveApi(
            getcreditLimit,
            context,
            theme,
            docEntry,
            docstatus,
            documentNum,
          );
        } else if (value.balanceCreaditValue!.isEmpty) {
          //log("Step::2");

          callSaveApi(
            0.00,
            context,
            theme,
            docEntry,
            docstatus,
            documentNum,
          );
        }
      });
    }
  }

  void callSaveApi(
    double getCredit,
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
    String documentNum,
  ) async {
//log("Step::3");

    GettCreditDaysAPi.cardCode = selectedcust!.cardCode;
    GettCreditDaysAPi.date = config.currentDate();
    await GettCreditDaysAPi.getGlobalData().then((value) async {
      if (value.creaditDaysValueValue![0].CreditDays == 0) {
        //log("Step::4");

        // print("getCredit3333 : " + getCredit.toString());
        await GetBalanceCreditAPi.getGlobalData().then((value) async {
          if (value.balanceCreaditValue!.isNotEmpty) {
            //log("Step::5");

            double? balance = value.balanceCreaditValue![0].Balance;
            double? creditLimit = value.balanceCreaditValue![0].CreditLimit;
            double? ordersBal = value.balanceCreaditValue![0].OrdersBal;

            double ans =
                creditLimit! - balance! - ordersBal! - totalPayment!.totalDue!;
            //log("hhhhh:::${ans}");
            if (ans < 0) {
              //log("Step::6");

              PostOrderLoginAPi.username = 'solimitapp';
              AppConstant.sapDB = "MRP T1";
              await PostOrderLoginAPi.getGlobalData().then((valuel) {
                if (valuel.sessionId!.isNotEmpty) {
                  //log("Step::7");

                  soLimit = true;
                  OrderPostAPi2.sessionID = valuel.sessionId!;
                  callPostSalesOrderApi22(
                      context, docEntry, docstatus, documentNum);
                } else {
                  //log("Step::9");

                  isLoading = false;
                  schemeApiLoad = false;
                }
              });
              // });
            } else {
              //log("Step::10");

              SalesOrderPostAPi.sessionID = AppConstant.sapSessionID;
              callPostSalesOrderApi(
                context,
                theme,
                docEntry,
                docstatus,
                documentNum,
              );
            }
          } else {
            //log("Step::11");
            // sapOrderLoginApi(context, theme);

            SalesOrderPostAPi.sessionID = AppConstant.sapSessionID;
            callPostSalesOrderApi(
              context,
              theme,
              docEntry,
              docstatus,
              documentNum,
            );
          }
        });
      } else if (value.creaditDaysValueValue![0].CreditDays! > 0) {
        //log("Step::12");

        PostOrderLoginAPi.username = 'sodaysapp';
        AppConstant.sapDB = "MRP T1";
        await PostOrderLoginAPi.getGlobalData().then((valuel) {
          //log("Step::13");

          if (valuel.sessionId != null) {
            soDats = true;
            OrderPostAPi2.sessionID = valuel.sessionId!;
            AppConstant.sapSessionID = valuel.sessionId!;
            callPostSalesOrderApi22(context, docEntry, docstatus, documentNum);
          } else if (valuel.sessionId == null) {
            //log("Step::14");

            isLoading = false;
            schemeApiLoad = false;

            // showDetailBox('Server Issue Please Try Again !!..');
          }
        });

        //  });
      } else {
        //log("Step::15");

        SalesOrderPostAPi.sessionID = AppConstant.sapSessionID;
        callPostSalesOrderApi(
          context,
          theme,
          docEntry,
          docstatus,
          documentNum,
        );
      }
      // }
    });
  }

  static bool soLimit = false;
  static bool soDats = false;

  void callPostSalesOrderApi22(BuildContext context, int docEntry,
      String docstatus, String documentNum) async {
//log("Step::16");

    final Database db = (await DBHelper.getInstance())!;
    OrderPostAPi2.sessionID = AppConstant.sapSessionID.toString();
    OrderPostAPi2.cardCodePost = selectedcust!.cardCode;
    OrderPostAPi2.cardNamePost = selectedcust!.name;
    OrderPostAPi2.docLineQout = itemsDocDetails;
    OrderPostAPi2.docDate = config.currentDate();
    OrderPostAPi2.dueDate = config.currentDate();
    OrderPostAPi2.remarks = remarkcontroller3.text;
    OrderPostAPi2.orderDate = config.alignDate2(udfController[2].text);
    OrderPostAPi2.orderType = valueSelectedOrder;
    OrderPostAPi2.gpApproval = valueSelectedGPApproval;
    OrderPostAPi2.orderTime = udfController[1].text;
    OrderPostAPi2.custREfNo = udfController[0].text;
    OrderPostAPi2.deviceTransID = uuiDeviceId!;
    OrderPostAPi2.deviceCode = AppConstant.ip;
    OrderPostAPi2.slpCode = '67';
    OrderPostAPi2.method(latitude!, longitude!);
    await OrderPostAPi2.getGlobalData(latitude!, longitude!)
        .then((value) async {
      // log("Doccccccd" + value.docEntry.toString());
      if (value.statusCode! >= 200 && value.statusCode! <= 204) {
        // sapDocentry = value.docEntry.toString();

        await DBOperation.updateSOrdercApprovalsts(db, docEntry.toString());
        // sapDocuNumber = value.documentNum.toString();
        // await DBOperation.UpdtSapDetSalHead(db, int.parse(sapDocentry),
        //     int.parse(sapDocuNumber), docEntry, 'SalesOrderHeader');

        // await pushRabiMqSO2(int.parse(docEntry.toString()));
        // await postingReceipt(
        //   context,
        // );
        await Get.defaultDialog(
                title: "Success",
                middleText: docstatus == "check out"
                    ? 'Successfully Done, This document is saved as Approval Draft'
                    // Document Number is $documentNum'
                    : docstatus == "save as order"
                        ? "Sales order successfully saved..!!, Document Number is $documentNum"
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
          cpyfrmsq = false;
          OndDisablebutton = true;
          selectedcust55 = null;
          selectedcust = null;
          scanneditemData.clear();
          schemebtnclk = false;
          paymentWay.clear();
          newShipAddrsValue = [];
          newBillAddrsValue = [];
          newCustValues = [];
          totalPayment = null;
          mycontroller[50].text = "";
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(100, (i) => TextEditingController());
          remarkcontroller3.text = '';
          injectToDb();
          // if (docstatus == "check out") {
          //   Get.offAllNamed(ConstantRoutes.dashboard);
          // }
          OndDisablebutton = false;

          notifyListeners();
        });
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        await Get.defaultDialog(
                title: "Alert",
                middleText: "${value.error!.message!.value}",
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
          cpyfrmsq = false;
          OndDisablebutton = true;
          selectedcust55 = null;
          selectedcust = null;
          scanneditemData.clear();
          schemebtnclk = false;
          paymentWay.clear();
          newShipAddrsValue = [];
          newBillAddrsValue = [];
          newCustValues = [];
          totalPayment = null;
          mycontroller[50].text = "";
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(100, (i) => TextEditingController());
          remarkcontroller3.text = '';
          injectToDb();
          // if (docstatus == "check out") {
          //   Get.offAllNamed(ConstantRoutes.dashboard);
          // }
          OndDisablebutton = false;
          // Navigator.pop(context);
          notifyListeners();
        });
        OndDisablebutton = false;
      } else {
        await Get.defaultDialog(
                title: "Alert",
                middleText: "${value.error!.message!.value}",
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
          cpyfrmsq = false;
          OndDisablebutton = true;
          selectedcust55 = null;
          selectedcust = null;
          scanneditemData.clear();
          schemebtnclk = false;
          paymentWay.clear();
          newShipAddrsValue = [];
          newBillAddrsValue = [];
          newCustValues = [];
          totalPayment = null;
          mycontroller[50].text = "";
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(100, (i) => TextEditingController());
          remarkcontroller3.text = '';
          injectToDb();
          // if (docstatus == "check out") {
          //   Get.offAllNamed(ConstantRoutes.dashboard);
          // }
          OndDisablebutton = false;
          // Navigator.pop(context);
          notifyListeners();
        });
      }
    });
  }

  void callPostSalesOrderApi(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
    String documentNum,
  ) async {
    final Database db = (await DBHelper.getInstance())!;

    await SalesOrderPostAPi.getGlobalData(latitude!, longitude!)
        .then((value) async {
      //log("Doccccccd" + value.docEntry.toString());
      if (value.statusCode! >= 200 && value.statusCode! <= 204) {
        sapDocentry = value.docEntry.toString();
        sapDocuNumber = value.docNum.toString();
        await DBOperation.UpdtSapDetSalHead(db, int.parse(sapDocentry),
            int.parse(sapDocuNumber), docEntry, 'SalesOrderHeader');
        if (cashType == 'Cash' ||
            chequeType == "Cheque" ||
            cardType == "Card" ||
            transferType == "Transfer" ||
            walletType == "Wallet" ||
            accType == "Account Balance" ||
            pointType == 'Points Redemption') {
          log("mycontroller[22].text:::${cashpayment}");

          // for (int ik = 0; ik < paymentWay.length; ik++) {
          //   if (paymentWay[ik].type != 'Credit') {
          await postingReceipt22(context, theme, docEntry);
          //   }
        }
        await pushRabiMqSO2(docEntry);
        (docEntry);
        await Get.defaultDialog(
                title: "Success",
                middleText: docstatus == "check out"
                    ? 'Successfully Done, Document Number is $sapDocuNumber'
                    : docstatus == "save as order"
                        ? "Sales order successfully saved..!!, Document Number is $sapDocuNumber"
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
          cpyfrmsq = false;
          OndDisablebutton = true;
          selectedcust55 = null;
          selectedcust = null;
          scanneditemData.clear();
          schemebtnclk = false;
          paymentWay.clear();
          newShipAddrsValue = [];
          newBillAddrsValue = [];
          newCustValues = [];
          totalPayment = null;
          mycontroller[50].text = "";
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(100, (i) => TextEditingController());
          remarkcontroller3.text = '';

          injectToDb();
          if (docstatus == "check out") {
            Get.offAllNamed(ConstantRoutes.dashboard);
          }
          OndDisablebutton = false;

          notifyListeners();
        });
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        await Get.defaultDialog(
                title: "Alert",
                middleText: "${value.error!.message!.value}",
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
          cashType = '';
          creditType = '';
          cardType = '';
          chequeType = '';
          transferType = '';
          walletType = '';
          pointType = '';
          accType = '';
          addCardCode = '';
          cpyfrmsq = false;
          OndDisablebutton = true;
          selectedcust55 = null;
          selectedcust = null;
          scanneditemData.clear();
          schemebtnclk = false;
          paymentWay.clear();
          newShipAddrsValue = [];
          newBillAddrsValue = [];
          newCustValues = [];
          totalPayment = null;
          mycontroller[50].text = "";
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(100, (i) => TextEditingController());
          remarkcontroller3.text = '';
          injectToDb();
          // if (docstatus == "check out") {
          //   Get.offAllNamed(ConstantRoutes.dashboard);
          // }
          OndDisablebutton = false;
          // Navigator.pop(context);
          notifyListeners();
        });
        OndDisablebutton = false;
      } else {
        await Get.defaultDialog(
                title: "Alert",
                middleText: "${value.error!.message!.value}",
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
          cashType = '';
          creditType = '';
          cardType = '';
          chequeType = '';
          transferType = '';
          walletType = '';
          pointType = '';
          accType = '';
          addCardCode = '';
          cpyfrmsq = false;
          OndDisablebutton = true;
          selectedcust55 = null;
          selectedcust = null;
          scanneditemData.clear();
          schemebtnclk = false;
          paymentWay.clear();
          newShipAddrsValue = [];
          newBillAddrsValue = [];
          newCustValues = [];
          totalPayment = null;
          mycontroller[50].text = "";
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(100, (i) => TextEditingController());
          remarkcontroller3.text = '';
          injectToDb();
          // if (docstatus == "check out") {
          //   Get.offAllNamed(ConstantRoutes.dashboard);
          // }
          OndDisablebutton = false;
          // Navigator.pop(context);
          notifyListeners();
        });
      }
    });
  }

  callOrdPostApi(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
    String documentNum,
  ) async {
    if (latitude != null && longitude != null) {
      await sapOrderLoginApi(
        context,
      );
      validateAndCallApi(context, theme, docEntry, docstatus, documentNum);
      notifyListeners();
    } else {
      Get.defaultDialog(
          title: "Alert",
          middleText: "Please Enable the location",
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
          radius: 5);
    }
  }

  // postOrderData(BuildContext context, ThemeData theme, int docEntry) async {
  //   final Database db = (await DBHelper.getInstance())!;
  // var uuid = Uuid();
  // String? uuidg = uuid.v1();
  //   await getOrderDocList();
  //   SalesOrderPostAPi.cardCodePost = selectedcust!.cardCode;
  //   SalesOrderPostAPi.sessionID = AppConstant.sapSessionID;
  //   SalesOrderPostAPi.cardNamePost = selectedcust!.name;
  //   SalesOrderPostAPi.docLineQout = itemsDocDetails;
  //   SalesOrderPostAPi.docDate = config.currentDate();
  //   SalesOrderPostAPi.dueDate = config.currentDate();
  //   SalesOrderPostAPi.remarks = remarkcontroller3.text;
  //   SalesOrderPostAPi.orderDate = config.currentDate();
  //   SalesOrderPostAPi.orderType = DateTime.now().toString();
  //   SalesOrderPostAPi.gpApproval = '';
  //   SalesOrderPostAPi.orderTime = '';
  //   SalesOrderPostAPi.custREfNo = '';
  //   SalesOrderPostAPi.deviceCode = AppConstant.ip;
  //   SalesOrderPostAPi.deviceTransID = uuid.v1();
  //   SalesOrderPostAPi.slpCode = '';

  //   // SalesOrderPostAPi.method(uuidg);
  //   await SalesOrderPostAPi.getGlobalData(latitude!, longitude!)
  //       .then((value) async {
  //     // SalesOrderAfterAPi.baseEntry = value.docEntry.toString();
  // //log("object:" + value.statusCode.toString());
  // //log("docEntry:" + value.docEntry.toString());
  //     if (value.statusCode == null) {
  //       return;
  //     }
  //     if (value.statusCode! >= 200 && value.statusCode! <= 210) {
  //       if (value.docEntry != null) {
  //         sapDocentry = value.docEntry.toString();
  //         sapDocuNumber = value.docNum.toString();
  //         await DBOperation.UpdtSapDetSalHead(db, int.parse(sapDocentry),
  //             int.parse(sapDocuNumber), docEntry, 'SalesOrderHeader');
  //         await pushRabiMqSO2(int.parse(docEntry.toString()));

  //         custserieserrormsg = '';
  //         notifyListeners();
  //       }
  //       notifyListeners();
  //     }
  //   });
  //   notifyListeners();
  // }

  clickaEditBtn(BuildContext context, ThemeData theme) async {
    // if (sapDocentry.isNotEmpty) {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getheaderData =
        await DBOperation.salesOrderCancellQuery(db, tbDocEntry.toString());
    if (getheaderData.isNotEmpty) {
      if (getheaderData[0]['basedocentry'].toString() ==
          tbDocEntry.toString()) {
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
                      content:
                          'This document is already converted into sales invoice',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          cancelDocnum = '';
          sapDocentry = '';
          sapDocuNumber = '';
          selectedcust2 = null;
          selectedcust25 = null;
          paymentWay2.clear();
          scanneditemData2.clear();
          cancelbtn = false;
          selectedcust2 = null;
          selectedcust = null;
          scanneditemData2.clear();
          paymentWay2.clear();
          totalPayment2 = null;
          injectToDb();
          getdraftindex();
          mycontroller2[50].text = "";
          notifyListeners();
        });
      }
    } else if (sapDocentry.isEmpty) {
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
                    content: 'Something went wrong...!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        cancelDocnum = '';
        sapDocentry = '';
        sapDocuNumber = '';
        selectedcust2 = null;
        selectedcust25 = null;
        paymentWay2.clear();
        scanneditemData2.clear();
        cancelbtn = false;
        selectedcust2 = null;
        selectedcust = null;
        scanneditemData2.clear();
        paymentWay2.clear();
        totalPayment2 = null;
        injectToDb();
        getdraftindex();
        mycontroller2[50].text = "";
        notifyListeners();
      });
    } else {
      await sapOrderLoginApi(
        context,
      );
      await callSerlaySalesOrderAPI(context, theme);
      await checkSAPsts(context, theme);

      notifyListeners();
    }
    // }
    // else {
    //   cancelbtn = false;
    //   showDialog(
    //       context: context,
    //       barrierDismissible: false,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //             contentPadding: const EdgeInsets.all(0),
    //             content: AlertBox(
    //               payMent: 'Alert',
    //               errormsg: true,
    //               widget: Center(
    //                   child: ContentContainer(
    //                 content: 'Something went wrong1111',
    //                 theme: theme,
    //               )),
    //               buttonName: null,
    //             ));
    //       }).then((value) {
    //     sapDocentry = '';
    //     sapDocuNumber = '';
    //     selectedcust2 = null;
    //     selectedcust25 = null;
    //     paymentWay2.clear();
    //     scanneditemData2.clear();
    //     cancelbtn = false;
    //     selectedcust2 = null;
    //     selectedcust = null;
    //     scanneditemData2.clear();
    //     paymentWay2.clear();
    //     totalPayment2 = null;
    //     injectToDb();
    //     getdraftindex();
    //     mycontroller2[50].text = "";
    //     searchmapbool = false;
    //     notifyListeners();
    //   });

    //   print("BBBBBBBBBBBBBBBBBBBBBB");
    // }
  }

  checkSAPsts(BuildContext context, ThemeData theme) async {
    if (SapSaleOrderModelData.isNotEmpty) {
      for (int ij = 0; ij < SapSaleOrderModelData.length; ij++) {
        if (SapSaleOrderModelData[ij].lineStatus == "bost_Open") {
          await updateFixDataMethod(context, theme);
        } else if (SapSaleOrderModelData[ij].lineStatus == "bost_Close") {
          cancelbtn = false;

          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: EdgeInsets.all(0),
                    content: AlertBox(
                      payMent: 'Alert',
                      errormsg: true,
                      widget: Center(
                          child: ContentContainer(
                        content: 'Document is already cancelled',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            sapDocentry = '';
            sapDocuNumber = '';
            sapDocentry = '';
            sapDocuNumber = '';
            selectedcust2 = null;
            scanneditemData2.clear();
            selectedcust25 = null;
            cancelbtn = false;
            notifyListeners();
          });
          notifyListeners();
        }
      }
    } else {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Something went wrong..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        // OndDisablebutton = false;
        notifyListeners();
      });
    }
  }

  onClickUpdate(
    BuildContext context,
    ThemeData theme,
  ) {
    OndDisablebutton = true;
    if (selectedcust == null || scanneditemData.isEmpty) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Choose Dcoument..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        OndDisablebutton = false;
        notifyListeners();
      });
      notifyListeners();
    } else {
      updatechangecheckout(context, theme);
      notifyListeners();
    }
  }

  updatechangecheckout(BuildContext context, ThemeData theme) async {
    if (SapSaleOrderModelData.isNotEmpty) {
      for (int ij = 0; ij < SapSaleOrderModelData.length; ij++) {
        if (SapSaleOrderModelData[ij].lineStatus == "bost_Open") {
          scehmeapiforckout(context, theme);
          await callOrderPatchApi(
              context, theme, int.parse(tbDocEntry.toString()));
          notifyListeners();
        } else if (SapSaleOrderModelData[ij].lineStatus == "bost_Close") {
          cancelbtn = false;
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: EdgeInsets.all(0),
                    content: AlertBox(
                      payMent: 'Alert',
                      errormsg: true,
                      widget: Center(
                          child: ContentContainer(
                        content: 'Document is already cancelled',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            sapDocentry = '';
            sapDocuNumber = '';
            sapDocentry = '';
            sapDocuNumber = '';
            selectedcust = null;
            scanneditemData.clear();
            selectedcust = null;
            notifyListeners();
          });
          notifyListeners();
        }
      }
    } else {
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
                    content: 'Something went wrong',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        sapDocentry = '';
        sapDocuNumber = '';
        selectedcust = null;
        selectedcust55 = null;
        scanneditemData.clear();
        paymentWay.clear();
        totalPayment = null;
        custList2.clear();
        injectToDb();
        getdraftindex();
        remarkcontroller3.text = '';
        mycontroller2[50].text = "";
        cancelbtn = false;
        notifyListeners();
      });
    }
  }

  updateSalesHeaderToDB(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<SalesOrderLineTDB> salesLineValues = [];
    // List<Map<String, Object?>> getDBUpdateSalesLine = [];

    SalesOrderHeaderModelDB salesHeaderValues1 = SalesOrderHeaderModelDB(
      doctype: 'Sales Order',
      docentry: tbDocEntry.toString(),
      objname: '',
      objtype: '',
      amtpaid: totalPayment != null
          ? getSumTotalPaid().toString().replaceAll(',', '')
          : null,
      baltopay: totalPayment != null
          ? getBalancePaid().toString().replaceAll(',', '')
          : null,
      billaddressid: selectedcust == null && selectedcust!.address == null ||
              selectedcust!.address!.isEmpty
          ? ''
          : selectedcust!.address![selectedBillAdress].autoId.toString(),
      billtype: null,
      branch: UserValues.branch!,
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      createdbyuser: UserValues.userType,
      customercode: selectedcust!.cardCode != null
          ? selectedcust!.cardCode.toString()
          : '',
      customername: selectedcust != null ? selectedcust!.name : "",
      customertype: UserValues.userType,
      docbasic: totalPayment != null
          ? totalPayment!.subtotal!.toString().replaceAll(',', '')
          : null,
      docdiscamt: totalPayment != null
          ? totalPayment!.discount!.toString().replaceAll(',', '')
          : null,
      docdiscuntpercen: mycontroller[i].text.isNotEmpty
          ? mycontroller[i].text.toString()
          : '0',
      documentno: (cancelDocnum).toString(),
      docstatus: '3',
      doctotal: totalPayment != null
          ? totalPayment!.totalDue!.toStringAsFixed(0)
          : null,
      lastupdateIp: UserValues.lastUpdateIp,
      premiumid: '',
      remarks: remarkcontroller3.text.toString(),
      salesexec: '',
      seresid: "",
      seriesnum: '',
      shipaddresid: selectedcust55 != null &&
              selectedcust55!.address!.isNotEmpty
          ? selectedcust55!.address![selectedShipAdress].autoId.toString()
          // ? '${selectedcust!.address![selectedShipAdress].address1.toString()},${selectedcust!.address![selectedShipAdress].address2.toString()},${selectedcust!.address![selectedShipAdress].address3}'
          : "",
      sodocno: "",
      sodocseries: "",
      sodocseriesno: '',
      sodoctime: config.currentDate(),
      sosystime: config.currentDate(),
      sotransdate: config.currentDate(),
      sysdatetime: config.currentDate(),
      taxamount:
          totalPayment != null ? totalPayment!.totalTX!.toString() : null,
      taxno: selectedcust != null ? selectedcust!.tarNo.toString() : "",
      transactiondate: '',
      transtime: config.currentDate(),
      updatedDatetime: config.currentDate(),
      updateduserid: UserValues.userID.toString(),
      paystatus: '',
      customeraccbal:
          selectedcust != null ? selectedcust!.accBalance!.toString() : "",
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
      terminal: UserValues.terminal,
      sapDocNo:
          sapDocuNumber.isNotEmpty ? int.parse(sapDocuNumber.toString()) : 0,
      sapDocentry:
          sapDocentry.isNotEmpty ? int.parse(sapDocentry.toString()) : 0,
      qStatus: "C",
      totalltr: totalLiter(),
      totalweight: totalWeight(),
      basedocentry: selectedcust!.docentry != null
          ? selectedcust!.docentry.toString()
          : '',
      customerSeriesNum: '',
      editType: 'Edit',
      uOrderDate: selectedcust!.uOrderDate!,
      uOrderType: selectedcust!.uOrderType,
      uGPApproval: selectedcust!.uGPApproval,
      uReceivedTime: selectedcust!.uReceivedTime,
      uDeviceId: selectedcust!.uDeviceId!,
      custRefNo: selectedcust!.custRefNum ?? '',
    );

    await DBOperation.updateSaleOrderheader(
        db, salesHeaderValues1, tbDocEntry.toString(), cancelDocnum.toString());
    List<Map<String, Object?>> getDBUpdateSalesHeader =
        await DBOperation.getSalesOrderHeaderDB(
            db, int.parse(tbDocEntry.toString()));

//log("getDBUpdateSalesHeader::${getDBUpdateSalesHeader.length}::${getDBUpdateSalesHeader[0]['doctype']}");
    for (int i = 0; i < scanneditemData.length; i++) {
      double? mycontamount = mycontroller[i].text.toString().isNotEmpty
          ? double.parse(mycontroller[i].text.toString())
          : 00;
      salesLineValues.add(SalesOrderLineTDB(
        basic: scanneditemData[i].basic.toString(),
        branch: UserValues.branch,
        createdUser: UserValues.userType,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        discamt: scanneditemData[i].discount.toString(),
        discperc: discountcontroller[i].text.isNotEmpty
            ? discountcontroller[i].text.toString()
            : '0',
        discperunit: scanneditemData[i].discount.toString(),
        maxdiscount: scanneditemData[i].Maxdiscount.toString(),
        docentry: tbDocEntry.toString(),
        itemcode: scanneditemData[i].ItemCode,
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        lineID: i.toString(),
        linetotal: scanneditemData[i].basic.toString(),
        netlinetotal: scanneditemData[i].netvalue!.toStringAsFixed(0),
        price: scanneditemData[i].SellPrice.toString(),
        quantity: scanneditemData[i].Qty.toString(),
        serialbatch: scanneditemData[i].SerialBatch,
        taxrate: scanneditemData[i].TaxRate.toString(),
        taxtotal: scanneditemData[i].taxvalue!.toStringAsFixed(0),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        terminal: UserValues.terminal,
        itemname: scanneditemData[i].ItemName,
        basedocentry: scanneditemData[i].basedocentry ?? '',
        baselineID: scanneditemData[i].baselineid ?? '',
      ));

      notifyListeners();
    }

    if (salesLineValues.isNotEmpty) {
      for (int ik = 0; ik < salesLineValues.length; ik++) {
        await DBOperation.updateSalesOrderLine(
            db, salesLineValues, ik, tbDocEntry.toString());
        notifyListeners();
        List<Map<String, Object?>> getDBUpdateSalesLine =
            await DBOperation.getSalesOrderLineDB(
                db, int.parse(tbDocEntry.toString()));
        //log("getDBUpdateSalesHeader::${getDBUpdateSalesLine.length}::${getDBUpdateSalesLine[0]['itemcode']}");
      }
    }
    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      // pushRabiMqSO3(tbDocEntry!);
    }

    // cpyfrmsq = false;
    // OndDisablebutton = true;
    // scanneditemData.clear();
    // selectedcust = null;
    // schemebtnclk = false;
    // selectedcust55 = null;
    // paymentWay.clear();
    // newShipAddrsValue = [];
    // newBillAddrsValue = [];
    // newCustValues = [];
    // totalPayment = null;
    // mycontroller[50].text = "";
    // discountcontroller = List.generate(100, (i) => TextEditingController());
    // mycontroller = List.generate(150, (i) => TextEditingController());
    // qtymycontroller = List.generate(100, (i) => TextEditingController());
    // remarkcontroller3.text = '';
    // notifyListeners();
    // if (getDBUpdateSalesHeader.isNotEmpty) {
    //   await Get.defaultDialog(
    //           title: "Success",
    //           middleText: 'Updated Successfully Done',
    //           backgroundColor: Colors.white,
    //           titleStyle: const TextStyle(color: Colors.red),
    //           middleTextStyle: const TextStyle(color: Colors.black),
    //           actions: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 TextButton(
    //                   child: const Text("Close"),
    //                   onPressed: () => Get.back(),
    //                 ),
    //               ],
    //             ),
    //           ],
    //           radius: 5)
    //       .then((value) {
    //     injectToDb();
    //     // if (docstatus == "check out") {
    //     Get.offAllNamed(ConstantRoutes.dashboard);
    //     // }
    //     OndDisablebutton = false;

    //     notifyListeners();
    //   });
    // } else if (getDBUpdateSalesHeader.isEmpty) {
    //   showDialog(
    //       context: context,
    //       barrierDismissible: false,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //             contentPadding: const EdgeInsets.all(0),
    //             content: AlertBox(
    //               payMent: 'Alert',
    //               errormsg: true,
    //               widget: Center(
    //                   child: ContentContainer(
    //                 content: 'Something went wrong',
    //                 theme: theme,
    //               )),
    //               buttonName: null,
    //             ));
    //       });
    // }
    notifyListeners();
  }

  callOrderPatchApi(BuildContext context, ThemeData theme, int docEntry) async {
    final Database db = (await DBHelper.getInstance())!;
    getOrderDocList();
    // List<Map<String, Object?>>  soHeaderData= await DBOperation. getSalesOrderHeaderDB(db,docEntry);

    // var uuid = Uuid();
    // String? uuidg = uuid.v1();
    SalesOrdPatchAPI.sessionID = AppConstant.sapSessionID.toString();
    SalesOrdPatchAPI.cardCodePost = addCardCode;
    SalesOrdPatchAPI.cardNamePost = selectedcust!.name;
    SalesOrdPatchAPI.docLineQout = itemsDocDetails;
    SalesOrdPatchAPI.docDate = config.currentDate2();
    SalesOrdPatchAPI.dueDate = config.currentDate2();
    SalesOrdPatchAPI.remarks = remarkcontroller3.text;
    SalesOrdPatchAPI.orderDate =
        config.alignDate2(selectedcust!.uOrderDate.toString());
    SalesOrdPatchAPI.orderType = selectedcust!.uOrderType;
    SalesOrdPatchAPI.gpApproval = selectedcust!.uGPApproval;
    SalesOrdPatchAPI.orderTime = selectedcust!.uReceivedTime;
    SalesOrdPatchAPI.custREfNo = selectedcust!.custRefNum ?? '';
    SalesOrdPatchAPI.deviceTransID = selectedcust!.uDeviceId;
    SalesOrdPatchAPI.deviceCode = AppConstant.ip;
    SalesOrdPatchAPI.slpCode = '67';
    // SalesOrdPatchAPI.method(latitude!, longitude!);
    // SalesOrdPatchAPI.cardCodePost = selectedcust!.cardCode;
    // SalesOrdPatchAPI.docLineQout = itemsDocDetails;
    // SalesOrdPatchAPI.docDate = config.currentDate();
    // SalesOrdPatchAPI.dueDate = config.currentDate().toString();
    // SalesOrdPatchAPI.remarks = remarkcontroller3.text;

    // SalesOrdPatchAPI.deviceTransID = uuidg;

    await SalesOrdPatchAPI.gettData(sapDocentry, latitude!, longitude!)
        .then((value) async {
      // SalesOrderAfterAPi.baseEntry = value.docEntry.toString();
      //log("object:" + value.statusCode.toString());

      if (value.statusCode == null) {
        return;
      }
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        await DBOperation.UpdtSapDetSalHead(db, int.parse(sapDocentry),
            int.parse(sapDocuNumber), docEntry, 'SalesOrderHeader');

        await updateSalesHeaderToDB(context, theme);

        await pushRabiMqSO2(int.parse(docEntry.toString()));

        custserieserrormsg = '';
        OndDisablebutton = true;
        loadingscrn = false;
        scanneditemData.clear();
        schemebtnclk = false;
        selectedcust = null;
        selectedcust55 = null;
        paymentWay.clear();
        newShipAddrsValue = [];
        itemsDocDetails = [];
        newBillAddrsValue = [];
        newCustValues = [];
        totalPayment = null;
        mycontroller[50].text = "";
        discountcontroller = List.generate(100, (i) => TextEditingController());
        mycontroller = List.generate(150, (i) => TextEditingController());
        qtymycontroller = List.generate(100, (i) => TextEditingController());
        remarkcontroller3.text = '';
        notifyListeners();

        await Get.defaultDialog(
                title: "Success",
                middleText: 'Updated Successfully',
                backgroundColor: Colors.white,
                titleStyle: TextStyle(color: Colors.red),
                middleTextStyle: TextStyle(color: Colors.black),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text("Close"),
                        onPressed: () =>
                            Get.offAllNamed(ConstantRoutes.dashboard),
                      ),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          injectToDb();

          notifyListeners();
        });
      } else if (value.statusCode >= 400 && value.statusCode <= 410) {
        //log("Error22");
        cancelbtn = false;
        custserieserrormsg = value.erorrs!.message!.Value;
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
          OndDisablebutton = true;
          loadingscrn = false;
          scanneditemData.clear();
          schemebtnclk = false;
          selectedcust = null;
          selectedcust55 = null;
          paymentWay.clear();
          newShipAddrsValue = [];
          itemsDocDetails = [];
          newBillAddrsValue = [];
          newCustValues = [];
          totalPayment = null;
          mycontroller[50].text = "";
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(100, (i) => TextEditingController());
          remarkcontroller3.text = '';
          notifyListeners();
          Get.defaultDialog(
                  title: "Alert",
                  middleText: custserieserrormsg =
                      value.error!.message!.value.toString(),
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
            injectToDb();
            OndDisablebutton = false;

            notifyListeners();
          });
        });
      } else {
        Get.defaultDialog(
                title: "Alert",
                middleText: custserieserrormsg = value.exception.toString(),
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
          injectToDb();
          OndDisablebutton = false;

          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  pushRabiMqSO(int? docentry) async {
    //background service
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getdSalesOrderPayDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.getSalesOrderLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesOrderHeaderDB(db, docentry);
    String salesPAY = json.encode(getDBSalespay);
    String salesLine = json.encode(getDBSalesLine);
    String salesHeader = json.encode(getDBSalesHeader);
    // dynamic data = {"payload": salesPAY};
    var ddd = json.encode({
      "ObjectType": 10,
      "ActionType": "Add",
      "SalesOrderHeader": salesHeader,
      "SalesOrderLine": salesLine,
      "SalesOrderPay": salesPAY,
    });
//log("payload11 : $ddd");
    //RabitMQ
    // Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        // AppConstant.ip,
        //"102.69.167.106"
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    Channel channel = await client1.channel(); //Server_CS
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    // properties.headers = {"Branch": UserValues.branch};
    // exchange.publish(ddd, "", properties: properties);

    //cs

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  pushRabiMqSO2(int? docentry) async {
    //background service
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getdSalesOrderPayDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.getSalesOrderLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesOrderHeaderDB(db, docentry);
    String salesPAY = json.encode(getDBSalespay);
    String salesLine = json.encode(getDBSalesLine);
    String salesHeader = json.encode(getDBSalesHeader);
    // dynamic data = {"payload": salesPAY};
    var ddd = json.encode({
      "ObjectType": 10,
      "ActionType": "Add",
      "SalesOrderHeader": salesHeader,
      "SalesOrderLine": salesLine,
      "SalesOrderPay": salesPAY,
    });
//log("payload22 : $ddd");
    //RabitMQ
    // Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        // AppConstant.ip,
        //"102.69.167.106"
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    properties.headers = {"Branch": UserValues.branch};
    Channel channel = await client1.channel(); //Server_CS
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    exchange.publish(ddd, "", properties: properties);

    //cs

    // properties.headers = {"Branch": "Server"};
    // exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  pushRabiMqSO3(int? docentry) async {
    //background service
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getdSalesOrderPayDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.getSalesOrderLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesOrderHeaderDB(db, docentry);
    String salesPAY = json.encode(getDBSalespay);
    String salesLine = json.encode(getDBSalesLine);
    String salesHeader = json.encode(getDBSalesHeader);
    // dynamic data = {"payload": salesPAY};
    var ddd = json.encode({
      "ObjectType": 10,
      "ActionType": "Edit",
      "SalesOrderHeader": salesHeader,
      "SalesOrderLine": salesLine,
      "SalesOrderPay": salesPAY,
    });
//log("payload : $ddd");
    //RabitMQ
    // Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        // AppConstant.ip,
        //"102.69.167.106"
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    properties.headers = {"Branch": UserValues.branch};
    Channel channel = await client1.channel(); //Server_CS
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    exchange.publish(ddd, "", properties: properties);

    //cs

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  CustSeriesApi() async {
    mycontroller[48].text = '139';
    //GetValues.slpCode!;
    await GetSeriesApiAPi.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.seriescustData != null) {
          seriesData = value.seriescustData!;
          // custserieserrormsg = '';
          notifyListeners();
        } else {
          custserieserrormsg = value.message!.toString();
          notifyListeners();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custserieserrormsg = value.message!.toString();
        notifyListeners();
      } else {
        custserieserrormsg = value.message!.toString();
        notifyListeners();
      }
      notifyListeners();
    });
    await GetCustomerGrpAPi.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.groupcustData != null) {
          groupcData = value.groupcustData!;
          custerrormsg = '';
          notifyListeners();
        } else {
          custerrormsg = value.message!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custerrormsg = value.message!;
      } else {
        custerrormsg = value.message!;
      }
      notifyListeners();
    });

    await GetTeriteriAPi.getGlobalData().then((value) {
      // groCustLoad = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.groupcustData != null) {
          teriteritData = value.groupcustData!;
          custserieserrormsg = '';
          notifyListeners();
        } else {
          custserieserrormsg = value.message!;
          notifyListeners();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custserieserrormsg = value.message!;
        notifyListeners();
      } else {
        custserieserrormsg = value.message!;
      }
    });

    await GetPaymentGroupAPi.getGlobalData().then((value) {
      groCustLoad = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.groupcustData != null) {
          paygroupData = value.groupcustData!;
          custserieserrormsg = '';
          notifyListeners();
        } else {
          custserieserrormsg = value.message!;
          notifyListeners();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custserieserrormsg = value.message!;
        notifyListeners();
      } else {
        custserieserrormsg = value.message!;
        notifyListeners();
      }
    });
  }

  Future<void> addFiles() async {
    filedata.clear();
    List<int> intdata = tinFiles!.readAsBytesSync();
    filedata.add(FilesData(
        fileBytes: base64Encode(intdata),
        fileName: tinFiles!.path.split('/').last));
    List<int> intdata2 = vatFiles!.readAsBytesSync();
    filedata.add(FilesData(
        fileBytes: base64Encode(intdata2),
        fileName: vatFiles!.path.split('/').last));
  }

  callPostApi(BuildContext context, ThemeData theme) async {
    loadingBtn = true;
    await addFiles();
    await sapOrderLoginApi(
      context,
    );
//log("App constatant fff ::::${AppConstant.sapSessionID}");

    NewCutomerModel newCutomerModel = NewCutomerModel();

    for (int i = 0; i < filedata.length; i++) {
      print('Step11');

      await FilePostApi.getFilePostData(
              filedata[i].fileBytes, filedata[i].fileName)
          .then((value) {
        print('Step12');

        if (value.stCode! >= 200 && value.stCode! <= 210) {
          //log("Api PAth $i: " + value.filepath.toString());
          if (i == 0) {
            print('Step13');

            newCutomerModel.tincer = value.filepath!;
            notifyListeners();
          } else if (i == 1) {
            print('Step14');

            newCutomerModel.vatcer = value.filepath!;
            notifyListeners();
          }
        } else if (value.stCode! >= 400 && value.stCode! <= 410) {
          print('Step15');
        } else {
          print('Step16');

          //   // fileException.add(value.exception!);
        }
      });
    }

    newCutomerModel.cardCode =
        mycontroller[3].text.isEmpty ? null : mycontroller[3].text;
    newCutomerModel.cardName = mycontroller[6].text;
    newCutomerModel.grupCode = codeValue == null ? null : int.parse(codeValue!);
    newCutomerModel.AdditionalID = mycontroller[46].text;
    newCutomerModel.FederalTaxID = mycontroller[47].text;
    newCutomerModel.Cellular = mycontroller[4].text;
    newCutomerModel.SalesPersonCode =
        mycontroller[48].text.isEmpty ? null : int.parse(mycontroller[48].text);
    newCutomerModel.ContactPerson = mycontroller[51].text;
    newCutomerModel.CreditLimit = mycontroller[49].text.isEmpty
        ? null
        : int.parse(
            mycontroller[49].text.replaceAll(",", "").replaceAll(".", ""));
    newCutomerModel.Notes = mycontroller[50].text;
    newCutomerModel.Series =
        custseriesNo == null ? null : int.parse(custseriesNo!);
    newCutomerModel.Territory =
        teriteriValue == null ? null : int.parse(teriteriValue!);
    newCutomerModel.PayTermsGrpCod =
        paygrpValue == null ? null : int.parse(paygrpValue!);
    newCutomerModel.newModel = [
      NewCutomeAdrsModel(
        AddressName: mycontroller[7].text,
        AddressName2: mycontroller[8].text,
        AddressName3: mycontroller[9].text,
        AddressType: 'bo_BillTo',
        City: mycontroller[10].text,
        Country: '', //mycontroller[10].text,
        State: '', // mycontroller[12].text,
        Street: '',
        ZipCode: mycontroller[13].text,
      ),
      NewCutomeAdrsModel(
        AddressName: mycontroller[14].text,
        AddressName2: mycontroller[15].text,
        AddressName3: mycontroller[16].text,
        AddressType: 'bo_ShipTo',
        City: mycontroller[17].text,
        Country: '', //mycontroller[20].text,
        State: '', //mycontroller[19].text,
        Street: '',
        ZipCode: mycontroller[18].text,
      ),
    ];
    newCutomerModel.contEmp = [ContactEmployees(name: mycontroller[51].text)];
    await PostCustCreateAPi.getGlobalData(newCutomerModel).then((value) {
      print('Step1');

      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        print('Step2');

        cardCodexx = value.CardCode.toString();
        // Navigator.pop(context);

        // mycontroller[3].text = value.CardCode.toString();
        config.showDialogSucessB("Customer Successfully created..!!", "Sucess");
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        print('Step3');

        config.showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed");
      } else {
        print('Step4');

        config.showDialogg("Something went wrong try agian..!!", "Sucess");
      }
    });
    notifyListeners();
  }

  void selectVatattachment() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      //filedata.clear();
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      for (int i = 0; i < filesz.length; i++) {
        vatFiles = filesz[i];
        // List<int> intdata = filesz[i].readAsBytesSync();
        // filedata.add(FilesData(
        //     fileBytes: base64Encode(intdata),
        //     fileName: tinFiles!.path.split('/').last));
        notifyListeners();
      }
    }
  }

  void selectattachment() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      //filedata.clear();
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      print(tinFiles);

      for (int i = 0; i < filesz.length; i++) {
        tinFiles = filesz[i];
        notifyListeners();

        // List<int> intdata = filesz[i].readAsBytesSync();
        // filedata.add(FilesData(
        //     fileBytes: base64Encode(intdata),
        //     fileName: tinFiles!.path.split('/').last));
      }
    }
  }

  clearSuspendedData(BuildContext context, ThemeData theme) {
    cpyfrmsq = false;
    cashType = '';
    creditType = '';
    cardType = '';
    chequeType = '';
    transferType = '';
    walletType = '';
    pointType = '';
    accType = '';
    addCardCode = '';
    OndDisablebutton = true;
    scanneditemData.clear();
    selectedcust = null;
    selectedcust55 = null;
    remarkcontroller3.text = '';
    mycontroller[50].clear();
    paymentWay.clear();
    totalPayment = null;
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    billcreateNewAddress = [];
    shipcreateNewAddress = [];
    newCustValues = [];
    cashType = '';
    creditType = '';
    cardType = '';
    chequeType = '';
    transferType = '';
    walletType = '';
    pointType = '';
    accType = '';
    cashpayment = null;
    cashpayment = null;

    cqpayment = null;

    transpayment = null;
    chqnum = null;

    transrefff = null;
    addCardCode = '';
    mycontroller = List.generate(150, (i) => TextEditingController());
    qtymycontroller = List.generate(100, (i) => TextEditingController());
    discountcontroller = List.generate(100, (i) => TextEditingController());
    discountcontroller2 = List.generate(100, (i) => TextEditingController());

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
      OndDisablebutton = false;
      notifyListeners();
    });
  }

  viewDbtable() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.getdata(db);
    notifyListeners();
  }

// [log] itemData[i].SerialBatch: 23-556
// [log] itemData[i].SerialBatch: OB
// [log] itemData[i].SerialBatch: OBSTK-16309
// [log] itemData[i].SerialBatch: 22-32699
// [log] itemData[i].SerialBatch: 21-23706
// [log] itemData[i].SerialBatch: 22-6955
// [log] itemData[i].SerialBatch: 23-1683
// [log] itemData[i].SerialBatch: 21-21215

  // getItemFromDB(Database db) async {
  //   List<StockSnapTModelDB> itemMasdata = await DBOperation.getItemMasData(db);
  //   for (int i = 0; i < itemMasdata.length; i++) {
  //     itemData.add(StocksnapModelData(
  //         TransID: int.parse(itemMasdata[i].transentry != null
  //             ? itemMasdata[i].transentry.toString()
  //             : '0'),
  //         Branch: itemMasdata[i].branchcode,
  //         ItemCode: itemMasdata[i].itemcode,
  //         ItemName: itemMasdata[i].itemname,
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
  // }

  getItemFromDB(Database db) async {
    List<StockSnapTModelDB> itemMasdata =
        await DBOperation.getItemMasData(db, "");
    for (int i = 0; i < itemMasdata.length; i++) {
      itemData.add(StocksnapModelData(
        Branch: itemMasdata[i].branchcode,
        ItemCode: itemMasdata[i].itemcode,
        ItemName: itemMasdata[i].itemname,
        SerialBatch: itemMasdata[i].serialbatch,
        Qty: int.parse(itemMasdata[i].quantity!),
        MRP: double.parse(itemMasdata[i].mrpprice.toString()),
        createdUserID: itemMasdata[i].createdUserID.toString(),
        createdateTime: itemMasdata[i].createdateTime,
        lastupdateIp: itemMasdata[i].lastupdateIp,
        purchasedate: itemMasdata[i].purchasedate,
        snapdatetime: itemMasdata[i].snapdatetime,
        specialprice: double.parse(itemMasdata[i].specialprice.toString()),
        updatedDatetime: itemMasdata[i].updatedDatetime,
        updateduserid: itemMasdata[i].updateduserid.toString(),
        SellPrice: double.parse(itemMasdata[i].sellprice!),
        Maxdiscount: itemMasdata[i].maxdiscount != null
            ? itemMasdata[i].maxdiscount.toString()
            : '',
        TaxRate: itemMasdata[i].taxrate != null
            ? double.parse(itemMasdata[i].taxrate.toString())
            : 00,
        discountper: 0,
        OpenQty: 0,
        TransID: int.parse(itemMasdata[i].transentry != null
            ? itemMasdata[i].transentry.toString()
            : '0'),
        InDate: '',
        Cost: 0,
        TaxType: '',
        InType: '',
        VenCode: '',
        VenName: '',
        liter: itemMasdata[i].liter != null
            ? double.parse(itemMasdata[i].liter.toString())
            : 00,
        weight: itemMasdata[i].weight != null
            ? double.parse(itemMasdata[i].weight.toString())
            : 00,
      ));
      notifyListeners();
    }
    notifyListeners();
  }

  getCustDetFDB() async {
    custList.clear();
    custList2.clear();
    final Database db = (await DBHelper.getInstance())!;

    List<CustomerModelDB> cusdataDB = await DBOperation.getCstmMasDB(db);

    List<CustomerAddressModelDB> csadresdataDB =
        await DBOperation.getCstmMasAddDB(
      db,
    );
    List<Map<String, Object?>> getTopCuslist =
        await DBOperation.getTopCuslist(db);

    for (int i = 1; i < cusdataDB.length; i++) {
      if (cusdataDB[i].customername != "This is my updated name") {
        custList.add(CustomerDetals(
            cardCode: cusdataDB[i].customerCode,
            name: cusdataDB[i].customername,
            phNo: cusdataDB[i].phoneno1,
            accBalance: cusdataDB[i].balance,
            point: cusdataDB[i].points.toString(),
            tarNo: cusdataDB[i].taxno,
            email: cusdataDB[i].emalid,
            invoicenum: '',
            invoiceDate: '',
            totalPayment: 00,
            address: []));
      }
    }
    for (int i = 0; i < custList.length; i++) {
      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (custList[i].cardCode == csadresdataDB[ia].custcode) {
          custList[i].address!.add(Address(
                autoId: int.parse(csadresdataDB[ia].autoid.toString()),
                addresstype: csadresdataDB[ia].addresstype,
                address1: csadresdataDB[ia].address1!,
                address2: csadresdataDB[ia].address2!,
                address3: csadresdataDB[ia].address3!,
                billCity: csadresdataDB[ia].city!,
                billCountry: csadresdataDB[ia].countrycode!,
                billPincode: csadresdataDB[ia].pincode!,
                billstate: csadresdataDB[ia].statecode,
              ));
        }
      }
    }

    for (int j = 0; j < getTopCuslist.length; j++) {
      for (int i = 1; i < cusdataDB.length; i++) {
        if (cusdataDB[i].customerCode ==
            getTopCuslist[j]["customercode"].toString()) {
          custList2.add(CustomerDetals(
              cardCode: cusdataDB[i].customerCode,
              name: cusdataDB[i].customername,
              phNo: cusdataDB[i].phoneno1,
              // accBalance: cusdataDB[i].balance,
              point: cusdataDB[i].points.toString(),
              tarNo: cusdataDB[i].taxno,
              email: cusdataDB[i].emalid,
              invoicenum: '',
              invoiceDate: '',
              totalPayment: 00,
              address: []));
        }
      }
    }
    //log("getTopCuslist2:::" + custList2.length.toString());

    for (int i = 0; i < custList2.length; i++) {
      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (custList2[i].cardCode == csadresdataDB[ia].custcode) {
          custList2[i].address!.add(Address(
                autoId: int.parse(csadresdataDB[ia].autoid.toString()),
                addresstype: csadresdataDB[ia].addresstype,
                address1: csadresdataDB[ia].address1!,
                address2: csadresdataDB[ia].address2!,
                address3: csadresdataDB[ia].address3!,
                billCity: csadresdataDB[ia].city!,
                billCountry: csadresdataDB[ia].countrycode!,
                billPincode: csadresdataDB[ia].pincode!,
                billstate: csadresdataDB[ia].statecode,
                // shipCity: csadresdataDB[ia].city!,
                // shipCountry: csadresdataDB[ia].countrycode!,
                // shipPincode: csadresdataDB[ia].statecode,
                // shipstate: csadresdataDB[ia].statecode,
              ));
        }
      }
    }
    // if (newCustValues.isNotEmpty && newBillAddrsValue.isNotEmpty) {
    //  //log("step1");
    //   for (int i = 0; i < custList.length; i++) {
    //    //log("step2");

    //     for (int ia = 0; ia < csadresdataDB.length; ia++) {
    //      //log("step3");

    //       if (custList[custList.length - 1].cardCode == csadresdataDB[ia].custcode) {
    //       selectedcust = CustomerDetals(
    //         accBalance: custList[custList.length - 1].accBalance,
    //         cardCode: custList[custList.length - 1].cardCode,
    //         name: custList[custList.length - 1].name,
    //         phNo: custList[custList.length - 1].phNo,
    //         point: custList[custList.length - 1].point,
    //         tarNo: custList[custList.length - 1].tarNo,
    //         email: custList[custList.length - 1].email,
    //         address: [
    //           //custlist[i].address[ij].address1
    //           Address(
    //             autoId:int.parse(csadresdataDB[ia].autoid.toString() ),
    //             address1: csadresdataDB[ia].address1,
    //             address2: csadresdataDB[ia].address2,
    //             address3: csadresdataDB[ia].address3,
    //             billCity: csadresdataDB[ia].city!,
    //             billCountry: csadresdataDB[ia].countrycode!,
    //             billPincode: csadresdataDB[ia].pincode.toString(),
    //             billstate: csadresdataDB[ia].statecode,
    //           ),
    //         ],
    //         //   invoicenum: '',
    //         //   invoiceDate: '',
    //         //   totalPayment: 00,
    //       );
    //       if (selectedcust!.address!.length >= 2) {
    //        //log("step4");

    //         selectedBillAdress = selectedcust!.address!.length - 2;
    //         selectedShipAdress = selectedcust!.address!.length - 1;
    //       } else {
    //        //log("step5");

    //         selectedBillAdress = selectedcust!.address!.length - 1;
    //         selectedShipAdress = selectedcust!.address!.length - 1;
    //       }
    //     }
    //   }
    // }
    // }
    // List<Address> Newadd55 = [];
    // if (newCustValues.isNotEmpty &&
    //     newBillAddrsValue.isNotEmpty &&
    //     newShipAddrsValue.isNotEmpty) {
    //   for (int i = 0; i < custList.length; i++) {
    //     for (int ia = 0; ia < csadresdataDB.length; ia++) {
    //       if (custList[i].cardCode == csadresdataDB[ia].custcode) {
    //        //log("csadresdataDBcsadresdataDB::" +
    //             csadresdataDB.length.toString());
    //         // Newadd55 = [
    //         //   //custlist[i].address[ij].address1
    //         //   Address(
    //         //     address1: custList[custList.length - 2]
    //         //         .address![custList[custList.length - 2].address!.length - 2]
    //         //         .address1,
    //         //     address2: custList[custList.length - 2]
    //         //         .address![custList[custList.length - 2].address!.length - 2]
    //         //         .address2,
    //         //     address3: custList[custList.length - 2]
    //         //         .address![custList[custList.length - 2].address!.length - 2]
    //         //         .address3,
    //         //     billCity: custList[custList.length - 2]
    //         //         .address![custList[custList.length - 2].address!.length - 2]
    //         //         .billCity,
    //         //     billCountry: custList[custList.length - 2]
    //         //         .address![custList[custList.length - 2].address!.length - 1]
    //         //         .billCountry,
    //         //     billPincode: custList[custList.length - 2]
    //         //         .address![custList[custList.length - 2].address!.length - 2]
    //         //         .billPincode,
    //         //     billstate: custList[custList.length - 2]
    //         //         .address![custList[custList.length - 2].address!.length - 2]
    //         //         .billstate,
    //         //   ),
    //         //   Address(
    //         //     address1: custList[custList.length - 1]
    //         //         .address![custList[custList.length - 1].address!.length - 1]
    //         //         .address1,
    //         //     address2: custList[custList.length - 1]
    //         //         .address![custList[custList.length - 1].address!.length - 1]
    //         //         .address2,
    //         //     address3: custList[custList.length - 1]
    //         //         .address![custList[custList.length - 1].address!.length - 1]
    //         //         .address3,
    //         //     billCity: custList[custList.length - 1]
    //         //         .address![custList[custList.length - 1].address!.length - 1]
    //         //         .billCity,
    //         //     billCountry: custList[custList.length - 1]
    //         //         .address![custList[custList.length - 1].address!.length - 1]
    //         //         .billCountry,
    //         //     billPincode: custList[custList.length - 1]
    //         //         .address![custList[custList.length - 1].address!.length - 1]
    //         //         .billPincode,
    //         //     billstate: custList[custList.length - 1]
    //         //         .address![custList[custList.length - 1].address!.length - 1]
    //         //         .billstate,
    //         //   ),
    //         // ];

    //         selectedcust = CustomerDetals(
    //           accBalance: custList[custList.length - 1].accBalance,
    //           cardCode: custList[custList.length - 1].cardCode,
    //           name: custList[custList.length - 1].name,
    //           phNo: custList[custList.length - 1].phNo,
    //           point: custList[custList.length - 1].point,
    //           tarNo: custList[custList.length - 1].tarNo,
    //           email: custList[custList.length - 1].email,
    //           address: Newadd55,
    //         );
    //       }
    //     }
    //   }
    //   selectedBillAdress = (selectedcust!.address!.length - 2);
    //   selectedShipAdress = (selectedcust!.address!.length - 1);
    //  //log("selectedcust!.address!.length:" +
    //       selectedcust!.address!.length.toString());
    //  //log('selectedcust!.address!.length - 2::${selectedcust!.address!.length - 2}');
    // }
    // for (int ik = 0; ik < custList.length; ik++) {
    //   await AccountBalApi.getData(custList[ik].cardCode.toString())
    //       .then((value) {
    //     // loadingscrn = false;

    //     if (value.statuscode >= 200 && value.statuscode <= 210) {
    //   //log("GGGGGG:::${value.accBalanceData![0].balance.toString()}");
    //       for (int ij = 0; ij < value.accBalanceData!.length; ij++) {
    //         // updateCustBal
    //         custList[ik].accBalance =
    //             double.parse(value.accBalanceData![ij].balance.toString());
    //         // selectedcust55!.accBalance = double.parse(value.accBalanceData![0].balance.toString());
    //         notifyListeners();
    //       }
    //     }
    //   });
    // }
    filtercustList = custList;
    notifyListeners();
  }

  // call api

  postCategory(String value) {
    selectedValue = value;
  }

  // clickItemcode(ItemCodeListModel aaa, BuildContext context, ThemeData theme) {
  //   itemcodeitem = null;
  //   ItemCodeListModel itemcodee = ItemCodeListModel(ItemCode: aaa.ItemCode);
  //   itemcodeitem = itemcodee;
  //   // log("itemcodeitem.itemcode::" + itemcodeitem!.ItemCode.toString());
  //   // log("itemcodeitem.intval::" + intval.toString());
  //   addScannedData(intval, context, theme);
  //   mycontroller[99].clear();
  //   notifyListeners();
  // }

  int intval = 0;
  // scannBAtch(BuildContext context, ThemeData theme) async {
  //   intval = 0;
  //   print(" mycontroller[99].text::${mycontroller[99].text}");
  //   int? indx = await checkBatchAvail(
  //       mycontroller[99].text.toString().trim().toUpperCase());
  //   if (indx != null) {
  //     intval = indx;
  //     // log("****************::" + itemcodelistitem.length.toString());
  //     if (itemcodelistitem.length > 1) {
  //       forItemCodecheck(context, theme);

  //       notifyListeners();
  //     } else if (itemcodelistitem.length == 1) {
  //       // log("VVVVVVVVV");

  //       addScannedData(indx, context, theme);
  //       mycontroller[99].clear();

  //       notifyListeners();
  //     }
  //   } else if (indx == null) {
  //     // log("index: $indx");
  //     showDialog(
  //         context: context,
  //         barrierDismissible: true,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //               contentPadding: EdgeInsets.all(0),
  //               content: AlertBox(
  //                 payMent: 'Alert',
  //                 errormsg: true,
  //                 widget: Center(
  //                     child: ContentContainer(
  //                   content: 'Wrong batch scanned..!!',
  //                   theme: theme,
  //                 )),
  //                 buttonName: null,
  //               ));
  //         });
  //     mycontroller[99].clear();
  //   }
  // }

  // List<ItemCodeListModel> itemcodelistitem = [];
  // ItemCodeListModel? itemcodeitem;

  // Future<int?> checkBatchAvail(String sBatch) async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   itemcodelistitem.clear();
  //   itemcodeitem = null;
  //   for (int i = 0; i < itemData.length; i++) {
  //    //log('Serial batch1111:${itemData[i].SerialBatch}');

  //     if (itemData[i].SerialBatch == sBatch) {
  //      //log('Serial batch2222:$sBatch');
  //       List<Map<String, Object?>> itemcodelist =
  //           await DBOperation.Itemcodeserialbatch(db, sBatch);
  //       for (int ia = 0; ia < itemcodelist.length; ia++) {
  //         // log("itemcodelist[ia]['itemcode']::" +
  //         // itemcodelist[ia]['itemcode'].toString());
  //         itemcodelistitem.add(ItemCodeListModel(
  //             ItemCode: itemcodelist[ia]['itemcode'].toString()));
  //       }
  //       notifyListeners();
  //       return Future.value(i);
  //     }
  //   }
  //   notifyListeners();
  //   return Future.value(null);
  // }

  // forItemCodecheck(BuildContext context, ThemeData theme) {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //             contentPadding: EdgeInsets.all(0),
  //             content: AlertBox(
  //                 payMent: "ItemCode",
  //                 widget: checkItemcode(context, theme),
  //                 buttonName: null));
  //       });
  //   notifyListeners();
  // }

  // Widget checkItemcode(BuildContext context, ThemeData theme) {
  //   final theme = Theme.of(context);
  //   return SizedBox(
  //     height: Screens.padingHeight(context) * 0.5,
  //     width: Screens.width(context) * 0.4, // Change as per your requirement
  //     child: ListView.builder(
  //         itemCount: itemcodelistitem.length,
  //         itemBuilder: (context, index) {
  //           return Card(
  //             child: Container(
  //               child: ListTile(
  //                 onTap: () {
  //                   clickItemcode(itemcodelistitem[index], context, theme);
  //                   Navigator.pop(context);
  //                 },
  //                 title: Container(
  //                     child: Text(
  //                   itemcodelistitem[index].ItemCode.toString(),
  //                 )),
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }

  // addScannedData(int ind, BuildContext context, ThemeData theme) async {
  //   if (scanneditemData.isEmpty) {
  //     //log("Add the data");
  //     addScndDataFst(ind, context, theme);
  //   } else {
  //     //log("Add the one more qty data");

  //     addScndData(ind, context, theme);
  //   }
  //   notifyListeners();
  // }

  // addScndData(int indx, BuildContext context, ThemeData theme) async {
  //   //log("Same serial batch");
  //   //log("Same serial batch1111::" + mycontroller[99].text.toString());

  //   int? ins = await checkSameSerialBatchScnd(
  //       mycontroller[99].text.toString().trim().toUpperCase());
  //   if (ins != null) {
  //     if (itemcodeitem != null) {
  //       int? inssx = await checkSameItemcode();
  //       if (inssx != null) {
  //         itemIncrement(inssx, context, theme);
  //       } else if (inssx == null) {
  //         addScndDataFst(indx, context, theme);
  //         notifyListeners();
  //       }
  //     } else {
  //       itemIncrement(ins, context, theme);
  //     }
  //   } else {
  //     addScndDataFst(indx, context, theme);
  //     notifyListeners();
  //   }
  // }

  Future<int?> checkSameSerialBatchScnd(String sBatch) async {
    //log("YYYYYYYYY:::" + sBatch);

    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].SerialBatch == sBatch) {
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  // Future<int?> checkSameItemcode() async {
  //   for (int i = 0; i < scanneditemData.length; i++) {
  //     if (scanneditemData[i].ItemCode == itemcodeitem!.ItemCode) {
  //       return Future.value(i);
  //     }
  //   }
  //   notifyListeners();
  //   return Future.value(null);
  // }

  // int? adddiscperunit;
  // addScndDataFst(int ind, BuildContext context, ThemeData theme) {
  //   scanneditemData.add(StocksnapModelData(
  //       TransID: itemData[ind].TransID,
  //       Branch: itemData[ind].Branch,
  //       ItemCode: itemcodeitem != null
  //           ? itemcodeitem!.ItemCode
  //           : itemData[ind].ItemCode,
  //       // itemData[ind].ItemCode,
  //       ItemName: itemData[ind].ItemName,
  //       SerialBatch: itemData[ind].SerialBatch,
  //       OpenQty: itemData[ind].Qty,
  //       Qty: 1,
  //       InDate: itemData[ind].InDate,
  //       InType: itemData[ind].InType,
  //       VenCode: itemData[ind].VenCode,
  //       VenName: itemData[ind].VenName,
  //       MRP: itemData[ind].MRP,
  //       SellPrice: itemData[ind].SellPrice,
  //       Cost: itemData[ind].Cost,
  //       TaxRate: itemData[ind].TaxRate,
  //       TaxType: itemData[ind].TaxType,
  //       discount: itemData[ind].discount,
  //       basic: itemData[ind].basic,
  //       netvalue: itemData[ind].netvalue,
  //       taxvalue: itemData[ind].taxvalue,
  //       Maxdiscount: itemData[ind].Maxdiscount,
  //       createdUserID: '',
  //       createdateTime: '',
  //       lastupdateIp: '',
  //       purchasedate: '',
  //       snapdatetime: '',
  //       specialprice: 0,
  //       updatedDatetime: '',
  //       updateduserid: '',
  //       discountper: double.parse(itemData[ind].Maxdiscount.toString()),
  //       liter: double.parse(itemData[ind].liter.toString()),
  //       weight: double.parse(itemData[ind].weight.toString())));
  //   notifyListeners();

  //   // qtymycontroller[ind].text = scanneditemData[ind].Qty.toString();

  //   // qtychangemtd(
  //   //   scanneditemData.length - 1,
  //   // );
  //   FocusScopeNode focus = FocusScope.of(context);

  //   if (!focus.hasPrimaryFocus) {
  //     focus.unfocus();
  //   }
  //   notifyListeners();
  //   calCulateDocVal(context, theme);

  //   focusnode[0].requestFocus();
  // }

  // addScndDataFstItemcode(int ind, BuildContext context, ThemeData theme) {
  //   scanneditemData.add(StocksnapModelData(
  //       TransID: itemData[ind].TransID,
  //       Branch: itemData[ind].Branch,
  //       ItemCode: itemcodeitem!.ItemCode,
  //       // itemData[ind].ItemCode,
  //       ItemName: itemData[ind].ItemName,
  //       SerialBatch: itemData[ind].SerialBatch,
  //       OpenQty: itemData[ind].OpenQty,
  //       Qty: 1,
  //       InDate: itemData[ind].InDate,
  //       InType: itemData[ind].InType,
  //       VenCode: itemData[ind].VenCode,
  //       VenName: itemData[ind].VenName,
  //       MRP: itemData[ind].MRP,
  //       SellPrice: itemData[ind].SellPrice,
  //       Cost: itemData[ind].Cost,
  //       TaxRate: itemData[ind].TaxRate,
  //       TaxType: itemData[ind].TaxType,
  //       discount: itemData[ind].discount,
  //       basic: itemData[ind].basic,
  //       netvalue: itemData[ind].netvalue,
  //       taxvalue: itemData[ind].taxvalue,
  //       Maxdiscount: itemData[ind].Maxdiscount,
  //       createdUserID: '',
  //       createdateTime: '',
  //       lastupdateIp: '',
  //       purchasedate: '',
  //       snapdatetime: '',
  //       specialprice: 0,
  //       updatedDatetime: '',
  //       updateduserid: '',
  //       discountper: double.parse(itemData[ind].Maxdiscount.toString()),
  //       liter: double.parse(itemData[ind].liter.toString()),
  //       weight: double.parse(itemData[ind].weight.toString())));
  //   notifyListeners();

  //   // qtymycontroller[ind].text = scanneditemData[ind].Qty.toString();

  //   // qtychangemtd(
  //   //   scanneditemData.length - 1
  //   // );
  //   FocusScopeNode focus = FocusScope.of(context);

  //   if (!focus.hasPrimaryFocus) {
  //     focus.unfocus();
  //   }
  //   notifyListeners();
  //   // paymentDetails();
  //   calCulateDocVal(context, theme);
  //   // qtymycontroller[ind].text="1";

  //   focusnode[0].requestFocus();
  // }

  ////
  ///

  int i = 1;

  int get geti => i;

  itemIncrement(int ind, BuildContext context, ThemeData theme) {
    int qtyctrl = int.parse(qtymycontroller[ind].text);
    //log("data qty greater111");

    for (int i = 0; i < itemData.length; i++) {
      //log("data qty greater2222");
      if (itemData[i].SerialBatch == scanneditemData[ind].SerialBatch) {
        if (itemData[i].Qty! >= qtyctrl) {
          //log("data qty greater::" + itemData[i].Qty.toString());
          qtyctrl = qtyctrl + 1;
          //log("qtyctrlqtyctrl::" + qtyctrl.toString());
          qtymycontroller[ind].text = qtyctrl.toString();
          FocusScopeNode focus = FocusScope.of(context);
          calCulateDocVal(context, theme);

          if (!focus.hasPrimaryFocus) {
            focus.unfocus();
          }
          focusnode[0].requestFocus();
          notifyListeners();
          break;
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

  setstate1() {
    notifyListeners();
  }

  itemIncrement11(int ind, BuildContext context, ThemeData theme) {
    for (int i = 0; i < itemData.length; i++) {
      int qtyctrl = 0;

      // // log("-----scanitemdate"+scanneditemData[ind].SerialBatch.toString());
      if (itemData[i].SerialBatch == scanneditemData[ind].SerialBatch) {
        //log("-----itemData[i].Qty:" + itemData[i].Qty.toString());

        if (itemData[i].ItemCode == scanneditemData[ind].ItemCode) {
          qtyctrl = int.parse(qtymycontroller[ind].text.toString());
          //log("-----index qty" + qtymycontroller[ind].text.toString());

          //log("-----itemdata:" + itemData[i].SerialBatch.toString());

          //log("scanneditemData[ind].SerialBatch::" +
          //     scanneditemData[ind].SerialBatch.toString());
          if (qtyctrl != 0) {
            if (itemData[i].Qty! >= qtyctrl) {
              //log("---------------------MMMMM----------------------------");

              //log("data qty greater::" + qtyctrl.toString());

              //log("qtyctrl::" + qtyctrl.toString());
              qtymycontroller[ind].text = qtyctrl.toString();
              calCulateDocVal(context, theme);
              //   FocusScopeNode focus = FocusScope.of(context);
              // if (!focus.hasPrimaryFocus) {
              //   focus.unfocus();
              // }
              notifyListeners();
              // break;
            } else {
              qtymycontroller[ind].text = '';
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

              // break;
            }
          } else if (qtyctrl == 0) {
            //log("KKKKKKKKKKKKKK::" + ind.toString());
            //log("----------------" + qtymycontroller[ind].text);
            qtymycontroller.removeAt(ind);
            scanneditemData.removeAt(ind);

            calCulateDocVal(context, theme);

            notifyListeners();
          }
        }
      }
    }
    notifyListeners();
  }

  itemdecrement(BuildContext context, ThemeData theme, int ind) {
    int qtyctrl = int.parse(qtymycontroller[ind].text);

    if (qtyctrl > 0) {
      qtyctrl = qtyctrl - 1;
      qtymycontroller[ind].text = qtyctrl.toString();
      notifyListeners();
    } else {
      scanneditemData.removeAt(ind);
      mycontroller[ind].text = '';
      notifyListeners();
    }
    calCulateDocVal(context, theme);
  }

  /// customer

  custSelected(CustomerDetals customerDetals, BuildContext context,
      ThemeData theme) async {
    selectedcust = null;
    selectedcust55 = null;
    selectedBillAdress = 0;
    selectedShipAdress = 0;
    double? updateCustBal;
    loadingscrn = true;
    holddocentry = '';

    selectedcust = CustomerDetals(
        autoId: customerDetals.autoId,
        name: customerDetals.name,
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        // accBalance: customerDetals.accBalance,
        point: customerDetals.point,
        address: [],
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '');

    selectedcust55 = CustomerDetals(
        autoId: customerDetals.autoId,
        name: customerDetals.name,
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        // accBalance: customerDetals.accBalance,
        point: customerDetals.point,
        address: [],
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '');
    notifyListeners();
    for (int i = 0; i < customerDetals.address!.length; i++) {
      if (customerDetals.address![i].addresstype == "B") {
        selectedcust!.address!.add(Address(
            autoId: customerDetals.address![i].autoId,
            addresstype: customerDetals.address![i].addresstype,
            address1: customerDetals.address![i].address1,
            address2: customerDetals.address![i].address2,
            address3: customerDetals.address![i].address3,
            billCity: customerDetals.address![i].billCity,
            billCountry: customerDetals.address![i].billCountry,
            billPincode: customerDetals.address![i].billPincode,
            billstate: customerDetals.address![i].billstate));
        notifyListeners();
      }
      //log("selectedcust.address1::${selectedcust!.address!.length}");

      if (customerDetals.address![i].addresstype == "S") {
        selectedcust55!.address!.add(Address(
            autoId: customerDetals.address![i].autoId,
            addresstype: customerDetals.address![i].addresstype,
            address1: customerDetals.address![i].address1,
            address2: customerDetals.address![i].address2,
            address3: customerDetals.address![i].address3,
            billCity: customerDetals.address![i].billCity,
            billCountry: customerDetals.address![i].billCountry,
            billPincode: customerDetals.address![i].billPincode,
            billstate: customerDetals.address![i].billstate));
        //log("selectedcust55.address1::${selectedcust55!.address!.length}");
      }
      notifyListeners();
    }
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
    addCardCode = selectedcust!.cardCode.toString();
    selectedcust!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    selectedcust55!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    await callgetSQValue(context, theme);

//  checkcashcust() ;
    notifyListeners();
  }

  billaddresslist() {
    billadrrssItemlist = [];
    //log("selectedcust address lenght ZZZZ:::${selectedcust!.address!.length}");
    if (selectedcust != null) {
      for (int i = 0; i < selectedcust!.address!.length; i++) {
        //log("selectedcust!.address!.type AAAA::${selectedcust!.address![i].addresstype}");

        billadrrssItemlist.add(Address(
            addresstype: selectedcust!.address![i].addresstype,
            address1: selectedcust!.address![i].address1,
            address2: selectedcust!.address![i].address2,
            address3: selectedcust!.address![i].address3,
            billCity: selectedcust!.address![i].billCity,
            billCountry: selectedcust!.address![i].billCountry,
            billPincode: selectedcust!.address![i].billPincode,
            billstate: selectedcust!.address![i].billstate));
      }
      notifyListeners();
    }
    notifyListeners();
  }

  shippinfaddresslist() {
    shipadrrssItemlist = [];

    if (selectedcust55 != null) {
      for (int i = 0; i < selectedcust55!.address!.length; i++) {
        //log("selectedcust55!.address![i].addresstype::${selectedcust55!.address![0].addresstype.toString()}");

        if (selectedcust55!.address![i].addresstype == "S") {
          //log("selectedcust55!.address!.typeXXbbb::${selectedcust55!.address!.length.toString()}");

          shipadrrssItemlist.add(Address(
              addresstype: selectedcust55!.address![i].addresstype,
              address1: selectedcust55!.address![i].address1,
              address2: selectedcust55!.address![i].address2,
              address3: selectedcust55!.address![i].address3,
              billCity: selectedcust55!.address![i].billCity,
              billCountry: selectedcust55!.address![i].billCountry,
              billPincode: selectedcust55!.address![i].billPincode,
              billstate: selectedcust55!.address![i].billstate));
          //log("shipadrrssItemlist::${shipadrrssItemlist.length}");
          notifyListeners();
        }
      }

      notifyListeners();
    }
    notifyListeners();
  }

  clearData() {
    holddocentry = '';
    selectedcust = null;
    selectedcust55 = null;
    notifyListeners();
  }

  refresCufstList() async {
    filtercustList = custList;

    notifyListeners();
  }

  filterList(String v) async {
    if (v.isNotEmpty) {
      filtercustList = custList
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.name!.toLowerCase().contains(v.toLowerCase()))
          .toList();

      notifyListeners();
    } else if (v.isEmpty) {
      filtercustList = custList;

      notifyListeners();
    }
  }

  String addCardCode = '';
  CreateNewBillAdd() async {
    // final Database db = await dbHelper.createDB();
    final Database db = (await DBHelper.getInstance())!;
    addCardCode = selectedcust!.cardCode.toString();
    print("New Created address CardCode:$addCardCode");

    List<CustomerAddressModelDB> createnewcsaddDB =
        await DBOperation.createNewgetCstmMasAddDB(db, addCardCode);
    List<Address> address555 = [];
// createnewcsaddDB.length - 1
    // for (int i = 0; i < custList.length; i++) {
    for (int ia = 0; ia < createnewcsaddDB.length; ia++) {
      if (selectedcust!.cardCode == createnewcsaddDB[ia].custcode) {
        //log("New objectobjectobject::${createnewcsaddDB.length.toString()}");
        if (createnewcsaddDB[ia].addresstype == "B") {
          selectedcust!.address!.add(Address(
              autoId: int.parse(createnewcsaddDB[ia].autoid.toString()),
              addresstype: createnewcsaddDB[ia].addresstype,
              address1: createnewcsaddDB[ia].address1!,
              address2: createnewcsaddDB[ia].address2!,
              address3: createnewcsaddDB[ia].address3!,
              billCity: createnewcsaddDB[ia].city.toString(),
              billCountry: createnewcsaddDB[ia].countrycode.toString(),
              billPincode: createnewcsaddDB[ia].pincode.toString(),
              billstate: createnewcsaddDB[ia].statecode.toString()));
        }
        if (createnewcsaddDB[ia].addresstype == "S") {
          selectedcust55!.address!.add(Address(
              autoId: int.parse(createnewcsaddDB[ia].autoid.toString()),
              addresstype: createnewcsaddDB[ia].addresstype,
              address1: createnewcsaddDB[ia].address1!,
              address2: createnewcsaddDB[ia].address2!,
              address3: createnewcsaddDB[ia].address3!,
              billCity: createnewcsaddDB[ia].city.toString(),
              billCountry: createnewcsaddDB[ia].countrycode.toString(),
              billPincode: createnewcsaddDB[ia].pincode.toString(),
              billstate: createnewcsaddDB[ia].statecode.toString()));
        }

        //log("selectedcust!.address!.length::${selectedcust!.address!.length}");
        selectedBillAdress = (selectedcust!.address!.length - 1);
        selectedShipAdress = (selectedcust55!.address!.length - 1);
        notifyListeners();
        print(selectedcust!.address);
        // }
      }
    }

    notifyListeners();
  }

  callShipAddressPostApi(BuildContext context) async {
    loadingBtn = true;
    await await sapOrderLoginApi(context);
    (context);
//log("App constatant fff ::::${AppConstant.sapSessionID}");
    NewAddressModel? newAddModel = NewAddressModel();
    newAddModel!.newModel = [
      NewCutomeAdrsModel(
        AddressName: mycontroller[14].text,
        AddressName2: mycontroller[15].text,
        AddressName3: mycontroller[16].text,
        AddressType: 'bo_ShipTo',
        City: mycontroller[17].text,
        Country: "TZ", //mycontroller[20].text,
        State: '', // mycontroller[19].text,
        Street: '',
        ZipCode: mycontroller[18].text,
      ),
    ];
    final Database db = (await DBHelper.getInstance())!;

    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertsipCreatenewAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustshipaddresslist(
          context,
        );
        loadingBtn = false;
        config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingBtn = false;

        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        loadingBtn = false;
      }
    });
    notifyListeners();
  }

  callBillAddressPostApi(BuildContext context) async {
    loadingBtn = true;
    await await sapOrderLoginApi(context);
    (context);
//log("App constatant fff ::::${AppConstant.sapSessionID}");
    NewAddressModel? newAddModel = NewAddressModel();

    newAddModel.newModel = [
      NewCutomeAdrsModel(
        AddressName: mycontroller[7].text,
        AddressName2: mycontroller[8].text,
        AddressName3: mycontroller[9].text,
        AddressType: 'bo_BillTo',
        City: mycontroller[10].text,
        Country: "TZ", //mycontroller[13].text,
        State: '', //mycontroller[12].text,
        Street: '',
        ZipCode: mycontroller[11].text,
      ),
    ];
    final Database db = (await DBHelper.getInstance())!;

    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertbillCreatenewAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustBilladdresslist(
          context,
        );
        loadingBtn = false;
        config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");

        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingBtn = false;

        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        loadingBtn = false;
      }
    });
    notifyListeners();
  }

  callAddressPostApi(BuildContext context) async {
    loadingBtn = true;
    await sapOrderLoginApi(context);
    (context);
//log("App constatant fff ::::${AppConstant.sapSessionID}");
    NewAddressModel? newAddModel = NewAddressModel();

    newAddModel.newModel = [
      NewCutomeAdrsModel(
        AddressName: mycontroller[7].text,
        AddressName2: mycontroller[8].text,
        AddressName3: mycontroller[9].text,
        AddressType: 'bo_BillTo',
        City: mycontroller[10].text,
        Country: "TZ", //mycontroller[13].text,
        State: '', //mycontroller[12].text,
        Street: '',
        ZipCode: mycontroller[11].text,
      ),
      NewCutomeAdrsModel(
        AddressName: mycontroller[14].text,
        AddressName2: mycontroller[15].text,
        AddressName3: mycontroller[16].text,
        AddressType: 'bo_ShipTo',
        City: mycontroller[17].text,
        Country: "TZ", //mycontroller[20].text,
        State: '', // mycontroller[19].text,
        Street: '',
        ZipCode: mycontroller[18].text,
      ),
    ];
    final Database db = (await DBHelper.getInstance())!;

    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertbillCreatenewAddress();
        await insertsipCreatenewAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();

        await getcustBilladdresslist(
          context,
        );

        await getcustshipaddresslist(
          context,
        );
        //log('JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ:::${shipcreateNewAddress.length}');
        loadingBtn = false;
        config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingBtn = false;

        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        loadingBtn = false;
      }
    });
    notifyListeners();
  }

  // callAddressPostApi(BuildContext context) async {
  //   loadingBtn = true;

  //   await sapOrderLoginApi(context);
  //   log("App constatant fff ::::${AppConstant.sapSessionID}");
  //   NewAddressModel? newAddModel = NewAddressModel();
  //   newAddModel!.newModel = [
  //     NewCutomeAdrsModel(
  //       AddressName: mycontroller[7].text,
  //       AddressName2: mycontroller[8].text,
  //       AddressName3: mycontroller[9].text,
  //       AddressType: 'bo_BillTo',
  //       City: mycontroller[10].text,
  //       Country: "TZ", //mycontroller[13].text,
  //       State: '', //mycontroller[12].text,
  //       Street: '',
  //       ZipCode: mycontroller[11].text,
  //     ),
  //     NewCutomeAdrsModel(
  //       AddressName: mycontroller[14].text,
  //       AddressName2: mycontroller[15].text,
  //       AddressName3: mycontroller[16].text,
  //       AddressType: 'bo_ShipTo',
  //       City: mycontroller[17].text,
  //       Country: "TZ", //mycontroller[20].text,
  //       State: '', // mycontroller[19].text,
  //       Street: '',
  //       ZipCode: mycontroller[18].text,
  //     ),
  //   ];
  //   PostAddressCreateAPi.newCutomerAddModel = newAddModel;
  //   await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
  //       .then((value) {
  //     loadingBtn = false;
  //     if (value.statusCode! >= 200 && value.statusCode! <= 210) {
  //       cardCodexx = value.statusCode.toString();
  //       // Navigator.pop(context);
  //       config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");
  //       notifyListeners();
  //     } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
  //       config
  //           .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
  //           .then((value) => Navigator.pop(context));
  //     } else {
  //       config.showDialogg("Something went wrong try agian..!!", "Failed");
  //     }
  //   });
  //   notifyListeners();
  // }

  insertnewshipaddresscreation(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    loadingBtn = true;
    if (formkeyShipAd.currentState!.validate()) {
      if (checkboxx == true) {
        //log("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        await callAddressPostApi(context);
        notifyListeners();
      } else {
        await callShipAddressPostApi(context);
        notifyListeners();
      }

      notifyListeners();
    } else {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: textError,
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        loadingBtn = false;
        notifyListeners();
      });
    }
    notifyListeners();

    // getCustDetFDB();
  }

  insertnewbiladdresscreation(BuildContext context, ThemeData theme) async {
    loadingBtn = true;

    final Database db = (await DBHelper.getInstance())!;
    if (formkeyAd.currentState!.validate()) {
      //log('shipcreateNewAddressshipcreateNewAddress:::::$checkboxx');

      if (checkboxx == true) {
        //log("(VVVVVVVVVVVVVVV:::${mycontroller[14].text}");
        await callAddressPostApi(context);
        notifyListeners();
      } else {
        await callBillAddressPostApi(context);
        notifyListeners();
      }

      notifyListeners();
    } else {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: textError,
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        loadingBtn = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  insertbillCreatenewAddress() async {
    final Database db = (await DBHelper.getInstance())!;
    billcreateNewAddress = [];
    if (mycontroller[7].text.isNotEmpty) {
      billcreateNewAddress.add(CustomerAddressModelDB(
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        lastupdateIp: '1',
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.lastUpdateIp.toString(),
        address1: mycontroller[7].text,
        address2: mycontroller[8].text,
        address3: mycontroller[9].text,
        city: mycontroller[10].text,
        countrycode: mycontroller[13].text,
        custcode: selectedcust!.cardCode,
        // mycontroller[77].text,
        geolocation1: '',
        geolocation2: '',
        statecode: mycontroller[12].text,
        pincode: mycontroller[11].text,
        branch: UserValues.branch.toString(),
        terminal: UserValues.terminal,
        addresstype: 'B',
      ));
    }

    if (billcreateNewAddress.isNotEmpty) {
      await DBOperation.insertCustomerAddress(db, billcreateNewAddress);
    }
  }

  insertsipCreatenewAddress() async {
    final Database db = (await DBHelper.getInstance())!;
    shipcreateNewAddress = [];
    if (mycontroller[14].text.isNotEmpty) {
      shipcreateNewAddress.add(CustomerAddressModelDB(
        custcode: selectedcust55!.cardCode,

        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        lastupdateIp: '1',
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.lastUpdateIp.toString(),
        address1: mycontroller[14].text,
        address2: mycontroller[15].text,
        address3: mycontroller[16].text,
        city: mycontroller[17].text,
        countrycode: mycontroller[20].text,
        // mycontroller[77].text,
        geolocation1: '',
        geolocation2: '',
        statecode: mycontroller[19].text,
        pincode: mycontroller[18].text,
        branch: UserValues.branch.toString(),
        terminal: UserValues.terminal,
        addresstype: 'S',
      ));
    }

    if (shipcreateNewAddress.isNotEmpty) {
      await DBOperation.insertCustomerAddress(db, shipcreateNewAddress);
    }
    //log("selectedcust address lenghtXXX:::${selectedcust!.address!.length}");
    //log("selectedcust55 address lenghtYYY:::${selectedcust55!.address!.length}");

    //log("Inserted New Created Address");

    notifyListeners();
  }

//  {autoid: 1756, custcode: B2222, addresstype: B, address1: ttttttt, address2: aaaaaa, address3: sssss, city: rrrrr,
// statecode: tn, pincode: 333333, countrycode: xcgyjjj, geolocation1: , geolocation2: , branch: HOFG, terminal: T2,
//createdateTime: 1, UpdatedDatetime: 2023-08-09 15:14:05, createdUserID: 1, updateduserid: 192.198.182.1,
//lastupdateIp: 1}
  changeBillAddress(int slcAdrs) {
    selectedBillAdress = slcAdrs;
    notifyListeners();
  }

  changeShipAddress(int slcAdrs) {
    selectedShipAdress = slcAdrs;
    notifyListeners();
  }

  billToShip(bool dat) {
    //checkboxx = dat;
    notifyListeners();
    if (checkboxx == true) {
      mycontroller[14].text = mycontroller[7].text; //bill add1
      mycontroller[15].text = mycontroller[8].text; //bill add2
      mycontroller[16].text = mycontroller[9].text; //bill add3
      mycontroller[17].text = mycontroller[10].text; //city
      mycontroller[18].text = mycontroller[11].text; //pin
      mycontroller[19].text = mycontroller[12].text; //state
      mycontroller[20].text = mycontroller[13].text; //country
    } else {
      mycontroller[14].clear();
      mycontroller[15].clear();
      mycontroller[16].clear();
      mycontroller[17].clear();
      mycontroller[18].clear();
      mycontroller[19].clear();
      mycontroller[20].clear();
    }
    notifyListeners();
  }

  shipToBill(bool dat) {
    //checkboxx = dat;
    notifyListeners();
    if (checkboxx == true) {
      mycontroller[7].text = mycontroller[14].text; //bill add1
      mycontroller[8].text = mycontroller[15].text; //bill add2
      mycontroller[9].text = mycontroller[16].text; //bill add3
      mycontroller[10].text = mycontroller[17].text; //city
      mycontroller[11].text = mycontroller[18].text; //pin
      mycontroller[12].text = mycontroller[19].text; //state
      mycontroller[13].text = mycontroller[20].text; //country
    } else {
      mycontroller[7].clear();
      mycontroller[8].clear();
      mycontroller[9].clear();
      mycontroller[10].clear();
      mycontroller[11].clear();
      mycontroller[12].clear();
      mycontroller[13].clear();
    }
    notifyListeners();
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  validateformkey(
    int ij,
  ) {
    // print("ij.toString():$ij");
    if (formkey[ij].currentState!.validate()) {
      // print("validate the Customer formkey");
      notifyListeners();
    }
    notifyListeners();
  }

  createnewchagescustaddres(
      BuildContext context, ThemeData theme, int ij) async {
    final Database db = (await DBHelper.getInstance())!;

    await addnewCustomer(context, theme, ij);
    // await DBOperation.getdata(db);
    await getCustDetFDB();
    await getNewCustandadd(context);
    notifyListeners();
  }

  String vatfileError = '';
  String tinfileError = '';
  addnewCustomer(BuildContext context, ThemeData theme, int ij) async {
    final Database db = (await DBHelper.getInstance())!;

    int sucesss = 0;
    vatfileError = '';
    tinfileError = '';
    textError = '';

    if (formkey[ij].currentState!.validate()) {
      sucesss = sucesss + 1;
    }

    if (formkeyAd.currentState!.validate()) {
      sucesss = sucesss + 1;
      notifyListeners();
    }

    if (sucesss == 2) {
      if (tinFiles == null) {
        print('XXXXXXXXXXXXXXXXXXXX');
        fileValidation = true;
        tinfileError = "Select a Tin file";
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: tinfileError,
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          loadingBtn = false;
          // tinfileError = '';
          notifyListeners();
        });

        notifyListeners();
      } else if (vatFiles == null) {
        fileValidation = true;
        vatfileError = 'Select a Vat File';
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: vatfileError,
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          loadingBtn = false;
          // vatfileError = '';
          notifyListeners();
        });

        notifyListeners();
      } else {
        fileValidation = false;
        notifyListeners();
      }

      await callPostApi(context, theme);
      await insertAddNewCusToDB(context);

      Navigator.pop(context);

      notifyListeners();
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
                    content: textError,
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
    notifyListeners();
  }

  getNewCustandadd(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    selectedcust = null;
    selectedcust55 = null;
    mycontroller[3].text = mycontroller[3].text.isNotEmpty
        ? mycontroller[3].text.toString()
        : cardCodexx.toString();
    //log("mycontroller[3].text.toString()::${mycontroller[3].text}");
    List<Map<String, Object?>> newcusdataDB =
        await DBOperation.getCstmMasDatabyautoid(
            db, mycontroller[3].text.toString());
    List<Map<String, Object?>> newaddrssdataDB =
        await DBOperation.addgetCstmMasAddDB(
            db, mycontroller[3].text.toString());
    for (int i = 0; i < newcusdataDB.length; i++) {
      //log('step:1');
      selectedcust = CustomerDetals(
          autoId: newcusdataDB[i]['autoid'].toString(),
          cardCode: newcusdataDB[i]['customercode'].toString(),
          name: newcusdataDB[i]['customername'].toString(),
          phNo: newcusdataDB[i]['phoneno1'].toString(),
          accBalance: double.parse(newcusdataDB[i]['balance'].toString()),
          point: newcusdataDB[i]['points'].toString(),
          tarNo: newcusdataDB[i]['taxno'].toString(),
          email: newcusdataDB[i]['emalid'].toString(),
          invoicenum: '',
          invoiceDate: '',
          totalPayment: 00,
          address: []);
      notifyListeners();
      selectedcust55 = CustomerDetals(
          autoId: newcusdataDB[i]['autoid'].toString(),
          cardCode: newcusdataDB[i]['customercode'].toString(),
          name: newcusdataDB[i]['customername'].toString(),
          phNo: newcusdataDB[i]['phoneno1'].toString(),
          accBalance: double.parse(newcusdataDB[i]['balance'].toString()),
          point: newcusdataDB[i]['points'].toString(),
          tarNo: newcusdataDB[i]['taxno'].toString(),
          email: newcusdataDB[i]['emalid'].toString(),
          invoicenum: '',
          invoiceDate: '',
          totalPayment: 00,
          address: []);
      notifyListeners();
    }

    if (newaddrssdataDB.isNotEmpty) {
      for (int ik = 0; ik < newaddrssdataDB.length; ik++) {
        //log("newaddrssdataDB.cardcode::${newaddrssdataDB[ik]['custcode']}");

        if (newaddrssdataDB[ik]['addresstype'].toString() == "B") {
          selectedcust!.address!.add(
            Address(
              autoId: int.parse(newaddrssdataDB[ik]['autoid'].toString()),
              addresstype: newaddrssdataDB[ik]['addresstype'].toString(),
              address1: newaddrssdataDB[ik]['address1'].toString(),
              address2: newaddrssdataDB[ik]['address2'].toString(),
              address3: newaddrssdataDB[ik]['address3'].toString(),
              billCity: newaddrssdataDB[ik]['city'].toString(),
              billCountry: newaddrssdataDB[ik]['countrycode'].toString(),
              billPincode: newaddrssdataDB[ik]['pincode'].toString(),
              billstate: newaddrssdataDB[ik]['statecode'].toString(),
            ),
          );
          notifyListeners();

          //log('step:3');
        }

        if (newaddrssdataDB[ik]['addresstype'].toString() == "S") {
          selectedcust55!.address!.add(
            Address(
              autoId: int.parse(newaddrssdataDB[ik]['autoid'].toString()),
              addresstype: newaddrssdataDB[ik]['addresstype'].toString(),
              address1: newaddrssdataDB[ik]['address1'].toString(),
              address2: newaddrssdataDB[ik]['address2'].toString(),
              address3: newaddrssdataDB[ik]['address3'].toString(),
              billCity: newaddrssdataDB[ik]['city'].toString(),
              billCountry: newaddrssdataDB[ik]['countrycode'].toString(),
              billPincode: newaddrssdataDB[ik]['pincode'].toString(),
              billstate: newaddrssdataDB[ik]['statecode'].toString(),
            ),
          );
        }

        selectedBillAdress = selectedcust!.address!.length - 1;
        selectedShipAdress = selectedcust55!.address!.length - 1;
      }
    }
    //log("selectedcust!.address!.length 2233:::${selectedcust!.address!.length}");
    notifyListeners();
  }

  String? custautoid;
  insertAddNewCusToDB(
    BuildContext context,
  ) async {
    print("lastUpdateIp::-----${UserValues.lastUpdateIp}");
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    newCustValues = [];
    custautoid = '';
    final Database db = (await DBHelper.getInstance())!;
    newCustValues.add(CustomerModelDB(
        customerCode:
            mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        // UserValues.lastUpdateIp != null
        //     ? int.parse(UserValues.lastUpdateIp.toString())
        //     : 0,
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID,
        balance: 0,
        createdbybranch: UserValues.branch,
        customertype: '',
        customername:
            mycontroller[6].text.isNotEmpty ? mycontroller[6].text : '',
        emalid: mycontroller[21].text.isNotEmpty ? mycontroller[21].text : '',
        phoneno1: mycontroller[4].text.isNotEmpty ? mycontroller[4].text : '',
        phoneno2: "",
        points: 0,
        premiumid: '',
        snapdatetime: config.currentDate(),
        taxno: mycontroller[5].text.isNotEmpty
            ? mycontroller[5].text.toString()
            : '',
        terminal: UserValues.terminal,
        tinNo: '',
        vatregno: ''));
    notifyListeners();
    // if (mycontroller[3].text.isEmpty) {
    //   log(" step:1");
    //   await DBOperation.insertCustomer(db, newCustValues);
    //   List<CustomerModelDB> newcusdataDB = await DBOperation.getCstmMasDB(db);
    //   log(" step:21");
    //   custautoid = newcusdataDB[newcusdataDB.length - 1].autoid.toString();
    //   log("newcusdataDB autoid:::" +
    //       newcusdataDB[newcusdataDB.length - 1].autoid.toString());

    //   List<Map<String, Object?>> updatenewcardcode =
    //       await DBOperation.updateCustomerDetailstocrdcode(
    //           db, newcusdataDB[newcusdataDB.length - 1].autoid.toString());
    //   log(" step:3");
    //   notifyListeners();
    // } else {
    //   await DBOperation.insertCustomer(db, newCustValues);
    //   notifyListeners();
    // }
    newBillAddrsValue.add(CustomerAddressModelDB(
      countrycode:
          mycontroller[13].text.isNotEmpty ? mycontroller[13].text : '',
      createdUserID: "1",
      createdateTime: config.currentDate(),
      lastupdateIp: '1',
      updatedDatetime: config.currentDate(),
      updateduserid: '1',
      address1: mycontroller[7].text.isNotEmpty ? mycontroller[7].text : '',
      address2: mycontroller[8].text.isNotEmpty ? mycontroller[8].text : '',
      address3: mycontroller[9].text.isNotEmpty ? mycontroller[9].text : '',
      city: mycontroller[10].text.isNotEmpty ? mycontroller[10].text : '',
      custcode:
          mycontroller[3].text.isEmpty ? custautoid : mycontroller[3].text,
      // mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
      geolocation1: '',
      geolocation2: '',
      statecode: mycontroller[12].text.isNotEmpty ? mycontroller[12].text : '',
      pincode: mycontroller[11].text.isNotEmpty ? mycontroller[11].text : '',
      branch: UserValues.branch,
      terminal: UserValues.terminal,
      addresstype: 'B',
    ));
    newShipAddrsValue.add(CustomerAddressModelDB(
      custcode:
          mycontroller[3].text.isEmpty ? custautoid : mycontroller[3].text,

      //  mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
      createdUserID: "1",
      createdateTime: config.currentDate(),
      lastupdateIp: '1',
      updatedDatetime: config.currentDate(),
      updateduserid: '1',
      address1: mycontroller[14].text.isNotEmpty ? mycontroller[14].text : '',
      address2: mycontroller[15].text.isNotEmpty ? mycontroller[15].text : '',
      address3: mycontroller[16].text.isNotEmpty ? mycontroller[16].text : '',
      city: mycontroller[17].text.isNotEmpty ? mycontroller[17].text : '',
      countrycode:
          mycontroller[20].text.isNotEmpty ? mycontroller[20].text : '',
      geolocation1: '',
      geolocation2: '',
      statecode: mycontroller[19].text.isNotEmpty ? mycontroller[19].text : '',
      pincode: mycontroller[18].text.isNotEmpty ? mycontroller[18].text : '',
      branch: UserValues.branch,
      terminal: UserValues.terminal,
      addresstype: 'S',
    ));

    int newadd = 0;
    if (newBillAddrsValue.isNotEmpty) {
      newadd = newadd + 1;
    }
    if (newShipAddrsValue.isNotEmpty) {
      newadd = newadd + 1;
    }
    if (newadd == 2) {
      await DBOperation.insertCustomer(db, newCustValues);
      await DBOperation.insertCustomerAddress(db, newBillAddrsValue);
      await DBOperation.insertCustomerAddress(db, newShipAddrsValue);
      List<CustomerModelDB> newcusdataDB = await DBOperation.getCstmMasDB(db);
      List<CustomerAddressModelDB> newcusAddrssdataDB =
          await DBOperation.getCstmMasAddDB(db);
      //log(" step:21");
      // custautoid = newcusdataDB[newcusdataDB.length - 1].autoid.toString();
      //log("newcusdataDB autoid:::" +
      // newcusdataDB[newcusdataDB.length - 1].autoid.toString());

      await DBOperation.updateCustomerDetailstocrdcode(db, cardCodexx,
          newcusdataDB[newcusdataDB.length - 1].autoid.toString());
      print(
          "newcusAddrssdataDB[newcusAddrssdataDB.length-1].autoid::${newcusAddrssdataDB[newcusAddrssdataDB.length - 1].autoid.toString()}");
      print(
          "newcusAddrssdataDB[newcusAddrssdataDB.length-2].autoid::${newcusAddrssdataDB[newcusAddrssdataDB.length - 2].autoid.toString()}");
      await DBOperation.updateCustAddrsscrdcode(db, cardCodexx,
          newcusAddrssdataDB[newcusAddrssdataDB.length - 2].autoid.toString());
      await DBOperation.updateCustAddrsscrdcode(db, cardCodexx,
          newcusAddrssdataDB[newcusAddrssdataDB.length - 1].autoid.toString());
    }
    notifyListeners();
  }

  mapUpdateCustomer(int sInd) async {
    //log("selectedcust!.address![selectedBillAdress].autoId:${selectedcust!.address![selectedBillAdress].autoId}");
    //log("selectedcust!.address![selectedBillAdress].address2:${selectedcust!.address![selectedBillAdress].address2}and${selectedcust!.address![selectedBillAdress].address3}");

    mycontroller[3].text = selectedcust!.cardCode!;
    mycontroller[4].text = selectedcust!.phNo!;
    mycontroller[5].text = selectedcust!.tarNo!;
    mycontroller[6].text = selectedcust!.name!;
    mycontroller[21].text = selectedcust!.email!;
    mycontroller[7].text = selectedcust!.address![selectedBillAdress].address1!;
    mycontroller[8].text = selectedcust!.address![selectedBillAdress].address2!;
    mycontroller[9].text = selectedcust!.address![selectedBillAdress].address3!;
    mycontroller[10].text = selectedcust!.address![selectedBillAdress].billCity;
    mycontroller[11].text =
        selectedcust!.address![selectedBillAdress].billPincode;
    mycontroller[12].text =
        selectedcust!.address![selectedBillAdress].billstate;
    mycontroller[13].text =
        selectedcust!.address![selectedBillAdress].billCountry;
    mycontroller[14].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].address1 != null
        ? selectedcust55!.address![selectedShipAdress].address1!
        : '';
    mycontroller[15].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].address2 != null
        ? selectedcust55!.address![selectedShipAdress].address2!
        : '';
    mycontroller[16].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].address3 != null
        ? selectedcust55!.address![selectedShipAdress].address3!
        : '';

    mycontroller[17].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].billCity.isNotEmpty
        ? selectedcust55!.address![selectedShipAdress].billCity
        : "";

    mycontroller[18].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].billPincode.isNotEmpty
        ? selectedcust55!.address![selectedShipAdress].billPincode
        : '';
    mycontroller[19].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].billstate.isNotEmpty
        ? selectedcust55!.address![selectedShipAdress].billstate
        : "";
    mycontroller[20].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].billCountry.isNotEmpty
        ? selectedcust55!.address![selectedShipAdress].billCountry
        : '';
    // mycontroller[14].text =
    //     selectedcust55!.address![selectedShipAdress].address1!;
    // mycontroller[15].text =
    //     selectedcust55!.address![selectedShipAdress].address2!;
    // mycontroller[16].text =
    //     selectedcust55!.address![selectedShipAdress].address3!;

    // mycontroller[17].text =
    //     selectedcust55!.address![selectedShipAdress].billCity;

    // mycontroller[18].text =
    //     selectedcust55!.address![selectedShipAdress].billPincode;
    // mycontroller[19].text =
    //     selectedcust55!.address![selectedShipAdress].billstate;
    // mycontroller[20].text =
    //     selectedcust55!.address![selectedShipAdress].billCountry;
    notifyListeners();
  }

  updateAAAA(BuildContext context, ThemeData theme, int i, int ij) {
    if (formkey[6].currentState!.validate()) {
      updateCustomer(context, i, ij);
      Navigator.pop(context);

      notifyListeners();
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
                    content: textError,
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
      notifyListeners();
    }
    notifyListeners();
  }

  updateCustomer(BuildContext context, int i, int ij) async {
    final Database db = (await DBHelper.getInstance())!;
    String aId = selectedcust!.address![selectedBillAdress].autoId.toString();

// if(selectedcust!.address![selectedBillAdress].addresstype=='B'){
    // selectedcust!.cardCode = mycontroller[3].text;
    selectedcust!.phNo = mycontroller[4].text;
    selectedcust!.tarNo = mycontroller[5].text;
    selectedcust!.name = mycontroller[6].text;
    selectedcust!.email = mycontroller[21].text;

    selectedcust!.address![selectedBillAdress].address1 = mycontroller[7].text;
    selectedcust!.address![selectedBillAdress].address2 = mycontroller[8].text;
    selectedcust!.address![selectedBillAdress].address3 = mycontroller[9].text;
    selectedcust!.address![selectedBillAdress].billCity = mycontroller[10].text;

    selectedcust!.address![selectedBillAdress].billPincode =
        mycontroller[11].text;
    selectedcust!.address![selectedBillAdress].billstate =
        mycontroller[12].text;
    selectedcust!.address![selectedBillAdress].billCountry =
        mycontroller[13].text;

    // selectedcust55!.cardCode = mycontroller[3].text;
    selectedcust55!.phNo = mycontroller[4].text;
    selectedcust55!.tarNo = mycontroller[5].text;
    selectedcust55!.name = mycontroller[6].text;
    selectedcust55!.email = mycontroller[21].text;

    if (mycontroller[14].text.isNotEmpty ||
        mycontroller[16].text.isNotEmpty ||
        mycontroller[17].text.isNotEmpty ||
        mycontroller[18].text.isNotEmpty ||
        mycontroller[15].text.isNotEmpty ||
        mycontroller[19].text.isNotEmpty ||
        mycontroller[20].text.isNotEmpty) {
      if (selectedcust55!.address!.isNotEmpty) {
        selectedcust55!.address![selectedShipAdress].address1 =
            mycontroller[14].text;
        selectedcust55!.address![selectedShipAdress].address2 =
            mycontroller[15].text;
        selectedcust55!.address![selectedShipAdress].address3 =
            mycontroller[16].text;
        selectedcust55!.address![selectedShipAdress].billCity =
            mycontroller[17].text;
        selectedcust55!.address![selectedShipAdress].billPincode =
            mycontroller[18].text;
        selectedcust55!.address![selectedShipAdress].billstate =
            mycontroller[19].text;
        selectedcust55!.address![selectedShipAdress].billCountry =
            mycontroller[20].text;

        String autoid5 = selectedcust55!.address != null
            ? selectedcust55!.address![selectedShipAdress].autoId.toString()
            : "";
        //log("iiiiiiiiiiiiiiiiiiiiiiiiii------$aId ::$autoid5");
        await DBOperation.updateShipAddressDetails(
            db,
            // selectedcust55!.cardCode.toString(),
            ij,
            selectedcust55!,
            autoid5.toString());
      } else {
        //log('PPPPPPPPPPPPPPPPPPPPPPPPPPP');
        shipcreateNewAddress.add(CustomerAddressModelDB(
          custcode: selectedcust55!.cardCode,
          createdUserID: UserValues.userID.toString(),
          createdateTime: config.currentDate(),
          lastupdateIp: '1',
          updatedDatetime: config.currentDate(),
          updateduserid: UserValues.lastUpdateIp.toString(),
          address1: mycontroller[14].text,
          address2: mycontroller[15].text,
          address3: mycontroller[16].text,
          city: mycontroller[17].text,
          countrycode: mycontroller[20].text,
          geolocation1: '',
          geolocation2: '',
          statecode: mycontroller[19].text,
          pincode: mycontroller[18].text,
          branch: UserValues.branch.toString(),
          terminal: UserValues.terminal,
          addresstype: 'S',
        ));
        if (shipcreateNewAddress.isNotEmpty) {
          await DBOperation.insertCustomerAddress(db, shipcreateNewAddress);
        }
      }
    }
    print("selectedcust!.cardCode:::${selectedcust!.cardCode}");
    await DBOperation.updateCustomerDetails(
      db,
      selectedcust!.autoId.toString(),
      selectedcust!,
    );
//  selectedcust!.cardCode.toString(),
    await DBOperation.updateAddressDetails(
        db, i, selectedcust!, aId.toString());

    getCustDetFDB();
    await getUpdateCustandadd(context, selectedcust!.cardCode.toString());
    notifyListeners();
  }

//   updateCustomer(BuildContext context, int i, int ij) async {
//     // final Database db = await dbHelper.createDB();
//     final Database db = (await DBHelper.getInstance())!;
//     String aId = selectedcust!.address![selectedBillAdress].autoId.toString();

//     //log("iiiiiiiiiiiiiiiiiiiiiiiiii------$aId ::$autoid5");
// // if(selectedcust!.address![selectedBillAdress].addresstype=='B'){
//     selectedcust!.cardCode = mycontroller[3].text;
//     selectedcust!.phNo = mycontroller[4].text;
//     selectedcust!.tarNo = mycontroller[5].text;
//     selectedcust!.name = mycontroller[6].text;
//     selectedcust!.email = mycontroller[21].text;

//     selectedcust!.address![selectedBillAdress].address1 = mycontroller[7].text;
//     selectedcust!.address![selectedBillAdress].address2 = mycontroller[8].text;
//     selectedcust!.address![selectedBillAdress].address3 = mycontroller[9].text;
//     selectedcust!.address![selectedBillAdress].billCity = mycontroller[10].text;
//     selectedcust!.address![selectedBillAdress].billPincode =
//         mycontroller[11].text;
//     selectedcust!.address![selectedBillAdress].billstate =
//         mycontroller[12].text;
//     selectedcust!.address![selectedBillAdress].billCountry =
//         mycontroller[13].text;

//     selectedcust55!.cardCode = mycontroller[3].text;
//     selectedcust55!.phNo = mycontroller[4].text;
//     selectedcust55!.tarNo = mycontroller[5].text;
//     selectedcust55!.name = mycontroller[6].text;
//     selectedcust55!.email = mycontroller[21].text;
//     if (mycontroller[14].text.isNotEmpty ||
//         mycontroller[16].text.isNotEmpty ||
//         mycontroller[17].text.isNotEmpty ||
//         mycontroller[18].text.isNotEmpty ||
//         mycontroller[15].text.isNotEmpty ||
//         mycontroller[19].text.isNotEmpty ||
//         mycontroller[20].text.isNotEmpty) {
//       if (selectedcust55!.address!.length > 0) {
//         selectedcust55!.address![selectedShipAdress].address1 =
//             mycontroller[14].text;
//         selectedcust55!.address![selectedShipAdress].address2 =
//             mycontroller[15].text;
//         selectedcust55!.address![selectedShipAdress].address3 =
//             mycontroller[16].text;
//         selectedcust55!.address![selectedShipAdress].billCity =
//             mycontroller[17].text;
//         selectedcust55!.address![selectedShipAdress].billPincode =
//             mycontroller[18].text;
//         selectedcust55!.address![selectedShipAdress].billstate =
//             mycontroller[19].text;
//         selectedcust55!.address![selectedShipAdress].billCountry =
//             mycontroller[20].text;

//         String autoid5 = selectedcust55!.address != null
//             ? selectedcust55!.address![selectedShipAdress].autoId.toString()
//             : "";
//    //log("iiiiiiiiiiiiiiiiiiiiiiiiii------$aId ::$autoid5");
//         await DBOperation.updateShipAddressDetails(
//             db,
//             selectedcust55!.cardCode.toString(),
//             ij,
//             selectedcust55!,
//             autoid5.toString());
//       } else {
//         await insertsipCreatenewAddress();
//       }
//     }
//     await DBOperation.updateCustomerDetails(
//       db,
//       selectedcust!.cardCode.toString(),
//       selectedcust!,
//     );

//     await DBOperation.updateAddressDetails(db,
//         selectedcust!.cardCode.toString(), i, selectedcust!, aId.toString());

//     getCustDetFDB();
//     await getUpdateCustandadd(context, selectedcust!.cardCode.toString());
//     notifyListeners();
//   }

  getUpdateCustandadd(BuildContext context, String cardcode) async {
    final Database db = (await DBHelper.getInstance())!;
    selectedcust!.address = [];
    selectedcust55!.address = [];

    //log("mycontroller[3].text.toString()::${mycontroller[3].text}");
    List<Map<String, Object?>> newcusdataDB =
        await DBOperation.getCstmMasDatabyautoid(db, cardcode.toString());
    List<Map<String, Object?>> newaddrssdataDB =
        await DBOperation.addgetCstmMasAddDB(db, cardcode.toString());
    for (int i = 0; i < newcusdataDB.length; i++) {
      //log('step:1');
      selectedcust = CustomerDetals(
          autoId: newcusdataDB[i]['autoid'].toString(),
          cardCode: newcusdataDB[i]['customercode'].toString(),
          name: newcusdataDB[i]['customername'].toString(),
          phNo: newcusdataDB[i]['phoneno1'].toString(),
          accBalance: double.parse(newcusdataDB[i]['balance'].toString()),
          point: newcusdataDB[i]['points'].toString(),
          tarNo: newcusdataDB[i]['taxno'].toString(),
          email: newcusdataDB[i]['emalid'].toString(),
          invoicenum: '',
          invoiceDate: '',
          totalPayment: 00,
          address: []);
    }
    notifyListeners();

    if (newaddrssdataDB.isNotEmpty) {
      for (int ik = 0; ik < newaddrssdataDB.length; ik++) {
        //log("newaddrssdataDB.cardcode::${newaddrssdataDB[ik]['custcode']}");
        if (newaddrssdataDB[ik]['addresstype'].toString() == "B") {
          selectedcust!.address!.add(
            Address(
              autoId: int.parse(newaddrssdataDB[ik]['autoid'].toString()),
              addresstype: newaddrssdataDB[ik]['addresstype'].toString(),
              address1: newaddrssdataDB[ik]['address1'].toString(),
              address2: newaddrssdataDB[ik]['address2'].toString(),
              address3: newaddrssdataDB[ik]['address3'].toString(),
              billCity: newaddrssdataDB[ik]['city'].toString(),
              billCountry: newaddrssdataDB[ik]['countrycode'].toString(),
              billPincode: newaddrssdataDB[ik]['pincode'].toString(),
              billstate: newaddrssdataDB[ik]['statecode'].toString(),
            ),
          );
          notifyListeners();
        }

        if (newaddrssdataDB[ik]['addresstype'].toString() == "S") {
          selectedcust55!.address!.add(
            Address(
              autoId: int.parse(newaddrssdataDB[ik]['autoid'].toString()),
              addresstype: newaddrssdataDB[ik]['addresstype'].toString(),
              address1: newaddrssdataDB[ik]['address1'].toString(),
              address2: newaddrssdataDB[ik]['address2'].toString(),
              address3: newaddrssdataDB[ik]['address3'].toString(),
              billCity: newaddrssdataDB[ik]['city'].toString(),
              billCountry: newaddrssdataDB[ik]['countrycode'].toString(),
              billPincode: newaddrssdataDB[ik]['pincode'].toString(),
              billstate: newaddrssdataDB[ik]['statecode'].toString(),
            ),
          );
          notifyListeners();

          //log('step:3');
        }
      }
    }
    //log("selectedcust!.address!.length:::${selectedcust!.address!.length}");

    // selectedBillAdress = selectedcust!.address!.length - 1;
    // selectedShipAdress = selectedcust55!.address!.length - 1;

    notifyListeners();

    //log('step:4');
  }

  clearAddress() {
    mycontroller[7].clear();
    mycontroller[8].clear();
    mycontroller[9].clear();
    mycontroller[10].clear();
    mycontroller[11].clear();
    mycontroller[12].clear();
    mycontroller[13].clear();
    checkboxx = false;
    mycontroller[14].clear();
    mycontroller[15].clear();
    mycontroller[16].clear();
    mycontroller[17].clear();
    mycontroller[18].clear();
    mycontroller[19].clear();
    mycontroller[20].clear();
    notifyListeners();
  }

  clearCustomer() {
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[21].clear();

    notifyListeners();
  }
//payment func

  calCulateDocVal(BuildContext context, ThemeData theme) {
    totalPayment = null;
//log("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
    TotalPayment totalPay = TotalPayment();
    totalPay.total = 0;
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.totalDue = 0.00;
//log("issss length:${scanneditemData.length}");

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      //log('  step11');
      double? mycontlaa = discountcontroller[iss].text.isNotEmpty
          ? double.parse(discountcontroller[iss].text.toString())
          : 0;
      scanneditemData[iss].Qty = int.parse(qtymycontroller[iss].text.isNotEmpty
          ? qtymycontroller[iss].text
          : "0");

      totalPay.total =
          totalPay.total! + int.parse(scanneditemData[iss].Qty.toString());
      notifyListeners();
      if (double.parse(scanneditemData[iss].Maxdiscount!) >= mycontlaa) {
        //log('  step22::::${totalPay.total}');

        String ansbasic =
            (scanneditemData[iss].SellPrice! * scanneditemData[iss].Qty!)
                .toString();
        scanneditemData[iss].basic = double.parse(ansbasic);
        scanneditemData[iss].discountper =
            discountcontroller[iss].text.isNotEmpty
                ? double.parse(discountcontroller[iss].text.toString())
                : 00;
        scanneditemData[iss].discount = (scanneditemData[iss].basic! *
            scanneditemData[iss].discountper! /
            100);

        scanneditemData[iss].taxable =
            scanneditemData[iss].basic! - scanneditemData[iss].discount!;

        scanneditemData[iss].taxvalue =
            scanneditemData[iss].taxable! * scanneditemData[iss].TaxRate! / 100;

        scanneditemData[iss].netvalue =
            (scanneditemData[iss].basic! - scanneditemData[iss].discount!) +
                scanneditemData[iss].taxvalue!;

        totalPay.subtotal = totalPay.subtotal! + scanneditemData[iss].basic!;

        totalPay.discount = totalPay.discount! + scanneditemData[iss].discount!;
        totalPay.totalTX = totalPay.totalTX! + scanneditemData[iss].taxvalue!;

        totalPay.totalDue = totalPay.totalDue! + scanneditemData[iss].netvalue!;
        totalPayment = totalPay;

        //log("totalPay.subtotaltotalPay.subtotal::${totalPay.subtotal}");
        //log("  totalPay.discount  totalPay.discount::${totalPay.discount}");

        //log("  totalPay.totalDue   totalPay.totalDue ::${totalPay.totalDue}");

        //log("totalPay.subtotaltotalPay.subtotal::${totalPay.subtotal}");
        notifyListeners();
      } else if (mycontlaa >= 100) {
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
                            "Please enter the discount percentage is below 100"),
                  ));
            }).then((value) {
          discountcontroller[iss].text = '';
          notifyListeners();
        });
      } else {
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
                            "Discount is greater than Maximum Discount(${scanneditemData[iss].Maxdiscount})"),
                  ));
            }).then((value) {
          discountcontroller[iss].text = '';
          notifyListeners();
        });
      }
      //  totalPayment = totalPay;
      notifyListeners();
      // FocusScopeNode focus = FocusScope.of(context);
      // //log("TaxRate:${scanneditemData[iss].TaxRate}");
      // if (!focus.hasPrimaryFocus) {
      //   focus.unfocus();
      // }
    }
    notifyListeners();
  }

//   calCulateDocVal(BuildContext context, ThemeData theme) {
//     TotalPayment totalPay = TotalPayment();
//     totalPay.total = 0;
//     totalPay.discount = 0.00;
//     totalPay.subtotal = 0.00;
//     totalPay.totalTX = 0.00;
//     totalPay.totalDue = 0.00;

//     if (scanneditemData.isEmpty) {
//      //log('Step11');
//       totalPayment = totalPay;
//     }

//     for (int iss = 0; iss < scanneditemData.length; iss++) {
//      //log('Step22::scanneditemData[iss].Qty::'+scanneditemData[iss].Qty.toString());

//       double? mycontlaa = discountcontroller[iss].text.isNotEmpty
//           ? double.parse(discountcontroller[iss].text.toString())
//           : 0;

//       scanneditemData[iss].Qty = int.parse(qtymycontroller[iss].text);
//       totalPay.total =
//           totalPay.total! + int.parse(scanneditemData[iss].Qty.toString());
//         notifyListeners();
//log(" totalPay.total::"+ totalPay.total.toString());
//       if (double.parse(scanneditemData[iss].Maxdiscount!) >= mycontlaa) {
//      //log('Step33');

//         String ansbasic =
//             (scanneditemData[iss].SellPrice! * scanneditemData[iss].Qty!)
//                 .toString();
//         scanneditemData[iss].basic = double.parse(ansbasic);
//         scanneditemData[iss].discountper =
//             discountcontroller[iss].text.isNotEmpty
//                 ? double.parse(discountcontroller[iss].text.toString())
//                 : 00;
//         scanneditemData[iss].discount = (scanneditemData[iss].basic! *
//             scanneditemData[iss].discountper! /
//             100);

//         //log("discount Amount:${scanneditemData[iss].discount.toString()}: ${scanneditemData[iss].basic.toString()}:${scanneditemData[iss].discountper!.toString()}");
//         scanneditemData[iss].taxable =
//             scanneditemData[iss].basic! - scanneditemData[iss].discount!;

//         scanneditemData[iss].taxvalue =
//             scanneditemData[iss].taxable! * scanneditemData[iss].TaxRate / 100;

//         scanneditemData[iss].netvalue =
//             (scanneditemData[iss].basic! - scanneditemData[iss].discount!) +
//                 scanneditemData[iss].taxvalue!;
//         // calculateLineVal(context, theme, iss);

//         totalPay.subtotal = totalPay.subtotal! + scanneditemData[iss].basic!;
//         // totalPay.total = totalPay.total! + scanneditemData[iss].Qty!;
//         totalPay.discount = totalPay.discount! + scanneditemData[iss].discount!;
//         totalPay.totalTX = totalPay.totalTX! + scanneditemData[iss].taxvalue!;
//         totalPay.totalDue = totalPay.totalDue! + scanneditemData[iss].netvalue!;
//         notifyListeners();
//       } else if (mycontlaa >= 100) {
//      //log('Step55');

//         showDialog(
//             context: context,
//             barrierDismissible: true,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                   contentPadding: EdgeInsets.all(0),
//                   content: SizedBox(
//                     width: Screens.width(context) * 0.5,
//                     height: Screens.bodyheight(context) * 0.15,
//                     child: ContentWidgetMob(
//                         theme: theme,
//                         msg:
//                             "Please enter the discount percentage is below 100"),
//                   ));
//             }).then((value) {
//           mycontroller[iss].text = '';
//           notifyListeners();
//         });
//       } else {
//      //log('Step66');

//         showDialog(
//             context: context,
//             barrierDismissible: true,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                   contentPadding: EdgeInsets.all(0),
//                   content: SizedBox(
//                     width: Screens.width(context) * 0.5,
//                     height: Screens.bodyheight(context) * 0.15,
//                     child: ContentWidgetMob(
//                         theme: theme,
//                         msg:
//                             "Discount is greater than Maximum Discount(${scanneditemData[iss].Maxdiscount})"),
//                   ));
//             }).then((value) {
//           mycontroller[iss].text = '';
//           notifyListeners();
//         });
//       }
//       FocusScopeNode focus = FocusScope.of(context);
//       //log("TaxRate:${scanneditemData[iss].TaxRate}");
//       if (!focus.hasPrimaryFocus) {
//         focus.unfocus();
//       }
//     notifyListeners();

//     }
//       totalPayment = totalPay;

//     notifyListeners();
//   }

  calculateLineVal(BuildContext context, ThemeData theme, int iss) {
    // for (int iss = 0; iss < scanneditemData.length; iss++) {
    // if (int.parse(mycontroller[iss].text.toString()) <
    //     scanneditemData[iss].Maxdiscount!) {
    String ans = (scanneditemData[iss].SellPrice! * scanneditemData[iss].Qty!)
        .toString();
    scanneditemData[iss].basic = double.parse(ans);
    scanneditemData[iss].discountper = mycontroller[iss].text.isNotEmpty
        ? double.parse(mycontroller[iss].text.toString())
        : 00;
    scanneditemData[iss].discount =
        (scanneditemData[iss].basic! * scanneditemData[iss].discountper! / 100);

    //log("discount Amount:${scanneditemData[iss].discount.toString()}: ${scanneditemData[iss].basic.toString()}:${scanneditemData[iss].discountper!.toString()}");
    scanneditemData[iss].taxable =
        scanneditemData[iss].basic! - scanneditemData[iss].discount!;

    scanneditemData[iss].taxvalue =
        scanneditemData[iss].taxable! * scanneditemData[iss].TaxRate! / 100;

    scanneditemData[iss].netvalue =
        (scanneditemData[iss].basic! - scanneditemData[iss].discount!) +
            scanneditemData[iss].taxvalue!;
    notifyListeners();
  }

  /// pay ment way

  double getSumTotalPaid2() {
    double toalPaid = 0.0;
    if (paymentWay2.isNotEmpty) {
      for (int i = 0; i < paymentWay2.length; i++) {
        if (paymentWay2[i].type != "Credit") {
          toalPaid = toalPaid + paymentWay2[i].amt!;
        }
      }
      //log("toalPaidtoalPaid:::::" + toalPaid.toString());

      return toalPaid;
    } else {
      return 0.00;
    }
  }

  // double getSumTotalPaid() {
  //   double toalPaid = 0.0;
  //   if (paymentWay.isNotEmpty) {
  //     for (int i = 0; i < paymentWay.length; i++) {
  //       if (paymentWay[i].type != "Credit") {
  //         toalPaid = toalPaid + paymentWay[i].amt!;
  //       }
  //     }
  //     //log("toalPaidtoalPaid:::::" + toalPaid.toString());

  //     return toalPaid;
  //   } else {
  //     return 0.00;
  //   }
  // }
  double getSumTotalPaid() {
    double toalPaid = 0.0;
    // if (paymentWay.isNotEmpty) {
    //   for (int i = 0; i < paymentWay.length; i++) {
    //     if (paymentWay[i].type != "Credit") {
    //       toalPaid = toalPaid + paymentWay[i].amt!;
    //     }
    //   }
    //  //log("toalPaidtoalPaid:::::$toalPaid");

    //   return toalPaid;
    // } else {
    //   return 0.00;
    // }
    if (paymentWay.isNotEmpty) {
      var getTotalPaid = paymentWay.map((itemdet) => itemdet.amt.toString());
      var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
      var toalPaid = getTotalPaidSum.reduce((a, b) => a + b);
      return toalPaid;
    } else {
      return 0.00;
    }
  }

  double getBalancePaid() {
    if (paymentWay.isNotEmpty) {
      return double.parse(
              totalPayment!.totalDue!.toStringAsFixed(0).replaceAll(',', '')) -
          double.parse(getSumTotalPaid().toStringAsFixed(0));
    }
    return totalPayment != null
        ? double.parse(
            totalPayment!.totalDue!.toStringAsFixed(0).replaceAll(',', ''))
        : 0.00;
  }

  addPayAmount(PaymentWay paymt, BuildContext context) {
    // print("typeee: ${paymt.amt!.toStringAsFixed(0)}");
    // double paymentamt = 0;
    if (paymentWay.isEmpty) {
      if (double.parse(totalPayment!.totalDue!
                  .toStringAsFixed(0)
                  .replaceAll(',', '')) >
              getSumTotalPaid() &&
          double.parse(getBalancePaid().toStringAsFixed(0)) >=
              double.parse(paymt.amt!.toStringAsFixed(0))) {
        //log("Amt111: ${paymt.amt}");
        addToPaymentWay(paymt, context);
      } else {
        //log("_______:${totalPayment!.totalDue!.toStringAsFixed(0)}");
        //log("Am22221: ${paymt.amt}");
        msgforAmount = 'Enter Correct amount..!!';
        //log("msgforAmount:::${msgforAmount}");

        notifyListeners();
      }
    } else {
      if (double.parse(totalPayment!.totalDue!
                  .toStringAsFixed(0)
                  .replaceAll(',', '')) >
              getSumTotalPaid() &&
          double.parse(getBalancePaid().toStringAsFixed(0)) >=
              double.parse(paymt.amt!.toStringAsFixed(0))) {
        //log("ErroAmt3333: ${paymt.amt!.toStringAsFixed(0)}");
        addToPaymentWay(paymt, context);
      } else {
        //log("ErroAmtgetBalancePaid:" + getBalancePaid().toString());

        //log("ErroAmt4444: ${paymt.amt!.toStringAsFixed(0)}");
        msgforAmount = 'Enter Correct amount..!!';
        notifyListeners();
        //config.showDialogBox('Alert', 'Enter Correct amount..!!', context);
      }
    }
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

  addToPaymentWay(
    PaymentWay paymt,
    BuildContext context,
  ) {
    hintcolor = false;
    paymentWay.add(PaymentWay(
        amt: paymt.amt!,
        dateTime: paymt.dateTime,
        reference: paymt.reference ?? '',
        type: paymt.type,
        cardApprno: paymt.cardApprno,
        cardref: paymt.cardref,
        cardterminal: paymt.cardterminal,
        chequedate: paymt.chequedate,
        chequeno: paymt.chequeno,
        // couponcode: paymt.couponcode,
        // coupontype: paymt.coupontype,
        discountcode: paymt.discountcode,
        discounttype: paymt.discounttype,
        // creditref: paymt.creditref,
        recoverydate: paymt.recoverydate,
        redeempoint: paymt.redeempoint,
        availablept: paymt.availablept,
        remarks: paymt.remarks,
        // transref: paymt.transref,
        transtype: paymt.transtype,
        walletid: paymt.walletid,
        // walletref: paymt.walletref,
        wallettype: paymt.wallettype));
    getSumTotalPaid();
    getBalancePaid();
    Navigator.pop(context);
    notifyListeners();
  }

  fullamt(String type, BuildContext context, ThemeData theme) {
    PaymentWay fpaymt = PaymentWay();

    mycontroller[22].text = totalPayment!.totalDue.toString();
    cashpayment = totalPayment!.totalDue!;
    String fullam = getBalancePaid().toString().replaceAll(',', '');
    fpaymt.amt = double.parse(fullam.replaceAll(",", ""));
    fpaymt.dateTime = config.currentDate();
    fpaymt.type = type;
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
  }

  cpyBtnclik(int i) {
    mycontroller[i].text = getBalancePaid().toStringAsFixed(0);
    notifyListeners();
  }

  double? cashpayment = 0;
  double? cqpayment = 0;
  double? transpayment = 0;
  int? chqnum = 0;
  String? transrefff = '';
  String cashType = '';
  String creditType = '';
  String cardType = '';
  String chequeType = '';
  String transferType = '';
  String walletType = '';
  String pointType = '';
  String accType = '';

  addEnteredAmtType(String type, BuildContext context, int i, ThemeData theme) {
    PaymentWay paymt = PaymentWay();

    if (formkey[i].currentState!.validate()) {
      //log('type: $type');

      if (type == 'Cash') {
        //log("Cash: ${mycontroller[22].text.toString().trim()}");
        creditType = type;
        paymt.amt = double.parse(mycontroller[22].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        cashType = type;
        cashpayment = paymt.amt!;
      } else if (type == 'Cheque') {
        //log("cheque: ${mycontroller[25].text.toString().trim()}");
        paymt.amt = double.parse(mycontroller[25].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.chequedate = mycontroller[24].text;
        paymt.chequeno = mycontroller[23].text.toString();
        paymt.type = type;
        chequeType = type;
        cqpayment = paymt.amt;
        chqnum = int.parse(paymt.chequeno.toString());
      } else if (type == 'Card') {
        paymt.amt = double.parse(
            mycontroller[29].text.toString().trim().replaceAll(',', ''));
        paymt.reference = mycontroller[28].text;
        paymt.cardApprno = mycontroller[27].text;
        paymt.cardref = mycontroller[28].text;
        paymt.cardterminal = paymentterm.toString();
        paymt.type = type;
        cardType = type;
      } else if (type == 'Transfer') {
        // paymt.transref = mycontroller[30].text.toString();

        paymt.transtype = selectedType.toString();
        paymt.reference = mycontroller[30].text;
        paymt.amt = double.parse(mycontroller[31].text.toString().trim());
        paymt.dateTime = config.currentDate(); //mycontroller[30],
        paymt.type = type;
        transferType = type;
        transpayment = paymt.amt;
        transrefff = paymt.reference!;
      } else if (type == 'Wallet') {
        paymt.reference = mycontroller[33].text;
        paymt.walletid = mycontroller[32].text;
        // paymt.walletref = mycontroller[33].text;
        paymt.wallettype = wallet;
        paymt.amt = double.parse(mycontroller[34].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        walletType = type;
      } else if (type == 'Account Balance') {
        paymt.type = type;
        accType = type;

        paymt.amt = double.parse(mycontroller[36].text.toString().trim());
        paymt.dateTime = config.currentDate();
      } else if (type == 'Points Redemption') {
        paymt.redeempoint = mycontroller[38].text;
        paymt.availablept = mycontroller[37].text;
        paymt.amt = double.parse(mycontroller[40].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        pointType = type;
      } else if (type == 'Discount') {
        paymt.discountcode = mycontroller[41].text;
        paymt.discounttype = discount;
        paymt.amt = double.parse(mycontroller[42].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.reference = mycontroller[41].text.toString();
        paymt.type = type;
      } else if (type == 'Credit') {
        // paymt.creditref = mycontroller[43].text;
        paymt.recoverydate = mycontroller[44].text;
        paymt.reference = mycontroller[43].text.toString();
        paymt.amt = double.parse(mycontroller[45].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        creditType = type;
      }
    }
    if (selectedType == null && type == 'Transfer') {
      hintcolor = true;
      notifyListeners();
      return;
    }
    if (paymentterm == null && type == 'Card') {
      hintcolor = true;
      notifyListeners();
      return;
    }
    if (wallet == null && type == 'Wallet') {
      hintcolor = true;
      notifyListeners();
      return;
    }
    if (coupon == null && type == 'Coupons') {
      hintcolor = true;
      notifyListeners();
      return;
    }
    if (discount == null && type == 'Discount') {
      hintcolor = true;
      notifyListeners();
      return;
    }

    //log("paymt.amt: ${paymt.amt!.toStringAsFixed(0)}");

    if (paymt.amt != null) {
      int check = checkAlreadyUsed(paymt.type!);
      notifyListeners();

      if (check == 0) {
        //log("check: $check");

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
                          "Already you are used ${paymt.type!} mode of payment..!!"));
            });
      }
    }
  }

  int checkAlreadyUsed(String typeofMoney) {
    for (int ip = 0; ip < paymentWay.length; ip++) {
      if (paymentWay[ip].type == "Cash") {
        if (paymentWay[ip].type == typeofMoney) {
          return 1;
        }
      }
      notifyListeners();
    }
    return 0;
  }

  clearPayment() {
    paymentWay.clear();
    getSumTotalPaid();
    getBalancePaid();
    notifyListeners();
  }

  removePayment(int i) {
    // if (selectedcust != null) {
    //   if (paymentWay[i].type == "Account Balance") {
    //     selectedcust!.accBalance = selectedcust!.accBalance! - paymentWay[i].amt!;
    //   }
    //else if (paymentWay[i].type == "Points Redemption") {
    //     selectedcust!.point = (double.parse(selectedcust!.point.toString()) + paymentWay[i].amt!).toString();
    //   }
    // }
    paymentWay.removeAt(i);
    getSumTotalPaid();
    getBalancePaid();

    notifyListeners();
  }

  udfClear() {
    valueSelectedOrder = null;
    valueSelectedGPApproval = null;
    udfController[2].clear();
    udfController[0].clear();
    udfController[1].clear();
    notifyListeners();
  }

  clearTextField() {
    custseriesNo = null;
    loadingBtn = false;
    teriteriValue = null;
    paygrpValue = null;
    codeValue = null;
    filedata.clear();
    tinFiles = null;
    vatFiles = null;
    searchcontroller.clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[7].clear();
    mycontroller[8].clear();
    mycontroller[9].clear();
    mycontroller[10].clear();
    mycontroller[11].clear();
    mycontroller[12].clear();
    mycontroller[13].clear();
    mycontroller[14].clear();
    mycontroller[15].clear();
    mycontroller[16].clear();
    mycontroller[17].clear();
    mycontroller[18].clear();
    mycontroller[19].clear();
    mycontroller[13].clear();
    mycontroller[20].clear();
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
    mycontroller[46].clear();
    mycontroller[47].clear();
    mycontroller[49].clear();
    mycontroller[50].clear();

    checkboxx = false;
    selectedType = null;
    notifyListeners();
  }

//checkout

  changecheckout(BuildContext context, ThemeData theme) async {
//log('GGGGGGGGGGGGGGGGGGG');
    await scehmeapiforckout(context, theme);

    checkOut(context, theme);
    notifyListeners();
  }

  checkOut(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    OndDisablebutton = true;
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
        OndDisablebutton = false;
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
        OndDisablebutton = false;
        notifyListeners();
      });
    } else if (getBalancePaid() < 0) {
      //log("without put any payment way");
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
                      content: 'Your balance amount is less than 0',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        OndDisablebutton = false;
        notifyListeners();
      });
    } else if (valueSelectedOrder == null && valueSelectedGPApproval == null) {
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
                      content: 'Please Update a UDF',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        OndDisablebutton = false;
        notifyListeners();
      });
    } else if (paymentWay.isNotEmpty) {
      if ((totalPayment!.totalDue != getSumTotalPaid()) &&
          (getBalancePaid() != 0)) {
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
                        content: 'Pay the full amount..!!',
                        theme: theme,
                      )),
                      buttonName: null));
            }).then((value) {
          disableKeyBoard(context);
        }).then((value) {
          OndDisablebutton = false;
          notifyListeners();
        });
      } else {
        await saveValuesTODB("check out", context, theme);

        if (holddocentry.isNotEmpty) {
          print("KKKKKKKKKKKKKKKKK");
          await DBOperation.deleteOrderHold(db, holddocentry).then((value) {
            holddocentry = '';
            onHoldFilter = [];
            getdraftindex();
          });
        }
      }
    } else if (paymentWay.isEmpty) {
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
                      content: 'Pay the full amount..!!',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        OndDisablebutton = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  scehmeapiforckout(BuildContext context, ThemeData theme) async {
    await salesOrderSchemeData();
    await callSchemeOrderAPi();
    await calculatescheme(context, theme);
    notifyListeners();
  }

  clickacancelbtn(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    log("tbDocEntrytbDocEntry:::${tbDocEntry}");
    if (sapDocentry.isNotEmpty) {
      List<Map<String, Object?>> getheaderData =
          await DBOperation.salesOrderCancellQuery(
        db,
        tbDocEntry.toString(),
      );
      if (getheaderData.isNotEmpty) {
        if (getheaderData[0]['basedocentry'].toString() ==
            tbDocEntry.toString()) {
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
                        content:
                            'This document is already converted into sales invoice',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            cancelDocnum = '';
            sapDocentry = '';
            sapDocuNumber = '';
            selectedcust2 = null;
            selectedcust25 = null;
            paymentWay2.clear();
            scanneditemData2.clear();
            cancelbtn = false;
            selectedcust2 = null;
            selectedcust = null;
            scanneditemData2.clear();
            paymentWay2.clear();
            totalPayment2 = null;
            injectToDb();
            getdraftindex();
            mycontroller2[50].text = "";
            notifyListeners();
          });
        }
      } else {
        await sapOrderLoginApi(
          context,
        );
        // await callSerlaySalesOrderAPI(context, theme);
        // await callSalesOrderCancelAPI(context, theme);
        notifyListeners();
      }
    } else {
      //log("BBBBBBBBBBBBBBBBBBBBBB");
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
                    content: 'Something went wrong',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        sapDocentry = '';
        sapDocuNumber = '';
        selectedcust2 = null;
        selectedcust25 = null;
        scanneditemData2.clear();
        paymentWay2.clear();
        totalPayment2 = null;
        custList2.clear();
        injectToDb();
        getdraftindex();
        mycontroller2[50].text = "";
        cancelbtn = false;
        notifyListeners();
      });
    }
  }

  sapOrderLoginApi(
    BuildContext context,
  ) async {
    final pref2 = await pref;
    PostOrderLoginAPi.username = "api";
    AppConstant.sapDB = 'MRP T1';
    await PostOrderLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          AppConstant.sapSessionID = '';

          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          print("sessionID: " + value.sessionId.toString());
          await getSession();
        }
      } else if (value.stCode! >= 400 && value.stCode! <= 410) {
        if (value.error!.code != null) {
          loadingscrn = false;

          custserieserrormsg = value.error!.message!.value.toString();
          //log("Error22:;$custserieserrormsg");

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
            "Opps Someething went wrong !!..",
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
//log("AppConstant.sapSessionIDyyyy::${AppConstant.sapSessionID}");
    notifyListeners();
  }

  callSerlaySalesOrderAPI(BuildContext context, ThemeData theme) async {
//log("AppConstant.sapSessionIDzzz::${AppConstant.sapSessionID}");
//log("sapDocentrysapDocentrysapDocentry:::$sapDocentry");

    await SerlaySalesOrderAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.documentLines.isNotEmpty) {
          SapSaleOrderModelData = value.documentLines;
          //log("SapSaleOrderModelDataSapSaleOrderModelData::${SapSaleOrderModelData[0].lineStatus}");
          //log("SapSaleOrderModelData lenght::${SapSaleOrderModelData.length}");
          custserieserrormsg = '';
        } else {
          //log("Error11");
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        cancelbtn = false;
        //log("Error22");
        custserieserrormsg = value.error!.message!.value.toString();
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
          selectedcust2 = null;
          selectedcust25 = null;
          paymentWay2.clear();
          scanneditemData2.clear();
          notifyListeners();
        });
        //log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
      } else {
        //log("Error33");
      }
    });
  }

  callSalesOrderCancelAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    if (SapSaleOrderModelData.isNotEmpty) {
      for (int ij = 0; ij < SapSaleOrderModelData.length; ij++) {
        if (SapSaleOrderModelData[ij].lineStatus == "bost_Open") {
          //:bost_Close
          await SerlayOrderCancelAPI.getData(sapDocentry.toString())
              .then((value) async {
            if (value.statusCode! >= 200 && value.statusCode! <= 204) {
              cancelbtn = false;

              //log("SapSaleOrderModelDataSapSaleOrderModelData::${SapSaleOrderModelData[0].lineStatus}");

              await DBOperation.updateSalesOrderclosedocsts(
                  db, sapDocentry.toString());
              notifyListeners();

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
                selectedcust25 = null;
                paymentWay2.clear();
                scanneditemData2.clear();
                notifyListeners();
              });
              custserieserrormsg = '';
              notifyListeners();

              // }
              //  else {
              //  log("Error11");

              //   // custserieserrormsg = value.message!.toString();
              // }
            } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
              cancelbtn = false;

              custserieserrormsg = value.exception!.message!.value.toString();
              //log("Error22:;$custserieserrormsg");
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
                selectedcust2 = null;
                selectedcust25 = null;
                paymentWay2.clear();
                scanneditemData2.clear();
                notifyListeners();
              });
              //log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
            } else {
              //log("Error33");

              // custserieserrormsg = value.message!.toString();
            }
          });
        } else if (SapSaleOrderModelData[ij].lineStatus == "bost_Close") {
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
                        content: 'Document is already cancelled',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            sapDocentry = '';
            sapDocuNumber = '';
            selectedcust2 = null;
            selectedcust25 = null;
            paymentWay2.clear();
            scanneditemData2.clear();
            notifyListeners();
          });
          notifyListeners();
        }
      }
    }
  }

  Future<int?> checkCredit(String typpe) {
    for (int i = 0; i < paymentWay.length; i++) {
      if (paymentWay[i].type == typpe) {
        print('Serial batch:$typpe');
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  filterListOnHold(String v) {
    if (v.isNotEmpty) {
      fileterHoldData = holdData
          .where((e) =>
              e.CardName!.toLowerCase().contains(v.toLowerCase()) ||
              e.Cardcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.date!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      fileterHoldData = holdData;
      notifyListeners();
    }
  }

  onHoldClicked(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    OndDisablebutton = true;
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
        OndDisablebutton = false;
        notifyListeners();
      });
    } else {
      selectedcust2 = null;
      scanneditemData2.clear();
      paymentWay2.clear();
      totalPayment2 = null;
      if (schemebtnclk == true) {
        //log('GGGGGGGGGGGGGGGGGGG');
        await scehmeapiforckout(context, theme);
      }
      await saveValuesTODB("hold", context, theme);
      if (holddocentry.isNotEmpty) {
        //log('holddocentryholddocentry:$holddocentry');
        await DBOperation.deleteHoldMaped(db, holddocentry).then((value) {
          holddocentry = '';
          holdData.clear();
          getdraftindex();
          //log('datatatatatatata deleleleleleelle ');
        });
      }
      injectToDb();
      notifyListeners();
    }
    notifyListeners();
  }

  getDate(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      print(pickedDate);
      datetype = DateFormat('yyyy-MM-dd').format(pickedDate);
      mycontroller[24].text = config.alignDate(datetype!);
      mycontroller[44].text = config.alignDate(datetype!);
      udfController[2].text = config.alignDate(datetype!);
      print(datetype);
    } else {
      print("Date is not selected");
    }
  }

  recoveryGetDate(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      print(pickedDate);
      datetype = DateFormat('yyyy-MM-dd').format(pickedDate);
      mycontroller[24].text = config.alignDate(datetype!);
      mycontroller[44].text = config.alignDate(datetype!);
      print(datetype);
    } else {
      print("Date is not selected");
    }
  }

  adjamt(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    double availbal = selectedcust!.accBalance!;
    double adjamtt = double.parse(mycontroller[36].text);
    if (availbal < 0) {
      print("step1");
      // availbal = availbal + adjamtt;
      if (availbal < 1) {
        addEnteredAmtType('Account Balance', context, 7, theme);
        selectedcust!.accBalance = availbal;
        print(" selectedcust!.accBalancexxx :::${selectedcust!.accBalance}");
        notifyListeners();
      } else {
        msgforAmount = "Adjustment amount is greater than available amount";
        mycontroller[36].text = '';
        notifyListeners();
      }
      notifyListeners();
    } else {
      msgforAmount = "Adjustment amount is less than available amount";
      mycontroller[36].text = '';
      notifyListeners();
    }
    // if (availbal >= adjamtt) {
    // }
    // else {
    //   msgforAmount = "Adjustment amount is greater than available amount";
    //   mycontroller[36].text = '';
    // }
    notifyListeners();
  }
  // adjamt(BuildContext context, ThemeData theme) {
  //   double availbal = selectedcust!.accBalance!;
  //   double adjamtt = double.parse(mycontroller[36].text);
  //   if (availbal < 1) {
  //     availbal = availbal + adjamtt;
  //     addEnteredAmtType('Account Balance', context, 7, theme);
  //     selectedcust!.accBalance = availbal;
  // //log(" selectedcust!.accBalancexxx :::${selectedcust!.accBalance}");
  //     notifyListeners();
  //   } else {
  //     msgforAmount = "Adjustment amount is greater than available amount";
  //     mycontroller[36].text = '';
  //     notifyListeners();
  //   }
  //   // if (availbal >= adjamtt) {
  //   // }
  //   // else {
  //   //   msgforAmount = "Adjustment amount is greater than available amount";
  //   //   mycontroller[36].text = '';
  //   // }
  //   notifyListeners();
  // }

  custCodeReadOnly() {
//log('seriesValueAA ${custseriesNo}');
    if (custseriesNo.toString().toLowerCase() == '218') {
      seriesValuebool = false;
      notifyListeners();
      //log('seriesValuebool11 ${seriesValuebool}');
    } else {
      seriesValuebool = true;
      //log('seriesValuebool222 ${seriesValuebool}');
      notifyListeners();
    }
    notifyListeners();
  }

  pointconvert() {
    print("mycontroller[40].text:${mycontroller[40].text}");

    double availPointt = double.parse(mycontroller[37].text);
    double enteredPoint = double.parse(mycontroller[38].text);
    if (availPointt >= enteredPoint) {
      mycontroller[39].text = mycontroller[38].text;
      mycontroller[40].text = mycontroller[39].text;
    } else {
      msgforAmount = "Redeem points is greater than available points";
      mycontroller[38].text = '';
      mycontroller[40].text = '';
      mycontroller[39].text = '';
    }
    notifyListeners();
  }

  // double cashAmt = 0.00;
  // double get getcashAmt => cashAmt;
  // bool boolCash = false;
  // bool get getboolCash => boolCash;

  String? selectedType;
  List<String> get gettransType => transType;
  bool hintcolor = false;
  bool get gethintcolor => hintcolor;
  String? paymentterm;
  String? wallet;
  String? coupon;
  double? tottpaid;
  String? baltopay;

  List<String> transType = [
    'NEFT',
    'RTGS',
    'IMPS',
  ];

  List payTerminal = [
    "Terminal - 1",
    "Terminal - 2",
    "Terminal - 3",
    "Terminal - 4",
  ];
  List get getpayTerminal => payTerminal;

  List walletlist = ['GPAY', 'PAYTM', 'PHONEPE', 'BAHRAT PE'];
  List get getwalletlist => walletlist;

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
  clearAllData(BuildContext context, ThemeData theme) {
    loadingSqBtn = false;
    loadingSqBtn = false;
    cashpayment = null;
    cashType = '';
    creditType = '';
    cardType = '';
    chequeType = '';
    transferType = '';
    walletType = '';
    pointType = '';
    accType = '';
    addCardCode = '';
    selectedcust55 = null;
    cancelbtn = false;
    editqty = false;
    cpyfrmsq = false;
    searchcon.text = '';
    remarkcontroller3.text = '';
    catchmsg = [];
    custseriesNo = null;
    soData = [];
    cancelbtn = false;
    schemeData = [];
    schemebtnclk = false;
    pref = SharedPreferences.getInstance();
    loadingscrn = false;
    sapDocentry = '';
    sapDocuNumber = '';
    resSchemeDataList = [];
    formkey = List.generate(100, (i) => GlobalKey<FormState>());
    focusnode = List.generate(100, (i) => FocusNode());
    mycontroller = List.generate(150, (i) => TextEditingController());
    mycontroller2 = List.generate(150, (i) => TextEditingController());
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    qtymycontroller2 = List.generate(100, (ij) => TextEditingController());
    discountcontroller = List.generate(100, (ij) => TextEditingController());
    searchcontroller = TextEditingController();
    udfController = List.generate(100, (ij) => TextEditingController());
    selectedcust = null;
    schemebtnclk = false;
    paymentWay.clear();
    billcreateNewAddress = [];
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    billcreateNewAddress = [];
    shipcreateNewAddress = [];
    newCustValues = [];
    paymentWay2.clear();
    custList.clear();
    filtercustList.clear();
    scanneditemData.clear();
    scanneditemData2.clear();
    totwieght = 0.0;
    totLiter = 0.0;
    custList2.clear();
    shipaddress = '';
    msgforAmount = null;
    mycontroller[99].text = '';
    mycontroller[98].text = '';
    OndDisablebutton = false;
    searchbool = false;
    totalPayment = null;
    totalPayment2 = null;
    filtersearchData.clear();
    selectedcust2 = null;
    searchData.clear();
    onHoldFilter!.clear();
    onHold.clear();
    totquantity = null;
    discountamt = null;
    totquantity = null;
    discountamt = null;
    newCustValues.clear();
    newBillAddrsValue.clear();
    newShipAddrsValue.clear();
    clearTextField();
    clearCustomer();
    clearAddress();

    itemData.clear();
    selectedShipAdress = 0;
    selectedBillAdress = 0;
    valueSelectedOrder = null;
    valueSelectedGPApproval = null;
    itemsDocDetails.clear();
    searchAprvlData = [];
    filterAprvlData = [];
    isApprove = false;
    tbDocEntry = null;
    notifyListeners();
  }

  viewdetails() async {
    final Database db = (await DBHelper.getInstance())!;

    // await DBOperation.viewsalesret(db);
  }

  viewSalesheader() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.getSalesHeadHoldvalueDB(db);
    notifyListeners();
  }

  getcustBilladdresslist(
    BuildContext context,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.getdata(db);
    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust!.cardCode!);

    print("MMMMMMMMM:::${csadresdataDB.length}");
    selectedcust!.address = [];

    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (selectedcust!.cardCode == csadresdataDB[ia]['custcode'].toString()) {
        if (csadresdataDB[ia]['addresstype'].toString() == "B") {
          selectedcust!.address!.add(
            Address(
              autoId: int.parse(csadresdataDB[ia]['autoid'].toString()),
              addresstype: csadresdataDB[ia]['addresstype'].toString(),
              address1: csadresdataDB[ia]['address1'].toString(),
              address2: csadresdataDB[ia]['address2'].toString(),
              address3: csadresdataDB[ia]['address3'].toString(),
              billCity: csadresdataDB[ia]['city'].toString(),
              billCountry: csadresdataDB[ia]['countrycode'].toString(),
              billPincode: csadresdataDB[ia]['pincode'].toString(),
              billstate: csadresdataDB[ia]['statecode'].toString(),
            ),
          );
          selectedBillAdress = selectedcust!.address!.length - 1;
        }
        notifyListeners();
      }
    }

    //log("selectedcust!.address!.length:::${selectedcust!.address!.length}");
    //log('selectedBillAdress:$selectedBillAdress');
    //log(' selectedcust!.address index:${selectedcust!.address![selectedBillAdress].billCity}');

    notifyListeners();
  }

  getcustshipaddresslist(
    BuildContext context,
  ) async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust55!.cardCode!);

    print("MMMMMMMMM55:::${selectedcust55!.cardCode}");

    selectedcust55!.address = [];
    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (selectedcust55!.cardCode ==
          csadresdataDB[ia]['custcode'].toString()) {
        if (csadresdataDB[ia]['addresstype'].toString() == "S") {
          selectedcust55!.address!.add(
            Address(
              addresstype: csadresdataDB[ia]['addresstype'].toString(),
              autoId: int.parse(csadresdataDB[ia]['autoid'].toString()),
              address1: csadresdataDB[ia]['address1'].toString(),
              address2: csadresdataDB[ia]['address2'].toString(),
              address3: csadresdataDB[ia]['address3'].toString(),
              billCity: csadresdataDB[ia]['city'].toString(),
              billCountry: csadresdataDB[ia]['countrycode'].toString(),
              billPincode: csadresdataDB[ia]['pincode'].toString(),
              billstate: csadresdataDB[ia]['statecode'].toString(),
            ),
          );
          selectedShipAdress = selectedcust55!.address!.length - 1;
        }
      }
      notifyListeners();
    }

    notifyListeners();
  }

  Invoice? invoice = Invoice();
  List<Address> address2 = [];

  addressxx(int ih) async {
    final Database db = (await DBHelper.getInstance())!;

    address2 = [];
    List<CustomerAddressModelDB> csadresdataDB =
        await DBOperation.getCstmMasAddDB(
      db,
    );
    for (int k = 0; k < csadresdataDB.length; k++) {
      if (csadresdataDB[k].custcode.toString() ==
          salesmodl[ih].cardCode.toString()) {
        address2.add(Address(
            autoId: int.parse(csadresdataDB[k].autoid.toString()),
            address1: csadresdataDB[k].address1 ?? '',
            address2: csadresdataDB[k].address2 ?? '',
            address3: csadresdataDB[k].address3 ?? '',
            custcode: csadresdataDB[k].custcode ?? '',
            billCity: csadresdataDB[k].city ?? '', //city
            billCountry: csadresdataDB[k].countrycode ?? '', //country
            billPincode: csadresdataDB[k].pincode ?? '', //pinno
            billstate: csadresdataDB[k].statecode ?? ''));
      }
      notifyListeners();
    }
//log(address2.length.toString());
  }

  // mapCallSalesOrdInfoApiForPDF(
  //   preff,
  //   BuildContext context,
  // ) async {
  //   log("FFFFFFFF::${salesmodl.length}");
  //   List<InvoiceItem> itemsList = [];
  //   invoice = null;
  //   for (int ih = 0; ih < salesmodl.length; ih++) {
  // //log(salesmodl[ih].cardCode.toString());
  //     addressxx(ih);
  //     for (int i = 0; i < salesmodl[ih].item!.length; i++) {
  //   //log("XXXXXXXX::${salesmodl[ih].item!.length}");

  //       itemsList.add(InvoiceItem(
  //         slNo: '${i + 1}',
  //         //
  //         descripton: salesmodl[ih].item![i].ItemName,
  //         // netTotal: salesmodl[ih].item![i].netvalue,
  //         unitPrice: double.parse(salesmodl[ih].item![i].SellPrice!.toStringAsFixed(2)),
  //         quantity: salesmodl[ih].item![i].Qty,
  //         dics: salesmodl[ih].item![i].discountper,
  //         vat: double.parse(salesmodl[ih].item![i].taxvalue!.toStringAsFixed(2)),
  //       ));
  //       notifyListeners();
  //     }
  //     invoice = Invoice(
  //       headerinfo: InvoiceHeader(
  //           ordReference: salesmodl[ih].ordReference ?? '',
  //           invDate: config.alignDate(salesmodl[ih].invoceDate.toString()),
  //           invNum: salesmodl[ih].sapInvoiceNum,
  //           companyName: 'companyName',
  //           //
  //           address: 'address',
  //           area: 'area',
  //           pincode: 'pincode',
  //           mobile: 'mobile',
  //           gstNo: 'gstNo',
  //           salesOrder: salesmodl[ih].sapOrderNum),
  //       invoiceMiddle: InvoiceMiddle(
  //         date: salesmodl[ih].invoceDate.toString(),
  //         //
  //         time: 'time',
  //         customerName: salesmodl[ih].custName ?? '',
  //         mobile: salesmodl[ih].phNo!.isEmpty ? '' : salesmodl[ih].phNo.toString(),
  //         address: address2.isEmpty || address2[0].address1!.isEmpty ? '' : address2[0].address1.toString(),
  //         city: address2.isEmpty || address2[0].billCity.isEmpty ? '' : address2[0].billCity.toString(),
  //         area: address2.isEmpty || address2[0].address3!.isEmpty ? '' : address2[0].address3.toString(),
  //         pin: address2.isEmpty || address2[0].billPincode.isEmpty ? '' : address2[0].billPincode.toString(),
  //       ),
  //       items: itemsList,
  //     );

  //     notifyListeners();
  //   }
  //   PdfOrderApiii.exclTxTotal = 0;
  //   PdfOrderApiii.vatTx = 0;
  //   PdfOrderApiii.inclTxTotal = 0;
  //   for (int i = 0; i < invoice!.items!.length; i++) {
  //     invoice!.items![i].basic = (invoice!.items![i].quantity!) * (invoice!.items![i].unitPrice!);
  //     invoice!.items![i].discountamt = (invoice!.items![i].basic! * invoice!.items![i].dics! / 100);
  //     // double netvalue
  //     invoice!.items![i].netTotal = (invoice!.items![i].basic!) - (invoice!.items![i].discountamt!);
  // //log("netTotal::: ${invoice!.items![i].netTotal}");
  //     PdfOrderApiii.exclTxTotal = (PdfOrderApiii.exclTxTotal) + (invoice!.items![i].netTotal!);
  // //log(" PdfOrderApiii.exclTxTotal:::${PdfOrderApiii.exclTxTotal}");
  //     PdfOrderApiii.vatTx = (PdfOrderApiii.vatTx) + double.parse(invoice!.items![i].vat.toString());
  //     // PdfOrderApiii.inclTxTotal = double.parse(invoice!.items![i].unitPrice.toString()) + double.parse(invoice!.items![i].vat.toString());
  //     notifyListeners();
  //   }
  //   PdfOrderApiii.inclTxTotal = (PdfOrderApiii.exclTxTotal) + (PdfOrderApiii.vatTx);
  //   log("invoice.items:::${invoice!.items!.length}");
  //   int length = invoice!.items!.length;
  //   if (length > 0) {
  //     PdfOrderApiii.height = length + 19;
  //     notifyListeners();
  //   }

  //   final pdfFile = await PdfOrderApiii.gennnerate(invoice!);

  //   // PDFDocument doc = await PDFDocument.fromFile(pdfFile);
  //   // ShowOrderrPdfs.document = doc;
  //   // ShowOrderrPdfs.invoicee = invoice;
  //   vvv(context);
  //   notifyListeners();
  // }

  // orderPDFtoPrinter(
  //   preff,
  //   BuildContext context,
  // ) async {

  //   log("FFFFFFFF::${salesmodl.length}");
  //   List<InvoiceItem> itemsList = [];
  //   invoice = null;
  //   for (int ih = 0; ih < salesmodl.length; ih++) {
  // //log(salesmodl[ih].cardCode.toString());
  //     addressxx(ih);
  //     for (int i = 0; i < salesmodl[ih].item!.length; i++) {
  //       itemsList.add(InvoiceItem(
  //         slNo: '${i + 1}',
  //         //
  //         descripton: salesmodl[ih].item![i].ItemName,
  //         unitPrice: salesmodl[ih].item![i].SellPrice,
  //         quantity: salesmodl[ih].item![i].Qty,
  //         dics: salesmodl[ih].item![i].discountper,
  //         vat: salesmodl[ih].item![i].taxvalue,
  //       ));
  //       notifyListeners();
  //     }
  //     invoice = Invoice(
  //       headerinfo: InvoiceHeader(
  //           ordReference: salesmodl[ih].ordReference ?? '',
  //           invDate: config.alignDate(salesmodl[ih].invoceDate.toString()),
  //           invNum: salesmodl[ih].sapInvoiceNum,
  //           companyName: 'companyName',
  //           //
  //           address: 'address',
  //           area: 'area',
  //           pincode: 'pincode',
  //           mobile: 'mobile',
  //           gstNo: 'gstNo',
  //           salesOrder: salesmodl[ih].sapOrderNum ?? ''),
  //       invoiceMiddle: InvoiceMiddle(
  //         date: salesmodl[ih].invoceDate.toString(),
  //         //
  //         time: 'time',
  //         customerName: salesmodl[ih].custName ?? '',
  //         mobile: salesmodl[ih].phNo!.isEmpty ? '' : salesmodl[ih].phNo.toString(),
  //         address: address2.isEmpty || address2[0].address1!.isEmpty ? '' : address2[0].address1.toString(),
  //         city: address2.isEmpty || address2[0].billCity.isEmpty ? '' : address2[0].billCity.toString(),
  //         area: address2.isEmpty || address2[0].address3!.isEmpty ? '' : address2[0].address3.toString(),
  //         pin: address2.isEmpty || address2[0].billPincode.isEmpty ? '' : address2[0].billPincode.toString(),
  //       ),
  //       items: itemsList,
  //     );

  //     notifyListeners();
  //   }
  //   PdfOrderApiii.exclTxTotal = 0;
  //   PdfOrderApiii.vatTx = 0;
  //   PdfOrderApiii.inclTxTotal = 0;
  //   for (int i = 0; i < invoice!.items!.length; i++) {
  //     invoice!.items![i].basic = (invoice!.items![i].quantity!) * (invoice!.items![i].unitPrice!);
  //     invoice!.items![i].discountamt = (invoice!.items![i].basic! * invoice!.items![i].dics! / 100);
  //     // double netvalue
  //     invoice!.items![i].netTotal = (invoice!.items![i].basic!) - (invoice!.items![i].dics!);
  //     PdfOrderApiii.exclTxTotal = (PdfOrderApiii.exclTxTotal) + (invoice!.items![i].netTotal!);
  //     PdfOrderApiii.vatTx = (PdfOrderApiii.vatTx) + double.parse(invoice!.items![i].vat.toString());
  //     // PdfOrderApiii.inclTxTotal = double.parse(invoice!.items![i].unitPrice.toString()) + double.parse(invoice!.items![i].vat.toString());
  //     notifyListeners();
  //   }
  //   PdfOrderApiii.inclTxTotal = (PdfOrderApiii.exclTxTotal) + (PdfOrderApiii.vatTx);
  //   log("invoice.items:::${invoice!.items!.length}");
  //   int length = invoice!.items!.length;
  //   if (length > 0) {
  //     PdfOrderApiii.height = length + 19;
  //     notifyListeners();
  //   }

  //   final pdfFile = await PdfOrderApiii.gennnerate(invoice!);

  //   // PDFDocument doc = await PDFDocument.fromFile(pdfFile);
  //   // ShowOrderrPdfs.document = doc;
  //   // ShowOrderrPdfs.invoicee = /invoice;
  //   // PdftoPrints.document = doc;
  //   // PdftoPrints.invoicee = invoice;

  //   // PdftoPrints
  //   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PdftoPrint()));
  //   notifyListeners();
  // }

  printingdoc(BuildContext context, ThemeData theme) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OrderprintLayout()));
    notifyListeners();
  }

  mapCallSalesOrderForPDF(preff, BuildContext context, ThemeData theme) async {
//log("FFFFFFFF::${salesmodl.length}");
    List<InvoiceItem> itemsList = [];
    invoice = null;
    for (int ih = 0; ih < salesmodl.length; ih++) {
      //log(salesmodl[ih].cardCode.toString());
      addressxx(ih);
      for (int i = 0; i < salesmodl[ih].item!.length; i++) {
        itemsList.add(InvoiceItem(
          slNo: '${i + 1}',
          //
          itemcode: salesmodl[ih].item![i].ItemCode,
          descripton: salesmodl[ih].item![i].ItemName,
          // tax: salesmodl[ih].item![i].TaxRate,
          unitPrice: double.parse(
              salesmodl[ih].item![i].SellPrice!.toStringAsFixed(2)),
          quantity: salesmodl[ih].item![i].Qty,
          dics: salesmodl[ih].item![i].discountper,
          vat:
              double.parse(salesmodl[ih].item![i].taxvalue!.toStringAsFixed(2)),
        ));
        notifyListeners();
      }
      invoice = Invoice(
        headerinfo: InvoiceHeader(
            custcode: salesmodl[ih].cardCode,
            ordReference: salesmodl[ih].ordReference ?? '',
            invDate: config.alignDate(salesmodl[ih].invoceDate.toString()),
            invNum: salesmodl[ih].sapInvoiceNum,
            companyName: 'companyName',
            //
            address: 'address',
            area: 'area',
            pincode: 'pincode',
            mobile: 'mobile',
            gstNo: 'gstNo',
            salesOrder: salesmodl[ih].sapOrderNum),
        invoiceMiddle: InvoiceMiddle(
          date: salesmodl[ih].invoceDate.toString(),
          //
          time: 'time',
          customerName: salesmodl[ih].custName ?? '',
          mobile:
              salesmodl[ih].phNo!.isEmpty ? '' : salesmodl[ih].phNo.toString(),
          address: address2.isEmpty || address2[0].address1!.isEmpty
              ? ''
              : address2[0].address1.toString(),
          city: address2.isEmpty || address2[0].billCity.isEmpty
              ? ''
              : address2[0].billCity.toString(),
          area: address2.isEmpty || address2[0].address3!.isEmpty
              ? ''
              : address2[0].address3.toString(),
          pin: address2.isEmpty || address2[0].billPincode.isEmpty
              ? ''
              : address2[0].billPincode.toString(),
        ),
        items: itemsList,
      );

      notifyListeners();
    }
    OrderprintLayout.subtotal = 0;
    OrderprintLayout.discountval = 0;
    OrderprintLayout.exclTxTotal = 0;
    OrderprintLayout.vatTx = 0;
    OrderprintLayout.inclTxTotal = 0;
    OrderprintLayout.carryoverval = 0;
    OrderprintLayout.discountper = 0;
    if (invoice!.items!.length > 0) {
      for (int i = 0; i < invoice!.items!.length; i++) {
        invoice!.items![i].basic =
            (invoice!.items![i].quantity!) * (invoice!.items![i].unitPrice!);
        invoice!.items![i].discountamt =
            (invoice!.items![i].basic! * invoice!.items![i].dics! / 100);

        invoice!.items![i].netTotal =
            (invoice!.items![i].basic!) - (invoice!.items![i].discountamt!);
        OrderprintLayout.subtotal =
            OrderprintLayout.subtotal + invoice!.items![i].basic!;
        OrderprintLayout.discountper =
            OrderprintLayout.discountper + invoice!.items![i].dics!;
        OrderprintLayout.discountval =
            OrderprintLayout.discountval + invoice!.items![i].discountamt!;
        OrderprintLayout.exclTxTotal =
            (OrderprintLayout.exclTxTotal) + (invoice!.items![i].netTotal!);
        OrderprintLayout.vatTx = (OrderprintLayout.vatTx) +
            double.parse(invoice!.items![i].vat.toString());
        OrderprintLayout.carryoverval =
            OrderprintLayout.carryoverval + invoice!.items![i].netTotal!;

        // OrderprintLayout.inclTxTotal = double.parse(invoice!.items![i].unitPrice.toString()) + double.parse(invoice!.items![i].vat.toString());
        notifyListeners();
      }
      OrderprintLayout.inclTxTotal =
          (OrderprintLayout.exclTxTotal) + (OrderprintLayout.vatTx);
      //log("invoice.items:::${invoice!.items!.length}");
      int length = invoice!.items!.length;
      if (length > 0) {
        // OrderprintLayout.height = length + 19;
        notifyListeners();
      }

      OrderprintLayout.iinvoicee = invoice;
      await printingdoc(context, theme);
    } else {
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
                    content: 'No Printing Bills',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
    notifyListeners();
  }

  checkstocksetqty() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.checkqty(db, "");
    notifyListeners();
  }

  File? source1;
  Directory? copyTo;
  Future<File> getPathOFDB() async {
    final dbFolder = await getDatabasesPath();
    File source1 = File('$dbFolder/PosDBV2.db');
    return Future.value(source1);
  }

  Future<Directory> getDirectory() async {
    Directory copyTo = Directory("storage/emulated/0/Sqlite Backup");
    return Future.value(copyTo);
  }

  Future<bool> getPermissionStorage() async {
    try {
      var statusStorage = await Permission.storage.status;
      if (statusStorage.isDenied) {
        Permission.storage.request();
        return Future.value(false);
      }
      if (statusStorage.isGranted) {
        return Future.value(true);
      }
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
    return Future.value(false);
  }

  showSnackBars(String e, Color color) {
    print(e);
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 3),
      title: "Warning..",
      message: e,
      backgroundColor: Colors.green,
    ));
  }

  Future<String> createDirectory() async {
    try {
      await copyTo!.create();
      String newPath = copyTo!.path;
      createDBFile(newPath);
      return newPath;
    } catch (e) {
      print("datata1111");
      print(e);
      showSnackBars("$e", Colors.red);
    }
    return 'null';
  }

  createDBFile(String path) async {
    try {
      String getPath = "$path/PosDBV2.db";
      print(getPath);
      await source1!.copy(getPath);
      showSnackBars("Created!!...", Colors.green);
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
  }
}
