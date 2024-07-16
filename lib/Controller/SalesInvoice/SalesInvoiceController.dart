// ignore_for_file: unused_local_variable, unnecessary_null_comparison, dead_code

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posproject/Controller/SalesQuotationController/SalesQuotationController.dart';
import 'package:posproject/Models/Service%20Model/GroupCustModel.dart';
import 'package:posproject/Models/Service%20Model/PamentGroupModel.dart';
import 'package:posproject/Models/Service%20Model/TeriTeriModel.dart';
import 'package:posproject/Pages/PrintPDF/PDFInVoiceApi.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:posproject/Service/NewCustCodeCreate/CreatecustPostApi%20copy.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerGropApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerSeriesApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/FileUploadApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/PaymentGroupApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/TeritoryApi.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/ConstantRoutes.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:posproject/DB Helper/DBhelper.dart';
import 'package:posproject/DBModel/SalesHeader.dart';
import 'package:posproject/DBModel/SalesLineDBModel.dart';
import 'package:posproject/DBModel/SalesPay.dart';
import 'package:posproject/Models/DataModel/SalesOrderModel.dart';
import 'package:posproject/Service/AccountBalanceAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../DB Helper/DBOperation.dart';
import "package:dart_amqp/dart_amqp.dart";
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/StockSnap.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/ItemCode/Itemcodelist.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import '../../Models/SchemeOrderModel/SchemeOrderModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/SeriesModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';
import '../../Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
import '../../Models/ServiceLayerModel/ReceiptModel/PostReceiptLineMode.dart';
import '../../Models/ServiceLayerModel/SAPInwardModel/InwardPostList.dart';
import '../../Models/ServiceLayerModel/SapInvoiceModel/InvPostingLineModel.dart';
import '../../Models/ServiceLayerModel/SapInvoiceModel/Sapinvoicesmodel.dart';
import '../../Pages/Sales Screen/Screens/MobileScreenSales/WidgetsMob/ContentcontainerMob.dart';
import '../../Service/NewCustCodeCreate/NewAddCreatePatchApi.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/PostInvoiceAPI.dart';
import '../../ServiceLayerAPIss/Paymentreceipt/PostpaymentDataAPI.dart';
import '../../Widgets/AlertBox.dart';
import '../../Service/SchemeOrderApi.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/GetInvoicerAPI.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/InvoiceCancelAPI.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/InvoiceLoginnAPI.dart';
import '../../Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';

import '../PaymentReceiptController/PayReceiptController.dart';

class PosController extends ChangeNotifier {
  Configure config = Configure();
  final GlobalKey<ScaffoldState> scaffoldKeyy = GlobalKey<ScaffoldState>();
  List<GlobalKey<FormState>> formkeyy =
      List.generate(100, (i) => GlobalKey<FormState>());

  GlobalKey<FormState> formkeyAdd = GlobalKey<FormState>();
  GlobalKey<FormState> formkeyShipAdd = GlobalKey<FormState>();

  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());

  List<TextEditingController> qtymycontroller =
      List.generate(100, (ij) => TextEditingController());

  List<TextEditingController> discountcontroller =
      List.generate(100, (ij) => TextEditingController());

  List<StocksnapModelData> itemData = [];
  List<StocksnapModelData> get getitemData => itemData;

  List<StocksnapModelData> scanneditemData = [];
  List<StocksnapModelData> get getScanneditemData => scanneditemData;
  List<StocksnapModelData> scanneditemData2 = [];
  List<StocksnapModelData> get getScanneditemData2 => scanneditemData2;

  List<TextEditingController> mycontroller2 =
      List.generate(150, (i) => TextEditingController());

  TextEditingController remarkcontroller3 = TextEditingController();

  TextEditingController searchcontroller = TextEditingController();
  List<TextEditingController> qtymycontroller2 =
      List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> soqtycontroller =
      List.generate(100, (ij) => TextEditingController());
  List<CustomerAddressModelDB> newBillAddrsValue = [];
  List<CustomerAddressModelDB> newShipAddrsValue = [];
  List<CustomerAddressModelDB> billcreateNewAddress = [];
  List<CustomerAddressModelDB> shipcreateNewAddress = [];
  List<searchModel> searchData = [];
  List<FocusNode> focusnode = List.generate(100, (i) => FocusNode());

  double soTotal = 0;
  String cpyfrmso = '';
  List<ItemCodeListModel> itemcodelistitem = [];
  List<ItemCodeListModel> soitemcodelistitem = [];
  List<ItemCodeListModel> soitemcodelistitem55 = [];
  List<StocksnapModelData> soScanItem = [];

  List<ItemCodeListModel> itemcodelistitem55 = [];

  ItemCodeListModel? itemcodeitem;
  List<StocksnapModelData> soData = [];
  List<StocksnapModelData> get getsoData => soData;
  List<SalesModel> salesmodl = [];
  List<SalesModel> soSalesmodl = [];
  List<SalesModel> onHold = [];
  List<SalesModel> onHoldFilter = [];
  String? totquantity;
  double? discountamt;
  List<searchModel> filtersearchData = [];
  CustomerDetals? selectedcust2;
  CustomerDetals? get getselectedcust2 => selectedcust2;
  CustomerDetals? selectedcust25;
  CustomerDetals? get getselectedcust25 => selectedcust25;
  TotalPayment? totalPayment2;
  TotalPayment? get gettotalPayment2 => totalPayment2;
  List<PaymentWay> paymentWay = [];
  List<PaymentWay> get getpaymentWay => paymentWay;
  List<PaymentWay> paymentWay2 = [];
  List<PaymentWay> get getpaymentWay2 => paymentWay2;
  bool OndDisablebutton = false;
  bool schemebtnclk = false;
  bool searchbool = false;
  bool searchmapbool = false;
  List<CustomerDetals> custList2 = [];
  TotalPayment? totalPayment;
  TotalPayment? get gettotalPayment => totalPayment;
  String holddocentry = '';

  String? msgforAmount;
  String? get getmsgforAmount => msgforAmount;

  String? shipaddress = "";
  double? totwieght = 0.0;
  double? totLiter = 0.0;
  List<Address> billadrrssItemlist = [];
  List<Address> shipadrrssItemlist = [];
  List<Address> billadrrssItemlist5 = [];
  List<Address> shipadrrssItemlist5 = [];
  List<String> catchmsg = [];
  List<SalesOrderScheme> schemeData = [];
  List<SchemeOrderModalData> resSchemeDataList = [];
  bool valuefirst = false;

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  bool cancelbtn = false;

  String? custseriesNo;
  // String? mapcustseriesNo;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  List<ErrorModel> sererrorlist = [];
  List<SeriesModelData> seriesData = [];
  bool? fileValidation = false;
  File? tinFiles;
  File? vatFiles;
  String? teriteriValue;
  String? codeValue;
  String? paygrpValue;
  FilePickerResult? result;
  List<FilesData> filedata = [];
  bool loadingBtn = false;
  String? sapDocentry = '';
  String sapDocuNumber = '';
  String? sapReceiptDocentry = '';
  String cancelDocnum = '';

  List<GroupCustData> groupcData = [];
  List<GetTeriteriData> teriteritData = [];
  List<GetPayGrpData>? paygroupData = [];
  String? custerrormsg = '';
  bool groCustLoad = false;
  List<InvoiceDocumentLine> sapInvocieModelData = [];

  String exception = '';
  bool loading = false;

  String vatfileError = '';
  String tinfileError = '';
//dropdown
  String? selectedValue;
  String? get getselectedValue => selectedValue;

  /// customer
  List<CustomerDetals> custList = [];
  List<CustomerDetals> filtercustList = [];
  List<CustomerDetals> get getfiltercustList => filtercustList;

  int selectedCustomer = 0;
  int get getselectedCustomer => selectedCustomer;
  // cus functions

  CustomerDetals? selectedcust;
  CustomerDetals? get getselectedcust => selectedcust;
  CustomerDetals? selectedcust55;
  CustomerDetals? get getselectedcust55 => selectedcust55;
  bool checkboxx = false;
  int selectedBillAdress = 0;
  int? get getselectedBillAdress => selectedBillAdress;

  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;
  String? autoidddd;
  int? selectIndex;

  List<CustomerAddressModelDB> createNewAddress = [];
  List<CustomerModelDB> newCustValues = [];
  List<CustomerAddressModelDB> newAddrsValue = [];
  String textError = '';
  init(BuildContext context, ThemeData theme) {
    clearAllData(context, theme);
    injectToDb();
    getdraftindex();
    getCustSeriesApi();
    // updateStkSnaptab(1000000);
  }

  injectToDb() async {
    getCustDetFDB();
    notifyListeners();
  }

  getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getSalesHeadHoldvalueDB(db);
    for (int i = 0; i < getDBholddata5.length; i++) {
      getdraft(i);
      // log("getDBholddata5 doc entry:${getDBholddata5[i]['docentry']}");
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
// bool searchError=false;

  getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getSalesHeaderDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();
    filtersearchData.clear();
    for (int i = 0; i < getSalesHeader.length; i++) {
      searchdata2.add(searchModel(
          username: UserValues.username,
          terminal: AppConstant.terminal,
          type: getSalesHeader[i]["docstatus"] == null
              ? ""
              : getSalesHeader[i]["docstatus"].toString() == "2"
                  ? "Order"
                  : getSalesHeader[i]["docstatus"].toString() == "3"
                      ? "Invoice"
                      : "",
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
    // log("header::" + getSalesHeader.toString());
    // log("Line::" + getSalesLine.toString());
    // log("Pay::" + getSalesPay.toString());
    searchbool = false;
    notifyListeners();
  }

  fixDataMethod(int docentry) async {
    searchmapbool = false;
    totwieght = 0.0;
    totLiter = 0.0;
    shipaddress = "";
    paymentWay2.clear();
    scanneditemData2.clear();
    totalPayment2 = null;
    selectedcust2 = null;
    sapDocentry = '';
    cancelDocnum = '';
    salesmodl = [];
    sapDocuNumber = '';
    //background service
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getHoldSalesPayDB(db, docentry);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.holdSalesLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(db, docentry);

    List<PaymentWay> payment = [];
    int? totalQuantity = 0;

    sapDocentry = getDBSalesHeader[0]['sapDocentry'] != null
        ? getDBSalesHeader[0]['sapDocentry'].toString()
        : "";
    sapDocuNumber = getDBSalesHeader[0]['sapDocNo'] != null
        ? getDBSalesHeader[0]['sapDocNo'].toString()
        : "";
    cancelDocnum = getDBSalesHeader[0]['documentno'] != null
        ? getDBSalesHeader[0]['documentno'].toString()
        : "";
    for (int kk = 0; kk < getDBSalespay.length; kk++) {
      // log("getDBholdSalespay.length:${getDBSalespay.length}");
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
          // creditref: getDBholdSalespay[kk]['creditref'].toString(),
          recoverydate: getDBSalespay[kk]['recoverydate'].toString(),
          redeempoint: getDBSalespay[kk]['redeempoint'].toString(),
          availablept: getDBSalespay[kk]['availablept'].toString(),
          remarks: getDBSalespay[kk]['remarks'].toString(),
          // transref: getDBholdSalespay[kk]['transref'].toString(),
          transtype: getDBSalespay[kk]['transtype'].toString(),
          walletid: getDBSalespay[kk]['walletid'].toString(),
          // walletref: getDBholdSalespay[kk]['walletref'].toString(),
          wallettype: getDBSalespay[kk]['wallettype'].toString(),
        ));
        paymentWay2 = payment;
      }
      notifyListeners();
    }
    totwieght = double.parse(getDBSalesHeader[0]["totalweight"].toString());
    totLiter = double.parse(getDBSalesHeader[0]["totalltr"].toString());

    // remarkcontroller3.text = getDBSalesHeader[0]['remarks'].toString();
    mycontroller2[50].text = getDBSalesHeader[0]['remarks'] != null
        ? getDBSalesHeader[0]['remarks'].toString()
        : "";

    for (int ik = 0; ik < getDBSalesLine.length; ik++) {
      // log("getDBholdSalesLine.length:${getDBSalesLine.length}");

      print(
          "${getDBSalesHeader[0]['docentry'].toString()}::${getDBSalesLine[ik]['docentry']}");
      scanneditemData2.add(StocksnapModelData(
          pails: getDBSalesLine[ik]['pails'] != null
              ? int.parse(getDBSalesLine[ik]['pails'].toString())
              : 00,
          cartons: getDBSalesLine[ik]['cartons'] != null
              ? int.parse(getDBSalesLine[ik]['cartons'].toString())
              : 00,
          looseTins: getDBSalesLine[ik]['looseTins'] != null
              ? double.parse(getDBSalesLine[ik]['looseTins'].toString())
              : 00,
          tonnage: getDBSalesLine[ik]['tonnage'] != null
              ? double.parse(getDBSalesLine[ik]['tonnage'].toString())
              : 00,
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
          // uTINSPERBOX: int.parse(getDBSalesLine[ik]['UTINSPERBOX'].toString()),
          // uPackSize: double.parse(getDBSalesLine[ik]['UPackSize'].toString()),
          // uSpecificGravity: double.parse(getDBSalesLine[ik]['USpecificGravity'].toString()),
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

      qtymycontroller2[ik].text = getDBSalesLine[ik]['quantity'] == null
          ? "0"
          : getDBSalesLine[ik]['quantity'].toString();

      mycontroller2[ik].text = getDBSalesLine[ik]['discperc'] == null
          ? "0"
          : getDBSalesLine[ik]['discperc'].toString();
      discountamt = getDBSalesLine[ik]['discperc'] != null
          ? double.parse(getDBSalesLine[ik]['discperc'].toString())
          : 0;
      notifyListeners();
    }
    for (int i = 0; i < scanneditemData2.length; i++) {
      // scanneditemData2[i].Qty=int.parse(qtymycontroller2[i].text.toString());
      // log("controller2" + qtymycontroller2[i].text.toString());
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
          notifyListeners();
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
            notifyListeners();
          }
        }
      }
    }
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
    // log(salesmodl.length.toString());
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
    notifyListeners();

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
//log("selectedcust25!.address!length::${selectedcust25!.address!.length}");

    notifyListeners();

    searchmapbool = false;
    notifyListeners();
  }

  saveValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      // log("33333333333");

      insertSalesHeaderToDB(docstatus, context, theme);
    } else if (docstatus.toLowerCase() == "save as order") {
      insertSalesHeaderToDB(docstatus, context, theme);
    } else if (docstatus.toLowerCase() == "check out") {
      insertSalesHeaderToDB(docstatus, context, theme);
    }
    // else if (docstatus.toLowerCase() == "suspend") {
    //   print('IIIIIIII');
    //   print(docstatus.toString());
    //   insertSalesHeaderToDB(docstatus, context, theme);
    // }
    notifyListeners();
  }

  updateStkSnaptab(int docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(db, docentry);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.holdSalesLineDB(
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

          int stksnpqty =
              int.parse(serialbatchCheck[ij]['quantity'].toString()) -
                  int.parse(getDBSalesLine[i]['quantity'].toString());
          stkSnpValues.add(StockSnapTModelDB(
            uPackSize: serialbatchCheck[ij]['uPackSize'].toString(),
            uTINSPERBOX: serialbatchCheck[ij]['uTINSPERBOX'] != null
                ? int.parse(serialbatchCheck[ij]['uTINSPERBOX'].toString())
                : 0,
            uSpecificGravity:
                serialbatchCheck[ij]['uSpecificGravity'].toString(),
            uPackSizeuom: serialbatchCheck[ij]['UPackSizeUom'].toString(),
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

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

//log("datattata doc : ${data.substring(8)}");
    return listdata; // int.parse(data.substring(8));
  }

  insertSalesHeaderToDB(
      String docstatus, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<SalesHeaderTModelDB> salesHeaderValues1 = [];
    List<SalesPayTDB> SalesPayValues = [];
    List<SalesLineTDB> salesLineValues = [];

    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "SalesHeader");
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
          await DBOperation.generateDocentr(db, "docentry", "SalesHeader");
    }
    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 2);
    List<String> getseriesvalue = await checkingdoc(2);
    int docseries = int.parse(getseriesvalue[1]);
    int nextno = documentN0!;
    documentN0 = docseries + documentN0;
    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);
    documentNum = finlDocnum + documentN0.toString();
    salesHeaderValues1.add(SalesHeaderTModelDB(
        doctype: 'Sales Invoice',
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
            ? ""
            : selectedcust!.address![selectedBillAdress].autoId.toString()
        // ? " ${selectedcust!.address![selectedBillAdress].address1.toString()},${selectedcust!.address![selectedBillAdress].address2.toString()}, ${selectedcust!.address![selectedBillAdress].address3.toString()}"
        ,
        billtype: null,
        branch: UserValues.branch!,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        createdbyuser: UserValues.userType,
        customercode: selectedcust!.cardCode != null
            ? selectedcust!.cardCode.toString()
            : '',
        // selectedcust!.cardCode == selectedcust!.autoId
        //     ? ""
        //     : selectedcust!.cardCode.toString(),
        customerSeriesNum: '',
        customername: selectedcust != null ? selectedcust!.name : "",
        customertype: UserValues.userType,
        docbasic: totalPayment != null
            ? totalPayment!.subtotal!.toString().replaceAll(',', '')
            : null,
        docdiscamt: totalPayment != null
            ? totalPayment!.discount!.toString().replaceAll(',', '')
            : null,
        docdiscuntpercen: discountcontroller[i].text.isNotEmpty
            ? discountcontroller[i].text.toString()
            : '0',
        documentno: (documentNum).toString(),
        docstatus: docstatus == "suspend"
            ? "0"
            : docstatus == "hold"
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
        shipaddresid: selectedcust55!.address!.isNotEmpty
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
        customeremail: selectedcust!.email ?? '',
        customerphono: selectedcust!.phNo ?? '',
        customerpoint: selectedcust != null ? selectedcust!.point : '',
        city: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].billCity,
        gst: selectedcust!.tarNo ?? '',
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
        basedocentry:
            selectedcust!.docentry != null ? selectedcust!.docentry.toString() : ''));
    int? docentry2 = await DBOperation.insertSaleheader(db, salesHeaderValues1);

    await DBOperation.updatenextno(db, 2, nextno);

    for (int i = 0; i < scanneditemData.length; i++) {
      double? mycontamount = mycontroller[i].text.toString().isNotEmpty
          ? double.parse(mycontroller[i].text.toString())
          : 00;
      salesLineValues.add(SalesLineTDB(
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
        docentry: docentry2.toString(),
        itemcode: scanneditemData[i].ItemCode,
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        lineID: i.toString(),
        linetotal: scanneditemData[i].basic.toString(),
        netlinetotal: scanneditemData[i].netvalue!.toStringAsFixed(0),
        price: scanneditemData[i].SellPrice.toString(),
        quantity: scanneditemData[i].Qty.toString(),
        serialbatch: scanneditemData[i].SerialBatch,
        taxrate: scanneditemData[i].TaxRate.toString(),
        taxtotal: scanneditemData[i].taxvalue!.toStringAsFixed(2),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        terminal: UserValues.terminal,
        itemname: scanneditemData[i].ItemName,
        basedocentry: scanneditemData[i].basedocentry,
        baselineID: scanneditemData[i].baselineid,
        pails: scanneditemData[i].pails,
        cartons: scanneditemData[i].cartons,
        looseTins: scanneditemData[i].looseTins != null
            ? double.parse(scanneditemData[i].looseTins!.toString())
            : 0,
        tonnage: scanneditemData[i].tonnage != null
            ? double.parse(scanneditemData[i].tonnage.toString())
            : 0,
        totalPack: scanneditemData[i].totalPack != null
            ? double.parse(scanneditemData[i].totalPack.toString())
            : 0,
      ));

      notifyListeners();
    }
    for (int ij = 0; ij < getpaymentWay.length; ij++) {
      SalesPayValues.add(SalesPayTDB(
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
      await DBOperation.insertSalesPay(db, SalesPayValues, docentry2!);
      notifyListeners();
    }
    if (salesLineValues.isNotEmpty) {
      await DBOperation.insertSalesLine(db, salesLineValues, docentry2!);
      notifyListeners();
    }

    if (docstatus == "hold") {
      await getdraftindex();
      mycontroller = List.generate(150, (i) => TextEditingController());
      qtymycontroller = List.generate(150, (i) => TextEditingController());
      discountcontroller = List.generate(100, (i) => TextEditingController());
      selectedcust = null;
      schemebtnclk = false;
      paymentWay.clear();
      totalPayment = null;
      cpyfrmso = '';
      newAddrsValue = [];
      newCustValues = [];
      remarkcontroller3.text = "";
      scanneditemData.clear();
      cashpayment = null;
      cashpayment = null;
      cqpayment = null;
      transpayment = null;
      chqnum = null;
      transrefff = null;
      injectToDb();
      notifyListeners();
      await Get.defaultDialog(
              title: "Success",
              middleText: docstatus == "check out"
                  ? 'Successfully Done, Document Number is $documentNum'
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
        OndDisablebutton = false;
        notifyListeners();
      });
    }
    bool? netbool = await config.haveInterNet();

//log("config.haveInterNet():::$netbool");

    if (netbool == true) {
      if (docstatus == "check out") {
        callInvoicePostApi(context, theme, docentry2!, docstatus, documentNum);
        notifyListeners();
        // await pushRabitmqSales(docentry2!);
      }
    }

    // mycontroller = List.generate(150, (i) => TextEditingController());
    // qtymycontroller = List.generate(150, (i) => TextEditingController());
    // discountcontroller = List.generate(100, (i) => TextEditingController());
    // selectedcust = null;
    // schemebtnclk = false;
    // paymentWay.clear();
    // totalPayment = null;
    // cpyfrmso = '';
    // newAddrsValue = [];
    // newCustValues = [];
    // remarkcontroller3.text = "";
    // scanneditemData.clear();
    // injectToDb();
    // notifyListeners();
    // await Get.defaultDialog(
    //         title: "Success",
    //         middleText: docstatus == "check out"
    //             ? 'Successfully Done, Document Number is $documentNum'
    //             : docstatus == "save as order"
    //                 ? "Sales order successfully saved..!!, Document Number is $documentNum"
    //                 : docstatus == "hold"
    //                     ? "Saved as draft"
    //                     // : docstatus == "suspend"
    //                     //     ? "This Sales Transaction Suspended Sucessfully..!!"
    //                     : "null",
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
    //   if (docstatus == "check out") {
    //     Get.offAllNamed(ConstantRoutes.dashboard);
    //   }
    //   OndDisablebutton = false;
    //   notifyListeners();
    // });
    notifyListeners();
  }

  callInvoicePostApi(BuildContext context, ThemeData theme, int docEntry,
      String docstatus, String documentNum) async {
    await sapLoginApi(context);
    await postingInvoice(context, theme, docEntry, docstatus, documentNum);
    notifyListeners();
  }

  List<Invbatch>? batchTable;
  addBatchtable(int ik) {
    batchTable = [];

    batchTable!.add(Invbatch(
      quantity: double.parse(scanneditemData[ik].Qty.toString()),
      batchNumberProperty: scanneditemData[ik].SerialBatch.toString(),
    ));
  }

  List<PostingInvoiceLines> itemsDocDetails = [];

  addDocLine() {
    itemsDocDetails = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      addBatchtable(i);
      itemsDocDetails.add(PostingInvoiceLines(
        // accountCode: "_SYS00000000698",
        Currency: "TZS",
        DiscPrcnt: scanneditemData[i].discountper.toString(),
        ItemCode: scanneditemData[i].ItemCode,
        Price: scanneditemData[i].SellPrice.toString(),
        Quantity: scanneditemData[i].Qty.toString(),
        TaxCode: scanneditemData[i].TaxRate.toString(),
        UnitPrice: scanneditemData[i].netvalue!.toStringAsFixed(2),
        WhsCode: UserValues.branch,
        itemName: scanneditemData[i].ItemName.toString(),
        batchNumbers: batchTable!,
      )

          // basedocentry:itemsDetails3[i].basedocentry ,
          // baseline:itemsDetails3[i].baseline

          );
      notifyListeners();
    }
  }

  List<PostPaymentCheck> itemsPaymentCheckDet = [];
  List<PostPaymentInvoice> itemsPaymentInvDet = [];

  addChequeValues() {
    itemsPaymentCheckDet = [];
    for (int i = 0; i < paymentWay.length; i++) {
      if (paymentWay[i].type == "Cheque") {
        //log("ddddd:::" + mycontroller[23].text);
        itemsPaymentCheckDet.add(PostPaymentCheck(
            dueDate: config.currentDate(),
            checkNumber: int.parse(paymentWay[i].chequeno.toString()),
            //  int.parse(mycontroller[23].text),
            bankCode: "NBC TZS",
            accounttNum: '',
            details: remarkcontroller3.text,
            checkSum: paymentWay[i].amt!));
      }
      notifyListeners();
    }
    notifyListeners();
  }

  postingReceipt22(
    BuildContext context,
    ThemeData theme,
    int docEntry,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    await addChequeValues22();
    await addInvoiceLine();
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
          sapReceiptDocentry = value.docEntry.toString();
          await DBOperation.updateRcSapDetSalpay(
              db,
              docEntry,
              int.parse(value.docNum.toString()),
              int.parse(value.docEntry.toString()),
              "SalesPay");
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

  addInvoiceLine() {
    itemsPaymentInvDet = [];
    if (scanneditemData.length > 0) {
      for (int i = 0; i < scanneditemData.length; i++) {
        itemsPaymentInvDet.add(PostPaymentInvoice(
            docEntry: int.parse(sapDocentry.toString()),
            sumApplied:
                double.parse(getSumTotalPaid().toString().replaceAll(',', '')),
            invoiceType: 'it_Invoice'));
      }
    }
    notifyListeners();
  }

  postingReceipt(BuildContext context, ThemeData theme, int docEntry) async {
    final Database db = (await DBHelper.getInstance())!;
    await addChequeValues();
    await addInvoiceLine();
    ReceiptPostAPi.docType = "rCustomer";
    ReceiptPostAPi.checkAccount = "_SYS00000000136";
    ReceiptPostAPi.cardCodePost = selectedcust!.cardCode;
    ReceiptPostAPi.docPaymentChecks = itemsPaymentCheckDet;
    ReceiptPostAPi.docPaymentInvoices = itemsPaymentInvDet;
    ReceiptPostAPi.docDate = config.currentDate();
    ReceiptPostAPi.dueDate = config.currentDate().toString();
    ReceiptPostAPi.remarks = remarkcontroller3.text;
    // ReceiptPostAPi.checkAccount = "_SYS00000000136";
    for (int i = 0; i < paymentWay.length; i++) {
      if (paymentWay[i].type == 'Cash') {
        ReceiptPostAPi.cashAccount = "_SYS00000000136";
        ReceiptPostAPi.cashSum = paymentWay[i].amt;

        notifyListeners();
      }
      if (paymentWay[i].type == 'Transfer') {
        ReceiptPostAPi.transferAccount = "_SYS00000000136";
        ReceiptPostAPi.transferSum = paymentWay[i].amt!;
        ReceiptPostAPi.transferReference = paymentWay[i].transref;
        ReceiptPostAPi.transferDate = config.currentDate.toString();
        notifyListeners();
      }
      notifyListeners();
    }

    ReceiptPostAPi.method();
    await ReceiptPostAPi.getGlobalData().then((value) async {
      // SalesOrderAfterAPi.baseEntry = value.docEntry.toString();
      //log("object:" + value.stscode.toString());
      if (value.stscode == null) {
        return;
      }
      if (value.stscode! >= 200 && value.stscode! <= 210) {
        if (value.docNum != null) {
          sapReceiptDocentry = value.docEntry.toString();

          await DBOperation.updateRcSapDetSalpay(
              db,
              docEntry,
              int.parse(value.docNum.toString()),
              int.parse(value.docEntry.toString()),
              "SalesPay");

          notifyListeners();
        }
      } else if (value.stscode! >= 400 && value.stscode! <= 410) {}
    });
    notifyListeners();
  }

  postingInvoice(BuildContext context, ThemeData theme, int docEntry,
      String docstatus, String documentNum) async {
    final Database db = (await DBHelper.getInstance())!;
    addDocLine();
    SalesInvoicePostAPi.docType = 'dDocument_Items';
    SalesInvoicePostAPi.cardCodePost = selectedcust!.cardCode;
    SalesInvoicePostAPi.docLineQout = itemsDocDetails;
    SalesInvoicePostAPi.docDate = config.currentDate();
    SalesInvoicePostAPi.dueDate = config.currentDate().toString();
    SalesInvoicePostAPi.remarks = remarkcontroller3.text;

    var uuid = Uuid();
    String? uuidg = uuid.v1();
    SalesInvoicePostAPi.method(uuidg);
    await SalesInvoicePostAPi.getGlobalData(uuidg).then((value) async {
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
          await DBOperation.UpdtSapDetSalHead(db, int.parse(sapDocentry!),
              int.parse(sapDocuNumber), docEntry, 'SalesHeader');

          if (cashType == 'Cash' ||
              chequeType == "Cheque" ||
              cardType == "Card" ||
              transferType == "Transfer" ||
              walletType == "Wallet" ||
              accType == "Account Balance" ||
              pointType == 'Points Redemption') {
            log("mycontroller[22].text:::$cashpayment");

            await postingReceipt22(context, theme, docEntry);
          }

          // for (int ik = 0; ik < paymentWay.length; ik++) {
          //   if (paymentWay[ik].type != 'Credit') {
          //     await postingReceipt(context, theme, docEntry);
          //   }
          // }
          await pushRabitmqSales2(docEntry);

          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(150, (i) => TextEditingController());
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          selectedcust = null;
          schemebtnclk = false;
          paymentWay.clear();
          totalPayment = null;
          cpyfrmso = '';
          newAddrsValue = [];
          newCustValues = [];
          remarkcontroller3.text = "";
          scanneditemData.clear();
          OndDisablebutton = false;
          injectToDb();
          notifyListeners();
          await Get.defaultDialog(
                  title: "Success",
                  middleText: docstatus == "check out"
                      ? 'Successfully Done, Document Number is $sapDocuNumber'
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
            if (docstatus == "check out") {
              Get.offAllNamed(ConstantRoutes.dashboard);
            }
            OndDisablebutton = false;
            notifyListeners();
          });
          custserieserrormsg = '';
        } else {
          //log("Error11");

          custserieserrormsg = value.error!.message.toString();
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(150, (i) => TextEditingController());
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          selectedcust = null;
          schemebtnclk = false;
          paymentWay.clear();
          totalPayment = null;
          cpyfrmso = '';
          newAddrsValue = [];
          newCustValues = [];
          remarkcontroller3.text = "";
          scanneditemData.clear();
          OndDisablebutton = false;
          injectToDb();
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
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(150, (i) => TextEditingController());
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          selectedcust = null;
          schemebtnclk = false;
          paymentWay.clear();
          totalPayment = null;
          cpyfrmso = '';
          newAddrsValue = [];
          newCustValues = [];
          remarkcontroller3.text = "";
          scanneditemData.clear();
          OndDisablebutton = false;
          injectToDb();
        });
      }
    });
    notifyListeners();
  }

  pushRabitmqSales(int? docentry) async {
    //background service

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getHoldSalesPayDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.holdSalesLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(db, docentry);
    String salesPAY = json.encode(getDBSalespay);
    String salesLine = json.encode(getDBSalesLine);
    String salesHeader = json.encode(getDBSalesHeader);
    // dynamic data = {"payload": salesPAY};
    var ddd = json.encode({
      "ObjectType": 1,
      "ActionType": "Add",
      "InvoiceHeader": salesHeader,
      "InvoiceLine": salesLine,
      "InvoicePay": salesPAY,
    });
    // log("branch: :${UserValues.branch}");
    // log("AppConstant.ip: :${AppConstant.ip}");

//log(" payload : $ddd");

    //RabitMQ

    // Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        // AppConstant.ip,
        // "102.69.167.106",
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    Channel channel = await client1.channel(); //Server_CS
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    // properties.headers = {"Branch": AppConstant.branch};
    // exchange.publish(ddd, "", properties: properties);

    //cs

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  pushRabitmqSales2(int? docentry) async {
    //background service

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getHoldSalesPayDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.holdSalesLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(db, docentry);
    String salesPAY = json.encode(getDBSalespay);
    String salesLine = json.encode(getDBSalesLine);
    String salesHeader = json.encode(getDBSalesHeader);

    // dynamic data = {"payload": salesPAY};
    var ddd = json.encode({
      "ObjectType": 1,
      "ActionType": "Add",
      "InvoiceHeader": salesHeader,
      "InvoiceLine": salesLine,
      "InvoicePay": salesPAY,
    });
    // log("branch: :${UserValues.branch}");
    // log("AppConstant.ip: :${AppConstant.ip}");

//log(" payload 22: $ddd");
    // RabitMQ
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

  viewDbtable() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.getdata(db);
    notifyListeners();
  }

  viewSalesRet() async {
    final Database db = (await DBHelper.getInstance())!;

    DBOperation.viewsalesret(db);
    print(' viewSalesRet msg');
  } //d
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

  // getItemFromDB(Database db) async {
  //   List<StockSnapTModelDB> itemMasdata = await DBOperation.getItemMasData(db);
  //   for (int i = 0; i < itemMasdata.length; i++) {
  //     itemData.add(StocksnapModelData(
  //       Branch: itemMasdata[i].branchcode,
  //       ItemCode: itemMasdata[i].itemcode,
  //       ItemName: itemMasdata[i].itemname,
  //       SerialBatch: itemMasdata[i].serialbatch,
  //       Qty: int.parse(itemMasdata[i].quantity!),
  //       MRP: double.parse(itemMasdata[i].mrpprice.toString()),
  //       createdUserID: itemMasdata[i].createdUserID.toString(),
  //       createdateTime: itemMasdata[i].createdateTime,
  //       lastupdateIp: itemMasdata[i].lastupdateIp,
  //       purchasedate: itemMasdata[i].purchasedate,
  //       snapdatetime: itemMasdata[i].snapdatetime,
  //       specialprice: double.parse(itemMasdata[i].specialprice.toString()),
  //       updatedDatetime: itemMasdata[i].updatedDatetime,
  //       updateduserid: itemMasdata[i].updateduserid.toString(),
  //       SellPrice: double.parse(itemMasdata[i].sellprice!),
  //       Maxdiscount: itemMasdata[i].maxdiscount != null
  //           ? itemMasdata[i].maxdiscount.toString()
  //           : '',
  //       TaxRate: itemMasdata[i].taxrate != null
  //           ? double.parse(itemMasdata[i].taxrate.toString())
  //           : 00,
  //       discountper: 0,
  //       OpenQty: 0,
  //       TransID: int.parse(itemMasdata[i].transentry != null
  //           ? itemMasdata[i].transentry.toString()
  //           : '0'),
  //       InDate: '',
  //       Cost: 0,
  //       TaxType: '',
  //       InType: '',
  //       VenCode: '',
  //       VenName: '',
  //     ));
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }

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

    for (int i = 1; i < cusdataDB.length; i++) {
      // if (cusdataDB[i].customername != "This is my updated name") {
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
      // }
    }
    for (int i = 0; i < custList.length; i++) {
      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (custList[i].cardCode == csadresdataDB[ia].custcode) {
          // log(csadresdataDB[0].address2!);
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
    // log("getTopCuslist2:::" + custList2.length.toString());

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
    //   log("step1");
    //   for (int i = 0; i < custList.length; i++) {
    //  // log("step2");

    //     for (int ia = 0; ia < csadresdataDB.length; ia++) {
    //    // log("step3");

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
    //      // log("step4");

    //         selectedBillAdress = selectedcust!.address!.length - 2;
    //         selectedShipAdress = selectedcust!.address!.length - 1;
    //       } else {
    //      // log("step5");

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
    //      // log("csadresdataDBcsadresdataDB::" +
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
    //   log("selectedcust!.address!.length:" +
    //       selectedcust!.address!.length.toString());
    //   log('selectedcust!.address!.length - 2::${selectedcust!.address!.length - 2}');
    // }

    filtercustList = custList;
    notifyListeners();
  }

  // call api

  postCategory(String value) {
    selectedValue = value;
  }

  clickItemcode(
      ItemCodeListModel aaa, BuildContext context, ThemeData theme, int inddd) {
    itemcodeitem = null;
    itemcodeitem = ItemCodeListModel(
      Branch: aaa.Branch,
      ItemCode: aaa.ItemCode,
      ItemName: aaa.ItemName,
      SerialBatch: aaa.SerialBatch,
      Qty: aaa.Qty,
      MRP: double.parse(aaa.MRP.toString()),
      createdUserID: aaa.createdUserID.toString(),
      createdateTime: aaa.createdateTime,
      lastupdateIp: aaa.lastupdateIp,
      purchasedate: aaa.purchasedate,
      snapdatetime: aaa.snapdatetime,
      specialprice: double.parse(aaa.specialprice.toString()),
      updatedDatetime: aaa.updatedDatetime,
      updateduserid: aaa.updateduserid.toString(),
      SellPrice: double.parse(aaa.SellPrice.toString()),
      Maxdiscount: aaa.Maxdiscount != null ? aaa.Maxdiscount.toString() : '',
      TaxRate: aaa.TaxRate != null ? double.parse(aaa.TaxRate.toString()) : 00,
      discountper: 0,
      OpenQty: 0,
      InDate: '',
      Cost: 0,
      TaxType: '',
      InType: '',
      VenCode: '',
      VenName: '',
      uPackSize: aaa.uPackSize,
      uTINSPERBOX: aaa.uTINSPERBOX,
      uSpecificGravity: aaa.uSpecificGravity,
    );

    itemcodelistitem55.add(itemcodeitem!);
    aaaabbb(context, theme, inddd);
    notifyListeners();
  }

  aaaabbb(BuildContext context, ThemeData theme, int i) {
    if (scanneditemData.isEmpty) {
      itemcodedataaa(context, theme, i);
      mycontroller[99].clear();
    } else {
      // log("AddSecond item ");
      addScndData(i, context, theme);
      mycontroller[99].clear();
    }
    calCulateDocVal(context, theme);
    // mycontroller[99].clear();
    // OndDisablebutton = false;
  }

  itemcodedataaa(BuildContext context, ThemeData theme, int i) {
//log("AAAAAAAAAAAAAAAAAAAAAAAAAA::${itemcodelistitem55.length}");

    // for (int i = 0; i < itemcodelistitem.length; i++) {
    if (itemcodelistitem[i].Qty! > 0) {
      scanneditemData.add(StocksnapModelData(
        Branch: itemcodelistitem[i].Branch,
        ItemCode: itemcodelistitem[i].ItemCode,
        ItemName: itemcodelistitem[i].ItemName,
        SerialBatch: itemcodelistitem[i].SerialBatch,
        Qty: 1,
        MRP: double.parse(itemcodelistitem[i].MRP.toString()),
        createdUserID: itemcodelistitem[i].createdUserID.toString(),
        createdateTime: itemcodelistitem[i].createdateTime,
        lastupdateIp: itemcodelistitem[i].lastupdateIp,
        purchasedate: itemcodelistitem[i].purchasedate,
        snapdatetime: itemcodelistitem[i].snapdatetime,
        specialprice: double.parse(itemcodelistitem[i].specialprice.toString()),
        updatedDatetime: itemcodelistitem[i].updatedDatetime,
        updateduserid: itemcodelistitem[i].updateduserid.toString(),
        SellPrice: double.parse(itemcodelistitem[i].SellPrice.toString()),
        Maxdiscount: itemcodelistitem[i].Maxdiscount != null
            ? itemcodelistitem[i].Maxdiscount.toString()
            : '',
        TaxRate: itemcodelistitem[i].TaxRate != null
            ? double.parse(itemcodelistitem[i].TaxRate.toString())
            : 0.0,
        uPackSize: itemcodelistitem[i].uPackSize ?? 0,
        uSpecificGravity: itemcodelistitem[i].uSpecificGravity ?? 0,
        uTINSPERBOX: itemcodelistitem[i].uTINSPERBOX ?? 0,
        discountper: 0,
        OpenQty: itemcodelistitem[i].Qty,
        InDate: '',
        Cost: 0,
        TaxType: '',
        InType: '',
        VenCode: '',
        VenName: '',
        liter: itemcodelistitem[i].liter != null
            ? double.parse(itemcodelistitem[i].liter.toString())
            : 0.0,
        weight: itemcodelistitem[i].weight != null
            ? double.parse(itemcodelistitem[i].weight.toString())
            : 0.0,
      ));

      for (int i = 0; i < scanneditemData.length; i++) {
        scanneditemData[i].TransID = i;
        discountcontroller[i].text = 0.0.toString();
      }

      // }

      // log("scanneditemData.length5555::::" + scanneditemData.length.toString());
      // log("scanneditemData.length5555111::::" +
      //     (int.parse(scanneditemData.length.toString()) - 1).toString());

      FocusScopeNode focus = FocusScope.of(context);

      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      notifyListeners();

      qtychangemtd(
        scanneditemData.length - 1,
        context,
        theme,
      );
      calCulateDocVal(context, theme);
      focusnode[0].requestFocus();
    }
  }

  // int intval = 0;
  // scannBAtch(BuildContext context, ThemeData theme) async {
  //   intval = 0;
  //   print(" mycontroller[99].text::" + mycontroller[99].text.toString());
  //   int? indx = await checkBatchAvail2(
  //     mycontroller[99].text.toString().trim().toUpperCase(),
  //   );
  //   if (indx != null) {
  //     intval = indx;
  //  // log("****************::" + itemcodelistitem.length.toString());
  //     if (itemcodelistitem.length > 1) {
  //       forItemCodecheck(context, theme);

  //       notifyListeners();
  //     } else if (itemcodelistitem.length == 1) {
  //    // log("VVVVVVVVV");

  //       addScannedData(indx, context, theme);
  //       mycontroller[99].clear();

  //       notifyListeners();
  //     }
  //   } else if (indx == null) {
  //  // log("index: $indx");
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

  // Future<int?> checkBatchAvail2(String sBatch) async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   itemcodelistitem.clear();
  //   itemcodeitem = null;
  //   for (int i = 0; i < itemData.length; i++) {
  //     // log('Serial batch1111:${itemData[i].SerialBatch}');

  //     if (itemData[i].SerialBatch == sBatch) {
  //       // log('Serial batch2222:$sBatch');
  //       List<Map<String, Object?>> itemcodelist =
  //           await DBOperation.Itemcodeserialbatch(db, sBatch);
  //       for (int ia = 0; ia < itemcodelist.length; ia++) {
  //         // log("itemcodelist[ia]['itemcode']::" +
  //         //     itemcodelist[ia]['itemcode'].toString());
  //         // log("itemcodelist[ia]['quantity']::" +
  //         //     itemcodelist[ia]['quantity'].toString());
  //         itemcodelistitem.add(ItemCodeListModel(
  //           ItemCode: itemcodelist[ia]['itemcode'].toString(),
  //           Qty: int.parse(itemcodelist[ia]['quantity'].toString()),
  //         ));
  //       }
  //       notifyListeners();
  //       return Future.value(i);
  //     }
  //   }
  //   notifyListeners();
  //   return Future.value(null);
  // }

  getCustSeriesApi() async {
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

  callCustPostApi(BuildContext context, ThemeData theme) async {
    loadingBtn = true;

    await addFiles();
    await sapLoginApi(context);
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
    await PostCustCreateAPi.getGlobalData(newCutomerModel).then((value) async {
      print('Step1');

      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        print('Step2');
        await insertAddNewCusToDB(context);
        Navigator.pop(context);
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

  Future<int?> checkBatchAvail(
    String sBatch,
    BuildContext context,
    ThemeData theme,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    itemcodelistitem.clear();
    itemcodeitem = null;

    List<StockSnapTModelDB> itemMasdata =
        await DBOperation.getItemMasData(db, sBatch);
    // log("sBatch::" + sBatch.toString());

    List<Map<String, Object?>> itemcodelist =
        await DBOperation.Itemcodeserialbatch(db, sBatch);

    for (int ia = 0; ia < itemcodelist.length; ia++) {
      itemcodelistitem.add(ItemCodeListModel(
          ItemCode: itemcodelist[ia]['itemcode'].toString(),
          ItemName: itemcodelist[ia]['itemname'].toString(),
          SerialBatch: itemcodelist[ia]['serialbatch'].toString(),
          Qty: int.parse(itemcodelist[ia]['quantity'].toString()),
          MRP: itemcodelist[ia]['mrpprice'] != null
              ? double.parse(itemcodelist[ia]['mrpprice'].toString())
              : null,
          createdUserID: itemcodelist[ia]['createdUserID'].toString(),
          createdateTime: itemcodelist[ia]['itecreatedateTimemname'].toString(),
          lastupdateIp: itemcodelist[ia]['lastupdateIp'].toString(),
          purchasedate: itemcodelist[ia]['purchasedate'].toString(),
          snapdatetime: itemcodelist[ia]['snapdatetime'].toString(),
          specialprice: itemcodelist[ia]['specialprice'] == null ||
                  itemcodelist[ia]['specialprice'] == 'null'
              ? 0
              : double.parse(
                  itemcodelist[ia]['specialprice'].toString(),
                ),
          updatedDatetime: itemcodelist[ia]['UpdatedDatetime'].toString(),
          updateduserid: itemcodelist[ia]['updateduserid'].toString(),
          SellPrice: itemcodelist[ia]['sellprice'] != null
              ? double.parse(
                  itemcodelist[ia]['sellprice'].toString(),
                )
              : null,
          Maxdiscount: itemcodelist[ia]['maxdiscount'] != null
              ? itemcodelist[ia]['maxdiscount'].toString()
              : '',
          TaxRate: itemcodelist[ia]['taxrate'] != null
              ? double.parse(
                  itemcodelist[ia]['taxrate'].toString(),
                )
              : 00,
          discountper: 0,
          OpenQty: 0,
          InDate: '',
          Cost: 0,
          TaxType: '',
          InType: '',
          VenCode: '',
          VenName: '',
          weight: itemcodelist[ia]['weight'] != null
              ? double.parse(itemcodelist[ia]['weight'].toString())
              : null,
          liter: itemcodelist[ia]['liter'] != null
              ? double.parse(itemcodelist[ia]['liter'].toString())
              : null,
          uPackSize: double.parse(itemcodelist[ia]['UPackSize'].toString()),
          uTINSPERBOX: int.parse(itemcodelist[ia]['UTINSPERBOX'].toString()),
          uSpecificGravity:
              double.parse(itemcodelist[ia]['USpecificGravity'].toString())));
    }
    if (itemcodelistitem.isNotEmpty) {
      if (itemcodelistitem.length == 1) {
        aaaabbb(context, theme, 0);
        notifyListeners();
      } else {
        forItemCodecheck(
          context,
          theme,
        );
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
                    content: 'Wrong batch scanned..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
      notifyListeners();
      mycontroller[99].clear();
    }
    return null;
  }

  forItemCodecheck(BuildContext context, ThemeData theme) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: AlertBox(
                  payMent: "ItemCode",
                  widget: checkItemcode(context, theme),
                  buttonName: null));
        });
    notifyListeners();
  }

  Widget checkItemcode(BuildContext context, ThemeData theme) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Screens.bodyheight(context) * 0.5,
      width: Screens.width(context) * 1, // Change as per your requirement
      child: ListView.builder(
          itemCount: itemcodelistitem.length,
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);

                    clickItemcode(
                        itemcodelistitem[index], context, theme, index);
                  },
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            itemcodelistitem[index].ItemCode.toString(),
                          )),
                          const Text(" - "),
                          SizedBox(
                              // color: Colors.red,
                              width: Screens.width(context) * 0.45,
                              child: Text(
                                itemcodelistitem[index].ItemName.toString(),
                              )),
                        ],
                      ),
                      Container(
                          child: Text(
                        itemcodelistitem[index].SerialBatch.toString(),
                      )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  // addScannedData(int ind, BuildContext context, ThemeData theme) async {
  //   if (scanneditemData.isEmpty) {
  //     // log("Add the data");
  //     // addScndDataFst(ind, context, theme);
  //   } else {
  //     // log("Add the one more qty data");

  //     addScndData(ind, context, theme);
  //   }
  //   notifyListeners();
  // }

  addScndData(int indx, BuildContext context, ThemeData theme) async {
    int? ins = await checkSameSerialBatchScnd(
        mycontroller[99].text.toString().trim().toUpperCase());
    // log("mycontroller[99].text:" +
    //     mycontroller[99].text.toString().trim().toUpperCase());
    if (ins != null) {
      // log("objectobjectobject11111");

      if (itemcodeitem != null) {
        int? inssx = await checkSameItemcode();
        if (inssx != null) {
          // log("objectobjectobject122222222222221");

          itemIncrement(inssx, context, theme);
        } else if (inssx == null) {
          // log("****************************************");

          itemcodedataaa(context, theme, indx);
          // addScndDataFst(indx, context, theme);
          notifyListeners();
        }
      } else {
        itemIncrement(ins, context, theme);
      }
    } else {
      // log("!!!!!!!!!!!!!!!!!!!!!!!");
      itemcodedataaa(context, theme, indx);
      // addScndDataFst(indx, context, theme);
      notifyListeners();
    }
  }

  Future<int?> checkSameSerialBatchScnd(String sBatch) async {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].SerialBatch == sBatch) {
        // log("textErrortextErrortextErrortextErrortextErrorFF111111111111::" + sBatch.toString());

        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  Future<int?> checkSameItemcode() async {
    for (int i = 0; i < scanneditemData.length; i++) {
      //log("MMMM1");
      if (scanneditemData[i].SerialBatch == itemcodeitem!.SerialBatch) {
        //log("MMMM2");

        if (scanneditemData[i].ItemCode == itemcodeitem!.ItemCode) {
          //log("MMMM3");

          return Future.value(i);
        }
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  int? adddiscperunit;
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
  //       discountper: double.parse(itemData[ind].Maxdiscount.toString())));
  //   notifyListeners();

  //   // qtymycontroller[ind].text = scanneditemData[ind].Qty.toString();

  //   qtychangemtd(
  //     scanneditemData.length - 1,
  //     context,
  //     theme,
  //   );
  //   FocusScopeNode focus = FocusScope.of(context);

  //   if (!focus.hasPrimaryFocus) {
  //     focus.unfocus();
  //   }
  //   notifyListeners();
  //   calCulateDocVal(context, theme);

  //   focusnode[0].requestFocus();
  // }

//   addScndDataFstItemcode(int ind, BuildContext context, ThemeData theme) {
//     scanneditemData.add(StocksnapModelData(
//         TransID: itemData[ind].TransID,
//         Branch: itemData[ind].Branch,
//         ItemCode: itemcodeitem!.ItemCode,
//         // itemData[ind].ItemCode,
//         ItemName: itemData[ind].ItemName,
//         SerialBatch: itemData[ind].SerialBatch,
//         OpenQty: itemData[ind].OpenQty,
//         Qty: 1,
//         InDate: itemData[ind].InDate,
//         InType: itemData[ind].InType,
//         VenCode: itemData[ind].VenCode,
//         VenName: itemData[ind].VenName,
//         MRP: itemData[ind].MRP,
//         SellPrice: itemData[ind].SellPrice,
//         Cost: itemData[ind].Cost,
//         TaxRate: itemData[ind].TaxRate,
//         TaxType: itemData[ind].TaxType,
//         discount: itemData[ind].discount,
//         basic: itemData[ind].basic,
//         netvalue: itemData[ind].netvalue,
//         taxvalue: itemData[ind].taxvalue,
//         Maxdiscount: itemData[ind].Maxdiscount,
//         createdUserID: '',
//         createdateTime: '',
//         lastupdateIp: '',
//         purchasedate: '',
//         snapdatetime: '',
//         specialprice: 0,
//         updatedDatetime: '',
//         updateduserid: '',
//         discountper: double.parse(itemData[ind].Maxdiscount.toString()),
//         liter: itemData[ind].liter,
//         weight: itemData[ind].weight));
//     notifyListeners();

//     // qtymycontroller[ind].text = scanneditemData[ind].Qty.toString();
// log("scanneditemDatascanneditemData:"+scanneditemData.length.toString());
//     qtychangemtd(
//     scanneditemData.length-1,
//       context,
//       theme,
//     );
//     FocusScopeNode focus = FocusScope.of(context);

//     if (!focus.hasPrimaryFocus) {
//       focus.unfocus();
//     }
//     notifyListeners();
//     // paymentDetails();
//     calCulateDocVal(context, theme);
//     // qtymycontroller[ind].text="1";

//     focusnode[0].requestFocus();
//   }

  qtychangemtd(int ind, BuildContext context, ThemeData theme) {
    // for (int ir = 0; ir < scanneditemData.length; ir++) {
    // log("indindind::" + ind.toString());
    qtymycontroller[ind].text = scanneditemData[ind].Qty.toString();
    notifyListeners();
    // }
  }

  ////
  ///

  int i = 1;

  int get geti => i;
  itemIncrement(int ind, BuildContext context, ThemeData theme) {
    int qtyctrl = int.parse(qtymycontroller[ind].text);
    // log("data qty greater111::" + scanneditemData[ind].OpenQty.toString());

    for (int i = 0; i < itemcodelistitem.length; i++) {
      // log("data qty greater2222::" + itemcodelistitem[i].Qty.toString());
      if (itemcodelistitem[i].SerialBatch == scanneditemData[ind].SerialBatch) {
        if (scanneditemData[ind].OpenQty! >= qtyctrl) {
          // log("data qty greater::" + itemcodelistitem[i].OpenQty.toString());
          qtyctrl = qtyctrl + 1;
          // log("qtyctrlqtyctrl::" + qtyctrl.toString());
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
          calCulateDocVal(context, theme);

          break;
        }
      }
    }

    notifyListeners();
  }
  // itemIncrement(int ind, BuildContext context, ThemeData theme) {
  //   int qtyctrl = int.parse(qtymycontroller[ind].text);
  //   log("data qty greater111");

  //   for (int i = 0; i < itemData.length; i++) {
  //  // log("data qty greater2222");
  //     if (itemData[i].SerialBatch == scanneditemData[ind].SerialBatch) {
  //       if (itemData[i].Qty! >= qtyctrl) {
  //      // log("data qty greater::" + itemData[i].Qty.toString());
  //         qtyctrl = qtyctrl + 1;
  //      // log("qtyctrlqtyctrl::" + qtyctrl.toString());
  //         qtymycontroller[ind].text = qtyctrl.toString();
  //         FocusScopeNode focus = FocusScope.of(context);
  //         calCulateDocVal(context, theme);

  //         if (!focus.hasPrimaryFocus) {
  //           focus.unfocus();
  //         }
  //         focusnode[0].requestFocus();
  //         notifyListeners();
  //         break;
  //       } else {
  //         qtymycontroller[ind].text = 1.toString();

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

  //   notifyListeners();
  // }

  // setstate1() {
  //   notifyListeners();
  // }
  int qqqttyy = 0;

  qqqqq(int ix) {
    qqqttyy = 0;
    // for (int ix = 0; ix < soData.length; ix++) {
    for (int ij = 0; ij < soScanItem.length; ij++) {
      if (soScanItem[ij].basedocentry.toString() ==
              soData[ix].basedocentry.toString() &&
          soScanItem[ij].baselineid.toString() ==
              soData[ix].baselineid.toString() &&
          soScanItem[ij].ItemCode.toString() ==
              soData[ix].ItemCode.toString()) {
        qqqttyy = qqqttyy + int.parse(soqtycontroller[ij].text);
        //log("qqqttyyqqqttyy:::${qqqttyy}");
        notifyListeners();
      }
      // }
    }
    notifyListeners();
  }

  mapsoqty(int ij, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    List<StockSnapTModelDB> itemMasdata =
        await DBOperation.getItemMasDataItemcd(
            db,
            soScanItem[ij].SerialBatch.toString(),
            soScanItem[ij].ItemCode.toString());

    for (int ix = 0; ix < soData.length; ix++) {
      //log("MMMM2:::${soScanItem[ij].baselineid}:: ${soData[ix].baselineid}");
      if (soScanItem[ij].basedocentry.toString() ==
              soData[ix].basedocentry.toString() &&
          soScanItem[ij].baselineid.toString() ==
              soData[ix].baselineid.toString() &&
          soScanItem[ij].ItemCode.toString() ==
              soData[ix].ItemCode.toString()) {
        //log("MMMM3");
        if (itemMasdata[0].serialbatch.toString() ==
            soScanItem[ij].SerialBatch.toString()) {
          qqqqq(ix);
          if (int.parse(soqtycontroller[ij].text) > 0) {
            if (soData[ix].Qty! >= qqqttyy &&
                (int.parse(itemMasdata[0].quantity.toString()) >=
                    int.parse(soqtycontroller[ij].text))) {
              soScanItem[ij].Qty = int.parse(soqtycontroller[ij].text);
              notifyListeners();
            } else {
              soqtycontroller[ij].text = 1.toString();
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
          } else if (int.parse(soqtycontroller[ij].text) == 0) {
            soScanItem.removeAt(ij);
            soqtycontroller.removeAt(ij);
          }
        }

        notifyListeners();
      }
    }
  }

  itemIncrement11(int ind, BuildContext context, ThemeData theme) async {
    double removeqty = 0;
    double qtyctrl = 0;
    qtyctrl = double.parse(qtymycontroller[ind].text.toString());

    if (qtyctrl != 0) {
      if (scanneditemData[ind].OpenQty! >=
          double.parse(qtymycontroller[ind].text.toString())) {
        calCulateDocVal(context, theme);
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
        notifyListeners();
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
        calCulateDocVal(context, theme);

        notifyListeners();
      }
    } else if (double.parse(qtymycontroller[ind].text.toString()) ==
            removeqty ||
        qtymycontroller[ind].text.isEmpty) {
      qtymycontroller.removeAt(ind);
      scanneditemData.removeAt(ind);

      calCulateDocVal(context, theme);

      notifyListeners();
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

  soItemDecrement(
    BuildContext context,
    ThemeData theme,
    int ind,
  ) {
    int soqtyctrl = int.parse(soqtycontroller[ind].text);

    if (soqtyctrl > 0) {
      soqtyctrl = soqtyctrl - 1;
      soqtycontroller[ind].text = soqtyctrl.toString();
      // soScanItem[ik].Qty = int.parse(soqtycontroller[ind].text.toString());
      notifyListeners();
    } else if (soqtyctrl == 0) {
      soqtycontroller[ind].text = '';
      notifyListeners();
    }
    notifyListeners();
  }

  custSelected(
    CustomerDetals customerDetals,
    BuildContext context,
  ) async {
    selectedcust = null;
    selectedcust55 = null;
    selectedBillAdress = 0;
    selectedShipAdress = 0;
    double? updateCustBal;
    loadingscrn = true;
    holddocentry = '';
    List<Address> address22 = [];
    List<Address> address55 = [];

    for (int i = 0; i < customerDetals.address!.length; i++) {
      if (customerDetals.address![i].addresstype == "B") {
        // log("customerDetals.address!.length::" +
        // customerDetals.address!.length.toString());
        // selectedcust!.address!.
        address22.add(Address(
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
        // log("HHHHHHHHH:::" + selectedcust!.address!.length.toString());
      }

      if (customerDetals.address![i].addresstype == "S") {
        // selectedcust55!.address!
        address55.add(Address(
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
    selectedcust = CustomerDetals(
        autoId: customerDetals.autoId,
        name: customerDetals.name,
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        // accBalance: customerDetals.accBalance,
        point: customerDetals.point,
        address: address22,
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '');

    selectedcust55 = CustomerDetals(
        autoId: customerDetals.autoId,
        name: customerDetals.name,
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        // accBalance: customerDetals.accBalance,
        point: customerDetals.point,
        address: address55,
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '');
//log("selectedcust add length::${selectedcust!.address!.length}");
//log("selectedcust55 add length::${selectedcust55!.address!.length}");

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
    selectedcust!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    selectedcust55!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    notifyListeners();
    callgetSOValue();
  }

  billaddresslist() {
    billadrrssItemlist = [];
    for (int i = 0; i < selectedcust!.address!.length; i++) {
      if (selectedcust!.address![i].addresstype == "B") {
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
  }

  shippinfaddresslist() {
    shipadrrssItemlist = [];
    for (int i = 0; i < selectedcust55!.address!.length; i++) {
      if (selectedcust55!.address![i].addresstype == "S") {
        shipadrrssItemlist.add(Address(
            addresstype: selectedcust55!.address![i].addresstype,
            address1: selectedcust55!.address![i].address1,
            address2: selectedcust55!.address![i].address2,
            address3: selectedcust55!.address![i].address3,
            billCity: selectedcust55!.address![i].billCity,
            billCountry: selectedcust55!.address![i].billCountry,
            billPincode: selectedcust55!.address![i].billPincode,
            billstate: selectedcust55!.address![i].billstate));
        // log("shipadrrssItemlist::" + shipadrrssItemlist.length.toString());
      }
      notifyListeners();
    }
    notifyListeners();
  }

  // createadd(BuildContext context) {
  //   if (formkeyAd.currentState!.validate()) {
  //     Navigator.pop(context);

  //     insertCreatenewAddress();
  //     CareateNewBillAdd();
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }

  CareateNewBillAdd() async {
    // final Database db = await dbHelper.createDB();
    final Database db = (await DBHelper.getInstance())!;
    String addCardCode = selectedcust!.cardCode.toString();
    print("New Created address CardCode:$addCardCode");

    List<CustomerAddressModelDB> createnewcsaddDB =
        await DBOperation.createNewgetCstmMasAddDB(db, addCardCode);

    for (int i = 0; i < custList.length; i++) {
      for (int ia = createnewcsaddDB.length - 1;
          ia < createnewcsaddDB.length;
          ia++) {
        if (custList[i].cardCode == createnewcsaddDB[ia].custcode) {
          print("New objectobjectobject");
          custList[i].address!.add(Address(
                address1: createnewcsaddDB[ia].address1!,
                address2: createnewcsaddDB[ia].address2!,
                address3: createnewcsaddDB[ia].address3!,
                billCity: createnewcsaddDB[ia].city!,
                billCountry: createnewcsaddDB[ia].countrycode!,
                billPincode: createnewcsaddDB[ia].pincode!,
                billstate: createnewcsaddDB[ia].statecode,
              ));
          selectedcust!.address = custList[i].address!;
          selectedBillAdress = (selectedcust!.address!.length - 1);
          selectedShipAdress = (selectedcust!.address!.length - 1);
          notifyListeners();
          // print(selectedcust!.address);
        }
      }
    }

    // print("Create new bill");

    // log("custList.length:${createnewcsaddDB.length}");
    // log("custList.length:${createnewcsaddDB.length - 1}");

    // billAddress: createnewcsaddDB[i].address1!,
    // billCity: createnewcsaddDB[i].city!,
    // billCountry: createnewcsaddDB[i].countrycode!,
    // billPincode: createnewcsaddDB[i].statecode,
    // billstate: createnewcsaddDB[i].statecode,
    // shipAddress: createnewcsaddDB[i].address1!,
    // shipCity: createnewcsaddDB[i].city!,
    // shipCountry: createnewcsaddDB[i].countrycode!,
    // shipPincode: createnewcsaddDB[i].statecode,
    // shipstate: createnewcsaddDB[i].statecode,
    //   ));

    notifyListeners();
  }

  clearData() {
    selectedcust = null;
    holddocentry = '';
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
      // log("filter values length::" + filtercustList.length.toString());
    } else if (v.isEmpty) {
      // log("filter values lengthxxx::" + filtercustList.length.toString());

      filtercustList = custList;
      notifyListeners();
    }
  }

  refreshfiltercust() {
    filtercustList = custList;
    notifyListeners();
  }

  callBillAddressPostApi(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    OndDisablebutton = true;
    await sapLoginApi(context);
//log("App constatant fff ::::${AppConstant.sapSessionID}");
    NewAddressModel? newAddModel = NewAddressModel();
    newAddModel!.newModel = [
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
      // NewCutomeAdrsModel(
      //   AddressName: mycontroller[14].text,
      //   AddressName2: mycontroller[15].text,
      //   AddressName3: mycontroller[16].text,
      //   AddressType: 'bo_ShipTo',
      //   City: mycontroller[17].text,
      //   Country: "TZ", //mycontroller[20].text,
      //   State: '', // mycontroller[19].text,
      //   Street: '',
      //   ZipCode: mycontroller[18].text,
      // ),
    ];
    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertCreatenewbilAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustBilladdresslist(
          context,
        );
        // await insertCreatenewsipAddress();
        // await DBOperation.getdata(db);
        // await getCustDetFDB();
        // await getcustshipaddresslist(
        //   context,
        // );
        // Navigator.pop(context);
        OndDisablebutton = false;

        config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        OndDisablebutton = false;

        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        OndDisablebutton = false;
      }
    });
    notifyListeners();
  }

  callShipAddressPostApi(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;

    loadingBtn = true;
    await sapLoginApi(context);
//log("App constatant fff ::::${AppConstant.sapSessionID}");
    NewAddressModel? newAddModel = NewAddressModel();
    newAddModel!.newModel = [
      // NewCutomeAdrsModel(
      //   AddressName: mycontroller[7].text,
      //   AddressName2: mycontroller[8].text,
      //   AddressName3: mycontroller[9].text,
      //   AddressType: 'bo_BillTo',
      //   City: mycontroller[10].text,
      //   Country: "TZ", //mycontroller[13].text,
      //   State: '', //mycontroller[12].text,
      //   Street: '',
      //   ZipCode: mycontroller[11].text,
      // ),
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
    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertCreatenewsipAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustshipaddresslist(
          context,
        );
        // Navigator.pop(context);
        config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        OndDisablebutton = false;

        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        OndDisablebutton = false;

        config.showDialogg("Something went wrong try agian..!!", "Failed");
      }
    });
    notifyListeners();
  }

  callAddressPostApi(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    await sapLoginApi(context);
//log("App constatant fff ::::${AppConstant.sapSessionID}");
    NewAddressModel? newAddModel = NewAddressModel();
    newAddModel!.newModel = [
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
    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertCreatenewbilAddress();
        await insertCreatenewsipAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustBilladdresslist(
          context,
        );
        await getcustshipaddresslist(
          context,
        );
        OndDisablebutton = false;
        config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        OndDisablebutton = false;
        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        OndDisablebutton = false;

        config.showDialogg("Something went wrong try agian..!!", "Failed");
      }
    });
    notifyListeners();
  }

  insertnewbilladdresscreation(BuildContext context, ThemeData theme) async {
    OndDisablebutton = true;
//log("objectobjectobject bill");
    final Database db = (await DBHelper.getInstance())!;

    if (formkeyAdd.currentState!.validate()) {
      if (checkboxx == true) {
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
          }).then((value) {
        OndDisablebutton = false;
        notifyListeners();
      });
      notifyListeners();
    }
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
            //autoid
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

  insertnewshipaddresscreation(BuildContext context, ThemeData theme) async {
    OndDisablebutton = true;
//log("objectobjectobject ship");
    final Database db = (await DBHelper.getInstance())!;

    if (formkeyShipAdd.currentState!.validate()) {
      // callAddressPostApi(context);
      // await insertCreatenewsipAddress();
      // // await DBOperation.getdata(db);
      // await getCustDetFDB();
      // await getcustshipaddresslist(
      //   context,
      // );

      if (checkboxx == true) {
        await callAddressPostApi(context);
        // await insertCreatenewbilAddress();
        // await DBOperation.getdata(db);
        // await getCustDetFDB();
        // await getcustBilladdresslist(
        //   context,
        // );
        notifyListeners();
      } else {
        callShipAddressPostApi(context);
        notifyListeners();
      }

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
          }).then((value) {
        OndDisablebutton = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  getcustshipaddresslist(
    BuildContext context,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.getdata(db);

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust!.cardCode!);

    print("MMMMMMMMM:::${selectedcust!.cardCode}");
    print("MMMMMMMMM55:::${selectedcust!.cardCode}");
    selectedcust55!.address = [];

    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (selectedcust55!.cardCode ==
          csadresdataDB[ia]['custcode'].toString()) {
        if (csadresdataDB[ia]['addresstype'].toString() == "S") {
          selectedcust55!.address!.add(
            //autoid
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
        }
      }
      notifyListeners();
    }
//log("selectedcust!.address!.length:::${selectedcust!.address!.length}");
    selectedShipAdress = selectedcust55!.address!.length - 1;
//log("selectedShipAdress::$selectedShipAdress");
//log(" selectedcust!.address!.length555::${selectedcust!.address!.length}");
    notifyListeners();
  }

  insertCreatenewbilAddress() async {
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
    getCustDetFDB();
  }

  insertCreatenewsipAddress() async {
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

//log("Inserted New Created Address");

    notifyListeners();
  }

  // insertCreatenewAddress() async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   // final Database db = await dbHelper.createDB();

  //   createNewAddress.add(CustomerAddressModelDB(
  //     createdUserID: UserValues.userID.toString(),
  //     createdateTime: config.currentDate(),
  //     lastupdateIp: UserValues.lastUpdateIp.toString(),
  //     updatedDatetime: config.currentDate(),
  //     updateduserid: UserValues.lastUpdateIp.toString(),
  //     address1: mycontroller[7].text,
  //     address2: mycontroller[8].text,addresstype: 'B',
  //     address3: mycontroller[9].text,
  //     city: mycontroller[10].text,
  //     countrycode: mycontroller[13].text,
  //     custcode: selectedcust!.cardCode,
  //     // mycontroller[77].text,
  //     geolocation1: '',
  //     geolocation2: '',
  //     statecode: mycontroller[12].text, pincode: mycontroller[11].text,
  //     branch: UserValues.branch.toString(), terminal: UserValues.terminal,
  //   ));
  //   await DBOperation.insertCustomerAddress(db, createNewAddress);
  //   await DBOperation.getdata(db);

  //   notifyListeners();
  //   print("Inserted New Created Address");
  // }

  changeBillAddress(int slcAdrs) {
    selectedBillAdress = slcAdrs;
    notifyListeners();
  }

  changeShipAddress(int slcAdrs) {
    selectedShipAdress = slcAdrs;
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
      mycontroller[20].text = '';
    }
    notifyListeners();
  }

  validateformkey(
    int ij,
  ) {
    print("ij.toString():$ij");
    if (formkeyy[ij].currentState!.validate()) {
      print("validate the Customer formkey");
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

  createnewchagescustaddres(
      BuildContext context, ThemeData theme, int ij) async {
    final Database db = (await DBHelper.getInstance())!;

    await addnewCustomer(context, theme, ij);
    await DBOperation.getdata(db);
    await getCustDetFDB();
    await getNewCustandadd(context);
    // Navigator.pop(context);
    notifyListeners();
  }

  addnewCustomer(BuildContext context, ThemeData theme, int ij) async {
    int sucesss = 0;
    tinfileError = '';
    vatfileError = '';
    textError = '';
    if (formkeyy[ij].currentState!.validate()) {
      sucesss = sucesss + 1;
    }

    if (formkeyAdd.currentState!.validate()) {
      sucesss = sucesss + 1;
      notifyListeners();
    }

    if (sucesss == 2) {
      if (tinFiles == null) {
        print('XXXXXXXXXXXXXXXXXXXX');
        fileValidation = true;
        tinfileError = "Select a Tin File";
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
          notifyListeners();
        });

        notifyListeners();
      } else {
        fileValidation = false;
        notifyListeners();
      }
      await callCustPostApi(context, theme);

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
    // log("mycontroller[3].text.toString()::${mycontroller[3].text}");
    List<Map<String, Object?>> newcusdataDB =
        await DBOperation.getCstmMasDatabyautoid(
            db, mycontroller[3].text.toString());
    // mycontroller[3].text.toString());
    List<Map<String, Object?>> newaddrssdataDB =
        await DBOperation.addgetCstmMasAddDB(
            db, mycontroller[3].text.toString());
    for (int i = 0; i < newcusdataDB.length; i++) {
      // log('step:1');
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
//log('step:1.1');
    if (newaddrssdataDB.isNotEmpty) {
      for (int ik = 0; ik < newaddrssdataDB.length; ik++) {
        // log('step:2');
        // log("newcusdataDB.length::${newaddrssdataDB.length}");

        // log("newaddrssdataDB.cardcode::${newaddrssdataDB[ik]['custcode']}");
        // selectedcust!.address = [];
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

          // log('step:3');
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
        // log("selectedcust!.address!.length:::${selectedcust!.address!.length}");

        selectedBillAdress = selectedcust!.address!.length - 1;
        selectedShipAdress = selectedcust55!.address!.length - 1;
        // log("selectedBillAdress55:" + selectedBillAdress.toString());
        // log('selectedShipAdress88::' + selectedShipAdress.toString());
        // log('step:4');
      }
    }

    notifyListeners();
  }

  // String? custautoid;

  insertAddNewCusToDB(
    BuildContext context,
  ) async {
    print("lastUpdateIp::-----${UserValues.lastUpdateIp}");
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
    //   log("step:1");
    //   await DBOperation.insertCustomer(db, newCustValues);
    //   List<CustomerModelDB> newcusdataDB = await DBOperation.getCstmMasDB(db);
    //   log(" step:21");
    //   custautoid = newcusdataDB[newcusdataDB.length - 1].autoid.toString();
    //   log("newcusdataDB autoid:::${newcusdataDB[newcusdataDB.length - 1].autoid}");

    //   List<Map<String, Object?>> updatenewcardcode =
    //       await DBOperation.updateCustomerDetailstocrdcode(
    //           db, newcusdataDB[newcusdataDB.length - 1].autoid.toString());
    //   notifyListeners();

    //   log(" step:3");
    // } else {
    //   await DBOperation.insertCustomer(db, newCustValues);
    //   notifyListeners();
    // }

    newBillAddrsValue.add(CustomerAddressModelDB(
      custcode: mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
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
      geolocation1: '',
      geolocation2: '',
      statecode: mycontroller[12].text.isNotEmpty ? mycontroller[12].text : '',
      pincode: mycontroller[11].text.isNotEmpty ? mycontroller[11].text : '',
      branch: UserValues.branch,
      terminal: UserValues.terminal,
      addresstype: 'B',
    ));
    newShipAddrsValue.add(CustomerAddressModelDB(
      custcode: mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
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

//log('Stepa::${newBillAddrsValue.length}');
    int newadd = 0;
    if (newBillAddrsValue.isNotEmpty) {
      // log('Step1B');
      newadd = newadd + 1;
    }
    if (newShipAddrsValue.isNotEmpty) {
      newadd = newadd + 1;

      // log('StepC:$newadd');
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

      // log('StepD');
    }
    notifyListeners();
  }

  // insertAddNewCusToDB( BuildContext context, ) async {
  //   print("lastUpdateIp::-----" + UserValues.lastUpdateIp.toString());

  //   final Database db = (await DBHelper.getInstance())!;

  //   // if (formkeyy[ji].currentState!.validate()) {

  //   newCustValues.add(CustomerModelDB(
  //       customerCode:
  //           mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
  //       createdUserID: UserValues.userID.toString(),
  //       createdateTime: config.currentDate(),
  //       lastupdateIp: UserValues.lastUpdateIp.toString(),
  //       // UserValues.lastUpdateIp != null
  //       //     ? int.parse(UserValues.lastUpdateIp.toString())
  //       //     : 0,
  //       updatedDatetime: config.currentDate(),
  //       updateduserid: UserValues.userID,
  //       balance: 0,
  //       createdbybranch: UserValues.branch,
  //       customertype: '',
  //       customername:
  //           mycontroller[6].text.isNotEmpty ? mycontroller[6].text : '',
  //       emalid: mycontroller[21].text.isNotEmpty ? mycontroller[21].text : '',
  //       phoneno1: mycontroller[4].text.isNotEmpty ? mycontroller[4].text : '',
  //       phoneno2: "",
  //       points: 0,
  //       premiumid: '',
  //       snapdatetime: config.currentDate(),
  //       taxno: mycontroller[5].text.toString(),
  //       // AppLocalizations.of(context)!.gst,
  //       terminal: UserValues.terminal));
  //   notifyListeners();

  //   newAddrsValue.add(CustomerAddressModelDB(
  //     createdUserID: UserValues.userID.toString(),
  //     createdateTime: config.currentDate(),
  //     lastupdateIp: UserValues.lastUpdateIp,
  //     updatedDatetime: config.currentDate(),
  //     updateduserid: UserValues.userID.toString(),
  //     address1: mycontroller[7].text.isNotEmpty ? mycontroller[7].text : '',
  //     address2: mycontroller[8].text.isNotEmpty ? mycontroller[8].text : '',
  //     address3: mycontroller[9].text.isNotEmpty ? mycontroller[9].text : '',
  //     city: mycontroller[10].text.isNotEmpty ? mycontroller[10].text : '',
  //     countrycode:
  //         mycontroller[13].text.isNotEmpty ? mycontroller[13].text : '',
  //     custcode: mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
  //     geolocation1: '',
  //     geolocation2: '',
  //     addresstype: 'B',
  //     statecode: mycontroller[12].text.isNotEmpty ? mycontroller[12].text : '',
  //     pincode: mycontroller[11].text.isNotEmpty ? mycontroller[11].text : '',
  //     branch: UserValues.branch,
  //     terminal: UserValues.terminal,
  //   ));
  //   await DBOperation.insertCustomer(db, newCustValues);
  //   await DBOperation.insertCustomerAddress(db, newAddrsValue);
  //   await DBOperation.getdata(db);

  //   notifyListeners();
  //   print("values[0].customerCode:${newCustValues[0].customerCode}");
  //   print("values.customername:${newCustValues[0].customername}");
  //   // }
  //   notifyListeners();
  // }

  mapUpdateCustomer(int sInd) async {
    // log("selectedcust!.address![selectedBillAdress].autoId:${selectedcust!.address![selectedBillAdress].autoId}");
    // log("selectedcust!.address![selectedBillAdress].address2:${selectedcust!.address![selectedBillAdress].address2}and${selectedcust!.address![selectedBillAdress].address3}");

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
    if (formkeyy[6].currentState!.validate()) {
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
    // final Database db = await dbHelper.createDB();
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
    print("  selectedcust!.autoId::${selectedcust!.autoId.toString()}");
    await DBOperation.updateCustomerDetails(
      db,
      selectedcust!.autoId.toString(),
      selectedcust!,
    );
// selectedcust!.cardCode.toString(),
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

// //log("iiiiiiiiiiiiiiiiiiiiiiiiii------$selectedBillAdress");
// // if(selectedcust!.address![selectedBillAdress].addresstype=='B'){
//     // selectedcust!.cardCode = mycontroller[3].text;
//     selectedcust!.phNo = mycontroller[4].text;
//     selectedcust!.tarNo = mycontroller[5].text;
//     selectedcust!.name = mycontroller[6].text;
//     selectedcust!.email = mycontroller[21].text;

//     selectedcust!.address![i].address1 = mycontroller[7].text;
//     selectedcust!.address![i].address2 = mycontroller[8].text;
//     selectedcust!.address![i].address3 = mycontroller[9].text;
//     selectedcust!.address![i].billCity = mycontroller[10].text;
//     selectedcust!.address![i].billPincode = mycontroller[11].text;
//     selectedcust!.address![i].billstate = mycontroller[12].text;
//     selectedcust!.address![i].billCountry = mycontroller[13].text;

//     selectedcust55!.cardCode = mycontroller[3].text;
//     selectedcust55!.phNo = mycontroller[4].text;
//     selectedcust55!.tarNo = mycontroller[5].text;
//     selectedcust55!.name = mycontroller[6].text;
//     selectedcust55!.email = mycontroller[21].text;
// // if( mycontroller[14].text.isNotEmpty){
//     if (mycontroller[14].text.isNotEmpty ||
//         mycontroller[16].text.isNotEmpty ||
//         mycontroller[17].text.isNotEmpty ||
//         mycontroller[18].text.isNotEmpty ||
//         mycontroller[15].text.isNotEmpty ||
//         mycontroller[19].text.isNotEmpty ||
//         mycontroller[20].text.isNotEmpty) {
//       selectedcust55!.address![ij].address1 = mycontroller[14].text;
//       selectedcust55!.address![ij].address2 = mycontroller[15].text;
//       selectedcust55!.address![ij].address3 = mycontroller[16].text;
//       selectedcust55!.address![ij].billCity = mycontroller[17].text;
//       selectedcust55!.address![ij].billPincode = mycontroller[18].text;
//       selectedcust55!.address![ij].billstate = mycontroller[19].text;
//       selectedcust55!.address![ij].billCountry = mycontroller[20].text;
//       notifyListeners();
//     }
//     notifyListeners();

//     await DBOperation.updateCustomerDetails(
//       db,
//       selectedcust!.cardCode.toString(),
//       selectedcust!,
//     );
//     notifyListeners();

//     await DBOperation.updateAddressDetails(db,
//         selectedcust!.cardCode.toString(), i, selectedcust!, aId.toString());
//     if (selectedcust55!.address != null) {
//       String autoid5 =
//           selectedcust55!.address![selectedShipAdress].autoId != null
//               ? selectedcust55!.address![selectedShipAdress].autoId.toString()
//               : '';

//       await DBOperation.updateShipAddressDetails(
//           db,
//           selectedcust55!.cardCode.toString(),
//           ij,
//           selectedcust55!,
//           autoid5.toString());
//     }
//     getCustDetFDB();
//     await getUpdateCustandadd(context, selectedcust!.cardCode.toString());
//     notifyListeners();
//   }

  getUpdateCustandadd(BuildContext context, String cardcode) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Address> address55 = [];
    selectedcust!.address = [];
    selectedcust55!.address = [];

    List<Map<String, Object?>> newcusdataDB =
        await DBOperation.getCstmMasDatabyautoid(db, cardcode.toString());
    List<Map<String, Object?>> newaddrssdataDB =
        await DBOperation.addgetCstmMasAddDB(db, cardcode.toString());
    for (int i = 0; i < newcusdataDB.length; i++) {
      // log('step:1');
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
//log('step:3');
    if (newaddrssdataDB.isNotEmpty) {
      for (int ik = 0; ik < newaddrssdataDB.length; ik++) {
        // log('step:2');
        // log("newcusdataDB.length::${newcusdataDB.length}");

        // log("newaddrssdataDB.cardcode::${newaddrssdataDB[ik]['custcode']}");
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

          // log('step:3');
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

          // log('step:3');
        }
      }
    }
//log("selectedcust!.address!.length:::${selectedcust!.address!.length}");

    // selectedBillAdress = selectedcust!.address!.length - 1;
    // selectedShipAdress = selectedcust55!.address!.length - 1;
    // log("selectedBillAdress55:" + selectedBillAdress.toString());
    // log('selectedShipAdress88::' + selectedShipAdress.toString());

//log('step:4');
  }
  // mapUpdateCustomer(int sInd) async {
  //   log("selectedcust!.address![selectedBillAdress].autoId:${selectedcust!.address![selectedBillAdress].autoId}");
  //   log("selectedcust!.address![selectedBillAdress].address2:${selectedcust!.address![selectedBillAdress].address2}and${selectedcust!.address![selectedBillAdress].address3}");

  //   mycontroller[3].text = selectedcust!.cardCode!;
  //   mycontroller[4].text = selectedcust!.phNo!;
  //   mycontroller[5].text = selectedcust!.tarNo!;
  //   mycontroller[6].text = selectedcust!.name!;
  //   mycontroller[21].text = selectedcust!.email!;
  //   mycontroller[7].text = selectedcust!.address![selectedBillAdress].address1!;
  //   mycontroller[8].text = selectedcust!.address![selectedBillAdress].address2!;
  //   mycontroller[9].text = selectedcust!.address![selectedBillAdress].address3!;
  //   mycontroller[10].text = selectedcust!.address![selectedBillAdress].billCity;
  //   mycontroller[11].text =
  //       selectedcust!.address![selectedBillAdress].billPincode;
  //   mycontroller[12].text =
  //       selectedcust!.address![selectedBillAdress].billstate;
  //   mycontroller[13].text =
  //       selectedcust!.address![selectedBillAdress].billCountry;

  //   mycontroller[14].text =
  //       selectedcust!.address![selectedBillAdress].address1!;
  //   mycontroller[15].text =
  //       selectedcust!.address![selectedBillAdress].address2!;
  //   mycontroller[16].text =
  //       selectedcust!.address![selectedBillAdress].address3!;
  //   mycontroller[17].text = selectedcust!.address![selectedBillAdress].billCity;
  //   mycontroller[18].text =
  //       selectedcust!.address![selectedBillAdress].billPincode;
  //   mycontroller[19].text =
  //       selectedcust!.address![selectedBillAdress].billstate;
  //   mycontroller[20].text =
  //       selectedcust!.address![selectedBillAdress].billCountry;
  //   log("Mapped Customer Bill Address2 And Address3:${mycontroller[7].text}${mycontroller[8].text}${mycontroller[9].text}");
  //   log("Mapped Customer Shiped Address2 And Address3:${mycontroller[14].text}${mycontroller[15].text}${mycontroller[16].text}");
  //   notifyListeners();
  // }

  // updateCustomer(int i) async {
  //   // final Database db = await dbHelper.createDB();
  //   final Database db = (await DBHelper.getInstance())!;
  //   String aId = selectedcust!.address![selectedBillAdress].autoId.toString();
  //   log("aId------$aId");
  //   selectedcust!.cardCode = mycontroller[3].text;
  //   selectedcust!.phNo = mycontroller[4].text;
  //   selectedcust!.tarNo = mycontroller[5].text;
  //   selectedcust!.name = mycontroller[6].text;
  //   selectedcust!.email = mycontroller[21].text;
  //   log('Updated email:::' + selectedcust!.email.toString());
  //   selectedcust!.address![selectedBillAdress].address1 = mycontroller[7].text;
  //   selectedcust!.address![selectedBillAdress].address2 = mycontroller[8].text;
  //   selectedcust!.address![selectedBillAdress].address3 = mycontroller[9].text;
  //   selectedcust!.address![selectedBillAdress].billCity = mycontroller[10].text;
  //   selectedcust!.address![selectedBillAdress].billPincode =
  //       mycontroller[11].text;
  //   selectedcust!.address![selectedBillAdress].billstate =
  //       mycontroller[12].text;
  //   selectedcust!.address![selectedBillAdress].billCountry =
  //       mycontroller[13].text;

  //   selectedcust!.address![selectedBillAdress].address1 = mycontroller[14].text;
  //   selectedcust!.address![selectedBillAdress].address2 = mycontroller[15].text;
  //   selectedcust!.address![selectedBillAdress].address3 = mycontroller[16].text;
  //   selectedcust!.address![selectedBillAdress].billCity = mycontroller[17].text;
  //   selectedcust!.address![selectedBillAdress].billPincode =
  //       mycontroller[18].text;
  //   selectedcust!.address![selectedBillAdress].billstate =
  //       mycontroller[19].text;
  //   selectedcust!.address![selectedBillAdress].billCountry =
  //       mycontroller[20].text;

  //   String upCardCode = "${selectedcust!.cardCode}";

  //   await DBOperation.updateCustomerDetails(
  //     db,
  //     selectedcust!.cardCode.toString(),
  //     selectedcust!,
  //   );

  //   await DBOperation.updateAddressDetails(
  //       db, selectedcust!.cardCode.toString(), i, selectedcust!);
  //   log("Updated Cudtomer Address2 Address3:${mycontroller[14].text}${mycontroller[15].text}${mycontroller[16].text}");
  //   notifyListeners();
  // }

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

  calculateTons(int iss) {
    for (int iss = 0; iss < scanneditemData.length; iss++) {
      // if (scanneditemData[iss].uPackSize! >= 10) {
      //   scanneditemData[iss].pails = scanneditemData[iss].Qty!;
      // }
      // if (scanneditemData[iss].uTINSPERBOX! > 0 && scanneditemData[iss].uPackSize! < 10) {
      //   scanneditemData[iss].cartons = int.parse((scanneditemData[iss].Qty! / scanneditemData[iss].uTINSPERBOX!).toString());
      // }

      // if (scanneditemData[iss].uTINSPERBOX! > 0) {
      //   scanneditemData[iss].looseTins = double.parse((scanneditemData[iss].Qty! - (scanneditemData[iss].uTINSPERBOX! * scanneditemData[iss].cartons!)).toString());
      // }

      // if (scanneditemData[iss].uSpecificGravity! > 0) {
      //   if (scanneditemData[iss].uPackSize != 0) {
      //     scanneditemData[iss].tonnage = (scanneditemData[iss].uSpecificGravity! * scanneditemData[iss].uPackSize! * scanneditemData[iss].Qty!);
      //   } else {
      //     scanneditemData[iss].tonnage = (scanneditemData[iss].uPackSize! * scanneditemData[iss].Qty!);
      //   }
      // }
    }
  }

  calCulateDocVal(BuildContext context, ThemeData theme) {
    totalPayment = null;

//log("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
    TotalPayment totalPay = TotalPayment();
    totalPay.total = 0;
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.totalDue = 0.00;

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      //log("issss length:${scanneditemData.length}");
      double? mycontlaa = discountcontroller[iss].text.isNotEmpty
          ? double.parse(discountcontroller[iss].text.toString())
          : 0;
      scanneditemData[iss].Qty = int.parse(qtymycontroller[iss].text.isNotEmpty
          ? qtymycontroller[iss].text
          : "0");
      totalPay.total =
          totalPay.total! + int.parse(scanneditemData[iss].Qty.toString());
      //log('  totalPay.total   totalPay.total ::${totalPay.total}');
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

        // log("discount Amount:${scanneditemData[iss].discount.toString()}: ${scanneditemData[iss].basic.toString()}:${scanneditemData[iss].discountper!.toString()}");
        scanneditemData[iss].taxable =
            scanneditemData[iss].basic! - scanneditemData[iss].discount!;

        scanneditemData[iss].taxvalue =
            scanneditemData[iss].taxable! * scanneditemData[iss].TaxRate! / 100;

        scanneditemData[iss].netvalue =
            (scanneditemData[iss].basic! - scanneditemData[iss].discount!) +
                scanneditemData[iss].taxvalue!;

        // calculateLineVal(context, theme, iss);
        if (scanneditemData[iss].uPackSize! >= 10) {
          scanneditemData[iss].pails = scanneditemData[iss].Qty!;
          notifyListeners();
        }
        if (scanneditemData[iss].uTINSPERBOX! > 0) {
          // &&

          if (scanneditemData[iss].uPackSize! < 10) {
            scanneditemData[iss].cartons = int.parse(
                (scanneditemData[iss].Qty! / scanneditemData[iss].uTINSPERBOX!)
                    .round()
                    .toString());
            //log("scanneditemData[iss].cartons::${scanneditemData[iss].cartons}");
            notifyListeners();
          }
        }
        if (scanneditemData[iss].uTINSPERBOX! > 0) {
          int crts = scanneditemData[iss].cartons ?? 0;
          int utins = (scanneditemData[iss].uTINSPERBOX! * crts);
          scanneditemData[iss].looseTins =
              double.parse((scanneditemData[iss].Qty! - utins).toString());
          //log("scanneditemData[iss].looseTins::${scanneditemData[iss].looseTins}");
          notifyListeners();
        }
        if (scanneditemData[iss].uSpecificGravity! > 0) {
          if (scanneditemData[iss].uPackSize != 0) {
            notifyListeners();

            scanneditemData[iss].tonnage =
                (scanneditemData[iss].uSpecificGravity! *
                    scanneditemData[iss].uPackSize! *
                    scanneditemData[iss].Qty!);
            notifyListeners();
          } else {
            scanneditemData[iss].tonnage =
                (scanneditemData[iss].uPackSize! * scanneditemData[iss].Qty!);
            notifyListeners();
          }
          notifyListeners();
        }
        //log(" scanneditemData[iss].tonnage::::" +
        // scanneditemData[iss].tonnage.toString());
        int pailsss = scanneditemData[iss].pails ?? 0;
        int crts = scanneditemData[iss].cartons ?? 0;
        double loosetins = scanneditemData[iss].looseTins != null
            ? scanneditemData[iss].looseTins!
            : 0;

        scanneditemData[iss].totalPack = pailsss + crts + loosetins;
        //log(" scanneditemData[iss].totalPack::${scanneditemData[iss].totalPack}");
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
      FocusScopeNode focus = FocusScope.of(context);
      // log("TaxRate:${scanneditemData[iss].TaxRate}");
      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      totalPayment = totalPay;
      notifyListeners();
    }
    notifyListeners();
  }

  calculateLineVal(BuildContext context, ThemeData theme, int iss) {
    // for (int iss = 0; iss < scanneditemData.length; iss++) {
    // if (int.parse(mycontroller[iss].text.toString()) <
    //     scanneditemData[iss].Maxdiscount!) {
    String ans = (scanneditemData[iss].SellPrice! * scanneditemData[iss].Qty!)
        .toString();
    scanneditemData[iss].basic = double.parse(ans);
    scanneditemData[iss].discountper = discountcontroller[iss].text.isNotEmpty
        ? double.parse(discountcontroller[iss].text.toString())
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

    // }
    // else if ((int.parse(mycontroller[iss].text.toString()) > 100)) {
    //   showDialog(
    //       context: context,
    //       barrierDismissible: true,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //             contentPadding: EdgeInsets.all(0),
    //             content: Container(
    //               width: Screens.width(context) * 0.5,
    //               height: Screens.bodyheight(context) * 0.15,
    //               child: ContentWidgetMob(
    //                   theme: theme,
    //                   msg:
    //                       "Please enter the discount percentage is below 100"),
    //             ));
    //       }).then((value) {});
    // } else {
    //   showDialog(
    //       context: context,
    //       barrierDismissible: true,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //             contentPadding: EdgeInsets.all(0),
    //             content: Container(
    //               width: Screens.width(context) * 0.5,
    //               height: Screens.bodyheight(context) * 0.15,
    //               child: ContentWidgetMob(
    //                   theme: theme,
    //                   msg: "Discount is greater than Maximum Discount"),
    //             ));
    //       });
    // }
    // }
    notifyListeners();
  }

  // discountcalculate() {
  //   for (int iss = 0; iss < scanneditemData.length; iss++) {
  //     scanneditemData[iss].discountper =
  //         int.parse(mycontroller[iss].text.toString());
  //     calCulateDocVal();
  //     notifyListeners();
  //   }
  // }

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

  // double getSumTotalTax() {
  //   var getTax = scanneditemData.map((itemdet) => itemdet.TaxRate.toString());
  //   var getTaxSum = getTax.map(double.parse).toList();
  //   var toalTax = getTaxSum.reduce((a, b) => a + b);
  //   return toalTax;
  // }

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
    //bala sir//=(H10-N10)*I10/100=
    int totalQty = 0; // getNoOfQty();
    double totalPrice = 0; //getSumPrice();
    double tax = 0; //getSumTotalTax();
    double totalTax = 0;
    double disamt = getDiscount();
    for (int iss = 0; iss < scanneditemData.length; iss++) {
      totalPrice = double.parse(scanneditemData[iss].SellPrice.toString());
      totalQty = scanneditemData[iss].Qty!;
      tax = double.parse(scanneditemData[iss].TaxRate.toString());

      var basic = (totalQty * totalPrice);

      var taxable = basic - disamt;
      scanneditemData[iss].TaxType = (taxable * tax / 100).toString();
    }

    return totalTax;
  }

  double getDiscount() {
    double totaldisc = 0;
    int totalQty = 0; // getNoOfQty();
    double totalPrice = 0; //getSumPrice();
    double itemdisc = 0; //getSumTotalTax();

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      totalPrice = double.parse(scanneditemData[iss].SellPrice.toString());
      totalQty = scanneditemData[iss].Qty!;
      itemdisc = double.parse(scanneditemData[iss].Maxdiscount.toString());

      var basic = totalQty * totalPrice;
      scanneditemData[iss].Cost =
          int.parse((basic * itemdisc / 100).toString());

      // log("totaldisc:${scanneditemData[iss].Cost}");
    }
    return totaldisc;

    // for (int iss = 0; iss < scanneditemData.length; iss++) {
    //   qty = getNoOfQty();
    //   subtotalamt = qty *price;
    //   double totdiscount =
    //       double.parse(scanneditemData[iss].Maxdiscount.toString());
    //   totaldiscount = totaldiscount + ((totdiscount * subtotalamt) / 100);
    //   log("scanneditemData[iss].Maxdiscount::${scanneditemData[iss].Maxdiscount.toString()}");
    //   // discAmt = (totaldiscount * discount) / 100;
    // }
    // return totaldiscount;
  }

  /// pay ment way

  // addPaymentWay(
  //   PaymentWay payWay,
  // ) {
  //   paymentWay.add(PaymentWay(
  //     amt: payWay.amt,
  //     dateTime: payWay.dateTime,
  //     // dateTime: mycontroller[i].text,
  //     type: payWay.type,

  //   ));
  //   notifyListeners();
  // }
  // double getSumTotalPaiid2() {
  //   double toalPaid = 0.0;
  //   if (paymentWay.length > 0) {
  //     for (int i = 0; i < paymentWay.length; i++) {
  //       if (paymentWay[i].type != "Credit") {
  //         toalPaid = toalPaid + paymentWay[i].amt!;
  //       }
  //     }
  //  // log("toalPaidtoalPaid:::::" + toalPaid.toString());

  //     return toalPaid;
  //   } else {
  //     return 0.00;
  //   }
  // }
  double getSumTotalPaid2() {
    double toalPaid = 0.0;
    if (paymentWay2.isNotEmpty) {
      for (int i = 0; i < paymentWay2.length; i++) {
        if (paymentWay2[i].type != "Credit") {
          toalPaid = toalPaid + paymentWay2[i].amt!;
        }
      }
      // log("toalPaidtoalPaid:::::$toalPaid");

      return toalPaid;
    } else {
      return 0.00;
    }
    // if (paymentWay.length > 0) {
    //   var getTotalPaid = paymentWay.map((itemdet) => itemdet.amt.toString());
    //   var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
    //   var toalPaid = getTotalPaidSum.reduce((a, b) => a + b);
    //   return toalPaid;
    // } else {
    //   return 0.00;
    // }
  }

  double getSumTotalPaid() {
    double toalPaid = 0.0;
    // if (paymentWay.isNotEmpty) {
    //   for (int i = 0; i < paymentWay.length; i++) {
    //     if (paymentWay[i].type != "Credit") {
    //       toalPaid = toalPaid + paymentWay[i].amt!;
    //     }
    //   }
    //   log("toalPaidtoalPaid:::::$toalPaid");

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
    // print("totalDue :${totalPayment!.totalDue! -
    //       double.parse(getSumTotalPaid().toStringAsFixed(0))}");
    // double data  = totalPayment!.totalDue! -
    // double.parse(getSumTotalPaid().toStringAsFixed(0));
    // print("totalDue2 : ${data.toStringAsFixed(0)}");

    return totalPayment != null
        ? double.parse(
            totalPayment!.totalDue!.toStringAsFixed(0).replaceAll(',', ''))
        : 0.00;
  }

  addPayAmount(PaymentWay paymt, BuildContext context) {
    print("typeee: ${paymt.amt!.toStringAsFixed(0)}");
    double paymentamt = 0;
    if (paymentWay.isEmpty) {
      if (double.parse(totalPayment!.totalDue!
                  .toStringAsFixed(0)
                  .replaceAll(',', '')) >
              getSumTotalPaid() &&
          double.parse(getBalancePaid().toStringAsFixed(0)) >=
              double.parse(paymt.amt!.toStringAsFixed(0))) {
        // log("Amt111: ${paymt.amt}");
        addToPaymentWay(paymt, context);
        if (paymt.type == "Account Balance") {
          selectedcust!.accBalance = selectedcust!.accBalance! - paymt.amt!;
          notifyListeners();
        } else if (paymt.type == "Points Redemption") {
          selectedcust!.point =
              (double.parse(selectedcust!.point!.toString()) - paymt.amt!)
                  .toString();
        }
      } else {
        // log("_______:${totalPayment!.totalDue!.toStringAsFixed(0)}");
        // log("Am22221: ${paymt.amt}");

        // if (paymt.type == "Account Balance") {
        //   selectedcust!.accBalance = selectedcust!.accBalance! + paymt.amt!;
        //   notifyListeners();
        // } else if (paymt.type == "Points Redemption") {
        //   selectedcust!.point =
        //       (double.parse(selectedcust!.point!.toString()) + paymt.amt!)
        //           .toString();
        // }
        msgforAmount = 'Enter Correct amount..!!';
        // log("msgforAmount:::$msgforAmount");

        notifyListeners();
      }
    } else {
      if (double.parse(totalPayment!.totalDue!
                  .toStringAsFixed(0)
                  .replaceAll(',', '')) >
              getSumTotalPaid() &&
          double.parse(getBalancePaid().toStringAsFixed(0)) >=
              double.parse(paymt.amt!.toStringAsFixed(0))) {
        // log("ErroAmt3333: ${paymt.amt!.toStringAsFixed(0)}");
        addToPaymentWay(paymt, context);
      } else {
        // log("ErroAmtgetBalancePaid:${getBalancePaid()}");

        // log("ErroAmt4444: ${paymt.amt!.toStringAsFixed(0)}");
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

  // fullamt(String type, BuildContext context, ThemeData theme) {
  //   PaymentWay fpaymt = PaymentWay();

  //   mycontroller[22].text = totalPayment!.totalDue.toString();
  //   String fullam = getBalancePaid().toString().replaceAll(',', '');
  //   fpaymt.amt = double.parse(fullam.replaceAll(",", ""));
  //   fpaymt.dateTime = config.currentDate();
  //   fpaymt.type = type;
  //   if (fpaymt.amt != null) {
  //     int check = checkAlreadyUsed(fpaymt.type!);
  //     if (check == 0) {
  //       addPayAmount(fpaymt, context);
  //     } else if (check == 1) {
  //       showDialog(
  //           context: context,
  //           barrierDismissible: true,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //                 contentPadding: EdgeInsets.all(0),
  //                 content: Container(
  //                   width: Screens.width(context) * 0.5,
  //                   height: Screens.bodyheight(context) * 0.15,
  //                   child: ContentWidgetMob(
  //                       theme: theme,
  //                       msg:
  //                           "Already you used ${fpaymt.type!} mode of payment..!!"),
  //                 ));
  //           });
  //     }
  //   }
  // }

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

    if (formkeyy[i].currentState!.validate()) {
      // log('type: $type');

      if (type == 'Cash') {
        // log("Cash: ${mycontroller[22].text.toString().trim()}");

        paymt.amt = double.parse(mycontroller[22].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        cashpayment = paymt.amt;
        cashType = paymt.type!;
      } else if (type == 'Cheque') {
        // log("cheque: ${mycontroller[25].text.toString().trim()}");
        paymt.amt = double.parse(mycontroller[25].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.chequedate = config.alignDate2(mycontroller[24].text);
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
      } else if (type == 'Transfer') {
        // paymt.transref = mycontroller[30].text.toString();

        paymt.transtype = selectedType.toString();
        paymt.reference = mycontroller[30].text;
        paymt.amt = double.parse(mycontroller[31].text.toString().trim());
        paymt.dateTime = config.currentDate(); //mycontroller[30],
        paymt.type = type;
        transferType = paymt.type!;
        transpayment = paymt.amt;
        transrefff = paymt.reference!;
      } else if (type == 'Wallet') {
        walletType = type;
        paymt.reference = mycontroller[33].text;
        paymt.walletid = mycontroller[32].text;
        // paymt.walletref = mycontroller[33].text;
        paymt.wallettype = wallet;
        paymt.amt = double.parse(mycontroller[34].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      } else if (type == 'Account Balance') {
        paymt.type = type;
        paymt.amt = double.parse(mycontroller[36].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        accType = type;
        selectcustaccbal(paymt);
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
        paymt.recoverydate = config.alignDate2(mycontroller[44].text);
        paymt.reference = mycontroller[43].text.toString();
        paymt.amt = double.parse(mycontroller[45].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
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

    // log("paymt.amt: ${paymt.amt!.toStringAsFixed(0)}");

    if (paymt.amt != null) {
      int check = checkAlreadyUsed(paymt.type!);
      notifyListeners();

      if (check == 0) {
        // log("check: $check");

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
                          "Already you are used ${paymt.type!} mode of payment..!!")
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
    disableKeyBoard(context);
  }

  selectcustaccbal(PaymentWay paymt) {
    // PaymentWay paymt = PaymentWay();

    if (selectedcust!.accBalance! < 0) {
      selectedcust!.accBalance = selectedcust!.accBalance! + paymt.amt!;
      selectedcust55!.accBalance = selectedcust!.accBalance! + paymt.amt!;

      //log("  selectedcust!.accBalance11:;${selectedcust!.accBalance}");
    } else {
      selectedcust!.accBalance = selectedcust!.accBalance! - paymt.amt!;
      selectedcust55!.accBalance = selectedcust!.accBalance! + paymt.amt!;

      //log("  selectedcust!.accBalance2;;${selectedcust!.accBalance}");
      notifyListeners();
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
    if (selectedcust != null) {
      if (paymentWay[i].type == "Account Balance") {
        selectedcust!.accBalance =
            selectedcust!.accBalance! - paymentWay[i].amt!;
      } else if (paymentWay[i].type == "Points Redemption") {
        selectedcust!.point =
            (double.parse(selectedcust!.point.toString()) + paymentWay[i].amt!)
                .toString();
      }
    }
    paymentWay.removeAt(i);
    getSumTotalPaid();
    getBalancePaid();

    notifyListeners();
  }

  clearTextField() {
    OndDisablebutton = false;
    checkboxx = false;
    custseriesNo = null;
    loadingBtn = false;
    teriteriValue = null;
    paygrpValue = null;
    codeValue = null;
    loadingscrn = false;
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
    mycontroller[20].clear();
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
    mycontroller[46].clear();
    mycontroller[47].clear();
    mycontroller[49].clear();
    mycontroller[50].clear();
    mycontroller[51].clear();

    selectedType = null;
    notifyListeners();
  }

//checkout
  changecheckout(BuildContext context, ThemeData theme) async {
    if (schemebtnclk == true) {
      //log('GGGGGGGGGGGGGGGGGGG');
      await scehmeapiforckout(context, theme);
    }
    checkOut(context, theme);
  }

  scehmeapiforckout(BuildContext context, ThemeData theme) async {
    await salesOrderSchemeData();
    await callSchemeOrderAPi();
    await calculatescheme(context, theme);
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
        disableKeyBoard(context);
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
        disableKeyBoard(context);
        notifyListeners();
      });
    } else if (getBalancePaid() < 0) {
      // log("without put any payment way");
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
        saveValuesTODB("check out", context, theme);

        if (holddocentry.isNotEmpty) {
          await DBOperation.deleteHold(db, holddocentry).then((value) {
            holddocentry = '';
            onHoldFilter.clear();
            getdraftindex();
          });
        }
      }
    } else if (paymentWay.isEmpty) {
      // log("without put payment way");
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

  // checkOut(BuildContext context, ThemeData theme) async {
  //   final Database db = (await DBHelper.getInstance())!;

  //   OndDisablebutton = true;
  //   if (selectedcust == null) {
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
  //                   content: 'Choose customer..!!',
  //                   theme: theme,
  //                 )),
  //                 buttonName: null,
  //               ));
  //         }).then((value) {
  //       OndDisablebutton = false;
  //       disableKeyBoard(context);
  //       notifyListeners();
  //     });
  //   } else if (scanneditemData.isEmpty) {
  //     showDialog(
  //         context: context,
  //         barrierDismissible: true,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //               contentPadding: EdgeInsets.all(0),
  //               content: AlertBox(
  //                   payMent: 'Alert',
  //                   errormsg: true,
  //                   widget: Center(
  //                       child: ContentContainer(
  //                     content: 'Choose Product..!!',
  //                     theme: theme,
  //                   )),
  //                   buttonName: null));
  //         }).then((value) {
  //       OndDisablebutton = false;
  //       disableKeyBoard(context);
  //       notifyListeners();
  //     });
  // } else if (getBalancePaid() < 0) {
  //   log("without put any payment way");
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
  //                   content: 'Your balance amount is less than 0',
  //                   theme: theme,
  //                 )),
  //                 buttonName: null));
  //       }).then((value) {
  //     OndDisablebutton = false;
  //     notifyListeners();
  //   });
  // } else if (paymentWay.length > 0) {
  //     if ((totalPayment!.totalDue == getSumTotalPaid()) &&
  //         (getBalancePaid() == 0)) {
  //       // int? indx = await checkCredit("Credit");
  //       // if (indx != null) {
  //       saveValuesTODB("check out", context, theme);
  //       if (holddocentry.isNotEmpty) {
  //      // log('holddocentryholddocentry:$holddocentry');
  //         await DBOperation.deleteHold(db, holddocentry).then((value) {
  //           holddocentry = '';
  //           onHoldFilter.clear();
  //           getdraftindex();
  //         });
  //       }
  //       //   print('Same the balance and credit amt');
  //       // }
  //       //   else {
  //       //     print("without Credit and balance is not equal to 0");

  //       //     showDialog(
  //       //         context: context,
  //       //         barrierDismissible: true,
  //       //         builder: (BuildContext context) {
  //       //           return AlertDialog(
  //       //               contentPadding: EdgeInsets.all(0),
  //       //               content: AlertBox(
  //       //                   payMent: 'Alert',
  //       //                   errormsg: true,
  //       //                   widget: Center(
  //       //                       child: ContentContainer(
  //       //                     content: 'Pay the full amount..!!',
  //       //                     theme: theme,
  //       //                   )),
  //       //                   buttonName: null));
  //       //         }).then((value) {
  //       //       disableKeyBoard(context);
  //       //     }).then((value) {
  //       //       OndDisablebutton = false;
  //       //       notifyListeners();
  //       //     });
  //       //   }
  //       // }
  //       //   else {
  //       //     print("without Credit and balance is ==0");

  //       //     saveValuesTODB("check out", context, theme);
  //       //     if (holddocentry.isNotEmpty) {
  //       //    // log('holddocentryholddocentry:$holddocentry');
  //       //       await DBOperation.deleteHold(db, holddocentry).then((value) {
  //       //         holddocentry = '';
  //       //         onHoldFilter.clear();
  //       //         getdraftindex();
  //       //       });
  //       //     }
  //     }

  //   } else if (getBalancePaid() != 0 && paymentWay.isNotEmpty) {
  //  // log("without put any payment way");
  //     showDialog(
  //         context: context,
  //         barrierDismissible: true,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //               contentPadding: EdgeInsets.all(0),
  //               content: AlertBox(
  //                   payMent: 'Alert',
  //                   errormsg: true,
  //                   widget: Center(
  //                       child: ContentContainer(
  //                     content: 'Pay the full amount..!!',
  //                     theme: theme,
  //                   )),
  //                   buttonName: null));
  //         }).then((value) {
  //       OndDisablebutton = false;
  //       notifyListeners();
  //     });
  //   }
  //   else if (( totalPayment!.totalDue != getSumTotalPaid()) &&
  //         (getBalancePaid() != 0)) {
  //  // log("without put any payment way");
  //     showDialog(
  //         context: context,
  //         barrierDismissible: true,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //               contentPadding: EdgeInsets.all(0),
  //               content: AlertBox(
  //                   payMent: 'Alert',
  //                   errormsg: true,
  //                   widget: Center(
  //                       child: ContentContainer(
  //                     content: 'Pay the full amount..!!',
  //                     theme: theme,
  //                   )),
  //                   buttonName: null));
  //         }).then((value) {
  //       OndDisablebutton = false;
  //       notifyListeners();
  //     });
  //   }

  //   else if (getBalancePaid() != 0 && paymentWay.isEmpty) {
  //  // log("without put any payment way");
  //     showDialog(
  //         context: context,
  //         barrierDismissible: true,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //               contentPadding: EdgeInsets.all(0),
  //               content: AlertBox(
  //                   payMent: 'Alert',
  //                   errormsg: true,
  //                   widget: Center(
  //                       child: ContentContainer(
  //                     content: 'Pay the full amount..!!',
  //                     theme: theme,
  //                   )),
  //                   buttonName: null));
  //         }).then((value) {
  //       OndDisablebutton = false;
  //       notifyListeners();
  //     });
  //   }
  //   OndDisablebutton = false;
  //   notifyListeners();
  // }

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

  salesOrderClicked(BuildContext context, ThemeData theme) {
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
        disableKeyBoard(context);
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
        disableKeyBoard(context);
      });
    }
    // else if ((totalPayment!.totalDue! != getSumTotalPaid()) &&
    //     (getBalancePaid() != 0)) {
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
    // }
    else {
      // SaveSalesOrder();
      saveValuesTODB("save as order", context, theme);

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
      //                 content: 'Sales order successfully saved..!!',
      //                 theme: theme,
      //               )),
      //               buttonName: null));
      //     }).then((value) {
      // });
      notifyListeners();
    }
  }

  filterListOnHold(String v) {
    if (v.isNotEmpty) {
      onHoldFilter = salesmodl
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.custName!.toLowerCase().contains(v.toLowerCase()) ||
              e.invoceDate!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      onHoldFilter = salesmodl;
      notifyListeners();
    }
  }
//  else if ((totalPayment!.totalDue! != getSumTotalPaid()) &&
  //     (getBalancePaid() != 0)) {
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
  // }
// else{
//  if ((totalPayment!.totalDue! == getSumTotalPaid()) &&
//         (getBalancePaid() == 0)) {
//             print("check the  amt of balance is 0");

//       // saveValuesTODB("check out", context, theme);
//     }

//     else {
//     // if (totalPayment!.totalDue! != getSumTotalPaid()) {
//       for (int ik = 0; ik < paymentWay.length; ik++) {
//         if (paymentWay[ik].type == "Credit") {
//           print("PPPPPP111::" + paymentWay[ik].amt.toString());
//           print("PPPPPP222::" + getBalancePaid().toString());

//           if (getBalancePaid().toStringAsFixed(0) ==
//               paymentWay[ik].amt!.toStringAsFixed(0)) {
//             print("check the same amt of balance and credit");

//             // saveValuesTODB("check out", context, theme);
//             notifyListeners();
//           }
//         }

  //  else {
  //     showDialog(
  //         context: context,
  //         barrierDismissible: true,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //               contentPadding: EdgeInsets.all(0),
  //               content: AlertBox(
  //                   payMent: 'Alert',
  //                   errormsg: true,
  //                   widget: Center(
  //                       child: ContentContainer(
  //                     content: 'Pay the full amount..!!',
  //                     theme: theme,
  //                   )),
  //                   buttonName: null));
  //         });

  onHoldClicked(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    OndDisablebutton = true;

//log("111111111111");
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
        disableKeyBoard(context);
        OndDisablebutton = false;
      });
    } else {
      selectedcust2 = null;
      scanneditemData2.clear();
      paymentWay2.clear();
      totalPayment2 = null;
      saveValuesTODB("hold", context, theme);
      if (holddocentry.isNotEmpty) {
        // log('holddocentryholddocentry:$holddocentry');
        await DBOperation.deleteHold(db, holddocentry).then((value) {
          holddocentry = '';
          onHoldFilter.clear();
          getdraftindex();
          // log('datatatatatatata deleleleleleelle ');
        });
      }
      notifyListeners();
    }
    notifyListeners();
  }

//Payment Mode Buttons
  // String? creditDate;
  // String? get getcreditDate => creditDate;
  // String? formattedDate;
  // String? get getformattedDate => formattedDate;

  getDate(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      // print(pickedDate);
      datetype = DateFormat('yyyy-MM-dd').format(pickedDate);
      mycontroller[24].text = config.alignDate(datetype!);
      mycontroller[44].text = config.alignDate(datetype!);
      // print(datetype);
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
      // print(pickedDate);
      datetype = DateFormat('yyyy-MM-dd').format(pickedDate);
      mycontroller[24].text = config.alignDate(datetype!);
      mycontroller[44].text = config.alignDate(datetype!);
      // print(datetype);
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
      availbal = availbal + adjamtt;
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
  // adjamt(BuildContext context, int i, ThemeData theme) {
  //   double availbal = selectedcust!.accBalance!;
  //   double adjamtt = double.parse(mycontroller[36].text);
  //   // if (availbal >= adjamtt) {
  //   addEnteredAmtType('Account Balance', context, 7, theme);
  //   // }
  //   // else {
  //   //   msgforAmount = "Adjustment amount is greater than available amount";
  //   //   mycontroller[36].text = '';
  //   // }
  //   notifyListeners();
  // }

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

  double cashAmt = 00.00;
  double get getcashAmt => cashAmt;
  bool boolCash = false;
  bool get getboolCash => boolCash;
  String? paymentterm;
  String? coupon;
  String? wallet;
  String? selectedType;
  bool hintcolor = false;
  bool get gethintcolor => hintcolor;
  double? tottpaid;
  String? baltopay;
  // String? get getselectedType => selectedType;
  List<String> transType = [
    'NEFT',
    'RTGS',
    'IMPS',
  ];
  List<String> get gettransType => transType;

  List payTerminal = [
    "Terminal - 1",
    "Terminal - 2",
    "Terminal - 3",
    "Terminal - 4",
    // "HDFC Machine",
    // 'Pinelabs Machine - 1',
    // 'Pinelabs - Accessories',
    // 'Pinelabs - 2nd Counter'
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

  getdraft(int ji) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.getSalesHeadHoldvalueDB(db);

    remarkcontroller3.text = "";
    List<StocksnapModelData> scannData = [];
    List<PaymentWay> payment = [];
    salesmodl.clear();
    onHoldFilter = [];
    List<Map<String, Object?>>? getDBholdSalesLine =
        await DBOperation.holdSalesLineDB(
            db, int.parse(getDBholddata1[ji]['docentry'].toString()));

    List<Map<String, Object?>> getDBholdSalespay =
        await DBOperation.getHoldSalesPayDB(
            db, int.parse(getDBholddata1[ji]['docentry'].toString()));

    for (int kk = 0; kk < getDBholdSalespay.length; kk++) {
      if (getDBholddata1[ji]['docentry'] == getDBholdSalespay[kk]['docentry']) {
        payment.add(PaymentWay(
          amt: double.parse(getDBholdSalespay[kk]['rcamount'].toString()),
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
          couponcode: "",
          coupontype: "",
          discountcode: getDBholdSalespay[kk]['discountcode'].toString(),
          discounttype: getDBholdSalespay[kk]['discounttype'].toString(),
          recoverydate: getDBholdSalespay[kk]['recoverydate'].toString(),
          redeempoint: getDBholdSalespay[kk]['redeempoint'].toString(),
          availablept: getDBholdSalespay[kk]['availablept'].toString(),
          remarks: getDBholdSalespay[kk]['remarks'].toString(),
          transtype: getDBholdSalespay[kk]['transtype'].toString(),
          walletid: getDBholdSalespay[kk]['walletid'].toString(),
          wallettype: getDBholdSalespay[kk]['wallettype'].toString(),
        ));
      }
      notifyListeners();
    }
    for (int ik = 0; ik < getDBholdSalesLine.length; ik++) {
      // log("getDBholdSalesLine.length:${getDBholdSalesLine.length}");
      if (getDBholddata1[ji]['docentry'] ==
          getDBholdSalesLine[ik]['docentry']) {
        print(
            "${getDBholddata1[ji]['docentry'].toString()}::${getDBholdSalesLine[ik]['docentry']}");
        scannData.add(StocksnapModelData(
            basic: getDBholdSalesLine[ik]['basic'] != null
                ? double.parse(getDBholdSalesLine[ik]['basic'].toString())
                : 00,
            netvalue: getDBholdSalesLine[ik]['netlinetotal'] != null
                ? double.parse(
                    getDBholdSalesLine[ik]['netlinetotal'].toString())
                : null,
            TransID: int.parse(getDBholdSalesLine[ik]['docentry'].toString()),
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
            MRP: 0,
            SellPrice: double.parse(getDBholdSalesLine[ik]['price'].toString()),
            Cost: 0,
            discount: getDBholdSalesLine[ik]['discperunit'] != null
                ? double.parse(getDBholdSalesLine[ik]['discperunit'].toString())
                : 00,
            taxvalue: getDBholdSalesLine[ik]['taxtotal'] != null
                ? double.parse(getDBholdSalesLine[ik]['taxtotal'].toString())
                : 00,
            TaxRate: double.parse(getDBholdSalesLine[ik]['taxrate'].toString()),
            TaxType: getDBholdSalesLine[ik]['taxtype'].toString(),
            Maxdiscount: getDBholdSalesLine[ik]['maxdiscount'].toString(),
            discountper: getDBholdSalesLine[ik]['discperc'] == null
                ? 0.0
                : double.parse(getDBholdSalesLine[ik]['discperc'].toString()),
            basedocentry: getDBholdSalesLine[ik]['basedocentry'] != null
                ? getDBholdSalesLine[ik]['basedocentry'].toString()
                : "",
            baselineid: getDBholdSalesLine[ik]['baselineID'] != null
                ? getDBholdSalesLine[ik]['baselineID'].toString()
                : "",
            createdUserID: '',
            createdateTime: '',
            lastupdateIp: '',
            purchasedate: '',
            snapdatetime: '',
            specialprice: 0,
            updatedDatetime: '',
            updateduserid: '',
            liter: getDBholdSalesLine[ik]['liter'] != null
                ? double.parse(getDBholdSalesLine[ik]['liter'].toString())
                : 00,
            weight: getDBholdSalesLine[ik]['weight'] != null
                ? double.parse(getDBholdSalesLine[ik]['weight'].toString())
                : 00)); //discperc
        totquantity = getDBholdSalesLine[ik]['quantity'].toString();
        discountamt = getDBholdSalesLine[ik]['discperc'] != null
            ? double.parse(getDBholdSalesLine[ik]['discperc'].toString())
            : 0;
      }
      // log("scannDatascannDatascannDatascannData docentry:${scannData.length}");
      // log("Line Total && basic Total :${double.parse(getDBholdSalesLine[ik]['basic'].toString())}");
      notifyListeners();
    }

    SalesModel salesM = SalesModel(
        objname: getDBholddata1[ji]['objname'].toString(),
        objtype: getDBholddata1[ji]['objtype'].toString(),
        doctype: getDBholddata1[ji]['doctype'].toString(),
        docentry: int.parse(getDBholddata1[ji]['docentry'].toString()),
        custName: getDBholddata1[ji]['customername'].toString(),
        phNo: getDBholddata1[ji]['customerphono'].toString(),
        cardCode: getDBholddata1[ji]['customercode'].toString(),
        accBalance: getDBholddata1[ji]['customeraccbal'].toString(),
        point: getDBholddata1[ji]['customerpoint'].toString(),
        tarNo: getDBholddata1[ji]['taxno'].toString(),
        email: getDBholddata1[ji]['customeremail'].toString(),
        invoceDate: getDBholddata1[ji]['createdateTime'].toString(),
        invoiceNum: getDBholddata1[ji]['documentno'].toString(),
        address: [
          Address(
              address1: getDBholddata1[ji]['billaddressid'].toString(),
              //
              billCity: getDBholddata1[ji]['city'].toString(),
              billCountry: getDBholddata1[ji]['country'].toString(),
              billPincode: getDBholddata1[ji]['pinno'].toString(),
              billstate: getDBholddata1[ji]['state'].toString())
        ],
        totalPayment: TotalPayment(
          balance: getDBholddata1[ji]['baltopay'] == null
              ? 0.00
              : double.parse(getDBholddata1[ji]['baltopay'].toString()),

          discount2: getDBholddata1[ji]['docdiscamt'] == null
              ? 0.00
              : double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
          // double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
          discount: getDBholddata1[ji]['docdiscamt'] == null
              ? 0.00
              : double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
          totalTX: double.parse(getDBholddata1[ji]['taxamount'] == null
              ? '0'
              : getDBholddata1[ji]['taxamount'].toString().replaceAll(',', '')),

          subtotal: double.parse(getDBholddata1[ji]['docbasic'] == null
              ? '0'
              : getDBholddata1[ji]['docbasic']
                  .toString()
                  .replaceAll(',', '')), //doctotal

          total: totalPayment == null
              ? 0
              : int.parse(totalPayment!.total!.toString()),
          totalDue: double.parse(getDBholddata1[ji]['doctotal'] == null
              ? '0'
              : getDBholddata1[ji]['doctotal'].toString().replaceAll(',', '')),
          totpaid: double.parse(getDBholddata1[ji]['amtpaid'] == null
              ? '0'
              : getDBholddata1[ji]['amtpaid'].toString().replaceAll(',', '')),
        ),
        item: scannData,
        paymentway: payment);

    notifyListeners();

    salesmodl.add(salesM);

//log("salesmodl.item.length:${salesM.item!.length}");
    notifyListeners();
    // // }
    // log("getSalesHeadHoldvalueDBgetSalesHeadHoldvalueDB:${getDBholddata1.length}");
    // log("salesmodl.length:${salesmodl.length}");

    onHoldFilter = salesmodl;
//log("onHoldFilter.length:${onHoldFilter.length}");
    notifyListeners();
  }

  viewSalesheader() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.getSalesHeadHoldvalueDB(db);
    notifyListeners();
  }

  getcustaddresslist() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust!.cardCode!);
    selectedcust!.address = [];

    print("MMMMMMMMM:::${csadresdataDB.length}");

    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (selectedcust!.cardCode == csadresdataDB[ia]['custcode'].toString()) {
        selectedcust!.address!.add(Address(
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
      notifyListeners();
    }
//log("  selectedcust!.address length:${selectedcust!.address!.length}");
    notifyListeners();
  }

  mapHoldValues(BuildContext context, ThemeData theme, int ih) async {
    scanneditemData = [];
    final Database db = (await DBHelper.getInstance())!;
    int? totqty;
    loadingscrn = true;
    paymentWay = [];
    cpyfrmso = '';
    cancelbtn = false;
    remarkcontroller3.text = "";
//log("salesmodl[ih] docentry::${salesmodl[ih].docentry}");
    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.getSalesHeadHoldvalueddDB(
            db, salesmodl[ih].docentry.toString());
    List<Map<String, Object?>> getcustaddd =
        await DBOperation.addgetCstmMasAddDB(
            db, salesmodl[ih].cardCode.toString());
    List<Map<String, Object?>> custData =
        await DBOperation.getCstmMasDatabyautoid(
            db, salesmodl[ih].cardCode.toString());
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

    // selectedcust = selectedcust2;
    for (int ik = 0; ik < getDBholddata1.length; ik++) {
      remarkcontroller3.text = getDBholddata1[ik]['remarks'].toString();
      for (int i = 0; i < getcustaddd.length; i++) {
        // log("step3");

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
          }
        }
        // log("step6");

        // log("getholddata[i]['shipaddresid'].toString()::" +
        //     getholddata[ik]['shipaddresid'].toString());
        // if (getcustaddd[i]['addresstype'].toString() == 'S') {
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
      // log("step8");
    }

    for (int i = 0; i < salesmodl[ih].item!.length; i++) {
      scanneditemData.add(StocksnapModelData(
          uPackSize: salesmodl[ih].item![i].uPackSize ?? 0,
          uTINSPERBOX: salesmodl[ih].item![i].uTINSPERBOX ?? 0,
          uSpecificGravity: salesmodl[ih].item![i].uSpecificGravity ?? 0,
          Maxdiscount: salesmodl[ih].item![i].Maxdiscount,
          discountper: salesmodl[ih].item![i].discountper,
          Branch: salesmodl[ih].item![i].Branch,
          ItemCode: salesmodl[ih].item![i].ItemCode,
          ItemName: salesmodl[ih].item![i].ItemName,
          SerialBatch: salesmodl[ih].item![i].SerialBatch,
          Qty: salesmodl[ih].item![i].Qty,
          OpenQty: salesmodl[ih].item![i].OpenQty,
          MRP: salesmodl[ih].item![i].MRP,
          SellPrice: salesmodl[ih].item![i].SellPrice,
          TaxRate: salesmodl[ih].item![i].TaxRate,
          weight: salesmodl[ih].item![i].weight,
          liter: salesmodl[ih].item![i].liter));
      notifyListeners();

      // log("scanneditemData[i].Qty55::" + salesmodl[ih].item![i].Qty.toString());
    }
    // scanneditemData = salesmodl[ih].item!;
    // paymentWay = salesmodl[ih].paymentway!;

    for (int ij = 0; ij < salesmodl[ih].paymentway!.length; ij++) {
      paymentWay.add(PaymentWay(
          amt: salesmodl[ih].paymentway![ij].amt!,
          dateTime: salesmodl[ih].paymentway![ij].dateTime,
          reference: salesmodl[ih].paymentway![ij].reference ?? '',
          type: salesmodl[ih].paymentway![ij].type,
          cardApprno: salesmodl[ih].paymentway![ij].cardApprno,
          cardref: salesmodl[ih].paymentway![ij].cardref,
          cardterminal: salesmodl[ih].paymentway![ij].cardterminal,
          chequedate: salesmodl[ih].paymentway![ij].chequedate,
          chequeno: salesmodl[ih].paymentway![ij].chequeno,
          discountcode: salesmodl[ih].paymentway![ij].discountcode,
          discounttype: salesmodl[ih].paymentway![ij].discounttype,
          recoverydate: salesmodl[ih].paymentway![ij].recoverydate,
          redeempoint: salesmodl[ih].paymentway![ij].redeempoint,
          availablept: salesmodl[ih].paymentway![ij].availablept,
          remarks: salesmodl[ih].paymentway![ij].remarks,
          transtype: salesmodl[ih].paymentway![ij].transtype,
          walletid: salesmodl[ih].paymentway![ij].walletid,
          wallettype: salesmodl[ih].paymentway![ij].wallettype));
      notifyListeners();
    }

//log("scanneditemData.length::${scanneditemData.length}");

    for (int ib = 0; ib < scanneditemData.length; ib++) {
      scanneditemData[ib].TransID = ib;
      qtymycontroller[ib].text = scanneditemData[ib].Qty!.toString();
      discountcontroller[ib].text = scanneditemData[ib].discountper!.toString();

      // log("scanneditemData[i].Qty::" + scanneditemData[ib].Qty.toString());
      notifyListeners();
    }
    calCulateDocVal(context, theme);
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
    holddocentry = salesmodl[ih].docentry.toString();
    notifyListeners();
    // await DBOperation.deleteHold(db, salesmodl[ih].docentry.toString())
    //     .then((value) {
    //   getcustaddresslist();

    //   onHoldFilter.clear();
    //   getdraftindex();
    // });
    notifyListeners();
  }

  calculatescheme(BuildContext context, ThemeData theme) async {
    double discount = 0;
    // log('discount1');

    for (int ik = 0; ik < resSchemeDataList.length; ik++) {
      discount = 0;

      for (int i = 0; i < scanneditemData.length; i++) {
        // print('discount4::${scanneditemData[i].TransID}');

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

//log("schemeData::${schemeData.length}");
    for (int i = 0; i < scanneditemData.length; i++) {
      // discountcontroller[i].text=0.toString();
      //log('discount4::${scanneditemData[i].TransID}');

      discountcontroller[i].text = 0.0.toString();
      //log('discount5::${discountcontroller[i].text}');

      notifyListeners();
    }
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
          catchmsg.add("Stock details2: ${value.message!}");
          notifyListeners();
        }
      } else if (value.statuscode >= 400 && value.statuscode <= 410) {
        // exception = value.exception!;
        catchmsg.add("Stock details3: ${value.exception!}");
      } else {
        // exception = value.exception!;
        catchmsg.add("Stcok details4: ${value.exception!}");
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

  salesorderheader() {
    for (int i = 0; i < soSalesmodl.length; i++) {
      soSalesmodl[i].invoiceClr = 0;
      soSalesmodl[i].checkBClr = false;
      notifyListeners();
    }
  }

  selctIndex(int i) {
    for (int ix = 0; ix < soData.length; ix++) {
      soData[ix].checkBClr = false;
    }
    selectIndex = i;
    if (selectIndex == null) {
    } else if (selectIndex == i) {
      tickListBox(i);
    notifyListeners();

    }
    notifyListeners();
  }

  bool checktick = false;

  Future<bool> getmockdata(int i) {
    return Future.value(true);
    notifyListeners();
  }

  Future<bool> getstatus(int i) async {
    bool stringfuture = await getmockdata(i);
    bool message = stringfuture;
    notifyListeners();

    return (message);
  }

  tickListBox(int i) async {
    soData[i].checkBClr = await getstatus(i);
    notifyListeners();
  }

  SOitemDeSelect(int i) {
    textError = '';

    if (soData[i].invoiceClr == 0 && soData[i].checkBClr == false) {
      soData[i].invoiceClr = 1;
      soData[i].checkBClr = true;
      notifyListeners();
    } else if (soData[i].invoiceClr == 1 && soData[i].checkBClr == true) {
      soData[i].invoiceClr = 0;
      soData[i].checkBClr = false;

      // totalduepay = totalduepay! - scanneditemData[i].amount!;
      notifyListeners();
    }

    notifyListeners();
  }

  clickcancelbtn(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    if (sapDocentry!.isNotEmpty) {
      List<Map<String, Object?>> getsalheadertosalr =
          await DBOperation.salesInvtoRetCancellQuery(db, cancelDocnum);
      List<Map<String, Object?>> getsalheadertoRec =
          await DBOperation.salesInvtoReceiptcancel(db, cancelDocnum);

      if (getsalheadertosalr.isNotEmpty) {
        if (getsalheadertosalr[0]['basedocnum'].toString() == cancelDocnum) {
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
                            'This document is already converted into sales return',
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
      } else if (getsalheadertoRec.isNotEmpty) {
        if (getsalheadertoRec[0]['transdocnum'].toString() == cancelDocnum) {
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
                            'This document is already converted into Payment Receipt',
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
        await sapLoginApi(context);
        await callSerlaySalesQuoAPI(context, theme);
        await callSerlaySalesCancelQuoAPI(context, theme);
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
      notifyListeners();
    }
  }

  sapLoginApi(BuildContext context) async {
    final pref2 = await pref;

    await PostInvoiceLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          print("sessionID: ${value.sessionId}");
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
//log("  AppConstant.sapSessionID::${AppConstant.sapSessionID}");
    notifyListeners();
  }

  callSerlaySalesQuoAPI(BuildContext context, ThemeData theme) async {
    // List<Map<String, Object?>> getqstatusdata =
    //     await DBOperation.getSaleQuorQstatusDB(db);
    cancelbtn = false;
//log("sapDocentrysapDocentrysapDocentry:::$sapDocentry");

    await SerlaySalesInvoiceAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.documentLines.isNotEmpty) {
          sapInvocieModelData = value.documentLines;

          //log("sapInvocieModelDatasapInvocieModelData::${sapInvocieModelData[0].lineStatus}");
          custserieserrormsg = '';
        } else {
          //log("Error11");

          // custserieserrormsg = value.message!.toString();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
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

        // custserieserrormsg = value.message!.toString();
      }
    });
  }

  callSerlaySalesCancelQuoAPI(BuildContext context, ThemeData theme) async {
    custserieserrormsg = '';
    final Database db = (await DBHelper.getInstance())!;
    if (sapInvocieModelData.isNotEmpty) {
      if (sapInvocieModelData[0].lineStatus == "bost_Open") {
        //:bost_Close
        await SerlayInvoiceCancelAPI.getData(sapDocentry.toString())
            .then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 210) {
            cancelbtn = false;

            //log("sapInvocieModelDatasapInvocieModelData::${sapInvocieModelData[0].lineStatus}");
            await DBOperation.updateSaleInvoiceclosedocsts(
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
              paymentWay2.clear();
              selectedcust25 = null;
              notifyListeners();
            });
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
                          content: value.exception!.message!.value.toString(),
                          theme: theme,
                        )),
                        buttonName: null,
                      ));
                }).then((value) {
              sapDocentry = '';
              sapDocuNumber = '';
              selectedcust2 = null;
              scanneditemData2.clear();
              selectedcust25 = null;
              paymentWay2.clear();

              notifyListeners();
            });
            //log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
            notifyListeners();
          } else {
            //log("Error33");

            // custserieserrormsg = value.message!.toString();
          }
        });
      } else if (sapInvocieModelData[0].lineStatus == "bost_Close") {
        //:bost_Close
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
          scanneditemData2.clear();
          selectedcust25 = null;
          paymentWay2.clear();
          notifyListeners();
        });
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future callgetSOValue() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getheaderData =
        await DBOperation.getSalesOrdervalueDB(db);
    soScanItem = [];
    soSalesmodl = [];
    List<StocksnapModelData> scannData = [];

    if (selectedcust != null) {
      soSalesmodl = [];
      // print("getheaderData sapDocentry::${getheaderData[0]['sapDocentry']}");
      for (int ik = 0; ik < getheaderData.length; ik++) {
        if (selectedcust!.cardCode.toString() ==
            getheaderData[ik]['customercode'].toString()) {
          if (getheaderData[ik]['sapDocentry'] != null) {
            List<Map<String, Object?>> lineData =
                await DBOperation.getSalesOrderLinevalueDB(
                    db, getheaderData[ik]['docentry'].toString());
            for (int i = 0; i < lineData.length; i++) {
              // log("LineData: {} ${lineData.length}");
              if (getheaderData[ik]['docentry'].toString() ==
                  lineData[i]['docentry'].toString()) {
                // qtymycontroller[i].text = lineData[i]['quantity'].toString();
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
              checkBClr: false,
              invoiceClr: 0,
              invoceAmount:
                  double.parse(getheaderData[ik]['doctotal'].toString()),
              invoceDate: config
                  .alignDate(getheaderData[ik]['createdateTime'].toString()),
              invoiceNum: getheaderData[ik]['documentno'].toString(),
              sapOrderNum: getheaderData[ik]['sapDocNo'].toString(),
              address: [
                Address(
                    address1: getheaderData[ik]['billaddressid'].toString(),
                    billCity: getheaderData[ik]['city'].toString(),
                    billCountry: getheaderData[ik]['country'].toString(),
                    billPincode: getheaderData[ik]['pinno'].toString(),
                    billstate: getheaderData[ik]['state'].toString())
              ],
              totalPayment: TotalPayment(
                balance: getheaderData[ik]['baltopay'] == null
                    ? 0.00
                    : double.parse(getheaderData[ik]['baltopay'].toString()),

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
            // log(" double.parse(getDBholddata1[ji]['docdiscamt']):${getheaderData[ik]['docdiscamt']}");

            soSalesmodl.add(salesM);
            soTotal = double.parse(getheaderData[ik]['baltopay'].toString());
            notifyListeners();
          }
        }
        notifyListeners();
      }
    }
    // else {
    //   soSalesmodl = [];

    //   for (int j = 0; j < getheaderData.length; j++) {
    //     List<Map<String, Object?>> lineDataa = await DBOperation.getSalesOrderLinevalueDB(db, getheaderData[j]['docentry'].toString());
    //     for (int i = 0; i < lineDataa.length; i++) {
    //       if (getheaderData[j]['docentry'].toString() == lineDataa[i]['docentry'].toString()) {
    //         // qtymycontroller[i].text = lineDataa[i]['quantity'].toString();
    //         // log("qtymycontroller[i].textqtymycontroller[i].text:"+qtymycontroller[i].text.toString());
    //         scannData.add(StocksnapModelData(
    //             basedocentry: lineDataa[i]['docentry'].toString(),
    //             baselineid: lineDataa[i]['lineID'].toString(),
    //             basic: lineDataa[i]['basic'] != null ? double.parse(lineDataa[i]['basic'].toString()) : 00,
    //             netvalue: lineDataa[i]['netlinetotal'] != null ? double.parse(lineDataa[i]['netlinetotal'].toString()) : null,
    //             TransID: int.parse(lineDataa[i]['docentry'].toString()),
    //             Branch: lineDataa[i]['branch'].toString(),
    //             ItemCode: lineDataa[i]['itemcode'].toString(),
    //             ItemName: lineDataa[i]['itemname'].toString(),
    //             SerialBatch: lineDataa[i]['serialbatch'].toString(),
    //             OpenQty: int.parse(lineDataa[i]['quantity'].toString()),
    //             Qty: lineDataa[i]['Balanceqty'] != null ? int.parse(lineDataa[i]['Balanceqty'].toString()) : int.parse(lineDataa[i]['quantity'].toString()),
    //             InDate: lineDataa[i][''].toString(),
    //             InType: lineDataa[i][''].toString(),
    //             VenCode: lineDataa[i][''].toString(),
    //             VenName: lineDataa[i][''].toString(),
    //             MRP: 0,
    //             SellPrice: double.parse(lineDataa[i]['price'].toString()),
    //             Cost: 0,
    //             discount: lineDataa[i]['discperunit'] != null ? double.parse(lineDataa[i]['discperunit'].toString()) : 00,
    //             taxvalue: lineDataa[i]['taxtotal'] != null ? double.parse(lineDataa[i]['taxtotal'].toString()) : 00,
    //             TaxRate: double.parse(lineDataa[i]['taxrate'].toString()),
    //             TaxType: lineDataa[i]['taxtype'].toString(),
    //             Maxdiscount: lineDataa[i]['maxdiscount'].toString(),
    //             discountper: lineDataa[i]['discperc'] == null ? 0.0 : double.parse(lineDataa[i]['discperc'].toString()),
    //             createdUserID: '',
    //             createdateTime: lineDataa[i]['createdateTime'].toString(),
    //             lastupdateIp: '',
    //             purchasedate: '',
    //             snapdatetime: '',
    //             specialprice: 0,
    //             updatedDatetime: '',
    //             updateduserid: '',
    //             liter: lineDataa[i]['liter'] == null ? 0.0 : double.parse(lineDataa[i]['liter'].toString()),
    //             weight: lineDataa[i]['weight'] == null ? 0.0 : double.parse(lineDataa[i]['weight'].toString())));
    //       }
    //     }

    //     SalesModel salesM = SalesModel(
    //       objname: getheaderData[j]['objname'].toString(),
    //       objtype: getheaderData[j]['objtype'].toString(),
    //       doctype: getheaderData[j]['doctype'].toString(),
    //       docentry: int.parse(getheaderData[j]['docentry'].toString()),
    //       custName: getheaderData[j]['customername'].toString(),
    //       phNo: getheaderData[j]['customerphono'].toString(),
    //       cardCode: getheaderData[j]['customercode'].toString(),
    //       accBalance: getheaderData[j]['customeraccbal'].toString(),
    //       point: getheaderData[j]['customerpoint'].toString(),
    //       tarNo: getheaderData[j]['taxno'].toString(),
    //       email: getheaderData[j]['customeremail'].toString(),
    //       invoceAmount: double.parse(getheaderData[j]['doctotal'].toString()),
    //       invoceDate: config.alignDate(getheaderData[j]['createdateTime'].toString()),
    //       invoiceNum: getheaderData[j]['documentno'].toString(),
    //       address: [Address(address1: getheaderData[j]['billaddressid'].toString(), billCity: getheaderData[j]['city'].toString(), billCountry: getheaderData[j]['country'].toString(), billPincode: getheaderData[j]['pinno'].toString(), billstate: getheaderData[j]['state'].toString())],
    //       totalPayment: TotalPayment(
    //         balance: getheaderData[j]['baltopay'] == null ? 0.00 : double.parse(getheaderData[j]['baltopay'].toString()),

    //         discount2: getheaderData[j]['docdiscamt'] == null ? 0.00 : double.parse(getheaderData[j]['docdiscamt'].toString()),
    //         discount: getheaderData[j]['docdiscamt'] == null ? 0.00 : double.parse(getheaderData[j]['docdiscamt'].toString()),
    //         totalTX: double.parse(getheaderData[j]['taxamount'] == null ? '0' : getheaderData[j]['taxamount'].toString().replaceAll(',', '')),

    //         subtotal: double.parse(getheaderData[j]['docbasic'] == null ? '0' : getheaderData[j]['docbasic'].toString().replaceAll(',', '')), //doctotal

    //         total: totalPayment == null ? 0 : int.parse(totalPayment!.total!.toString()),
    //         totalDue: double.parse(getheaderData[j]['doctotal'] == null ? '0' : getheaderData[j]['doctotal'].toString().replaceAll(',', '')),
    //         totpaid: double.parse(getheaderData[j]['amtpaid'] == null ? '0' : getheaderData[j]['amtpaid'].toString().replaceAll(',', '')),
    //       ),
    //       item: scannData,
    //     );

    //     soSalesmodl.add(salesM);
    //     soTotal = double.parse(getheaderData[j]['baltopay'].toString());

    //     notifyListeners();
    //   }

    notifyListeners();
    // }
  }

  Widget checksoItemcode(
      BuildContext context, ThemeData theme, int ins, String sbatch) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Screens.bodyheight(context) * 0.5,
      width: Screens.width(context) * 1, // Change as per your requirement
      child: ListView.builder(
          itemCount: soitemcodelistitem.length,
          itemBuilder: (context, index) {
            return Card(
              child: Container(
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    clicksoItemcode(
                        soitemcodelistitem[index], context, theme, ins, sbatch);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          // color: Colors.green,

                          child: Text(
                        soitemcodelistitem[index].ItemCode.toString(),
                      )),
                      const Text(" - "),
                      SizedBox(
                          // color: Colors.red,
                          width: Screens.width(context) * 0.45,
                          child: Text(
                            soitemcodelistitem[index].ItemName.toString(),
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  List<ItemCodeListModel> sssoitemcodelistitem55 = [];
  clicksoItemcode(ItemCodeListModel aaa, BuildContext context, ThemeData theme,
      int ins, String sbatch) {
    ItemCodeListModel? ssoitemcodeitem;

    ssoitemcodeitem = null;
    soitemcodelistitem = [];
//log("HHHHHHHHHHHHHHHHHHHH:${aaa.SerialBatch}");
    ssoitemcodeitem = ItemCodeListModel(
      Branch: aaa.Branch,
      ItemCode: aaa.ItemCode,
      ItemName: aaa.ItemName,
      SerialBatch: aaa.SerialBatch,
      Qty: aaa.Qty,
      MRP: double.parse(aaa.MRP.toString()),
      createdUserID: aaa.createdUserID.toString(),
      createdateTime: aaa.createdateTime,
      lastupdateIp: aaa.lastupdateIp,
      purchasedate: aaa.purchasedate,
      snapdatetime: aaa.snapdatetime,
      specialprice: double.parse(aaa.specialprice.toString()),
      updatedDatetime: aaa.updatedDatetime,
      updateduserid: aaa.updateduserid.toString(),
      SellPrice: double.parse(aaa.SellPrice.toString()),
      Maxdiscount: aaa.Maxdiscount != null ? aaa.Maxdiscount.toString() : '',
      TaxRate: aaa.TaxRate != null ? double.parse(aaa.TaxRate.toString()) : 00,
      discountper: 0,
      OpenQty: 0,
      InDate: '',
      Cost: 0,
      TaxType: '',
      InType: '',
      VenCode: '',
      VenName: '',
      uPackSize: aaa.uPackSize,
      uTINSPERBOX: aaa.uTINSPERBOX,
      uSpecificGravity: aaa.uSpecificGravity,
    );
    sssoitemcodelistitem55.add(ssoitemcodeitem);
//log("soitemcodelistitemxxxcc:::${sssoitemcodelistitem55.length}:::${ins}");

    for (int ik = 0; ik < sssoitemcodelistitem55.length; ik++) {
      if (sssoitemcodelistitem55[ik].ItemCode.toString() ==
              soData[ins].ItemCode.toString() &&
          sbatch == sssoitemcodelistitem55[ik].SerialBatch.toString()) {
        cccddd(context, theme, ik, ins);
        notifyListeners();
      }
    }
    notifyListeners();
  }

  // soitemcodedataaa55(BuildContext context, ThemeData theme, int i, int soind) {
  //   log("soitemcodelistitem::${sssoitemcodelistitem55[i].DocEntry}");
  //   soScanItem.add(StocksnapModelData(
  //     basedocentry: sssoitemcodelistitem55[i].DocEntry,
  //     baselineid: sssoitemcodelistitem55[i].baselineid.toString(),
  //     Branch: sssoitemcodelistitem55[i].Branch,
  //     ItemCode: sssoitemcodelistitem55[i].ItemCode,
  //     ItemName: sssoitemcodelistitem55[i].ItemName,
  //     SerialBatch: sssoitemcodelistitem55[i].SerialBatch,
  //     Qty: 1,
  //     MRP: double.parse(sssoitemcodelistitem55[i].MRP.toString()),
  //     createdUserID: sssoitemcodelistitem55[i].createdUserID.toString(),
  //     createdateTime: sssoitemcodelistitem55[i].createdateTime,
  //     lastupdateIp: sssoitemcodelistitem55[i].lastupdateIp,
  //     purchasedate: sssoitemcodelistitem55[i].purchasedate,
  //     snapdatetime: sssoitemcodelistitem55[i].snapdatetime,
  //     specialprice: double.parse(sssoitemcodelistitem55[i].specialprice.toString()),
  //     updatedDatetime: sssoitemcodelistitem55[i].updatedDatetime,
  //     updateduserid: sssoitemcodelistitem55[i].updateduserid.toString(),
  //     SellPrice: double.parse(sssoitemcodelistitem55[i].SellPrice.toString()),
  //     Maxdiscount: sssoitemcodelistitem55[i].Maxdiscount != null ? sssoitemcodelistitem55[i].Maxdiscount.toString() : '',
  //     TaxRate: sssoitemcodelistitem55[i].TaxRate != null ? double.parse(sssoitemcodelistitem55[i].TaxRate.toString()) : 0.0,
  //     discountper: 0,
  //     OpenQty: sssoitemcodelistitem55[i].Qty,
  //     InDate: '',
  //     Cost: 0,
  //     TaxType: '',
  //     InType: '',
  //     VenCode: '',
  //     VenName: '',
  //     liter: sssoitemcodelistitem55[i].liter != null ? double.parse(sssoitemcodelistitem55[i].liter.toString()) : 0.0,
  //     weight: sssoitemcodelistitem55[i].weight != null ? double.parse(sssoitemcodelistitem55[i].weight.toString()) : 0.0,
  //   ));

  //   FocusScopeNode focus = FocusScope.of(context);

  //   if (!focus.hasPrimaryFocus) {
  //     focus.unfocus();
  //   }
  //   notifyListeners();

  //   focusnode[0].requestFocus();
  //   log("soScanItemsoScanItemsoScanItem::${soScanItem.length.toString()}");
  // }

  forsoItemCodecheck(
      BuildContext context, ThemeData theme, int ins, String sbatch) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: AlertBox(
                  payMent: "ItemCode",
                  //
                  widget: checksoItemcode(context, theme, ins, sbatch),
                  buttonName: null));
        });
    notifyListeners();
  }

  cccddd(BuildContext context, ThemeData theme, int ik, int soins) async {
    if (soScanItem.isNotEmpty) {
      await soitemcodedataaa(context, theme, ik, soins);
      // soqtycontroller[soins].text = 1.toString();
      //log("soScanItemsoScanItemXX::${soScanItem.length}");
      mycontroller[79].clear();
      notifyListeners();
    } else {
      //log('step2');
      //log("AddSecond item ");
      await soaddScndData(
        ik,
        soins,
        context,
        theme,
      );
      mycontroller[79].clear();
    }
  }

  soaddScndData(
    int indx,
    int soins,
    BuildContext context,
    ThemeData theme,
  ) async {
    log("KKKK soitemcodelistitem:${soitemcodelistitem.length}");
//log("VVVVVVVVVVVVVVVVVVVVVVV :$itemcodedata:;$indx}");

    // int? ins = await socheckSameSerialBatchScnd(itemcodedata.toString(), indx);

    // if (ins != null) {
    //   log("objectobjectobject1222222222221 ins::${ins}");
    if (soitemcodelistitem.length > 0) {
      int? inssx = await socheckSameItemcode(
        context,
        theme,
        soitemcodelistitem[indx].ItemCode.toString(),
        indx,
      );

      if (inssx != null) {
        //log("objectobjectobject13333333333 inssx::$inssx");

        await soitemIncrement(
          inssx,
          soins,
          context,
          theme,
        );
      } else if (inssx == null) {
        //log("QQQQQQQQQQQQQQQQQQQQQ");
        //log("*************************xxxxxxxxxx");
        // soqtycontroller[soins].text = 1.toString();
        await soitemcodedataaa(context, theme, indx, soins);
        notifyListeners();
      }
    } else {
      log("QQQQQQQQQQQQQQQQQQ");
      await soitemcodedataaa(context, theme, indx, soins);

      notifyListeners();
    }
  }

  // Future<int?> socheckSameSerialBatchScnd(String sBatch, int indx) async {
  // if (soData[sodatind].docentry.toString() ==
  //         soitemcodelistitem[indx].DocEntry.toString() &&
  //       soData[sodatind].baselineid.toString() ==
  //           soitemcodelistitem[indx].baselineid.toString() &&
  //       soData[sodatind].ItemCode.toString() ==
  //           soitemcodelistitem[indx].ItemCode.toString()) {
  // //log("SSSSSSSSSSSSSS");
  //     return Future.value(indx);
  //   }

  //   notifyListeners();
  //   return Future.value(null);
  // }

  Future<int?> socheckSameItemcode(
    BuildContext context,
    ThemeData theme,
    String itemcode,
    ind,
  ) async {
    for (int i = 0; i < soScanItem.length; i++) {
      //log("MMMM2:::${soScanItem[i].baselineid}:: ${soitemcodelistitem[ind].baselineid}");
      if (soScanItem[i].basedocentry.toString() ==
              soitemcodelistitem[ind].DocEntry.toString() &&
          soScanItem[i].baselineid.toString() ==
              soitemcodelistitem[ind].baselineid.toString() &&
          soScanItem[i].ItemCode.toString() == itemcode.toString()) {
        //log("MMMM3");

        if (mycontroller[79].text.toString().toUpperCase().trim() ==
            soScanItem[i].SerialBatch.toString()) {
          return Future.value(ind);
        }
      }
    }
    notifyListeners();
    return Future.value(null);
  }
//  log("indindindindind::${soitemcodelistitem[soScaniss].baselineid.toString()}");
//     //log("issississississ::${soScanItem[soScaniss].baselineid.toString()}");
//     //log("soindsoind soData[sodatind].baselineid::${soData[sodatind].baselineid.toString()}");
//     //log("indindindindindxx::${soitemcodelistitem[soScaniss].baselineid.toString()}::${soData[sodatind].baselineid}");
  // log("soqtycontroller[sodatind]::${soqtycontroller[sodatind].text}");

  soitemIncrement(
    int soScaniss,
    int sodatind,
    BuildContext context,
    ThemeData theme,
  ) async {
//log("soindsoindsoind::${soScanItem.length} ");
    for (int ik = 0; ik < soScanItem.length; ik++) {
      //log("soScanItem serial:::${soScanItem[ik].SerialBatch}");
      if (soScanItem[ik].basedocentry.toString() ==
              soData[sodatind].docentry.toString() &&
          soitemcodelistitem[soScaniss].baselineid.toString() ==
              soScanItem[ik].baselineid.toString() &&
          soScanItem[ik].baselineid.toString() ==
              soData[sodatind].baselineid.toString()) {
        int soqtyctrl = int.parse(soqtycontroller[ik].text);
        // int qtyctrl = soScanItem[ik].Qty != null ? int.parse(soScanItem[ik].Qty.toString()) : 0;

        if (soitemcodelistitem[soScaniss].SerialBatch.toString() ==
            soScanItem[ik].SerialBatch.toString()) {
          if (soitemcodelistitem[soScaniss].ItemCode ==
                  soData[sodatind].ItemCode &&
              soData[sodatind].Qty! > soqtyctrl) {
            // qtyctrl = qtyctrl + 1;
            soqtyctrl = soqtyctrl + 1;
            soqtycontroller[ik].text = soqtyctrl.toString();
            print('soqtycontroller[ik].text1111::${soqtycontroller[ik].text}');

            // print("qtyctrlVVVV::${qtyctrl}");
            // soScanItem[ik].Qty = qtyctrl;
            print(" soScanItem[ik].Qty::${soScanItem[ik].Qty}");
            FocusScopeNode focus = FocusScope.of(context);

            if (!focus.hasPrimaryFocus) {
              focus.unfocus();
            }
            focusnode[0].requestFocus();
            notifyListeners();
          }
          break;
        }
        // else {
        //   log("textErrortextErrorFF");
        //   if (soitemcodelistitem[soScaniss].SerialBatch.toString() != soScanItem[ik].SerialBatch.toString()) {
        // //log("textErrortextErrorFF5555:::soScanItem");
        //     if (soitemcodelistitem[soScaniss].ItemCode == soScanItem[ik].ItemCode && soData[sodatind].ItemCode == soScanItem[ik].ItemCode) {
        //       if (soData[sodatind].Qty! > soqtyctrl) {
        //         await soitemcodedataaa(context, theme, soScaniss, sodatind);
        //         soqtyctrl = 1;
        //         soqtycontroller[ik].text = soqtyctrl.toString();
        //         // soqtycontroller[ik].text = (int.parse(soqtycontroller[ik].text) + 1).toString();
        //     //log('soqtycontroller[ik].text222::${sodatind}::${soqtyctrl}:${soqtycontroller[ik].text}');
        //     //log("soScanItemsoScanItemlength::${soScanItem.length}");
        //         notifyListeners();
        //         break;
        //       }
        //     } else {
        //       showDialog(
        //           context: context,
        //           barrierDismissible: true,
        //           builder: (BuildContext context) {
        //             return AlertDialog(
        //                 contentPadding: const EdgeInsets.all(0),
        //                 content: AlertBox(
        //                   payMent: 'Alert',
        //                   errormsg: true,
        //                   widget: Center(
        //                       child: ContentContainer(
        //                     content: 'No more qty to add..!!',
        //                     theme: theme,
        //                   )),
        //                   buttonName: null,
        //                 ));
        //           });
        //       notifyListeners();
        //     }
        //   }
        // }
      }
      // break;
    }

    notifyListeners();
    // }
  }
  // soitemIncrement(int ind, BuildContext context, ThemeData theme) {
  //   for (int ik = 0; ik < soData.length; ik++) {
  //     for (int i = 0; i < soitemcodelistitem.length; i++) {
  //       if (soitemcodelistitem[i].ItemCode == soData[ik].ItemCode) {
  //         if (soitemcodelistitem[i].SerialBatch ==
  //             soScanItem[ind].SerialBatch) {
  //         //log("HHHHHHHHHHHHH::${soitemcodelistitem[i].SerialBatch}::${soScanItem[ind].SerialBatch}");
  //           if (soitemcodelistitem[i].ItemCode == soScanItem[ind].ItemCode) {
  //           //log("HHHHHHHHHHHHH1:: " + soData[ik].Qty.toString());
  //             int qtyctrl = soqtycontroller[ik].text.isNotEmpty
  //                 ? int.parse(soqtycontroller[ik].text)
  //                 : 0;
  //             if (soData[ik].Qty! > qtyctrl) {
  //             //log("HHHHHHHHHHHHH2::");

  //               qtyctrl = qtyctrl + 1;
  //               soqtycontroller[ik].text = qtyctrl.toString();
  //               soScanItem[ind].Qty =
  //                   int.parse(soqtycontroller[ik].text.toString());
  //             //log("HHHHHHHHHHHHH3::" + qtyctrl.toString());

  //               FocusScopeNode focus = FocusScope.of(context);

  //               if (!focus.hasPrimaryFocus) {
  //                 focus.unfocus();
  //               }
  //               focusnode[0].requestFocus();
  //               notifyListeners();
  //               break;
  //             } else {
  //               // soqtycontroller[ik].text = 1.toString();

  //               showDialog(
  //                   context: context,
  //                   barrierDismissible: true,
  //                   builder: (BuildContext context) {
  //                     return AlertDialog(
  //                         contentPadding: EdgeInsets.all(0),
  //                         content: AlertBox(
  //                           payMent: 'Alert',
  //                           errormsg: true,
  //                           widget: Center(
  //                               child: ContentContainer(
  //                             content: 'No more qty to add..!!',
  //                             theme: theme,
  //                           )),
  //                           buttonName: null,
  //                         ));
  //                   });
  //               notifyListeners();

  //               break;
  //             }
  //           }
  //         } else {
  //         //log(" textErrortextErrorFFF1 ");

  //           if (soitemcodelistitem[i].SerialBatch !=
  //               soScanItem[ind].SerialBatch) {
  //           //log(" textErrortextErrorFFF2 ");

  //             if (soitemcodelistitem[i].ItemCode == soScanItem[ind].ItemCode) {
  //               int qtyctrl = soqtycontroller[ik].text.isNotEmpty
  //                   ? int.parse(soqtycontroller[ik].text)
  //                   : 0;
  //             //log(" textErrortextErrorFFF3:: " + soData[ik].Qty.toString());
  //               if (soData[ik].Qty! > qtyctrl) {
  //               //log(" textErrortextErrorFFF4 ");
  //                 qtyctrl = qtyctrl + 1;
  //                 soqtycontroller[ik].text = qtyctrl.toString();

  //                 soitemcodedataaa(context, theme, i);

  //                 notifyListeners();
  //               } else {
  //                 showDialog(
  //                     context: context,
  //                     barrierDismissible: true,
  //                     builder: (BuildContext context) {
  //                       return AlertDialog(
  //                           contentPadding: EdgeInsets.all(0),
  //                           content: AlertBox(
  //                             payMent: 'Alert',
  //                             errormsg: true,
  //                             widget: Center(
  //                                 child: ContentContainer(
  //                               content: 'No more qty to add..!!',
  //                               theme: theme,
  //                             )),
  //                             buttonName: null,
  //                           ));
  //                     });
  //                 notifyListeners();
  //                 break;
  //               }
  //             }
  //           }
  //         }
  //       }
  //     }
  //     notifyListeners();
  //   }
  // }

  soitemcodedataaa(
    BuildContext context,
    ThemeData theme,
    int i,
    int soind,
  ) {
//log("soitemcodelistitem[i].SerialBatch::${soitemcodelistitem[i].SerialBatch}");
    log("soitemcodelistitemxxx length::${soitemcodelistitem.length}");

    soScanItem.add(StocksnapModelData(
      basedocentry: soitemcodelistitem[i].DocEntry,
      // sapbasedocentry: soitemcodelistitem[i].sap,
      baselineid: soitemcodelistitem[i].baselineid.toString(),
      Branch: soitemcodelistitem[i].Branch,
      ItemCode: soitemcodelistitem[i].ItemCode,
      ItemName: soitemcodelistitem[i].ItemName,
      SerialBatch: soitemcodelistitem[i].SerialBatch,
      Qty: 1,
      MRP: double.parse(soitemcodelistitem[i].MRP.toString()),
      createdUserID: soitemcodelistitem[i].createdUserID.toString(),
      createdateTime: soitemcodelistitem[i].createdateTime,
      lastupdateIp: soitemcodelistitem[i].lastupdateIp,
      purchasedate: soitemcodelistitem[i].purchasedate,
      snapdatetime: soitemcodelistitem[i].snapdatetime,
      specialprice: double.parse(soitemcodelistitem[i].specialprice.toString()),
      updatedDatetime: soitemcodelistitem[i].updatedDatetime,
      updateduserid: soitemcodelistitem[i].updateduserid.toString(),
      SellPrice: double.parse(soitemcodelistitem[i].SellPrice.toString()),
      Maxdiscount: soitemcodelistitem[i].Maxdiscount != null
          ? soitemcodelistitem[i].Maxdiscount.toString()
          : '',
      TaxRate: soitemcodelistitem[i].TaxRate != null
          ? double.parse(soitemcodelistitem[i].TaxRate.toString())
          : 0.0,
      discountper: 0,
      OpenQty: soData[soind].OpenQty,
      InDate: '',
      Cost: 0,
      TaxType: '',
      InType: '',
      VenCode: '',
      VenName: '',
      liter: soitemcodelistitem[i].liter != null
          ? double.parse(soitemcodelistitem[i].liter.toString())
          : 0.0,
      weight: soitemcodelistitem[i].weight != null
          ? double.parse(soitemcodelistitem[i].weight.toString())
          : 0.0,
    ));
    notifyListeners();
    for (int ink = 0; ink < soScanItem.length; ink++) {
      soqtycontroller[ink].text = soScanItem[ink].Qty.toString();
    }
    FocusScopeNode focus = FocusScope.of(context);

    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
    notifyListeners();

    focusnode[0].requestFocus();
//log("soScanItemsoScanItemsoScanItem::${soScanItem.length.toString()}");
  }

  // soitemcodedataaa55(BuildContext context, ThemeData theme, int i) {
  //   log("AAAAAAAAAAAAAAAAAAAAAAAAAA::${soitemcodelistitem[i].ItemCode}");

  //   // if (soitemcodelistitem[i].Qty! > 0) {
  //   soScanItem.add(StocksnapModelData(
  //     Branch: soitemcodelistitem[i].Branch,
  //     ItemCode: soitemcodelistitem[i].ItemCode,
  //     ItemName: soitemcodelistitem[i].ItemName,
  //     SerialBatch: soitemcodelistitem[i].SerialBatch,
  //     Qty: 1,
  //     MRP: double.parse(soitemcodelistitem[i].MRP.toString()),
  //     createdUserID: soitemcodelistitem[i].createdUserID.toString(),
  //     createdateTime: soitemcodelistitem[i].createdateTime,
  //     lastupdateIp: soitemcodelistitem[i].lastupdateIp,
  //     purchasedate: soitemcodelistitem[i].purchasedate,
  //     snapdatetime: soitemcodelistitem[i].snapdatetime,
  //     specialprice: double.parse(soitemcodelistitem[i].specialprice.toString()),
  //     updatedDatetime: soitemcodelistitem[i].updatedDatetime,
  //     updateduserid: soitemcodelistitem[i].updateduserid.toString(),
  //     SellPrice: double.parse(soitemcodelistitem[i].SellPrice.toString()),
  //     Maxdiscount: soitemcodelistitem[i].Maxdiscount != null
  //         ? soitemcodelistitem[i].Maxdiscount.toString()
  //         : '',
  //     TaxRate: soitemcodelistitem[i].TaxRate != null
  //         ? double.parse(soitemcodelistitem[i].TaxRate.toString())
  //         : 0.0,
  //     discountper: 0,
  //     OpenQty: soitemcodelistitem[i].Qty,
  //     InDate: '',
  //     Cost: 0,
  //     TaxType: '',
  //     InType: '',
  //     VenCode: '',
  //     VenName: '',
  //     liter: soitemcodelistitem[i].liter != null
  //         ? double.parse(soitemcodelistitem[i].liter.toString())
  //         : 0.0,
  //     weight: soitemcodelistitem[i].weight != null
  //         ? double.parse(soitemcodelistitem[i].weight.toString())
  //         : 0.0,
  //   ));

  //   for (int ik = 0; ik < soData.length; ik++) {
  //     if (soitemcodelistitem[i].ItemCode == soData[ik].ItemCode) {
  //       soqtycontroller[ik].text = 1.toString();
  //     }
  //   }
  //   FocusScopeNode focus = FocusScope.of(context);

  //   if (!focus.hasPrimaryFocus) {
  //     focus.unfocus();
  //   }
  //   notifyListeners();

  //   focusnode[0].requestFocus();
  //   // }
  // }


  // scannsolist(String sBatch, BuildContext context, ThemeData theme) async {
  //   int soqtyyy = 0;
  //   indxxx = 0;
  //   soitemcodelistitem = [];
  //   final Database db = (await DBHelper.getInstance())!;

  //   log("AAAAAAA1::");

  //   for (int ins = 0; ins < soData.length; ins++) {
  //     List<Map<String, Object?>> serialbatchCheck = await DBOperation.Itemcodeserialbatch(db, sBatch.toString());
  // //log("AAAAAAA1::${serialbatchCheck.length}");

  //     for (int ia = 0; ia < serialbatchCheck.length; ia++) {
  //       soqtyyy = soqtycontroller[ins].text.isNotEmpty ? int.parse(soqtycontroller[ins].text) : 0;

  //       if (soData[ins].ItemCode.toString() == serialbatchCheck[ia]['itemcode'].toString() && soData[ins].Qty! > soqtyyy) {
  //     //log("AAAAAAA2:;${soData[ins].ItemCode}::${serialbatchCheck[ia]['itemcode'].toString()}");

  //     //log(" soData.length soData.length::${ins}::${soData.length} ");
  //         for (int ih = 0; ih < soSalesmodl.length; ih++) {
  //           if (soSalesmodl[ih].docentry.toString() == soData[ins].basedocentry.toString()) {
  //         //log("AAAAAAA3 ih:;${ih}");
  //         //log("AAAAAAA4 ins::${ins}::${soData[ins].basedocentry}:;${soSalesmodl[ih].docentry}");
  //             indxxx = ins;
  //             soitemcodelistitem.add(ItemCodeListModel(
  //               DocEntry: soData[ins].basedocentry.toString(),
  //               baselineid: int.parse(soData[ins].baselineid.toString()),
  //               ItemCode: serialbatchCheck[ia]['itemcode'].toString(),
  //               ItemName: serialbatchCheck[ia]['itemname'].toString(),
  //               SerialBatch: serialbatchCheck[ia]['serialbatch'].toString(),
  //               Qty: int.parse(serialbatchCheck[ia]['quantity'].toString()),
  //               MRP: serialbatchCheck[ia]['mrpprice'] != null ? double.parse(serialbatchCheck[ia]['mrpprice'].toString()) : null,
  //               createdUserID: serialbatchCheck[ia]['createdUserID'].toString(),
  //               createdateTime: serialbatchCheck[ia]['itecreatedateTimemname'].toString(),
  //               lastupdateIp: serialbatchCheck[ia]['lastupdateIp'].toString(),
  //               purchasedate: serialbatchCheck[ia]['purchasedate'].toString(),
  //               snapdatetime: serialbatchCheck[ia]['snapdatetime'].toString(),
  //               specialprice: serialbatchCheck[ia]['specialprice'] != null
  //                   ? double.parse(
  //                       serialbatchCheck[ia]['specialprice'].toString(),
  //                     )
  //                   : null,
  //               updatedDatetime: serialbatchCheck[ia]['UpdatedDatetime'].toString(),
  //               updateduserid: serialbatchCheck[ia]['updateduserid'].toString(),
  //               SellPrice: serialbatchCheck[ia]['sellprice'] != null
  //                   ? double.parse(
  //                       serialbatchCheck[ia]['sellprice'].toString(),
  //                     )
  //                   : null,
  //               Maxdiscount: serialbatchCheck[ia]['maxdiscount'] != null ? serialbatchCheck[ia]['maxdiscount'].toString() : '',
  //               TaxRate: serialbatchCheck[ia]['taxrate'] != null
  //                   ? double.parse(
  //                       serialbatchCheck[ia]['taxrate'].toString(),
  //                     )
  //                   : 00,
  //               discountper: 0,
  //               OpenQty: 0,
  //               InDate: '',
  //               Cost: 0,
  //               TaxType: '',
  //               InType: '',
  //               VenCode: '',
  //               VenName: '',
  //               weight: serialbatchCheck[ia]['weight'] != null ? double.parse(serialbatchCheck[ia]['weight'].toString()) : null,
  //               liter: serialbatchCheck[ia]['liter'] != null ? double.parse(serialbatchCheck[ia]['liter'].toString()) : null,
  //             ));
  //             itemcodedata = serialbatchCheck[ia]['itemcode'].toString();
  //           }
  //       //log("itemcodedataitemcodedata::${itemcodedata}");
  //         }
  //       }
  //     }
  //     if (soitemcodelistitem.length == 1) {
  //   //log("GGGGGGGGGGGGGGGGGGGGG1111::${soitemcodelistitem.length}");
  //       cccddd(context, theme, 0, ins);
  //       // break;
  //       notifyListeners();
  //     } else if (soitemcodelistitem.length > 1) {
  //   //log("GGGGGGGGGGGGGGGGGGGGG222::${soitemcodelistitem.length}");

  //       forsoItemCodecheck(context, theme, ins, sBatch);
  //       // break;
  //     }
  //   }
  //   if (soitemcodelistitem.isEmpty) {
  //     showDialog(
  //         context: context,
  //         barrierDismissible: true,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //               contentPadding: const EdgeInsets.all(0),
  //               content: AlertBox(
  //                 payMent: 'Alert',
  //                 errormsg: true,
  //                 widget: Center(
  //                     child: ContentContainer(
  //                   content: 'Wrong Batch Scanned..!!',
  //                   theme: theme,
  //                 )),
  //                 buttonName: null,
  //               ));
  //         });
  //   }

  //   notifyListeners();
  // }

  Future<int?> selectsalesorderlist() {
    for (int ins = 0; ins < soData.length; ins++) {
      if (selectIndex == ins) {
      // if (soData[ins].invoiceClr == 1 && soData[ins].checkBClr == true) {
        log("insss55:::$ins");
        return Future.value(ins);
      }
      notifyListeners();
    }
    notifyListeners();

    return Future.value(null);
  }

  soInvoiceScan(String sBatch, BuildContext context, ThemeData theme) async {
    log("Step1:::$sBatch");

    int? indx = await selectsalesorderlist();
    log("Step2:::$indx");

    if (indx != null) {
      int? sindx = await soScanBatch(sBatch, context, theme, indx);
      if (sindx != null) {
        cccddd(context, theme, sindx, indx);
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
                      content: 'Wrong Batch Scanned',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
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
                    content: 'Select a Item List',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
  }

  Future<int?> soScanBatch(
      String sBatch, BuildContext context, ThemeData theme, int ins) async {
    final Database db = (await DBHelper.getInstance())!;
    int soqtyyy = 0;
    soitemcodelistitem = [];

    List<StockSnapTModelDB> itemMasdata =
        await DBOperation.getItemMasDataItemcd(
            db, sBatch.toString(), soData[ins].ItemCode.toString());
    log("soData[ins]:::$ins");
    if (itemMasdata.isNotEmpty) {
      for (int ia = 0; ia < itemMasdata.length; ia++) {
        soqtyyy = soqtycontroller[ins].text.isNotEmpty
            ? int.parse(soqtycontroller[ins].text)
            : 0;

        if (soData[ins].ItemCode.toString() ==
                itemMasdata[ia].itemcode.toString() &&
            soData[ins].Qty! > soqtyyy) {
          //log("AAAAAAA2:;${soData[ins].ItemCode}::${itemMasdata[ia].itemcode.toString()}");
          //log(" soData.length soData.length::${ins}::${soData.length} ");
          for (int ih = 0; ih < soSalesmodl.length; ih++) {
            if (soSalesmodl[ih].docentry.toString() ==
                soData[ins].basedocentry.toString()) {
              textError = '';
              //log("AAAAAAA3 ih:;${ih}");
              //log("AAAAAAA4 ins::${ins}::${soData[ins].basedocentry}:;${soSalesmodl[ih].docentry}");
              soitemcodelistitem.add(ItemCodeListModel(
                uPackSize: double.parse(itemMasdata[ia].uPackSize.toString()),
                uTINSPERBOX: int.parse(itemMasdata[ia].uTINSPERBOX.toString()),
                uSpecificGravity:
                    double.parse(itemMasdata[ia].uSpecificGravity.toString()),
                DocEntry: soData[ins].basedocentry.toString(),
                baselineid: int.parse(soData[ins].baselineid.toString()),
                ItemCode: itemMasdata[ia].itemcode.toString(),
                ItemName: itemMasdata[ia].itemname.toString(),
                SerialBatch: itemMasdata[ia].serialbatch.toString(),
                Qty: int.parse(itemMasdata[ia].quantity.toString()),
                MRP: itemMasdata[ia].mrpprice != null
                    ? double.parse(itemMasdata[ia].mrpprice.toString())
                    : null,
                createdUserID: itemMasdata[ia].createdUserID.toString(),
                createdateTime: itemMasdata[ia].createdateTime.toString(),
                lastupdateIp: itemMasdata[ia].lastupdateIp.toString(),
                purchasedate: itemMasdata[ia].purchasedate.toString(),
                snapdatetime: itemMasdata[ia].snapdatetime.toString(),
                specialprice: itemMasdata[ia].specialprice != null
                    ? double.parse(
                        itemMasdata[ia].specialprice.toString(),
                      )
                    : null,
                updatedDatetime: itemMasdata[ia].updatedDatetime.toString(),
                updateduserid: itemMasdata[ia].updateduserid.toString(),
                SellPrice: itemMasdata[ia].sellprice != null
                    ? double.parse(
                        itemMasdata[ia].sellprice.toString(),
                      )
                    : null,
                Maxdiscount: itemMasdata[ia].maxdiscount != null
                    ? itemMasdata[ia].maxdiscount.toString()
                    : '',
                TaxRate: itemMasdata[ia].taxrate != null
                    ? double.parse(
                        itemMasdata[ia].taxrate.toString(),
                      )
                    : 00,
                discountper: 0,
                OpenQty: 0,
                InDate: '',
                Cost: 0,
                TaxType: '',
                InType: '',
                VenCode: '',
                VenName: '',
                weight: itemMasdata[ia].weight != null
                    ? double.parse(itemMasdata[ia].weight.toString())
                    : 0,
                liter: itemMasdata[ia].liter != null
                    ? double.parse(itemMasdata[ia].liter.toString())
                    : 0,
              ));
            }
            //log("itemcodedataitemcodedata::$itemcodedata");
          }

          // cccddd(context, theme, ia, ins);
          // notifyListeners();
        }
        log("GGGGGGGGGGGGGGGGGGGGG1111::${soitemcodelistitem.length}");
        return Future.value(ia);
      }
    }
    return Future.value(null);
  }

  // scannsolistcopy(String sBatch, BuildContext context, ThemeData theme) async {
  //   textError = '';
  //   indxxx = 0;
  //   soitemcodelistitem = [];
  //   int soqtyyy = 0;
  //   final Database db = (await DBHelper.getInstance())!;
  //   log("AAAAAAA1::");
  //   for (int ins = 0; ins < soData.length; ins++) {
  //     if (soData[ins].invoiceClr == 1 && soData[ins].checkBClr == true) {
  //       List<StockSnapTModelDB> itemMasdata =
  //           await DBOperation.getItemMasDataItemcd(
  //               db, sBatch.toString(), soData[ins].ItemCode.toString());
  //       log("soData[ins]:::${ins}");
  //       log("itemCode:::${soData[ins].ItemCode.toString()}");
  //       if (itemMasdata.isNotEmpty) {
  //         for (int ia = 0; ia < itemMasdata.length; ia++) {
  //           soqtyyy = soqtycontroller[ins].text.isNotEmpty
  //               ? int.parse(soqtycontroller[ins].text)
  //               : 0;

  //           if (soData[ins].ItemCode.toString() ==
  //                   itemMasdata[ia].itemcode.toString() &&
  //               soData[ins].Qty! > soqtyyy) {
  //             //log("AAAAAAA2:;${soData[ins].ItemCode}::${itemMasdata[ia].itemcode.toString()}");
  //             for (int ih = 0; ih < soSalesmodl.length; ih++) {
  //               log("soData[ins].basedocentry::${soData[ins].basedocentry}::${soSalesmodl[ih].docentry.toString()} ");

  //               if (soSalesmodl[ih].docentry.toString() ==
  //                   soData[ins].basedocentry.toString()) {
  //                 textError = '';
  //                 //log("AAAAAAA3 ih:;${ih}");
  //                 //log("AAAAAAA4 ins::${ins}::${soData[ins].basedocentry}:;${soSalesmodl[ih].docentry}");
  //                 indxxx = ins;
  //                 soitemcodelistitem.add(ItemCodeListModel(
  //                   uPackSize:
  //                       double.parse(itemMasdata[ia].uPackSize.toString()),
  //                   uTINSPERBOX:
  //                       int.parse(itemMasdata[ia].uTINSPERBOX.toString()),
  //                   uSpecificGravity: double.parse(
  //                       itemMasdata[ia].uSpecificGravity.toString()),
  //                   DocEntry: soData[ins].basedocentry.toString(),
  //                   baselineid: int.parse(soData[ins].baselineid.toString()),
  //                   ItemCode: itemMasdata[ia].itemcode.toString(),
  //                   ItemName: itemMasdata[ia].itemname.toString(),
  //                   SerialBatch: itemMasdata[ia].serialbatch.toString(),
  //                   Qty: int.parse(itemMasdata[ia].quantity.toString()),
  //                   MRP: itemMasdata[ia].mrpprice != null
  //                       ? double.parse(itemMasdata[ia].mrpprice.toString())
  //                       : null,
  //                   createdUserID: itemMasdata[ia].createdUserID.toString(),
  //                   createdateTime: itemMasdata[ia].createdateTime.toString(),
  //                   lastupdateIp: itemMasdata[ia].lastupdateIp.toString(),
  //                   purchasedate: itemMasdata[ia].purchasedate.toString(),
  //                   snapdatetime: itemMasdata[ia].snapdatetime.toString(),
  //                   specialprice: itemMasdata[ia].specialprice != null
  //                       ? double.parse(
  //                           itemMasdata[ia].specialprice.toString(),
  //                         )
  //                       : null,
  //                   updatedDatetime: itemMasdata[ia].updatedDatetime.toString(),
  //                   updateduserid: itemMasdata[ia].updateduserid.toString(),
  //                   SellPrice: itemMasdata[ia].sellprice != null
  //                       ? double.parse(
  //                           itemMasdata[ia].sellprice.toString(),
  //                         )
  //                       : null,
  //                   Maxdiscount: itemMasdata[ia].maxdiscount != null
  //                       ? itemMasdata[ia].maxdiscount.toString()
  //                       : '',
  //                   TaxRate: itemMasdata[ia].taxrate != null
  //                       ? double.parse(
  //                           itemMasdata[ia].taxrate.toString(),
  //                         )
  //                       : 00,
  //                   discountper: 0,
  //                   OpenQty: 0,
  //                   InDate: '',
  //                   Cost: 0,
  //                   TaxType: '',
  //                   InType: '',
  //                   VenCode: '',
  //                   VenName: '',
  //                   weight: itemMasdata[ia].weight != null
  //                       ? double.parse(itemMasdata[ia].weight.toString())
  //                       : 0,
  //                   liter: itemMasdata[ia].liter != null
  //                       ? double.parse(itemMasdata[ia].liter.toString())
  //                       : 0,
  //                 ));
  //               }
  //               break;

  //               //log("itemcodedataitemcodedata::$itemcodedata");
  //             }

  //             cccddd(context, theme, ia, ins);
  //             notifyListeners();
  //           }
  //             notifyListeners();

  //           log("GGGGGGGGGGGGGGGGGGGGG1111::${soitemcodelistitem.length}");
  //           return Future.value(ia);
  //         }
  //       }
  //       //log("GGGGGGGGGGGGGGGGGGGGG1111::${soitemcodelistitem.length}");

  //       notifyListeners();
  //     }
  //   }
  //   return Future.value(null);

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

  soOrderdata() {
    soData.clear();
    soitemcodelistitem = [];
    soScanItem = [];
    clearsoaqty();

    for (int ih = 0; ih < soSalesmodl.length; ih++) {
      //log("soSalesmodl[ih].item:::${soSalesmodl[ih].item!.length}");
      //log("soSalesmodl[ih].docentry:::${soSalesmodl[ih].docentry.toString()}");
      if (soSalesmodl[ih].invoiceClr == 1 &&
          soSalesmodl[ih].checkBClr == true) {
        for (int ik = 0; ik < soSalesmodl[ih].item!.length; ik++) {
          if (soSalesmodl[ih].item![ik].basedocentry.toString() ==
              soSalesmodl[ih].docentry.toString()) {
            if (soSalesmodl[ih].item![ik].Qty != 0) {
              soData.add(StocksnapModelData(
                checkBClr: false,
                invoiceClr: 0,
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
            // log("soDatasoDatasoData length::" + soData.length.toString());
          }
        }

        notifyListeners();
      }
      notifyListeners();
    }

    for (int ih = 0; ih < soData.length; ih++) {
      // selectIndex = soData.length - 1;
    }
  }

  sBatchFrmStksnap(int index) async {
    // log("sBatchFrmStksnap11122222 $index");

    // itemchCheck = '';
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> serialbatchCheck =
        await DBOperation.cfoserialBatchCheck(
            db, soData[index].ItemCode.toString());
    print("soData[index].ItemCode.toString():::${soData[index].ItemCode}");
    for (int i = 0; i < serialbatchCheck.length; i++) {
      if (soData[index].ItemCode ==
          serialbatchCheck[i]['itemcode'].toString()) {
        soData[index].SerialBatch =
            serialbatchCheck[i]['serialbatch'].toString();

        notifyListeners();
      }
    }
    notifyListeners();
    return i;
  }

  // soIncrement(BuildContext context, ThemeData theme, int sik) {
  //   if (itemchCheck == soData[sik].ItemCode) {
  //     // if (soqtycontroller[sik].text.isEmpty) {
  //     //   soqtycontroller[sik].text = 1.toString();
  //     // } else {
  //     int soqtyqty = 0;
  //     if (soData[sik].Qty! >= int.parse(soqtycontroller[sik].text.toString())) {
  //       soqtyqty = int.parse(soqtycontroller[sik].text.toString());

  //       notifyListeners();
  // } else {
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
  //               content: 'No more qty to add..!!',
  //               theme: theme,
  //             )),
  //             buttonName: null,
  //           ));
  //     });
  //   soqtycontroller[sik].clear();
  // }
  //     mycontroller[79].clear();
  //     notifyListeners();
  //   }
  // }
  soqtychangealertbc(int ikn, BuildContext context, ThemeData theme) {
    if (soqtycontroller[ikn].text.isNotEmpty) {
      if (soData[ikn].Qty! >= (int.parse(soqtycontroller[ikn].text))) {
        soqtycontroller[ikn].text = soqtycontroller[ikn].text;
      } else {
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
    // }
  }

  clearsoaqty() {
    soqtycontroller = List.generate(100, (ij) => TextEditingController());
  }

  mapsodata(
    BuildContext context,
    ThemeData theme,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    int? totqty;
    mycontroller[50].text = "";
    List<Address>? add5 = [];
    List<Address>? sipadd5 = [];

    selectedBillAdress = 0;
    selectedShipAdress = 0;
    scanneditemData = [];
//log("soSalesmodl[ih].cardCode::${soSalesmodl[0].cardCode.toString()}");
    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(
            db, soSalesmodl[0].cardCode.toString());

    print("MMMMMMMMM:::${csadresdataDB.length}");

    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (soSalesmodl[0].cardCode.toString() ==
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

      selectedcust = CustomerDetals(
        name: soSalesmodl[0].custName,
        phNo: soSalesmodl[0].phNo,
        cardCode: soSalesmodl[0].cardCode,
        accBalance: double.parse(soSalesmodl[0].accBalance.toString()),
        point: soSalesmodl[0].point,
        address: add5,
        tarNo: soSalesmodl[0].tarNo,
        docentry: soSalesmodl[0].docentry.toString(),
        email: soSalesmodl[0].email,
      );
      notifyListeners();

      selectedcust55 = CustomerDetals(
        name: soSalesmodl[0].custName,
        phNo: soSalesmodl[0].phNo,
        cardCode: soSalesmodl[0].cardCode,
        accBalance: double.parse(soSalesmodl[0].accBalance.toString()),
        point: soSalesmodl[0].point,
        address: sipadd5,
        tarNo: soSalesmodl[0].tarNo,
        docentry: soSalesmodl[0].docentry.toString(),
        email: soSalesmodl[0].email,
      );
    }

    notifyListeners();
    for (int ihk = 0; ihk < soSalesmodl.length; ihk++) {
      for (int im = 0; im < soScanItem.length; im++) {
        //log("KKKKKKKKKKKKKKKKKKKK:${soScanItem.length}");
        //log("XXX::${soSalesmodl[ihk].docentry.toString()}:: ${soScanItem[im].basedocentry.toString()}");

        if (soSalesmodl[ihk].docentry.toString() ==
            soScanItem[im].basedocentry.toString()) {
          //log("AAAAAAAAAAAAAAAAA:${soScanItem[im].SerialBatch}");

          scanneditemData.add(StocksnapModelData(
            Branch: soScanItem[im].Branch,
            ItemCode: soScanItem[im].ItemCode,
            ItemName: soScanItem[im].ItemName,
            basedocentry: soScanItem[im].basedocentry,
            baselineid: soScanItem[im].baselineid,
            SerialBatch: soScanItem[im].SerialBatch,
            Qty: int.parse(soqtycontroller[im].text),
            // soScanItem[im].Qty.toString()),
            MRP: double.parse(soScanItem[im].MRP.toString()),
            createdUserID: soScanItem[im].createdUserID.toString(),
            createdateTime: soScanItem[im].createdateTime.toString(),
            lastupdateIp: soScanItem[im].lastupdateIp,
            purchasedate: soScanItem[im].purchasedate,
            snapdatetime: soScanItem[im].snapdatetime,
            specialprice: double.parse(soScanItem[im].specialprice.toString()),
            updatedDatetime: soScanItem[im].updatedDatetime,
            updateduserid: soScanItem[im].updateduserid.toString(),
            SellPrice: double.parse(soScanItem[im].SellPrice.toString()),
            Maxdiscount: soScanItem[im].Maxdiscount != null
                ? soScanItem[im].Maxdiscount.toString()
                : '',
            TaxRate: soScanItem[im].TaxRate != null
                ? double.parse(soScanItem[im].TaxRate.toString())
                : 0.0,
            discountper: soScanItem[im].discountper,
            OpenQty: soScanItem[im].OpenQty,
            InDate: '',
            Cost: 0,
            TaxType: '',
            InType: '',
            VenCode: '',
            VenName: '',
            liter: soScanItem[im].liter != null
                ? double.parse(soScanItem[im].liter.toString())
                : 0.0,
            weight: soScanItem[im].weight != null
                ? double.parse(soScanItem[im].weight.toString())
                : 0.0,
            uPackSize: soScanItem[im].uPackSize ?? 0,
            uSpecificGravity: soScanItem[im].uSpecificGravity ?? 0,
            uTINSPERBOX: soScanItem[im].uTINSPERBOX ?? 0,
          ));
        }
      }
    }
//log("SO scanneditemData.length::${scanneditemData.length}");

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

  // scannsolist(
  //   String sBatch,
  //   BuildContext context,
  //   ThemeData theme,
  // ) async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   // itemchCheck = '';
  //   if (soData.isNotEmpty) {
  //     for (int sik = 0; sik < soData.length; sik++) {
  //    // log('soData[sik].ItemCodesoData[sik].ItemCode:' +
  //           soData[sik].ItemCode.toString());
  //       List<Map<String, Object?>> serialbatchCheck =
  //           await DBOperation.cfoserialBatchCheck(
  //               db, soData[sik].ItemCode.toString());

  //       for (int i = 0; i < serialbatchCheck.length; i++) {
  //         if (soData[sik].ItemCode ==
  //             serialbatchCheck[i]['itemcode'].toString()) {
  //           if (sBatch == serialbatchCheck[i]['serialbatch'].toString()) {

  // soScanItem.add(StocksnapModelData(
  //     Maxdiscount: serialbatchCheck[i]['maxdiscount'].toString(),
  //     Branch: serialbatchCheck[i]['branch'].toString(),
  //     ItemCode: serialbatchCheck[i]['itemcode'].toString(),
  //     ItemName: serialbatchCheck[i]['itemname'].toString(),
  //     SerialBatch: serialbatchCheck[i]['serialbatch'].toString(),
  //     Qty: int.parse(serialbatchCheck[i]['quantity'].toString()),
  //     MRP: double.parse(serialbatchCheck[i]['mrpprice'].toString()),
  //     SellPrice:
  //         double.parse(serialbatchCheck[i]['sellprice'].toString()),
  //     TaxRate:
  //         double.parse(serialbatchCheck[i]['taxrate'].toString()),
  //     weight:
  //         double.parse(serialbatchCheck[i]['weight'].toString()),
  //     liter:
  //         double.parse(serialbatchCheck[i]['liter'].toString())));

  //             if (soqtycontroller[sik].text.isEmpty) {
  //               soqtycontroller[sik].text = 1.toString();

  //               notifyListeners();
  //             } else {
  //               if (soData[sik].Qty! >
  //                   int.parse(soqtycontroller[sik].text.toString())) {
  //                 soqtycontroller[sik].text =
  //                     (int.parse(soqtycontroller[sik].text.toString()) + 1)
  //                         .toString();
  //                 notifyListeners();
  //               }
  //               //  else {
  //               //       showDialog(
  //               //           context: context,
  //               //           barrierDismissible: true,
  //               //           builder: (BuildContext context) {
  //               //             return AlertDialog(
  //               //                 contentPadding: EdgeInsets.all(0),
  //               //                 content: AlertBox(
  //               //                   payMent: 'Alert',
  //               //                   errormsg: true,
  //               //                   widget: Center(
  //               //                       child: ContentContainer(
  //               //                     content: 'No more qty to add..!!',
  //               //                     theme: theme,
  //               //                   )),
  //               //                   buttonName: null,
  //               //                 ));
  //               //           });
  //               //     }
  //             }
  //           }
  //           //   mycontroller[79].clear();
  //           // } else {
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
  //               content: 'Wrong batch scanned..!!',
  //               theme: theme,
  //             )),
  //             buttonName: null,
  //           ));
  //     });
  //         }
  //         mycontroller[79].clear();

  //         notifyListeners();
  //       }
  //     }
  //   }
  //   notifyListeners();
  // }

  // soOrderdata(
  //   ih,
  //   String basedoc,
  // ) {
  //   soData.clear();
  //   for (int ik = 0; ik < soSalesmodl[ih].item!.length; ik++) {
  //     if (soSalesmodl[ih].item![ik].basedocentry.toString() == basedoc) {
  //       if (soSalesmodl[ih].item![ik].Qty != 0) {
  //         soData.add(StocksnapModelData(
  //           docentry: basedoc.toString(),
  //           basedocentry: soSalesmodl[ih].item![ik].basedocentry,
  //           baselineid: soSalesmodl[ih].item![ik].baselineid,
  //           Branch: soSalesmodl[ih].item![ik].Branch,
  //           ItemCode: soSalesmodl[ih].item![ik].ItemCode,
  //           ItemName: soSalesmodl[ih].item![ik].ItemName,
  //           SerialBatch: '',
  //           Qty: soSalesmodl[ih].item![ik].Qty,
  //           MRP: double.parse(soSalesmodl[ih].item![ik].MRP.toString()),
  //           createdUserID: soSalesmodl[ih].item![ik].createdUserID.toString(),
  //           createdateTime: config
  //               .alignDate(soSalesmodl[ih].item![ik].createdateTime.toString()),
  //           lastupdateIp: soSalesmodl[ih].item![ik].lastupdateIp,
  //           purchasedate: soSalesmodl[ih].item![ik].purchasedate,
  //           snapdatetime: soSalesmodl[ih].item![ik].snapdatetime,
  //           specialprice:
  //               double.parse(soSalesmodl[ih].item![ik].specialprice.toString()),
  //           updatedDatetime: soSalesmodl[ih].item![ik].updatedDatetime,
  //           updateduserid: soSalesmodl[ih].item![ik].updateduserid.toString(),
  //           SellPrice:
  //               double.parse(soSalesmodl[ih].item![ik].SellPrice.toString()),
  //           Maxdiscount: soSalesmodl[ih].item![ik].Maxdiscount != null
  //               ? soSalesmodl[ih].item![ik].Maxdiscount.toString()
  //               : '',
  //           TaxRate: soSalesmodl[ih].item![ik].TaxRate != null
  //               ? double.parse(soSalesmodl[ih].item![ik].TaxRate.toString())
  //               : 0.0,
  //           discountper:
  //               double.parse(soSalesmodl[ih].item![ik].discountper!.toString()),
  //           OpenQty: soSalesmodl[ih].item![ik].Qty,
  //           InDate: '',
  //           Cost: 0,
  //           TaxType: '',
  //           InType: '',
  //           VenCode: '',
  //           VenName: '',
  //           liter: soSalesmodl[ih].item![ik].liter != null
  //               ? double.parse(soSalesmodl[ih].item![ik].liter.toString())
  //               : 0.0,
  //           weight: soSalesmodl[ih].item![ik].weight != null
  //               ? double.parse(soSalesmodl[ih].item![ik].weight.toString())
  //               : 0.0,
  //         ));
  //         notifyListeners();
  //       }
  //     }
  //     // log("soDatasoDatasoData length::" + soData.length.toString());
  //   }

  //   for (int lk = 0; lk < soData.length; lk++) {
  //     // log("sBatchFrmStksnap11111 $lk");
  //     sBatchFrmStksnap(lk);
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }

  // sBatchFrmStksnap(int index) async {
  //   // log("sBatchFrmStksnap11122222 $index");

  //   // itemchCheck = '';
  //   final Database db = (await DBHelper.getInstance())!;
  //   List<Map<String, Object?>> serialbatchCheck =
  //       await DBOperation.cfoserialBatchCheck(
  //           db, soData[index].ItemCode.toString());
  //   print("soData[index].ItemCode.toString():::" +
  //       soData[index].ItemCode.toString());
  //   for (int i = 0; i < serialbatchCheck.length; i++) {
  //     if (soData[index].ItemCode ==
  //         serialbatchCheck[i]['itemcode'].toString()) {
  //       // soData[index].SerialBatch =
  //       //     serialbatchCheck[i]['serialbatch'].toString();
  //       // itemchCheck = serialbatchCheck[i]['itemcode'].toString();

  //       // notifyListeners();
  //     }
  //   }
  //   notifyListeners();
  //   return i;
  // }

  // mapsodata(BuildContext context, ThemeData theme, int ih) async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   int? totqty;
  //   mycontroller[50].text = "";
  //   List<Address>? add5 = [];
  //   selectedcust2 = null;
  //   selectedcust = null;
  //   selectedBillAdress = 0;
  //   selectedShipAdress = 0;

  //   // for (int ih = 0; ih < soSalesmodl.length; ih++) {
  //   for (int ik = 0; ik < soData.length; ik++) {
  //     int soqty = soqtycontroller[ik].text.isNotEmpty
  //         ? int.parse(soqtycontroller[ik].text.toString())
  //         : 0;
  //     // log("soqtycontroller[ik].text.toString()::::" +
  //     //     soqtycontroller[ik].text.toString());
  //     if (soqty > 0) {
  //       for (int ikn = 0; ikn < soSalesmodl[ih].address!.length; ikn++) {
  //         add5 = [
  //           Address(
  //               billCity: soSalesmodl[ih].address![ikn].billCity,
  //               billCountry: soSalesmodl[ih].address![ikn].billCountry,
  //               billPincode: soSalesmodl[ih].address![ikn].billPincode,
  //               billstate: soSalesmodl[ih].address![ikn].billstate,
  //               address1: soSalesmodl[ih].address![ikn].address1)
  //         ];
  //         notifyListeners();
  //       }

  //       selectedcust = CustomerDetals(
  //         name: soSalesmodl[ih].custName,
  //         phNo: soSalesmodl[ih].phNo,
  //         cardCode: soSalesmodl[ih].cardCode,
  //         accBalance: double.parse(soSalesmodl[ih].accBalance.toString()),
  //         point: soSalesmodl[ih].point,
  //         address: add5!,
  //         tarNo: soSalesmodl[ih].tarNo,
  //         docentry: soSalesmodl[ih].docentry.toString(),
  //         email: soSalesmodl[ih].email,
  //       );

  //       notifyListeners();
  //       for (int i = 0; i < soScanItem.length; i++) {
  //      // log("soScanItemsoScanItem555::" + soScanItem.length.toString());
  //         scanneditemData.add(StocksnapModelData(
  //           Branch: soScanItem[i].Branch,
  //           ItemCode: soScanItem[i].ItemCode,
  //           ItemName: soScanItem[i].ItemName,
  //           basedocentry: soScanItem[i].basedocentry,
  //           baselineid: soScanItem[i].baselineid,
  //           SerialBatch: soScanItem[i].SerialBatch,
  //           Qty:
  //               // soScanItem[i].Qty,
  //               int.parse(soqtycontroller[ik].text.toString()),
  //           MRP: double.parse(soScanItem[i].MRP.toString()),
  //           createdUserID: soScanItem[i].createdUserID.toString(),
  //           createdateTime: soScanItem[i].createdateTime != null
  //               ? soScanItem[i].createdateTime.toString()
  //               : '',
  //           lastupdateIp: soScanItem[i].lastupdateIp,
  //           purchasedate: soScanItem[i].purchasedate ?? '',
  //           snapdatetime: soScanItem[i].snapdatetime,
  //           specialprice: soScanItem[i].specialprice != null
  //               ? double.parse(soScanItem[i].specialprice.toString())
  //               : 0,
  //           updatedDatetime: soScanItem[i].updatedDatetime,
  //           updateduserid: soScanItem[i].updateduserid.toString(),
  //           SellPrice: double.parse(soData[ik].SellPrice.toString()),
  //           Maxdiscount: soScanItem[i].Maxdiscount != null
  //               ? soScanItem[i].Maxdiscount.toString()
  //               : '',
  //           TaxRate: soScanItem[i].TaxRate != null
  //               ? double.parse(soScanItem[i].TaxRate.toString())
  //               : 0.0,
  //           discountper: soScanItem[i].discountper,
  //           OpenQty: 0,
  //           InDate: '',
  //           Cost: 0,
  //           TaxType: '',
  //           InType: '',
  //           VenCode: '',
  //           VenName: '',
  //           liter: soScanItem[i].liter != null
  //               ? double.parse(soScanItem[i].liter.toString())
  //               : 0.0,
  //           weight: soScanItem[i].weight != null
  //               ? double.parse(soScanItem[i].weight.toString())
  //               : 0.0,
  //         ));
  //       }
  //     }
  //     for (int il = 0; il < scanneditemData.length; il++) {
  //       qtymycontroller[il].text = scanneditemData[il].Qty.toString();
  //       // log("soqtycontroller[ik].text.toString()::" +
  //       //     soqtycontroller[ik].text.toString().toString());
  //       notifyListeners();
  //       // discountcontroller[il].text =
  //       //     scanneditemData[il].discountper!.toString();
  //     }
  //     // log("So scanneditemDatascanneditemData::" +
  //     //     scanneditemData.length.toString());
  //   }
  //   // else {
  //   //   showDialog(
  //   //       context: context,
  //   //       barrierDismissible: true,
  //   //       builder: (BuildContext context) {
  //   //         return AlertDialog(
  //   //             contentPadding: EdgeInsets.all(0),
  //   //             content: AlertBox(
  //   //                 payMent: 'Alert',
  //   //                 errormsg: true,
  //   //                 widget: Center(
  //   //                     child: ContentContainer(
  //   //                   content: 'Please scan the serial batch',
  //   //                   theme: theme,
  //   //                 )),
  //   //                 buttonName: null));
  //   //       });
  //   // }
  //   notifyListeners();
  //   getcustaddresslist();
  //   calCulateDocVal(context, theme);
  //   notifyListeners();
  // }

  //
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
      print('datata1111::'+e.toString());
      showSnackBars("$e", Colors.red);
    }
    return 'null';
  }

  createDBFile(String path) async {
    try {
      String getPath = "$path/PosDBV2.db";
      print("getPath::"+getPath);
      await source1!.copy(getPath);
      showSnackBars("Created!!...", Colors.green);
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
  }

  clearSuspendedData(BuildContext context, ThemeData theme) {
    mycontroller = List.generate(150, (i) => TextEditingController());
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    discountcontroller = List.generate(100, (ij) => TextEditingController());
    OndDisablebutton = true;
    scanneditemData.clear();
    remarkcontroller3.text = '';
    selectedcust = null;
    selectedcust55 = null;
    newAddrsValue = [];
    newCustValues = [];
    billadrrssItemlist = [];
    shipadrrssItemlist = [];
    billadrrssItemlist5 = [];
    shipadrrssItemlist5 = [];
    mycontroller[50].clear();
    cpyfrmso = '';
    paymentWay.clear();
    totalPayment = null;
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

    mycontroller = List.generate(150, (i) => TextEditingController());
    getdraftindex();
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

  // getPrintindex() async {
  //   final Database db = (await DBHelper.getInstance())!;

  //   List<Map<String, Object?>> getDBholddata5 = await DBOperation.salestoprint(db);
  //   for (int i = 0; i < getDBholddata5.length; i++) {
  //     print(i.toString());
  //     getPrint(i);
  //   }
  //   notifyListeners();
  // }

  // List<SalesModel> onPrintFilter = [];

  // getPrint(int ji) async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   List<Map<String, Object?>> getDBholddata1 = await DBOperation.salestoprint(db);

  //   List<StocksnapModelData> scannData = [];
  //   salesmodl = [];
  //   onPrintFilter = [];
  //   List<Map<String, Object?>>? getDBholdSalesLine = await DBOperation.holdSalesLineDB(db, int.parse(getDBholddata1[ji]['docentry'].toString()));

  //   for (int ik = 0; ik < getDBholdSalesLine.length; ik++) {
  // //log("getDBholdSalesLine.length:${getDBholdSalesLine.length}");
  //     if (getDBholddata1[ji]['docentry'] == getDBholdSalesLine[ik]['docentry']) {
  //       print("${getDBholddata1[ji]['docentry'].toString()}::${getDBholdSalesLine[ik]['docentry']}");
  //       scannData.add(StocksnapModelData(
  //           basic: getDBholdSalesLine[ik]['basic'] != null ? double.parse(getDBholdSalesLine[ik]['basic'].toString()) : 00,
  //           netvalue: getDBholdSalesLine[ik]['netlinetotal'] != null ? double.parse(getDBholdSalesLine[ik]['netlinetotal'].toString()) : null,
  //           TransID: int.parse(getDBholdSalesLine[ik]['docentry'].toString()),
  //           Branch: getDBholdSalesLine[ik]['branch'].toString(),
  //           ItemCode: getDBholdSalesLine[ik]['itemcode'].toString(),
  //           ItemName: getDBholdSalesLine[ik]['itemname'].toString(),
  //           SerialBatch: getDBholdSalesLine[ik]['serialbatch'].toString(),
  //           OpenQty: int.parse(getDBholdSalesLine[ik]['quantity'].toString()),
  //           Qty: int.parse(getDBholdSalesLine[ik]['quantity'].toString()),
  //           InDate: getDBholdSalesLine[ik][''].toString(),
  //           InType: getDBholdSalesLine[ik][''].toString(),
  //           VenCode: getDBholdSalesLine[ik][''].toString(),
  //           VenName: getDBholdSalesLine[ik][''].toString(),
  //           MRP: 0,
  //           SellPrice: double.parse(getDBholdSalesLine[ik]['price'].toString()),
  //           Cost: 0,
  //           discount: getDBholdSalesLine[ik]['discperunit'] != null ? double.parse(getDBholdSalesLine[ik]['discperunit'].toString()) : 00,
  //           taxvalue: getDBholdSalesLine[ik]['taxtotal'] != null ? double.parse(getDBholdSalesLine[ik]['taxtotal'].toString()) : 00,
  //           TaxRate: double.parse(getDBholdSalesLine[ik]['taxrate'].toString()),
  //           TaxType: getDBholdSalesLine[ik]['taxtype'].toString(),
  //           Maxdiscount: getDBholdSalesLine[ik]['maxdiscount'].toString(),
  //           discountper: getDBholdSalesLine[ik]['discperc'] == null ? 0.0 : double.parse(getDBholdSalesLine[ik]['discperc'].toString()),
  //           basedocentry: getDBholdSalesLine[ik]['basedocentry'] != null ? getDBholdSalesLine[ik]['basedocentry'].toString() : "",
  //           baselineid: getDBholdSalesLine[ik]['baselineID'] != null ? getDBholdSalesLine[ik]['baselineID'].toString() : "",
  //           createdUserID: '',
  //           createdateTime: '',
  //           lastupdateIp: '',
  //           purchasedate: '',
  //           snapdatetime: '',
  //           specialprice: 0,
  //           updatedDatetime: '',
  //           updateduserid: '',
  //           liter: getDBholdSalesLine[ik]['liter'] != null ? double.parse(getDBholdSalesLine[ik]['liter'].toString()) : 00,
  //           weight: getDBholdSalesLine[ik]['weight'] != null ? double.parse(getDBholdSalesLine[ik]['weight'].toString()) : 00)); //discperc
  //     }
  //     notifyListeners();
  //   }

  //   SalesModel salesM = SalesModel(
  //     ordReference: getDBholddata1[ji]['remarks'].toString(),
  //     objname: getDBholddata1[ji]['objname'].toString(),
  //     objtype: getDBholddata1[ji]['objtype'].toString(),
  //     doctype: getDBholddata1[ji]['doctype'].toString(),
  //     docentry: int.parse(getDBholddata1[ji]['docentry'].toString()),
  //     custName: getDBholddata1[ji]['customername'].toString(),
  //     phNo: getDBholddata1[ji]['customerphono'].toString(),
  //     cardCode: getDBholddata1[ji]['customercode'].toString(),
  //     accBalance: getDBholddata1[ji]['customeraccbal'].toString(),
  //     point: getDBholddata1[ji]['customerpoint'].toString(),
  //     tarNo: getDBholddata1[ji]['taxno'].toString(),
  //     email: getDBholddata1[ji]['customeremail'].toString(),
  //     invoceDate: getDBholddata1[ji]['createdateTime'].toString(),
  //     invoiceNum: getDBholddata1[ji]['documentno'].toString(),
  //     sapOrderNum: getDBholddata1[ji]['basedocentry'].toString(),
  //     sapInvoiceNum: getDBholddata1[ji]['sapDocNo'].toString(),
  //     address: [
  //       Address(
  //           address1: getDBholddata1[ji]['billaddressid'].toString(),
  //           //
  //           billCity: getDBholddata1[ji]['city'].toString(),
  //           billCountry: getDBholddata1[ji]['country'].toString(),
  //           billPincode: getDBholddata1[ji]['pinno'].toString(),
  //           billstate: getDBholddata1[ji]['state'].toString())
  //     ],
  //     totalPayment: TotalPayment(
  //       balance: getDBholddata1[ji]['baltopay'] == null ? 0.00 : double.parse(getDBholddata1[ji]['baltopay'].toString()),

  //       discount2: getDBholddata1[ji]['docdiscamt'] == null ? 0.00 : double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
  //       // double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
  //       discount: getDBholddata1[ji]['docdiscamt'] == null ? 0.00 : double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
  //       totalTX: double.parse(getDBholddata1[ji]['taxamount'] == null ? '0' : getDBholddata1[ji]['taxamount'].toString().replaceAll(',', '')),

  //       subtotal: double.parse(getDBholddata1[ji]['docbasic'] == null ? '0' : getDBholddata1[ji]['docbasic'].toString().replaceAll(',', '')), //doctotal

  //       totalDue: double.parse(getDBholddata1[ji]['doctotal'] == null ? '0' : getDBholddata1[ji]['doctotal'].toString().replaceAll(',', '')),
  //       totpaid: double.parse(getDBholddata1[ji]['amtpaid'] == null ? '0' : getDBholddata1[ji]['amtpaid'].toString().replaceAll(',', '')),
  //     ),
  //     item: scannData,
  //   );

  //   notifyListeners();

  //   salesmodl.add(salesM);

  //   log("salesmodl.item.length:${salesM.item!.length}");
  //   notifyListeners();
  //   onPrintFilter = salesmodl;
  //   notifyListeners();
  // }

  Invoice? invoice = Invoice();
  List<Address> address2 = [];
  String? remark;
  double exclTxTotal = 0;
  double inclTxTotal = 0;
  double vatTx = 0;
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

  mapCallSalesInfoApiForPDF(
      preff, BuildContext context, ThemeData theme) async {
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
          descripton: salesmodl[ih].item![i].ItemName,
          unitPrice: double.parse(
              salesmodl[ih].item![i].SellPrice!.toStringAsFixed(2)),
          quantity: salesmodl[ih].item![i].Qty,
          dics: salesmodl[ih].item![i].discountper,
          vat:
              double.parse(salesmodl[ih].item![i].taxvalue!.toStringAsFixed(2)),
          pails: int.parse(salesmodl[ih].item![i].pails!.toString()),
          cartons: int.parse(salesmodl[ih].item![i].cartons!.toString()),
          looseTins: double.parse(salesmodl[ih].item![i].looseTins!.toString()),
          tonnage: double.parse(salesmodl[ih].item![i].tonnage!.toString()),
          // totalPack: int.parse(salesmodl[ih].item![i].totalPack!.toString()),
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
    PdfInvoiceApiii.exclTxTotal = 0;
    PdfInvoiceApiii.vatTx = 0;
    PdfInvoiceApiii.inclTxTotal = 0;
    if (invoice!.items!.length > 0) {
      for (int i = 0; i < invoice!.items!.length; i++) {
        invoice!.items![i].basic =
            (invoice!.items![i].quantity!) * (invoice!.items![i].unitPrice!);
        invoice!.items![i].discountamt =
            (invoice!.items![i].basic! * invoice!.items![i].dics! / 100);
        // double netvalue
        invoice!.items![i].netTotal =
            (invoice!.items![i].basic!) - (invoice!.items![i].discountamt!);
        PdfInvoiceApiii.exclTxTotal =
            (PdfInvoiceApiii.exclTxTotal) + (invoice!.items![i].netTotal!);
        PdfInvoiceApiii.vatTx = (PdfInvoiceApiii.vatTx) +
            double.parse(invoice!.items![i].vat.toString());
        PdfInvoiceApiii.inclTxTotal =
            double.parse(invoice!.items![i].unitPrice.toString()) +
                double.parse(invoice!.items![i].vat.toString());
        PdfInvoiceApiii.pails =
            PdfInvoiceApiii.pails! + invoice!.items![i].pails!;
        PdfInvoiceApiii.cartons =
            PdfInvoiceApiii.cartons! + invoice!.items![i].cartons!;
        PdfInvoiceApiii.looseTins =
            PdfInvoiceApiii.looseTins! + invoice!.items![i].looseTins!;
        PdfInvoiceApiii.tonnage =
            PdfInvoiceApiii.tonnage! + invoice!.items![i].tonnage!;
        notifyListeners();
      }
      PdfInvoiceApiii.totalPack = PdfInvoiceApiii.pails! +
          PdfInvoiceApiii.cartons! +
          PdfInvoiceApiii.looseTins!;
      PdfInvoiceApiii.inclTxTotal =
          (PdfInvoiceApiii.exclTxTotal) + (PdfInvoiceApiii.vatTx);
      //log("invoice.items:::${invoice!.items!.length}");
      int length = invoice!.items!.length;
      if (length > 0) {
        // PdfInvoiceApiii.height = length + 19;
        notifyListeners();
      }

      PdfInvoiceApiii.iinvoicee = invoice;
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

  printingdoc(BuildContext context, ThemeData theme) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PdfInvoiceApiii('Printing Document', theme)));
    notifyListeners();
  }

  clearAllData(BuildContext context, ThemeData theme) {
    formkeyy = List.generate(100, (i) => GlobalKey<FormState>());
    focusnode = List.generate(100, (i) => FocusNode());
    soScanItem = [];
    itemsDocDetails = [];
    custseriesNo = null;
    schemebtnclk = false;
    cancelbtn = false;
    textError = '';
    loadingscrn = false;
    newAddrsValue = [];
    newCustValues = [];
    billadrrssItemlist = [];
    shipadrrssItemlist = [];
    billadrrssItemlist5 = [];
    shipadrrssItemlist5 = [];
    cpyfrmso = '';
    remarkcontroller3.text = '';
    formkeyAdd = GlobalKey<FormState>();
    mycontroller = List.generate(150, (i) => TextEditingController());
    mycontroller2 = List.generate(150, (i) => TextEditingController());
    remarkcontroller3 = TextEditingController();
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    discountcontroller = List.generate(100, (ij) => TextEditingController());
    qtymycontroller2 = List.generate(100, (ij) => TextEditingController());
    soqtycontroller = List.generate(100, (ij) => TextEditingController());
    searchcontroller = TextEditingController();
    selectedcust = null;
    paymentWay.clear();
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
    searchmapbool = false;
    totalPayment = null;
    totalPayment2 = null;
    filtersearchData.clear();
    selectedcust2 = null;
    searchData.clear();
    soTotal = 0;
    soSalesmodl.clear();
    cpyfrmso = '';
    itemcodelistitem.clear();
    onHoldFilter.clear();
    onHold.clear();
    totquantity = null;
    discountamt = null;
    totquantity = null;
    discountamt = null;
    cashpayment = null;
    cashpayment = null;

    cqpayment = null;

    transpayment = null;
    chqnum = null;

    transrefff = null;
    salesmodl.clear();
    soData.clear();
    newCustValues.clear();
    newAddrsValue.clear();
    clearTextField();
    clearCustomer();
    clearAddress();
    itemData.clear();
    selectedShipAdress = 0;
    selectedBillAdress = 0;
    notifyListeners();
  }
}
