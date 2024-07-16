// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:posproject/DB Helper/DBhelper.dart';
import 'package:posproject/Models/DataModel/SalesOrderModel.dart';
import 'package:posproject/Models/Service%20Model/GroupCustModel.dart';
import 'package:posproject/Models/Service%20Model/PamentGroupModel.dart';
import 'package:posproject/Models/Service%20Model/TeriTeriModel.dart';
import 'package:posproject/Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
import 'package:posproject/Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_details.modal.dart';
import 'package:posproject/Pages/PrintPDF/PDFInVoiceApi.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:posproject/Service/NewCustCodeCreate/CreatecustPostApi%20copy.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerGropApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerSeriesApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/FileUploadApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/PaymentGroupApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/TeritoryApi.dart';
import 'package:posproject/ServiceLayerAPIss/QuotationAPI/QiotationPostAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../DB Helper/DBOperation.dart';
import "package:dart_amqp/dart_amqp.dart";
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/ItemMaster.dart';
import '../../DBModel/SalesQuotationHead.dart';
import '../../DBModel/SalesQuotationLine.dart';
import '../../DBModel/StockSnap.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import '../../Models/SchemeOrderModel/SchemeOrderModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/AccountBalModel.dart';
import '../../Models/Service Model/SeriesModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotStatusModel.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotsforPutModel.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';
import '../../Pages/Sales Screen/Screens/MobileScreenSales/WidgetsMob/ContentcontainerMob.dart';
import '../../Pages/SalesQuotation/Widgets/QuotPrintLayout.dart';
import '../../Service/NewCustCodeCreate/NewAddCreatePatchApi.dart';
import '../../ServiceLayerAPIss/QuotationAPI/QuotPatchAPI.dart';
import '../../Widgets/AlertBox.dart';
import '../../Pages/SalesOrder/Widgets/SOBar.dart';
import '../../Service/AccountBalanceAPI.dart';
import '../../Service/SchemeOrderApi.dart';
import '../../ServiceLayerAPIss/QuotationAPI/LoginnAPI.dart';
import '../../ServiceLayerAPIss/QuotationAPI/GetQuotationAPI.dart';
import '../../ServiceLayerAPIss/QuotationAPI/QuotationCancelAPI.dart';
import '../../Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class SalesQuotationCon extends ChangeNotifier {
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
  bool editqty = false;
  List<searchModel> searchData = [];
  bool searchmapbool = false;
  List<FocusNode> focusnode = List.generate(100, (i) => FocusNode());
  String holddocentry = '';

  CustomerDetals? selectedcust;
  CustomerDetals? get getselectedcust => selectedcust;
  CustomerDetals? selectedcust55;
  CustomerDetals? get getselectedcust55 => selectedcust55;
  List<SalesModel> salesmodl = [];
  List<SalesModel> onHold = [];
  List<SalesModel>? onHoldFilter = [];
  // int? documententryno;
  String? totquantity;
  double? discountamt;
  List<QuotDocumentLine> sapSsalesQuoline = [];
  List<QuotDocumentLine> sapcancelline = [];
  bool schemebtnclk = false;
  bool cancelbtn = false;
  List<searchModel> filtersearchData = [];
  String? custerrormsg = '';
  TotalPayment? totalPayment2;
  TotalPayment? get gettotalPayment2 => totalPayment2;
  List<PaymentWay> paymentWay2 = [];
  List<PaymentWay> get getpaymentWay2 => paymentWay2;

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  String sapDocentry = '';
  String sapDocuNumber = '';
  String cancelDocnum = '';
  int? cancelDocEntry;

  String? seriesNumvalue;
  String? custseriesNo;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  bool loadingBtn = false;
  bool addLoadingBtn = true;

  String? teriteriValue;
  String? codeValue;
  String? paygrpValue;
  bool OndDisablebutton = false;

  /// list searched data to choose
  TextEditingController searchcon = TextEditingController();
  List<SeriesModelData> seriesData = [];
  List<ErrorModel> sererrorlist = [];
  double? tottpaid;
  String? baltopay;

  String exception = '';
  bool loading = false;
  bool? fileValidation = false;
  File? tinFiles;
  File? vatFiles;

  FilePickerResult? result;
  List<FilesData> filedata = [];
  List<GroupCustData> groupcData = [];
  List<GetTeriteriData> teriteritData = [];
  List<GetPayGrpData>? paygroupData = [];
  bool groCustLoad = false;
//dropdown
  String? selectedValue;
  String? get getselectedValue => selectedValue;

  bool searchbool = false;
  double? totwieght = 0.0;
  double? totLiter = 0.0;
  String? shipaddress = "";
  int? tabledocentry;

  List<CustomerDetals> custList = [];
  List<CustomerDetals> filtercustList = [];
  List<CustomerDetals> get getfiltercustList => filtercustList;

  int selectedCustomer = 0;
  int get getselectedCustomer => selectedCustomer;
  // cus functions

  bool checkboxx = false;
  int selectedBillAdress = 0;
  int? get getselectedBillAdress => selectedBillAdress;

  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;
  List<Address> billadrrssItemlist = [];
  List<Address> shipadrrssItemlist = [];
  List<AccountBalanceModelData> accBalList = [];
  List<PaymentWay> paymentWay = [];
  List<PaymentWay> get getpaymentWay => paymentWay;
  String textError = '';
  String vatfileError = '';
  String tinfileError = '';

  TotalPayment? totalPayment;
  TotalPayment? get gettotalPayment => totalPayment;

  String? msgforAmount;
  String? get getmsgforAmount => msgforAmount;

  static List<QuatationLines> itemsDocDetails = [];

  void init(BuildContext context, ThemeData theme) {
    clearAllData(context, theme);
    clearAll(context, theme);
    injectToDb();
    getCustDetFDB();
    getdraftindex();
    CustSeriesApi();
    notifyListeners();
  }

  clearAll(BuildContext context, ThemeData theme) {
    mycontroller = List.generate(150, (i) => TextEditingController());
    searchcontroller = TextEditingController();
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    checkboxx = false;
    selectedcust = null;
    selectedcust2 = null;
    scanneditemData2 = [];
    searchData.clear();
    custList.clear();
    filtercustList.clear();
    custList2.clear();
    selectedBillAdress = 0;
    getSearchedData = [];
    notifyListeners();
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
    final Database db = (await DBHelper.getInstance())!;
    getSearchedData = await DBOperation.getSearchedStockList(db, data);
    getfilterSearchedData = getSearchedData;
    log("getOrderSearchedData ${getSearchedData.length}");
    searchcon.clear();
    notifyListeners();

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

// singleitemsearch( BuildContext context, ThemeData theme, int indx){

  singleitemsearch(BuildContext context, ThemeData theme, int indx) async {
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
          notifyListeners();
        } else {
          Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
        }
      } else {
        addSannedItem(indx, context, theme);
        notifyListeners();
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
      notifyListeners();
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

  postincrementQty(
      int indxs, String qty, BuildContext context, ThemeData theme) {
    postqtychangemtd(indxs, qty, context, theme);
  }

  qtyEdited(int indx, BuildContext context, ThemeData theme) async {
    double removeqty = 0;
    log("scaQtyyy : ${qtymycontroller[indx].text.toString()}");

    if (qtymycontroller[indx].text.isEmpty ||
        double.parse(qtymycontroller[indx].text.toString()) == removeqty) {
      discountcontroller.removeAt(indx);
      qtymycontroller.removeAt(indx);
      scanneditemData.removeAt(indx);
      calCulateDocVal(context, theme);
      notifyListeners();
    } else {
      //log("textErrortextErrortextErrorFFF");
      incrementQty(indx, '0', context, theme);
      notifyListeners();
    }

    notifyListeners();
  }

  postqtyreadonly() {
    editqty = true;
    notifyListeners();
  }

  postqtyEdited(int indx, BuildContext context, ThemeData theme) async {
    double removeqty = 0;
    log("scaQtyyy : ${qtymycontroller2[indx].text.toString()}");

    if (qtymycontroller2[indx].text.isEmpty ||
        double.parse(qtymycontroller2[indx].text.toString()) == removeqty) {
      discountcontroller2.removeAt(indx);
      qtymycontroller2.removeAt(indx);
      scanneditemData2.removeAt(indx);
      calCulateDocVal2(context, theme);
      notifyListeners();
    } else {
      postincrementQty(indx, '0', context, theme);
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
        ItemCode: getfilterSearchedData != null
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

  postqtychangemtd(int ind, String qty, BuildContext context, ThemeData theme) {
    String added = (int.parse(qty) +
            int.parse(qtymycontroller2[ind].text.isEmpty
                ? '0'
                : qtymycontroller2[ind].text))
        .toString();
    qtymycontroller2[ind].text = added;
    scanneditemData2[ind].Qty = int.parse(added);
    calCulateDocVal2(context, theme);
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

// new draft hold

  calculatescheme(BuildContext context, ThemeData theme) async {
    double discount = 0;
    log('discount1::${resSchemeDataList.length}');

    for (int ik = 0; ik < resSchemeDataList.length; ik++) {
      //log('discount2::${resSchemeDataList.length}');

      //log('discount3::${resSchemeDataList[ik].lineNum}');
      discount = 0;

      for (int i = 0; i < scanneditemData.length; i++) {
        // discountcontroller[i].text=0.toString();
        //log('discount4::${scanneditemData[i].TransID}');

        if (resSchemeDataList[ik].lineNum == scanneditemData[i].TransID) {
          discount = discount + resSchemeDataList[ik].discPer;
          discountcontroller[i].text = discount.toString();
          //log('discount5::${discountcontroller[i].text}');

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
      //log('discount4::${scanneditemData[i].TransID}');
      discountcontroller[i].text = 0.0.toString();
      //log('discount5::${discountcontroller[i].text}');

      notifyListeners();
    }
    log("schemeData::${schemeData.length}");
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
    log('Step1');
    for (int i = 0; i < scanneditemData.length; i++) {
      //log('Step2');

      schemeData.add(SalesOrderScheme(
        ItemCode: scanneditemData[i].ItemCode.toString(),
        PriceBefDi: scanneditemData[i].SellPrice.toString(),
        Quantity: scanneditemData[i].Qty.toString(),
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

  void selectVatattachment() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      vatfileError = "";

      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      for (int i = 0; i < filesz.length; i++) {
        vatFiles = filesz[i];
        notifyListeners();
      }
    } else {
      textError = "Select a VAT File";
    }
    notifyListeners();
  }

  clearVatFile() {
    vatFiles = null;
    notifyListeners();
  }

  void selectattachment() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      print(tinFiles);
      tinfileError = "";
      for (int i = 0; i < filesz.length; i++) {
        tinFiles = filesz[i];
        notifyListeners();
      }
    } else if (tinFiles == null) {
      tinfileError = "Select a Tin File";
      notifyListeners();
    }
    notifyListeners();
  }

  CustSeriesApi() async {
    mycontroller[24].text = '139';
    await GetSeriesApiAPi.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.seriescustData != null) {
          seriesData = value.seriescustData!;
          notifyListeners();
        } else {
          custserieserrormsg = value.message!.toString();
          notifyListeners();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custserieserrormsg = value.message!.toString();
        notifyListeners();
      } else {
        custserieserrormsg = value!.message!.toString();
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

  clickaEditBtn(BuildContext context, ThemeData theme) async {
    // if (sapDocentry.isNotEmpty) {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getheaderData =
        await DBOperation.salesQuoCancellQuery(db, cancelDocEntry.toString());
    if (getheaderData.isNotEmpty) {
      if (getheaderData[0]['basedocentry'].toString() ==
          cancelDocEntry.toString()) {
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
                          'This document is already converted into sales order',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          cancelDocnum = '';
          sapDocentry = '';
          sapDocuNumber = '';
          selectedcust = null;
          selectedcust55 = null;
          paymentWay.clear();
          scanneditemData.clear();
          cancelbtn = false;
          selectedcust55 = null;
          selectedcust = null;
          scanneditemData.clear();
          totalPayment = null;
          injectToDb();
          getdraftindex();
          remarkcontroller3.text = '';
          searchmapbool = false;
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
                    content: 'Something went wrong..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        cancelDocnum = '';
        sapDocentry = '';
        sapDocuNumber = '';
        selectedcust = null;
        selectedcust55 = null;
        paymentWay.clear();
        scanneditemData.clear();
        cancelbtn = false;
        selectedcust55 = null;
        selectedcust = null;
        scanneditemData.clear();
        totalPayment = null;
        injectToDb();
        getdraftindex();
        remarkcontroller3.text = '';
        searchmapbool = false;
        notifyListeners();
      });
    } else {
      await sapLoginApi(context);
      await callSerlaySalesQuoAPI(context, theme);
      await checkSAPsts(context, theme);
      notifyListeners();
    }
  }

  checkSAPsts(BuildContext context, ThemeData theme) async {
    if (sapSsalesQuoline.isNotEmpty) {
      for (int ij = 0; ij < sapSsalesQuoline.length; ij++) {
        if (sapSsalesQuoline[ij].lineStatus == "bost_Open") {
          await updateFixDataMethod(context, theme);
        } else if (sapSsalesQuoline[ij].lineStatus == "bost_Close") {
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

  clickacancelbtn(BuildContext context, ThemeData theme) async {
    if (sapDocentry.isNotEmpty) {
      final Database db = (await DBHelper.getInstance())!;
      List<Map<String, Object?>> getheaderData =
          await DBOperation.salesQuoCancellQuery(db, cancelDocEntry.toString());
      if (getheaderData.isNotEmpty) {
        if (getheaderData[0]['basedocentry'].toString() ==
            cancelDocEntry.toString()) {
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
                            'This document is already converted into sales order',
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
            searchmapbool = false;
            notifyListeners();
          });
        }
      } else {
        await sapLoginApi(context);
        await callSerlaySalesQuoAPI(context, theme);
        await callSerlaySalesCancelQuoAPI(context, theme);
        notifyListeners();
      }
    } else {
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
        searchmapbool = false;
        notifyListeners();
      });

      //log("BBBBBBBBBBBBBBBBBBBBBB");
    }
  }

  sapLoginApi(BuildContext context) async {
    final pref2 = await pref;

    await PostLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          //log("sessionID: " + value.sessionId.toString());
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
            duration: Duration(seconds: 4),
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
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: Text(
            "Opps Somthing went wrong !!..",
            style: const TextStyle(color: Colors.white),
          ),
        );
      } else {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.bodyheight(context) * 0.3,
          ),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: Text(
            "Opps Somthing went wrong !!..",
            style: const TextStyle(color: Colors.white),
          ),
        );
      }
    });
  }

  getSession() async {
    var preff = await SharedPreferences.getInstance();
    AppConstant.sapSessionID = preff.getString('sessionId')!;
    log("AppConstant.sapSessionID xx::${AppConstant.sapSessionID}");
  }

  callSerlaySalesQuoAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    log("sapDocentrysapDocentrysapDocentry:::$sapDocentry");

    await SerlaySalesQuoAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.documentLines!.isNotEmpty) {
          sapSsalesQuoline = value.documentLines!;
          //log("sapSsalesQuolinesapSsalesQuoline::${sapSsalesQuoline[0].lineStatus}");

          custserieserrormsg = '';
        } else {
          //log("Error11");

          // custserieserrormsg = value.message!.toString();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        //log("Error22");
        cancelbtn = false;
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

        // custserieserrormsg = value.message!.toString();
      }
    });
  }

  custCodeReadOnly() {
    log('seriesValueAA ${custseriesNo}');
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

  String cardCodexx = '';

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

  callCustPostApi(BuildContext context) async {
    loadingBtn = true;
    await addFiles();
    await sapLoginApi(context);
    log("App constatant fff ::::${AppConstant.sapSessionID}");

    NewCutomerModel newCutomerModel = NewCutomerModel();

    for (int i = 0; i < filedata.length; i++) {
      await FilePostApi.getFilePostData(
              filedata[i].fileBytes, filedata[i].fileName)
          .then((value) {
        if (value.stCode! >= 200 && value.stCode! <= 210) {
          //log("Api PAth $i: " + value.filepath.toString());
          if (i == 0) {
            newCutomerModel.tincer = value.filepath!;
            notifyListeners();
          } else if (i == 1) {
            newCutomerModel.vatcer = value.filepath!;
            notifyListeners();
          }
        } else if (value.stCode! >= 400 && value.stCode! <= 410) {
        } else {
          //   // fileException.add(value.exception!);
        }
      });
    }

    newCutomerModel.cardCode =
        mycontroller[3].text.isEmpty ? null : mycontroller[3].text;
    newCutomerModel.cardName = mycontroller[6].text;
    newCutomerModel.grupCode = codeValue == null ? null : int.parse(codeValue!);
    newCutomerModel.AdditionalID = mycontroller[22].text;
    newCutomerModel.FederalTaxID = mycontroller[23].text;
    newCutomerModel.Cellular = mycontroller[4].text;
    newCutomerModel.SalesPersonCode =
        mycontroller[24].text.isEmpty ? null : int.parse(mycontroller[24].text);
    newCutomerModel.ContactPerson = mycontroller[25].text;
    newCutomerModel.CreditLimit = mycontroller[26].text.isEmpty
        ? null
        : int.parse(
            mycontroller[26].text.replaceAll(",", "").replaceAll(".", ""));
    newCutomerModel.Notes = mycontroller[27].text;
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
    newCutomerModel.contEmp = [ContactEmployees(name: mycontroller[25].text)];
    await PostCustCreateAPi.getGlobalData(newCutomerModel).then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.CardCode.toString();

        await insertAddNewCusToDB(context);


        // Navigator.pop(context);
        config.showDialogSucessB(
            "Customer Created Successfully ..!!", "Sucess");
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config
            .showDialogg("Something went wrong try agian..!!", "Failed")
            .then((value) => Navigator.pop(context));
      }
    });
    notifyListeners();
  }

  // Future<void> callApi() async {
  //   final preff = await SharedPreferences.getInstance();
  //     GetCustomerAPi.slpCode = preff.getString('SlpCode');
  //     print("slpccode222: " + GetCustomerAPi.slpCode.toString());
  // await GetCustomerAPi.getGlobalData().then((value) {
  //     if (value.CustomerData != null) {
  //       if (value.CustomerData!.length > 0) {
  //         print("Customervalue!.length: " +
  //             value.CustomerData!.length.toString());
  //           //print( "salesPersonCode: "+value.Customervalue![0].salesPersonCode!.toStringAsFixed(0));
  //           // value.Customervalue![0].salesPersonCode!.toStringAsFixed(0);
  //           //  print("nextLink: "+value.nextLink.toString());
  //           customerData = value.CustomerData!;
  //           customerDataFilter = customerData;
  //           // GetCustomerAPi.nextUrl = value.nextLink;
  //           lenthofList = customerDataFilter.length;
  //           // print("lenthofList: "+lenthofList.toString());
  //           // print("U_CASHCUST: "+customerData[1].businessPartners!.U_CASHCUST.toString());
  //           //  print("leng..."+customerData.length.toString());
  //           //  print("cardcode: "+customerData[0].cardCode.toString());
  //           //  print("cardname: "+customerData[1].cardCode.toString());
  //           notifyListeners();
  //       }
  //     } else if (value.error != null) {
  //       final snackBar = SnackBar(
  //         duration: const Duration(seconds: 5),
  //         backgroundColor: Colors.red,
  //         content: Text(
  //           '${value.error}!!..',
  //           style: const TextStyle(color: Colors.white),
  //         ),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       Future.delayed(const Duration(seconds: 5), () {
  //         Navigator.pop(context);
  //       });
  //     }

  //     // scrollController.addListener(() {
  //     //   if(scrollController.position.pixels ==
  //     //       scrollController.position.maxScrollExtent) {
  //     //     if (mycontroller[0].text.isEmpty) {
  //     //       // getmoredata();
  //     //     }
  //     //   }
  //     //   // else if (scrollController.position.pixels !=
  //     //   //     scrollController.position.maxScrollExtent) {
  //     //   //   print("heelllllloo");
  //     //   // }
  //     // });
  //   });
  // }

  callSerlaySalesCancelQuoAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    if (sapSsalesQuoline.isNotEmpty) {
      for (int ij = 0; ij < sapSsalesQuoline.length; ij++) {
        if (sapSsalesQuoline[ij].lineStatus == "bost_Open") {
          await SerlayCancelQuoAPI.getData(sapDocentry.toString())
              .then((value) async {
            if (value.statusCode! >= 200 && value.statusCode! <= 204) {
              cancelbtn = false;
              //log("sapSsalesQuolinesapSsalesQuoline::${sapSsalesQuoline[0].lineStatus}");
              await DBOperation.updateSalesQuoclosedocsts(
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
                selectedcust25 = null;
                notifyListeners();
              });
              custserieserrormsg = '';
              notifyListeners();
            } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
              cancelbtn = false;

              //log("Error22");
              custserieserrormsg = value.exception!.message.toString();
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
        } else if (sapSsalesQuoline[ij].lineStatus == "bost_Close") {
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
    }
  }

  getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;
    List<HoldedHeader> holdData = [];
    fileterHoldData = [];
    List<Map<String, Object?>> getholddata =
        await DBOperation.getSalesQuoHeadHoldvalueDB(db);
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
        await DBOperation.getSalesQuoLineDB(
            db, int.parse(holddata.docEntry.toString()));

    List<Map<String, Object?>> getcustomer =
        await DBOperation.getCstmMasDatabyautoid(
            db, holddata.Cardcode.toString());

    List<Map<String, Object?>> getcustaddd =
        await DBOperation.addgetCstmMasAddDB(db, holddata.Cardcode.toString());

    holddocentry = holddata.docEntry.toString();

    mapCustomer(context, theme, getcustomer, getcustaddd);
    mapProdcut(getDBholdSalesLine, context, theme);
    getCustDetFDB();
    calCulateDocVal(context, theme);

    // await DBOperation.deleteHoldMaped(db, holddata.docEntry!).then((value) {
    //   holdData.clear();
    // await getdraftindex();
    //   //log('datatatatatatata deleleleleleelle ');
    // });
    notifyListeners();
  }

  mapCustomer(
      BuildContext context,
      ThemeData theme,
      List<Map<String, Object?>> custData,
      List<Map<String, Object?>> getcustaddd) async {
    final Database db = (await DBHelper.getInstance())!;
    double? updateCustBal1;
    selectedcust = null;
    selectedcust55 = null;
    List<Map<String, Object?>> getholddata =
        await DBOperation.getSalesQuoHeadHoldvalueDB(db);
    selectedcust = CustomerDetals(
      name: custData[0]['customername'].toString(),
      phNo: custData[0]['phoneno1'].toString(),
      cardCode: custData[0]['customercode'].toString(),
      // accBalance: double.parse(custData[0]['balance'].toString()),
      point: custData[0]['points'].toString(),
      address: [],
      email: custData[0]['emalid'].toString(),
      tarNo: custData[0]['taxno'].toString(),
      autoId: custData[0]['autoid'].toString(),
    );
    notifyListeners();

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
            notifyListeners();
          }
        }

        if (getholddata[ik]['shipaddresid'].toString().isNotEmpty) {
          if (getholddata[ik]['shipaddresid'].toString() ==
              getcustaddd[i]['autoid'].toString()) {
            selectedcust55 = CustomerDetals(
              name: custData[0]['customername'].toString(),
              phNo: custData[0]['phoneno1'].toString(),
              cardCode: custData[0]['customercode'].toString(),
              // accBalance: double.parse(custData[0]['balance'].toString()),
              point: custData[0]['points'].toString(),
              address: [],
              email: custData[0]['emalid'].toString(),
              tarNo: custData[0]['taxno'].toString(),
              // autoId: int.parse(custData[0]['autoid'].toString()),
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
            notifyListeners();
          }
        }
      }
    }
    await AccountBalApi.getData(selectedcust!.cardCode.toString())
        .then((value) {
      loadingscrn = false;
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        updateCustBal1 =
            double.parse(value.accBalanceData![0].balance.toString());

        notifyListeners();
      }
    });
    selectedcust!.accBalance =
        updateCustBal1 ?? double.parse(custData[0]['balance'].toString());
    selectedcust55!.accBalance =
        updateCustBal1 ?? double.parse(custData[0]['balance'].toString());
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
      //log("lineData[i]['discperc'] lineData[i]['discperc'] ::${lineData[i]['discperc'].toString()}");
    }
    notifyListeners();
    for (int ig = 0; ig < scanneditemData.length; ig++) {
      //log('  discountcontroller[ig].text:: ${discountcontroller[ig].text}');

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
        couponcode: "", //getDBholdSalespay[i]['couponcode'].toString(),
        coupontype: "", //getDBholdSalespay[i]['coupontype'].toString(),
        discountcode: payment[i]['discountcode'].toString(),
        discounttype: payment[i]['discounttype'].toString(),
        // creditref: getDBholdSalespay[i]['creditref'].toString(),
        recoverydate: payment[i]['recoverydate'].toString(),
        redeempoint: payment[i]['redeempoint'].toString(),
        availablept: payment[i]['availablept'].toString(),
        remarks: payment[i]['remarks'].toString(),
        // transref: getDBholdSalespay[i]['transref'].toString(),
        transtype: payment[i]['transtype'].toString(),
        walletid: payment[i]['walletid'].toString(),
        // walletref: getDBholdSalespay[i]['walletref'].toString(),
        wallettype: payment[i]['wallettype'].toString(),
      ));
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
      //log(datetype);
    } else if (pickedDate != null && datetype == "To") {
      print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      mycontroller[101].text = datetype!;
      //log(datetype);
    } else {
      //log("Date is not selected");
    }
  }

  searchInitMethod() {
    mycontroller[100].text = config.alignDate(config.currentDate());
    mycontroller[101].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  // searchMainMethod(String fromDate, String toDate) {
  //   mycontroller[100].text = config.alignDate(config.currentDate());
  //   mycontroller[101].text = config.alignDate(config.currentDate());
  //   notifyListeners();
  // }

  getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getSalesquoDateWise(
            db,
            config.alignDate2(fromdate.trim()),
            config.alignDate2(todate.trim()));

    List<searchModel> searchdata2 = [];
    searchData.clear();
    filtersearchData.clear();
    for (int i = 0; i < getSalesHeader.length; i++) {
      searchdata2.add(searchModel(
          username: UserValues.username,
          terminal: AppConstant.terminal,
          type: "Sales Quotation",
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
    //log("header::" + getSalesHeader.toString());
    //log("Line::" + getSalesLine.toString());
    //log("Pay::" + getSalesPay.toString());
    searchbool = false;
    notifyListeners();
  }

  fixDataMethod(int docentry) async {
    editqty = false;
    searchmapbool = false;
    mycontroller2[50].text = "";
    shipaddress = "";
    sapDocentry = '';
    sapDocuNumber = '';
    cancelDocnum = '';
    cancelDocEntry = null;
    paymentWay2.clear();
    totwieght = 0.0;
    totLiter = 0.0;
    scanneditemData2 = [];
    totalPayment2 = null;
    selectedcust2 = null;
    salesmodl = [];
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalesQuoHeader =
        await DBOperation.getSaleQuorHeaderDB(db, docentry);
    List<Map<String, Object?>> getDBSalesquotLine =
        await DBOperation.getSalesQuoLineDB(db, docentry);

    int? totalQuantity = 0;
    sapDocentry = getDBSalesQuoHeader[0]['sapDocentry'] != null
        ? getDBSalesQuoHeader[0]['sapDocentry'].toString()
        : "";
    cancelDocnum = getDBSalesQuoHeader[0]['documentno'] != null
        ? getDBSalesQuoHeader[0]['documentno'].toString()
        : "";
    cancelDocEntry = int.parse(getDBSalesquotLine[0]['docentry'].toString());
    sapDocuNumber = getDBSalesQuoHeader[0]['sapDocNo'] != null
        ? getDBSalesQuoHeader[0]['sapDocNo'].toString()
        : "";

    mycontroller2[50].text = getDBSalesQuoHeader[0]['remarks'] != null
        ? getDBSalesQuoHeader[0]['remarks'].toString()
        : "";
    totwieght = double.parse(getDBSalesQuoHeader[0]['totalweight'].toString());
    totLiter = double.parse(getDBSalesQuoHeader[0]['totalltr'].toString());

    for (int ik = 0; ik < getDBSalesquotLine.length; ik++) {
      scanneditemData2.add(StocksnapModelData(
          basic: getDBSalesquotLine[ik]['basic'] != null
              ? double.parse(getDBSalesquotLine[ik]['basic'].toString())
              : 00,
          netvalue: getDBSalesquotLine[ik]['netlinetotal'] != null
              ? double.parse(getDBSalesquotLine[ik]['netlinetotal'].toString())
              : null,
          TransID: int.parse(getDBSalesquotLine[ik]['docentry'].toString()),
          Branch: getDBSalesquotLine[ik]['branch'].toString(),
          ItemCode: getDBSalesquotLine[ik]['itemcode'].toString(),
          ItemName: getDBSalesquotLine[ik]['itemname'].toString(),
          SerialBatch: getDBSalesquotLine[ik]['serialbatch'].toString(),
          OpenQty: int.parse(getDBSalesquotLine[ik]['quantity'].toString()),
          Qty: int.parse(getDBSalesquotLine[ik]['quantity'].toString()),
          InDate: getDBSalesquotLine[ik][''].toString(),
          InType: getDBSalesquotLine[ik][''].toString(),
          VenCode: getDBSalesquotLine[ik][''].toString(),
          VenName: getDBSalesquotLine[ik][''].toString(),
          MRP: 0,
          SellPrice: double.parse(getDBSalesquotLine[ik]['price'].toString()),
          Cost: 0,
          discount: getDBSalesquotLine[ik]['discperunit'] != null
              ? double.parse(getDBSalesquotLine[ik]['discperunit'].toString())
              : 00,
          taxvalue: getDBSalesquotLine[ik]['taxtotal'] != null
              ? double.parse(getDBSalesquotLine[ik]['taxtotal'].toString())
              : 00,
          TaxRate: double.parse(getDBSalesquotLine[ik]['taxrate'].toString()),
          TaxType: getDBSalesquotLine[ik]['taxtype'].toString(),
          Maxdiscount: getDBSalesquotLine[ik]['maxdiscount'].toString(),
          discountper: getDBSalesquotLine[ik]['discperc'] == null
              ? 0.0
              : double.parse(getDBSalesquotLine[ik]['discperc'].toString()),
          createdUserID: '',
          createdateTime: '',
          lastupdateIp: '',
          purchasedate: '',
          snapdatetime: '',
          specialprice: 0,
          updatedDatetime: '',
          updateduserid: '',
          liter: getDBSalesquotLine[ik]['liter'] == null
              ? 0.0
              : double.parse(getDBSalesquotLine[ik]['liter'].toString()),
          weight: getDBSalesquotLine[ik]['weight'] == null
              ? 0.0
              : double.parse(getDBSalesquotLine[ik]['weight'].toString())));

      //discperc
      totquantity = getDBSalesquotLine[ik]['quantity'].toString();
      qtymycontroller2[ik].text = getDBSalesquotLine[ik]['quantity'] == null
          ? "0"
          : getDBSalesquotLine[ik]['quantity'].toString();
      mycontroller2[ik].text = getDBSalesquotLine[ik]['discperc'] == null
          ? "0"
          : getDBSalesquotLine[ik]['discperc'].toString();
      discountamt = getDBSalesquotLine[ik]['discperc'] != null
          ? double.parse(getDBSalesquotLine[ik]['discperc'].toString())
          : 0;
      notifyListeners();
    }
    for (int i = 0; i < scanneditemData2.length; i++) {
      scanneditemData2[i].Qty = int.parse(qtymycontroller2[i].text.toString());
      discountcontroller2[i].text = scanneditemData2[i].discountper.toString();
      scanneditemData2[i].TransID = i;
      //  log("controller2" + qtymycontroller2[i].text.toString());
      totalQuantity =
          totalQuantity! + int.parse(qtymycontroller2[i].text.toString());

      notifyListeners();
    }
    notifyListeners();

    totalPayment2 = TotalPayment(
      discount2: getDBSalesQuoHeader[0]['docdiscamt'] == null
          ? 0.00
          : double.parse(getDBSalesQuoHeader[0]['docdiscamt'].toString()),
      discount: getDBSalesQuoHeader[0]['docdiscamt'] == null
          ? 0.00
          : double.parse(getDBSalesQuoHeader[0]['docdiscamt'].toString()),
      totalTX: double.parse(getDBSalesQuoHeader[0]['taxamount'] == null
          ? '0'
          : getDBSalesQuoHeader[0]['taxamount'].toString().replaceAll(',', '')),

      subtotal: double.parse(getDBSalesQuoHeader[0]['docbasic'] == null
          ? '0'
          : getDBSalesQuoHeader[0]['docbasic']
              .toString()
              .replaceAll(',', '')), //doctotal

      total: totalQuantity,
      totalDue: double.parse(getDBSalesQuoHeader[0]['doctotal'] == null
          ? '0'
          : getDBSalesQuoHeader[0]['doctotal'].toString().replaceAll(',', '')),
      // totpaid: double.parse(getDBSalesQuoHeader[0]['amtpaid'] == null
      //     ? '0'
      //     : getDBSalesQuoHeader[0]['amtpaid'].toString().replaceAll(',', '')),
    );
    shipaddress = getDBSalesQuoHeader[0]['shipaddresid'].toString();

    List<Address>? address2 = [];
    List<Address>? address25 = [];
    List<CustomerAddressModelDB> csadresdataDB =
        await DBOperation.getCstmMasAddDB(
      db,
    );
    for (int k = 0; k < csadresdataDB.length; k++) {
      if (csadresdataDB[k].custcode.toString() ==
          getDBSalesQuoHeader[0]['customercode'].toString()) {
        if (csadresdataDB[k].autoid.toString() ==
            getDBSalesQuoHeader[0]['billaddressid'].toString()) {
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
        if (getDBSalesQuoHeader[0]['shipaddresid'].toString().isNotEmpty) {
          if (csadresdataDB[k].autoid.toString() ==
              getDBSalesQuoHeader[0]['shipaddresid'].toString()) {
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
    SalesModel salesM = SalesModel(
      ordReference: getDBSalesQuoHeader[0]['remarks'].toString(),
      objname: getDBSalesQuoHeader[0]['objname'].toString(),
      objtype: getDBSalesQuoHeader[0]['objtype'].toString(),
      doctype: getDBSalesQuoHeader[0]['doctype'].toString(),
      docentry: int.parse(getDBSalesQuoHeader[0]['docentry'].toString()),
      custName: getDBSalesQuoHeader[0]['customername'].toString(),
      phNo: getDBSalesQuoHeader[0]['customerphono'].toString(),
      cardCode: getDBSalesQuoHeader[0]['customercode'].toString(),
      accBalance: getDBSalesQuoHeader[0]['customeraccbal'].toString(),
      point: getDBSalesQuoHeader[0]['customerpoint'].toString(),
      tarNo: getDBSalesQuoHeader[0]['taxno'].toString(),
      email: getDBSalesQuoHeader[0]['customeremail'].toString(),
      invoceDate: getDBSalesQuoHeader[0]['createdateTime'].toString(),
      invoiceNum: getDBSalesQuoHeader[0]['documentno'].toString(),
      // sapOrderNum: getDBSalesQuoHeader[0]['basedocentry'].toString(),
      sapInvoiceNum: getDBSalesQuoHeader[0]['sapDocNo'].toString(),
      item: scanneditemData2,
    );

    notifyListeners();

    salesmodl.add(salesM);
    log(salesmodl.length.toString());
    selectedcust2 = CustomerDetals(
      name: getDBSalesQuoHeader[0]["customername"]
          .toString(), // customername!.name
      phNo: getDBSalesQuoHeader[0]["customerphono"].toString(), //customerphono
      docentry: getDBSalesQuoHeader[0]["docentry"].toString(),
      cardCode: getDBSalesQuoHeader[0]["customercode"]
          .toString(), //customercode!.cardCode
      accBalance: double.parse(
          getDBSalesQuoHeader[0]["customeraccbal"].toString()), //customeraccbal
      point: getDBSalesQuoHeader[0]["customerpoint"].toString(), //customerpoint
      address: address2,
      tarNo: getDBSalesQuoHeader[0]["taxno"].toString(), //taxno
      email: getDBSalesQuoHeader[0]["customeremail"].toString(), //customeremail
      invoicenum: getDBSalesQuoHeader[0]['documentno'] != null
          ? getDBSalesQuoHeader[0]['documentno'].toString()
          : "",
      invoiceDate: getDBSalesQuoHeader[0]["createdateTime"].toString(),
      totalPayment: getDBSalesQuoHeader[0]["doctotal"] == null
          ? 0.0
          : double.parse(getDBSalesQuoHeader[0]["doctotal"].toString()),
    );
    selectedcust25 = CustomerDetals(
      name: getDBSalesQuoHeader[0]["customername"]
          .toString(), // customername!.name
      phNo: getDBSalesQuoHeader[0]["customerphono"].toString(), //customerphono
      docentry: getDBSalesQuoHeader[0]["docentry"].toString(),
      cardCode: getDBSalesQuoHeader[0]["customercode"]
          .toString(), //customercode!.cardCode
      accBalance: double.parse(
          getDBSalesQuoHeader[0]["customeraccbal"].toString()), //customeraccbal
      point: getDBSalesQuoHeader[0]["customerpoint"].toString(), //customerpoint
      address: address25,
      tarNo: getDBSalesQuoHeader[0]["taxno"].toString(), //taxno
      email: getDBSalesQuoHeader[0]["customeremail"].toString(), //customeremail
      invoicenum: getDBSalesQuoHeader[0]["documentno"].toString(),
      invoiceDate: getDBSalesQuoHeader[0]["createdateTime"].toString(),
      totalPayment: getDBSalesQuoHeader[0]["doctotal"] == null
          ? 0.0
          : double.parse(getDBSalesQuoHeader[0]["doctotal"].toString()),
    );
    notifyListeners();
    log("selectedcust25!.address!length::" +
        selectedcust25!.address!.length.toString());
    int? totqty;

    notifyListeners();
    selectedBillAdress = selectedcust2!.address!.length - 1;
    selectedShipAdress = selectedcust25!.address!.length - 1;
    notifyListeners();
    searchmapbool = false;
  }

  updateFixDataMethod(BuildContext context, ThemeData theme) async {
    mycontroller2[50].text = "";
    paymentWay2.clear();
    totwieght = 0.0;
    totLiter = 0.0;
    scanneditemData2 = [];
    scanneditemData = [];
    totalPayment2 = null;
    totalPayment = null;
    selectedcust2 = null;
    selectedcust = null;
    editqty = false;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalesQuoHeader =
        await DBOperation.getSaleQuorHeaderDB(db, cancelDocEntry!);

    List<Map<String, Object?>> getDBSalesquotLine =
        await DBOperation.getSalesQuoLineDB(db, cancelDocEntry!);

    int? totalQuantity = 0;
    // sapDocentry = getDBSalesQuoHeader[0]['sapDocentry'] != null ? getDBSalesQuoHeader[0]['sapDocentry'].toString() : "";
    // cancelDocnum = getDBSalesQuoHeader[0]['documentno'] != null ? getDBSalesQuoHeader[0]['documentno'].toString() : "";
    cancelDocEntry = int.parse(getDBSalesquotLine[0]['docentry'].toString());
    // sapDocuNumber = getDBSalesQuoHeader[0]['sapDocNo'] != null ? getDBSalesQuoHeader[0]['sapDocNo'].toString() : "";
    mycontroller2[50].text = getDBSalesQuoHeader[0]['remarks'] != null
        ? getDBSalesQuoHeader[0]['remarks'].toString()
        : "";
    totwieght = double.parse(getDBSalesQuoHeader[0]['totalweight'].toString());
    totLiter = double.parse(getDBSalesQuoHeader[0]['totalltr'].toString());
    if ((getDBSalesQuoHeader[0]['sapDocNo'].toString() != null ||
            getDBSalesQuoHeader[0]['sapDocNo'].toString().isNotEmpty) &&
        getDBSalesQuoHeader[0]['qStatus'].toString() == "C") {
      postqtyreadonly();
      for (int ik = 0; ik < getDBSalesquotLine.length; ik++) {
        scanneditemData.add(StocksnapModelData(
            basic: getDBSalesquotLine[ik]['basic'] != null
                ? double.parse(getDBSalesquotLine[ik]['basic'].toString())
                : 00,
            netvalue: getDBSalesquotLine[ik]['netlinetotal'] != null
                ? double.parse(
                    getDBSalesquotLine[ik]['netlinetotal'].toString())
                : null,
            docentry: getDBSalesquotLine[ik]['docentry'].toString(),
            Branch: getDBSalesquotLine[ik]['branch'].toString(),
            ItemCode: getDBSalesquotLine[ik]['itemcode'].toString(),
            ItemName: getDBSalesquotLine[ik]['itemname'].toString(),
            SerialBatch: getDBSalesquotLine[ik]['serialbatch'].toString(),
            OpenQty: int.parse(getDBSalesquotLine[ik]['quantity'].toString()),
            Qty: int.parse(getDBSalesquotLine[ik]['quantity'].toString()),
            InDate: getDBSalesquotLine[ik][''].toString(),
            InType: getDBSalesquotLine[ik][''].toString(),
            VenCode: getDBSalesquotLine[ik][''].toString(),
            VenName: getDBSalesquotLine[ik][''].toString(),
            MRP: 0,
            SellPrice: double.parse(getDBSalesquotLine[ik]['price'].toString()),
            Cost: 0,
            discount: getDBSalesquotLine[ik]['discperunit'] != null
                ? double.parse(getDBSalesquotLine[ik]['discperunit'].toString())
                : 00,
            taxvalue: getDBSalesquotLine[ik]['taxtotal'] != null
                ? double.parse(getDBSalesquotLine[ik]['taxtotal'].toString())
                : 00,
            TaxRate: double.parse(getDBSalesquotLine[ik]['taxrate'].toString()),
            TaxType: getDBSalesquotLine[ik]['taxtype'].toString(),
            Maxdiscount: getDBSalesquotLine[ik]['maxdiscount'].toString(),
            discountper: getDBSalesquotLine[ik]['discperc'] == null
                ? 0.0
                : double.parse(getDBSalesquotLine[ik]['discperc'].toString()),
            createdUserID: '',
            createdateTime: '',
            lastupdateIp: '',
            purchasedate: '',
            snapdatetime: '',
            specialprice: 0,
            updatedDatetime: '',
            updateduserid: '',
            liter: getDBSalesquotLine[ik]['liter'] == null
                ? 0.0
                : double.parse(getDBSalesquotLine[ik]['liter'].toString()),
            weight: getDBSalesquotLine[ik]['weight'] == null
                ? 0.0
                : double.parse(getDBSalesquotLine[ik]['weight'].toString())));

        //discperc
        totquantity = getDBSalesquotLine[ik]['quantity'].toString();
        qtymycontroller[ik].text = getDBSalesquotLine[ik]['quantity'] == null
            ? "0"
            : getDBSalesquotLine[ik]['quantity'].toString();
        discountcontroller[ik].text = getDBSalesquotLine[ik]['discperc'] == null
            ? "0"
            : getDBSalesquotLine[ik]['discperc'].toString();
        discountamt = getDBSalesquotLine[ik]['discperc'] != null
            ? double.parse(getDBSalesquotLine[ik]['discperc'].toString())
            : 0;
        notifyListeners();
      }
      for (int i = 0; i < scanneditemData.length; i++) {
        scanneditemData[i].Qty = int.parse(qtymycontroller[i].text.toString());
        discountcontroller[i].text = scanneditemData[i].discountper.toString();
        scanneditemData[i].TransID = i;
        totalQuantity =
            totalQuantity! + int.parse(qtymycontroller[i].text.toString());

        notifyListeners();
      }
      notifyListeners();

      totalPayment = TotalPayment(
        discount2: getDBSalesQuoHeader[0]['docdiscamt'] == null
            ? 0.00
            : double.parse(getDBSalesQuoHeader[0]['docdiscamt'].toString()),
        discount: getDBSalesQuoHeader[0]['docdiscamt'] == null
            ? 0.00
            : double.parse(getDBSalesQuoHeader[0]['docdiscamt'].toString()),
        totalTX: double.parse(getDBSalesQuoHeader[0]['taxamount'] == null
            ? '0'
            : getDBSalesQuoHeader[0]['taxamount']
                .toString()
                .replaceAll(',', '')),

        subtotal: double.parse(getDBSalesQuoHeader[0]['docbasic'] == null
            ? '0'
            : getDBSalesQuoHeader[0]['docbasic']
                .toString()
                .replaceAll(',', '')), //doctotal

        total: totalQuantity,
        totalDue: double.parse(getDBSalesQuoHeader[0]['doctotal'] == null
            ? '0'
            : getDBSalesQuoHeader[0]['doctotal']
                .toString()
                .replaceAll(',', '')),
      );
      shipaddress = getDBSalesQuoHeader[0]['shipaddresid'].toString();

      List<Address>? address2 = [];
      List<Address>? address25 = [];
      List<CustomerAddressModelDB> csadresdataDB =
          await DBOperation.getCstmMasAddDB(
        db,
      );
      addCardCode = getDBSalesQuoHeader[0]['customercode'].toString();
      for (int k = 0; k < csadresdataDB.length; k++) {
        if (csadresdataDB[k].custcode.toString() ==
            getDBSalesQuoHeader[0]['customercode'].toString()) {
          if (csadresdataDB[k].autoid.toString() ==
              getDBSalesQuoHeader[0]['billaddressid'].toString()) {
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
          if (getDBSalesQuoHeader[0]['shipaddresid'].toString().isNotEmpty) {
            if (csadresdataDB[k].autoid.toString() ==
                getDBSalesQuoHeader[0]['shipaddresid'].toString()) {
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
      selectedcust = CustomerDetals(
        autoId: getDBSalesQuoHeader[0]["billaddressid"].toString(),
        name: getDBSalesQuoHeader[0]["customername"]
            .toString(), // customername!.name
        phNo:
            getDBSalesQuoHeader[0]["customerphono"].toString(), //customerphono
        docentry: getDBSalesQuoHeader[0]["docentry"].toString(),
        cardCode: getDBSalesQuoHeader[0]["customercode"]
            .toString(), //customercode!.cardCode
        accBalance: double.parse(getDBSalesQuoHeader[0]["customeraccbal"]
            .toString()), //customeraccbal
        point:
            getDBSalesQuoHeader[0]["customerpoint"].toString(), //customerpoint
        address: address2,
        tarNo: getDBSalesQuoHeader[0]["taxno"].toString(), //taxno
        email:
            getDBSalesQuoHeader[0]["customeremail"].toString(), //customeremail
        invoicenum: getDBSalesQuoHeader[0]['documentno'] != null
            ? getDBSalesQuoHeader[0]['documentno'].toString()
            : "",
        invoiceDate: getDBSalesQuoHeader[0]["createdateTime"].toString(),
        totalPayment: getDBSalesQuoHeader[0]["doctotal"] == null
            ? 0.0
            : double.parse(getDBSalesQuoHeader[0]["doctotal"].toString()),
      );
      selectedcust55 = CustomerDetals(
        autoId: getDBSalesQuoHeader[0]["shipaddresid"].toString(),
        name: getDBSalesQuoHeader[0]["customername"]
            .toString(), // customername!.name
        phNo:
            getDBSalesQuoHeader[0]["customerphono"].toString(), //customerphono
        docentry: getDBSalesQuoHeader[0]["docentry"].toString(),
        cardCode: getDBSalesQuoHeader[0]["customercode"]
            .toString(), //customercode!.cardCode
        accBalance: double.parse(getDBSalesQuoHeader[0]["customeraccbal"]
            .toString()), //customeraccbal
        point:
            getDBSalesQuoHeader[0]["customerpoint"].toString(), //customerpoint
        address: address25,
        tarNo: getDBSalesQuoHeader[0]["taxno"].toString(), //taxno
        email:
            getDBSalesQuoHeader[0]["customeremail"].toString(), //customeremail
        invoicenum: getDBSalesQuoHeader[0]["documentno"].toString(),
        invoiceDate: getDBSalesQuoHeader[0]["createdateTime"].toString(),
        totalPayment: getDBSalesQuoHeader[0]["doctotal"] == null
            ? 0.0
            : double.parse(getDBSalesQuoHeader[0]["doctotal"].toString()),
      );
      notifyListeners();
      //log("selectedcust25!.address!length::" +
      // selectedcust25!.address!.length.toString());
      int? totqty;

      notifyListeners();
      selectedBillAdress = selectedcust!.address!.length - 1;
      selectedShipAdress = selectedcust55!.address!.length - 1;
      notifyListeners();
      searchmapbool = false;
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
    notifyListeners();
  }

  saveValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      insertSalesQuoHeaderToDB(docstatus, context, theme);
    } else if (docstatus.toLowerCase() == "check out") {
      insertSalesQuoHeaderToDB(docstatus, context, theme);
    }
    // else if (docstatus.toLowerCase() == "suspend") {
    //   insertSalesQuoHeaderToDB(docstatus, context, theme);
    // }
    notifyListeners();
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

    print("datattata doc : " + data.substring(8));
    return listdata;
  }

  insertSalesQuoHeaderToDB(
      String docstatus, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<SalesQuotationHeaderModelDB> salesQuoHeaderValues1 = [];
    List<SalesQuotationLineTDB> salesQuoLineValues = [];
    int? counofData = await DBOperation.getcountofTable(
        db, "docentry", "SalesQuotationHeader");
    int? docEntryCreated = 0;
    tabledocentry = null;
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
          db, "docentry", "SalesQuotationHeader");
    }
    await DBOperation.geteriesvlue(db);
    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 10);

    List<String> getseriesvalue = await checkingdoc(10);

    int docseries = int.parse(getseriesvalue[1]);
    int nextno = documentN0!;
    documentN0 = docseries + documentN0;
    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);
    print("finlDocnum:$finlDocnum");

    documentNum = finlDocnum + documentN0.toString();
    print("documentNum:$documentNum");
    salesQuoHeaderValues1.add(SalesQuotationHeaderModelDB(
      doctype: 'Sales Quotation',
      docentry: docEntryCreated.toString(),
      objname: '',
      objtype: '',
      amtpaid: '',
      // totalPayment != null
      //     ? getSumTotalPaid().toString().replaceAll(',', '')
      //     : null,
      baltopay: '',
      // totalPayment != null
      //     ? getBalancePaid().toString().replaceAll(',', '')
      //     : null,
      billaddressid: selectedcust == null && selectedcust!.address == null ||
              selectedcust!.address!.isEmpty
          ? ''
          : selectedcust!.address![selectedBillAdress].autoId.toString(),
      // ? " ${selectedcust!.address![selectedBillAdress].address1.toString()},${selectedcust!.address![selectedBillAdress].address2.toString()}, ${selectedcust!.address![selectedBillAdress].address3.toString()}"

      // selectedcust != null
      //     ? " ${selectedcust!.address![selectedBillAdress].address1.toString()},${selectedcust!.address![selectedBillAdress].address2.toString()}, ${selectedcust!.address![selectedBillAdress].address3.toString()}"
      //     : "",
      billtype: null,
      branch: UserValues.branch!,
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      createdbyuser: UserValues.userType,
      customercode: selectedcust!.cardCode == null
          ? ""
          : selectedcust!.cardCode.toString(),

      customerSeriesNum: '',
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
      docstatus:
          // docstatus == "suspend"
          //     ? "0"
          //     :
          docstatus == "hold"
              ? "1"
              : docstatus == "save as order"
                  ? "2"
                  : docstatus == "check out"
                      ? "3"
                      : "null",
      doctotal: totalPayment != null
          ? totalPayment!.totalDue!.toStringAsFixed(2)
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
      sapDocNo: null,
      sapDocentry: null,
      qStatus: "No",
      totalltr: totalLiter(),
      totalweight: totalWeight(), editType: '',
    ));
    int? docentry2 =
        await DBOperation.insertSaleQuoheader(db, salesQuoHeaderValues1);
    tabledocentry = docentry2;
    await DBOperation.updatenextno(db, 10, nextno);
    for (int i = 0; i < scanneditemData.length; i++) {
      double? mycontamount = mycontroller[i].text.toString().isNotEmpty
          ? double.parse(mycontroller[i].text.toString())
          : 00;
      salesQuoLineValues.add(SalesQuotationLineTDB(
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
        netlinetotal: scanneditemData[i].netvalue!.toStringAsFixed(2),
        // totalPayment != null
        //     ? totalPayment!.totalDue.toString().replaceAll(',', '')
        //     : null,
        price: scanneditemData[i].SellPrice.toString(),
        quantity: scanneditemData[i].Qty.toString(),
        serialbatch: scanneditemData[i].SerialBatch,
        taxrate: scanneditemData[i].TaxRate.toString(),
        taxtotal: scanneditemData[i].taxvalue!.toStringAsFixed(2),
        // totalPayment != null
        //     ? totalPayment!.totalTX!.toString().replaceAll(',', '')
        //     : null,
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        terminal: UserValues.terminal,
        itemname: scanneditemData[i].ItemName,
      ));

      notifyListeners();
// salesLineValues.add(salesLine);
    }

    if (salesQuoLineValues.isNotEmpty) {
      DBOperation.insertSalesQuoLine(db, salesQuoLineValues, docentry2!);
      notifyListeners();
    }

    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      if (docstatus == "check out") {
        // pushRabiMqSO(docentry2!);
        await callQuotPostApi(
            context, theme, docentry2!, docstatus, documentNum);
      }
    }
    if (docstatus == "hold") {
      getdraftindex();
      await Get.defaultDialog(
              title: "Success",
              middleText: docstatus == "hold" ? "Saved as draft" : "null",
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
        OndDisablebutton = false;

        notifyListeners();
      });
    }
    // OndDisablebutton = true;
    // loadingscrn = false;
    // scanneditemData.clear();
    // schemebtnclk = false;
    // selectedcust = null;
    // selectedcust55 = null;
    // paymentWay.clear();
    // newShipAddrsValue = [];
    // itemsDocDetails=[];
    // newBillAddrsValue = [];
    // newCustValues = [];
    // totalPayment = null;
    // mycontroller[50].text = "";
    // discountcontroller = List.generate(100, (i) => TextEditingController());
    // mycontroller = List.generate(150, (i) => TextEditingController());
    // qtymycontroller = List.generate(100, (i) => TextEditingController());
    // remarkcontroller3.text = '';
    // notifyListeners();

    // await Get.defaultDialog(
    //         title: "Success",
    //         middleText: docstatus == "check out"
    //             ? 'Successfully Done, Document Number is $documentNum'
    //             : docstatus == "save as order"
    //                 ? "Sales order successfully saved..!!, Document Number is $documentNum"
    //                 : docstatus == "hold"
    //                     ? "Saved as draft"
    //                       : "null",
    //         backgroundColor: Colors.white,
    //         titleStyle: TextStyle(color: Colors.red),
    //         middleTextStyle: TextStyle(color: Colors.black),
    //         actions: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               TextButton(
    //                 child: Text("Close"),
    //                 onPressed: () => Get.back(),
    //               ),
    //             ],
    //           ),
    //         ],
    //         radius: 5)
    //     .then((value) {
    //   injectToDb();
    //   if (docstatus == "check out") {
    //     Get.offAllNamed(ConstantRoutes.dashboard);
    //   }
    //   OndDisablebutton = false;

    //   notifyListeners();
    // });

    notifyListeners();
  }

  addDocLine() {
    itemsDocDetails = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      itemsDocDetails.add(QuatationLines(
          Currency: "TZS",
          DiscPrcnt: scanneditemData[i].discountper.toString(),
          ItemCode: scanneditemData[i].ItemCode,
          Price: scanneditemData[i].SellPrice.toString(),
          Quantity: scanneditemData[i].Qty.toString(),
          TaxCode: scanneditemData[i].TaxRate.toString(),
          UnitPrice: scanneditemData[i].netvalue!.toStringAsFixed(2),
          WhsCode: scanneditemData[i].Branch,
          itemName: scanneditemData[i].ItemName.toString()));
    }
  }

  callQuotPostApi(BuildContext context, ThemeData theme, int docEntry,
      String docststus, String documentNum) async {
    await sapLoginApi(context);
    await postQuotation(context, theme, docEntry, docststus, documentNum);
    notifyListeners();
  }

  postQuotation(BuildContext context, ThemeData theme, int docEntry,
      String docstatus, String documentNum) async {
    final Database db = (await DBHelper.getInstance())!;
    addDocLine();
    SalesQuotPostAPi.cardCodePost = selectedcust!.cardCode;
    SalesQuotPostAPi.docLineQout = itemsDocDetails;
    SalesQuotPostAPi.docDate = config.currentDate();
    SalesQuotPostAPi.dueDate = config.currentDate().toString();
    SalesQuotPostAPi.remarks = remarkcontroller3.text;
    var uuid = Uuid();
    String? uuidg = uuid.v1();
    SalesQuotPostAPi.method(uuidg);
    await SalesQuotPostAPi.getGlobalData(uuidg).then((value) async {
      // SalesOrderAfterAPi.baseEntry = value.docEntry.toString();
      //log("object:" + value.statusCode.toString());
      //log("docEntry:" + value.docEntry.toString());
      if (value.statusCode == null) {
        return;
      }
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.docEntry != null) {
          sapDocentry = value.docEntry.toString();
          sapDocuNumber = value.docNum.toString();
          await DBOperation.UpdtSapDetSalHead(db, int.parse(sapDocentry),
              int.parse(sapDocuNumber), docEntry, 'SalesQuotationHeader');
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
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(100, (i) => TextEditingController());
          remarkcontroller3.text = '';
          notifyListeners();

          await Get.defaultDialog(
                  title: "Success",
                  middleText: docstatus == "check out"
                      ? 'Successfully Done, Document Number is $sapDocuNumber'
                      : docstatus == "save as order"
                          ? "Sales order successfully saved..!!, Document Number is $sapDocuNumber"
                          : docstatus == "hold"
                              ? "Saved as draft"
                              // : docstatus == "suspend"
                              //     ? "This Sales Transaction Suspended Sucessfully..!!"
                              : "null",
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
            if (docstatus == "check out") {
              Get.offAllNamed(ConstantRoutes.dashboard);
            }
            OndDisablebutton = false;

            notifyListeners();
          });
        } else {
          //log("Error11");

          custserieserrormsg = value.error!.message.toString();
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

          await Get.defaultDialog(
                  title: "Alert",
                  middleText: custserieserrormsg =
                      value.error!.message.toString(),
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
            if (docstatus == "check out") {
              Get.offAllNamed(ConstantRoutes.dashboard);
            }
            OndDisablebutton = false;

            notifyListeners();
          });
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        //log("Error22");
        cancelbtn = false;
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
          OndDisablebutton = false;

          //   Get.defaultDialog(
          //           title: "Alert",
          //           middleText: custserieserrormsg =
          //               value.error!.message!.value.toString(),
          //           backgroundColor: Colors.white,
          //           titleStyle: TextStyle(color: Colors.red),
          //           middleTextStyle: TextStyle(color: Colors.black),
          //           actions: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.end,
          //               children: [
          //                 TextButton(
          //                   child: Text("Close"),
          //                   onPressed: () => Get.back(),
          //                 ),
          //               ],
          //             ),
          //           ],
          //           radius: 5)
          //       .then((value) {
          //     injectToDb();
          //     if (docstatus == "check out") {
          //       Get.offAllNamed(ConstantRoutes.dashboard);
          //     }
          //     OndDisablebutton = false;

          //     notifyListeners();
          //   });
        });
        OndDisablebutton = false;
      } else {
        cancelbtn = false;
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
          OndDisablebutton = false;
        });
        OndDisablebutton = false;
      }
    });
    notifyListeners();
  }

  updateSalesQuoHeaderToDB(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    //  SalesQuotationHeaderModelDB salesQuoHeaderValues1 = SalesQuotationHeaderModelDB();
    List<SalesQuotationLineTDB> salesQuoLineValues = [];
    log("cancelDocEntry:::${cancelDocEntry}");
    SalesQuotationHeaderModelDB salesQuoHeaderValues1 =
        SalesQuotationHeaderModelDB(
      doctype: 'Sales Quotation',
      docentry: cancelDocEntry.toString(),
      objname: '',
      objtype: '',
      amtpaid: '',
      baltopay: '',
      billaddressid: selectedcust == null && selectedcust!.address == null ||
              selectedcust!.address!.isEmpty
          ? ''
          : selectedcust!.address![selectedBillAdress].autoId.toString(),
      billtype: null,
      branch: UserValues.branch!,
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      createdbyuser: UserValues.userType,
      customercode: selectedcust!.cardCode == null
          ? ""
          : selectedcust!.cardCode.toString(),
      customerSeriesNum: '',
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
      documentno: cancelDocnum,
      docstatus: '3',
      doctotal: totalPayment != null
          ? totalPayment!.totalDue!.toStringAsFixed(2)
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
      sapDocNo: int.parse(sapDocuNumber.toString()),
      sapDocentry: int.parse(sapDocentry.toString()),
      qStatus: "C",
      totalltr: totalLiter(),
      totalweight: totalWeight(),
      editType: 'Edit',
    );
    await DBOperation.updateSaleQuoheader(db, salesQuoHeaderValues1,
        cancelDocEntry.toString(), cancelDocnum.toString());

    List<Map<String, Object?>> getDBUpdateSalesOrdHeader =
        await DBOperation.getSaleQuorHeaderDB(
            db, int.parse(cancelDocEntry.toString()));

    log("cancelDocEntry222:::${cancelDocEntry}");

    for (int i = 0; i < scanneditemData.length; i++) {
      double? mycontamount = mycontroller[i].text.toString().isNotEmpty
          ? double.parse(mycontroller[i].text.toString())
          : 00;
      salesQuoLineValues.add(SalesQuotationLineTDB(
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
        docentry: selectedcust!.docentry,
        itemcode: scanneditemData[i].ItemCode,
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        lineID: i.toString(),
        linetotal: scanneditemData[i].basic.toString(),
        netlinetotal: scanneditemData[i].netvalue!.toStringAsFixed(2),
        price: scanneditemData[i].SellPrice.toString(),
        quantity: scanneditemData[i].Qty.toString(),
        serialbatch: scanneditemData[i].SerialBatch,
        taxrate: scanneditemData[i].TaxRate.toString(),
        taxtotal: scanneditemData[i].taxvalue!.toStringAsFixed(2),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        terminal: UserValues.terminal,
        itemname: scanneditemData[i].ItemName,
      ));
      notifyListeners();
    }
    log("cancelDocEntry333:::${cancelDocEntry}");

    if (salesQuoLineValues.isNotEmpty) {
      for (int im = 0; im < salesQuoLineValues.length; im++) {
        await DBOperation.updateSalesQuoLine(
            db, salesQuoLineValues, im, cancelDocEntry.toString());
        notifyListeners();
      }
    }

    bool? netbool = await config.haveInterNet();
    log("cancelDocEntry444:::${cancelDocEntry}");

    if (netbool == true) {
      // await callPatchApi(context, theme, int.parse(cancelDocEntry.toString()));
      // await pushRabiMqSO3(int.parse(cancelDocEntry.toString()));
    }
    // editqty = false;
    // OndDisablebutton = true;
    // loadingscrn = false;
    // scanneditemData.clear();
    // schemebtnclk = false;
    // selectedcust = null;
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
    // if (getDBUpdateSalesOrdHeader.isNotEmpty) {
    //   await Get.defaultDialog(
    //           title: "Success",
    //           middleText: 'Updated Successfully Done',
    //           backgroundColor: Colors.white,
    //           titleStyle: TextStyle(color: Colors.red),
    //           middleTextStyle: TextStyle(color: Colors.black),
    //           actions: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 TextButton(
    //                   child: Text("Close"),
    //                   onPressed: () => Get.back(),
    //                 ),
    //               ],
    //             ),
    //           ],
    //           radius: 5)
    //       .then((value) {
    //     injectToDb();
    //     Get.offAllNamed(ConstantRoutes.dashboard);

    //     // Navigator.pop(context);
    //     OndDisablebutton = false;
    //     notifyListeners();
    //   });
    //   notifyListeners();
    // }
  }

  pushRabiMqSO(int? docentry) async {
    //background service
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBSalesquotLine =
        await DBOperation.getSalesQuoLineDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesQuoHeader =
        await DBOperation.getSaleQuorHeaderDB(db, docentry);
    String salesQuotLine = json.encode(getDBSalesquotLine);
    String salesQuotHeader = json.encode(getDBSalesQuoHeader);
    var ddd = json.encode({
      "ObjectType": 14,
      "ActionType": "Add",
      "SalesQuotationHeader": salesQuotHeader,
      "SalesQuotationLine": salesQuotLine,
    });
    log("payload11 : $ddd");
    // Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        // AppConstant.ip,
        //"102.69.167.106"
        port: 5672,
        authProvider: PlainAuthenticator("buson", "BusOn123"));
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
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBSalesquotLine =
        await DBOperation.getSalesQuoLineDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesQuoHeader =
        await DBOperation.getSaleQuorHeaderDB(db, docentry);
    // String salesPAY = json.encode(getDBSalespay);
    String salesQuotLine = json.encode(getDBSalesquotLine);
    String salesQuotHeader = json.encode(getDBSalesQuoHeader);
    var ddd = json.encode({
      "ObjectType": 14,
      "ActionType": "Add",
      "SalesQuotationHeader": salesQuotHeader,
      "SalesQuotationLine": salesQuotLine,
    });
    log("payload22 : $ddd");
    //RabitMQ
    // Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        // AppConstant.ip,
        //"102.69.167.106"
        port: 5672,
        authProvider: PlainAuthenticator("buson", "BusOn123"));
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

    List<Map<String, Object?>> getDBSalesquotLine =
        await DBOperation.getSalesQuoLineDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesQuoHeader =
        await DBOperation.getSaleQuorHeaderDB(db, docentry);
    String salesQuotLine = json.encode(getDBSalesquotLine);
    String salesQuotHeader = json.encode(getDBSalesQuoHeader);
    var ddd = json.encode({
      "ObjectType": 14,
      "ActionType": "Edit",
      "SalesQuotationHeader": salesQuotHeader,
      "SalesQuotationLine": salesQuotLine,
    });
    log("payload 3: $ddd");
    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        // AppConstant.ip,
        //"102.69.167.106"
        port: 5672,
        authProvider: PlainAuthenticator("buson", "BusOn123"));
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

  clearSuspendedData(BuildContext context, ThemeData theme) {
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
    mycontroller = List.generate(150, (i) => TextEditingController());
    qtymycontroller = List.generate(100, (i) => TextEditingController());
    discountcontroller = List.generate(100, (i) => TextEditingController());
    notifyListeners();
    Get.defaultDialog(
            title: "Success",
            middleText: "Suspended Sucessfully..!!",
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
      OndDisablebutton = false;
      notifyListeners();
    });
  }

  viewDbtable() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.getdata(db);
    notifyListeners();
  }

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

  List<CustomerDetals> custList2 = [];
  getCustDetFDB() async {
    custList.clear();
    custList2.clear();
    List<Address> addList = [];
    final Database db = (await DBHelper.getInstance())!;
    List<CustomerModelDB> cusdataDB = await DBOperation.getCstmMasDB(db);

    List<CustomerAddressModelDB> csadresdataDB =
        await DBOperation.getCstmMasAddDB(
      db,
    );
    List<Map<String, Object?>> getTopCuslist =
        await DBOperation.getTopCuslist(db);
    // log("csadresdataDBcsadresdataDB:::${csadresdataDB[0].autoid}");
    for (int i = 1; i < cusdataDB.length; i++) {
      // if (cusdataDB[i].customername != "This is my updated name") {s
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
        address: [],
        autoId: null,
      ));
      // }
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
              // autoId: int.parse(cusdataDB[i].autoid.toString()),
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
              ));
        }
      }
    }

    filtercustList = custList;
    notifyListeners();
  }

  List<DocumentLineData> itemsDetailsData = [];
  QuotPutModel? quotputdataval;

  List<DocumentLineData> contentitemsDetails55 = [];

  // delputHeaderValues() {
  //   contentitemsDetails55 = [];
  //   getQuotAllValues = null;
  //   itemsDetailsData = [];

  //   quotputdataval = QuotPutModel(
  //     odataMetadata: getQuotAllValues!.odataMetadata == null ||
  //             getQuotAllValues!.odataMetadata == "null"
  //         ? null
  //         : getQuotAllValues!.odataMetadata,
  //     odataEtag: getQuotAllValues!.odataEtag == null ||
  //             getQuotAllValues!.odataEtag == "null"
  //         ? null
  //         : getQuotAllValues!.odataEtag,
  //     docEntry: getQuotAllValues!.docEntry == null ||
  //             getQuotAllValues!.docEntry == "null"
  //         ? null
  //         : getQuotAllValues!.docEntry,
  //     docNum:
  //         getQuotAllValues!.docNum == null || getQuotAllValues!.docNum == "null"
  //             ? null
  //             : getQuotAllValues!.docNum,
  //     docType: getQuotAllValues!.docType == null ||
  //             getQuotAllValues!.docType == "null"
  //         ? null
  //         : getQuotAllValues!.docType,
  //     handWritten: getQuotAllValues!.handWritten == null ||
  //             getQuotAllValues!.handWritten == "null"
  //         ? null
  //         : getQuotAllValues!.handWritten,
  //     printed: getQuotAllValues!.printed == null ||
  //             getQuotAllValues!.printed == "null"
  //         ? null
  //         : getQuotAllValues!.printed,
  //     docDate: getQuotAllValues!.docDate == null ||
  //             getQuotAllValues!.docDate == "null"
  //         ? null
  //         : getQuotAllValues!.docDate,
  //     docDueDate: getQuotAllValues!.docDueDate == null ||
  //             getQuotAllValues!.docDueDate == "null"
  //         ? null
  //         : getQuotAllValues!.docDueDate,
  //     cardCode: getQuotAllValues!.cardCode == null ||
  //             getQuotAllValues!.cardCode == "null"
  //         ? null
  //         : getQuotAllValues!.cardCode,
  //     cardName: getQuotAllValues!.cardName == null ||
  //             getQuotAllValues!.cardName == "null"
  //         ? null
  //         : getQuotAllValues!.cardName,
  //     address: getQuotAllValues!.address == null ||
  //             getQuotAllValues!.address == "null"
  //         ? null
  //         : getQuotAllValues!.address,
  //     numAtCard: getQuotAllValues!.numAtCard == null ||
  //             getQuotAllValues!.numAtCard == "null"
  //         ? null
  //         : getQuotAllValues!.numAtCard,
  //     docTotal: getQuotAllValues!.docTotal == null ||
  //             getQuotAllValues!.docTotal == "null"
  //         ? null
  //         : getQuotAllValues!.docTotal,
  //     attachmentEntry: getQuotAllValues!.attachmentEntry == null ||
  //             getQuotAllValues!.attachmentEntry == "null"
  //         ? null
  //         : getQuotAllValues!.attachmentEntry,
  //     docCurrency: getQuotAllValues!.docCurrency == null ||
  //             getQuotAllValues!.docCurrency == "null"
  //         ? null
  //         : getQuotAllValues!.docCurrency,
  //     docRate: getQuotAllValues!.docRate == null ||
  //             getQuotAllValues!.docRate == "null"
  //         ? null
  //         : getQuotAllValues!.docRate,
  //     reference1: getQuotAllValues!.reference1 == null ||
  //             getQuotAllValues!.reference1 == "null"
  //         ? null
  //         : getQuotAllValues!.reference1,
  //     reference2: getQuotAllValues!.reference2 == null ||
  //             getQuotAllValues!.reference2 == "null"
  //         ? null
  //         : getQuotAllValues!.reference2,
  //     comments: getQuotAllValues!.comments == null ||
  //             getQuotAllValues!.comments == "null"
  //         ? null
  //         : getQuotAllValues!.comments,
  //     journalMemo: getQuotAllValues!.journalMemo == null ||
  //             getQuotAllValues!.journalMemo == "null"
  //         ? null
  //         : getQuotAllValues!.journalMemo,
  //     paymentGroupCode: getQuotAllValues!.paymentGroupCode == null ||
  //             getQuotAllValues!.paymentGroupCode == "null"
  //         ? null
  //         : getQuotAllValues!.paymentGroupCode,
  //     docTime: getQuotAllValues!.docTime == null ||
  //             getQuotAllValues!.docTime == "null"
  //         ? null
  //         : getQuotAllValues!.docTime,
  //     salesPersonCode: getQuotAllValues!.salesPersonCode == null ||
  //             getQuotAllValues!.salesPersonCode == "null"
  //         ? null
  //         : getQuotAllValues!.salesPersonCode,
  //     transportationCode: getQuotAllValues!.transportationCode == null ||
  //             getQuotAllValues!.transportationCode == "null"
  //         ? null
  //         : getQuotAllValues!.transportationCode,
  //     confirmed: getQuotAllValues!.confirmed == null ||
  //             getQuotAllValues!.confirmed == "null"
  //         ? null
  //         : getQuotAllValues!.confirmed,
  //     importFileNum: getQuotAllValues!.importFileNum == null ||
  //             getQuotAllValues!.importFileNum == "null"
  //         ? null
  //         : getQuotAllValues!.importFileNum!,
  //     summeryType: getQuotAllValues!.summeryType == null ||
  //             getQuotAllValues!.summeryType == "null"
  //         ? null
  //         : getQuotAllValues!.summeryType,
  //     contactPersonCode: getQuotAllValues!.contactPersonCode == null ||
  //             getQuotAllValues!.contactPersonCode == "null"
  //         ? null
  //         : getQuotAllValues!.contactPersonCode,
  //     showScn: getQuotAllValues!.showScn == null ||
  //             getQuotAllValues!.showScn == "null"
  //         ? null
  //         : getQuotAllValues!.showScn,
  //     series:
  //         getQuotAllValues!.series == null || getQuotAllValues!.series == "null"
  //             ? null
  //             : getQuotAllValues!.series,
  //     taxDate: getQuotAllValues!.taxDate == null ||
  //             getQuotAllValues!.taxDate == "null"
  //         ? null
  //         : getQuotAllValues!.taxDate,
  //     partialSupply: getQuotAllValues!.partialSupply == null ||
  //             getQuotAllValues!.partialSupply == "null"
  //         ? null
  //         : getQuotAllValues!.partialSupply,
  //     docObjectCode: getQuotAllValues!.docObjectCode == null ||
  //             getQuotAllValues!.docObjectCode == "null"
  //         ? null
  //         : getQuotAllValues!.docObjectCode,
  //     shipToCode: getQuotAllValues!.shipToCode == null ||
  //             getQuotAllValues!.shipToCode == "null"
  //         ? null
  //         : getQuotAllValues!.shipToCode,
  //     indicator: getQuotAllValues!.indicator == null ||
  //             getQuotAllValues!.indicator == "null"
  //         ? null
  //         : getQuotAllValues!.indicator,
  //     federalTaxId: getQuotAllValues!.federalTaxId == null ||
  //             getQuotAllValues!.federalTaxId == "null"
  //         ? null
  //         : getQuotAllValues!.federalTaxId,
  //     discountPercent: getQuotAllValues!.discountPercent == null ||
  //             getQuotAllValues!.discountPercent == "null"
  //         ? null
  //         : getQuotAllValues!.discountPercent,
  //     paymentReference: getQuotAllValues!.paymentReference == null ||
  //             getQuotAllValues!.paymentReference == "null"
  //         ? null
  //         : getQuotAllValues!.paymentReference,
  //     creationDate: getQuotAllValues!.creationDate == null ||
  //             getQuotAllValues!.creationDate == "null"
  //         ? null
  //         : getQuotAllValues!.creationDate,
  //     updateDate: getQuotAllValues!.updateDate == null ||
  //             getQuotAllValues!.updateDate == "null"
  //         ? null
  //         : getQuotAllValues!.updateDate,
  //     financialPeriod: getQuotAllValues!.financialPeriod == null ||
  //             getQuotAllValues!.financialPeriod == "null"
  //         ? null
  //         : getQuotAllValues!.financialPeriod,
  //     userSign: getQuotAllValues!.userSign == null ||
  //             getQuotAllValues!.userSign == "null"
  //         ? null
  //         : getQuotAllValues!.userSign,
  //     transNum: getQuotAllValues!.transNum == null ||
  //             getQuotAllValues!.transNum == "null"
  //         ? null
  //         : getQuotAllValues!.transNum,
  //     vatSum:
  //         getQuotAllValues!.vatSum == null || getQuotAllValues!.vatSum == "null"
  //             ? null
  //             : getQuotAllValues!.vatSum,
  //     vatSumSys: getQuotAllValues!.vatSumSys == null ||
  //             getQuotAllValues!.vatSumSys == "null"
  //         ? null
  //         : getQuotAllValues!.vatSumSys,
  //     vatSumFc: getQuotAllValues!.vatSumFc == null ||
  //             getQuotAllValues!.vatSumFc == "null"
  //         ? null
  //         : getQuotAllValues!.vatSumFc,
  //     netProcedure: getQuotAllValues!.netProcedure == null ||
  //             getQuotAllValues!.netProcedure == "null"
  //         ? null
  //         : getQuotAllValues!.netProcedure,
  //     docTotalFc: getQuotAllValues!.docTotalFc == null ||
  //             getQuotAllValues!.docTotalFc == "null"
  //         ? null
  //         : getQuotAllValues!.docTotalFc,
  //     docTotalSys: getQuotAllValues!.docTotalSys == null ||
  //             getQuotAllValues!.docTotalSys == "null"
  //         ? null
  //         : getQuotAllValues!.docTotalSys,
  //     form1099: getQuotAllValues!.form1099 == null ||
  //             getQuotAllValues!.form1099 == "null"
  //         ? null
  //         : getQuotAllValues!.form1099,
  //     box1099: getQuotAllValues!.box1099 == null ||
  //             getQuotAllValues!.box1099 == "null"
  //         ? null
  //         : getQuotAllValues!.box1099,
  //     revisionPo: getQuotAllValues!.revisionPo == null ||
  //             getQuotAllValues!.revisionPo == "null"
  //         ? null
  //         : getQuotAllValues!.revisionPo,
  //     requriedDate: getQuotAllValues!.requriedDate == null ||
  //             getQuotAllValues!.requriedDate == "null"
  //         ? null
  //         : getQuotAllValues!.requriedDate,
  //     cancelDate: getQuotAllValues!.cancelDate == null ||
  //             getQuotAllValues!.cancelDate == "null"
  //         ? null
  //         : getQuotAllValues!.cancelDate,
  //     blockDunning: getQuotAllValues!.blockDunning == null ||
  //             getQuotAllValues!.blockDunning == "null"
  //         ? null
  //         : getQuotAllValues!.blockDunning,
  //     submitted: getQuotAllValues!.submitted == null ||
  //             getQuotAllValues!.submitted == "null"
  //         ? null
  //         : getQuotAllValues!.submitted,
  //     segment: getQuotAllValues!.segment == null ||
  //             getQuotAllValues!.segment == "null"
  //         ? null
  //         : getQuotAllValues!.segment,
  //     pickStatus: getQuotAllValues!.pickStatus == null ||
  //             getQuotAllValues!.pickStatus == "null"
  //         ? null
  //         : getQuotAllValues!.pickStatus,
  //     pick: getQuotAllValues!.pick == null || getQuotAllValues!.pick == "null"
  //         ? null
  //         : getQuotAllValues!.pick,
  //     paymentMethod: getQuotAllValues!.paymentMethod == null ||
  //             getQuotAllValues!.paymentMethod == "null"
  //         ? null
  //         : getQuotAllValues!.paymentMethod,
  //     paymentBlock: getQuotAllValues!.paymentBlock == null ||
  //             getQuotAllValues!.paymentBlock == "null"
  //         ? null
  //         : getQuotAllValues!.paymentBlock,
  //     paymentBlockEntry: getQuotAllValues!.paymentBlockEntry == null ||
  //             getQuotAllValues!.paymentBlockEntry == "null"
  //         ? null
  //         : getQuotAllValues!.paymentBlockEntry,
  //     centralBankIndicator: getQuotAllValues!.centralBankIndicator == null ||
  //             getQuotAllValues!.centralBankIndicator == "null"
  //         ? null
  //         : getQuotAllValues!.centralBankIndicator,
  //     maximumCashDiscount: getQuotAllValues!.maximumCashDiscount == null ||
  //             getQuotAllValues!.maximumCashDiscount == "null"
  //         ? null
  //         : getQuotAllValues!.maximumCashDiscount,
  //     reserve: getQuotAllValues!.reserve == null ||
  //             getQuotAllValues!.reserve == "null"
  //         ? null
  //         : getQuotAllValues!.reserve,
  //     project: getQuotAllValues!.project == null ||
  //             getQuotAllValues!.project == "null"
  //         ? null
  //         : getQuotAllValues!.project,
  //     exemptionValidityDateFrom:
  //         getQuotAllValues!.exemptionValidityDateFrom == null ||
  //                 getQuotAllValues!.exemptionValidityDateFrom == "null"
  //             ? null
  //             : getQuotAllValues!.exemptionValidityDateFrom,
  //     exemptionValidityDateTo:
  //         getQuotAllValues!.exemptionValidityDateTo == null ||
  //                 getQuotAllValues!.exemptionValidityDateTo == "null"
  //             ? null
  //             : getQuotAllValues!.exemptionValidityDateTo,
  //     wareHouseUpdateType: getQuotAllValues!.wareHouseUpdateType == null ||
  //             getQuotAllValues!.wareHouseUpdateType == "null"
  //         ? null
  //         : getQuotAllValues!.wareHouseUpdateType,
  //     rounding: getQuotAllValues!.rounding == null ||
  //             getQuotAllValues!.rounding == "null"
  //         ? null
  //         : getQuotAllValues!.rounding,
  //     externalCorrectedDocNum:
  //         getQuotAllValues!.externalCorrectedDocNum == null ||
  //                 getQuotAllValues!.externalCorrectedDocNum == "null"
  //             ? null
  //             : getQuotAllValues!.externalCorrectedDocNum,
  //     internalCorrectedDocNum:
  //         getQuotAllValues!.internalCorrectedDocNum == null ||
  //                 getQuotAllValues!.internalCorrectedDocNum == "null"
  //             ? null
  //             : getQuotAllValues!.internalCorrectedDocNum,
  //     nextCorrectingDocument:
  //         getQuotAllValues!.nextCorrectingDocument == null ||
  //                 getQuotAllValues!.nextCorrectingDocument == "null"
  //             ? null
  //             : getQuotAllValues!.nextCorrectingDocument,
  //     deferredTax: getQuotAllValues!.deferredTax == null ||
  //             getQuotAllValues!.deferredTax == "null"
  //         ? null
  //         : getQuotAllValues!.deferredTax,
  //     taxExemptionLetterNum: getQuotAllValues!.taxExemptionLetterNum == null ||
  //             getQuotAllValues!.taxExemptionLetterNum == "null"
  //         ? null
  //         : getQuotAllValues!.taxExemptionLetterNum,
  //     wtApplied: getQuotAllValues!.wtApplied == null ||
  //             getQuotAllValues!.wtApplied == "null"
  //         ? null
  //         : getQuotAllValues!.wtApplied,
  //     wtAppliedFc: getQuotAllValues!.wtAppliedFc == null ||
  //             getQuotAllValues!.wtAppliedFc == "null"
  //         ? null
  //         : getQuotAllValues!.wtAppliedFc,
  //     billOfExchangeReserved:
  //         getQuotAllValues!.billOfExchangeReserved == null ||
  //                 getQuotAllValues!.billOfExchangeReserved == "null"
  //             ? null
  //             : getQuotAllValues!.billOfExchangeReserved,
  //     agentCode: getQuotAllValues!.agentCode == null ||
  //             getQuotAllValues!.agentCode == "null"
  //         ? null
  //         : getQuotAllValues!.agentCode,
  //     wtAppliedSc: getQuotAllValues!.wtAppliedSc == null ||
  //             getQuotAllValues!.wtAppliedSc == "null"
  //         ? null
  //         : getQuotAllValues!.wtAppliedSc,
  //     totalEqualizationTax: getQuotAllValues!.totalEqualizationTax == null ||
  //             getQuotAllValues!.totalEqualizationTax == "null"
  //         ? null
  //         : getQuotAllValues!.totalEqualizationTax,
  //     totalEqualizationTaxFc:
  //         getQuotAllValues!.totalEqualizationTaxFc == null ||
  //                 getQuotAllValues!.totalEqualizationTaxFc == "null"
  //             ? null
  //             : getQuotAllValues!.totalEqualizationTaxFc,
  //     totalEqualizationTaxSc:
  //         getQuotAllValues!.totalEqualizationTaxSc == null ||
  //                 getQuotAllValues!.totalEqualizationTaxSc == "null"
  //             ? null
  //             : getQuotAllValues!.totalEqualizationTaxSc,
  //     numberOfInstallments: getQuotAllValues!.numberOfInstallments == null ||
  //             getQuotAllValues!.numberOfInstallments == "null"
  //         ? null
  //         : getQuotAllValues!.numberOfInstallments,
  //     applyTaxOnFirstInstallment:
  //         getQuotAllValues!.applyTaxOnFirstInstallment == null ||
  //                 getQuotAllValues!.applyTaxOnFirstInstallment == "null"
  //             ? null
  //             : getQuotAllValues!.applyTaxOnFirstInstallment,
  //     wtNonSubjectAmount: getQuotAllValues!.wtNonSubjectAmount == null ||
  //             getQuotAllValues!.wtNonSubjectAmount == "null"
  //         ? null
  //         : getQuotAllValues!.wtNonSubjectAmount,
  //     wtNonSubjectAmountSc: getQuotAllValues!.wtNonSubjectAmountSc == null ||
  //             getQuotAllValues!.wtNonSubjectAmountSc == "null"
  //         ? null
  //         : getQuotAllValues!.wtNonSubjectAmountSc,
  //     wtNonSubjectAmountFc: getQuotAllValues!.wtNonSubjectAmountFc == null ||
  //             getQuotAllValues!.wtNonSubjectAmountFc == "null"
  //         ? null
  //         : getQuotAllValues!.wtNonSubjectAmountFc,
  //     wtExemptedAmount: getQuotAllValues!.wtExemptedAmount == null ||
  //             getQuotAllValues!.wtExemptedAmount == "null"
  //         ? null
  //         : getQuotAllValues!.wtExemptedAmount,
  //     wtExemptedAmountSc: getQuotAllValues!.wtExemptedAmountSc == null ||
  //             getQuotAllValues!.wtExemptedAmountSc == "null"
  //         ? null
  //         : getQuotAllValues!.wtExemptedAmountSc,
  //     wtExemptedAmountFc: getQuotAllValues!.wtExemptedAmountFc == null ||
  //             getQuotAllValues!.wtExemptedAmountFc == "null"
  //         ? null
  //         : getQuotAllValues!.wtExemptedAmountFc,
  //     baseAmount: getQuotAllValues!.baseAmount == null ||
  //             getQuotAllValues!.baseAmount == "null"
  //         ? null
  //         : getQuotAllValues!.baseAmount,
  //     baseAmountSc: getQuotAllValues!.baseAmountSc == null ||
  //             getQuotAllValues!.baseAmountSc == "null"
  //         ? null
  //         : getQuotAllValues!.baseAmountSc,
  //     baseAmountFc: getQuotAllValues!.baseAmountFc == null ||
  //             getQuotAllValues!.baseAmountFc == "null"
  //         ? null
  //         : getQuotAllValues!.baseAmountFc,
  //     wtAmount: getQuotAllValues!.wtAmount == null ||
  //             getQuotAllValues!.wtAmount == "null"
  //         ? null
  //         : getQuotAllValues!.wtAmount,
  //     wtAmountSc: getQuotAllValues!.wtAmountSc == null ||
  //             getQuotAllValues!.wtAmountSc == "null"
  //         ? null
  //         : getQuotAllValues!.wtAmountSc,
  //     wtAmountFc: getQuotAllValues!.wtAmountFc == null ||
  //             getQuotAllValues!.wtAmountFc == "null"
  //         ? null
  //         : getQuotAllValues!.wtAmountFc,
  //     vatDate: getQuotAllValues!.vatDate == null ||
  //             getQuotAllValues!.vatDate == "null"
  //         ? null
  //         : getQuotAllValues!.vatDate,
  //     documentsOwner: getQuotAllValues!.documentsOwner == null ||
  //             getQuotAllValues!.documentsOwner == "null"
  //         ? null
  //         : getQuotAllValues!.documentsOwner,
  //     folioPrefixString: getQuotAllValues!.folioPrefixString == null ||
  //             getQuotAllValues!.folioPrefixString == "null"
  //         ? null
  //         : getQuotAllValues!.folioPrefixString,
  //     folioNumber: getQuotAllValues!.folioNumber == null ||
  //             getQuotAllValues!.folioNumber == "null"
  //         ? null
  //         : getQuotAllValues!.folioNumber,
  //     documentSubType: getQuotAllValues!.documentSubType == null ||
  //             getQuotAllValues!.documentSubType == "null"
  //         ? null
  //         : getQuotAllValues!.documentSubType,
  //     bpChannelCode: getQuotAllValues!.bpChannelCode == null ||
  //             getQuotAllValues!.bpChannelCode == "null"
  //         ? null
  //         : getQuotAllValues!.bpChannelCode,
  //     bpChannelContact: getQuotAllValues!.bpChannelContact == null ||
  //             getQuotAllValues!.bpChannelContact == "null"
  //         ? null
  //         : getQuotAllValues!.bpChannelContact,
  //     address2: getQuotAllValues!.address2 == null ||
  //             getQuotAllValues!.address2 == "null"
  //         ? null
  //         : getQuotAllValues!.address2,
  //     documentStatus: getQuotAllValues!.documentStatus == null ||
  //             getQuotAllValues!.documentStatus == "null"
  //         ? null
  //         : getQuotAllValues!.documentStatus,
  //     periodIndicator: getQuotAllValues!.periodIndicator == null ||
  //             getQuotAllValues!.periodIndicator == "null"
  //         ? null
  //         : getQuotAllValues!.periodIndicator,
  //     payToCode: getQuotAllValues!.payToCode == null ||
  //             getQuotAllValues!.payToCode == "null"
  //         ? null
  //         : getQuotAllValues!.payToCode,
  //     manualNumber: getQuotAllValues!.manualNumber == null ||
  //             getQuotAllValues!.manualNumber == "null"
  //         ? null
  //         : getQuotAllValues!.manualNumber,
  //     useShpdGoodsAct: getQuotAllValues!.useShpdGoodsAct == null ||
  //             getQuotAllValues!.useShpdGoodsAct == "null"
  //         ? null
  //         : getQuotAllValues!.useShpdGoodsAct,
  //     isPayToBank: getQuotAllValues!.isPayToBank == null ||
  //             getQuotAllValues!.isPayToBank == "null"
  //         ? null
  //         : getQuotAllValues!.isPayToBank,
  //     payToBankCountry: getQuotAllValues!.payToBankCountry == null ||
  //             getQuotAllValues!.payToBankCountry == "null"
  //         ? null
  //         : getQuotAllValues!.payToBankCountry,
  //     payToBankCode: getQuotAllValues!.payToBankCode == null ||
  //             getQuotAllValues!.payToBankCode == "null"
  //         ? null
  //         : getQuotAllValues!.payToBankCode,
  //     payToBankAccountNo: getQuotAllValues!.payToBankAccountNo == null ||
  //             getQuotAllValues!.payToBankAccountNo == "null"
  //         ? null
  //         : getQuotAllValues!.payToBankAccountNo,
  //     payToBankBranch: getQuotAllValues!.payToBankBranch == null ||
  //             getQuotAllValues!.payToBankBranch == "null"
  //         ? null
  //         : getQuotAllValues!.payToBankBranch,
  //     bplIdAssignedToInvoice:
  //         getQuotAllValues!.bplIdAssignedToInvoice == null ||
  //                 getQuotAllValues!.bplIdAssignedToInvoice == "null"
  //             ? null
  //             : getQuotAllValues!.bplIdAssignedToInvoice,
  //     downPayment: getQuotAllValues!.downPayment == null ||
  //             getQuotAllValues!.downPayment == "null"
  //         ? null
  //         : getQuotAllValues!.downPayment,
  //     reserveInvoice: getQuotAllValues!.reserveInvoice == null ||
  //             getQuotAllValues!.reserveInvoice == "null"
  //         ? null
  //         : getQuotAllValues!.reserveInvoice,
  //     languageCode: getQuotAllValues!.languageCode == null ||
  //             getQuotAllValues!.languageCode == "null"
  //         ? null
  //         : getQuotAllValues!.languageCode,
  //     trackingNumber: getQuotAllValues!.trackingNumber == null ||
  //             getQuotAllValues!.trackingNumber == "null"
  //         ? null
  //         : getQuotAllValues!.trackingNumber,
  //     pickRemark: getQuotAllValues!.pickRemark == null ||
  //             getQuotAllValues!.pickRemark == "null"
  //         ? null
  //         : getQuotAllValues!.pickRemark,
  //     closingDate: getQuotAllValues!.closingDate == null ||
  //             getQuotAllValues!.closingDate == "null"
  //         ? null
  //         : getQuotAllValues!.closingDate,
  //     sequenceCode: getQuotAllValues!.sequenceCode == null ||
  //             getQuotAllValues!.sequenceCode == "null"
  //         ? null
  //         : getQuotAllValues!.sequenceCode,
  //     sequenceSerial: getQuotAllValues!.sequenceSerial == null ||
  //             getQuotAllValues!.sequenceSerial == "null"
  //         ? null
  //         : getQuotAllValues!.sequenceSerial,
  //     seriesString: getQuotAllValues!.seriesString == null ||
  //             getQuotAllValues!.seriesString == "null"
  //         ? null
  //         : getQuotAllValues!.seriesString,
  //     subSeriesString: getQuotAllValues!.subSeriesString == null ||
  //             getQuotAllValues!.subSeriesString == "null"
  //         ? null
  //         : getQuotAllValues!.subSeriesString,
  //     sequenceModel: getQuotAllValues!.sequenceModel == null ||
  //             getQuotAllValues!.sequenceModel == "null"
  //         ? null
  //         : getQuotAllValues!.sequenceModel,
  //     useCorrectionVatGroup: getQuotAllValues!.useCorrectionVatGroup == null ||
  //             getQuotAllValues!.useCorrectionVatGroup == "null"
  //         ? null
  //         : getQuotAllValues!.useCorrectionVatGroup,
  //     totalDiscount: getQuotAllValues!.totalDiscount == null ||
  //             getQuotAllValues!.totalDiscount == "null"
  //         ? null
  //         : getQuotAllValues!.totalDiscount,
  //     downPaymentAmount: getQuotAllValues!.downPaymentAmount == null ||
  //             getQuotAllValues!.downPaymentAmount == "null"
  //         ? null
  //         : getQuotAllValues!.downPaymentAmount,
  //     downPaymentPercentage: getQuotAllValues!.downPaymentPercentage == null ||
  //             getQuotAllValues!.downPaymentPercentage == "null"
  //         ? null
  //         : getQuotAllValues!.downPaymentPercentage,
  //     downPaymentType: getQuotAllValues!.downPaymentType == null ||
  //             getQuotAllValues!.downPaymentType == "null"
  //         ? null
  //         : getQuotAllValues!.downPaymentType,
  //     downPaymentAmountSc: getQuotAllValues!.downPaymentAmountSc == null ||
  //             getQuotAllValues!.downPaymentAmountSc == "null"
  //         ? null
  //         : getQuotAllValues!.downPaymentAmountSc,
  //     downPaymentAmountFc: getQuotAllValues!.downPaymentAmountFc == null ||
  //             getQuotAllValues!.downPaymentAmountFc == "null"
  //         ? null
  //         : getQuotAllValues!.downPaymentAmountFc,
  //     vatPercent: getQuotAllValues!.vatPercent == null ||
  //             getQuotAllValues!.vatPercent == "null"
  //         ? null
  //         : getQuotAllValues!.vatPercent,
  //     serviceGrossProfitPercent:
  //         getQuotAllValues!.serviceGrossProfitPercent == null ||
  //                 getQuotAllValues!.serviceGrossProfitPercent == "null"
  //             ? null
  //             : getQuotAllValues!.serviceGrossProfitPercent,
  //     openingRemarks: getQuotAllValues!.openingRemarks == null ||
  //             getQuotAllValues!.openingRemarks == "null"
  //         ? null
  //         : getQuotAllValues!.openingRemarks,
  //     closingRemarks: getQuotAllValues!.closingRemarks == null ||
  //             getQuotAllValues!.closingRemarks == "null"
  //         ? null
  //         : getQuotAllValues!.closingRemarks,
  //     roundingDiffAmount: getQuotAllValues!.roundingDiffAmount == null ||
  //             getQuotAllValues!.roundingDiffAmount == "null"
  //         ? null
  //         : getQuotAllValues!.roundingDiffAmount,
  //     roundingDiffAmountFc: getQuotAllValues!.roundingDiffAmountFc == null ||
  //             getQuotAllValues!.roundingDiffAmountFc == "null"
  //         ? null
  //         : getQuotAllValues!.roundingDiffAmountFc,
  //     roundingDiffAmountSc: getQuotAllValues!.roundingDiffAmountSc == null ||
  //             getQuotAllValues!.roundingDiffAmountSc == "null"
  //         ? null
  //         : getQuotAllValues!.roundingDiffAmountSc,
  //     cancelled: getQuotAllValues!.cancelled == null ||
  //             getQuotAllValues!.cancelled == "null"
  //         ? null
  //         : getQuotAllValues!.cancelled,
  //     signatureInputMessage: getQuotAllValues!.signatureInputMessage == null ||
  //             getQuotAllValues!.signatureInputMessage == "null"
  //         ? null
  //         : getQuotAllValues!.signatureInputMessage,
  //     signatureDigest: getQuotAllValues!.signatureDigest == null ||
  //             getQuotAllValues!.signatureDigest == "null"
  //         ? null
  //         : getQuotAllValues!.signatureDigest,
  //     certificationNumber: getQuotAllValues!.certificationNumber == null ||
  //             getQuotAllValues!.certificationNumber == "null"
  //         ? null
  //         : getQuotAllValues!.certificationNumber,
  //     privateKeyVersion: getQuotAllValues!.privateKeyVersion == null ||
  //             getQuotAllValues!.privateKeyVersion == "null"
  //         ? null
  //         : getQuotAllValues!.privateKeyVersion,
  //     controlAccount: getQuotAllValues!.controlAccount == null ||
  //             getQuotAllValues!.controlAccount == "null"
  //         ? null
  //         : getQuotAllValues!.controlAccount,
  //     insuranceOperation347: getQuotAllValues!.insuranceOperation347 == null ||
  //             getQuotAllValues!.insuranceOperation347 == "null"
  //         ? null
  //         : getQuotAllValues!.insuranceOperation347,
  //     archiveNonremovableSalesQuotation:
  //         getQuotAllValues!.archiveNonremovableSalesQuotation == null ||
  //                 getQuotAllValues!.archiveNonremovableSalesQuotation == "null"
  //             ? null
  //             : getQuotAllValues!.archiveNonremovableSalesQuotation,
  //     gtsChecker: getQuotAllValues!.gtsChecker == null ||
  //             getQuotAllValues!.gtsChecker == "null"
  //         ? null
  //         : getQuotAllValues!.gtsChecker,
  //     gtsPayee: getQuotAllValues!.gtsPayee == null ||
  //             getQuotAllValues!.gtsPayee == "null"
  //         ? null
  //         : getQuotAllValues!.gtsPayee,
  //     extraMonth: getQuotAllValues!.extraMonth == null ||
  //             getQuotAllValues!.extraMonth == "null"
  //         ? null
  //         : getQuotAllValues!.extraMonth,
  //     extraDays: getQuotAllValues!.extraDays == null ||
  //             getQuotAllValues!.extraDays == "null"
  //         ? null
  //         : getQuotAllValues!.extraDays,
  //     cashDiscountDateOffset:
  //         getQuotAllValues!.cashDiscountDateOffset == null ||
  //                 getQuotAllValues!.cashDiscountDateOffset == "null"
  //             ? null
  //             : getQuotAllValues!.cashDiscountDateOffset,
  //     startFrom: getQuotAllValues!.startFrom == null ||
  //             getQuotAllValues!.startFrom == "null"
  //         ? null
  //         : getQuotAllValues!.startFrom,
  //     ntsApproved: getQuotAllValues!.ntsApproved == null ||
  //             getQuotAllValues!.ntsApproved == "null"
  //         ? null
  //         : getQuotAllValues!.ntsApproved,
  //     eTaxWebSite: getQuotAllValues!.eTaxWebSite == null ||
  //             getQuotAllValues!.eTaxWebSite == "null"
  //         ? null
  //         : getQuotAllValues!.eTaxWebSite,
  //     eTaxNumber: getQuotAllValues!.eTaxNumber == null ||
  //             getQuotAllValues!.eTaxNumber == "null"
  //         ? null
  //         : getQuotAllValues!.eTaxNumber,
  //     ntsApprovedNumber: getQuotAllValues!.ntsApprovedNumber == null ||
  //             getQuotAllValues!.ntsApprovedNumber == "null"
  //         ? null
  //         : getQuotAllValues!.ntsApprovedNumber,
  //     eDocGenerationType: getQuotAllValues!.eDocGenerationType == null ||
  //             getQuotAllValues!.eDocGenerationType == "null"
  //         ? null
  //         : getQuotAllValues!.eDocGenerationType,
  //     eDocSeries: getQuotAllValues!.eDocSeries == null ||
  //             getQuotAllValues!.eDocSeries == "null"
  //         ? null
  //         : getQuotAllValues!.eDocSeries,
  //     eDocNum: getQuotAllValues!.eDocNum == null ||
  //             getQuotAllValues!.eDocNum == "null"
  //         ? null
  //         : getQuotAllValues!.eDocNum,
  //     eDocExportFormat: getQuotAllValues!.eDocExportFormat == null ||
  //             getQuotAllValues!.eDocExportFormat == "null"
  //         ? null
  //         : getQuotAllValues!.eDocExportFormat,
  //     eDocStatus: getQuotAllValues!.eDocStatus == null ||
  //             getQuotAllValues!.eDocStatus == "null"
  //         ? null
  //         : getQuotAllValues!.eDocStatus,
  //     eDocErrorCode: getQuotAllValues!.eDocErrorCode == null ||
  //             getQuotAllValues!.eDocErrorCode == "null"
  //         ? null
  //         : getQuotAllValues!.eDocErrorCode,
  //     eDocErrorMessage: getQuotAllValues!.eDocErrorMessage == null ||
  //             getQuotAllValues!.eDocErrorMessage == "null"
  //         ? null
  //         : getQuotAllValues!.eDocErrorMessage,
  //     downPaymentStatus: getQuotAllValues!.downPaymentStatus == null ||
  //             getQuotAllValues!.downPaymentStatus == "null"
  //         ? null
  //         : getQuotAllValues!.downPaymentStatus,
  //     groupSeries: getQuotAllValues!.groupSeries == null ||
  //             getQuotAllValues!.groupSeries == "null"
  //         ? null
  //         : getQuotAllValues!.groupSeries,
  //     groupNumber: getQuotAllValues!.groupNumber == null ||
  //             getQuotAllValues!.groupNumber == "null"
  //         ? null
  //         : getQuotAllValues!.groupNumber,
  //     groupHandWritten: getQuotAllValues!.groupHandWritten == null ||
  //             getQuotAllValues!.groupHandWritten == "null"
  //         ? null
  //         : getQuotAllValues!.groupHandWritten,
  //     reopenOriginalDocument:
  //         getQuotAllValues!.reopenOriginalDocument == null ||
  //                 getQuotAllValues!.reopenOriginalDocument == "null"
  //             ? null
  //             : getQuotAllValues!.reopenOriginalDocument,
  //     reopenManuallyClosedOrCanceledDocument:
  //         getQuotAllValues!.reopenManuallyClosedOrCanceledDocument == null ||
  //                 getQuotAllValues!.reopenManuallyClosedOrCanceledDocument ==
  //                     "null"
  //             ? null
  //             : getQuotAllValues!.reopenManuallyClosedOrCanceledDocument,
  //     createOnlineQuotation: getQuotAllValues!.createOnlineQuotation == null ||
  //             getQuotAllValues!.createOnlineQuotation == "null"
  //         ? null
  //         : getQuotAllValues!.createOnlineQuotation,
  //     posEquipmentNumber: getQuotAllValues!.posEquipmentNumber == null ||
  //             getQuotAllValues!.posEquipmentNumber == "null"
  //         ? null
  //         : getQuotAllValues!.posEquipmentNumber,
  //     posManufacturerSerialNumber:
  //         getQuotAllValues!.posManufacturerSerialNumber == null ||
  //                 getQuotAllValues!.posManufacturerSerialNumber == "null"
  //             ? null
  //             : getQuotAllValues!.posManufacturerSerialNumber,
  //     posCashierNumber: getQuotAllValues!.posCashierNumber == null ||
  //             getQuotAllValues!.posCashierNumber == "null"
  //         ? null
  //         : getQuotAllValues!.posCashierNumber,
  //     applyCurrentVatRatesForDownPaymentsToDraw:
  //         getQuotAllValues!.applyCurrentVatRatesForDownPaymentsToDraw == null ||
  //                 getQuotAllValues!.applyCurrentVatRatesForDownPaymentsToDraw ==
  //                     "null"
  //             ? null
  //             : getQuotAllValues!.applyCurrentVatRatesForDownPaymentsToDraw,
  //     closingOption: getQuotAllValues!.closingOption == null ||
  //             getQuotAllValues!.closingOption == "null"
  //         ? null
  //         : getQuotAllValues!.closingOption,
  //     specifiedClosingDate: getQuotAllValues!.specifiedClosingDate == null ||
  //             getQuotAllValues!.specifiedClosingDate == "null"
  //         ? null
  //         : getQuotAllValues!.specifiedClosingDate,
  //     openForLandedCosts: getQuotAllValues!.openForLandedCosts == null ||
  //             getQuotAllValues!.openForLandedCosts == "null"
  //         ? null
  //         : getQuotAllValues!.openForLandedCosts,
  //     authorizationStatus: getQuotAllValues!.authorizationStatus == null ||
  //             getQuotAllValues!.authorizationStatus == "null"
  //         ? null
  //         : getQuotAllValues!.authorizationStatus,
  //     totalDiscountFc: getQuotAllValues!.totalDiscountFc == null ||
  //             getQuotAllValues!.totalDiscountFc == "null"
  //         ? null
  //         : getQuotAllValues!.totalDiscountFc,
  //     totalDiscountSc: getQuotAllValues!.totalDiscountSc == null ||
  //             getQuotAllValues!.totalDiscountSc == "null"
  //         ? null
  //         : getQuotAllValues!.totalDiscountSc,
  //     relevantToGts: getQuotAllValues!.relevantToGts == null ||
  //             getQuotAllValues!.relevantToGts == "null"
  //         ? null
  //         : getQuotAllValues!.relevantToGts,
  //     bplName: getQuotAllValues!.bplName == null ||
  //             getQuotAllValues!.bplName == "null"
  //         ? null
  //         : getQuotAllValues!.bplName,
  //     vatRegNum: getQuotAllValues!.vatRegNum == null ||
  //             getQuotAllValues!.vatRegNum == "null"
  //         ? null
  //         : getQuotAllValues!.vatRegNum,
  //     annualInvoiceDeclarationReference:
  //         getQuotAllValues!.annualInvoiceDeclarationReference == null ||
  //                 getQuotAllValues!.annualInvoiceDeclarationReference == "null"
  //             ? null
  //             : getQuotAllValues!.annualInvoiceDeclarationReference,
  //     supplier: getQuotAllValues!.supplier == null ||
  //             getQuotAllValues!.supplier == "null"
  //         ? null
  //         : getQuotAllValues!.supplier,
  //     releaser: getQuotAllValues!.releaser == null ||
  //             getQuotAllValues!.releaser == "null"
  //         ? null
  //         : getQuotAllValues!.releaser,
  //     receiver: getQuotAllValues!.receiver == null ||
  //             getQuotAllValues!.receiver == "null"
  //         ? null
  //         : getQuotAllValues!.receiver,
  //     blanketAgreementNumber:
  //         getQuotAllValues!.blanketAgreementNumber == null ||
  //                 getQuotAllValues!.blanketAgreementNumber == "null"
  //             ? null
  //             : getQuotAllValues!.blanketAgreementNumber,
  //     isAlteration: getQuotAllValues!.isAlteration == null ||
  //             getQuotAllValues!.isAlteration == "null"
  //         ? null
  //         : getQuotAllValues!.isAlteration,
  //     cancelStatus: getQuotAllValues!.cancelStatus == null ||
  //             getQuotAllValues!.cancelStatus == "null"
  //         ? null
  //         : getQuotAllValues!.cancelStatus,
  //     assetValueDate: getQuotAllValues!.assetValueDate == null ||
  //             getQuotAllValues!.assetValueDate == "null"
  //         ? null
  //         : getQuotAllValues!.assetValueDate,
  //     documentDelivery: getQuotAllValues!.documentDelivery == null ||
  //             getQuotAllValues!.documentDelivery == "null"
  //         ? null
  //         : getQuotAllValues!.documentDelivery,
  //     authorizationCode: getQuotAllValues!.authorizationCode == null ||
  //             getQuotAllValues!.authorizationCode == "null"
  //         ? null
  //         : getQuotAllValues!.authorizationCode,
  //     startDeliveryDate: getQuotAllValues!.startDeliveryDate == null ||
  //             getQuotAllValues!.startDeliveryDate == "null"
  //         ? null
  //         : getQuotAllValues!.startDeliveryDate,
  //     startDeliveryTime: getQuotAllValues!.startDeliveryTime == null ||
  //             getQuotAllValues!.startDeliveryTime == "null"
  //         ? null
  //         : getQuotAllValues!.startDeliveryTime,
  //     endDeliveryDate: getQuotAllValues!.endDeliveryDate == null ||
  //             getQuotAllValues!.endDeliveryDate == "null"
  //         ? null
  //         : getQuotAllValues!.endDeliveryDate,
  //     endDeliveryTime: getQuotAllValues!.endDeliveryTime == null ||
  //             getQuotAllValues!.endDeliveryTime == "null"
  //         ? null
  //         : getQuotAllValues!.endDeliveryTime,
  //     vehiclePlate: getQuotAllValues!.vehiclePlate == null ||
  //             getQuotAllValues!.vehiclePlate == "null"
  //         ? null
  //         : getQuotAllValues!.vehiclePlate,
  //     atDocumentType: getQuotAllValues!.atDocumentType == null ||
  //             getQuotAllValues!.atDocumentType == "null"
  //         ? null
  //         : getQuotAllValues!.atDocumentType,
  //     elecCommStatus: getQuotAllValues!.elecCommStatus == null ||
  //             getQuotAllValues!.elecCommStatus == "null"
  //         ? null
  //         : getQuotAllValues!.elecCommStatus,
  //     elecCommMessage: getQuotAllValues!.elecCommMessage == null ||
  //             getQuotAllValues!.elecCommMessage == "null"
  //         ? null
  //         : getQuotAllValues!.elecCommMessage,
  //     reuseDocumentNum: getQuotAllValues!.reuseDocumentNum == null ||
  //             getQuotAllValues!.reuseDocumentNum == "null"
  //         ? null
  //         : getQuotAllValues!.reuseDocumentNum,
  //     reuseNotaFiscalNum: getQuotAllValues!.reuseNotaFiscalNum == null ||
  //             getQuotAllValues!.reuseNotaFiscalNum == "null"
  //         ? null
  //         : getQuotAllValues!.reuseNotaFiscalNum,
  //     printSepaDirect: getQuotAllValues!.printSepaDirect == null ||
  //             getQuotAllValues!.printSepaDirect == "null"
  //         ? null
  //         : getQuotAllValues!.printSepaDirect,
  //     fiscalDocNum: getQuotAllValues!.fiscalDocNum == null ||
  //             getQuotAllValues!.fiscalDocNum == "null"
  //         ? null
  //         : getQuotAllValues!.fiscalDocNum,
  //     posDailySummaryNo: getQuotAllValues!.posDailySummaryNo == null ||
  //             getQuotAllValues!.posDailySummaryNo == "null"
  //         ? null
  //         : getQuotAllValues!.posDailySummaryNo,
  //     posReceiptNo: getQuotAllValues!.posReceiptNo == null ||
  //             getQuotAllValues!.posReceiptNo == "null"
  //         ? null
  //         : getQuotAllValues!.posReceiptNo,
  //     pointOfIssueCode: getQuotAllValues!.pointOfIssueCode == null ||
  //             getQuotAllValues!.pointOfIssueCode == "null"
  //         ? null
  //         : getQuotAllValues!.pointOfIssueCode,
  //     letter:
  //         getQuotAllValues!.letter == null || getQuotAllValues!.letter == "null"
  //             ? null
  //             : getQuotAllValues!.letter,
  //     folioNumberFrom: getQuotAllValues!.folioNumberFrom == null ||
  //             getQuotAllValues!.folioNumberFrom == "null"
  //         ? null
  //         : getQuotAllValues!.folioNumberFrom,
  //     folioNumberTo: getQuotAllValues!.folioNumberTo == null ||
  //             getQuotAllValues!.folioNumberTo == "null"
  //         ? null
  //         : getQuotAllValues!.folioNumberTo,
  //     interimType: getQuotAllValues!.interimType == null ||
  //             getQuotAllValues!.interimType == "null"
  //         ? null
  //         : getQuotAllValues!.interimType,
  //     relatedType: getQuotAllValues!.relatedType == null ||
  //             getQuotAllValues!.relatedType == "null"
  //         ? null
  //         : getQuotAllValues!.relatedType,
  //     relatedEntry: getQuotAllValues!.relatedEntry == null ||
  //             getQuotAllValues!.relatedEntry == "null"
  //         ? null
  //         : getQuotAllValues!.relatedEntry,
  //     sapPassport: getQuotAllValues!.sapPassport == null ||
  //             getQuotAllValues!.sapPassport == "null"
  //         ? null
  //         : getQuotAllValues!.sapPassport,
  //     documentTaxId: getQuotAllValues!.documentTaxId == null ||
  //             getQuotAllValues!.documentTaxId == "null"
  //         ? null
  //         : getQuotAllValues!.documentTaxId,
  //     dateOfReportingControlStatementVat:
  //         getQuotAllValues!.dateOfReportingControlStatementVat == null ||
  //                 getQuotAllValues!.dateOfReportingControlStatementVat == "null"
  //             ? null
  //             : getQuotAllValues!.dateOfReportingControlStatementVat,
  //     reportingSectionControlStatementVat:
  //         getQuotAllValues!.reportingSectionControlStatementVat == null ||
  //                 getQuotAllValues!.reportingSectionControlStatementVat ==
  //                     "null"
  //             ? null
  //             : getQuotAllValues!.reportingSectionControlStatementVat,
  //     excludeFromTaxReportControlStatementVat:
  //         getQuotAllValues!.excludeFromTaxReportControlStatementVat == null ||
  //                 getQuotAllValues!.excludeFromTaxReportControlStatementVat ==
  //                     "null"
  //             ? null
  //             : getQuotAllValues!.excludeFromTaxReportControlStatementVat,
  //     posCashRegister: getQuotAllValues!.posCashRegister == null ||
  //             getQuotAllValues!.posCashRegister == "null"
  //         ? null
  //         : getQuotAllValues!.posCashRegister,
  //     updateTime: getQuotAllValues!.updateTime == null ||
  //             getQuotAllValues!.updateTime == "null"
  //         ? null
  //         : getQuotAllValues!.updateTime,
  //     createQrCodeFrom: getQuotAllValues!.createQrCodeFrom == null ||
  //             getQuotAllValues!.createQrCodeFrom == "null"
  //         ? null
  //         : getQuotAllValues!.createQrCodeFrom,
  //     priceMode: getQuotAllValues!.priceMode == null ||
  //             getQuotAllValues!.priceMode == "null"
  //         ? null
  //         : getQuotAllValues!.priceMode,
  //     shipFrom: getQuotAllValues!.shipFrom == null ||
  //             getQuotAllValues!.shipFrom == "null"
  //         ? null
  //         : getQuotAllValues!.shipFrom,
  //     commissionTrade: getQuotAllValues!.commissionTrade == null ||
  //             getQuotAllValues!.commissionTrade == "null"
  //         ? null
  //         : getQuotAllValues!.commissionTrade,
  //     commissionTradeReturn: getQuotAllValues!.commissionTradeReturn == null ||
  //             getQuotAllValues!.commissionTradeReturn == "null"
  //         ? null
  //         : getQuotAllValues!.commissionTradeReturn,
  //     useBillToAddrToDetermineTax:
  //         getQuotAllValues!.useBillToAddrToDetermineTax == null ||
  //                 getQuotAllValues!.useBillToAddrToDetermineTax == "null"
  //             ? null
  //             : getQuotAllValues!.useBillToAddrToDetermineTax,
  //     cig: getQuotAllValues!.cig == null || getQuotAllValues!.cig == "null"
  //         ? null
  //         : getQuotAllValues!.cig,
  //     cup: getQuotAllValues!.cup == null || getQuotAllValues!.cup == "null"
  //         ? null
  //         : getQuotAllValues!.cup,
  //     fatherCard: getQuotAllValues!.fatherCard == null ||
  //             getQuotAllValues!.fatherCard == "null"
  //         ? null
  //         : getQuotAllValues!.fatherCard,
  //     fatherType: getQuotAllValues!.fatherType == null ||
  //             getQuotAllValues!.fatherType == "null"
  //         ? null
  //         : getQuotAllValues!.fatherType,
  //     shipState: getQuotAllValues!.shipState == null ||
  //             getQuotAllValues!.shipState == "null"
  //         ? null
  //         : getQuotAllValues!.shipState,
  //     shipPlace: getQuotAllValues!.shipPlace == null ||
  //             getQuotAllValues!.shipPlace == "null"
  //         ? null
  //         : getQuotAllValues!.shipPlace,
  //     custOffice: getQuotAllValues!.custOffice == null ||
  //             getQuotAllValues!.custOffice == "null"
  //         ? null
  //         : getQuotAllValues!.custOffice,
  //     fci: getQuotAllValues!.fci == null || getQuotAllValues!.fci == "null"
  //         ? null
  //         : getQuotAllValues!.fci,
  //     addLegIn: getQuotAllValues!.addLegIn == null ||
  //             getQuotAllValues!.addLegIn == "null"
  //         ? null
  //         : getQuotAllValues!.addLegIn,
  //     legTextF: getQuotAllValues!.legTextF == null ||
  //             getQuotAllValues!.legTextF == "null"
  //         ? null
  //         : getQuotAllValues!.legTextF,
  //     danfeLgTxt: getQuotAllValues!.danfeLgTxt == null ||
  //             getQuotAllValues!.danfeLgTxt == "null"
  //         ? null
  //         : getQuotAllValues!.danfeLgTxt,
  //     indFinal: getQuotAllValues!.indFinal == null ||
  //             getQuotAllValues!.indFinal == "null"
  //         ? null
  //         : getQuotAllValues!.indFinal,
  //     dataVersion: getQuotAllValues!.dataVersion == null ||
  //             getQuotAllValues!.dataVersion == "null"
  //         ? null
  //         : getQuotAllValues!.dataVersion,
  //     uPurchaseType: getQuotAllValues!.uPurchaseType == null ||
  //             getQuotAllValues!.uPurchaseType == "null"
  //         ? null
  //         : getQuotAllValues!.uPurchaseType,
  //     uApApprove: getQuotAllValues!.uApApprove == null ||
  //             getQuotAllValues!.uApApprove == "null"
  //         ? null
  //         : getQuotAllValues!.uApApprove,
  //     uFinalDel: getQuotAllValues!.uFinalDel == null ||
  //             getQuotAllValues!.uFinalDel == "null"
  //         ? null
  //         : getQuotAllValues!.uFinalDel,
  //     uIncoTerms: getQuotAllValues!.uIncoTerms == null ||
  //             getQuotAllValues!.uIncoTerms == "null"
  //         ? null
  //         : getQuotAllValues!.uIncoTerms,
  //     uSourceDest: getQuotAllValues!.uSourceDest == null ||
  //             getQuotAllValues!.uSourceDest == "null"
  //         ? null
  //         : getQuotAllValues!.uSourceDest,
  //     uTransNo: getQuotAllValues!.uTransNo == null ||
  //             getQuotAllValues!.uTransNo == "null"
  //         ? null
  //         : getQuotAllValues!.uTransNo,
  //     uVehicleNo: getQuotAllValues!.uVehicleNo == null ||
  //             getQuotAllValues!.uVehicleNo == "null"
  //         ? null
  //         : getQuotAllValues!.uVehicleNo,
  //     uSupplierDt: getQuotAllValues!.uSupplierDt == null ||
  //             getQuotAllValues!.uSupplierDt == "null"
  //         ? null
  //         : getQuotAllValues!.uSupplierDt,
  //     uQuotNo: getQuotAllValues!.uQuotNo == null ||
  //             getQuotAllValues!.uQuotNo == "null"
  //         ? null
  //         : getQuotAllValues!.uQuotNo,
  //     uQuotDate: getQuotAllValues!.uQuotDate == null ||
  //             getQuotAllValues!.uQuotDate == "null"
  //         ? null
  //         : getQuotAllValues!.uQuotDate,
  //     uGovPermit: getQuotAllValues!.uGovPermit == null ||
  //             getQuotAllValues!.uGovPermit == "null"
  //         ? null
  //         : getQuotAllValues!.uGovPermit,
  //     uGovPermitdt: getQuotAllValues!.uGovPermitdt == null ||
  //             getQuotAllValues!.uGovPermitdt == "null"
  //         ? null
  //         : getQuotAllValues!.uGovPermitdt,
  //     uCheckNo: getQuotAllValues!.uCheckNo == null ||
  //             getQuotAllValues!.uCheckNo == "null"
  //         ? null
  //         : getQuotAllValues!.uCheckNo,
  //     uCheckDate: getQuotAllValues!.uCheckDate == null ||
  //             getQuotAllValues!.uCheckDate == "null"
  //         ? null
  //         : getQuotAllValues!.uCheckDate,
  //     uApprovalDate: getQuotAllValues!.uApprovalDate == null ||
  //             getQuotAllValues!.uApprovalDate == "null"
  //         ? null
  //         : getQuotAllValues!.uApprovalDate,
  //     uOrderNoRecd: getQuotAllValues!.uOrderNoRecd == null ||
  //             getQuotAllValues!.uOrderNoRecd == "null"
  //         ? null
  //         : getQuotAllValues!.uOrderNoRecd,
  //     uOrderDate: getQuotAllValues!.uOrderDate == null ||
  //             getQuotAllValues!.uOrderDate == "null"
  //         ? null
  //         : getQuotAllValues!.uOrderDate,
  //     uClearingAgent: getQuotAllValues!.uClearingAgent == null ||
  //             getQuotAllValues!.uClearingAgent == "null"
  //         ? null
  //         : getQuotAllValues!.uClearingAgent,
  //     uDateSubAgent: getQuotAllValues!.uDateSubAgent == null ||
  //             getQuotAllValues!.uDateSubAgent == "null"
  //         ? null
  //         : getQuotAllValues!.uDateSubAgent,
  //     uIdfno:
  //         getQuotAllValues!.uIdfno == null || getQuotAllValues!.uIdfno == "null"
  //             ? null
  //             : getQuotAllValues!.uIdfno,
  //     uIdfDate: getQuotAllValues!.uIdfDate == null ||
  //             getQuotAllValues!.uIdfDate == "null"
  //         ? null
  //         : getQuotAllValues!.uIdfDate,
  //     uInspectionNo: getQuotAllValues!.uInspectionNo == null ||
  //             getQuotAllValues!.uInspectionNo == "null"
  //         ? null
  //         : getQuotAllValues!.uInspectionNo,
  //     uEta: getQuotAllValues!.uEta == null || getQuotAllValues!.uEta == "null"
  //         ? null
  //         : getQuotAllValues!.uEta,
  //     uAirwayBillNo: getQuotAllValues!.uAirwayBillNo == null ||
  //             getQuotAllValues!.uAirwayBillNo == "null"
  //         ? null
  //         : getQuotAllValues!.uAirwayBillNo,
  //     uBol: getQuotAllValues!.uBol == null || getQuotAllValues!.uBol == "null"
  //         ? null
  //         : getQuotAllValues!.uBol,
  //     uCotecna: getQuotAllValues!.uCotecna == null ||
  //             getQuotAllValues!.uCotecna == "null"
  //         ? null
  //         : getQuotAllValues!.uCotecna,
  //     uArrivalDate: getQuotAllValues!.uArrivalDate == null ||
  //             getQuotAllValues!.uArrivalDate == "null"
  //         ? null
  //         : getQuotAllValues!.uArrivalDate,
  //     uDahacoAgentFees: getQuotAllValues!.uDahacoAgentFees == null ||
  //             getQuotAllValues!.uDahacoAgentFees == "null"
  //         ? null
  //         : getQuotAllValues!.uDahacoAgentFees,
  //     uPortCharges: getQuotAllValues!.uPortCharges == null ||
  //             getQuotAllValues!.uPortCharges == "null"
  //         ? null
  //         : getQuotAllValues!.uPortCharges,
  //     uOtherExp: getQuotAllValues!.uOtherExp == null ||
  //             getQuotAllValues!.uOtherExp == "null"
  //         ? null
  //         : getQuotAllValues!.uOtherExp,
  //     uClearCharges: getQuotAllValues!.uClearCharges == null ||
  //             getQuotAllValues!.uClearCharges == "null"
  //         ? null
  //         : getQuotAllValues!.uClearCharges,
  //     uHiddenChrges: getQuotAllValues!.uHiddenChrges == null ||
  //             getQuotAllValues!.uHiddenChrges == "null"
  //         ? null
  //         : getQuotAllValues!.uHiddenChrges,
  //     uGoodsInspBy: getQuotAllValues!.uGoodsInspBy == null ||
  //             getQuotAllValues!.uGoodsInspBy == "null"
  //         ? null
  //         : getQuotAllValues!.uGoodsInspBy,
  //     uGoodsReport: getQuotAllValues!.uGoodsReport == null ||
  //             getQuotAllValues!.uGoodsReport == "null"
  //         ? null
  //         : getQuotAllValues!.uGoodsReport,
  //     uPymtStatus: getQuotAllValues!.uPymtStatus == null ||
  //             getQuotAllValues!.uPymtStatus == "null"
  //         ? null
  //         : getQuotAllValues!.uPymtStatus,
  //     uPymtType: getQuotAllValues!.uPymtType == null ||
  //             getQuotAllValues!.uPymtType == "null"
  //         ? null
  //         : getQuotAllValues!.uPymtType,
  //     uTtCopyImage: getQuotAllValues!.uTtCopyImage == null ||
  //             getQuotAllValues!.uTtCopyImage == "null"
  //         ? null
  //         : getQuotAllValues!.uTtCopyImage,
  //     uPfiImage: getQuotAllValues!.uPfiImage == null ||
  //             getQuotAllValues!.uPfiImage == "null"
  //         ? null
  //         : getQuotAllValues!.uPfiImage,
  //     uSupplierImage: getQuotAllValues!.uSupplierImage == null ||
  //             getQuotAllValues!.uSupplierImage == "null"
  //         ? null
  //         : getQuotAllValues!.uSupplierImage,
  //     uBolImage: getQuotAllValues!.uBolImage == null ||
  //             getQuotAllValues!.uBolImage == "null"
  //         ? null
  //         : getQuotAllValues!.uBolImage,
  //     uOrderType: getQuotAllValues!.uOrderType == null ||
  //             getQuotAllValues!.uOrderType == "null"
  //         ? null
  //         : getQuotAllValues!.uOrderType,
  //     uTruckInternal: getQuotAllValues!.uTruckInternal == null ||
  //             getQuotAllValues!.uTruckInternal == "null"
  //         ? null
  //         : getQuotAllValues!.uTruckInternal,
  //     uGpApproval: getQuotAllValues!.uGpApproval == null ||
  //             getQuotAllValues!.uGpApproval == "null"
  //         ? null
  //         : getQuotAllValues!.uGpApproval,
  //     uSupplierName: getQuotAllValues!.uSupplierName == null ||
  //             getQuotAllValues!.uSupplierName == "null"
  //         ? null
  //         : getQuotAllValues!.uSupplierName,
  //     uVatNumber: getQuotAllValues!.uVatNumber == null ||
  //             getQuotAllValues!.uVatNumber == "null"
  //         ? null
  //         : getQuotAllValues!.uVatNumber,
  //     uTransferType: getQuotAllValues!.uTransferType == null ||
  //             getQuotAllValues!.uTransferType == "null"
  //         ? null
  //         : getQuotAllValues!.uTransferType,
  //     uSalesOrder: getQuotAllValues!.uSalesOrder == null ||
  //             getQuotAllValues!.uSalesOrder == "null"
  //         ? null
  //         : getQuotAllValues!.uSalesOrder,
  //     uReceived: getQuotAllValues!.uReceived == null ||
  //             getQuotAllValues!.uReceived == "null"
  //         ? null
  //         : getQuotAllValues!.uReceived,
  //     uDriverName: getQuotAllValues!.uDriverName == null ||
  //             getQuotAllValues!.uDriverName == "null"
  //         ? null
  //         : getQuotAllValues!.uDriverName,
  //     uReserveInvoice: getQuotAllValues!.uReserveInvoice == null ||
  //             getQuotAllValues!.uReserveInvoice == "null"
  //         ? null
  //         : getQuotAllValues!.uReserveInvoice,
  //     uRefSeries: getQuotAllValues!.uRefSeries == null ||
  //             getQuotAllValues!.uRefSeries == "null"
  //         ? null
  //         : getQuotAllValues!.uRefSeries,
  //     uReceivedTime: getQuotAllValues!.uReceivedTime == null ||
  //             getQuotAllValues!.uReceivedTime == "null"
  //         ? null
  //         : getQuotAllValues!.uReceivedTime,
  //     uSkuBatchNo: getQuotAllValues!.uSkuBatchNo == null ||
  //             getQuotAllValues!.uSkuBatchNo == "null"
  //         ? null
  //         : getQuotAllValues!.uSkuBatchNo,
  //     uInwardNo: getQuotAllValues!.uInwardNo == null ||
  //             getQuotAllValues!.uInwardNo == "null"
  //         ? null
  //         : getQuotAllValues!.uInwardNo,
  //     uDispatchTime: getQuotAllValues!.uDispatchTime == null ||
  //             getQuotAllValues!.uDispatchTime == "null"
  //         ? null
  //         : getQuotAllValues!.uDispatchTime,
  //     uReceivedDate: getQuotAllValues!.uReceivedDate == null ||
  //             getQuotAllValues!.uReceivedDate == "null"
  //         ? null
  //         : getQuotAllValues!.uReceivedDate,
  //     uExpiryDate: getQuotAllValues!.uExpiryDate == null ||
  //             getQuotAllValues!.uExpiryDate == "null"
  //         ? null
  //         : getQuotAllValues!.uExpiryDate,
  //     uCnType: getQuotAllValues!.uCnType == null ||
  //             getQuotAllValues!.uCnType == "null"
  //         ? null
  //         : getQuotAllValues!.uCnType,
  //     uTinNo:
  //         getQuotAllValues!.uTinNo == null || getQuotAllValues!.uTinNo == "null"
  //             ? null
  //             : getQuotAllValues!.uTinNo,
  //     uLpoNo:
  //         getQuotAllValues!.uLpoNo == null || getQuotAllValues!.uLpoNo == "null"
  //             ? null
  //             : getQuotAllValues!.uLpoNo,
  //     uOrderQty: getQuotAllValues!.uOrderQty == null ||
  //             getQuotAllValues!.uOrderQty == "null"
  //         ? null
  //         : getQuotAllValues!.uOrderQty,
  //     uDispatchDate: getQuotAllValues!.uDispatchDate == null ||
  //             getQuotAllValues!.uDispatchDate == "null"
  //         ? null
  //         : getQuotAllValues!.uDispatchDate,
  //     uBranch: getQuotAllValues!.uBranch == null ||
  //             getQuotAllValues!.uBranch == "null"
  //         ? null
  //         : getQuotAllValues!.uBranch,
  //     uSalAppEntry: getQuotAllValues!.uSalAppEntry == null ||
  //             getQuotAllValues!.uSalAppEntry == "null"
  //         ? null
  //         : getQuotAllValues!.uSalAppEntry,
  //     uDocType: getQuotAllValues!.uDocType == null ||
  //             getQuotAllValues!.uDocType == "null"
  //         ? null
  //         : getQuotAllValues!.uDocType,
  //     uIntKey: getQuotAllValues!.uIntKey == null ||
  //             getQuotAllValues!.uIntKey == "null"
  //         ? null
  //         : getQuotAllValues!.uIntKey,
  //     uQrFileLoc: getQuotAllValues!.uQrFileLoc == null ||
  //             getQuotAllValues!.uQrFileLoc == "null"
  //         ? null
  //         : getQuotAllValues!.uQrFileLoc,
  //     uRctCde: getQuotAllValues!.uRctCde == null ||
  //             getQuotAllValues!.uRctCde == "null"
  //         ? null
  //         : getQuotAllValues!.uRctCde,
  //     uZno: getQuotAllValues!.uZno == null || getQuotAllValues!.uZno == "null"
  //         ? null
  //         : getQuotAllValues!.uZno,
  //     uVfdIn:
  //         getQuotAllValues!.uVfdIn == null || getQuotAllValues!.uVfdIn == "null"
  //             ? null
  //             : getQuotAllValues!.uVfdIn,
  //     uQrPath: getQuotAllValues!.uQrPath == null ||
  //             getQuotAllValues!.uQrPath == "null"
  //         ? null
  //         : getQuotAllValues!.uQrPath,
  //     uQrValue: getQuotAllValues!.uQrValue == null ||
  //             getQuotAllValues!.uQrValue == "null"
  //         ? null
  //         : getQuotAllValues!.uQrValue,
  //     uIdate:
  //         getQuotAllValues!.uIdate == null || getQuotAllValues!.uIdate == "null"
  //             ? null
  //             : getQuotAllValues!.uIdate,
  //     uItime:
  //         getQuotAllValues!.uItime == null || getQuotAllValues!.uItime == "null"
  //             ? null
  //             : getQuotAllValues!.uItime,
  //     uDeviceCode: getQuotAllValues!.uDeviceCode == null ||
  //             getQuotAllValues!.uDeviceCode == "null"
  //         ? null
  //         : getQuotAllValues!.uDeviceCode,
  //     uDeviceTransId: getQuotAllValues!.uDeviceTransId == null ||
  //             getQuotAllValues!.uDeviceTransId == "null"
  //         ? null
  //         : getQuotAllValues!.uDeviceTransId,
  //     uRvc: getQuotAllValues!.uRvc == null || getQuotAllValues!.uRvc == "null"
  //         ? null
  //         : getQuotAllValues!.uRvc,
  //     uVrn: getQuotAllValues!.uVrn == null || getQuotAllValues!.uVrn == "null"
  //         ? null
  //         : getQuotAllValues!.uVrn,
  //     uLongitude: getQuotAllValues!.uLongitude == null ||
  //             getQuotAllValues!.uLongitude == "null"
  //         ? null
  //         : getQuotAllValues!.uLongitude,
  //     uLatitude: getQuotAllValues!.uLatitude == null ||
  //             getQuotAllValues!.uLatitude == "null"
  //         ? null
  //         : getQuotAllValues!.uLatitude,
  //     uAuditJobGroup: getQuotAllValues!.uAuditJobGroup == null ||
  //             getQuotAllValues!.uAuditJobGroup == "null"
  //         ? null
  //         : getQuotAllValues!.uAuditJobGroup,
  //     uAuditName: getQuotAllValues!.uAuditName == null ||
  //             getQuotAllValues!.uAuditName == "null"
  //         ? null
  //         : getQuotAllValues!.uAuditName,
  //     uRequest: getQuotAllValues!.uRequest == null ||
  //             getQuotAllValues!.uRequest == "null"
  //         ? null
  //         : getQuotAllValues!.uRequest,
  //     uPosDocNo: getQuotAllValues!.uPosDocNo == null ||
  //             getQuotAllValues!.uPosDocNo == "null"
  //         ? null
  //         : getQuotAllValues!.uPosDocNo,
  //     documentLines: [],
  //     documentReferences: getQuotAllValues!.documentReferences!.isNotEmpty
  //         ? getQuotAllValues!.documentReferences
  //         : [],
  //     taxExtension: getQuotAllValues!.taxExtension == null
  //         ? null
  //         : getQuotAllValues!.taxExtension,
  //     addressExtension: getQuotAllValues!.addressExtension == null
  //         ? null
  //         : getQuotAllValues!.addressExtension,
  //   );

  //   // getdocitemsDetailsData = getQuotAllValues!.documentLines!;
  // }

  // putcheckitem() async {
  //   itemsDetailsData = [];
  //   // log("getdocitemsDetailsData::::${getdocitemsDetailsData.length}");
  //   // for (int i = 0; i < getdocitemsDetailsData.length; i++) {
  //   await dputItemListData();
  //   // }
  // }

  // dputItemListData() {
  //   for (int ij = 0; ij < contentitemsDetails55.length; ij++) {
  //     // log("DDDD::${getdocitemsDetailsData[i].itemCode! + ":::" + contentitemsDetails55[ij].itemCode.toString()}");
  //     // if (getdocitemsDetailsData[i].itemCode ==
  //     //     contentitemsDetails55[ij].itemCode) {
  //     log("contentitemsDetails55[ij].lineNo::${contentitemsDetails55[ij].lineNumm}");
  //     // log("message:::");
  //     if (contentitemsDetails55[ij].lineNumm != null) {
  //       itemsDetailsData.add(DocumentLineData(
  //         lineNum: contentitemsDetails55[ij].lineNumm,
  //         // contentitemsDetails55[ij].lineNum,
  //         itemCode: contentitemsDetails55[ij].itemCode,
  //         itemDescription: contentitemsDetails55[ij].itemName,
  //         quantity: contentitemsDetails55[ij].qty,
  //         shipDate: contentitemsDetails55[ij].shipDate,
  //         price: contentitemsDetails55[ij].price,
  //         priceAfterVat: contentitemsDetails55[ij].priceAfterVat,
  //         currency: 'TZS',
  //         rate: contentitemsDetails55[ij].rate,
  //         discountPercent: contentitemsDetails55[ij].discounpercent,
  //         vendorNum: contentitemsDetails55[ij].vendorNum,
  //         serialNum: contentitemsDetails55[ij].serialNum,
  //         warehouseCode: contentitemsDetails55[ij].warehouse,
  //         salesPersonCode: contentitemsDetails55[ij].salesPersonCode,
  //         commisionPercent: contentitemsDetails55[ij].commisionPercent,
  //         treeType: contentitemsDetails55[ij].treeType,
  //         accountCode: contentitemsDetails55[ij].accountCode,
  //         useBaseUnits: contentitemsDetails55[ij].useBaseUnits,
  //         supplierCatNum: contentitemsDetails55[ij].supplierCatNum,
  //         costingCode: contentitemsDetails55[ij].costingCode,
  //         projectCode: contentitemsDetails55[ij].projectCode == null ||
  //                 contentitemsDetails55[ij].projectCode == "null"
  //             ? null
  //             : contentitemsDetails55[ij].projectCode,
  //         // contentitemsDetails55[ij].projectCode,
  //         barCode: contentitemsDetails55[ij].barCode == null ||
  //                 contentitemsDetails55[ij].barCode == "null"
  //             ? null
  //             : contentitemsDetails55[ij].barCode,
  //         vatGroup: contentitemsDetails55[ij].vatGroup,
  //         height1: contentitemsDetails55[ij].height1,
  //         hight1Unit: contentitemsDetails55[ij].hight1Unit == null ||
  //                 contentitemsDetails55[ij].hight1Unit == "null"
  //             ? null
  //             : contentitemsDetails55[ij].hight1Unit,
  //         height2: contentitemsDetails55[ij].height2,
  //         height2Unit: contentitemsDetails55[ij].height2Unit == null ||
  //                 contentitemsDetails55[ij].height2Unit == "null"
  //             ? null
  //             : contentitemsDetails55[ij].height2Unit,
  //         lengh1: contentitemsDetails55[ij].lengh1,
  //         lengh1Unit: contentitemsDetails55[ij].lengh1Unit == null ||
  //                 contentitemsDetails55[ij].lengh1Unit == "null"
  //             ? null
  //             : contentitemsDetails55[ij].lengh1Unit,
  //         lengh2: contentitemsDetails55[ij].lengh2,
  //         lengh2Unit: contentitemsDetails55[ij].lengh2Unit == null ||
  //                 contentitemsDetails55[ij].lengh2Unit == "null"
  //             ? null
  //             : contentitemsDetails55[ij].lengh2Unit,
  //         weight1: contentitemsDetails55[ij].weight1,
  //         weight1Unit: contentitemsDetails55[ij].weight1Unit,
  //         weight2: contentitemsDetails55[ij].weight2,
  //         weight2Unit: contentitemsDetails55[ij].weight2Unit,
  //         factor1: contentitemsDetails55[ij].factor1,
  //         factor2: contentitemsDetails55[ij].factor2,
  //         factor3: contentitemsDetails55[ij].factor3,
  //         factor4: contentitemsDetails55[ij].factor4,
  //         baseType: contentitemsDetails55[ij].baseType,
  //         baseEntry: contentitemsDetails55[ij].baseEntry,
  //         baseLine: contentitemsDetails55[ij].baseLine,
  //         volume: contentitemsDetails55[ij].volume,
  //         volumeUnit: contentitemsDetails55[ij].volumeUnit,
  //         width1: contentitemsDetails55[ij].weight1,
  //         width1Unit: contentitemsDetails55[ij].width1Unit,
  //         width2: contentitemsDetails55[ij].weight2,
  //         width2Unit: contentitemsDetails55[ij].width2Unit,
  //         address: contentitemsDetails55[ij].address,
  //         taxCode: contentitemsDetails55[ij].taxCode,
  //         taxType: contentitemsDetails55[ij].taxType,
  //         taxLiable: contentitemsDetails55[ij].taxLiable,
  //         pickStatus: contentitemsDetails55[ij].pickStatus,
  //         pickQuantity: contentitemsDetails55[ij].pickQuantity,
  //         pickListIdNumber: contentitemsDetails55[ij].pickListIdNumber,
  //         originalItem: contentitemsDetails55[ij].originalItem,
  //         backOrder: contentitemsDetails55[ij].backOrder,
  //         freeText: contentitemsDetails55[ij].freeText,
  //         shippingMethod: contentitemsDetails55[ij].shippingMethod,
  //         poTargetNum: contentitemsDetails55[ij].poTargetNum == null ||
  //                 contentitemsDetails55[ij].poTargetNum == "null"
  //             ? null
  //             : contentitemsDetails55[ij].poTargetNum,
  //         poTargetEntry: contentitemsDetails55[ij].poTargetEntry,
  //         poTargetRowNum: contentitemsDetails55[ij].poTargetRowNum,
  //         correctionInvoiceItem:
  //             contentitemsDetails55[ij].correctionInvoiceItem,
  //         corrInvAmountToStock: contentitemsDetails55[ij].corrInvAmountToStock,
  //         corrInvAmountToDiffAcct:
  //             contentitemsDetails55[ij].corrInvAmountToDiffAcct,
  //         appliedTax: contentitemsDetails55[ij].appliedTax,
  //         appliedTaxFc: contentitemsDetails55[ij].appliedTaxFc,
  //         appliedTaxSc: contentitemsDetails55[ij].appliedTaxSc,
  //         wtLiable: contentitemsDetails55[ij].wtLiable,
  //         deferredTax: contentitemsDetails55[ij].deferredTax,
  //         equalizationTaxPercent:
  //             contentitemsDetails55[ij].equalizationTaxPercent,
  //         totalEqualizationTax: contentitemsDetails55[ij].totalEqualizationTax,
  //         totalEqualizationTaxFc:
  //             contentitemsDetails55[ij].totalEqualizationTaxFc,
  //         totalEqualizationTaxSc:
  //             contentitemsDetails55[ij].totalEqualizationTaxSc,
  //         netTaxAmount: contentitemsDetails55[ij].netTaxAmount,
  //         netTaxAmountFc: contentitemsDetails55[ij].netTaxAmountFc,
  //         netTaxAmountSc: contentitemsDetails55[ij].netTaxAmountSc,
  //         measureUnit: contentitemsDetails55[ij].measureUnit,
  //         unitsOfMeasurment: contentitemsDetails55[ij].unitsOfMeasurment,
  //         lineTotal: contentitemsDetails55[ij].lineTotal,
  //         taxPercentagePerRow: contentitemsDetails55[ij].taxPercentagePerRow,
  //         taxTotal: contentitemsDetails55[ij].taxTotal,
  //         consumerSalesForecast:
  //             contentitemsDetails55[ij].consumerSalesForecast,
  //         exciseAmount: contentitemsDetails55[ij].exciseAmount,
  //         taxPerUnit: contentitemsDetails55[ij].taxPerUnit,
  //         totalInclTax: contentitemsDetails55[ij].totalInclTax,
  //         countryOrg: contentitemsDetails55[ij].countryOrg,
  //         sww: contentitemsDetails55[ij].sww,
  //         transactionType: contentitemsDetails55[ij].transactionType == null ||
  //                 contentitemsDetails55[ij].transactionType == "null"
  //             ? null
  //             : contentitemsDetails55[ij].transactionType,
  //         distributeExpense: contentitemsDetails55[ij].distributeExpense,
  //         rowTotalFc: contentitemsDetails55[ij].rowTotalFc,
  //         rowTotalSc: contentitemsDetails55[ij].rowTotalSc,
  //         lastBuyInmPrice: contentitemsDetails55[ij].lastBuyInmPrice,
  //         lastBuyDistributeSumFc:
  //             contentitemsDetails55[ij].lastBuyDistributeSumFc,
  //         lastBuyDistributeSumSc:
  //             contentitemsDetails55[ij].lastBuyDistributeSumSc,
  //         lastBuyDistributeSum: contentitemsDetails55[ij].lastBuyDistributeSum,
  //         stockDistributesumForeign:
  //             contentitemsDetails55[ij].stockDistributesumForeign,
  //         stockDistributesumSystem:
  //             contentitemsDetails55[ij].stockDistributesumSystem,
  //         stockDistributesum: contentitemsDetails55[ij].stockDistributesum,
  //         stockInmPrice: contentitemsDetails55[ij].stockInmPrice,
  //         pickStatusEx: contentitemsDetails55[ij].pickStatusEx,
  //         taxBeforeDpm: contentitemsDetails55[ij].taxBeforeDpm,
  //         taxBeforeDpmfc: contentitemsDetails55[ij].taxBeforeDpmfc,
  //         taxBeforeDpmsc: contentitemsDetails55[ij].taxBeforeDpmsc,
  //         cfopCode: contentitemsDetails55[ij].cfopCode,
  //         cstCode: contentitemsDetails55[ij].cstCode,
  //         usage: contentitemsDetails55[ij].usage,
  //         taxOnly: contentitemsDetails55[ij].taxOnly,
  //         visualOrder: contentitemsDetails55[ij].visualOrder,
  //         baseOpenQuantity: contentitemsDetails55[ij].baseOpenQuantity,
  //         unitPrice: double.parse(contentitemsDetails55[ij].price.toString()),
  //         lineStatus: contentitemsDetails55[ij].lineStatus,
  //         packageQuantity: contentitemsDetails55[ij].packageQuantity,
  //         text: contentitemsDetails55[ij].text,
  //         lineType: contentitemsDetails55[ij].lineType,
  //         cogsCostingCode: contentitemsDetails55[ij].cogsCostingCode,
  //         cogsAccountCode: contentitemsDetails55[ij].cogsAccountCode,
  //         changeAssemlyBoMWarehouse:
  //             contentitemsDetails55[ij].changeAssemlyBoMWarehouse,
  //         grossBuyPrice: contentitemsDetails55[ij].grossBuyPrice,
  //         grossBase: contentitemsDetails55[ij].grossBase,
  //         grossProfitTotalBasePrice:
  //             contentitemsDetails55[ij].grossProfitTotalBasePrice,
  //         costingCode2: contentitemsDetails55[ij].costingCode2,
  //         costingCode3: contentitemsDetails55[ij].costingCode3,
  //         costingCode4: contentitemsDetails55[ij].costingCode5,
  //         costingCode5: contentitemsDetails55[ij].costingCode5,
  //         itemDetails: contentitemsDetails55[ij].itemDetails,
  //         locationCode: contentitemsDetails55[ij].locationCode,
  //         actualDeliveryDate: contentitemsDetails55[ij].actualDeliveryDate,
  //         remainingOpenQuantity: 0,
  //         openAmount: 0,
  //         openAmountFc: 0,
  //         openAmountSc: 0,
  //         exLineNo: contentitemsDetails55[ij].exLineNo,
  //         Date: contentitemsDetails55[ij].Date,
  //         Quantity: contentitemsDetails55[ij].Quantity,
  //         cogsCostingCode2: contentitemsDetails55[ij].cogsCostingCode2,
  //         cogsCostingCode3: contentitemsDetails55[ij].cogsCostingCode3,
  //         cogsCostingCode4: contentitemsDetails55[ij].cogsCostingCode4,
  //         cogsCostingCode5: contentitemsDetails55[ij].cogsCostingCode5,
  //         csTforIpi: contentitemsDetails55[ij].csTforIpi,
  //         csTforPis: contentitemsDetails55[ij].csTforPis,
  //         csTforCofins: contentitemsDetails55[ij].csTforCofins,
  //         creditOriginCode: contentitemsDetails55[ij].creditOriginCode,
  //         withoutInventoryMovement:
  //             contentitemsDetails55[ij].withoutInventoryMovement,
  //         agreementNo: contentitemsDetails55[ij].agreementNo,
  //         agreementRowNumber: contentitemsDetails55[ij].agreementRowNumber,
  //         actualBaseEntry: contentitemsDetails55[ij].actualBaseEntry,
  //         actualBaseLine: contentitemsDetails55[ij].actualBaseLine,
  //         docEntry: contentitemsDetails55[ij].docEntry,
  //         surpluses: contentitemsDetails55[ij].surpluses,
  //         defectAndBreakup: contentitemsDetails55[ij].defectAndBreakup,
  //         shortages: contentitemsDetails55[ij].shortages,
  //         considerQuantity: contentitemsDetails55[ij].considerQuantity,
  //         partialRetirement: contentitemsDetails55[ij].partialRetirement,
  //         retirementQuantity: contentitemsDetails55[ij].retirementQuantity,
  //         retirementApc: contentitemsDetails55[ij].retirementApc,
  //         thirdParty: contentitemsDetails55[ij].thirdParty,
  //         poNum: contentitemsDetails55[ij].poNum,
  //         poItmNum: contentitemsDetails55[ij].poItmNum,
  //         expenseType: contentitemsDetails55[ij].expenseType,
  //         receiptNumber: contentitemsDetails55[ij].receiptNumber,
  //         expenseOperationType: contentitemsDetails55[ij].expenseOperationType,
  //         federalTaxId: contentitemsDetails55[ij].federalTaxId == null ||
  //                 contentitemsDetails55[ij].federalTaxId == "null"
  //             ? null
  //             : getQuotAllValues!.federalTaxId,
  //         //  contentitemsDetails55[ij].federalTaxId,
  //         grossProfit: contentitemsDetails55[ij].grossProfit,
  //         grossProfitFc: contentitemsDetails55[ij].grossProfitFc,
  //         grossProfitSc: contentitemsDetails55[ij].grossProfitSc,
  //         priceSource: contentitemsDetails55[ij].priceSource,
  //         stgSeqNum: contentitemsDetails55[ij].stgSeqNum,
  //         stgEntry: contentitemsDetails55[ij].stgEntry,
  //         stgDesc: contentitemsDetails55[ij].stgDesc,
  //         uoMEntry: contentitemsDetails55[ij].uoMEntry,
  //         uoMCode: contentitemsDetails55[ij].uoMCode,
  //         inventoryQuantity: contentitemsDetails55[ij].inventoryQuantity,
  //         remainingOpenInventoryQuantity:
  //             contentitemsDetails55[ij].remainingOpenInventoryQuantity,
  //         parentLineNum: contentitemsDetails55[ij].parentLineNum == null ||
  //                 contentitemsDetails55[ij].parentLineNum == "null"
  //             ? null
  //             : contentitemsDetails55[ij].parentLineNum,
  //         incoterms: contentitemsDetails55[ij].incoterms,
  //         transportMode: contentitemsDetails55[ij].transportMode,
  //         natureOfTransaction: contentitemsDetails55[ij].natureOfTransaction,
  //         destinationCountryForImport:
  //             contentitemsDetails55[ij].destinationCountryForImport,
  //         destinationRegionForImport:
  //             contentitemsDetails55[ij].destinationRegionForImport,
  //         originCountryForExport:
  //             contentitemsDetails55[ij].originCountryForExport,
  //         originRegionForExport:
  //             contentitemsDetails55[ij].originRegionForExport,
  //         itemType: 'dit_Item',
  //         changeInventoryQuantityIndependently:
  //             contentitemsDetails55[ij].changeInventoryQuantityIndependently,
  //         freeOfChargeBp: contentitemsDetails55[ij].freeOfChargeBp,
  //         sacEntry: contentitemsDetails55[ij].sacEntry,
  //         hsnEntry: contentitemsDetails55[ij].hsnEntry,
  //         grossPrice: contentitemsDetails55[ij].grossPrice,
  //         grossTotal: contentitemsDetails55[ij].grossTotal,
  //         grossTotalFc: contentitemsDetails55[ij].grossTotalFc,
  //         grossTotalSc: contentitemsDetails55[ij].grossTotalSc,
  //         ncmCode: contentitemsDetails55[ij].ncmCode,
  //         nveCode: contentitemsDetails55[ij].nveCode,
  //         indEscala: "tNO",
  //         ctrSealQty: contentitemsDetails55[ij].ctrSealQty,
  //         cnjpMan: contentitemsDetails55[ij].cnjpMan,
  //         cestCode: contentitemsDetails55[ij].cestCode == null
  //             ? null
  //             : contentitemsDetails55[ij].cestCode,
  //         ufFiscalBenefitCode:
  //             contentitemsDetails55[ij].ufFiscalBenefitCode == null
  //                 ? null
  //                 : contentitemsDetails55[ij].ufFiscalBenefitCode,
  //         shipToCode: contentitemsDetails55[ij].shipToCode == null ||
  //                 contentitemsDetails55[ij].shipToCode == "null"
  //             ? null
  //             : contentitemsDetails55[ij].shipToCode,
  //         shipToDescription: contentitemsDetails55[ij].shipToDescription,
  //         externalCalcTaxRate: contentitemsDetails55[ij].externalCalcTaxRate,
  //         externalCalcTaxAmount:
  //             contentitemsDetails55[ij].externalCalcTaxAmount,
  //         externalCalcTaxAmountFc:
  //             contentitemsDetails55[ij].externalCalcTaxAmountFc,
  //         externalCalcTaxAmountSc:
  //             contentitemsDetails55[ij].externalCalcTaxAmountSc,
  //         standardItemIdentification:
  //             contentitemsDetails55[ij].standardItemIdentification,
  //         commodityClassification:
  //             contentitemsDetails55[ij].commodityClassification,
  //         unencumberedReason: contentitemsDetails55[ij].unencumberedReason,
  //         cuSplit: "tNO",
  //         uQtyOrdered: contentitemsDetails55[ij].uQtyOrdered,
  //         uOpenQty: contentitemsDetails55[ij].uOpenQty,
  //         uTonnage: contentitemsDetails55[ij].uTonnage,
  //         uPackSize: contentitemsDetails55[ij].U_Pack_Size,
  //         uProfitCentre: contentitemsDetails55[ij].uProfitCentre,
  //         uNumberDrums: contentitemsDetails55[ij].uNumberDrums,
  //         uDrumSize: contentitemsDetails55[ij].uDrumSize,
  //         uPails: contentitemsDetails55[ij].uPails,
  //         uCartons: contentitemsDetails55[ij].uCartons ?? null,
  //         uLooseTins: contentitemsDetails55[ij].uLooseTins,
  //         uNettWt: contentitemsDetails55[ij].uNettWt,
  //         uGrossWt: contentitemsDetails55[ij].uGrossWt,
  //         uAppLinId: contentitemsDetails55[ij].uAppLinId,
  //         uMuQty: contentitemsDetails55[ij].uMuQty,
  //         uRvc: contentitemsDetails55[ij].uRvc,
  //         uVrn: contentitemsDetails55[ij].uVrn,
  //         uIdentifier: contentitemsDetails55[ij].uIdentifier,
  //       ));
  //     }
  //   }
  //   log("itemsDetailsData::${itemsDetailsData.length}");
  // }
  // //  getQuotAllValues!.documentLines!

  // Future<int?> patchhcheckitem() async {

  //    addDocLine();
  //    notifyListeners();
  // }

  callPatchApi(BuildContext context, ThemeData theme, int docEntry) async {
    final Database db = (await DBHelper.getInstance())!;
    addDocLine();
    var uuid = Uuid();
    String? uuidg = uuid.v1();
    SerlaySalesQuoPatchAPI.cardCodePost = addCardCode;
    SerlaySalesQuoPatchAPI.docLineQout = itemsDocDetails;
    SerlaySalesQuoPatchAPI.docDate = config.currentDate();
    SerlaySalesQuoPatchAPI.dueDate = config.currentDate().toString();
    SerlaySalesQuoPatchAPI.remarks = remarkcontroller3.text;

    SerlaySalesQuoPatchAPI.deviceTransID = uuidg;

    await SerlaySalesQuoPatchAPI.getData(sapDocentry).then((value) async {
      // SalesOrderAfterAPi.baseEntry = value.docEntry.toString();
      //log("object:" + value.statusCode.toString());

      if (value.statusCode == null) {
        return;
      }
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        await updateSalesQuoHeaderToDB(context, theme);
        await DBOperation.UpdtSapDetSalHead(db, int.parse(sapDocentry),
            int.parse(sapDocuNumber), docEntry, 'SalesQuotationHeader');
        await pushRabiMqSO2(int.parse(docEntry.toString()));

        custserieserrormsg = '';
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
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          injectToDb();
          editqty = false;
          OndDisablebutton = false;

          Get.offAllNamed(ConstantRoutes.dashboard);
          notifyListeners();
        });
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        //log("Error22");
        cancelbtn = false;
        custserieserrormsg = value.ErrorMsg!.message!.Value;
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
        OndDisablebutton = false;
      }
    });
    notifyListeners();
  }

  // call api

  postCategory(String value) {
    selectedValue = value;
  }

  // int intval = 0;

  Future<int?> checkSameSerialBatchScnd(String sBatch) async {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].SerialBatch == sBatch) {
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

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
                    contentPadding: EdgeInsets.all(0),
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
                        contentPadding: EdgeInsets.all(0),
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

  refresCufstList() async {
    filtercustList = custList;

    notifyListeners();
  }

  /// customer
  String addCardCode = '';

  custSelected(CustomerDetals customerDetals, BuildContext context,
      ThemeData theme) async {
    addCardCode = '';
    selectedcust = null;
    selectedcust55 = null;
    selectedBillAdress = 0;
    selectedShipAdress = 0;
    loadingscrn = true;
    holddocentry = '';
    double? updateCustBal;
    notifyListeners();
    selectedcust = CustomerDetals(
        name: customerDetals.name,
        //kkkkk
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        // accBalance: customerDetals.accBalance,
        point: customerDetals.point,
        address: [],
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '',
        autoId: customerDetals.autoId);

    selectedcust55 = CustomerDetals(
        autoId: customerDetals.autoId,
        name: customerDetals.name,
        // llll
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
        notifyListeners();
      }
    }
    await AccountBalApi.getData(selectedcust!.cardCode.toString())
        .then((value) {
      loadingscrn = false;
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        print("Account Balance");
        updateCustBal =
            double.parse(value.accBalanceData![0].balance.toString());
        notifyListeners();
      }
    });
    // log( 'YYYYYYYYYYYYYYYY::${selectedcust!.address![selectedBillAdress].autoId}::${selectedcust55!.address![selectedShipAdress].autoId}');
    selectedcust!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    selectedcust55!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    addCardCode = selectedcust!.cardCode.toString();
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
        //log("selectedcust55!.address![i].addresstype::${selectedcust55!.address![i].addresstype.toString()}");

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
          notifyListeners();
        }
        //log("shipadrrssItemlist::${shipadrrssItemlist.length}");
      }

      notifyListeners();
    }
    notifyListeners();
  }

  clearData() {
    holddocentry = '';
    loadingscrn = false;
    selectedcust = null;
    selectedcust55 = null;
    selectedcust2 = null;
    selectedcust25 = null;
    notifyListeners();
  }

  filterList(String v) {
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

  callShipAddressPostApi(BuildContext context) async {
    await sapLoginApi(context);
    log("App constatant fff ::::${AppConstant.sapSessionID}");
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
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertsipCreatenewAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustshipaddresslist(
          context,
        );
        config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        addLoadingBtn = false;

        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        addLoadingBtn = false;
      }
    });
    notifyListeners();
  }

  callBillAddressPostApi(BuildContext context) async {
    await sapLoginApi(context);
    log("App constatant fff ::::${AppConstant.sapSessionID}");
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
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertbillCreatenewAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustBilladdresslist(
          context,
        );
        addLoadingBtn = false;

        config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");

        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        addLoadingBtn = false;

        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        addLoadingBtn = false;
      }
    });
    notifyListeners();
  }

  callAddressPostApi(BuildContext context) async {
    await sapLoginApi(context);
    log("App constatant fff ::::${AppConstant.sapSessionID}");
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

        addLoadingBtn = false;
        config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        addLoadingBtn = false;

        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        addLoadingBtn = false;
      }
    });
    notifyListeners();
  }

  CreateNewBillAdd() async {
    addCardCode = '';
    // final Database db = await dbHelper.createDB();
    final Database db = (await DBHelper.getInstance())!;
    addCardCode = selectedcust!.cardCode.toString();
    log("New Created address CardCode:$addCardCode");

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
        //log("${selectedcust!.address}");
        // }
      }
    }

    notifyListeners();
  }

  insertnewshipaddresscreation(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    addLoadingBtn = true;
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
        addLoadingBtn = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  insertnewbiladdresscreation(BuildContext context, ThemeData theme) async {
    addLoadingBtn = true;
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
        addLoadingBtn = false;
        notifyListeners();
      });
      notifyListeners();
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
    log("(mycontroller[14].text(mycontroller[14].text:::${mycontroller[14].text}");
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

  billToShip(bool dat) async {
    log("GGGGGGGGGGGGGGGGGGGGG");
    shipcreateNewAddress = [];
    notifyListeners();
    if (checkboxx == true) {
      //log("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
      // shipcreateNewAddress.add(CustomerAddressModelDB(
      //   custcode: mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
      //   createdUserID: "1",
      //   createdateTime: config.currentDate(),
      //   lastupdateIp: '1',
      //   updatedDatetime: config.currentDate(),
      //   updateduserid: '1',
      //   address1: mycontroller[14].text.isNotEmpty ? mycontroller[14].text : '',
      //   address2: mycontroller[15].text.isNotEmpty ? mycontroller[15].text : '',
      //   address3: mycontroller[16].text.isNotEmpty ? mycontroller[16].text : '',
      //   city: mycontroller[17].text.isNotEmpty ? mycontroller[17].text : '',
      //   countrycode:
      //       mycontroller[20].text.isNotEmpty ? mycontroller[20].text : '',
      //   geolocation1: '',
      //   geolocation2: '',
      //   statecode:
      //       mycontroller[19].text.isNotEmpty ? mycontroller[19].text : '',
      //   pincode: mycontroller[18].text.isNotEmpty ? mycontroller[18].text : '',
      //   branch: UserValues.branch,
      //   terminal: UserValues.terminal,
      //   addresstype: 'S',
      // ));
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

  shipToBill(bool dat) async {
    final Database db = (await DBHelper.getInstance())!;
    notifyListeners();
    if (checkboxx == true) {
      //log("NNNNNNNNNNNNNNNNNNNNNNNNNNN");
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

  createnewchangescustaddres(
      BuildContext context, ThemeData theme, int ij) async {
    // final Database db = (await DBHelper.getInstance())!;
    await addnewCustomer(context, theme, ij);
    await getCustDetFDB();
    await getNewCustandadd(context);

    notifyListeners();
  }

  // cancelquery() async {
  //   final Database db = (await DBHelper.getInstance())!;

  //   List<Map<String, Object?>> getheaderData =
  //       await DBOperation.salesQuoCancellQuery(db, cancelDocnum);
  //   notifyListeners();
  // }

  addnewCustomer(BuildContext context, ThemeData theme, int ij) async {
    textError = '';
    tinfileError = '';
    vatfileError = '';

    int sucesss = 0;
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
      await callCustPostApi(context);

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
          });
    }
    notifyListeners();
  }

  getNewCustandadd(
    BuildContext context,
  ) async {
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
    // mycontroller[3].text.toString());
    List<Map<String, Object?>> newaddrssdataDB =
        await DBOperation.addgetCstmMasAddDB(
            db, mycontroller[3].text.toString());
    for (int i = 0; i < newcusdataDB.length; i++) {
      //log('step:1');

      // selectedcust = CustomerDetals(
      //     autoId: newcusdataDB[newcusdataDB.length - 1].autoid.toString(),
      //     cardCode: newcusdataDB[newcusdataDB.length - 1].customerCode.toString(),
      //     name: newcusdataDB[newcusdataDB.length - 1].customername.toString(),
      //     phNo: newcusdataDB[newcusdataDB.length - 1].phoneno1.toString(),
      //     accBalance: double.parse(
      //         newcusdataDB[newcusdataDB.length - 1].balance.toString()),
      //     point: newcusdataDB[newcusdataDB.length - 1].points.toString(),
      //     tarNo: newcusdataDB[newcusdataDB.length - 1].taxno.toString(),
      //     email: newcusdataDB[newcusdataDB.length - 1].emalid.toString(),
      //     invoicenum: '',
      //     invoiceDate: '',
      //     totalPayment: 00,
      //     address: []);

      selectedcust = CustomerDetals(
          customerSeriesNo: custseriesNo,
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
    //log('step:1.1');
    if (newaddrssdataDB.isNotEmpty) {
      for (int ik = 0; ik < newaddrssdataDB.length; ik++) {
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
    notifyListeners();
  }

  // String? custautoid;

  insertAddNewCusToDB(
    BuildContext context,
  ) async {
    log("lastUpdateIp::-----${UserValues.lastUpdateIp}");
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    newCustValues = [];
    // custautoid = '';
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
    // List<CustomerModelDB> newcusdataDB = await DBOperation.getCstmMasDB(db);
    // log(" step:21");
    // custautoid = newcusdataDB[newcusdataDB.length - 1].autoid.toString();
    // log("newcusdataDB autoid:::" +
    //     newcusdataDB[newcusdataDB.length - 1].autoid.toString());

    // await DBOperation.updateCustomerDetailstocrdcode(db, cardCodexx,
    //     newcusdataDB[newcusdataDB.length - 1].autoid.toString());
    //   log(" step:3");
    // } else {
    //   await DBOperation.insertCustomer(db, newCustValues);
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
          mycontroller[3].text.isEmpty ? '' : mycontroller[3].text.toString(),
      //  mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
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
          mycontroller[3].text.isEmpty ? '' : mycontroller[3].text.toString(),
      // mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
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
    notifyListeners();
    int newadd = 0;

    if (newBillAddrsValue.isNotEmpty) {
      //log("VVVVVVVVVVVVVVVVV");
      newadd = newadd + 1;
    }
    if (newShipAddrsValue.isNotEmpty) {
      //log("CCCCCCCCCCCCCCCCCCCCCCC");

      newadd = newadd + 1;
    }
    if (newadd == 2) {
      //log("VVVVVVVVVVVVVVVVV");
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
      notifyListeners();
    }
    notifyListeners();
  }

  mapUpdateCustomer(int sInd) async {
    mycontroller[3].text =
        selectedcust!.cardCode != null ? selectedcust!.cardCode! : '';
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
      updateCustomer(context, theme, i, ij);
      Navigator.pop(context);

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
          });
      notifyListeners();
    }
    notifyListeners();
  }

  updateCustomer(BuildContext context, ThemeData theme, int i, int ij) async {
    final Database db = (await DBHelper.getInstance())!;
    String aId = selectedcust!.address![selectedBillAdress].autoId.toString();

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

    selectedcust55!.cardCode = mycontroller[3].text;
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
            db, ij, selectedcust55!, autoid5.toString());
      } else {
        //log('PPPPPPPPPPPPPPPPPPPPPPPPPPP');

        shipcreateNewAddress.add(CustomerAddressModelDB(
          custcode: selectedcust!.cardCode,
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
    print("vvvv::${selectedcust!.autoId}");
    await DBOperation.updateCustomerDetails(
      db,
      selectedcust!.autoId.toString(),
      selectedcust!,
    );
// selectedcust!.cardCode.toString(),
    await DBOperation.updateAddressDetails(
        db, i, selectedcust!, aId.toString());
    await getCustDetFDB();
    await getUpdateCustandadd(context, selectedcust!.cardCode.toString());
    notifyListeners();
  }

  getUpdateCustandadd(BuildContext context, String custcode) async {
    final Database db = (await DBHelper.getInstance())!;
    selectedcust!.address = [];
    selectedcust55!.address = [];

    // mycontroller[3].text = mycontroller[3].text.isNotEmpty
    //     ? mycontroller[3].text.toString()
    //     : '';
    //log("mycontroller[3].text.toString()::${mycontroller[3].text}");
    List<Map<String, Object?>> newcusdataDB =
        await DBOperation.getCstmMasDatabyautoid(
            db, selectedcust!.cardCode.toString());
    // mycontroller[3].text.toString());
    List<Map<String, Object?>> newaddrssdataDB =
        await DBOperation.addgetCstmMasAddDB(
            db, selectedcust!.cardCode.toString());
    for (int i = 0; i < newcusdataDB.length; i++) {
      //log('step:1::::$i');
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
    //log('step:1.1');
    if (newaddrssdataDB.isNotEmpty) {
      for (int ik = 0; ik < newaddrssdataDB.length; ik++) {
        //log('step2:$ik');
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

          //log('step:3');
        }

        if (newaddrssdataDB[ik]['addresstype'].toString() == "S") {
          //log('step3:$ik');

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

          //log('step:3');
        }
      }
    }
    //log("selectedcust!.address!.length:::${selectedcust!.address!.length}");

    // selectedBillAdress = selectedcust!.address!.length - 1;
    // selectedShipAdress = selectedcust55!.address!.length - 1;
    //log("selectedBillAdress55:$selectedBillAdress");
    //log('selectedShipAdress88::$selectedShipAdress');

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
    addLoadingBtn = false;
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
    log("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
    totalPayment = null;
    TotalPayment totalPay = TotalPayment();
    totalPay.total = 0;
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.totalDue = 0.00;
    log("issss length:${scanneditemData.length}");

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      double? mycontlaa = discountcontroller[iss].text.isNotEmpty
          ? double.parse(discountcontroller[iss].text.toString())
          : 0;
      scanneditemData[iss].Qty = int.parse(qtymycontroller[iss].text.isNotEmpty
          ? qtymycontroller[iss].text
          : "0");
      totalPay.total =
          totalPay.total! + int.parse(scanneditemData[iss].Qty.toString());
      //log('  totalPay.total   totalPay.total ::${totalPay.total}');
      notifyListeners();
      if (double.parse(scanneditemData[iss].Maxdiscount!) >= mycontlaa) {
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

        //log("discount Amount:${scanneditemData[iss].discount.toString()}: ${scanneditemData[iss].basic.toString()}:${scanneditemData[iss].discountper!.toString()}");
        scanneditemData[iss].taxable =
            scanneditemData[iss].basic! - scanneditemData[iss].discount!;

        scanneditemData[iss].taxvalue =
            scanneditemData[iss].taxable! * scanneditemData[iss].TaxRate! / 100;

        scanneditemData[iss].netvalue =
            (scanneditemData[iss].basic! - scanneditemData[iss].discount!) +
                scanneditemData[iss].taxvalue!;

        totalPay.subtotal = totalPay.subtotal! + scanneditemData[iss].basic!;
        // totalPay.total = totalPay.total! + scanneditemData[iss].Qty!;
        totalPay.discount = totalPay.discount! + scanneditemData[iss].discount!;
        totalPay.totalTX = totalPay.totalTX! + scanneditemData[iss].taxvalue!;

        totalPay.totalDue = totalPay.totalDue! + scanneditemData[iss].netvalue!;

        notifyListeners();
      } else if (mycontlaa >= 100) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.all(0),
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
                  contentPadding: EdgeInsets.all(0),
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
      FocusScopeNode focus = FocusScope.of(context);
      //log("TaxRate:${scanneditemData[iss].TaxRate}");
      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      totalPayment = totalPay;
    }
    notifyListeners();
  }

  calCulateDocVal2(BuildContext context, ThemeData theme) {
    log("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
    totalPayment2 = null;
    TotalPayment totalPay = TotalPayment();
    totalPay.total = 0;
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.totalDue = 0.00;
    log("issss length:${scanneditemData2.length}");

    for (int iss = 0; iss < scanneditemData2.length; iss++) {
      double? mycontlaa = discountcontroller2[iss].text.isNotEmpty
          ? double.parse(discountcontroller2[iss].text.toString())
          : 0;
      scanneditemData2[iss].Qty = int.parse(
          qtymycontroller2[iss].text.isNotEmpty
              ? qtymycontroller2[iss].text
              : "0");
      totalPay.total =
          totalPay.total! + int.parse(scanneditemData2[iss].Qty.toString());
      notifyListeners();
      if (double.parse(scanneditemData2[iss].Maxdiscount!) >= mycontlaa) {
        String ansbasic =
            (scanneditemData2[iss].SellPrice! * scanneditemData2[iss].Qty!)
                .toString();
        scanneditemData2[iss].basic = double.parse(ansbasic);
        scanneditemData2[iss].discountper =
            discountcontroller2[iss].text.isNotEmpty
                ? double.parse(discountcontroller2[iss].text.toString())
                : 00;
        scanneditemData2[iss].discount = (scanneditemData2[iss].basic! *
            scanneditemData2[iss].discountper! /
            100);
        scanneditemData2[iss].taxable =
            scanneditemData2[iss].basic! - getScanneditemData2[iss].discount!;

        scanneditemData2[iss].taxvalue = scanneditemData2[iss].taxable! *
            scanneditemData2[iss].TaxRate! /
            100;

        scanneditemData2[iss].netvalue =
            (scanneditemData2[iss].basic! - scanneditemData2[iss].discount!) +
                scanneditemData2[iss].taxvalue!;

        totalPay.subtotal = totalPay.subtotal! + scanneditemData2[iss].basic!;
        totalPay.discount =
            totalPay.discount! + scanneditemData2[iss].discount!;
        totalPay.totalTX = totalPay.totalTX! + scanneditemData2[iss].taxvalue!;

        totalPay.totalDue =
            totalPay.totalDue! + scanneditemData2[iss].netvalue!;

        notifyListeners();
      } else if (mycontlaa >= 100) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  content: SizedBox(
                    width: Screens.width(context) * 0.5,
                    height: Screens.bodyheight(context) * 0.15,
                    child: ContentWidgetMob(
                        theme: theme,
                        msg:
                            "Please enter the discount percentage is below 100"),
                  ));
            }).then((value) {
          discountcontroller2[iss].text = '';
          notifyListeners();
        });
      } else {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  content: SizedBox(
                    width: Screens.width(context) * 0.5,
                    height: Screens.bodyheight(context) * 0.15,
                    child: ContentWidgetMob(
                        theme: theme,
                        msg:
                            "Discount is greater than Maximum Discount(${scanneditemData2[iss].Maxdiscount})"),
                  ));
            }).then((value) {
          discountcontroller2[iss].text = '';
          notifyListeners();
        });
      }
      FocusScopeNode focus = FocusScope.of(context);
      //log("TaxRate:${scanneditemData[iss].TaxRate}");
      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      totalPayment2 = totalPay;
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

  // double getNoOfQty() {
  //   var getQty = scanneditemData.map((itemdet) => itemdet.Qty.toString());
  //   var getSum = getQty.map(double.parse).toList();
  //   var totalqty = getSum.reduce((a, b) => a + b);
  //   return totalqty;
  // }

  // double getSumPrice() {
  //   var getprice = scanneditemData.map((itemdet) => itemdet.SellPrice.toString());
  //   var getpriceSum = getprice.map(double.parse).toList();
  //   var toalPrice = getpriceSum.reduce((a, b) => a + b);
  //   return toalPrice;
  // }

  // double getNoSubTotal() {
  //   int totalQty = 0; // getNoOfQty();
  //   double totalPrice = 0; //getSumPrice();
  //   double sumTotal = 0; //(totalQty * totalPrice);

  //   for (int iss = 0; iss < scanneditemData.length; iss++) {
  //     totalPrice = double.parse(scanneditemData[iss].SellPrice.toString());
  //     totalQty = scanneditemData[iss].Qty!;
  //     sumTotal = (sumTotal + (totalQty * totalPrice));
  //   }

  //   return sumTotal;
  // }

  // double getTotalTax() {
  //   //bala sir//=(H10-N10)*I10/100=
  //   int totalQty = 0; // getNoOfQty();
  //   double totalPrice = 0; //getSumPrice();
  //   double tax = 0; //getSumTotalTax();
  //   double totalTax = 0;
  //   double disamt = getDiscount();
  //   for (int iss = 0; iss < scanneditemData.length; iss++) {
  //     totalPrice = double.parse(scanneditemData[iss].SellPrice.toString());
  //     totalQty = scanneditemData[iss].Qty!;
  //     tax = double.parse(scanneditemData[iss].TaxRate.toString());

  //     var basic = (totalQty * totalPrice);

  //     var taxable = basic - disamt;
  //     scanneditemData[iss].TaxType = (taxable * tax / 100).toString();
  //   }

  //   return totalTax;
  // }

  // double getDiscount() {
  //   double totaldisc = 0;
  //   int totalQty = 0; // getNoOfQty();
  //   double totalPrice = 0; //getSumPrice();
  //   double itemdisc = 0; //getSumTotalTax();

  //   for (int iss = 0; iss < scanneditemData.length; iss++) {
  //     totalPrice = double.parse(scanneditemData[iss].SellPrice.toString());
  //     totalQty = scanneditemData[iss].Qty!;
  //     itemdisc = double.parse(scanneditemData[iss].Maxdiscount.toString());

  //     var basic = totalQty * totalPrice;
  //     scanneditemData[iss].Cost = int.parse((basic * itemdisc / 100).toString());

  //     //log("totaldisc:" + scanneditemData[iss].Cost.toString());
  //   }
  //   return totaldisc;
  // }

  /// pay ment way

  nullErrorMsg() {
    msgforAmount = null;
    discount = null;
    clearTextField();
    notifyListeners();
  }

  // addToPaymentWay(
  //   PaymentWay paymt,
  //   BuildContext context,
  // ) {
  //   paymentWay.add(PaymentWay(
  //       amt: paymt.amt!,
  //       dateTime: paymt.dateTime,
  //       reference: paymt.reference ?? '',
  //       type: paymt.type,
  //       cardApprno: paymt.cardApprno,
  //       cardref: paymt.cardref,
  //       cardterminal: paymt.cardterminal,
  //       chequedate: paymt.chequedate,
  //       chequeno: paymt.chequeno,
  //       // couponcode: paymt.couponcode,
  //       // coupontype: paymt.coupontype,
  //       discountcode: paymt.discountcode,
  //       discounttype: paymt.discounttype,
  //       // creditref: paymt.creditref,
  //       recoverydate: paymt.recoverydate,
  //       redeempoint: paymt.redeempoint,
  //       availablept: paymt.availablept,
  //       remarks: paymt.remarks,
  //       // transref: paymt.transref,
  //       transtype: paymt.transtype,
  //       walletid: paymt.walletid,
  //       // walletref: paymt.walletref,
  //       wallettype: paymt.wallettype));

  //   Navigator.pop(context);
  //   notifyListeners();
  // }

  clearTextField() {
    addLoadingBtn = false;
    custseriesNo = null;
    teriteriValue = null;
    paygrpValue = null;
    codeValue = null;
    filedata.clear();
    tinFiles = null;
    vatfileError = '';
    tinfileError = '';
    vatFiles = null;
    loadingBtn = false;
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
    // mycontroller[24].clear();
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
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    billcreateNewAddress = [];
    shipcreateNewAddress = [];
    checkboxx = false;
    notifyListeners();
  }

//checkout
  changecheckout(BuildContext context, ThemeData theme) async {
    // if (schemebtnclk == true) {
    log('GGGGGGGGGGGGGGGGGGG');
    await scehmeapiforckout(context, theme);
    // }
    checkOut(context, theme);
    notifyListeners();
  }

  validateUpdate(BuildContext context, ThemeData theme) {
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
                    content: 'Please Choose a Dcoument..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        OndDisablebutton = false;
        notifyListeners();
      });
    } else {
      updatechangecheckout(context, theme);
      notifyListeners();
    }
    notifyListeners();
  }

  updatechangecheckout(BuildContext context, ThemeData theme) async {
    if (sapSsalesQuoline.isNotEmpty) {
      for (int ij = 0; ij < sapSsalesQuoline.length; ij++) {
        if (sapSsalesQuoline[ij].lineStatus == "bost_Open") {
          await scehmeapiforckout(context, theme);
          await callPatchApi(
              context, theme, int.parse(cancelDocEntry.toString()));

          // await updateSalesQuoHeaderToDB(context, theme);

          notifyListeners();
        } else if (sapSsalesQuoline[ij].lineStatus == "bost_Close") {
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
            OndDisablebutton = false;
            notifyListeners();
          });
        }
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
                    content: 'Something went wrong..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        OndDisablebutton = false;
        notifyListeners();
      });
    }
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
                contentPadding: EdgeInsets.all(0),
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
                contentPadding: EdgeInsets.all(0),
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
    } else {
      await saveValuesTODB("check out", context, theme);
      if (holddocentry.isNotEmpty) {
        //log('holddocentryholddocentry:$holddocentry');
        await DBOperation.deleteHoldSalesQuoMaped(db, holddocentry)
            .then((value) {
          holddocentry = '';
          holdData.clear();
          getdraftindex();
          //log('datatatatatatata deleleleleleelle ');
        });
      }
    }
    notifyListeners();
  }

  scehmeapiforckout(BuildContext context, ThemeData theme) async {
    await salesOrderSchemeData();
    await callSchemeOrderAPi();
    await calculatescheme(context, theme);
    notifyListeners();
  }

  Future<int?> checkCredit(String typpe) {
    for (int i = 0; i < paymentWay.length; i++) {
      if (paymentWay[i].type == typpe) {
        //log('Serial batch:$typpe');
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  // removeEmptyList() {
  //   for (int i = 0; i < scanneditemData.length; i++) {
  //     if (qtymycontroller[i].text.isEmpty) {
  //       scanneditemData.removeAt(i);
  //       setvalues();
  // //log(scanneditemData[i].Qty.toString());
  //       break;
  //       // qtyCont[i].text=scanneditemData[i-1].Qty.toString();
  //     }else{
  //       scanneditemData[i].Qty=int.parse(qtymycontroller[i].text.toString());
  //     }
  //   }
  // }
  removeEmptyList(BuildContext context) {
    List<int>? removeI = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      if (qtymycontroller[i].text.isEmpty) {
        // removeI.add(i);
        qtymycontroller.removeAt(i);
        scanneditemData.removeAt(i);
        //log(scanneditemData[i].Qty.toString());
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
      //  log(scanneditemData[i].Qty.toString());
      //   break;
      qtymycontroller[i].text = scanneditemData[i].Qty.toString();
      // }else{
      //   scanneditemData[i].Qty=int.parse(qtyCont[i].text.toString());
      // }
    }
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
                contentPadding: EdgeInsets.all(0),
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
        await DBOperation.deleteHoldSalesQuoMaped(db, holddocentry)
            .then((value) {
          holddocentry = '';
          holdData.clear();
          getdraftindex();
          //log('datatatatatatata deleleleleleelle ');
        });
      }
      injectToDb();
      notifyListeners();
    }
    OndDisablebutton = false;
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
      //log(datetype);
    } else {
      //log("Date is not selected");
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
      //log(datetype);
    } else {
      //log("Date is not selected");
    }
  }

  String? discount;
  clearAllData(BuildContext context, ThemeData theme) {
    addCardCode = '';
    itemsDocDetails = [];
    searchcon.text = '';
    selectedcust55 = null;
    schemebtnclk = false;
    editqty = false;
    cancelbtn = false;
    filedata.clear();
    scanneditemData2 = [];
    remarkcontroller3.text = '';
    catchmsg = [];
    custseriesNo = null;
    schemeData = [];
    resSchemeDataList = [];
    pref = SharedPreferences.getInstance();
    loadingscrn = false;
    sapDocentry = '';
    sapDocuNumber = '';
    formkey = List.generate(100, (i) => GlobalKey<FormState>());
    focusnode = List.generate(100, (i) => FocusNode());
    mycontroller = List.generate(150, (i) => TextEditingController());
    mycontroller2 = List.generate(150, (i) => TextEditingController());
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    qtymycontroller2 = List.generate(100, (ij) => TextEditingController());
    discountcontroller = List.generate(100, (ij) => TextEditingController());
    searchcontroller = TextEditingController();
    selectedcust = null;
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
    // itemcodelistitem.clear();
    onHoldFilter!.clear();
    onHold.clear();
    // documententryno = null;
    totquantity = null;
    discountamt = null;
    totquantity = null;
    discountamt = null;
    salesmodl.clear();
    newCustValues.clear();
    newBillAddrsValue.clear();
    newShipAddrsValue.clear();
    clearTextField();
    clearCustomer();
    clearAddress();
    addLoadingBtn = false;
    itemData.clear();
    selectedShipAdress = 0;
    selectedBillAdress = 0;
    notifyListeners();
  }

  viewdetails() async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.deleteQuotHold(db);
    log("delete tab");
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
    //log("objectobjectobjectAAAAAAAA:: selectedcust addrexss lenght:${selectedcust!.address!.length}");
    //log("objectobjectobjectBBBB:: selectedcust55 addrexss lenght:${selectedcust55!.address!.length}");
    await DBOperation.getdata(db);
    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust!.cardCode!);

    log("MMMMMMMMM:::${csadresdataDB.length}");
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

    await DBOperation.getdata(db);

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust55!.cardCode!);

    log("MMMMMMMMM55:::${selectedcust55!.cardCode}");
    log("textErrortextErrortextErrortextErrortextError::${csadresdataDB.length}");
    //log("objectobjectCCCCCCCCC:: selectedcust addrexss lenght:${selectedcust!.address!.length}");
    //log("objectobjectDDDDDDDD:: selectedcust55 addrexss lenght:${selectedcust55!.address!.length}");
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
    log("selectedcust55!.address!.lengthRRR:::${selectedcust55!.address!.length}");
    //log("selectedShipAdress ss::$selectedShipAdress");
    //log(" selectedcust55!.address!.lengthEEEEEEE::${selectedcust55!.address!.length}");
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
    log(address2.length.toString());
  }

  //
  mapCallSalesQuotForPDF(preff, BuildContext context, ThemeData theme) async {
    log("FFFFFFFF::${salesmodl.length}");
    List<InvoiceItem> itemsList = [];
    invoice = null;
    for (int ih = 0; ih < salesmodl.length; ih++) {
      //log(salesmodl[ih].cardCode.toString());
      addressxx(ih);
      for (int i = 0; i < salesmodl[ih].item!.length; i++) {
        itemsList.add(InvoiceItem(
          slNo: '${i + 1}',
          //
          descripton: salesmodl[ih].item![i].ItemName,
          // netTotal: salesmodl[ih].item![i].netvalue,
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
    PDFQuoApi.exclTxTotal = 0;
    PDFQuoApi.vatTx = 0;
    PDFQuoApi.inclTxTotal = 0;
    if (invoice != null) {
      for (int i = 0; i < invoice!.items!.length; i++) {
        invoice!.items![i].basic =
            (invoice!.items![i].quantity!) * (invoice!.items![i].unitPrice!);
        invoice!.items![i].discountamt =
            (invoice!.items![i].basic! * invoice!.items![i].dics! / 100);
        // double netvalue
        invoice!.items![i].netTotal =
            (invoice!.items![i].basic!) - (invoice!.items![i].discountamt!);
        PDFQuoApi.exclTxTotal =
            (PDFQuoApi.exclTxTotal) + (invoice!.items![i].netTotal!);
        PDFQuoApi.vatTx =
            (PDFQuoApi.vatTx) + double.parse(invoice!.items![i].vat.toString());
        PDFQuoApi.inclTxTotal =
            double.parse(invoice!.items![i].unitPrice.toString()) +
                double.parse(invoice!.items![i].vat.toString());
        PDFQuoApi.pdfSubtotal = invoice!.items![i].unitPrice!;
        notifyListeners();
      }
      PDFQuoApi.inclTxTotal = (PDFQuoApi.exclTxTotal) + (PDFQuoApi.vatTx);
      //log("invoice.items:::${invoice!.items!.length}");
      int length = invoice!.items!.length;
      if (length > 0) {
        // PDFQuoApi.height = length + 19;
        notifyListeners();
      }
      PDFQuoApi.iinvoicee = invoice;
      printingdoc(context, theme);
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
                    content: 'Please Choose the Document..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
    notifyListeners();
  }

  printingdoc(BuildContext context, ThemeData theme) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PDFQuoApi()));
    notifyListeners();
  }

  checkstocksetqty() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.checkqty(db, '');
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
    log(e);
    Get.showSnackbar(GetSnackBar(
      duration: Duration(seconds: 3),
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
      //log("datata1111");
      print(e);
      showSnackBars("$e", Colors.red);
    }
    return 'null';
  }

  createDBFile(String path) async {
    try {
      String getPath = "$path/PosDBV2.db";
      //log(getPath);
      await source1!.copy(getPath);
      showSnackBars("Created!!...", Colors.green);
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
  }
}

class FilesData {
  String fileBytes;
  String fileName;

  FilesData({required this.fileBytes, required this.fileName});

  // Map<String, Object?> toMap() => {
  //       PostFilesModel.fileBytes: fileBytes,
  //       PostFilesModel.fileName: fileName,
  //     };
}
