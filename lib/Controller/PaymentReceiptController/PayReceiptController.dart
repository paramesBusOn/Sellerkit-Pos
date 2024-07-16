// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, avoid_print, unnecessary_null_comparison, dead_code
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/SalesQuotationController/SalesQuotationController.dart';
import 'package:posproject/DBModel/Receipt.dart';
import 'package:posproject/DBModel/ReceiptLine2.dart';
import 'package:posproject/DBModel/RecieptLine1.dart';
import 'package:posproject/Models/DataModel/SalesOrderModel.dart';
import 'package:posproject/Models/Service%20Model/GroupCustModel.dart';
import 'package:posproject/Models/Service%20Model/PamentGroupModel.dart';
import 'package:posproject/Models/Service%20Model/TeriTeriModel.dart';
import 'package:posproject/Service/AccountBalanceAPI.dart';
import 'package:posproject/Service/NewCustCodeCreate/CreatecustPostApi%20copy.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerGropApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerSeriesApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/FileUploadApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/PaymentGroupApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/TeritoryApi.dart';
import 'package:posproject/ServiceLayerAPIss/InvoiceAPI/InvoiceLoginnAPI.dart';
import 'package:posproject/Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../Models/DataModel/CouponsDetailsModel/CouponDetModel.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/PayReceiptModel/InvoicePayReceipt.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import 'package:posproject/Constant/UserValues.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/SeriesModel.dart';
import '../../Models/ServiceLayerModel/ReceiptModel/PostReceiptLineMode.dart';
import '../../Service/NewCustCodeCreate/NewAddCreatePatchApi.dart';
import '../../ServiceLayerAPIss/Paymentreceipt/PostpaymentDataAPI.dart';
import '../../Widgets/AlertBox.dart';

class PayreceiptController extends ChangeNotifier {
  init() {
    callClearAllData();
    getdraftindex();
    injectfromdb();
    getCustSeriesApi();
    notifyListeners();
  }

  Configure config = Configure();

  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());
  GlobalKey<FormState> formkeyAd = GlobalKey<FormState>();
  GlobalKey<FormState> formkeyShipAd = GlobalKey<FormState>();
  List<CustomerModelDB> newCustValues = [];
  List<CustomerAddressModelDB> newBillAddrsValue = [];
  List<CustomerAddressModelDB> newShipAddrsValue = [];
  List<CustomerAddressModelDB> billcreateNewAddress = [];
  List<CustomerAddressModelDB> shipcreateNewAddress = [];
  List<Address> billadrrssItemlist = [];
  List<Address> shipadrrssItemlist = [];
  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  bool OndDisablebutton = false;
  List<CustomerAddressModelDB> createNewAddress = [];
  bool hintcolor = false;
  bool get gethintcolor => hintcolor;
  List<SalesModel>? onHoldFilter = [];
  List<SalesModel> onHoldValue = [];
  double onacc = 0;
  List<InvoicePayReceipt>? holdInvoiceItem = [];

  String? msgforAmount;
  String? get getmsgforAmount => msgforAmount;

  int selectedCustomer = 0;
  int get getselectedCustomer => selectedCustomer;
  bool checkboxx = false;
  int selectedBillAdress = 0;
  int? get getselectedBillAdress => selectedBillAdress;
  String? sameInvNum;
  CustomerDetals? topselectedcust;
  CustomerDetals? get gettopselectedcust => topselectedcust;
  TextEditingController remarkcontroller3 = TextEditingController();
  CustomerDetals? selectedcust55;
  CustomerDetals? get getselectedcust55 => selectedcust55;
  CustomerDetals? selectedcust;
  CustomerDetals? get getselectedcust => selectedcust;
  CustomerDetals? selectedcust25;
  CustomerDetals? get getselectedcust25 => selectedcust25;
  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;
  CustomerDetals? selectedcust2;
  CustomerDetals? get getselectedcust2 => selectedcust2;
  List<TextEditingController> mycontroller2 =
      List.generate(150, (i) => TextEditingController());

  List<searchModel> searchData = [];
  bool searchbool = false;
  List<searchModel> filtersearchData = [];
  List<PaymentWay> paymentWay = [];
  List<PaymentWay> get getpaymentWay => paymentWay;

  List<PaymentWay> paymentWay2 = [];
  List<PaymentWay> get getpaymentWay2 => paymentWay2;
  List<InvoicePayReceipt> scanneditemData2 = [];
  List<InvoicePayReceipt> get getScanneditemData2 => scanneditemData2;
  TotalPayment? totalPayment2;
  double? totalduepay2 = 0;
  CouponDetModel cpndata = CouponDetModel();
  List<CouponDetModel> couponData = [];
  bool _isVisible = true;

  bool get get_isVisible => _isVisible;
  ScrollController hideButtonController =
      ScrollController(initialScrollOffset: 0.0);
  String advancetype = '';
  List<SalesModel> salesPayModell5 = [];
  List<InvoicePayReceipt> scanneditemData = [];
  List<InvoicePayReceipt> get getScanneditemData => scanneditemData;
  double? totpaidamt = 0;
  bool isExpanded = false;
  bool isExpanded2 = true;
  SalesModel? selectcust;
  SalesModel? get getselectcust => selectcust;
  double? totalduepay = 0;
  double? totalinvamt;
  String holddocentry = '';
  String? autoidddd;
  String? selectedcustcode;
  List<InvoicePayReceipt> filterInvList = [];
  double invAmt = 0;
  String typeee = '';
  List<CustomerDetals> filtercustList1 = [];
  List<CustomerDetals> get getfiltercustList1 => filtercustList1;

  List<CustomerAddressModelDB> newAddrsValue = [];
  List<CustomerDetals> custList = [];

  List<SalesModel> filtercustList = [];
  List<SalesModel> get getfiltercustList => filtercustList;

  List<CustomerDetals> custList2 = [];
  int totalinvdamtamt = 0;

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  String? sapDocentry = '';
  String sapDocuNumber = '';

  String? custseriesNo;
  // String? mapcustseriesNo;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  List<SeriesModelData> seriesData = [];
  List<GroupCustData> groupcData = [];
  List<GetTeriteriData> teriteritData = [];
  List<GetPayGrpData>? paygroupData = [];
  String? custerrormsg = '';
  bool groCustLoad = false;
  bool loadingBtn = false;
  bool? fileValidation = false;
  File? tinFiles;
  File? vatFiles;
  String? teriteriValue;
  String? codeValue;
  String? paygrpValue;
  FilePickerResult? result;
  List<FilesData> filedata = [];
  bool advancests = false;
  double? totpaidamt2 = 0.0;
  String textError = '';
  String vatfileError = '';
  String tinfileError = '';
  String? custautoid;
  callClearAllData() {
    advancests = false;
    formkey = List.generate(50, (i) => GlobalKey<FormState>());
    formkeyAd = GlobalKey<FormState>();
    mycontroller2 = List.generate(150, (i) => TextEditingController());
    mycontroller = List.generate(150, (i) => TextEditingController());
    OndDisablebutton = false;
    selectedShipAdress = 0;
    selectedcust25 = null;
    msgforAmount = null;
    newAddrsValue = [];
    newCustValues = [];
    selectedCustomer = 0;
    filtersearchData.clear();
    remarkcontroller3 = TextEditingController();
    searchData.clear();
    selectedBillAdress = 0;
    checkboxx = false;
    _isVisible = true;
    hintcolor = false;
    advancetype = '';
    holddocentry = '';
    totalduepay2 = 0;
    totalduepay = 0;
    onHoldFilter = [];
    onHoldValue = [];
    couponData = [];
    salesPayModell5 = [];
    createNewAddress.clear();
    scanneditemData = [];
    invAmt = 0;
    typeee = '';
    totpaidamt = 0;
    isExpanded = false;
    isExpanded2 = true;
    selectcust = null;
    selectedcust2 = null;
    totalinvamt = null;
    selectedcust = null;
    selectedcust55 = null;
    selectedcust25 = null;
    topselectedcust = null;
    custList2 = [];
    totalinvdamtamt = 0;
    totalduepay = null;
    autoidddd = null;
    selectedcustcode = null;
    filterInvList = [];
    filtercustList1 = [];
    newCustValues = [];
    newAddrsValue = [];
    custList = [];
    filtercustList = [];
    onacc = 0;
    holdInvoiceItem = [];
    cpndata = CouponDetModel();
    paymentWay2 = [];
    paymentWay = [];
    totalPayment2 = null;
    sameInvNum = null;
    totalduepay2 = null;
    searchbool = false;
    scanneditemData2 = [];
    hideButtonController = ScrollController(initialScrollOffset: 0.0);
    itemsPaymentCheckDet = [];
    itemsPaymentInvDet = [];
    clearTextField();
  }

  // checkcolor(bool val) {
  //   for (int i = 0; i < selectcust!.payItem!.length; i++) {
  //     if (selectcust!.payItem![i].checkbx == 0 &&
  //         selectcust!.payItem![i].checkClr == false) {
  //       print("Select All");
  //       selectcust!.payItem![i].checkbx = 1;
  //       selectcust!.payItem![i].checkClr = true;
  //       totalduepay = totalduepay + selectcust!.payItem![i].amount!;
  //       notifyListeners();
  //     } else {
  //       if (selectcust!.payItem![i].checkbx == 1 &&
  //           selectcust!.payItem![i].checkClr == true) {
  //         print("deSelect All");
  //         selectcust!.payItem![i].checkbx = 0;
  //         selectcust!.payItem![i].checkClr = false;
  //         totalduepay = totalduepay - selectcust!.payItem![i].amount!;
  //         notifyListeners();
  //       }
  //     }
  //     notifyListeners();
  //   }
  //   print("select all :" + totalduepay.toString());
  // }
  changeBillAddress(int slcAdrs) {
    selectedBillAdress = slcAdrs;
    notifyListeners();
  }

  changeShipAddress(int slcAdrs) {
    selectedShipAdress = slcAdrs;
    notifyListeners();
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

  fixDataMethod(int docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBReceipt2 =
        await DBOperation.getReceiptLine2(db, docentry);
    List<Map<String, Object?>> getDBReceiptLine =
        await DBOperation.getReceiptLine1(db, docentry);
    List<Map<String, Object?>> getDBReceiptHeader =
        await DBOperation.getReceiptHeaderDB(db, docentry);
    scanneditemData2.clear();
    paymentWay2.clear();
    mycontroller2[50].text = "";
    selectedcust2 = null;
    advancests = true;
    // List<Map<String, Object?>> getDBsalesdata1 =
    //     await DBOperation.getSalesheadCkout2(
    //         db, getDBReceiptHeader[0]['customer'].toString());
    mycontroller2[50].text = getDBReceiptHeader[0]['remarks'].toString();

    List<Address>? address = [];
    List<Address>? address25 = [];

    List<Map<String, Object?>> custDataDet =
        await DBOperation.getCstmMasDatabyautoid(
            db, getDBReceiptHeader[0]['customer'].toString());

    List<CustomerAddressModelDB> csadresdataDB =
        await DBOperation.createNewgetCstmMasAddDB(
            db, getDBReceiptHeader[0]['customer'].toString());
    for (int k = 0; k < csadresdataDB.length; k++) {
      // if (csadresdataDB[k].custcode.toString() ==
      //     getDBReceiptHeader[0]['customer'].toString()) {
      //log("XXXXXXXXXXXXXXXXXx::: ${csadresdataDB[k].addresstype}");
      if (csadresdataDB[k].addresstype == 'B') {
        address = [
          Address(
              autoId: int.parse(csadresdataDB[k].autoid.toString()),
              address1: csadresdataDB[k].address1!.isNotEmpty
                  ? csadresdataDB[k].address1
                  : '',
              address2: csadresdataDB[k].address2,
              address3: csadresdataDB[k].address3,
              addresstype: csadresdataDB[k].addresstype,
              custcode: csadresdataDB[k].custcode,
              billCity: csadresdataDB[k].city!, //city
              billCountry: csadresdataDB[k].countrycode!, //country
              billPincode: csadresdataDB[k].pincode!, //pinno
              billstate: csadresdataDB[k].statecode)
        ];
      }

      //log("address2address2::${address!.length}");
      if (csadresdataDB[k].addresstype.toString() == "S") {
        // custDataDet[0]['shipaddresid'].toString()) {
        address25 = [
          Address(
              autoId: int.parse(csadresdataDB[k].autoid.toString()),
              address1: csadresdataDB[k].address1,
              address2: csadresdataDB[k].address2,
              address3: csadresdataDB[k].address3,
              addresstype: csadresdataDB[k].addresstype,
              custcode: csadresdataDB[k].custcode,
              billCity: csadresdataDB[k].city!, //city
              billCountry: csadresdataDB[k].countrycode!, //country
              billPincode: csadresdataDB[k].pincode!, //pinno
              billstate: csadresdataDB[k].statecode)
        ];
      }
    }
    // }

    selectedcust2 = CustomerDetals(
      name: custDataDet[0]["customername"].toString(), // customername!.name
      phNo: custDataDet[0]["phoneno1"].toString(), //customerphono
      docentry: getDBReceiptHeader[0]["docentry"].toString(),
      cardCode:
          custDataDet[0]["customercode"].toString(), //customercode!.cardCode
      accBalance: double.parse(custDataDet[0]["balance"]
          .toString()
          .replaceAll(",", '')), //customeraccbal
      point: custDataDet[0]["points"].toString(), //customerpoint
      address: address,
      tarNo: custDataDet[0]["taxno"].toString(), //taxno
      email: custDataDet[0]["emalid"].toString(), //customeremail
      invoicenum: getDBReceiptHeader[0]["documentno"].toString(),
      invoiceDate: getDBReceiptHeader[0]["createdateTime"].toString(),
      totalPayment: getDBReceiptHeader[0][""] == null
          ? 0.0
          : double.parse(getDBReceiptHeader[0][""].toString()),
    );
    selectedcust25 = CustomerDetals(
      name: custDataDet[0]["customername"].toString(), // customername!.name
      phNo: custDataDet[0]["customerphono"].toString(), //customerphono
      docentry: custDataDet[0]["docentry"].toString(),
      cardCode:
          custDataDet[0]["customercode"].toString(), //customercode!.cardCode
      accBalance:
          double.parse(custDataDet[0]["balance"].toString()), //customeraccbal
      point: custDataDet[0]["customerpoint"].toString(), //customerpoint
      address: address25,
      tarNo: custDataDet[0]["taxno"].toString(), //taxno
      email: custDataDet[0]["customeremail"].toString(), //customeremail
      invoicenum: getDBReceiptHeader[0]["documentno"].toString(),
      invoiceDate: getDBReceiptHeader[0]["createdateTime"].toString(),
      totalPayment: getDBReceiptHeader[0]["totalamount"] == null
          ? 0.0
          : double.parse(getDBReceiptHeader[0]["totalamount"].toString()),
    );
    notifyListeners();

    notifyListeners();

    // selectedBillAdress = selectedcust2!.address!.length - 1;
    // selectedShipAdress = selectedcust25!.address!.length - 1;
    //  getcustaddresslist();
    notifyListeners();
//  for (int ig = 0; ig < getDBsalesdata1.length; ig++) {
    // if (getDBReceiptHeader[0]['customer'].toString() ==
    //     getDBsalesdata1[ig]['customercode'].toString()) {
    // CustomerDetals customerde = CustomerDetals(
    //     accBalance: getDBsalesdata1[0]['customeraccbal'] == null
    //         ? 0.0
    //         : double.parse(getDBsalesdata1[0]['customeraccbal'].toString()),
    //     name: getDBsalesdata1[0]['customername'].toString(),
    //     phNo: getDBsalesdata1[0]['customerphono'].toString(),
    //     cardCode: getDBsalesdata1[0]['customercode'].toString(),
    //     point: getDBsalesdata1[0]['customerpoint'].toString(),
    //     address: [
    //       Address(
    //         address1: getDBsalesdata1[0]['billaddressid'].toString(),
    //         billCity: getDBsalesdata1[0]['city'].toString(),
    //         billCountry: getDBsalesdata1[0]['country'].toString(),
    //         billPincode: getDBsalesdata1[0]['pinno'].toString(),
    //         billstate: getDBsalesdata1[0]['state'].toString(),
    //       ),
    //     ],
    //     tarNo: getDBsalesdata1[0]['taxno'].toString(),
    //     email: getDBsalesdata1[0]['customeremail'].toString(),
    //     invoiceDate: getDBsalesdata1[0]['createdateTime'].toString(),
    //     invoicenum: getDBsalesdata1[0]['documentno'].toString(),
    //     docentry: getDBReceiptHeader[0]['transdocentry'].toString());
    // selectedcust2 = customerde;
    // // log("customeredetailss name:" + selectedcust2!.name!.toString());
    // }
    // }
    // CustomerDetals customerde = CustomerDetals(
    //     accBalance:
    //         double.parse(getDBReceiptHeader[0]['customeraccbal'].toString()),
    //     name: getDBReceiptHeader[0]['customer'].toString(), //1
    //     phNo: getDBReceiptHeader[0]['customerphono'].toString(),
    //     cardCode: getDBReceiptHeader[0]['customercode'].toString(),
    //     point: getDBReceiptHeader[0]['customerpoint'].toString(),
    //     address: [
    //       Address(
    //         address1: getDBReceiptHeader[0]['billaddressid'].toString(),
    //         billCity: getDBReceiptHeader[0]['city'].toString(),
    //         billCountry: getDBReceiptHeader[0]['country'].toString(),
    //         billPincode: getDBReceiptHeader[0]['pinno'].toString(),
    //         billstate: getDBReceiptHeader[0]['state'].toString(),
    //       ),
    //     ],
    //     tarNo: getDBReceiptHeader[0]['taxno'].toString(),
    //     email: getDBReceiptHeader[0]['customeremail'].toString(),
    //     invoiceDate: getDBReceiptHeader[0]['createdateTime'].toString(),
    //     invoicenum: getDBReceiptHeader[0]['documentno'].toString(),
    //     docentry: getDBReceiptHeader[0]['transdocentry'].toString());
    // selectedcust2 = customerde;

    notifyListeners();

    for (int ik = 0; ik < getDBReceiptLine.length; ik++) {
      scanneditemData2.add(InvoicePayReceipt(
        date: getDBReceiptLine[ik]['TransDocDate'].toString(),
        amount: double.parse(getDBReceiptLine[ik]['TransAmount'].toString()),
        docNum: getDBReceiptLine[ik]['TransDocNum'].toString(),
        doctype: getDBReceiptLine[ik]['transType'].toString(),
        transdocentry: getDBReceiptLine[ik]['transDocEnty'].toString(),
        checkClr: true,
        checkbx: 1,
        sapbasedocentry:
            int.parse(getDBReceiptHeader[0]["sapInvoicedocentry"].toString()),
        // null,sapInvoicedocentry
      ));
      mycontroller2[ik].text = getDBReceiptLine[ik]['TransAmount'].toString();
      totalduepay2 = totalduepay2 != null
          ? totalduepay2! +
              double.parse(getDBReceiptLine[ik]['TransAmount'].toString())
          : 0.00;

      notifyListeners();
    }
    for (int kk = 0; kk < getDBReceipt2.length; kk++) {
      paymentWay2.add(PaymentWay(
        amt: double.parse(getDBReceipt2[kk]['rcamount'].toString()),
        type: getDBReceipt2[kk]['rcmode'].toString(),
        dateTime: getDBReceipt2[kk]['createdateTime'].toString(),
        reference: getDBReceipt2[kk]['reference'] != null
            ? getDBReceipt2[kk]['reference'].toString()
            : '',
        cardApprno: getDBReceipt2[kk]['cardApprno'] != null
            ? getDBReceipt2[kk]['cardApprno'].toString()
            : '',
        cardref: getDBReceipt2[kk]['cardref'].toString(),
        cardterminal: getDBReceipt2[kk]['cardterminal'].toString(),
        chequedate: getDBReceipt2[kk]['chequedate'].toString(),
        chequeno: getDBReceipt2[kk]['chequeno'].toString(),
        couponcode: getDBReceipt2[kk]['couponcode'].toString(),
        coupontype: getDBReceipt2[kk]['coupontype'].toString(),
        discountcode: getDBReceipt2[kk]['discountcode'].toString(),
        discounttype: getDBReceipt2[kk]['discounttype'].toString(),
        recoverydate: getDBReceipt2[kk]['recoverydate'].toString(),
        redeempoint: getDBReceipt2[kk]['redeempoint'].toString(),
        availablept: getDBReceipt2[kk]['availablept'].toString(),
        remarks: getDBReceipt2[kk]['remarks'].toString(),
        transtype: getDBReceipt2[kk]['transtype'].toString(),
        walletid: getDBReceipt2[kk]['walletid'].toString(),
        wallettype: getDBReceipt2[kk]['wallettype'].toString(),
        basedoctype: '',
      ));
    }
    notifyListeners();
  }

  totalpaidamt2() {
    totalduepay2 = 0;
    double myctrlval = 0;
    for (int i = 0; i < scanneditemData2.length; i++) {
      if (scanneditemData2[i].amount! >=
          double.parse(mycontroller2[i].text.toString())) {
        myctrlval = myctrlval + double.parse(mycontroller2[i].text.toString());
      }
    }
    totalduepay2 = totalduepay2! + myctrlval;
//log("totpaidamttotpaidamttotpaidamttotpaidamt$totalduepay2");
    return totalduepay2;
  }

  Future getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;
    // log(fromdate);
    // log(todate);

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getPayReciptHeaderDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();

    for (int i = 0; i < getSalesHeader.length; i++) {
      print(
          "getSalesHeader qStatus::${getSalesHeader[i]["qStatus"].toString()}");
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
              ? '0'
              : getSalesHeader[i]["documentno"].toString(),
          docDate: getSalesHeader[i]["createdateTime"].toString(),
          sapNo: getSalesHeader[i]["sapDocNo"] == null
              ? 0
              : int.parse(getSalesHeader[i]["sapDocNo"].toString()),
          sapDate: getSalesHeader[i]["createdateTime"] == null
              ? ""
              : getSalesHeader[i]["createdateTime"].toString(),
          customeraName: getSalesHeader[i]["customer"].toString(),
          doctotal: getSalesHeader[i]["totalamount"] == null
              ? 0
              : double.parse(getSalesHeader[i]["totalamount"].toString())));
    }
    searchData.addAll(searchdata2);
    filtersearchData = searchData;
    notifyListeners();

    // log("header::" + getSalesHeader.toString());

    searchbool = false;
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
      mycontroller[20].text = mycontroller[13].text;
      //log(" mycontroller[17].text::${mycontroller[17].text}");
    } else {
      mycontroller[14].clear();
      mycontroller[15].clear();
      mycontroller[16].clear();
      mycontroller[17].clear();
      mycontroller[18].clear();
      mycontroller[19].clear();
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

  updateCustomer(BuildContext context, int i, int ij) async {
    final Database db = (await DBHelper.getInstance())!;
    String aId = selectedcust!.address![selectedBillAdress].autoId.toString();

// if(selectedcust!.address![selectedBillAdress].addresstype=='B'){
    selectedcust!.cardCode = mycontroller[3].text;
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

    await DBOperation.updateCustomerDetails(
      db,
      selectedcust!.autoId.toString(),
      selectedcust!,
    );
// /  selectedcust!.cardCode.toString(),
    await DBOperation.updateAddressDetails(
        db, i, selectedcust!, aId.toString());
    getCustDetFDB();
    await getUpdateCustandadd(context, selectedcust!.cardCode.toString());
    notifyListeners();
  }

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
//log('step:1.1');
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
  // mapUpdateCustomer(int sInd) {
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
  //       selectedcust!.address![selectedShipAdress].address1!;
  //   mycontroller[15].text =
  //       selectedcust!.address![selectedShipAdress].address2!;
  //   mycontroller[16].text =
  //       selectedcust!.address![selectedShipAdress].address3!;

  //   mycontroller[17].text = selectedcust!.address![selectedShipAdress].billCity;
  //   mycontroller[18].text =
  //       selectedcust!.address![selectedShipAdress].billPincode;
  //   mycontroller[19].text =
  //       selectedcust!.address![selectedShipAdress].billstate;
  //   mycontroller[20].text =
  //       selectedcust!.address![selectedShipAdress].billCountry;

  //   notifyListeners();
  // }

  addadress(BuildContext context) {
    selectedcust!.address!.add(Address(
      address1: mycontroller[14].text,
      address2: mycontroller[15].text,
      address3: mycontroller[16].text,

      billCity: mycontroller[10].text,
      billCountry: 'IND', // mycontroller[13],.text,
      billPincode: mycontroller[11].text,
      billstate: mycontroller[12].text,
      // shipAddress:
      //     '${mycontroller[14].text},${mycontroller[15].text},${mycontroller[16].text}',
      // billAddress:
      // '${mycontroller[7].text},${mycontroller[8].text},${mycontroller[9].text}',
      // shipCity: mycontroller[17].text,
      // shipCountry: 'IND', // mycontroller[20].text,
      // shipPincode: mycontroller[18].text,
      // shipstate: mycontroller[19].text,
    ));
    selectedBillAdress = (selectedcust!.address!.length - 1);
    selectedShipAdress = (selectedcust!.address!.length - 1);

    Navigator.pop(context);
    print("Addres len: " + selectedcust!.address!.length.toString());
    notifyListeners();
  }

  // updateCustomer(int i) async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   String aId = selectedcust!.address![selectedBillAdress].autoId.toString();
  //   // log("selectedBillAdress::" + autoidddd.toString());

  //   selectedcust!.cardCode = mycontroller[3].text;
  //   selectedcust!.phNo = mycontroller[4].text;
  //   selectedcust!.tarNo = mycontroller[5].text;
  //   selectedcust!.name = mycontroller[6].text;
  //   selectedcust!.email = mycontroller[21].text;

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

  //   selectedcust!.address![selectedShipAdress].address1 = mycontroller[14].text;
  //   selectedcust!.address![selectedShipAdress].address2 = mycontroller[15].text;
  //   selectedcust!.address![selectedShipAdress].address3 = mycontroller[16].text;

  //   selectedcust!.address![selectedShipAdress].billCity = mycontroller[17].text;
  //   selectedcust!.address![selectedShipAdress].billPincode =
  //       mycontroller[18].text;
  //   selectedcust!.address![selectedShipAdress].billstate =
  //       mycontroller[19].text;
  //   selectedcust!.address![selectedShipAdress].billCountry =
  //       mycontroller[20].text;

  //   String upCardCode = "${selectedcust!.cardCode}";

  //   await DBOperation.updateCustomerDetails(
  //     db,
  //     selectedcust!.cardCode.toString(),
  //     selectedcust!,
  //   );

  //   await DBOperation.updateAddressDetails(
  //       db, selectedcust!.cardCode.toString(), i, selectedcust!);
  //   // log("Updated Cudtomer Address2 Address3:${mycontroller[14].text}${mycontroller[15].text}${mycontroller[16].text}");
  //   notifyListeners();
  //   notifyListeners();
  // }

  getcustaddresslist() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust!.cardCode!);
    selectedcust!.address = [];

    print("MMMMMMMMM:::" + csadresdataDB.length.toString());

    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (selectedcust!.cardCode == csadresdataDB[ia]['custcode'].toString()) {
        selectedcust!.address!.add(Address(
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
    // log("  selectedcust!.address length:" +
    // selectedcust!.address!.length.toString());
    notifyListeners();
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

  // createadd(BuildContext context) {
  //   if (formkeyAd.currentState!.validate()) {
  //     Navigator.pop(context);
  //     insertCreatenewAddress();
  //     CareateNewBillAdd();
  //     notifyListeners();
  //   }
  // }

  // addnewCustomer(BuildContext context, int ij) {
  //   // log('111111::');
  //   int sucesss = 0;
  //   if (formkey[ij].currentState!.validate()) {
  //     sucesss = sucesss + 1;
  //   }

  //   if (formkeyAd.currentState!.validate()) {
  //     sucesss = sucesss + 1;
  //   }

  //   if (sucesss == 2) {
  //     insertAddNewCusToDB(context);
  //     getCustDetFDB();
  //     Navigator.pop(context);
  //   }
  // }

  // insertnewaddresscreation(BuildContext context, ThemeData theme) async {
  //   log("objectobjectobject");
  //   if (formkeyAd.currentState!.validate()) {
  //     await insertCreatenewAddress();
  //     await getCustDetFDB();
  //     await getcustBilladdresslist(context, theme);
  //     notifyListeners();
  //   } else {
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
  //                   content: textError,
  //                   theme: theme,
  //                 )),
  //                 buttonName: null,
  //               ));
  //         });
  //   }
  // }

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

  insertnewbilladdresscreation(BuildContext context, ThemeData theme) async {
    adOndDisablebutton = true;
//log("objectobjectobject bill");
    final Database db = (await DBHelper.getInstance())!;

    if (formkeyAd.currentState!.validate()) {
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
        adOndDisablebutton = false;
        notifyListeners();
      });
      notifyListeners();
    }
    notifyListeners();
  }

  // insertnewbilladdresscreation(BuildContext context, ThemeData theme) async {
  //   log("objectobjectobject");
  //   final Database db = (await DBHelper.getInstance())!;

  //   if (formkeyAd.currentState!.validate()) {
  //     callAddressPostApi(context);
  //     await insertCreatenewbilAddress();
  //     // await DBOperation.getdata(db);
  //     await getCustDetFDB();
  //     await getcustBilladdresslist(context, theme);
  // //log('shipcreateNewAddressshipcreateNewAddress:::::$checkboxx');
  //     if (checkboxx == true) {
  //       await insertCreatenewsipAddress();
  //       await DBOperation.getdata(db);
  //       await getCustDetFDB();
  //       await getcustshipaddresslist(context, theme);
  //     }
  //     Navigator.pop(context);

  //     notifyListeners();
  //   } else {
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
  //                   content: textError,
  //                   theme: theme,
  //                 )),
  //                 buttonName: null,
  //               ));
  //         });
  //   }
  // }
  bool adOndDisablebutton = false;

  callBillAddressPostApi(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    adOndDisablebutton = true;
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
        adOndDisablebutton = false;

        config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        adOndDisablebutton = false;

        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        adOndDisablebutton = false;
      }
    });
    notifyListeners();
  }

  callShipAddressPostApi(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
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
        adOndDisablebutton = false;

        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        adOndDisablebutton = false;

        config.showDialogg("Something went wrong try agian..!!", "Failed");
      }
    });
    notifyListeners();
  }

  callAddressPostApi(BuildContext context) async {
    loadingBtn = true;
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
      loadingBtn = false;
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
        adOndDisablebutton = false;
        config.showDialogSucessB("Address Created Successfully ..!!", "Sucess");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        adOndDisablebutton = false;
        config
            .showDialogg("${value.ErrorMsg!.message!.Value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        adOndDisablebutton = false;
        config.showDialogg("Something went wrong try agian..!!", "Failed");
      }
    });
    notifyListeners();
  }

  insertnewshipaddresscreation(BuildContext context, ThemeData theme) async {
    adOndDisablebutton = true;
//log("objectobjectobject ship");
    final Database db = (await DBHelper.getInstance())!;

    if (formkeyShipAd.currentState!.validate()) {
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
        adOndDisablebutton = false;
        notifyListeners();
      });
      notifyListeners();
    }
  }

  // insertnewshipaddresscreation(BuildContext context, ThemeData theme) async {
  //   log("objectobjectobject");
  //   final Database db = (await DBHelper.getInstance())!;

  //   if (formkeyShipAd.currentState!.validate()) {
  //     callAddressPostApi(context);
  //     await insertCreatenewsipAddress();
  //     await DBOperation.getdata(db);
  //     await getCustDetFDB();
  //     await getcustshipaddresslist(context, theme);

  //     if (checkboxx == true) {
  //       await insertCreatenewbilAddress();
  //       await DBOperation.getdata(db);
  //       await getCustDetFDB();
  //       await getcustBilladdresslist(context, );
  //     }
  //     Navigator.pop(context);

  //     notifyListeners();
  //   } else {
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
  //                   content: textError,
  //                   theme: theme,
  //                 )),
  //                 buttonName: null,
  //               ));
  //         });
  //   }
  // }

  getcustshipaddresslist(
    BuildContext context,
  ) async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.getdata(db);

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust!.cardCode!);

    print("MMMMMMMMM:::${csadresdataDB.length}");
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
          selectedShipAdress = selectedcust55!.address!.length - 1;
        }
      }
      notifyListeners();
    }
//log("selectedcust!.address!.length:::${selectedcust55!.address!.length}");
//log("selectedShipAdress::" + selectedShipAdress.toString());
//log(" selectedcust!.address!.length555::${selectedcust55!.address!.length}");
    notifyListeners();
  }

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
    //   log("step:1");
    //   await DBOperation.insertCustomer(db, newCustValues);
    //   List<CustomerModelDB> newcusdataDB = await DBOperation.getCstmMasDB(db);
    //   log(" step:21");
    //   custautoid = newcusdataDB[newcusdataDB.length - 1].autoid.toString();
    //   log("newcusdataDB autoid:::" +
    //       newcusdataDB[newcusdataDB.length - 1].autoid.toString());

    //   await DBOperation.updateCustomerDetailstocrdcode(
    //       db, newcusdataDB[newcusdataDB.length - 1].autoid.toString());
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

//log('Stepa::' + newBillAddrsValue.length.toString());
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

  // insertAddNewCusToDB(
  //   BuildContext context,
  // ) async {
  //   print("lastUpdateIp::-----" + UserValues.lastUpdateIp.toString());

  //   // print("ji:" + ji.toString());
  //   // final Database db = await dbHelper.createDB();
  //   final Database db = (await DBHelper.getInstance())!;

  //   // if (formkey[ji].currentState!.validate()) {

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
  //       terminal: UserValues.terminal));
  //   notifyListeners();

  //   newAddrsValue.add(CustomerAddressModelDB(
  //     createdUserID: "1",
  //     addresstype: 'B',
  //     createdateTime: config.currentDate(),
  //     lastupdateIp: UserValues.lastUpdateIp.toString(),
  //     updatedDatetime: config.currentDate(),
  //     updateduserid: UserValues.lastUpdateIp.toString(),
  //     address1: mycontroller[7].text.isNotEmpty ? mycontroller[7].text : '',
  //     address2: mycontroller[8].text.isNotEmpty ? mycontroller[8].text : '',
  //     address3: mycontroller[9].text.isNotEmpty ? mycontroller[9].text : '',
  //     city: mycontroller[10].text.isNotEmpty ? mycontroller[10].text : '',
  //     countrycode:
  //         mycontroller[13].text.isNotEmpty ? mycontroller[13].text : '',
  //     custcode: mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
  //     geolocation1: '',
  //     geolocation2: '',
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
                // shipAddress: createnewcsaddDB[ia].address1!,
                // billAddress: createnewcsaddDB[ia].address1!,
                // shipCity: createnewcsaddDB[ia].city!,
                // shipCountry: createnewcsaddDB[ia].countrycode!,
                // shipPincode: createnewcsaddDB[ia].statecode,
                // shipstate: createnewcsaddDB[ia].statecode,
              ));
          selectedcust!.address = custList[i].address!;
          selectedBillAdress = (selectedcust!.address!.length - 1);
          selectedShipAdress = (selectedcust!.address!.length - 1);
          notifyListeners();
          print(selectedcust!.address![0].address1);
        }
      }
    }

    print("Create new bill");

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

  getcustBilladdresslist(BuildContext context) async {
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
              address1: csadresdataDB[ia]['address1'].toString(),
              address2: csadresdataDB[ia]['address2'].toString(),
              address3: csadresdataDB[ia]['address3'].toString(),
              billCity: csadresdataDB[ia]['city'].toString(),
              billCountry: csadresdataDB[ia]['countrycode'].toString(),
              billPincode: csadresdataDB[ia]['pincode'].toString(),
              billstate: csadresdataDB[ia]['statecode'].toString(),
              addresstype: csadresdataDB[ia]['addresstype'].toString(),
            ),
          );
          selectedBillAdress = selectedcust!.address!.length - 1;
        }
      }
    }

//log("selectedcust!.address!.length:::${selectedcust!.address!.length}");
//log('selectedBillAdress:' + selectedBillAdress.toString());
//log(' selectedcust!.address index:' +
    // selectedcust!.address![selectedBillAdress].billCity.toString());

    notifyListeners();
  }

  insertCreatenewAddress() async {
    final Database db = (await DBHelper.getInstance())!;
    // final Database db = await dbHelper.createDB();

    createNewAddress.add(CustomerAddressModelDB(
      addresstype: 'B',
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      lastupdateIp: UserValues.lastUpdateIp.toString(),
      updatedDatetime: config.currentDate(),
      updateduserid: UserValues.lastUpdateIp != null
          ? UserValues.lastUpdateIp.toString()
          : "0",
      address1: mycontroller[7].text,
      address2: mycontroller[8].text,
      address3: mycontroller[9].text,
      city: mycontroller[10].text,
      countrycode: mycontroller[13].text,
      custcode: selectedcust!.cardCode,
      // mycontroller[77].text,
      geolocation1: '',
      geolocation2: '',
      statecode: mycontroller[12].text, pincode: mycontroller[11].text,
      branch: UserValues.branch.toString(), terminal: UserValues.terminal,
    ));
    await DBOperation.insertCustomerAddress(db, createNewAddress);
    await DBOperation.getdata(db);
    notifyListeners();
    print("Inserted New Created Address");
  }

  //drop downs
  String? selectedType;
  List<String> transType = ['NEFT', 'RTGS', 'IMPS'];
  List<String> get gettransType => transType;

  List payTerminal = [
    "Terminal - 1",
    'Terminal - 2',
    'Terminal - 3',
    'Terminal - 4'
  ];
  List get getpayTerminal => payTerminal;
  String? paymentterm;

  List walletlist = ['GPAY', 'PAYTM', 'PHONEPE', 'BAHRAT PE'];
  List get getwalletlist => walletlist;
  String? wallet;

  // List couponlist = [
  //   'GROUPON',
  //   'AMAZON PAY',
  //   'FLIPKART CORPORATE',
  //   'HDFC GIFTPLUS',
  //   'ICICI GIFT COUPON',
  //   'UNILET COUPONS',
  //   'INSIGNIA COUPONS'
  // ];
  // List get getcouponlist => couponlist;
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
    msgforAmount = '';
    adOndDisablebutton = false;
    custseriesNo = null;
    loadingBtn = false;
    teriteriValue = null;
    paygrpValue = null;
    codeValue = null;
    filedata.clear();
    tinFiles = null;
    vatFiles = null;
    checkboxx = false;
    mycontroller[4].clear();
    mycontroller[6].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[8].clear();
    mycontroller[9].clear();
    mycontroller[10].clear();
    mycontroller[7].clear();
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

  submitted(BuildContext context, ThemeData theme) async {
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
    } else if (advancetype != "Advance" && scanneditemData.isEmpty) {
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
                      content: 'Choose a Document..!! or Advance',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        OndDisablebutton = false;
        notifyListeners();
      });
    } else if (advancetype != "Advance" &&
        scanneditemData.isNotEmpty &&
        //
        paymentWay.isEmpty &&
        getBalancePaid() < 1 &&
        totalduepay! < 1 &&
        getSumTotalPaid() < 1) {
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
                      content: 'Choose a Advance or Document..!! ',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        OndDisablebutton = false;
        notifyListeners();
      });
    } else if (advancetype != "Advance") {
      if (getSumTotalPaid() < 1 && getBalancePaid() > 0) {
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
                        content: "Pay the full amount",
                        //  'Your paid amount is less than 1',
                        theme: theme,
                      )),
                      buttonName: null));
            }).then((value) {
          OndDisablebutton = false;
          notifyListeners();
        });
      } else {
        if (paymentWay.isNotEmpty && totalduepay == getSumTotalPaid()) {
          savepayreceiptValuesTODB('submit', context, theme);
          if (holddocentry.isNotEmpty) {
            DBOperation.deletepayreceipttHold(db, holddocentry.toString())
                .then((value) {
              holddocentry = '';
              onHoldFilter!.clear();
              getdraftindex();
            });
          }
          notifyListeners();
        } else if (paymentWay.isNotEmpty &&
            totalduepay! < 1 &&
            getSumTotalPaid() > 0) {
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
                          content: 'Choose a Advance or Document..!!',
                          theme: theme,
                        )),
                        buttonName: null));
              }).then((value) {
            OndDisablebutton = false;
            notifyListeners();
          });
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
                          content: 'Pay the full amount..!!',
                          theme: theme,
                        )),
                        buttonName: null));
              }).then((value) {
            OndDisablebutton = false;
            notifyListeners();
          });
        }
      }
    } else if (advancetype == "Advance" && paymentWay.isNotEmpty) {
      print("GGGGGGGGGGGGGGG XXXXXXXXXxx");
      advSavePayReceiptValuesTODB('submit', context, theme);
      if (holddocentry.isNotEmpty) {
        DBOperation.deletepayreceipttHold(db, holddocentry.toString())
            .then((value) {
          onHoldFilter!.clear();
          getdraftindex();
        }).then((value) {
          holddocentry = '';
        });
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
                      content: 'Pay the amount..!!',
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

  checkadvanceamt(BuildContext context, ThemeData theme) {
    // log("HHHHHHHHHH");
    int? indx = int.parse(deSelectalladv("Advance", context, theme).toString());
    if (indx != null) {
      // log("index::" + indx.toString());
      savepayreceiptValuesTODB('submit', context, theme);
      notifyListeners();
    } else {
      if (indx == null) {
        if (scanneditemData.isNotEmpty) {
          if (getSumTotalPaid() > 0) {
            if (((getBalancePaid() != 0) && totalduepay != getSumTotalPaid())) {
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
                              content: 'Pay the full amount..!!',
                              theme: theme,
                            )),
                            buttonName: null));
                  });
            } else {
              savepayreceiptValuesTODB('submit', context, theme);
            }
          }
        }
      }
    }
  }

//pointconverter
  pointconvert() {
    print("mycontroller[40].text:" + mycontroller[40].text);

    double availPoint = double.parse(mycontroller[37].text);
    double enteredPoint = double.parse(mycontroller[38].text);
    if (availPoint >= enteredPoint) {
      mycontroller[39].text = mycontroller[38].text;
      mycontroller[40].text = mycontroller[39].text;
    } else {
      msgforAmount = "Points to redeem greater than available point";
      mycontroller[40].clear();
      mycontroller[39].clear();
    }
    notifyListeners();
  }

// //payment options

  int checkAlreadyUsed(String typeofMoney) {
    for (int ip = 0; ip < paymentWay.length; ip++) {
      if (paymentWay[ip].type != "Card") {
        if (paymentWay[ip].type == typeofMoney) {
          return 1;
        }
      }
    }
    return 0;
  }

  double getSumTotalPaid33() {
    double toalPaid2 = 0;
    if (paymentWay2.isNotEmpty) {
      var getTotalPaid = paymentWay2.map((itemdet) => itemdet.amt.toString());
      var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
      toalPaid2 = getTotalPaidSum.reduce((a, b) => a + b);

      print("getSumTotalPaid11:" + toalPaid2.toString());

      return toalPaid2;
    } else {
      return 0.00;
    }
  }

  double getSumTotalPaid() {
    double toalPaid = 0;
    if (paymentWay.isNotEmpty) {
      var getTotalPaid = paymentWay.map((itemdet) => itemdet.amt.toString());
      var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
      toalPaid = getTotalPaidSum.reduce((a, b) => a + b);

      print("getSumTotalPaid22:" + toalPaid.toString());

      return toalPaid;
    } else {
      return 0.00;
      print("BBBBBBBBBBB::${toalPaid}");
    }
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  double getSumTotalPaid2() {
    double toalPaid = 0;
    // log("KKKKKKKKKKK");
    if (paymentWay2.isNotEmpty) {
      // log("JJJJJJJJJJJJ");
      var getTotalPaid = paymentWay2.map((itemdet) => itemdet.amt.toString());
      var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
      toalPaid = getTotalPaidSum.reduce((a, b) => a + b);

      print("getSumTotalPaid33:" + toalPaid.toString());

      return toalPaid;
    } else {
      return 0.00;
    }
  }

  double getBalancePaid2() {
    for (int i = 0; i < scanneditemData2.length; i++) {
      totpaidamt2 = double.parse(mycontroller2[i].text);
    }
    // log("totpaidamttotpaidamt::" + totpaidamt2.toString());

    if (paymentWay2.isNotEmpty) {
      return totpaidamt != 0
          ? (totpaidamt2! - double.parse(getSumTotalPaid2().toStringAsFixed(2)))
          : totalduepay2! - double.parse(getSumTotalPaid2().toStringAsFixed(2));
    }
    return totpaidamt != 0 ? totpaidamt2! : totalduepay2!;
  }

  double getBalancePaid() {
    if (paymentWay.isNotEmpty) {
      return totpaidamt != 0
          ? (totpaidamt! - double.parse(getSumTotalPaid().toStringAsFixed(2)))
          : totalduepay! - double.parse(getSumTotalPaid().toStringAsFixed(2));
    } else if (totalduepay != null) {
      return totpaidamt != 0 ? totpaidamt! : totalduepay!;
    } else {
      totalduepay = 0.00;
      return 0.00;
    }
    // return totpaidamt != 0 ? totpaidamt! : totalduepay!;
  }

  double getBalancePaid33() {
//log('Step1111');
    if (paymentWay2.isNotEmpty) {
      return totpaidamt2 != 0
          ? (totpaidamt2! - double.parse(getSumTotalPaid().toStringAsFixed(2)))
          : totalduepay2! - double.parse(getSumTotalPaid().toStringAsFixed(2));
    } else if (totalduepay2 != null) {
      return totpaidamt2 != 0 ? totpaidamt2! : totalduepay2!;
    } else {
      totalduepay2 = 0.00;
      return 0.00;
    }
    // return totpaidamt != 0 ? totpaidamt! : totalduepay!;
  }

  itemDeSelect(int i) {
    print("HHHHHHH");
    advancetype = '';
    print(scanneditemData[i].checkClr);
    if (scanneditemData[i].checkbx == 0 &&
        scanneditemData[i].checkClr == false) {
      print("AAAAA");
      scanneditemData[i].checkbx = 1;
      scanneditemData[i].checkClr = true;
      totalduepay = totalduepay! + scanneditemData[i].amount!;
      notifyListeners();
    } else if (scanneditemData[i].checkbx == 1 &&
        scanneditemData[i].checkClr == true) {
      print("BBBBBBB");
      scanneditemData[i].checkbx = 0;
      scanneditemData[i].checkClr = false;
      totalduepay = totalduepay! - scanneditemData[i].amount!;

      notifyListeners();
    }

    notifyListeners();
  }

  fullamt(String type, BuildContext context, ThemeData theme) {
    PaymentWay fpaymt = PaymentWay();
    mycontroller[22].text = totalduepay.toString(); //for partial amt
    String fullam = getBalancePaid().toStringAsFixed(2);
    fpaymt.amt = double.parse(fullam.replaceAll(",", ""));
    fpaymt.dateTime = config.currentDate();
    fpaymt.type = type;
    print(" fpaymt.amt" + fpaymt.amt.toString());
    print("type:" + type);
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
                  contentPadding: EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content:
                          'Already you used ${fpaymt.type!} mode of payment..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }
    }
  }

  selectedcoupontype() {
    for (int i = 0; i < couponData.length; i++) {
      if (couponData[i].cardcode.toString() == selectedcustcode.toString() &&
          couponData[i].coupontype == coupon) {
        CouponDetModel cpndata2 = CouponDetModel(
          couponamt: couponData[i].couponamt,
          cardcode: couponData[i].cardcode,
          coupontype: couponData[i].coupontype,
          couponcode: couponData[i].couponcode,
          status: couponData[i].status,
        );
        cpndata = cpndata2;
      }
    }
  }

  addEnteredAmtType(String type, BuildContext context, int i, ThemeData theme) {
    PaymentWay paymt = PaymentWay();

    if (selectedType == null && type == 'Transfer') {
      hintcolor = true;
      notifyListeners();
    }

    if (formkey[i].currentState!.validate()) {
      // log('type: $type');

      if (type == 'Cash') {
        paymt.amt = double.parse(mycontroller[22].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      } else if (type == 'Cheque') {
        // log("mycontroller[44].textmycontroller[44].tex::" +
        // mycontroller[44].text);
        paymt.amt = double.parse(mycontroller[25].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.chequedate = mycontroller[44].text;
        paymt.chequeno = mycontroller[23].text.toString();
        paymt.type = type;
        //log("paymt.chequeno" + mycontroller[23].text.toString());
      } else if (type == 'Card') {
        paymt.amt = double.parse(
            mycontroller[29].text.toString().trim().replaceAll(',', ''));
        paymt.reference = mycontroller[28].text;
        paymt.cardApprno = mycontroller[27].text;
        paymt.cardref = mycontroller[28].text;
        paymt.cardterminal = paymentterm.toString();
        paymt.type = type;
      } else if (type == 'Transfer') {
        paymt.transtype = selectedType.toString();
        paymt.reference = mycontroller[30].text;
        paymt.amt = double.parse(mycontroller[31].text.toString().trim());
        paymt.dateTime = config.currentDate(); //mycontroller[30],
        paymt.type = type;
      } else if (type == 'Wallet') {
        paymt.reference = mycontroller[33].text;
        paymt.walletid = mycontroller[32].text;
        paymt.walletref = mycontroller[33].text;
        paymt.wallettype = wallet;
        paymt.amt = double.parse(mycontroller[34].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      } else if (type == 'Coupons') {
        paymt.couponcode = mycontroller[35].text;
        paymt.coupontype = coupon;
        paymt.amt = double.parse(mycontroller[36].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      } else if (type == 'Points Redemption') {
        paymt.redeempoint = mycontroller[38].text;
        paymt.availablept = mycontroller[37].text;
        paymt.amt = double.parse(mycontroller[40].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      }
    }
    if (paymt.amt != null) {
      int check = checkAlreadyUsed(paymt.type!);
      if (check == 0) {
        addPayAmount(paymt, context);
        notifyListeners();

        notifyListeners();
      } else if (check == 1) {
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
                      content:
                          'Already you used ${paymt.type!} mode of payment..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }
      // addPayAmount(paymt, context);
    }
  }

  addPayAmount(PaymentWay paymt, BuildContext context) {
    selectedcoupontype();
    print("totalduepaytotalduepay" + totalduepay.toString());
    if (advancetype != "Advance") {
      if (paymentWay.isEmpty) {
        print(paymentWay.length.toString());
        if (paymt.type == 'Coupons') {
          //coupon
          // log("LLLLLLLLLL::" + cpndata.couponamt.toString());
          // log("LLLLLLLLLLNNNNNNN::" + selectedcustcode.toString());
          if (cpndata.cardcode.toString() == selectedcustcode.toString()) {
            if (cpndata.coupontype == paymt.coupontype) {
              if (cpndata.couponcode == paymt.couponcode) {
                // log("DDDDDDDDD");
                if (cpndata.couponamt! >= paymt.amt!) {
                  // log("MMMMMMMMMMMMMM");

                  addToPaymentWay(paymt, context);
                  notifyListeners();
                } else {
                  // log("KKKKKKKKKKKKK");

                  msgforAmount = 'Amount entered exceeds coupon values';
                  notifyListeners();
                }
              }
            } else {
              msgforAmount = 'Invalid Coupon Type..!!';
              notifyListeners();
            }
          }
          notifyListeners();
        } else if (totalduepay! > getSumTotalPaid() &&
            getBalancePaid() >= double.parse(paymt.amt!.toStringAsFixed(2))) {
          print("typeee: ${paymt.amt}");

          addToPaymentWay(paymt, context);
        } else {
          // log("ErroAmt1111: ${paymt.amt}");
          msgforAmount = 'Enter Correct amount..!!';
          print(msgforAmount);
          notifyListeners();
        }
      } else {
        if (totalduepay! > getSumTotalPaid() &&
            double.parse(getBalancePaid().toStringAsFixed(2)) >=
                double.parse(paymt.amt!.toStringAsFixed(2))) {
          addToPaymentWay(paymt, context);
        } else {
          // log("ErroAmt2222: ${paymt.amt}");

          msgforAmount = 'Enter Correct amount..!!';
          notifyListeners();
          //config.showDialogBox('Alert', 'Enter Correct amount..!!', context);
        }
      }
    } else {
      addToPaymentWay(paymt, context);
    }
  }

  // accBaladdPayAmount(PaymentWay paymt, BuildContext context) {
  //   if (paymt.amt! < double.parse(selectedcust!.accBalance.toString())) {
  //     print("typeee: ${paymt.amt}");

  //     addToPaymentWay(paymt, context);

  //     selectedcust!.accBalance = selectedcust!.accBalance! - paymt.amt!;

  //     notifyListeners();
  //   } else {
  //     // log("ErroAmt1111: ${paymt.amt}");
  //     msgforAmount = 'Enter Correct amount..!!';
  //     notifyListeners();
  //   }
  // }

  addToPaymentWay(
    PaymentWay paymt,
    BuildContext context,
  ) {
    print(" paymt.amt paymt.amt::${paymt.amt}");
    hintcolor = false;
    paymentWay.add(PaymentWay(
        amt: paymt.amt,
        dateTime: paymt.dateTime,
        reference: paymt.reference ?? '',
        type: paymt.type,
        cardApprno: paymt.cardApprno,
        cardref: paymt.cardref,
        cardterminal: paymt.cardterminal,
        chequedate: paymt.chequedate,
        chequeno: paymt.chequeno,
        couponcode: paymt.couponcode,
        coupontype: paymt.coupontype,
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

    print("paymt.amt paymt.amt" + paymt.amt.toString());

    getSumTotalPaid();
    getBalancePaid();
    Navigator.pop(context);
    notifyListeners();
  }

  removePayment(int i) {
    paymentWay.removeAt(i);
    getSumTotalPaid();
    getBalancePaid();
    notifyListeners();
  }

// // chqu
  getDate(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate);
      datetype = DateFormat('yyyy-MM-dd').format(pickedDate);
      mycontroller[24].text = config.alignDate(datetype!);
      mycontroller[44].text = datetype!;
      //log(mycontroller[24].text);
    } else {
      print("Date is not selected");
    }
  }

//   //
  cpyBtnclik(int i) {
    if (double.parse(getBalancePaid().toStringAsFixed(2)) > 0) {
      mycontroller[i].text = getBalancePaid().toStringAsFixed(2);
      notifyListeners();
    } else {
      mycontroller[i].text = '';
    }
  }

  custCodeReadOnly() {
    // log('seriesValueAA ${custseriesNo}');
    if (custseriesNo.toString().toLowerCase() == '218') {
      seriesValuebool = false;
      notifyListeners();
      // log('seriesValuebool11 ${seriesValuebool}');
    } else {
      seriesValuebool = true;
      // log('seriesValuebool222 ${seriesValuebool}');
      notifyListeners();
    }
    notifyListeners();
  }

  couponcpybtn() {
    selectedcoupontype();
    if (cpndata.status == "Open") {
      // log("cpndata.couponamt::" + cpndata.couponamt.toString());
      mycontroller[36].text = cpndata.couponamt.toString();
    } else {
      mycontroller[36].text = 0.toString();
    }
    notifyListeners();
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
    }

    //   print("Save Hold bills");
    //   // SaveOnHold();
    //  submit"('hold', context, theme);
    //   notifyListeners();
    // }
    else {
      if (advancetype == "Advance") {
        advSavePayReceiptValuesTODB('hold', context, theme);
        if (holddocentry.isNotEmpty) {
          DBOperation.deletepayreceipttHold(db, holddocentry.toString())
              .then((value) {
            onHoldFilter!.clear();
            getdraftindex();
          });
        }
        holddocentry = '';
        //submit"('submit', context, theme);
      } else {
        savepayreceiptValuesTODB('hold', context, theme);
        if (holddocentry.isNotEmpty) {
          DBOperation.deletepayreceipttHold(db, holddocentry.toString())
              .then((value) {
            onHoldFilter!.clear();
            getdraftindex();
          });
        }
        holddocentry = '';
        notifyListeners();
      }
    }

    notifyListeners();
  }

  mapHoldValues(int ih, BuildContext context, ThemeData theme) async {
    holddocentry = '';
    scanneditemData = [];
    loadingscrn = true;
    paymentWay = [];

    selectedcust = CustomerDetals(
        name: salesPayModell5[ih].custName,
        phNo: salesPayModell5[ih].phNo,
        cardCode: salesPayModell5[ih].cardCode,
        accBalance: salesPayModell5[ih].accBalance != null
            ? double.parse(salesPayModell5[ih].accBalance.toString())
            : 0,
        point: salesPayModell5[ih].point,
        address: salesPayModell5[ih].address!,
        tarNo: salesPayModell5[ih].tarNo,
        email: salesPayModell5[ih].email,
        invoicenum: salesPayModell5[ih].invoiceNum,
        docentry: salesPayModell5[ih].transdocentry.toString());

    if (salesPayModell5[ih].payItem!.isNotEmpty) {
      for (int i = 0; i < salesPayModell5[ih].payItem!.length; i++) {
        scanneditemData.add(InvoicePayReceipt(
            amount: salesPayModell5[ih].payItem![i].amount,
            transdocentry: salesPayModell5[ih].payItem![i].transdocentry,
            docNum: salesPayModell5[ih].payItem![i].docNum,
            date: salesPayModell5[ih].payItem![i].date,
            doctype: salesPayModell5[ih].payItem![i].doctype,
            checkbx: salesPayModell5[ih].payItem![i].checkbx,
            checkClr: salesPayModell5[ih].payItem![i].checkClr,
            sapbasedocentry: salesPayModell5[ih].payItem![i].sapbasedocentry));
      }
      // log("scanneditemData length::" + scanneditemData.length.toString());
    }

    for (int ij = 0; ij < salesPayModell5[ih].paymentway!.length; ij++) {
      paymentWay.add(PaymentWay(
          amt: salesPayModell5[ih].paymentway![ij].amt!,
          dateTime: salesPayModell5[ih].paymentway![ij].dateTime,
          reference: salesPayModell5[ih].paymentway![ij].reference ?? '',
          type: salesPayModell5[ih].paymentway![ij].type,
          cardApprno: salesPayModell5[ih].paymentway![ij].cardApprno,
          cardref: salesPayModell5[ih].paymentway![ij].cardref,
          cardterminal: salesPayModell5[ih].paymentway![ij].cardterminal,
          chequedate: salesPayModell5[ih].paymentway![ij].chequedate,
          chequeno: salesPayModell5[ih].paymentway![ij].chequeno,
          discountcode: salesPayModell5[ih].paymentway![ij].discountcode,
          discounttype: salesPayModell5[ih].paymentway![ij].discounttype,
          recoverydate: salesPayModell5[ih].paymentway![ij].recoverydate,
          redeempoint: salesPayModell5[ih].paymentway![ij].redeempoint,
          availablept: salesPayModell5[ih].paymentway![ij].availablept,
          remarks: salesPayModell5[ih].paymentway![ij].remarks,
          transtype: salesPayModell5[ih].paymentway![ij].transtype,
          walletid: salesPayModell5[ih].paymentway![ij].walletid,
          wallettype: salesPayModell5[ih].paymentway![ij].wallettype));
      notifyListeners();
    }

    // totalduepay = salesPayModell5[ih].totaldue!;

    paymentWay = salesPayModell5[ih].paymentway!;
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
    if (scanneditemData.isNotEmpty) {
      for (int i = 0; i < scanneditemData.length; i++) {
        // log("salesPayModell5[ih].payItem![i].amount:" + salesPayModell5[ih].payItem![i].amount.toString());
        mycontroller[i].text = scanneditemData[i].amount.toString();
        totalduepay =
            totalduepay! + double.parse(mycontroller[i].text.toString());
        notifyListeners();

        //log("totalduepay:totalduepay::" + totalduepay.toString());
      }
      notifyListeners();
    }

    holddocentry = salesPayModell5[ih].docentry.toString();
    // salesPayModell5.removeAt(ih);
    // DBOperation.deletepayreceipttHold(
    //         db,holddocentry.toString())
    //     .then((value) {
    //   onHoldFilter!.clear();
    //   getdraftindex();
    // });
    notifyListeners();
  }

  filterListOnHold(String v) {
    if (v.isNotEmpty) {
      onHoldFilter = salesPayModell5
          .where((e) =>
              e.custName!.toLowerCase().contains(v.toLowerCase()) ||
              e.invoceDate!.toLowerCase().contains(v.toLowerCase()) ||
              e.invoiceNum!.toLowerCase().contains(v.toLowerCase()) ||
              e.phNo!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      onHoldFilter = salesPayModell5;
      notifyListeners();
    }
  }

  Button_HideMethod() {
    _isVisible = true;
    hideButtonController = ScrollController();
    hideButtonController.addListener(() {
      // print("listener");
      if (hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _isVisible = false;
        notifyListeners();
      }
      if (hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _isVisible = true;
        notifyListeners();
      }
    });
  }

  selectall() {
    advancetype = '';
    advancests = false;

    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].checkbx == 0 &&
          scanneditemData[i].checkClr == false) {
        print("Select All");
        scanneditemData[i].checkbx = 1;
        scanneditemData[i].checkClr = true;
        totalduepay = totalduepay! + scanneditemData[i].amount!;
        notifyListeners();
      }
      notifyListeners();
    }
    print("select all :" + totalduepay.toString());
  }

  deSelectall() {
    for (int i = 0; i < scanneditemData.length; i++) {
      scanneditemData[i].checkbx = 0;
      scanneditemData[i].checkClr = false;
      totalduepay = 0;
      notifyListeners();
    }
  }

  AAAAdvance(
    String advancetype1,
    BuildContext context,
    ThemeData theme,
  ) {
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
        advancests = false;
        notifyListeners();
      });
    } else {
      deSelectalladv(advancetype1, context, theme);
      advancetype = advancetype1;
    }
  }

  deSelectalladv(
    String advancetype1,
    BuildContext context,
    ThemeData theme,
  ) {
    // double adjamount = 0;
    // double myctrlamt = 0;

    for (int i = 0; i < scanneditemData.length; i++) {
      scanneditemData[i].checkbx = 0;
      scanneditemData[i].checkClr = false;
      totalduepay = 0;
      // adjamount = adjamount + double.parse(mycontroller[i].text.toString());
      notifyListeners();
    }
    advancetype = advancetype1;

    // return selectedcust!.accBalance = selectedcust!.accBalance! - adjamount;

    // return 00;
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
    totalduepay = 0;
    advancetype = '';
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

//  clearpayData();clearCustomer();

  clearSuspendedData(BuildContext context, ThemeData theme) {
    mycontroller = List.generate(150, (i) => TextEditingController());
    OndDisablebutton = true;
    scanneditemData.clear();
    selectedcust = null;
    mycontroller[50].clear();
    newAddrsValue = [];
    newCustValues = [];
    paymentWay.clear();
    notifyListeners();
    Get.defaultDialog(
            title: "Success",
            middleText: " Suspended Successfully..!!",
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
    OndDisablebutton = false;
  }

  clearpayData() async {
    // log("message");
    advancests = false;
    paymentWay2.clear();
    selectedcust = null;
    selectedcust2 = null;
    isExpanded = false;
    scanneditemData.clear();
    scanneditemData2.clear();
    advancetype = '';
    holddocentry = '';
    advancests = false;
    paymentWay.clear();
    totalduepay2 = 0;
    mycontroller2[50].text = "";
    getSumTotalPaid();
    getBalancePaid();
    notifyListeners();
  }

  forOnAccPaid2222() {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].checkbx == 1 &&
          scanneditemData[i].checkClr == true) {
        print("BBBBBBB");
        scanneditemData[i].checkbx = 0;
        scanneditemData[i].checkClr = false;
        totalduepay = totalduepay! - scanneditemData[i].amount!;

        notifyListeners();
      }
    }
    typeee = 'Advance';
    // log("typeeetypeee 1111:" + typeee);

    notifyListeners();
  }

  foraccselect(BuildContext context, ThemeData theme, String type) {
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
          });
    } else if (selectedcust == null && advancetype == "Advance") {
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
          });
    }
    // foracctotaldue(BuildContext context, ThemeData theme) {
    else if (scanneditemData.length < 0) {
      // log("PPPPPPPP");
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
          });
    } else if (advancetype != "Advance" &&
        scanneditemData.isNotEmpty &&
        //
        paymentWay.isEmpty &&
        getBalancePaid() < 1 &&
        totalduepay! < 1 &&
        getSumTotalPaid() < 1) {
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
                      content: 'Choose a Advance or Document..!!',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        OndDisablebutton = false;
        notifyListeners();
      });
    } else {
      // log("DDDDDDDDDD");

      for (int i = 0; i < scanneditemData.length; i++) {
        if (scanneditemData[i].checkClr == false) {
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
              });
        }
      }
    }
  }

  // checkonacc(BuildContext context, ThemeData theme) {
  //   if (selectedcust == null || scanneditemData.length < 0) {
  //   // log("'Choose Customer and Product',");

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
  //                     content: 'Choose Customer and Product',
  //                     theme: theme,
  //                   )),
  //                   buttonName: null));
  //         });
  //     notifyListeners();
  //   } else if (typeee != "On Account") {
  //     // foracctotaldue(context, theme);
  //     notifyListeners();
  //   }
  // }

  filtercustomerList(String v) {
    if (v.isNotEmpty) {
      // log("custListcustList55555:::" + custList.length.toString());
      filtercustList1 = custList
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.name!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtercustList1 = custList;
      notifyListeners();
    }
  }

  refreshfiltercust() {
    filtercustList1 = custList;
    notifyListeners();
  }

  // getCustDetFDB() async {
  //   custList.clear();
  //   List<Address> addList = [];
  //   final Database db = (await DBHelper.getInstance())!;
  //   List<CustomerModelDB> cusdataDB = await DBOperation.getCstmMasDB(db);
  //   List<CustomerAddressModelDB> csadresdataDB =
  //       await DBOperation.getCstmMasAddDB(
  //     db,
  //   );
  // // log("cusdataDB length::" + cusdataDB.length.toString());

  //   for (int i = 1; i < cusdataDB.length; i++) {
  //     if (cusdataDB[i].customername != "This is my updated name") {
  //       custList.add(CustomerDetals(
  //           cardCode: cusdataDB[i].customerCode,
  //           name: cusdataDB[i].customername,
  //           phNo: cusdataDB[i].phoneno1,
  //           accBalance: cusdataDB[i].balance,
  //           point: cusdataDB[i].points.toString(),
  //           tarNo: cusdataDB[i].taxno,
  //           email: cusdataDB[i].emalid,
  //           invoicenum: '',
  //           invoiceDate: '',
  //           totalPayment: 00,
  //           address: []));
  //     }
  //   }

  //   for (int i = 0; i < custList.length; i++) {
  //     for (int ia = 0; ia < csadresdataDB.length; ia++) {
  //       if (custList[i].cardCode == csadresdataDB[ia].custcode) {
  //         custList[i].address!.add(Address(
  //               autoId: int.parse(csadresdataDB[ia].autoid.toString()),
  //               address1: csadresdataDB[ia].address1!,
  //               address2: csadresdataDB[ia].address2!,
  //               address3: csadresdataDB[ia].address3!,
  //               billCity: csadresdataDB[ia].city!,
  //               billCountry: csadresdataDB[ia].countrycode!,
  //               billPincode: csadresdataDB[ia].pincode!,
  //               billstate: csadresdataDB[ia].statecode,
  //               // shipCity: csadresdataDB[ia].city!,
  //               // shipCountry: csadresdataDB[ia].countrycode!,
  //               // shipPincode: csadresdataDB[ia].statecode,
  //               // shipstate: csadresdataDB[ia].statecode,
  //             ));
  //       }
  //     }
  //   }
  //   if (newCustValues.isNotEmpty && newAddrsValue.isNotEmpty) {
  //     selectedcust = CustomerDetals(
  //       accBalance: custList[custList.length - 1].accBalance,
  //       cardCode: custList[custList.length - 1].cardCode,
  //       name: custList[custList.length - 1].name,
  //       phNo: custList[custList.length - 1].phNo,
  //       point: custList[custList.length - 1].point,
  //       tarNo: custList[custList.length - 1].tarNo,
  //       email: custList[custList.length - 1].email,
  //       address: [
  //         //custlist[i].address[ij].address1
  //         Address(
  //           address1: custList[custList.length - 1]
  //               .address![custList[custList.length - 1].address!.length - 1]
  //               .address1,
  //           address2: custList[custList.length - 1]
  //               .address![custList[custList.length - 1].address!.length - 1]
  //               .address2,
  //           address3: custList[custList.length - 1]
  //               .address![custList[custList.length - 1].address!.length - 1]
  //               .address3,
  //           billCity: custList[custList.length - 1]
  //               .address![custList[custList.length - 1].address!.length - 1]
  //               .billCity,
  //           billCountry: custList[custList.length - 1]
  //               .address![custList[custList.length - 1].address!.length - 1]
  //               .billCountry,
  //           billPincode: custList[custList.length - 1]
  //               .address![custList[custList.length - 1].address!.length - 1]
  //               .billPincode,
  //           billstate: custList[custList.length - 1]
  //               .address![custList[custList.length - 1].address!.length - 1]
  //               .billstate,

  //           //      shipAddress: custList[custList.length - 1]
  //           //     .address![custList[custList.length - 1].address!.length - 1]
  //           //     .shipAddress,
  //           // shipCity: custList[custList.length - 1]
  //           //     .address![custList[custList.length - 1].address!.length - 1]
  //           //     .shipCity,
  //           // shipCountry: custList[custList.length - 1]
  //           //     .address![custList[custList.length - 1].address!.length - 1]
  //           //     .shipCountry,
  //           // shipPincode: custList[custList.length - 1]
  //           //     .address![custList[custList.length - 1].address!.length - 1]
  //           //     .shipPincode,
  //           // shipstate: custList[custList.length - 1]
  //           //     .address![custList[custList.length - 1].address!.length - 1]
  //           //     .shipstate),
  //         ),
  //       ],
  //       //   invoicenum: '',
  //       //   invoiceDate: '',
  //       //   totalPayment: 00,
  //     );
  //   }

  // // log("len of cust: " + custList.length.toString());

  //   filtercustList1 = custList;

  //   notifyListeners();
  // }

  Future getCustDetFDB() async {
    custList.clear();
    custList2 = [];
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
    for (int i = 0; i < custList.length; i++) {
      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (custList[i].cardCode == csadresdataDB[ia].custcode) {
          custList[i].address!.add(Address(
                autoId: int.parse(csadresdataDB[ia].autoid.toString()),
                addresstype: csadresdataDB[ia].addresstype!,
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
    for (int i = 0; i < custList2.length; i++) {
      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (custList2[i].cardCode == csadresdataDB[ia].custcode) {
          custList2[i].address!.add(Address(
                autoId: int.parse(csadresdataDB[ia].autoid.toString()),
                addresstype: csadresdataDB[ia].addresstype!,
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
    if (newCustValues.isNotEmpty && newAddrsValue.isNotEmpty) {
      selectedcust = CustomerDetals(
        accBalance: custList[custList.length - 1].accBalance,
        cardCode: custList[custList.length - 1].cardCode,
        name: custList[custList.length - 1].name,
        phNo: custList[custList.length - 1].phNo,
        point: custList[custList.length - 1].point,
        tarNo: custList[custList.length - 1].tarNo,
        email: custList[custList.length - 1].email,
        address: [
          Address(
            address1: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .address1,
            address2: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .address2,
            address3: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .address3,
            billCity: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .billCity,
            billCountry: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .billCountry,
            billPincode: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .billPincode,
            billstate: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .billstate,
          ),
        ],
      );
    }

    filtercustList1 = custList;
    notifyListeners();
  }

  // custSelected(
  //     CustomerDetals customerDetals, BuildContext context, ThemeData theme) {
  //   selectedBillAdress = 0;
  //   selectedShipAdress = 0;
  //   selectedcust = null;
  //   print("YYYYYYYYYYYYYY");
  //   CustomerDetals selectedcust2 = CustomerDetals(
  //       name: customerDetals.name,
  //       phNo: customerDetals.phNo,
  //       cardCode: customerDetals.cardCode,
  //       accBalance: customerDetals.accBalance,
  //       point: customerDetals.point,
  //       address: customerDetals.address,
  //       email: customerDetals.email,
  //       tarNo: customerDetals.tarNo);
  //   selectedcust = selectedcust2;
  //   // selectedcustcode = customerDetals.cardCode;
  //   autoidddd = customerDetals.address![selectedBillAdress].autoId.toString();

  //   topcustcodeScan(context, theme);

  //   // log(customerDetals.address![selectedBillAdress].autoId.toString());
  //   // selectedBillAdress = (selectedcust!.address!.length-1 );
  //   // selectedShipAdress = (selectedcust!.address!.length -1);
  //   notifyListeners();
  // }
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
        // customerDetals.address,
        // customerDetals.address,
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
        // customerDetals.address,
        // customerDetals.address,
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '');
//log("selectedcust.name::" + selectedcust!.name.toString());
    // log("custselected aid::" + customerDetals.address![0].autoId.toString());
    notifyListeners();
    for (int i = 0; i < customerDetals.address!.length; i++) {
      print("customerDetals.address!.length::" +
          customerDetals.address![0].addresstype.toString());
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

        // log("HHHHHHHHH:::" + selectedcust!.address!.length.toString());
      }
      //log("selectedcust.address::" +
      // selectedcust!.address![0].addresstype.toString());
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
        updateCustBal =
            double.parse(value.accBalanceData![0].balance.toString());
        // selectedcust55!.accBalance = double.parse(value.accBalanceData![0].balance.toString());
        notifyListeners();
      }
    });
    selectedcust!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    selectedcust55!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    notifyListeners();
    topcustcodeScan(context, theme);
    // log("selectedcust55.address1::" +
    //     selectedcust55!.address![selectedShipAdress].address1.toString());
  }

  billaddresslist() async {
    final Database db = (await DBHelper.getInstance())!;

    billadrrssItemlist = [];
    for (int i = 0; i < selectedcust!.address!.length; i++) {
      print("HHHHHHHHH:::" + selectedcust!.address!.length.toString());
      List<Map<String, Object?>> csadresdataDB =
          await DBOperation.addgetCstmMasAddDB(db, selectedcust!.cardCode!);
      print("selectedcust.addressXX::" +
          selectedcust!.address![i].addresstype.toString());
      if (selectedcust!.address![i].addresstype == "B") {
        billadrrssItemlist.add(Address(
            autoId: selectedcust!.address![i].autoId,
            address1: selectedcust!.address![i].address1,
            addresstype: selectedcust!.address![i].addresstype,
            address2: selectedcust!.address![i].address2,
            address3: selectedcust!.address![i].address3,
            billCity: selectedcust!.address![i].billCity,
            billCountry: selectedcust!.address![i].billCountry,
            billPincode: selectedcust!.address![i].billPincode,
            billstate: selectedcust!.address![i].billstate));
        notifyListeners();
      }
      notifyListeners();
    }
//log("billadrrssItemlist::" + billadrrssItemlist.length.toString());
  }

  shippinfaddresslist() {
    shipadrrssItemlist = [];
    for (int i = 0; i < selectedcust55!.address!.length; i++) {
      // log("selectedcust55!.address!.length::" +
      // selectedcust55!.address!.length.toString());

      if (selectedcust55!.address![i].addresstype == "S") {
        print("selectedcust55!.address!.type::" +
            selectedcust55!.address![i].autoId.toString());
        shipadrrssItemlist.add(Address(
            autoId: selectedcust55!.address![i].autoId,
            addresstype: selectedcust55!.address![i].addresstype,
            address1: selectedcust55!.address![i].address1,
            address2: selectedcust55!.address![i].address2,
            address3: selectedcust55!.address![i].address3,
            billCity: selectedcust55!.address![i].billCity,
            billCountry: selectedcust55!.address![i].billCountry,
            billPincode: selectedcust55!.address![i].billPincode,
            billstate: selectedcust55!.address![i].billstate));
      }
      notifyListeners();
    }
//log("shipadrrssItemlist::" + shipadrrssItemlist.length.toString());

    notifyListeners();
  }

  filterInvoiceList(String v) {
    if (v.isNotEmpty) {
      filterInvList = scanneditemData
          .where((e) =>
              e.docNum!.toLowerCase().contains(v.toLowerCase()) ||
              e.date!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterInvList = scanneditemData;
      notifyListeners();
    }
  }

  Future addProductValue() async {
    await addProductItem();

    notifyListeners();
  }

  totalpaidamt(BuildContext context, ThemeData theme) {
    totpaidamt = 0;
    totalduepay = 0;
    double myctrlval = 0;
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].checkbx == 1) {
        if (scanneditemData[i].amount! >=
            double.parse(mycontroller[i].text.toString())) {
          myctrlval = myctrlval + double.parse(mycontroller[i].text.toString());
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
                        content:
                            'Your enter amount is more than invoice amount',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
        }
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      }
    }
    totalduepay = totalduepay! + myctrlval;
    notifyListeners();
    return totalduepay;
  }

  Future addProductItem() async {
    scanneditemData = [];
    totalinvamt = 0;
    for (int ins = 0; ins < salesPayModell5.length; ins++) {
      //log('XXXXXXX:::' + salesPayModell5[ins].payItem!.length.toString());

      for (int i = 0; i < salesPayModell5[ins].payItem!.length; i++) {
        if (salesPayModell5[ins].invoiceNum ==
            salesPayModell5[ins].payItem![i].docNum) {
          log('message::${salesPayModell5[ins].payItem![i].amount}');

          scanneditemData.add(InvoicePayReceipt(
              checkClr: salesPayModell5[ins].payItem![i].checkClr,
              amount: salesPayModell5[ins].payItem![i].amount,
              docNum: salesPayModell5[ins].payItem![i].docNum,
              date: salesPayModell5[ins].payItem![i].date,
              doctype: salesPayModell5[ins].payItem![i].doctype,
              checkbx: salesPayModell5[ins].payItem![i].checkbx,
              transdocentry: salesPayModell5[ins].payItem![i].transdocentry,
              sapbasedocentry:
                  salesPayModell5[ins].payItem![i].sapbasedocentry));
          // log("salesPayModell5[ins].payItem![i].transdocentry::" +
          // salesPayModell5[ins].payItem![i].transdocentry.toString());
          // log("salesPayModell5[ins].payItem![i].transdocentry::" +
          // salesPayModell5[ins].payItem![i].amount.toString());

          // log("scanneditemData[i].invoiceNo:${scanneditemData[i].docNum}");
        }
        notifyListeners();
      }
    }
    for (int ij = 0; ij < scanneditemData.length; ij++) {
      mycontroller[ij].text =
          scanneditemData[ij].amount!.toStringAsFixed(2).toString();
      if (scanneditemData[ij].checkbx == 1) {
        totalduepay =
            totalduepay! + double.parse(mycontroller[ij].text.toString());
        totalinvamt = scanneditemData[ij].amount;
        //log("totalinvamttotalinvamt:" + totalinvamt.toString());
        notifyListeners();
      }
    }
    notifyListeners();
  }

  // addCustomer(BuildContext context) {
  //   for (int i = 0; i < salesPayModell5.length; i++) {
  //     CustomerDetals selecust = CustomerDetals();
  //     selecust.cardCode = salesPayModell5[i].cardCode;

  //     selecust.accBalance = salesPayModell5[i].accBalance != 0
  //         ? double.parse(salesPayModell5[i].accBalance.toString())
  //         : 0.00;

  //     selecust.address = salesPayModell5[i].address;
  //     selecust.email = salesPayModell5[i].email;
  //     selecust.name = salesPayModell5[i].custName;
  //     selecust.phNo = salesPayModell5[i].phNo;
  //     selecust.point = salesPayModell5[i].point;
  //     selecust.tarNo = salesPayModell5[i].tarNo;
  //     selecust.docentry = salesPayModell5[i].transdocentry.toString();
  //     selecust.invoicenum = salesPayModell5[i].invoiceNum.toString();

  //     selecust.invoiceDate = salesPayModell5[i].invoceDate.toString();
  //     selectedcust = selecust;
  // selectedcustcode = salesPayModell5[i].cardCode;
  //     // FocusScopeNode focus = FocusScope.of(context);
  //     // if (!focus.hasPrimaryFocus) {
  //     //   focus.unfocus();
  //     // }
  //     notifyListeners();
  //   }
  // }
  addCustomer() async {
    final Database db = (await DBHelper.getInstance())!;
    for (int ik = 0; ik < salesPayModell5.length; ik++) {
      // List<Map<String, Object?>> getDBholddata1 =
      //     await DBOperation.salestosalesret(
      //         db, selectedcust!.cardCode);
      List<Map<String, Object?>> getcustaddd =
          await DBOperation.addgetCstmMasAddDB(
              db, salesPayModell5[ik].cardCode.toString());
      List<Map<String, Object?>> custData =
          await DBOperation.getCstmMasDatabyautoid(
              db, salesPayModell5[ik].cardCode.toString());
      //log("step1 documentno::${salesPayModell5[ik].invoiceNum.toString().toString()}");
      selectedcust = CustomerDetals(
        name: custData[0]['customername'].toString(),
        phNo: custData[0]['phoneno1'].toString(),
        cardCode: custData[0]['customercode'].toString(),
        accBalance: double.parse(custData[0]['balance'].toString()),
        point: custData[0]['points'].toString(),
        address: [],
        email: custData[0]['emalid'].toString(),
        tarNo: custData[0]['taxno'].toString(),
        invoicenum: salesPayModell5[ik].invoiceNum.toString(),
        invoiceDate: salesPayModell5[ik].invoceDate,
        docentry: salesPayModell5[ik].transdocentry.toString(),
      );
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
        invoicenum: salesPayModell5[ik].invoiceNum.toString(),
        invoiceDate: salesPayModell5[ik].invoceDate,
        docentry: salesPayModell5[ik].transdocentry.toString(),
      );
      notifyListeners();

      //log("step2");
      // selectedcust!.totalPayment = salesPayModell5[i].totaldue != null
      //     ? double.parse(salesPayModell5[i].totaldue.toString())
      //     : 00;
      notifyListeners();

      // selectedcust = selectedcust2;
      // for (int ik = 0; ik < getDBholddata1.length; ik++) {
      // basedocentryonqtyck = getDBholddata1[ik]['docentry'].toString();

      for (int i = 0; i < getcustaddd.length; i++) {
        // if (getDBholddata1[ik]['billaddressid'].toString() != null ||
        //     getDBholddata1[ik]['billaddressid'].toString().isNotEmpty) {
        //   // log("step4");

        //   if (getDBholddata1[ik]['billaddressid'].toString() ==
        //       getcustaddd[i]['autoid'].toString()) {
        //     // log("step5");
        if (getcustaddd[i]['addresstype'].toString() == "B") {
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
        notifyListeners();

        // if (getDBholddata1[ik]['shipaddresid'].toString().isNotEmpty) {
        //   log("step66");
        //   if (getDBholddata1[ik]['shipaddresid'].toString() ==
        //       getcustaddd[i]['autoid'].toString()) {
        //log("step77");
        if (getcustaddd[i]['addresstype'].toString() == "S") {
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
          // }
          notifyListeners();
        }
        // }
        // log("step8");
        // }
      }

      // notifyListeners();
    }
    notifyListeners();
  }
//   /// product add

  injectfromdb() async {
    await getCustDetFDB();
    notifyListeners();
  }

  iniialCustList() {
    filtercustList1 = custList;
  }

  invoiceScan(BuildContext context, ThemeData theme) async {
    int? indx = await invoiceBatchAvail(
        mycontroller[80].text.toString().trim().toUpperCase(), context, theme);
    if (indx != null) {
      if (scanneditemData.isEmpty) {
        addProductValue();
        //log('Invoice Num is Same');

        addCustomer();

        notifyListeners();
      } else {
        int? arSc = await checkSameSerialBatchScnd(sameInvNum.toString());
        // log("arSc $arSc");
        if (arSc != null) {
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
                        content: 'Already scanned..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
        } else {
          addProductValue();
        }
        notifyListeners();
      }

      notifyListeners();
    } else if (indx == null) {
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
                    content: 'Wrong Invoice Choosed..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        mycontroller[80].text = '';
      });
    }
    getcoupontypevalue();
  }

  Future<int?> checkSameSerialBatchScnd(String invc) async {
    print(invc);
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].docNum == invc) {
        if (scanneditemData[i].amount == null) {
          return Future.value(i);
        }
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  Future<int?> invoiceBatchAvail(
      String invcno, BuildContext context, ThemeData theme) async {
    salesPayModell5.clear();
    scanneditemData.clear();
    totalduepay = 0;
    totpaidamt = 0;
    advancetype = '';
    final Database db = (await DBHelper.getInstance())!;
    List<InvoicePayReceipt> scannData = [];

    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.salestosalesret(db, invcno.toString());

    for (int i = 0; i < getDBholddata1.length; i++) {
      // log("getDBholddata1[i]['documentno']${getDBholddata1[i]['documentno']}");
      // if (getDBholddata1[i]['sapDocentry'] != null) {
      List<Map<String, Object?>> salespayreceiptt =
          await DBOperation.salespaymentreceipt(
              db, getDBholddata1[i]['documentno'].toString());
      if (salespayreceiptt.isNotEmpty) {
        for (int ik = 0; ik < salespayreceiptt.length; ik++) {
          if (int.parse(getDBholddata1[i]['docentry'].toString()) ==
              int.parse(salespayreceiptt[ik]['docentry'].toString())) {
            // log("salespayreceiptt docentry:::" +
            // getDBholddata1[i]['docentry'].toString());
            scannData.add(InvoicePayReceipt(
              amount: salespayreceiptt[ik]['Balance'] != null
                  ? double.parse(salespayreceiptt[ik]['Balance']
                      .toString()
                      .replaceAll(',', ''))
                  : 0,
              docNum: getDBholddata1[i]['documentno'].toString(),
              date: salespayreceiptt[ik]['createdateTime'].toString(),
              doctype: salespayreceiptt[ik]['doctype'].toString(),
              transdocentry: salespayreceiptt[ik]['docentry'].toString(),
              checkClr: true,
              checkbx: 1,
              sapbasedocentry:
                  int.parse(salespayreceiptt[ik]['sapDocentry'].toString()),
              // scannData.add(InvoicePayReceipt(
              //   amount: double.parse(salespayreceiptt[ik]['rcamount'] != null
              //       ? salespayreceiptt[ik]['rcamount']
              //           .toString()
              //           .replaceAll(',', '')
              //       : '0.00'),
              //   invoiceNum: getDBholddata1[i]['documentno'].toString(),
              //   date: config.alignDateT(
              //       salespayreceiptt[ik]['createdateTime'].toString()),
              //   doctype: getDBholddata1[ik]['doctype'].toString(),
              //   checkClr: true,
              //   checkbx: 1,
            ));
            notifyListeners();

            // log("salespayreceiptt[ik]['createdateTime']:::" +
            // salespayreceiptt[ik]['createdateTime'].toString());
          }
        }
      } else {
        selectedcust = null;
        // log("PPPPPPPPPPP");
        List<Map<String, Object?>> getDBholdPayReceiptdata1 =
            await DBOperation.getpayreceiptHeadDB(db);
        for (int ir = 0; ir < getDBholdPayReceiptdata1.length; ir++) {
          // log(" getDBholdPayReceiptdata1[ir]['transdocentry']:::" +
          // getDBholdPayReceiptdata1[ir]['transdocentry'].toString());
          if (getDBholddata1[i]['docentry'].toString() ==
              getDBholdPayReceiptdata1[ir]['transdocentry'].toString()) {
            // log("WWWWWWWWW");
            Get.defaultDialog(
                    title: "Alert",
                    middleText:
                        getDBholdPayReceiptdata1[ir]["docstatus"].toString() ==
                                "1"
                            ? 'Your document is hold on draft bills..!!'
                            // : getDBholdPayReceiptdata1[ir]["docstatus"]
                            //             .toString() ==
                            //         "3"
                            //     ? "Already closed your payment"
                            : "",
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
              selectedcust = null;
              notifyListeners();
            });
          }
        }
      }
      notifyListeners();

      List<Map<String, Object?>> csadresdataDB =
          await DBOperation.addgetCstmMasAddDB(
              db, getDBholddata1[i]['customercode'].toString());
      List<Address> address55 = [];

      print("MMMMMMMMM:::" + csadresdataDB.length.toString());

      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (getDBholddata1[i]['customercode'].toString() ==
            csadresdataDB[ia]['custcode'].toString()) {
          address55.add(Address(
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
      //log("getDBholddata1 documentno.toString():::${getDBholddata1[i]['documentno'].toString()}");
      //log("getDBholddata1 docentry.toString():::${getDBholddata1[i]['docentry'].toString()}");

      SalesModel salesM = SalesModel(
          totaldue: double.parse(getDBholddata1[i]['doctotal'] == null
              ? '0'
              : getDBholddata1[i]['doctotal'].toString().replaceAll(',', '')),
          docentry: int.parse(getDBholddata1[i]['docentry'].toString()),
          transdocentry: getDBholddata1[i]['docentry'].toString(),
          custName: getDBholddata1[i]['customername'].toString(),
          phNo: getDBholddata1[i]['customerphono'] == null
              ? ""
              : getDBholddata1[i]['customerphono'].toString(),
          cardCode: getDBholddata1[i]['customercode'].toString(),
          accBalance: getDBholddata1[i]['customeraccbal'] == null
              ? ""
              : getDBholddata1[i]['customeraccbal'].toString(),
          point: getDBholddata1[i]['customerpoint'] == null
              ? ""
              : getDBholddata1[i]['customerpoint'].toString(),
          tarNo: getDBholddata1[i]['taxno'] == null
              ? ""
              : getDBholddata1[i]['taxno'].toString(),
          email: getDBholddata1[i]['customeremail'] == null
              ? ''
              : getDBholddata1[i]['customeremail'].toString(),
          invoceDate: getDBholddata1[i]['createdateTime'] == null
              ? ""
              : getDBholddata1[i]['createdateTime'].toString(),
          invoiceNum: getDBholddata1[i]['documentno'].toString(),
          address: address55,
          //  [
          //   Address(
          //       address1: getDBholddata1[i]['billaddressid'].toString(),
          //       billCity: getDBholddata1[i]['city'].toString(),
          //       billCountry: getDBholddata1[i]['country'].toString(),
          //       billPincode: getDBholddata1[i]['pinno'].toString(),
          //       billstate: getDBholddata1[i]['state'].toString())
          // ],
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
            // total: getDBholddata1[i]['doctotal'] == null
            //     ? 0
            //     : int.parse(getDBholddata1[i]['doctotal']
            //         .toString()
            //         .replaceAll(',', '')),
            totalDue: double.parse(getDBholddata1[i]['doctotal'] == null
                ? '0'
                : getDBholddata1[i]['doctotal'].toString().replaceAll(',', '')),
            totpaid: double.parse(getDBholddata1[i]['amtpaid'] == null
                ? '0'
                : getDBholddata1[i]['amtpaid'].toString().replaceAll(',', '')),
            balance: double.parse(getDBholddata1[i]['baltopay'] != null
                ? getDBholddata1[i]['baltopay'].toString().replaceAll(',', '')
                : '0'),
          ),
          payItem: scannData);

      // log("scannDatascannDatascannData:::" + scannData.length.toString());
      salesPayModell5.add(salesM);

      notifyListeners();

      return Future.value(i);
      // }
    }
    notifyListeners();
    return Future.value(null);
  }

  topcustcodeScan(BuildContext context, ThemeData theme) async {
//log("step1");
    // int? indx =
    await scancardcode(selectedcust!.cardCode.toString(), context, theme);
    // if (indx != null) {
    if (scanneditemData.isEmpty) {
      //log("Sales invoice index: ");
      addProductValue();
      addCustomer();

      notifyListeners();
      // }
    }
    // getcoupontypevalue();
  }

  custcodeScan(BuildContext context, ThemeData theme) async {
    // int? indx =
    await scancardcode(
        mycontroller[81].text.toString().trim().toUpperCase(), context, theme);
    // if (indx != null) {
    // if (scanneditemData.isEmpty) {
    addProductValue();
    addCustomer();

    notifyListeners();
    // }
    //  else {
    // // log("HHHHHHHHHH");

    //   int? arSc = await checkSameSerialBatchScnd(sameInvNum!.toString());
    // // log("arSc $arSc");
    //   if (arSc != null) {
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
    //                 content: 'Already scanned..!!',
    //                 theme: theme,
    //               )),
    //               buttonName: null,
    //             ));
    //       });
    //   }
    // else {
    //   addProductValue(indx);
    // }
  }

  Future<int?> scancardcode(
      String invcno, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    salesPayModell5.clear();
    scanneditemData.clear();
    totalduepay = 0;
    List<InvoicePayReceipt> sscannData = [];

    // List<Map<String, Object?>> getDBholddata1 = await DBOperation.getSalesheadCkoutpayreceipt(db, selectedcust!.cardCode.toString(), selectedcust!.name.toString());
    List<Map<String, Object?>> getDBholdPayReceiptLine22 =
        await DBOperation.salespaymentareceiptcardcode(db, invcno.toString());
    // List<Map<String, Object?>> getDBholdPayReceiptdata1 = await DBOperation.getpayreceiptHeadDB(db);
//log("step2");
    // for (int im = 0; im < getDBholddata1.length; im++) {
    // log("step4::${getDBholddata1.length}");
    // log("getDBholddata1 sapDocentry::${getDBholdPayReceiptLine22[ik]['sapDocentry']}");

    // if (getDBholdPayReceiptLine22[ik]['sapDocentry'] != null) {
    // log("BBBBB::${getDBholdPayReceiptLine22[ik]['customercode'].toString()}");

    for (int ik = 0; ik < getDBholdPayReceiptLine22.length; ik++) {
      //log('docnum::::${getDBholdPayReceiptLine22[ik]['documentno'].toString()}');

      // if (getDBholdPayReceiptLine22[ik]['sapDocentry'] != null) {
      //log("step25::${getDBholdPayReceiptLine22.length}");

      sscannData.add(InvoicePayReceipt(
        sapbasedocentry:
            int.parse(getDBholdPayReceiptLine22[ik]['sapDocentry'].toString()),
        amount: getDBholdPayReceiptLine22[ik]['Balance'] != null
            ? double.parse(getDBholdPayReceiptLine22[ik]['Balance']
                .toString()
                .replaceAll(',', ''))
            : 0,
        docNum: getDBholdPayReceiptLine22[ik]['documentno'].toString(),
        date: getDBholdPayReceiptLine22[ik]['createdateTime'].toString(),
        doctype: getDBholdPayReceiptLine22[ik]['doctype'].toString(),
        transdocentry: getDBholdPayReceiptLine22[ik]['docentry'].toString(),
        checkClr: true,
        checkbx: 1,
      ));
      notifyListeners();
      //log("sscannDatasscannData::${sscannData.length}");
      // }
      SalesModel salesM = SalesModel(
          totaldue: double.parse(
              getDBholdPayReceiptLine22[ik]['doctotal'] == null
                  ? '0'
                  : getDBholdPayReceiptLine22[ik]['doctotal']
                      .toString()
                      .replaceAll(',', '')),
          docentry:
              int.parse(getDBholdPayReceiptLine22[ik]['docentry'].toString()),
          transdocentry: getDBholdPayReceiptLine22[ik]['docentry'].toString(),
          custName: getDBholdPayReceiptLine22[ik]['customername'].toString(),
          phNo: getDBholdPayReceiptLine22[ik]['customerphono'] == null
              ? ""
              : getDBholdPayReceiptLine22[ik]['customerphono'].toString(),
          cardCode: getDBholdPayReceiptLine22[ik]['customercode'].toString(),
          accBalance: getDBholdPayReceiptLine22[ik]['customeraccbal'] == null
              ? ""
              : getDBholdPayReceiptLine22[ik]['customeraccbal'].toString(),
          point: getDBholdPayReceiptLine22[ik]['customerpoint'] == null
              ? ""
              : getDBholdPayReceiptLine22[ik]['customerpoint'].toString(),
          tarNo: getDBholdPayReceiptLine22[ik]['taxno'] == null
              ? ""
              : getDBholdPayReceiptLine22[ik]['taxno'].toString(),
          email: getDBholdPayReceiptLine22[ik]['customeremail'] == null
              ? ''
              : getDBholdPayReceiptLine22[ik]['customeremail'].toString(),
          invoceDate: getDBholdPayReceiptLine22[ik]['createdateTime'] == null
              ? ""
              : getDBholdPayReceiptLine22[ik]['createdateTime'].toString(),
          invoiceNum: getDBholdPayReceiptLine22[ik]['documentno'].toString(),
          address: [],
          totalPayment: TotalPayment(
            totalTX: double.parse(
                getDBholdPayReceiptLine22[ik]['taxamount'] == null
                    ? '0'
                    : getDBholdPayReceiptLine22[ik]['taxamount'].toString()),

            subtotal: double.parse(
                getDBholdPayReceiptLine22[ik]['docbasic'] == null
                    ? '0'
                    : getDBholdPayReceiptLine22[ik]['docbasic']
                        .toString()
                        .replaceAll(',', '')), //doctotal
            discount2: double.parse(
                getDBholdPayReceiptLine22[ik]['docdiscamt'] != null
                    ? getDBholdPayReceiptLine22[ik]['docdiscamt'].toString()
                    : '0'),
            discount: double.parse(
                getDBholdPayReceiptLine22[ik]['docdiscamt'] != null
                    ? getDBholdPayReceiptLine22[ik]['docdiscamt'].toString()
                    : '0'),

            totalDue: double.parse(
                getDBholdPayReceiptLine22[ik]['doctotal'] == null
                    ? '0'
                    : getDBholdPayReceiptLine22[ik]['doctotal']
                        .toString()
                        .replaceAll(',', '')),
            totpaid: double.parse(
                getDBholdPayReceiptLine22[ik]['amtpaid'] == null
                    ? '0'
                    : getDBholdPayReceiptLine22[ik]['amtpaid']
                        .toString()
                        .replaceAll(',', '')),
            balance: double.parse(
                getDBholdPayReceiptLine22[ik]['baltopay'] != null
                    ? getDBholdPayReceiptLine22[ik]['baltopay']
                        .toString()
                        .replaceAll(',', '')
                    : '0'),
          ),
          payItem: sscannData);
      salesPayModell5.add(salesM);
      //log("salesPayModell5salesPayModell5::${salesPayModell5.length}");
      // return Future.value(ik);
    }

    notifyListeners();
    // return Future.value(null);
  }

  savepayreceiptValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      insertPaymentReceipt(docstatus, context, theme);
      notifyListeners();
    } else if (docstatus.toLowerCase() == "submit") {
      insertPaymentReceipt(docstatus, context, theme);
    }

    notifyListeners();
  }

  advSavePayReceiptValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      advInsertPaymentReceipt(docstatus, context, theme);
      notifyListeners();
    } else if (docstatus.toLowerCase() == "submit") {
      advInsertPaymentReceipt(docstatus, context, theme);
    }

    notifyListeners();
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

    return listdata;
  }

  insertPaymentReceipt(
      String? docstatus, BuildContext context, ThemeData theme) async {
    List<ReceiptHeaderTDB> receiptHeader = [];
    List<ReceiptLineTDB> receiptLine1 = [];
    List<ReceiptLine2TDB> receiptLine2 = [];
    final Database db = (await DBHelper.getInstance())!; //
    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "ReceiptHeader");
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
          await DBOperation.generateDocentr(db, "docentry", "ReceiptHeader");
    }
    print('MMMMMMMMMMMMMMMMM:::' + docEntryCreated.toString());
    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 7);

    List<String> getseriesvalue = await checkingdoc(7);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;
    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);
    documentNum = finlDocnum + documentN0.toString();
    print('finlDocnumfinlDocnum:::${finlDocnum}');

    int selectdocentry = selectedcust!.docentry != null
        ? int.parse(selectedcust!.docentry.toString())
        : 0;

    List<Map<String, Object?>> sapdetails =
        await DBOperation.getSaleHeadSapDet(db, selectdocentry, 'SalesHeader');

    receiptHeader.add(ReceiptHeaderTDB(
      customerSeriesNum: '',
      docentry: docEntryCreated,
      doctype: "Payment Receipt",
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      customer: selectedcust!.cardCode.toString(),
      docnumber: documentNum.toString(),
      branch: UserValues.branch.toString(),
      lastupdateIp: UserValues.lastUpdateIp,
      series: '',
      seriesnumber: '',
      sysdate: config.currentDate(),
      totalamount: getSumTotalPaid().toString().replaceAll(',', ''),
      // totalinvamt != null ? totalinvamt!.toStringAsFixed(2) : '',
      // totalduepay.toString(),
      //
      transdate: config.currentDate(),
      transtime: config.currentDate(),
      updatedDatetime: config.currentDate(),
      updateduserid: UserValues.userID.toString(),
      docstatus: docstatus == "hold"
          ? "1"
          : docstatus == "submit"
              ? "3"
              : "null",
      terminal: UserValues.terminal,
      transdocentry: selectedcust!.docentry.toString(),
      transdocnum: selectedcust!.invoicenum.toString(),
      sapDocNo: null,
      qStatus: "No",
      sapDocentry: null,
      sapInvoicedocentry:
          sapdetails.isNotEmpty ? sapdetails[0]['sapDocentry'].toString() : "",
      sapInvoicedocnum:
          sapdetails.isNotEmpty ? sapdetails[0]['sapDocNo'].toString() : '',
      remarks: mycontroller[50].text.toString(),
    ));
    int? docentry5 = await DBOperation.insertRecieptHeader(db, receiptHeader);
    await DBOperation.updatenextno(db, 7, nextno);
    for (int ij = 0; ij < scanneditemData.length; ij++) {
      if (scanneditemData[ij].checkbx == 1) {
        receiptLine1.add(ReceiptLineTDB(
            TransAmount: double.parse(mycontroller[ij].text.toString())
                .toStringAsFixed(2),
            TransDocDate: scanneditemData[ij].date.toString(),
            TransDocNum: scanneditemData[ij].docNum,
            transDocEnty: scanneditemData[ij].transdocentry,
            createdUserID: UserValues.userID.toString(),
            createdateTime: config.currentDate(),
            docentry: docentry5,
            lastupdateIp: UserValues.lastUpdateIp,
            rc_entry: ij,
            transType: scanneditemData[ij].doctype,
            updatedDatetime: config.currentDate(),
            updateduserid: UserValues.userID.toString(),
            branch: UserValues.branch,
            sapDocNo: null,
            qStatus: "No",
            sapDocentry: null,
            terminal: UserValues.terminal));
        notifyListeners();
      }
    }
    for (int i = 0; i < paymentWay.length; i++) {
      receiptLine2.add(ReceiptLine2TDB(
          createdUserID: UserValues.userID.toString(),
          createdateTime: config.currentDate(),
          docentry: docentry5.toString(),
          lastupdateIp: UserValues.lastUpdateIp,
          rcamount: paymentWay[i].amt!.toStringAsFixed(2),
          rcdatetime: selectedcust!.invoiceDate,
          rcdocentry: selectedcust!.docentry,
          rcmode: paymentWay[i].type.toString(),
          rcnumber: selectedcust!.invoicenum,
          updatedDatetime: config.currentDate(),
          updateduserid: UserValues.userID.toString(),
          reference: paymentWay[i].reference,
          Ref2: '',
          Ref3: '',
          Ref4: '',
          Ref5: '',
          VouchCode: '',
          VouchCode2: '',
          branch: UserValues.branch,
          terminal: UserValues.terminal,
          cardApprno: paymentWay[i].cardApprno,
          // cardref: paymentWay[i].cardref,
          cardterminal: paymentWay[i].cardterminal,
          chequedate: paymentWay[i].chequedate,
          chequeno: paymentWay[i].chequeno,
          couponcode: paymentWay[i].couponcode,
          coupontype: paymentWay[i].coupontype,
          discountcode: paymentWay[i].discountcode,
          discounttype: paymentWay[i].discounttype,
          // creditref: paymentWay[i].creditref,
          recoverydate: paymentWay[i].recoverydate,
          redeempoint: paymentWay[i].redeempoint,
          availablept: paymentWay[i].availablept,
          remarks: paymentWay[i].remarks,
          // transref: paymentWay[i].transref,
          transtype: paymentWay[i].transtype,
          walletid: paymentWay[i].walletid,
          // walletref: paymentWay[i].walletref,
          wallettype: paymentWay[i].wallettype,
          lineId: i.toString()));
      notifyListeners();
    }
    if (receiptLine1.isNotEmpty) {
      await DBOperation.insertRecieptLine(db, receiptLine1, docentry5!);
    }
    if (receiptLine2.isNotEmpty) {
      await DBOperation.insertReciepLine2(db, receiptLine2, docentry5!);
    }
    bool? netbool = await config.haveInterNet();

    // log("config.haveInterNet():::" + netbool.toString());
    if (netbool == true) {
      if (docstatus == "submit") {
        await callReceiptPostApi(
            context, theme, docentry5!, docstatus!, documentNum);
        // postRabitMqPaymentReceipt(docentry5);
        notifyListeners();
      }
    }

    if (docstatus == "hold") {
      getdraftindex();
      await Get.defaultDialog(
              title: "Success",
              middleText: docstatus == "submit"
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
        notifyListeners();
      });
      scanneditemData.clear();
      selectedcust = null;
      totalduepay = 0;
      paymentWay.clear();
      totpaidamt = 0;
      advancetype = '';
      mycontroller[80].clear();
      mycontroller[81].clear();
      mycontroller[50].clear();
      newAddrsValue = [];
      newCustValues = [];
      advancests = false;
      getcoupontypevalue();
      mycontroller[0].clear();
      mycontroller[1].clear();
      OndDisablebutton = false;

      notifyListeners();
    }

    // if (cpndata.cardcode == selectedcust!.cardCode.toString()) {
    //   // log("updatecouponstatusupdatecouponstatusupdatecouponstatus");
    //   await DBOperation.updatecouponstatus(
    //       db, cpndata.couponcode.toString(), selectedcust!.cardCode.toString());
    // }
    // notifyListeners();
    // Get.defaultDialog(
    //         title: "Success",
    //         middleText: docstatus == "submit"
    //             ? ' Successfully Done..!!,  Document Number is $documentNum'
    //             : docstatus == "hold"
    //                 ? "Saved as draft"
    //                 // : docstatus == "suspend"
    //                 //     ? "This Transaction Suspended Sucessfully..!!"
    //                 : "null",
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
    // OndDisablebutton = false;
    // scanneditemData.clear();
    // selectedcust = null;
    // totalduepay = 0;
    // paymentWay.clear();
    // totpaidamt = 0;
    // advancetype = '';
    // mycontroller[80].clear();
    // mycontroller[81].clear();
    // mycontroller[50].clear();
    // newAddrsValue = [];
    // newCustValues = [];
    // advancests = false;
    // getcoupontypevalue();
    // mycontroller[0].clear();
    // mycontroller[1].clear();
    //   if (docstatus == "submit") {
    //     Get.offAllNamed(ConstantRoutes.dashboard);
    //   }
    //   notifyListeners();
    // });
    // // await showDialog(
    // //     context: context,
    // //     barrierDismissible: true,
    // //     builder: (BuildContext context) {
    // //       return AlertDialog(
    // //           contentPadding: EdgeInsets.all(0),
    // //           content: AlertBox(
    // //             payMent: '',
    // //             errormsg: false,
    // //             widget: Center(
    // //                 child: StReq_SuccessAlertbox(
    // //               content: docstatus == "submit"
    // //                   ? ' Sucessfully Done'
    // //                   : docstatus == "hold"
    // //                       ? "Saved as draft"
    // //                       : docstatus == "suspend"
    // //                           ? "This Sales Transaction Suspended Sucessfully..!!"
    // //                           : "null",
    // //               theme: theme,
    // //             )),
    // //             buttonName: null,
    // //           ));
    // //     }).then((value) {
    // //   scanneditemData.clear();
    // //   paymentWay.clear();
    // //   selectedcust = null;
    // //   mycontroller[0].text = "";
    // //   mycontroller[1].text = "";
    // //   getSumTotalPaid();
    // //   getBalancePaid();
    // //   notifyListeners();
    // // });
  }

  callReceiptPostApi(BuildContext context, ThemeData theme, int docEntry,
      String docstatus, String documentNum) async {
    await sapLoginApi(context);
    await postingReceipt(
      context,
      theme,
      docEntry,
      docstatus,
      documentNum,
    );
    notifyListeners();
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

  addInvoiceLine() {
    itemsPaymentInvDet = [];
    if (scanneditemData.length > 0) {
      for (int i = 0; i < scanneditemData.length; i++) {
        itemsPaymentInvDet.add(PostPaymentInvoice(
            docEntry: scanneditemData[i].sapbasedocentry,
            sumApplied:
                double.parse(getSumTotalPaid().toString().replaceAll(',', '')),
            invoiceType: 'it_Invoice'));
      }
    }
    notifyListeners();
  }

  postingReceipt(BuildContext context, ThemeData theme, int docEntry,
      String docstatus, String documentNum) async {
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
        // double.parse(mycontroller[31].text.toString().trim());
        ReceiptPostAPi.transferReference = paymentWay[i].transref;
        ReceiptPostAPi.transferDate = config.currentDate.toString();
        notifyListeners();
      }
      notifyListeners();
    }

    var uuid = Uuid();
    String? uuidg = uuid.v1();
    ReceiptPostAPi.method();
    await ReceiptPostAPi.getGlobalData().then((value) async {
      // SalesOrderAfterAPi.baseEntry = value.docEntry.toString();
      //log("object:" + value.stscode.toString());
      if (value.stscode == null) {
        return;
      }
      if (value.stscode! >= 200 && value.stscode! <= 210) {
        if (value.docNum != null) {
          sapDocentry = value.docEntry.toString();
          sapDocuNumber = value.docNum.toString();
          await DBOperation.UpdtSapDetSalHead(db, int.parse(sapDocentry!),
              int.parse(sapDocuNumber), docEntry, 'ReceiptHeader');

          await DBOperation.updateRcSapDetSalpay(
              db,
              docEntry,
              int.parse(sapDocuNumber),
              int.parse(sapDocentry!),
              'ReceiptLine2');
          await postRabitMqPaymentReceipt2(int.parse(docEntry.toString()));
          mycontroller = List.generate(150, (i) => TextEditingController());

          selectedcust = null;

          paymentWay.clear();

          remarkcontroller3.text = "";
          scanneditemData.clear();

          notifyListeners();
          await Get.defaultDialog(
                  title: "Success",
                  middleText: docstatus == "submit"
                      ? 'Successfully Done, Document Number is $sapDocuNumber'
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
            if (docstatus == "submit") {
              Get.offAllNamed(ConstantRoutes.dashboard);
            }

            notifyListeners();
          });
          custserieserrormsg = '';
        } else {
          //log("Error11");

          custserieserrormsg = value.error!.message.toString();
          mycontroller = List.generate(150, (i) => TextEditingController());

          selectedcust = null;

          paymentWay.clear();

          scanneditemData.clear();
          remarkcontroller3.text = "";
          scanneditemData.clear();
        }
      } else if (value.stscode! >= 400 && value.stscode! <= 410) {
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
          mycontroller = List.generate(150, (i) => TextEditingController());
          selectedcust = null;
          paymentWay.clear();
          remarkcontroller3.text = "";
          scanneditemData.clear();
          notifyListeners();
        });
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
                      content: '$custserieserrormsg',
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
          notifyListeners();
        });
      }
    });
    notifyListeners();
    OndDisablebutton = false;
  }

  advInsertPaymentReceipt(
      String? docstatus, BuildContext context, ThemeData theme) async {
    // List<ReceiptHeaderTDB> receiptHeader = [];
    // // List<ReceiptLineTDB> receiptLine1 = [];
    // List<ReceiptLine2TDB> receiptLine2 = [];
    // final Database db = (await DBHelper.getInstance())!;

    // int? counofData =
    //     await DBOperation.getcountofTable(db, "docentry", "ReceiptHeader");
    // int? docEntryCreated = 0;
    // if (counofData == 0) {
    //   if (AppConstant.terminal == 'T1') {
    //     docEntryCreated = 1000000;
    //   } else if (AppConstant.terminal == 'T2') {
    //     docEntryCreated = 2000000;
    //   } else if (AppConstant.terminal == 'T3') {
    //     docEntryCreated = 3000000;
    //   } else if (AppConstant.terminal == 'T4') {
    //     docEntryCreated = 4000000;
    //   }
    // } else {
    //   docEntryCreated =
    //       await DBOperation.generateDocentr(db, "docentry", "ReceiptHeader");
    //   //log("docEntryCreated11::${docEntryCreated.toString()}");
    // }
    // String documentNum = '';
    // int? documentN0 =
    //     await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 7);

    // List<String> getseriesvalue = await checkingdoc(7);

    // int docseries = int.parse(getseriesvalue[1]);

    // int nextno = documentN0!;

    // documentN0 = docseries + documentN0;

    // String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    // documentNum = finlDocnum + documentN0.toString();
    List<ReceiptHeaderTDB> receiptHeader = [];
    List<ReceiptLineTDB> receiptLine1 = [];
    List<ReceiptLine2TDB> receiptLine2 = [];
    final Database db = (await DBHelper.getInstance())!;
    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "ReceiptHeader");
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
          await DBOperation.generateDocentr(db, "docentry", "ReceiptHeader");
    }
    print('MMMMMMMMMMMMMMMMM:::' + docEntryCreated.toString());
    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 7);

    List<String> getseriesvalue = await checkingdoc(7);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;
    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);
    documentNum = finlDocnum + documentN0.toString();
    print('finlDocnumfinlDocnum:::${finlDocnum}');

    // String docentryselect = selectedcust!.docentry != null ? selectedcust!.docentry.toString() : "0";
    // List<Map<String, Object?>> sapdetails = await DBOperation.getSaleHeadSapDet(db, int.parse(docentryselect.toString()), 'SalesHeader');

    receiptHeader.add(ReceiptHeaderTDB(
      docentry: docEntryCreated,
      doctype: "Payment Receipt",
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      customerSeriesNum: '',
      customer: selectedcust!.cardCode.toString(),
      docnumber: documentNum.toString(),
      branch: UserValues.branch.toString(),
      lastupdateIp: UserValues.lastUpdateIp,
      series: '',
      seriesnumber: '',
      sysdate: config.currentDate(),
      totalamount: getSumTotalPaid().toString().replaceAll(',', ''),
      transdate: config.currentDate(),
      transtime: config.currentDate(),
      updatedDatetime: config.currentDate(),
      updateduserid: UserValues.userID.toString(),
      docstatus: docstatus == "hold"
          ? "1"
          : docstatus == "submit"
              ? "3"
              : "null",
      terminal: UserValues.terminal,
      transdocentry: '',
      transdocnum: '',
      sapDocNo: null,
      qStatus: "NO",
      sapDocentry: null,
      sapInvoicedocentry: '',
      // sapdetails.isNotEmpty ? sapdetails[0]['sapDocentry'].toString() : "",
      sapInvoicedocnum: '',
      // sapdetails.isNotEmpty ? sapdetails[0]['sapDocNo'].toString() : '',
      remarks: mycontroller[50].text.toString(),
    ));
    // log("XXXXXXXXX:" + selectedcust!.name.toString());
//log("docEntryCreated22::${docEntryCreated.toString()}");

    int? docentry5 = await DBOperation.insertRecieptHeader(db, receiptHeader);
    await DBOperation.updatenextno(db, 7, nextno);

    for (int i = 0; i < paymentWay.length; i++) {
      receiptLine2.add(ReceiptLine2TDB(
          createdUserID: UserValues.userID.toString(),
          createdateTime: config.currentDate(),
          docentry: docentry5.toString(),
          lastupdateIp: UserValues.lastUpdateIp,
          rcamount: paymentWay[i].amt!.toStringAsFixed(2).replaceAll(',', ''),
          //  paymentWay[i].amt != null
          //     ? paymentWay[i].amt!.toStringAsFixed(2)
          //     : "0.00",
          rcdatetime: selectedcust!.invoiceDate,
          rcdocentry: selectedcust!.docentry,
          rcmode: paymentWay[i].type.toString(),
          rcnumber: selectedcust!.invoicenum,
          updatedDatetime: config.currentDate(),
          updateduserid: UserValues.userID.toString(),
          reference: paymentWay[i].reference,
          Ref2: '',
          Ref3: '',
          Ref4: '',
          Ref5: '',
          VouchCode: '',
          VouchCode2: '',
          branch: UserValues.branch,
          terminal: UserValues.terminal,
          cardApprno: paymentWay[i].cardApprno,
          // cardref: paymentWay[i].cardref,
          cardterminal: paymentWay[i].cardterminal,
          chequedate: paymentWay[i].chequedate,
          chequeno: paymentWay[i].chequeno,
          couponcode: paymentWay[i].couponcode,
          coupontype: paymentWay[i].coupontype,
          discountcode: paymentWay[i].discountcode,
          discounttype: paymentWay[i].discounttype,
          // creditref: paymentWay[i].creditref,
          recoverydate: paymentWay[i].recoverydate,
          redeempoint: paymentWay[i].redeempoint,
          availablept: paymentWay[i].availablept,
          remarks: paymentWay[i].remarks,
          // transref: paymentWay[i].transref,
          transtype: paymentWay[i].transtype,
          walletid: paymentWay[i].walletid,
          // walletref: paymentWay[i].walletref,
          wallettype: paymentWay[i].wallettype,
          lineId: i.toString()));
      notifyListeners();
    }
    // if (receiptLine1.isNotEmpty) {
    //   await DBOperation.insertRecieptLine(db, receiptLine1, docentry5!);
    // }
    if (receiptLine2.isNotEmpty) {
      await DBOperation.insertReciepLine2(db, receiptLine2, docentry5!);
    }
    bool? netbool = await config.haveInterNet();
    if (netbool == true) {
      if (docstatus == "submit") {
        await callReceiptPostApi(
            context, theme, docentry5!, docstatus!, documentNum);
        // postRabitMqPaymentReceipt(docentry5);
        notifyListeners();
      }
    }
    if (docstatus == "hold") {
      getdraftindex();
      notifyListeners();
      OndDisablebutton = true;
      advancests = false;
      scanneditemData.clear();
      selectedcust = null;
      totalduepay = 0;
      paymentWay.clear();
      totpaidamt = 0;
      advancetype = '';
      mycontroller[80].text = "";
      mycontroller[81].text = "";
      mycontroller[0].text = "";
      mycontroller[1].text = "";
      Get.defaultDialog(
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
        if (docstatus == "submit") {
          Get.offAllNamed(ConstantRoutes.dashboard);
        }
        OndDisablebutton = false;
        notifyListeners();
      });
    }
    // notifyListeners();
    // OndDisablebutton = true;
    // advancests = false;
    // scanneditemData.clear();
    // selectedcust = null;
    // totalduepay = 0;
    // paymentWay.clear();
    // totpaidamt = 0;
    // advancetype = '';
    // mycontroller[80].text = "";
    // mycontroller[81].text = "";
    // mycontroller[0].text = "";
    // mycontroller[1].text = "";
    // Get.defaultDialog(
    //         title: "Success",
    //         middleText: docstatus == "submit"
    //             ? ' Sucessfully Done ..!!, Document Number is $documentNum'
    //             : docstatus == "hold"
    //                 ? "Saved as draft"
    //                 : docstatus == "suspend"
    //                     ? "This Transaction Suspended Successfully..!!"
    //                     : "null",
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
    //   if (docstatus == "submit") {
    //     Get.offAllNamed(ConstantRoutes.dashboard);
    //   }
    //   OndDisablebutton = false;
    //   notifyListeners();
    // });
  }

  postRabitMqPaymentReceipt(int? docentry) async {
    //background service
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBReceipt2 =
        await DBOperation.getReceiptLine2(db, docentry!);
    List<Map<String, Object?>> getDBReceiptLine =
        await DBOperation.getReceiptLine1(db, docentry);
    List<Map<String, Object?>> getDBReceiptHeader =
        await DBOperation.getReceiptHeaderDB(db, docentry);
    String receiptPAY = json.encode(getDBReceipt2);
    String receiptLine = json.encode(getDBReceiptLine);
    String receiptHeader = json.encode(getDBReceiptHeader);
    var ddd = json.encode({
      "ObjectType": 7,
      "ActionType": "Add",
      "ReceiptHeader": receiptHeader,
      "ReceiptLine": receiptLine,
      "ReceiptPay": receiptPAY,
    });
//log("payload11 : $ddd");
    //RabitMQ
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        //"102.69.167.106"
        //AppConstant.ip
        port: 5672,
        authProvider: PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    // properties.headers = {"Branch": UserValues.branch};
    Channel channel = await client1.channel(); //Server_CS
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    // exchange.publish(ddd, "", properties: properties);

    //cs

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  postRabitMqPaymentReceipt2(int? docentry) async {
    //background service
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBReceipt2 =
        await DBOperation.getReceiptLine2(db, docentry!);
    List<Map<String, Object?>> getDBReceiptLine =
        await DBOperation.getReceiptLine1(db, docentry);
    List<Map<String, Object?>> getDBReceiptHeader =
        await DBOperation.getReceiptHeaderDB(db, docentry);
    String receiptPAY = json.encode(getDBReceipt2);
    String receiptLine = json.encode(getDBReceiptLine);
    String receiptHeader = json.encode(getDBReceiptHeader);
    var ddd = json.encode({
      "ObjectType": 7,
      "ActionType": "Add",
      "ReceiptHeader": receiptHeader,
      "ReceiptLine": receiptLine,
      "ReceiptPay": receiptPAY,
    });
//log("payload22 :$ddd");
    //RabitMQ
    // Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        //"102.69.167.106"
        //AppConstant.ip
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

  getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getholdpayreceiptHeadDB(db);
    for (int i = 0; i < getDBholddata5.length; i++) {
      print(i.toString());
      getdraft(i);

      notifyListeners();
    }
    notifyListeners();
  }

  getdraft(int ji) async {
    salesPayModell5.clear();
    totalduepay = 0;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholdPayReceiptdata1 =
        await DBOperation.getholdpayreceiptHeadDB(db);
    List<Address> address55 = [];

    List<InvoicePayReceipt> scannData = [];
    List<PaymentWay> payment = [];
    CustomerDetals? customeredetailss = CustomerDetals();
    List<Map<String, Object?>>? getDBholdPayReceiptLine =
        await DBOperation.getpayreceipLine11DB(
            db, int.parse(getDBholdPayReceiptdata1[ji]['docentry'].toString()));

    List<Map<String, Object?>> getDBholdPayReceiptLine22 =
        await DBOperation.getpayreceipLine22DB(
            db, int.parse(getDBholdPayReceiptdata1[ji]['docentry'].toString()));

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(
            db, getDBholdPayReceiptdata1[ji]['customer'].toString());
//log("DDDDDDDDDDDDDDDD::${getDBholdPayReceiptdata1[ji]['customer'].toString()}:");
    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (getDBholdPayReceiptdata1[ji]['customer'].toString() ==
          csadresdataDB[ia]['custcode'].toString()) {
        address55.add(Address(
          custcode: csadresdataDB[ia]['custcode'].toString(),
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
        notifyListeners();
      }
    }
    List<Map<String, Object?>> custData =
        await DBOperation.getCstmMasDatabyautoid(
            db, getDBholdPayReceiptdata1[ji]['customer'].toString());
//log('FFFFFFFFF:::${custData[0]['customercode'].toString()}');
    if (getDBholdPayReceiptdata1[ji]['customer'].toString() ==
        custData[0]['customercode'].toString()) {
      CustomerDetals customerde = CustomerDetals(
          accBalance: double.parse(custData[0]['balance'].toString()),
          name: custData[0]['customername'].toString(),
          phNo: custData[0]['phoneno1'].toString(),
          cardCode: custData[0]['customercode'].toString(),
          point: custData[0]['points'].toString(),
          address: address55,
          tarNo: custData[0]['taxno'].toString(),
          email: custData[0]['emalid'].toString(),
          // invoiceDate: getDBsalesdata1[ig]['createdateTime'].toString(),
          // invoicenum: getDBsalesdata1[ig]['documentno'].toString(),
          docentry: getDBholdPayReceiptdata1[ji]['docentry'].toString());
      customeredetailss = customerde;
      //log("VVVV::${customeredetailss.name}");
    }

    for (int kk = 0; kk < getDBholdPayReceiptLine22.length; kk++) {
      // log("getDBholdPayReceiptLine22.length:${getDBholdPayReceiptLine22.length}");
      if (getDBholdPayReceiptdata1[ji]['docentry'] ==
          getDBholdPayReceiptLine22[kk]['docentry']) {
        payment.add(PaymentWay(
          amt: double.parse(
              getDBholdPayReceiptLine22[kk]['rcamount'].toString()),
          type: getDBholdPayReceiptLine22[kk]['rcmode'].toString(),
          dateTime: getDBholdPayReceiptLine22[kk]['createdateTime'].toString(),
          reference: getDBholdPayReceiptLine22[kk]['reference'] != null
              ? getDBholdPayReceiptLine22[kk]['reference'].toString()
              : '',
          cardApprno: getDBholdPayReceiptLine22[kk]['cardApprno'] != null
              ? getDBholdPayReceiptLine22[kk]['cardApprno'].toString()
              : '',
          cardref: getDBholdPayReceiptLine22[kk]['cardref'].toString(),
          cardterminal:
              getDBholdPayReceiptLine22[kk]['cardterminal'].toString(),
          chequedate: getDBholdPayReceiptLine22[kk]['chequedate'].toString(),
          chequeno: getDBholdPayReceiptLine22[kk]['chequeno'].toString(),
          couponcode: getDBholdPayReceiptLine22[kk]['couponcode'].toString(),
          coupontype: getDBholdPayReceiptLine22[kk]['coupontype'].toString(),
          discountcode:
              getDBholdPayReceiptLine22[kk]['discountcode'].toString(),
          discounttype:
              getDBholdPayReceiptLine22[kk]['discounttype'].toString(),
          // creditref: getDBholdPayReceiptLine22[kk]['creditref'].toString(),
          recoverydate:
              getDBholdPayReceiptLine22[kk]['recoverydate'].toString(),
          redeempoint: getDBholdPayReceiptLine22[kk]['redeempoint'].toString(),
          availablept: getDBholdPayReceiptLine22[kk]['availablept'].toString(),
          remarks: getDBholdPayReceiptLine22[kk]['remarks'].toString(),
          // transref: getDBholdPayReceiptLine22[kk]['transref'].toString(),
          transtype: getDBholdPayReceiptLine22[kk]['transtype'].toString(),
          walletid: getDBholdPayReceiptLine22[kk]['walletid'].toString(),
          // walletref: getDBholdPayReceiptLine22[kk]['walletref'].toString(),
          wallettype: getDBholdPayReceiptLine22[kk]['wallettype'].toString(),
          basedoctype: '',
        ));
        notifyListeners();
      }
    }
    if (getDBholdPayReceiptLine.isNotEmpty) {
      for (int ik = 0; ik < getDBholdPayReceiptLine.length; ik++) {
        if (getDBholdPayReceiptdata1[ji]['docentry'] ==
            getDBholdPayReceiptLine[ik]['docentry']) {
          scannData.add(InvoicePayReceipt(
            date: getDBholdPayReceiptLine[ik]['TransDocDate'].toString(),
            amount: double.parse(
                getDBholdPayReceiptLine[ik]['TransAmount'].toString()),
            docNum: getDBholdPayReceiptLine[ik]['TransDocNum'].toString(),
            doctype: getDBholdPayReceiptLine[ik]['transType'].toString(),
            transdocentry:
                getDBholdPayReceiptLine[ik]['transDocEnty'].toString(),
            checkClr: true,
            checkbx: 1,
            sapbasedocentry: int.parse(
                getDBholdPayReceiptdata1[ji]['sapInvoicedocentry'].toString()),
          ));
        }
        //   totalduepay = totalduepay! +sapInvoicedocentry
        // double.parse(getDBholdPayReceiptLine[ik]['TransAmount'].toString());

        notifyListeners();
      }
    }
    SalesModel salesM = SalesModel(
        transdocentry: getDBholdPayReceiptdata1[ji]['transdocentry']
            .toString(), //transdocentry
        docentry:
            int.parse(getDBholdPayReceiptdata1[ji]['docentry'].toString()),
        address: address55,
        custName: customeredetailss != null
            ? customeredetailss.name.toString()
            : null,
        phNo: customeredetailss != null ? customeredetailss.phNo : "",
        totaldue: getDBholdPayReceiptdata1[ji]['totalamount'] != null
            ? double.parse(
                getDBholdPayReceiptdata1[ji]['totalamount'].toString())
            : 0,
        // customeredetailss != null ? totalduepay : null,
        cardCode: customeredetailss != null ? customeredetailss.cardCode : "",
        accBalance: customeredetailss != null
            ? customeredetailss.accBalance.toString()
            : null,
        point: customeredetailss != null ? customeredetailss.point : "",
        tarNo: customeredetailss != null ? customeredetailss.tarNo : "",
        email: customeredetailss != null ? customeredetailss.email : "",
        invoceDate:
            customeredetailss != null ? customeredetailss.invoiceDate : "",
        createdateTime:
            getDBholdPayReceiptdata1[ji]['createdateTime'].toString(),
        invoiceNum: getDBholdPayReceiptdata1[ji]['documentno'].toString(),
        //  customeredetailss != null ? customeredetailss.invoicenum : "", //totalamount

        payItem: scannData,
        paymentway: payment);
    notifyListeners();
//log("paymentpayment::${payment.length}");
//log(
    //   "getDBholdPayReceiptdata1[ji]['createdateTime'].toString():::" +
    //       getDBholdPayReceiptdata1[ji]['createdateTime'].toString(),
    // );
    notifyListeners();

    salesPayModell5.add(salesM);
//log("salesPayModell5salesPayModell5::${salesPayModell5.length}");

    onHoldFilter = salesPayModell5;
//log("onHoldFilteronHoldFilter::${salesPayModell5[0].cardCode}::${salesPayModell5[0].custName}");
    notifyListeners();

    //   else{

    // List<Map<String, Object?>> custData =
    //       await DBOperation.getCstmMasDatabyautoid(
    //           db,getDBholdPayReceiptdata1[ji]['customer'].toString());
    // for (int ig = 0; ig < custData.length; ig++) {
    //   //log("KKKKKKKKKKKKKKKKKKKKKKKKK");

    //       if (getDBholdPayReceiptdata1[ji]['customer'].toString() ==
    //           custData[ig]['customercode'].toString()) {
    //         List<Map<String, Object?>> csadresdataDB =
    //             await DBOperation.addgetCstmMasAddDB(
    //                 db, custData[ig]['customercode'].toString());

    //         print("MMMMMMMMM:::" + csadresdataDB.length.toString());

    //         for (int ia = 0; ia < csadresdataDB.length; ia++) {
    //           if (custData[ig]['customercode'].toString() ==
    //               csadresdataDB[ia]['custcode'].toString()) {
    //             address55.add(Address(
    //               address1: csadresdataDB[ia]['address1'].toString(),
    //               address2: csadresdataDB[ia]['address2'].toString(),
    //               address3: csadresdataDB[ia]['address3'].toString(),
    //               billCity: csadresdataDB[ia]['city'].toString(),
    //               billCountry: csadresdataDB[ia]['countrycode'].toString(),
    //               billPincode: csadresdataDB[ia]['pincode'].toString(),
    //               billstate: csadresdataDB[ia]['statecode'].toString(),
    //             ));
    //           }
    //           notifyListeners();
    //         }

    //         CustomerDetals customerde = CustomerDetals(
    //             accBalance: double.parse(
    //                 custData[ig]['balance'].toString()),
    //             name: custData[ig]['customername'].toString(),
    //             phNo: custData[ig]['phoneno1'].toString(),
    //             cardCode: custData[ig]['customercode'].toString(),
    //             point: custData[ig]['points'].toString(),
    //             address: address55,

    //             tarNo: custData[ig]['taxno'].toString(),
    //             email: custData[ig]['emalid'].toString(),

    //             docentry: getDBholdPayReceiptdata1[ji]['docentry'].toString());
    //         customeredetailss = customerde;
    //       }

    //     }

    //     for (int kk = 0; kk < getDBholdPayReceiptLine22.length; kk++) {
    //       // log("getDBholdPayReceiptLine22.length:${getDBholdPayReceiptLine22.length}");
    //       if (getDBholdPayReceiptdata1[ji]['docentry'] ==
    //           getDBholdPayReceiptLine22[kk]['docentry']) {
    //         payment.add(PaymentWay(
    //           amt: double.parse(
    //               getDBholdPayReceiptLine22[kk]['rcamount'].toString()),
    //           type: getDBholdPayReceiptLine22[kk]['rcmode'].toString(),
    //           dateTime:
    //               getDBholdPayReceiptLine22[kk]['createdateTime'].toString(),
    //           reference: getDBholdPayReceiptLine22[kk]['reference'] != null
    //               ? getDBholdPayReceiptLine22[kk]['reference'].toString()
    //               : '',
    //           cardApprno: getDBholdPayReceiptLine22[kk]['cardApprno'] != null
    //               ? getDBholdPayReceiptLine22[kk]['cardApprno'].toString()
    //               : '',
    //           cardref: getDBholdPayReceiptLine22[kk]['cardref'].toString(),
    //           cardterminal:
    //               getDBholdPayReceiptLine22[kk]['cardterminal'].toString(),
    //           chequedate: getDBholdPayReceiptLine22[kk]['chequedate'].toString(),
    //           chequeno: getDBholdPayReceiptLine22[kk]['chequeno'].toString(),
    //           couponcode: getDBholdPayReceiptLine22[kk]['couponcode'].toString(),
    //           coupontype: getDBholdPayReceiptLine22[kk]['coupontype'].toString(),
    //           discountcode:
    //               getDBholdPayReceiptLine22[kk]['discountcode'].toString(),
    //           discounttype:
    //               getDBholdPayReceiptLine22[kk]['discounttype'].toString(),
    //           // creditref: getDBholdPayReceiptLine22[kk]['creditref'].toString(),
    //           recoverydate:
    //               getDBholdPayReceiptLine22[kk]['recoverydate'].toString(),
    //           redeempoint:
    //               getDBholdPayReceiptLine22[kk]['redeempoint'].toString(),
    //           availablept:
    //               getDBholdPayReceiptLine22[kk]['availablept'].toString(),
    //           remarks: getDBholdPayReceiptLine22[kk]['remarks'].toString(),
    //           // transref: getDBholdPayReceiptLine22[kk]['transref'].toString(),
    //           transtype: getDBholdPayReceiptLine22[kk]['transtype'].toString(),
    //           walletid: getDBholdPayReceiptLine22[kk]['walletid'].toString(),
    //           // walletref: getDBholdPayReceiptLine22[kk]['walletref'].toString(),
    //           wallettype: getDBholdPayReceiptLine22[kk]['wallettype'].toString(),
    //           basedoctype: '',
    //         ));
    //       }
    //       notifyListeners();
    //     }

    //     SalesModel salesM = SalesModel(
    //         transdocentry: getDBholdPayReceiptdata1[ji]['transdocentry']
    //             .toString(), //transdocentry
    //         docentry:
    //             int.parse(getDBholdPayReceiptdata1[ji]['docentry'].toString()),
    //         address: address55,
    //         custName: customeredetailss != null
    //             ? customeredetailss.name.toString()
    //             : null,
    //         phNo: customeredetailss != null ? customeredetailss.phNo : "",
    //         totaldue: customeredetailss != null ? totalduepay : null,
    //         cardCode: customeredetailss != null ? customeredetailss.cardCode : "",
    //         accBalance: customeredetailss != null
    //             ? customeredetailss.accBalance.toString()
    //             : null,
    //         point: customeredetailss != null ? customeredetailss.point : "",
    //         tarNo: customeredetailss != null ? customeredetailss.tarNo : "",
    //         email: customeredetailss != null ? customeredetailss.email : "",
    //         invoceDate:
    //             customeredetailss != null ? customeredetailss.invoiceDate : "",
    //         createdateTime:
    //             getDBholdPayReceiptdata1[ji]['createdateTime'].toString(),
    //         invoiceNum: customeredetailss != null
    //             ? customeredetailss.invoicenum
    //             : "", //totalamount
    //         // invoceAmount: double.parse(
    //         //     getDBholdPayReceiptdata1[ji]['totalamount'].toString()),
    //         // totalPayment: TotalPayment(
    //         //   totpaid: getDBholdPayReceiptdata1[ji]['TransAmount'] != null
    //         //       ? double.parse(getDBholdPayReceiptdata1[ji]['TransAmount']
    //         //           .toString()
    //         //           .replaceAll(',', ''))
    //         //       : null,
    //         //   // totalDue: totalduepay,
    //         // ),
    //         // payItem: scannData,
    //         paymentway: payment);
    // //log(
    //       "getDBholdPayReceiptdata1[ji]['createdateTime'].toString():::" +
    //           getDBholdPayReceiptdata1[ji]['createdateTime'].toString(),
    //     );
    //     notifyListeners();

    //     salesPayModell5.add(salesM);
    //     notifyListeners();

    // }

    // log("onHoldFilter.length:${onHoldFilter!.length}");
    notifyListeners();
  }

  insertpaymentreceipt() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.deletereceipt(db);
    // DBOperation.InsertReceipttableview(db);
    notifyListeners();
  }

  createnewchagescustaddres(
      BuildContext context, ThemeData theme, int ij) async {
    await addnewCustomer(context, theme, ij);
    await getCustDetFDB();
    await getNewCustandadd(context);
    notifyListeners();
  }

  addnewCustomer(BuildContext context, ThemeData theme, int ij) async {
    int sucesss = 0;
    tinfileError = '';
    vatfileError = '';
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
      await callCustPostApi(context, theme);

      await insertAddNewCusToDB(context);
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
    }
    notifyListeners();
  }
//  bool  validateqty = true;
//  balanceAmtcheck(BuildContext context, ThemeData theme) async {
//     final Database db = (await DBHelper.getInstance())!;
// //log("basedocentryonqtyck::$basedocentryonqtyck");
//     validateqty = true;
//     List<Map<String, Object?>> getSalRethead =
//         await DBOperation.getSalesRetHeaderDB(db, baldocentry.toString());
//     if (getSalRethead.isNotEmpty) {
//       List<Map<String, Object?>> getDBSalesLine =
//           await DBOperation.saleslinegetbalqty(db, baldocentry.toString());
//       if (getDBSalesLine.isNotEmpty) {
//         for (int i = 0; i < scanneditemData.length; i++) {
//       //log("step1");

//           for (int ik = 0; ik < getDBSalesLine.length; ik++) {
//         //log("step2:getDBSalesLine[ik]['balqty:${getDBSalesLine[ik]['balqty']}");
//         //log("qtymycontroller[ik].text::${qtymycontroller[i].text}");

//             if (int.parse(getDBSalesLine[ik]['balqty'].toString()) >=
//                 int.parse(qtymycontroller[i].text)) {
//           //log("step3");

//               validateqty = true;
//             } else {
//           //log("step4");
//               validateqty = false;
//               break;
//             }
//           }
//           // return ik;
//         }
//       }
//     } else {
//       List<Map<String, Object?>> getDBholdSalesLine =
//           await DBOperation.saleslinegetbalqty(db, baldocentry.toString());
//       for (int i = 0; i < scanneditemData.length; i++) {
//         for (int ih = 0; ih < getDBholdSalesLine.length; ih++) {
//       //log("getDBholdSalesLine[ih]['balqty'].toString():${getDBholdSalesLine[ih]['balqty']}");
//       //log('qtymycontroller[i].text:${qtymycontroller[i].text}');
//           if (int.parse(getDBholdSalesLine[ih]['balqty'].toString()) >=
//               int.parse(qtymycontroller[i].text)) {
//             validateqty = true;
//           } else {
//             validateqty = false;
//             break;
//           }
//         }
//       }
//     }

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

//Coupons details

  getcoupontypevalue() async {
    final Database db = (await DBHelper.getInstance())!;
    // log('Coupon values');
    String custcardcode =
        (selectedcust != null && selectedcust!.cardCode != null)
            ? selectedcust!.cardCode.toString()
            : '';

    List<Map<String, Object?>> couponTypeValue =
        await DBOperation.getcoupontype(db, custcardcode.toString());
    for (int i = 0; i < couponTypeValue.length; i++) {
      couponData.add(CouponDetModel(
          coupontype: couponTypeValue[i]['coupontype'].toString(),
          createdUserID: couponTypeValue[i]['createdUserID'] != null
              ? int.parse(couponTypeValue[i]['createdUserID'].toString())
              : null,
          couponcode: couponTypeValue[i]['couponcode'].toString(),
          status: couponTypeValue[i]['status'].toString(),
          cardcode: couponTypeValue[i]['cardcode'].toString(),
          doctype: couponTypeValue[i]['doctype'].toString(),
          lastupdateIp: couponTypeValue[i]['lastupdateIp'].toString(),
          couponamt: double.parse(couponTypeValue[i]['couponamt'].toString()),
          updateduserid: couponTypeValue[i]['updateduserid'] != null
              ? int.parse(couponTypeValue[i]['updateduserid'].toString())
              : null));
    }
  }
}

// List<SalesModel> salesPayModell = [
//   SalesModel(
//     payItem: [
//       InvoicePayReceipt(
//         amount: 4000.00,
//         date: '01/12/2022',
//         invoiceNum: "123451",
//         checkbx: 1,
//         checkClr: true,
//       ),
//       InvoicePayReceipt(
//         amount: 50000.00,
//         date: '11/10/2022',
//         invoiceNum: "123452",
//         checkbx: 1,
//         checkClr: true,
//       ),
//       InvoicePayReceipt(
//         amount: 15000.00,
//         date: '01/01/2022',
//         invoiceNum: "123453",
//         checkbx: 1,
//         checkClr: true,
//       ),
//     ],
//     custName: 'TVC Electornics &Furnitures',
//     invoceAmount: 2000,
//     address: [
//       Address(
//         address1: 'TVC Electornics &Furnitures,',
//         address2: 'Devarajan Layouts,Sathyamoorthy Rood,',
//         address3: ' Ram Nagar, Coimbatore',
//         // shipAddress:
//         //     'TVC Electornics &Furnitures, Devarajan Layouts,Sathyamoorthy Rood,Ram Nagar, Coimbatore',
//         billCity: "Coimbatore",
//         billCountry: "Ind",
//         billPincode: "672092",
//         billstate: "TN",
//         // shipCity: "Coimbatore",
//         // shipCountry: "Ind",
//         // shipPincode: "672092",
//         // shipstate: "TN"
//       ),
//       Address(
//         address1: ' Darling TVC ',
//         address2: 'Devarajan Layouts,Sathyamoorthy Rood,',
//         address3: ' Ram Nagar, Coimbatore',
//         // billAddress:
//         //     'TVC Electornics &Furnitures, Devarajan Layouts,Sathyamoorthy Rood,Ram Nagar, Coimbatore',
//         // shipAddress:
//         //     'TVC Electornics &Furnitures, Devarajan Layouts,Sathyamoorthy Rood,Ram Nagar, Coimbatore',
//         billCity: "Coimbatore",
//         billCountry: "Ind",
//         billPincode: "672092",
//         billstate: "TN",
//         // shipCity: "Coimbatore",
//         // shipCountry: "Ind",
//         // shipPincode: "672092",
//         // shipstate: "TN"
//       ),
//     ],
//     phNo: "9826910212",
//     cardCode: 'C0001',
//     accBalance: "50,000.00",
//     point: '50',
//     tarNo: "9302e001111ed",
//     email: "tvc@gmail.com",
//     invoceDate: "22-01-2023",
//     invoiceNum: '123451',
//     invoiceClr: 1,
//   ),
//   SalesModel(
//     payItem: [
//       InvoicePayReceipt(
//         amount: 1000.00,
//         date: '01/12/2022',
//         invoiceNum: "123451",
//         checkbx: 1,
//         checkClr: true,
//       ),
//       InvoicePayReceipt(
//         amount: 4000.00,
//         date: '01/12/2022',
//         invoiceNum: "123451",
//         checkbx: 1,
//         checkClr: true,
//       ),
//       InvoicePayReceipt(
//         amount: 50000.00,
//         date: '11/10/2022',
//         invoiceNum: "123452",
//         checkbx: 1,
//         checkClr: true,
//       ),
//       InvoicePayReceipt(
//         amount: 15000.00,
//         date: '01/01/2022',
//         invoiceNum: "123453",
//         checkbx: 1,
//         checkClr: true,
//       ),
//     ],
//     custName: 'James & Co',
//     invoceAmount: 2000,
//     address: [
//       Address(
//         address1: 'James and co ',
//         address2: 'Devarajan Layouts,Sathyamoorthy Rood,',
//         address3: ' Ram Nagar, Coimbatore',
//         // billAddress:
//         //     'TVC Electornics &Furnitures, Devarajan Layouts,Sathyamoorthy Rood,Ram Nagar, Coimbatore',
//         // shipAddress:
//         //     'TVC Electornics &Furnitures, Devarajan Layouts,Sathyamoorthy Rood,Ram Nagar, Coimbatore',
//         billCity: "Coimbatore",
//         billCountry: "Ind",
//         billPincode: "672092",
//         billstate: "TN",
//         // shipCity: "Coimbatore",
//         // shipCountry: "Ind",
//         // shipPincode: "672092",
//         // shipstate: "TN"
//       ),
//       Address(
//         address1: 'Darling James ',
//         address2: 'Devarajan Layouts,Sathyamoorthy Rood,',
//         address3: ' Ram Nagar, Coimbatore',
//         // billAddress:
//         //     'TVC Electornics &Furnitures, Devarajan Layouts,Sathyamoorthy Rood,Ram Nagar, Coimbatore',
//         // shipAddress:
//         //     'TVC Electornics &Furnitures, Devarajan Layouts,Sathyamoorthy Rood,Ram Nagar, Coimbatore',
//         billCity: "Coimbatore",
//         billCountry: "Ind",
//         billPincode: "672092",
//         billstate: "TN",
//         // shipCity: "Coimbatore",
//         // shipCountry: "Ind",
//         // shipPincode: "672092",
//         // shipstate: "TN"
//       ),
//     ],
//     phNo: "9826910212",
//     cardCode: 'C0002',
//     accBalance: "20,000.00",
//     point: '100',
//     tarNo: "j9302e001111ed",
//     invoiceClr: 1,
//     email: "James and co",
//     invoceDate: "22-01-2023",
//     invoiceNum: '123451',
//   ),
//   SalesModel(
//     payItem: [
//       InvoicePayReceipt(
//         amount: 6000.00,
//         date: '01/12/2022',
//         invoiceNum: "123451",
//         checkbx: 1,
//         checkClr: true,
//       ),
//       InvoicePayReceipt(
//         amount: 50000.00,
//         date: '11/10/2022',
//         invoiceNum: "123452",
//         checkbx: 1,
//         checkClr: true,
//       ),
//       InvoicePayReceipt(
//         amount: 3000.00,
//         date: '01/01/2022',
//         invoiceNum: "123453",
//         checkbx: 1,
//         checkClr: true,
//       ),
//     ],
//     custName: 'Ramsays',
//     invoceAmount: 2000,
//     address: [
//       Address(
//         address1: 'Ramesays ',
//         address2: 'Devarajan Layouts,Sathyamoorthy Rood,',
//         address3: ' Ram Nagar, Coimbatore',
//         // billAddress:
//         //     'TVC Electornics &Furnitures, Devarajan Layouts,Sathyamoorthy Rood,Ram Nagar, Coimbatore',
//         // shipAddress:
//         //     'TVC Electornics &Furnitures, Devarajan Layouts,Sathyamoorthy Rood,Ram Nagar, Coimbatore',
//         billCity: "Coimbatore",
//         billCountry: "Ind",
//         billPincode: "672092",
//         billstate: "TN",
//         // shipCity: "Coimbatore",
//         // shipCountry: "Ind",
//         // shipPincode: "672092",
//         // shipstate: "TN"
//       ),
//       Address(
//         address1: 'Darling Ramsays ',
//         address2: 'Devarajan Layouts,Sathyamoorthy Rood,',
//         address3: ' Ram Nagar, Coimbatore',
//         // billAddress:
//         //     'TVC Electornics &Furnitures, Devarajan Layouts,Sathyamoorthy Rood,Ram Nagar, Coimbatore',
//         // shipAddress:
//         //     'TVC Electornics &Furnitures, Devarajan Layouts,Sathyamoorthy Rood,Ram Nagar, Coimbatore',
//         billCity: "Coimbatore",
//         billCountry: "Ind",
//         billPincode: "672092",
//         billstate: "TN",
//         // shipCity: "Coimbatore",
//         // shipCountry: "Ind",
//         // shipPincode: "672092",
//         // shipstate: "TN"
//       ),
//     ],
//     phNo: "9826910212",
//     cardCode: 'C0003',
//     accBalance: "10,000.00",
//     point: '500',
//     tarNo: "j9302e001111ed",
//     email: "ramsays@gmail.com",
//     invoceDate: "22-01-2023",
//     invoiceClr: 1,
//     invoiceNum: '123451',
//   ),
// ];
