// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, empty_constructor_bodies, non_constant_identifier_names, unused_local_variable, prefer_const_constructors, use_build_context_synchronously, curly_braces_in_flow_control_structures, unrelated_type_equality_checks, prefer_if_null_operators, prefer_is_empty, unused_import, unused_element, unnecessary_null_comparison, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
import 'package:posproject/Pages/DashBoard/Screens/DashBoardScreen.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:posproject/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/StockOutwardBatchModel.dart';
import '../../DBModel/StockOutwardHeader.dart';
import '../../DBModel/StockOutwardLineData.dart';
import '../../DBModel/StockSnap.dart';
import '../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';
import '../../Models/DataModel/StockReqModel/warehouseModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/ServiceLayerModel/SAPOutwardModel/StockOutPostingMidel.dart';
import '../../Models/ServiceLayerModel/SAPOutwardModel/sapOutwardmodel.dart';

import '../../Pages/StockRequest/Widget/SuccessContainer.dart';
import '../../ServiceLayerAPIss/SAPStockOutwardAPI/GetOutwardAPI.dart';
import '../../ServiceLayerAPIss/SAPStockOutwardAPI/OutWardPostingAPI.dart';
import '../../ServiceLayerAPIss/SAPStockOutwardAPI/OutwardCancelAPI.dart';
import '../../ServiceLayerAPIss/SAPStockOutwardAPI/OutwardLoginnAPI.dart';
import '../../Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';

class StockOutwardController extends ChangeNotifier {
  void init() {
    // deletereq();
    clear2();
    // getStockReqData();
    gethold();
  }

  TextEditingController searchcon = TextEditingController();
  List<StockSnapTModelDB> getSearchedData = [];
  List<StockSnapTModelDB> getfilterSearchedData = [];
  List<TextEditingController> qtymycontroller =
      List.generate(100, (ij) => TextEditingController());
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  ScrollController scrollController = ScrollController();
  String? sapDocentry = '';
  String? sapDocuNumber = '';
  String? RequestedWarehouse;
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  bool cancelbtn = false;
  String custserieserrormsg = '';
  List<StockTransferLine> sapstkoutwarddata = [];
  bool OndDisablebutton = false;

  Configure config = Configure();
  List<StockOutwardDetails>? Scandata;
  List<String> ScandSerial = [];
  List<List<String>>? test2;
  int scannvalue2 = 0;

  int pageIndex = 0;
  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());

  List<TextEditingController> StOutController =
      List.generate(150, (i) => TextEditingController());
  List<TextEditingController> StOutController2 =
      List.generate(150, (i) => TextEditingController());
  int i_value = 0;
  int get get_i_value => i_value;
  int ScannigVal = 0;
  int get get_ScannigVal => ScannigVal;
  int Scanned_Val = 0;
  int get get_Scanned_Val => Scanned_Val;
  int? selectIndex;
  int? selectIndex2;
  String? msg = '';
  bool? OnclickDisable = false;
  bool? OnScanDisable = false;

  bool searchbool = false;
  List<searchModel> searchData = [];
  List<searchModel> filtersearchData = [];
  List<StockOutwardList> StockOutward2 = [];
  bool? dbDataTrue = false;
  List<StockOutwardList> savedraftBill = [];
  List<StockOutwardList> SaveBill = [];

  adddlistner() {
    scrollController.addListener(_scrollListener);
  }

  bool isselect = false;
  disposmethod() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
  }

  isselectmethod() {
    isselect = !isselect;
    log(isselect.toString());
    notifyListeners();
  }

  void _scrollListener() {
    // Handle scroll events here
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // Reached the bottom of the scroll view
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < 2) {
      // Replace '3' with the total number of pages
      pageController.animateToPage(
        page,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      currentPage = page;
      notifyListeners();
    }
  }

  void goToNextPage() {
    print("goToNextPage::" + currentPage.toString());
    goToPage(currentPage + 1);
  }

  void goToPreviousPage() {
    goToPage(currentPage - 1);
  }

  setstatemethod() {
    print("goToPreviousPage::" + currentPage.toString());

    notifyListeners();
  }

  clear2() {
    stockOutwardLines = [];
    batchTable = [];
    log("KKKKKKKKKKKK");
    cancelbtn = false;
    submitBool == false;
    StockOutward.clear();
    StockOutward2.clear();
    getStockReqData();
    StOutController2[50].text = "";
    StOutController[50].clear();
    StOutController2[50].clear();
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    isselect = false;
    OnclickDisable = false;
    cancelbtn = false;
    i_value = 0;
    currentPage = 0;
    pageController = PageController(initialPage: 0);
    batch_datalist = null;
    passdata!.clear();
    StockOutward.clear();
    batch_i = 0;
    notifyListeners();
  }

  passData(ThemeData theme, BuildContext context, int index) {
    log("StockOutward[index].data length:" +
        StockOutward[index].data.length.toString());
    if (StockOutward[index].data.isNotEmpty) {
      selectIndex = index;
      i_value = index;

      passdata = StockOutward[index].data;
      notifyListeners();
    } else if (StockOutward[index].data.isEmpty) {
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
                      content: 'This Item Saved in DraftBill..!!',
                      theme: theme,
                    )),
                    buttonName: null));
          });
    }
    notifyListeners();
  }

  clearDataAll() {
    pageIndex = 0;
    // tappageIndex = 0;
    StOutController2[50].text = "";
    passdata = [];
    selectIndex;
    notifyListeners();
  }

//  Future<bool> onbackpress() {
//     DateTime now = DateTime.now();
//     // if(saveTrans == true){
//     //     return Future.value(false);
//     //   } else {
//     if (tappageIndex == 0) {
//       tappage.animateToPage(--tappageIndex,
//           duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
//     } else if (tappageIndex == 1) {
//       tappage.animateToPage(--tappageIndex,
//           duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
//     } else if (tappageIndex == 0) {
//       return Future.value(true);
//     }
//     return Future.value(false);
//     // }
//   }
  pagePlus() {
    goToNextPage();
  }

  pageminus() {
    goToPreviousPage();
  }

  String searchError = "";
  gethold() async {
    final Database db = (await DBHelper.getInstance())!;
    getHoldValues(db);
  }

  deletereq() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.deletereq(db).then((value) {
      //log("deleted");
    });
  }

  Selectindex(int i) {
    selectIndex = i;
    notifyListeners();
  }

  Selectindex2(int i) {
    selectIndex2 = i;
    notifyListeners();
  }

  getBatchData(int index, int list_i) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBStOutBatchData =
        await DBOperation.StOutCheckScanData(
            //com
            db,
            StockOutward[index].data[list_i].baseDocentry,
            StockOutward[index].data[list_i].docentry,
            StockOutward[index].data[list_i].lineNo,
            StockOutward[index].data[list_i].itemcode);
    print(getDBStOutBatchData.length);
    if (getDBStOutBatchData.isNotEmpty) {
      StockOutward[index].data[list_i].serialbatchList = [];
      for (int i = 0; i < getDBStOutBatchData.length; i++) {
        StockOutward[index]
            .data[list_i]
            .serialbatchList!
            .add(StockOutSerialbatch(
              lineno: getDBStOutBatchData[i]["lineno"].toString(),
              baseDocentry: getDBStOutBatchData[i]["baseDocentry"].toString(),
              itemcode: getDBStOutBatchData[i]["itemcode"].toString(),
              qty: getDBStOutBatchData[i]["quantity"] == null
                  ? 0
                  : int.parse(getDBStOutBatchData[i]["quantity"].toString()),
              scanbool: true,
              serialbatch: getDBStOutBatchData[i]["serialBatch"].toString(),
            ));
      }
      OnScanDisable = false;
      notifyListeners();
    } else {
      StockOutward[index].data[list_i].serialbatchList = [];
    }

    notifyListeners();
  }

  Future stoutLineRefersh(int index, int list_i,
      List<StockOutSerialbatch>? serialbatchList2) async {
    int totalscannedQty = 0;
    if (StockOutward[index].data[list_i].serialbatchList != null) {
      for (int i = 0;
          i < StockOutward[index].data[list_i].serialbatchList!.length;
          i++) {
        qtymycontroller[i].text = StockOutward[index]
            .data[list_i]
            .serialbatchList![i]
            .qty!
            .toString();
        totalscannedQty = totalscannedQty +
            StockOutward[index].data[list_i].serialbatchList![i].qty!;
      }
      StockOutward[index].data[list_i].serialbatchList = serialbatchList2;
      StockOutward[index].data[list_i].Scanned_Qty = totalscannedQty;
    }
    // print("test111::" + serialbatchList2![0].serialbatch!.toString());

    searchcon.clear();
    notifyListeners();
  }

  Future<List<StockSnapTModelDB>> getAllList(String data) async {
    getSearchedData = [];
    getfilterSearchedData = [];
    print("scan List length before::" + getSearchedData.length.toString());
    final Database db = (await DBHelper.getInstance())!;
    getSearchedData =
        await DBOperation.getSearchedStockListBatch(db, data); //com
    if (getSearchedData.isNotEmpty) {
      searchError = "";
      getfilterSearchedData = getSearchedData;
      //log("scan List length after::" + getSearchedData.length.toString());

      return getSearchedData;
    } else {
      searchError = "No data Found..!!";
      getSearchedData = [];
      getfilterSearchedData = [];
      searchcon.clear();
      return getSearchedData;
    }
  }

  filterListSearched(String v) {
    if (v.isNotEmpty) {
      getfilterSearchedData = getSearchedData
          .where((e) =>
              e.itemcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemname!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      getfilterSearchedData = getSearchedData;
      notifyListeners();
    }
  }

  ///

  Future scanqtyRemove(int index, int list_i, int batchI) async {
    final Database db = (await DBHelper.getInstance())!;
    StockOutward[index].data[list_i].serialbatchList![batchI].qty =
        StockOutward[index].data[list_i].serialbatchList![batchI].qty! - 1;
    msg = "";
    notifyListeners();
    if (StockOutward[index].data[list_i].serialbatchList![batchI].qty! == 0) {
      StockOutward[index].data[list_i].serialbatchList!.removeAt(batchI);
    }
    notifyListeners();
  }

  searchInitMethod() {
    StOutController[100].text = config.alignDate(config.currentDate());
    StOutController[101].text = config.alignDate(config.currentDate());
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

  getSalesDataDatewise(String fromdate, String todate) async {
    // log(fromdate);
    // log(todate);
    log("step1");
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getStockoutHeader =
        await DBOperation.getStockOutHeaderDateWise(
            //com
            db,
            config.alignDate2(fromdate),
            config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();

    if (getStockoutHeader.isNotEmpty) {
      //log("step2");

      for (int i = 0; i < getStockoutHeader.length; i++) {
        //log("step3");

        // log("getStockoutHeader.reqdocno::" + getStockoutHeader[i]["reqdocno"].toString());
        searchdata2.add(searchModel(
            username: UserValues.username,
            terminal: AppConstant.terminal,
            type: getStockoutHeader[i]["docstatus"] == null
                ? ""
                : getStockoutHeader[i]["docstatus"] == "2"
                    ? "Against Order"
                    : getStockoutHeader[i]["docstatus"] == "3"
                        ? "Against Stock"
                        : "",
            // sapDocNo: getStockoutHeader[i]["sapDocNo"] == null
            //     ? 0
            //     : int.parse(getStockoutHeader[i]["sapDocNo"].toString()),
            qStatus: getStockoutHeader[i]["qStatus"] == null
                ? ""
                : getStockoutHeader[i]["qStatus"].toString(),
            docentry: getStockoutHeader[i]["docentry"] == null
                ? 0
                : int.parse(getStockoutHeader[i]["docentry"].toString()),
            docNo: getStockoutHeader[i]["reqdocno"] == null
                ? '0'
                : getStockoutHeader[i]["reqdocno"].toString(),
            docDate: getStockoutHeader[i]["createdateTime"].toString(),
            sapNo: getStockoutHeader[i]["sapDocNo"] == null
                ? 0
                : int.parse(getStockoutHeader[i]["sapDocNo"].toString()),
            sapDate: getStockoutHeader[i]["createdateTime"] == null
                ? ""
                : getStockoutHeader[i]["createdateTime"].toString(),
            customeraName: getStockoutHeader[i]["reqfromWhs"].toString(),
            doctotal: getStockoutHeader[i][""] == null
                ? 0
                : double.parse(getStockoutHeader[i][""].toString())));
        notifyListeners();
      }
      searchData.addAll(searchdata2);
      filtersearchData = searchData;
    } else {
      // log("aasdasdasda");
      searchbool = false;
      searchData.clear();
      notifyListeners();
    }
    notifyListeners();
  }

  fixDataMethod(int docentry) async {
    StockOutward2.clear();
    StOutController2[50].text = "";
    if (isselect == true) {
      isselect = false;
    }
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDB_StoutHeader =
        await DBOperation.getStockOutHeader2(db, docentry); //com
    List<Map<String, Object?>> getDB_StoutLine =
        await DBOperation.StOutLineDB(db, docentry); //com
    List<StockOutwardList> StockOutDATA2 = [];
    List<StockOutwardDetails> stockDetails2 = [];
    // List<StockOutSerialbatch> stockSerialBatch2 = [];
    // log("Header" + getDB_StoutHeader.length.toString());
    // log("line" + getDB_StoutLine[0]["itemcode"].toString());
    // log("Batch");
//  List<StockOutwardDetails> stoutDetails = [];
//     List<StockOutwardList> stoutList = [];

// List<StockOutwardList> stoutList=[];
    for (int j = 0; j < getDB_StoutLine.length; j++) {
      List<StockOutSerialbatch> stoutSeralBatchList = [];

      stockDetails2.add(StockOutwardDetails(
          createdUserID: 1,
          createdateTime: getDB_StoutLine[j]["createdateTime"].toString(),
          baseDocentry:
              int.parse(getDB_StoutLine[j]["baseDocentry"].toString()),
          docentry: int.parse(getDB_StoutLine[j]["docentry"].toString()),
          dscription: getDB_StoutLine[j]["description"].toString(),
          itemcode: getDB_StoutLine[j]["itemcode"].toString(),
          lastupdateIp: "",
          lineNo: getDB_StoutLine[j]["lineno"] == null
              ? 0
              : int.parse(getDB_StoutLine[j]["lineno"].toString()),
          qty: getDB_StoutLine[j]["quantity"] == null
              ? 0
              : int.parse(getDB_StoutLine[j]["quantity"].toString()),
          status: getDB_StoutLine[j]["createdateTime"].toString(),
          updatedDatetime: getDB_StoutLine[j]["createdateTime"].toString(),
          updateduserid: 1,
          price: 1,
          serialBatch: getDB_StoutLine[j]["serialBatch"].toString(),
          taxRate: 0.0,
          taxType: "",
          trans_Qty: getDB_StoutLine[j]["transferQty"] == null
              ? 0
              : int.parse(getDB_StoutLine[j]["transferQty"].toString()),
          Scanned_Qty: getDB_StoutLine[j]["scannedQty"] == null
              ? 0
              : int.parse(getDB_StoutLine[j]["scannedQty"].toString()),
          baseDocline: getDB_StoutLine[j]["baseDocline"] == null
              ? 0
              : int.parse(getDB_StoutLine[j]["baseDocline"].toString()),
          serialbatchList: stoutSeralBatchList));
    }
    StOutController2[50].text = getDB_StoutHeader[0]["remarks"].toString();
    StockOutDATA2.add(StockOutwardList(
        remarks: getDB_StoutHeader[0]["remarks"].toString(),
        branch: getDB_StoutHeader[0]["branch"].toString(),
        // createdUserID: StockOut[index].createdUserID,
        // createdateTime: StockOut[index].createdateTime,
        docentry: getDB_StoutHeader[0]["docentry"].toString(),
        baceDocentry: getDB_StoutHeader[0]["baceDocentry"].toString(),
        docstatus: getDB_StoutHeader[0]["baceDocentry"].toString(),
        documentno: getDB_StoutHeader[0]["documentno"] == null
            ? "0"
            : getDB_StoutHeader[0]["documentno"].toString(),
        // isagainstorder: StockOut[index].isagainstorder,
        // isagainststock: StockOut[index].isagainststock,
        // lastupdateIp: StockOut[index].lastupdateIp,
        // reqdocno: StockOut[index].reqdocno,
        // reqdocseries: StockOut[index].reqdocseries,
        // reqdocseriesno: StockOut[index].reqdocseriesno,
        // reqdoctime: StockOut[index].reqdoctime,
        reqfromWhs: getDB_StoutHeader[0]["reqfromWhs"].toString(),
        // reqsystime: StockOut[index].reqsystime,
        reqtoWhs: getDB_StoutHeader[0]["reqtoWhs"].toString(),
        reqtransdate: getDB_StoutHeader[0]["transdate"].toString(),
        // salesexec: StockOut[index].salesexec,
        // seresid: StockOut[index].seresid,
        // seriesnum: StockOut[index].seriesnum,
        // sysdatetime: StockOut[index].sysdatetime,
        // totalitems: StockOut[index].totalitems,
        // totalltr: StockOut[index].totalltr,
        // totalqty: StockOut[index].totalqty,
        // totalweight: StockOut[index].totalweight,
        // transactiondate: StockOut[index].transactiondate,
        // transtime: StockOut[index].transtime,
        // updatedDatetime: StockOut[index].updatedDatetime,
        // updateduserid: StockOut[index].updateduserid,
        data: stockDetails2,
        sapbaceDocentry: ''));

    StockOutward2.addAll(StockOutDATA2);
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
      StOutController[100].text = datetype!;
      print(datetype);
    } else if (pickedDate != null && datetype == "To") {
      print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
      StOutController[101].text = datetype!;
      print(datetype);
    } else {
      print("Date is not selected");
    }
  }

  int qqqttyy = 0;
  qqqqq(int index, String serialBatch, int list_i, String itemcode, im) {
    qqqttyy = 0;
    // for (int ix = 0; ix < soData.length; ix++) {
    for (int im = 0;
        im < StockOutward[index].data[list_i].serialbatchList!.length;
        im++) {
      if (StockOutward[index].data[list_i].itemcode ==
          StockOutward[index].data[list_i].serialbatchList![im].itemcode) {
        qqqttyy = qqqttyy + int.parse(qtymycontroller[im].text);
        //log("qqqttyyqqqttyy:::${qqqttyy}");
        notifyListeners();
      }
    }
    notifyListeners();
  }

  stkOutEditQty(
      int index, String serialBatch, int list_i, String itemcode, im) async {
    final Database db = (await DBHelper.getInstance())!;
    // List<Map<String, Object?>> serialbatchCheck = await DBOperation.cfoserialBatchCheck(db, itemcode);
    msg = '';
    List<Map<String, Object?>> serailbatchCheck =
        await DBOperation.serialBatchCheck(
            db,
            serialBatch.toString().trim(), //com
            StockOutward[index].data[list_i].itemcode.toString());
    if (serailbatchCheck.isNotEmpty) {
      if (int.parse(serailbatchCheck[0]["quantity"].toString()) != 0) {
        //log("serialbatchList MM::" +
        // StockOutward[index].data[list_i].balQty.toString());
        if (int.parse(qtymycontroller[im].text) != 0) {
          int editqqty = int.parse(qtymycontroller[im].text);
          qqqqq(index, serialBatch, list_i, itemcode, im);
          if (qqqttyy <=
              int.parse(serailbatchCheck[0]["quantity"].toString())) {
            if (qqqttyy <= StockOutward[index].data[list_i].balQty!) {
              qtymycontroller[im].text = editqqty.toString();
              StockOutward[get_i_value]
                  .data[batch_i!]
                  .serialbatchList![im]
                  .qty = int.parse(qtymycontroller[im].text);

              notifyListeners();
            } else {
              qtymycontroller[im].text = 1.toString();
              msg = "No Qty Does Not Have...!!";

              notifyListeners();
            }
          } else {
            qtymycontroller[im].text = 1.toString();
            msg = "No Qty Does Not Have...!!";
            notifyListeners();
          }
        } else {
          qtymycontroller.removeAt(im);
          StockOutward[index].data[list_i].serialbatchList!.removeAt(im);
          notifyListeners();
        }
      }
    }
    notifyListeners();
  }

  scanmethod(int index, String serialBatch, int list_i, String itemcode) async {
    print("AAAA1:" + index.toString());
    print("AAAA1:" + serialBatch.toString());
    print("AAAA1:" + list_i.toString());
    print("AAAA1:" + itemcode.toString());
    msg = "";
    serialBatch = searchcon.text.toString();
    if (itemcode == StockOutward[index].data[list_i].itemcode.toString()) {
      print("AAAA2:" + list_i.toString());
      OnScanDisable = true;
      // StockOutward[i].data.length;
      final Database db = (await DBHelper.getInstance())!;
      msg = "";
      List<Map<String, Object?>> serailbatchCheck =
          await DBOperation.serialBatchCheck(
              db,
              serialBatch.toString().trim(), //com
              StockOutward[index].data[list_i].itemcode.toString());
      if (serailbatchCheck.isNotEmpty) {
        if (int.parse(serailbatchCheck[0]["quantity"].toString()) != 0) {
          print("AAAA3:" + serialBatch);

          int totalqty = int.parse(serailbatchCheck[0]["quantity"].toString());
          int separateBatchQty = 0;
          int totalscanqty =
              StockOutward[index].data[list_i].trans_Qty!; //newchange
          bool AlreadyScan = false;

          if (StockOutward[index].data[list_i].serialbatchList != null) {
            for (int i = 0;
                i < StockOutward[index].data[list_i].serialbatchList!.length;
                i++) {
              if (serialBatch ==
                  StockOutward[index]
                      .data[list_i]
                      .serialbatchList![i]
                      .serialbatch) {
                separateBatchQty =
                    StockOutward[index].data[list_i].serialbatchList![i].qty!;
                qtymycontroller[i].text =
                    (int.parse(qtymycontroller[i].text.toString()) + 1)
                        .toString();
              }

              totalscanqty = totalscanqty +
                  StockOutward[index].data[list_i].serialbatchList![i].qty!;
              AlreadyScan = true;
              notifyListeners();
            }
          }
          if ((totalqty > separateBatchQty) &&
              (StockOutward[index].data[list_i].qty != totalscanqty)) {
            print("AAAA4:");
            List<StockOutSerialbatch> serialbatchList = [];

            msg = "";
            if (AlreadyScan == false) {
              print("AAAA5:");

              serialbatchList.add(StockOutSerialbatch(
                lineno: StockOutward[index].data[list_i].lineNo.toString(),
                baseDocentry:
                    StockOutward[index].data[list_i].baseDocentry.toString(),
                itemcode: StockOutward[index].data[list_i].itemcode,
                qty: 1,
                serialbatch: serialBatch.toString(),
                docstatus: null,
                docentry: '',
              ));
              StockOutward[index].data[list_i].serialbatchList =
                  serialbatchList;

              for (int im = 0;
                  im < StockOutward[index].data[list_i].serialbatchList!.length;
                  im++) {
                qtymycontroller[im].text = StockOutward[index]
                    .data[list_i]
                    .serialbatchList![im]
                    .qty!
                    .toString();
              }
            } else {
              int? count = await ExistingBatchCheck(index, list_i, serialBatch);

              if (count != null) {
                StockOutward[index].data[list_i].serialbatchList![count].qty =
                    StockOutward[index]
                            .data[list_i]
                            .serialbatchList![count]
                            .qty! +
                        1;
              } else {
                StockOutward[index]
                    .data[list_i]
                    .serialbatchList!
                    .add(StockOutSerialbatch(
                      lineno:
                          StockOutward[index].data[list_i].lineNo.toString(),
                      baseDocentry: StockOutward[index]
                          .data[list_i]
                          .baseDocentry
                          .toString(),
                      itemcode: StockOutward[index].data[list_i].itemcode,
                      qty: 1,
                      serialbatch: serialBatch.toString(),
                      docstatus: null,
                      docentry: '',
                    ));
                for (int im = 0;
                    im <
                        StockOutward[index]
                            .data[list_i]
                            .serialbatchList!
                            .length;
                    im++) {
                  if (StockOutward[index]
                          .data[list_i]
                          .serialbatchList![im]
                          .serialbatch ==
                      serialBatch) {
                    qtymycontroller[im].text = StockOutward[index]
                        .data[list_i]
                        .serialbatchList![im]
                        .qty!
                        .toString();
                  }
                }
              }
            }
          } else {
            //log("No More Qty to add...!!");
            msg = 'No More Qty to add...!!';
            for (int im = 0;
                im < StockOutward[index].data[list_i].serialbatchList!.length;
                im++) {
              if (StockOutward[index]
                      .data[list_i]
                      .serialbatchList![im]
                      .serialbatch ==
                  serialBatch) {
                qtymycontroller[im].text = 1.toString();
              }
            }
          }
        } else {
          msg = "No Qty Does Not Have...!!";
          for (int im = 0;
              im < StockOutward[index].data[list_i].serialbatchList!.length;
              im++) {
            if (StockOutward[index]
                    .data[list_i]
                    .serialbatchList![im]
                    .serialbatch ==
                serialBatch) {
              qtymycontroller[im].text = 1.toString();
            }
          }
        }
        // }

        notifyListeners();
      } else {
        msg = 'Wrong BatchCode Scan...!!';
      }
      OnScanDisable = false;
      serialBatch = "";
    } else {
      msg = "Itemcode Does not Matched...!!";
      notifyListeners();
    }

    searchcon.clear();
    OnScanDisable = false;
    notifyListeners();
  }

  Future<int?> ExistingBatchCheck(int index, int list_i, String serialBatch) {
    for (int i = 0;
        i < StockOutward[index].data[list_i].serialbatchList!.length;
        i++) {
      if (StockOutward[index].data[list_i].serialbatchList![i].serialbatch ==
              serialBatch.toString().trim() &&
          StockOutward[index].data[list_i].itemcode ==
              StockOutward[index].data[list_i].serialbatchList![i].itemcode) {
        return Future.value(i);
      }
    }
    return Future.value(null);
  }

  suspendedbutton(int index, BuildContext context, ThemeData theme,
      List<StockOutwardDetails>? data, StockOutwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;

    int? scannedtottal = 0;
    int? totalReqQty = 0;
    int? totalTransQty = 0;

    for (int i = 0; i < data!.length; i++) {
      scannedtottal = scannedtottal! + data[i].Scanned_Qty!;
      totalTransQty = totalTransQty! + data[i].trans_Qty!;
      totalReqQty = totalReqQty! + data[i].qty!;
      notifyListeners();
    }
    // log(scannedtottal!.toString());
    // log(totalReqQty!.toString());

    if (scannedtottal == 0) {
      Get.defaultDialog(
          title: "Alert",
          middleText: 'Items Already Suspended..!!',
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyLarge,
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
    } else if (scannedtottal != 0) {
      StOutController[50].clear();

      for (int i = 0; i < StockOutward[index].data.length; i++) {
        StockOutward[index].data[i].Scanned_Qty = 0;
        StockOutward[index].data[i].serialbatchList = [];
        // await DBOperation.deletAlreadyHoldData(
        //     //com
        //     db,
        //     int.parse(StockOutward[index].baceDocentry.toString()));
        // await DBOperation.deletAlreadyHoldDataLine(
        //     //com
        //     db,
        //     int.parse(StockOutward[index].baceDocentry.toString()),
        //     StockOutward[index].data[i].itemcode.toString());
        // await DBOperation.deleteSuspendBatchStOut(
        //     //com
        //     db,
        //     int.parse(StockOutward[index].baceDocentry.toString()),
        //     StockOutward[index].data[i].itemcode.toString());
        // getHoldValues(db);
        // StockOutward[index].data[i].serialbatchList!=null;
        notifyListeners();
      }
      i_value = index;
      // passdata!.clear();
      // getStockReqData();

      // SuspendDBInsert('suspend', context, theme, index, data, datatotal);
    }
    notifyListeners();
  }

  submitbutton(int index, BuildContext context, ThemeData theme,
      List<StockOutwardDetails>? data, StockOutwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;

    OnclickDisable = true;
    if (data!.isEmpty) {
      Get.defaultDialog(
              title: "Alert",
              middleText: 'Please Scan Items..!!',
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
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
              radius: 0)
          .then((value) {
        OnclickDisable = false;
        notifyListeners();
      });
    } else {
      int? scannedtottal = 0;
      int? totalReqQty = 0;
      int? totalscanqty = 0;

      for (int i = 0; i < data.length; i++) {
        scannedtottal =
            scannedtottal! + data[i].Scanned_Qty! + data[i].trans_Qty!;
        totalReqQty = totalReqQty! + data[i].qty!;
        totalscanqty = totalscanqty! + data[i].Scanned_Qty!;
        notifyListeners();
      }
      if (totalscanqty == 0) {
        Get.defaultDialog(
                title: "Alert",
                middleText: 'Please Select Items..!!',
                backgroundColor: Colors.white,
                titleStyle:
                    theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
                middleTextStyle: theme.textTheme.bodyLarge,
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
          OnclickDisable = false;
          notifyListeners();
        });
      } else if (totalscanqty != 0) {
        await DBOperation.deletAlreadyHoldData(
            //com
            db,
            int.parse(StockOutward[index].baceDocentry.toString()));
        //log("Basedocentry::" + StockOutward[index].baceDocentry.toString());
        await savepartialData('submit', context, theme, index, data, datatotal);
        // if (holddocentry.isNotEmpty) {
        // await DBOperation.deleteHoldStOut(db, holddocentry).then((value) {
        //   getHoldValues(db);
        //   holddocentry = "";
        //   notifyListeners();
        // });
        // }
      }
    }
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

    log("datattata doc : ${data.substring(8)}");
    return listdata; // int.parse(data.substring(8));
  }

  bool submitBool = false;
  savepartialData(
      String docstatus,
      BuildContext context,
      ThemeData theme,
      int index,
      List<StockOutwardDetails>? data,
      StockOutwardList? datatotal) async {
    OnclickDisable = true;
    final Database db = (await DBHelper.getInstance())!;
    List<StockOutHeaderDataDB> StOutHeader = []; //headersss
    List<StockOutLineDataDB> StOutLine = [];
    List<StockOutBatchDataDB> StOutBatch = [];
    submitBool = false;
    int scanToatal = 0;
    int qtyToatal = 0;
    int tempDocentry = 0;

    for (int i = 0; i < StockOutward[index].data.length; i++) {
      scanToatal = scanToatal + StockOutward[index].data[i].Scanned_Qty!;
      qtyToatal = qtyToatal + StockOutward[index].data[i].qty!;
      if (scanToatal == qtyToatal) {
        submitBool = true;
        notifyListeners();
      }
    }

    int? counofData = await DBOperation.getcountofTable(
        db, "docentry", "StockOutHeaderDataDB");
    int? docEntryCreated = 0;
    //  await DBOperation.generateDocentr(db, "docentry", "SalesHeader");
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
          db, "docentry", "StockOutHeaderDataDB");
    }

    String docmntNo = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 5);
    List<String> getseriesvalue = await checkingdoc(5);
    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    docmntNo = finlDocnum + documentN0.toString();
    DBOperation.getSaleHeadSapDet(
        db, int.parse(StockOutward[index].baceDocentry!), 'SalesHeader');
    List<Map<String, Object?>> count = await DBOperation.StockHeaderCheck(
        db, int.parse(StockOutward[index].baceDocentry.toString()));

    List<Map<String, Object?>> sapdetails = await DBOperation.getSaleHeadSapDet(
        db,
        int.parse(StockOutward[index].baceDocentry.toString()),
        'StockReqHDT');
    log("From warehouse::${StockOutward[index].reqfromWhs}");
    log("to warehouse::${StockOutward[index].reqtoWhs}");

    StOutHeader.add(StockOutHeaderDataDB(
      docentry: docEntryCreated.toString(),
      documentno: docmntNo,
      terminal: AppConstant.terminal,
      branch: AppConstant.branch,
      baseDocentry: StockOutward[index].baceDocentry,
      createdUserID: UserValues.userID,
      createdateTime: config.currentDate(),
      docstatus: "3",
      lastupdateIp: UserValues.lastUpdateIp,
      reqdocno: StockOutward[index].documentno.toString(),
      docseries: "",
      docseriesno: 0,
      doctime: config.currentDate(),
      reqfromWhs: StockOutward[index].reqfromWhs,
      systime: config.currentDate(),
      reqtoWhs: "HOGIT",
      // StockOutward[index].reqtoWhs,
      transdate: config.currentDate(),
      salesexec: "",
      totalitems: 0,
      totalltr: 0,
      totalqty: 0,
      updatedDatetime: config.currentDate(),
      updateduserid: UserValues.userID,
      sapDocNo: null,
      sapDocentry: null,
      qStatus: 'N',

      sapStockReqdocentry:
          //  "18607",
          sapdetails[0]['sapDocentry'].toString(), //checkkkkkkk
      sapStockReqdocnum:
          // '559',
          sapdetails[0]['sapDocNo'].toString(),
      remarks: StOutController[50].text.isEmpty
          ? ""
          : StOutController[50].text.toString(),
    ));

    int? docentry2 = await DBOperation.insertStockOutheader(db, StOutHeader);

    await DBOperation.updatenextno(db, 5, nextno);

    tempDocentry = docentry2!;
    for (int i = 0; i < StockOutward[index].data.length; i++) {
      List<StockOutSerialbatch>? serialbatchList2 = [];
      StOutBatch.clear();

      String concatenatedText = '';
      int totalbatchQty = 0;

      if (StockOutward[index].data[i].docentry != null) {
        await DBOperation.deletAlreadyHoldDataLine(
          //com
          db,
          int.parse(StockOutward[index].baceDocentry.toString()),
          int.parse(StockOutward[index].docentry.toString()),
          StockOutward[index].data[i].itemcode.toString(),
        );
      }
      if (StockOutward[index].data[i].serialbatchList != null) {
        if (StockOutward[index].data[i].docentry != null) {
          await DBOperation.deleteBatch(
            //Delete  Already db saved Hold batch data
            db,
            int.parse(StockOutward[index].data[i].baseDocentry.toString()),
            int.parse(StockOutward[index].data[i].docentry.toString()),
            StockOutward[index].data[i].itemcode!,
          );
        }
        for (int l = 0;
            l < StockOutward[index].data[i].serialbatchList!.length;
            l++) {
          StOutBatch.add(StockOutBatchDataDB(
            lineno: StockOutward[index]
                .data[i]
                .serialbatchList![l]
                .lineno
                .toString(),
            baseDocentry: StockOutward[index]
                .data[i]
                .serialbatchList![l]
                .baseDocentry
                .toString(),
            itemcode: StockOutward[index]
                .data[i]
                .serialbatchList![l]
                .itemcode
                .toString(),
            qty: StockOutward[index].data[i].serialbatchList![l].qty == null
                ? 0
                : int.parse(StockOutward[index]
                    .data[i]
                    .serialbatchList![l]
                    .qty
                    .toString()),
            serialbatch: StockOutward[index]
                .data[i]
                .serialbatchList![l]
                .serialbatch
                .toString(),
            docentry: docentry2.toString(),
            docstatus: "3",
          ));
          concatenatedText = '';
          concatenatedText += StockOutward[index]
                  .data[i]
                  .serialbatchList![l]
                  .serialbatch
                  .toString() +
              '/';
          totalbatchQty = totalbatchQty +
              int.parse(StockOutward[index]
                  .data[i]
                  .serialbatchList![l]
                  .qty
                  .toString());
        }
      }
      await DBOperation.insertStOutBatch(
          db, StOutBatch); //  List<Map<String, Object?>> getDB_StOutBatch =

      // await DBOperation.getStockOutBatch(
      //     db, int.parse(StockOutward[index].baceDocentry.toString()));
      print("Scanned QTY Submit::" +
          StockOutward[index].data[i].Scanned_Qty.toString());
      if (StockOutward[index].data[i].Scanned_Qty != 0) {
        StOutLine.add(StockOutLineDataDB(
          lineno: StockOutward[index].data[i].lineNo.toString(),
          docentry: docentry2.toString(),
          itemcode: StockOutward[index].data[i].itemcode.toString(),
          description: StockOutward[index].data[i].dscription,
          qty: int.parse(StockOutward[index].data[i].qty.toString()),
          baseDocentry: StockOutward[index].data[i].baseDocentry.toString(),
          baseDocline: StockOutward[index].data[i].lineNo.toString(),
          status: StockOutward[index].data[i].status,
          traansferQty: 0,
          scannedQty: StockOutward[index].data[i].Scanned_Qty,
          serialBatch: concatenatedText.toString(),
          // getDBStOutBatchData[0]["serialBatch"] == null ||
          //         getDBStOutBatchData[0]["serialBatch"] == ""
          //     ? ""
          //     : getDBStOutBatchData[0]["serialBatch"].toString(),
          branch: AppConstant.branch,
          terminal: AppConstant.terminal,
        ));
      }
    }
    // if(StOutLine.isNotEmpty){
    await DBOperation.insertStOutLine(db, StOutLine);

    // }
    // }
    bool? netbool = await config.haveInterNet();

    // log("config.haveInterNet():::" + netbool.toString());

    if (netbool == true) {
      postingStockOutward(
          docstatus,
          tempDocentry,
          index,
          int.parse(StockOutward[index].baceDocentry!),
          data,
          datatotal,
          context,
          theme);
      // await PostRabitMq(
      //     // count.length == 0
      //     //     ?
      //     tempDocentry,
      //     int.parse(StockOutward[index].baceDocentry!),
      //     StockOutward[index].reqfromWhs.toString());
    }

    // await Get.defaultDialog(
    //   title: "Success",
    //   middleText: ' Sucessfully Done \n'
    //       "Stock Outward successfully saved..!!",
    //   backgroundColor: Colors.white,
    //   titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
    //   middleTextStyle: theme.textTheme.bodyLarge,
    //   radius: 5,
    //   actions: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         TextButton(
    //           child: Text("Close"),
    //           onPressed: () {
    //             OnclickDisable = false;
    //             if (submitBool == true) {
    //               StockOutward.remove(datatotal);
    //               data!.clear();
    //               StOutController[50].text = "";
    //               qtymycontroller =
    //                   List.generate(100, (ij) => TextEditingController());
    //               // StockOutward[index].data.clear();
    //               // tappageIndex = 0;
    //               // tappage = PageController();
    //               notifyListeners();
    //               // myFuture(context);
    //               // Navigator.of(context)
    //               //     .push(MaterialPageRoute(builder: (context) => DashBoardScreen()));
    //             } else {
    //               submitBool == false;
    //             }
    //             Get.offAllNamed(ConstantRoutes.dashboard);
    //           },
    //         ),
    //       ],
    //     ),
    //   ],
    // ).then((value) {
    //   OnclickDisable = false;
    //   if (submitBool == true) {
    //     StockOutward.remove(datatotal);
    //     data!.clear();
    //     StOutController[50].text = "";
    //     // StockOutward[index].data.clear();
    //     // tappageIndex = 0;
    //     // tappage = PageController();
    //     notifyListeners();
    //     // myFuture(context);
    //     // Navigator.of(context)
    //     //     .push(MaterialPageRoute(builder: (context) => DashBoardScreen()));
    //   } else {
    //     submitBool == false;
    //   }
    // });
    // // if (submitBool == true) {
    // //   Get.toNamed(ConstantRoutes.dashboard);
    // //   // Navigator.of(context)
    // //   //     .push(MaterialPageRoute(builder: (context) => DashBoardScreen()));
    // //   // notifyListeners();
    // // }
    notifyListeners();
  }

  // static Future<List<Map<String, Object?>>> getStockOutBatch(
  //     Database db, int docentry) async {
  //   List<Map<String, Object?>> result = await db.rawQuery('''
  //   select * from StockOutBatchDB where docentry = "$docentry"
  //    ''');
  //   // // log("StockReqHDT hold:: "+result.toList().toString());

  //   return result;
  // }
  postingStockOutward(
      String docstatus,
      int docEntry,
      int index,
      int baseentry,
      List<StockOutwardDetails>? data,
      StockOutwardList? datatotal,
      BuildContext context,
      ThemeData theme) async {
    await sapLoginApi(context);
    await postOutwardData(
        docstatus, docEntry, index, baseentry, data, datatotal, context, theme);
    notifyListeners();
  }

  List<StockOutLineModel>? stockOutwardLines = [];
  List<StockOutbatch>? batchTable;
  addBatchtable(int index, int ik) {
    batchTable = [];
    for (int i = 0;
        i < StockOutward[index].data[ik].serialbatchList!.length;
        i++) {
      batchTable!.add(StockOutbatch(
        // baseLineNumber: i,
        quantity: double.parse(
            StockOutward[index].data[ik].serialbatchList![i].qty.toString()),
        // StockOutward[index].data[ik].serialbatchList![i].qty.toString()),
        batchNumberProperty: StockOutward[index]
            .data[ik]
            .serialbatchList![i]
            .serialbatch
            .toString(),
      ));
    }
  }

  addOutLinedata(int index) {
    stockOutwardLines = [];
    for (int i = 0; i < StockOutward[index].data.length; i++) {
      addBatchtable(index, i);
      stockOutwardLines!.add(StockOutLineModel(
          // Currency: "TZS",
          fromWarehouseCode: UserValues.branch.toString(),
          itemCode: StockOutward[index].data[i].itemcode.toString(),
          itemDescription: StockOutward[index].data[i].dscription.toString(),
          quantity:
              double.parse(StockOutward[index].data[i].Scanned_Qty.toString()),
          unitPrice: double.parse(StockOutward[index].data[i].price.toString()),
          toWarehouseCode: 'HOGIT',
          lineNum: i,
          baseDocentry:
              int.parse(StockOutward[index].sapbaceDocentry.toString()),
          baseline: StockOutward[index].data[i].baseDocline.toString(),
          batchNumbers: batchTable!,
          baseType: '1250000001'));
    }
    notifyListeners();
  }

  postOutwardData(
      String docstatus,
      int docEntryId,
      int index,
      int baseentry,
      List<StockOutwardDetails>? data,
      StockOutwardList? datatotal,
      BuildContext context,
      ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    var uuid = Uuid();
    String? uuidg = uuid.v1();
    await addOutLinedata(index);
    PostStkOutwardAPi.fromWarehouse = UserValues.branch;
    PostStkOutwardAPi.toWarehouse = "HOGIT";
    PostStkOutwardAPi.comments = StOutController[50].text.toString();
    PostStkOutwardAPi.docDate = config.currentDate();
    PostStkOutwardAPi.dueDate = config.currentDate();
    PostStkOutwardAPi.stockTransferLines = stockOutwardLines;
    PostStkOutwardAPi.method(uuidg);
    notifyListeners();
    await PostStkOutwardAPi.getGlobalData(uuidg).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.docEntry != null) {
          sapDocentry = value.docEntry.toString();
          sapDocuNumber = value.docNum.toString();

          await DBOperation.UpdtSapDetSalHead(db, int.parse(sapDocentry!),
              int.parse(sapDocuNumber!), docEntryId, 'StockOutHeaderDataDB');

          await updateOutWrdStkSnaptab(int.parse(docEntryId.toString()),
              int.parse(baseentry.toString()));

          await PostRabitMq2(int.parse(docEntryId.toString()),
              baseentry.toString(), RequestedWarehouse.toString());

          await Get.defaultDialog(
            title: "Success",
            middleText: ' Sucessfully Done \n'
                "Stock outward successfully saved..!!",
            backgroundColor: Colors.white,
            titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
            middleTextStyle: theme.textTheme.bodyLarge,
            radius: 5,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text("Close"),
                    onPressed: () {
                      OnclickDisable = false;
                      if (submitBool == true) {
                        StockOutward.clear();
                        StockOutward.remove(datatotal);
                        StockOutward[index].data.clear();
                        data!.clear();
                        StOutController[50].text = "";
                        qtymycontroller =
                            List.generate(100, (ij) => TextEditingController());

                        notifyListeners();
                      } else {
                        submitBool == false;
                      }
                      Get.offAllNamed(ConstantRoutes.dashboard);
                    },
                  ),
                ],
              ),
            ],
          ).then((value) {
            OnclickDisable = false;
            if (submitBool == true) {
              StockOutward.remove(datatotal);
              data!.clear();
              StOutController[50].text = "";
              StockOutward.remove(index);
              StockOutward[index].data.clear();
              notifyListeners();
            } else {
              submitBool == false;
            }
          });
        }
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        await Get.defaultDialog(
          title: "Alert",
          middleText: value.error!.message!.value.toString(),
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
        ).then((value) {
          OnclickDisable = false;
          StockOutward[index].data.clear();
        });
      } else {
        await Get.defaultDialog(
          title: "Alert",
          middleText: 'Something went Wrong..!!',
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
        ).then((value) {
          OnclickDisable = false;
          StockOutward[index].data.clear();
        });
        notifyListeners();
      }

      notifyListeners();
    });
  }

  Future myFuture(BuildContext context, ThemeData theme,
      List<StockOutwardDetails>? data) async {
    if (data!.isEmpty) {
      Get.defaultDialog(
          // content: Container(
          //   width: Screens.width(context) * 0.4,
          //   height: Screens.bodyheight(context) * 0.1,
          // ),
          title: "Alert",
          middleText: 'Please Select Items..!!',
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyLarge,
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
    } else {
      int? scannedtottal = 0;
      int? totalReqQty = 0;
      int? totalscanqty = 0;

      for (int i = 0; i < data.length; i++) {
        scannedtottal =
            scannedtottal! + data[i].Scanned_Qty! + data[i].trans_Qty!;
        totalReqQty = totalReqQty! + data[i].qty!;
        totalscanqty = totalscanqty! + data[i].Scanned_Qty!;
        notifyListeners();
      }
      // log(scannedtottal!.toString());
      // log(totalReqQty!.toString());

      if (totalscanqty == 0) {
        Get.defaultDialog(
            title: "Alert",
            middleText: 'Please Select Items..!!',
            backgroundColor: Colors.white,
            titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
            middleTextStyle: theme.textTheme.bodyLarge,
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
      } else if (totalscanqty != 0) {
        // await new Future.delayed(new Duration(seconds: 1));
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => DashBoardScreen()));

        // Get.toNamed(ConstantRoutes.dashboard);
      }
    }
  }

  deleteoutdata() async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.deletAllOutHoldData(db);
    notifyListeners();
  }

  holdbutton(int index, BuildContext context, ThemeData theme,
      List<StockOutwardDetails>? data, StockOutwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;
    int? scannedtottal = 0;
    int? totalReqQty = 0;
    int? totalTransQty = 0;

    for (int i = 0; i < data!.length; i++) {
      scannedtottal = scannedtottal! + data[i].Scanned_Qty!;
      totalTransQty = totalTransQty! + data[i].trans_Qty!;
      totalReqQty = totalReqQty! + data[i].qty!;
      notifyListeners();
    }
    // log(scannedtottal!.toString());
    // log(totalReqQty!.toString());

    if (scannedtottal == 0) {
      Get.defaultDialog(
          title: "Alert",
          middleText: 'Please Scan Minimum One Item..!!',
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyLarge,
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
    } else if (scannedtottal != 0) {
      //log("Step------1");
      print("object");

      // StockOut.removeAt(index);
      // int? count = dupilicateDRAFTDataCheck(StockOutward[index]);
      // if (count != null) {
      await DBOperation.deletAlreadyHoldData(
          //com
          db,
          int.parse(StockOutward[index].baceDocentry.toString()));
      // log("Step------2");

      // savedraftBill.removeAt(count);
      // }
      await HoldValueInsertToDB('hold', context, theme, index, data, datatotal);
      // if (holddocentry.isNotEmpty) {
      //   await DBOperation.deleteHoldStOut(db, holddocentry).then((value) {
      //     getHoldValues(db);
      //     holddocentry = "";
      //     notifyListeners();
      //   });
      // }
      notifyListeners();
    }

    notifyListeners();
  }

  HoldValueInsertToDB(
      String docstatus,
      BuildContext context,
      ThemeData theme,
      int index,
      List<StockOutwardDetails>? data,
      StockOutwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;
    List<StockOutHeaderDataDB> StOutHeader = [];
    List<StockOutLineDataDB> StOutLine = [];
    List<StockOutBatchDataDB> StOutBatch = [];

    // log("Save Data Process");
    // log("Save Data Process" + StockOutward[index].baceDocentry.toString());
    int? docEntryCreated = await DBOperation.generateDocentr(
        db, "docentry", "StockOutHeaderDataDB");

    StOutHeader.add(StockOutHeaderDataDB(
        terminal: AppConstant.terminal,
        docentry: docEntryCreated.toString(),
        branch: AppConstant.branch,
        createdUserID: UserValues.userID,
        baseDocentry: StockOutward[index].baceDocentry,
        createdateTime: config.currentDate(),
        docstatus: "1",
        lastupdateIp: UserValues.lastUpdateIp,
        reqdocno: StockOutward[index].documentno,
        docseries: "",
        docseriesno: 0,
        doctime: config.currentDate(),
        reqfromWhs: StockOutward[index].reqfromWhs,
        systime: config.currentDate(),
        reqtoWhs: "HOGIT",
        transdate: config.currentDate(),
        salesexec: "",
        totalitems: 0,
        totalltr: 0,
        totalqty: 0,
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID,
        sapDocNo: null,
        sapDocentry: null,
        qStatus: 'N',
        sapStockReqdocentry: '',
        sapStockReqdocnum: '',
        remarks: StOutController[50].text.isEmpty
            ? ""
            : StOutController[50].text.toString()));
    int? docentry2 = await DBOperation.insertStockOutheader(db, StOutHeader);

    for (int i = 0; i < StockOutward[index].data.length; i++) {
      List<StockOutBatchDataDB>? serialbatchList2 = [];
      if (StockOutward[index].data[i].serialbatchList != null) {
        if (StockOutward[index].data[i].docentry != null) {
          await DBOperation.deleteBatch(
            db,
            int.parse(StockOutward[index].data[i].baseDocentry.toString()),
            int.parse(StockOutward[index].data[i].docentry.toString()),
            StockOutward[index].data[i].itemcode!,
          );
        }
        for (int j = 0;
            j < StockOutward[index].data[i].serialbatchList!.length;
            j++) {
          print("test zero::" +
              StockOutward[index].data[i].serialbatchList![j].qty.toString());
          serialbatchList2.add(StockOutBatchDataDB(
              lineno: StockOutward[index].data[i].serialbatchList![j].lineno,
              itemcode:
                  StockOutward[index].data[i].serialbatchList![j].itemcode,
              qty: StockOutward[index].data[i].serialbatchList![j].qty,
              baseDocentry:
                  StockOutward[index].data[i].serialbatchList![j].baseDocentry,
              serialbatch:
                  StockOutward[index].data[i].serialbatchList![j].serialbatch,
              docstatus: "1",
              docentry: docentry2!.toString()));
        }
      }
      await DBOperation.insertStOutBatch(db, serialbatchList2);

      //log("step--------2");
      if (StockOutward[index].data[i].docentry != null) {
        await DBOperation.deletAlreadyHoldDataLine(
            //com
            db,
            int.parse(StockOutward[index].baceDocentry.toString()),
            int.parse(StockOutward[index].docentry.toString()),
            StockOutward[index].data[i].itemcode.toString());
      }

      StOutLine.add(StockOutLineDataDB(
        lineno: StockOutward[index].data[i].lineNo.toString(),
        docentry: docentry2.toString(),
        itemcode: StockOutward[index].data[i].itemcode.toString(),
        description: StockOutward[index].data[i].dscription,
        qty: int.parse(StockOutward[index].data[i].qty.toString()),
        baseDocentry: StockOutward[index].baceDocentry.toString(),
        baseDocline: StockOutward[index].data[i].lineNo.toString(),
        status: StockOutward[index].data[i].status,
        traansferQty: StockOutward[index].data[i].trans_Qty,
        scannedQty: StockOutward[index].data[i].Scanned_Qty,
        serialBatch: StockOutward[index].data[i].serialBatch.toString(),
        branch: AppConstant.branch,
        terminal: AppConstant.terminal,
      ));
    }

    await DBOperation.insertStOutLine(db, StOutLine);
    // log("Inside Hold Process");

    getHoldValues(db);
    // log("AlertDialogBox");
    await Get.defaultDialog(
      title: "Alert",
      middleText: "Saved as draft",
      backgroundColor: Colors.white,
      titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
      middleTextStyle: theme.textTheme.bodyLarge,
      radius: 5,
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
    ).then((value) {
      StOutController[50].clear();
      StockOutward.remove(datatotal);
      data!.clear();
      // StockOutward[index].data.clear();
    });

    notifyListeners();
  }

  SuspendDBInsert(
      String docstatus,
      BuildContext context,
      ThemeData theme,
      int index,
      List<StockOutwardDetails>? data,
      StockOutwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;
    List<StockOutHeaderDataDB> StOutHeader = [];
    List<StockOutLineDataDB> StOutLine = [];
    List<StockOutBatchDataDB> StOutBatch = [];
    // log("Save Data Process");

    StOutHeader.add(StockOutHeaderDataDB(
        branch: AppConstant.branch,
        // StockOutward[index].branch,//
        createdUserID: UserValues.userID,
        baseDocentry: StockOutward[index].baceDocentry,
        // StockOutward[index].createdUserID,//
        createdateTime: config.currentDate(),
        docstatus: "0",
        lastupdateIp: UserValues.lastUpdateIp,
        // StockOutward[index].lastupdateIp,//
        reqdocno: "0",
        // StockOutward[index].reqdocno,//
        docseries: "",
        //  StockOutward[index].reqdocseries,//
        docseriesno: 0,
        // StockOutward[index].reqdocseriesno,//
        doctime: config.currentDate(),
        reqfromWhs: StockOutward[index].reqfromWhs,
        systime: config.currentDate(),
        reqtoWhs: StockOutward[index].reqtoWhs, //
        transdate: config.currentDate(),
        salesexec: "",
        //  StockOutward[index].salesexec,//
        totalitems: 0,
        // StockOutward[index].totalitems,//
        totalltr: 0,
        //  StockOutward[index].totalltr,//
        totalqty: 0,
        //  StockOutward[index].totalqty,//
        updatedDatetime: config.currentDate(),
        //  StockOutward[index].updatedDatetime,//
        updateduserid: UserValues.userID,
        terminal: AppConstant.terminal,
        sapDocNo: null,
        sapDocentry: null,
        qStatus: 'N',
        sapStockReqdocentry: '',
        sapStockReqdocnum: '',
        remarks: ''
        //  StockOutward[index].updateduserid,//
        ));
    int? docentry2 = await DBOperation.insertStockOutheader(db, StOutHeader);
    // await DBOperation.deleteSuspendBatchStOut(
    //     db, int.parse(StockOutward[index].baceDocentry.toString()));
    // for (int i = 0; i < StockOutward[index].data.length; i++) {
    //   StOutLine.add(StockOutLineDataDB(
    //     lineno: (i + 1).toString(),
    //     docentry: docentry2.toString(),
    //     itemcode: StockOutward[index].data[i].itemcode.toString(),
    //     description: StockOutward[index].data[i].dscription,
    //     qty: int.parse(StockOutward[index].data[i].qty.toString()),
    //     baseDocentry: StockOutward[index].data[i].docentry.toString(),
    //     baseDocline: StockOutward[index].data[i].lineNo.toString(),
    //     status: StockOutward[index].data[i].status,
    //     traansferQty: StockOutward[index].data[i].trans_Qty,
    //     scannedQty: StockOutward[index].data[i].Scanned_Qty,
    //     serialBatch: StockOutward[index].data[i].serialBatch,
    //   ));

    // StOutBatch.add(StockOutBatchDataDB(
    //   lineno: StockOutward[index].data[i].lineNo.toString(),
    //   docentry: docentry2.toString(),
    //   itemcode: StockOutward[index].data[i].itemcode,
    //   qty: StockOutward[index].data[i].Scanned_Qty,
    //   serialbatch: StockOutward[index].data[i].serialBatch,
    //   // scannedQty: StockOutward[index].data[i].Scanned_Qty
    // ));
    // }
    for (int i = 0; i < StockOutward[index].data.length; i++) {
      StockOutward[index].data[i].Scanned_Qty = 0;
      // StockOutward[index].data[i].serialbatchList!=null;
      notifyListeners();
    }
    await Get.defaultDialog(
      title: "Alert",
      middleText: "This Sales Transaction Suspended Sucessfully..!!",
      backgroundColor: Colors.white,
      titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
      middleTextStyle: theme.textTheme.bodyLarge,
      radius: 5,
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
    ).then((value) {});

    notifyListeners();
  }

  int? totalqty(int? index) {
    int? totalqty = 0;
    for (int i = 0; i < StockOutward[index!].data.length; i++) {
      totalqty = totalqty! + StockOutward[index].data[i].qty!;
    }
    return totalqty;
  }

  int? totalValdationqty(int? index) {
    int? totalqty = 0;
    for (int i = 0; i < StockOutward[index!].data.length; i++) {
      totalqty = totalqty! + StockOutward[index].data[i].Scanned_Qty!;
    }
    return totalqty;
  }

  int? totalscannedqty(int? index) {
    int? totalscanqty = 0;
    for (int i = 0; i < StockOutward[index!].data.length; i++) {
      totalscanqty = totalscanqty! + StockOutward[index].data[i].Scanned_Qty!;
    }
    return totalscanqty;
  }

  String a = "";
  Future getHoldValues(Database db) async {
    List<Map<String, Object?>> getDBStOutHead =
        await DBOperation.getHoldStOutHeadDB(db); //com
    savedraftBill = [];
    List<StockOutwardDetails> Stout_Line = [];
    List<StockOutSerialbatch> Stout_Batch = [];
    for (int i = 0; i < getDBStOutHead.length; i++) {
      // log("get head doc:" + getDBStOutHead[i]["docentry"].toString());

      List<Map<String, Object?>> getDBStOutLine =
          await DBOperation.holdStOutLineDB2(
              //com
              db,
              int.parse(getDBStOutHead[i]["baseDocentry"].toString()),
              int.parse(getDBStOutHead[i]["docentry"].toString()));
      Stout_Line = [];
      for (int j = 0; j < getDBStOutLine.length; j++) {
// -----------------------
        List<Map<String, Object?>> getDBStOutBatch =
            await DBOperation.holdStOutBatchDB2(
                //com
                db,
                int.parse(getDBStOutLine[j]["baseDocentry"].toString()),
                int.parse(getDBStOutLine[j]["docentry"].toString()),
                getDBStOutLine[j]["itemcode"].toString());
        // if (getDBStOutHead[i]["docstatus"].toString() == "1") {
        // log("1---");
        if (int.parse(getDBStOutLine[j]["scannedQty"].toString()) != 0) {
          Stout_Batch = [];
          for (int k = 0; k < getDBStOutBatch.length; k++) {
            // log("2---");

            Stout_Batch.add(
              StockOutSerialbatch(
                lineno: getDBStOutBatch[k]["lineno"].toString(),
                baseDocentry: getDBStOutBatch[k]["baseDocentry"].toString(),
                itemcode: getDBStOutBatch[k]["itemcode"].toString(),
                qty: int.parse(getDBStOutBatch[k]["quantity"].toString()),
                serialbatch: getDBStOutBatch[k]["serialBatch"].toString(),
                docentry: getDBStOutBatch[k]["baseDocentry"].toString(),
                docstatus: "",
                // scannedQty:
                //     int.parse(getDBStOutBatch[k]["scannedQty"].toString()),
              ),
            );
          }
        } else {
          // log("3---");

          Stout_Batch = [];
        }
        // }
        //log("${int.parse(getDBStOutLine[j]["quantity"].toString())} ::${int.parse(getDBStOutLine[j]["transferQty"].toString())}");
        Stout_Line.add(StockOutwardDetails(
            lineNo: int.parse(getDBStOutLine[j]["lineno"].toString()),
            docentry: int.parse(getDBStOutLine[j]["docentry"].toString()),
            baseDocentry:
                int.parse(getDBStOutLine[j]["baseDocentry"].toString()),
            itemcode: getDBStOutLine[j]["itemcode"].toString(),
            dscription: getDBStOutLine[j]["description"].toString(),
            qty: int.parse(getDBStOutLine[j]["quantity"].toString()),
            status: getDBStOutLine[j]["status"].toString(),
            serialBatch: getDBStOutLine[j]["serialBatch"].toString(),
            createdUserID: 0,
            taxRate: 0.0,
            taxType: "",
            balQty: int.parse(getDBStOutLine[j]["quantity"].toString()) -
                int.parse(getDBStOutLine[j]["transferQty"].toString()),
            baseDocline: int.parse(getDBStOutLine[j]["baseDocline"].toString()),
            trans_Qty: int.parse(getDBStOutLine[j]["transferQty"].toString()),
            Scanned_Qty: int.parse(getDBStOutLine[j]["scannedQty"].toString()),
            createdateTime: "",
            updatedDatetime: "",
            updateduserid: 0,
            price: 0,
            lastupdateIp: "",
            serialbatchList: Stout_Batch));
      }

      savedraftBill.add(StockOutwardList(
        remarks: getDBStOutHead[i]["remarks"].toString(),
        docentry: getDBStOutHead[i]["docentry"].toString(),
        baceDocentry: getDBStOutHead[i]["baseDocentry"].toString(),
        branch: getDBStOutHead[i]["branch"].toString(),
        // createdUserID: int.parse(getDBStOutHead[i]["createdUserID"].toString()),
        // createdateTime: getDBStOutHead[i]["createdateTime"].toString(),
        docstatus: getDBStOutHead[i]["docstatus"].toString(),
        // lastupdateIp: getDBStOutHead[i]["lastupdateIp"].toString(),
        // reqdocno: int.parse(getDBStOutHead[i]["reqdocno"].toString()),
        // reqdocseries: getDBStOutHead[i]["docseries"].toString(),
        // reqdocseriesno: int.parse(getDBStOutHead[i]["docseriesno"].toString()),
        // reqdoctime: getDBStOutHead[i]["doctime"].toString(),
        reqfromWhs: getDBStOutHead[i]["reqfromWhs"].toString(),
        // reqsystime: getDBStOutHead[i]["systime"].toString(),
        reqtoWhs: getDBStOutHead[i]["reqtoWhs"].toString(),
        reqtransdate: getDBStOutHead[i]["transdate"].toString(),
        // salesexec: getDBStOutHead[i]["salesexec"].toString(),
        // totalitems: int.parse(getDBStOutHead[i]["totalitems"].toString()),
        // totalltr: double.parse(getDBStOutHead[i]["totalltr"].toString()),
        // totalqty: double.parse(getDBStOutHead[i]["totalqty"].toString()),
        // updatedDatetime: getDBStOutHead[i]["UpdatedDatetime"].toString(),
        // updateduserid: int.parse(
        //   getDBStOutHead[i]["updateduserid"].toString(),
        // ),
        // seresid: 0,
        // seriesnum: 0,
        // sysdatetime: "",
        // scanToatal: 0,
        // totalweight: 0,
        // transactiondate: "",
        // transtime: "",
        // transTotal: 0,
        // isagainstorder: "",
        // isagainststock: "",
        documentno: getDBStOutHead[i]["reqdocno"].toString(),
        data: Stout_Line, sapbaceDocentry: '',
      ));

      //savedraftBill[i].data.add(StockOutwardList(branch: StOut_Head.branch, createdUserID: StOut_Head.createdUserID, createdateTime: StOut_Head.createdateTime, docentry: StOut_Head.docentry, docstatus:StOut_Head. docstatus, documentno: StOut_Head.reqdocno, isagainstorder: StOut_Head.isagainstorder, isagainststock: isagainststock, lastupdateIp: StOut_Head.lastupdateIp, reqdocno: StOut_Head.reqdocno, reqdocseries: StOut_Head.reqdocseries, reqdocseriesno: StOut_Head.reqdocseriesno, reqdoctime: StOut_Head.reqdoctime, reqfromWhs: StOut_Head.reqfromWhs, reqsystime: StOut_Head.reqsystime, reqtoWhs: StOut_Head.reqtoWhs, reqtransdate: StOut_Head.reqtransdate, salesexec: StOut_Head.salesexec, seresid: StOut_Head.seresid, seriesnum: StOut_Head.seriesnum, sysdatetime: StOut_Head.sysdatetime, totalitems: StOut_Head.totalitems, totalltr: StOut_Head.totalltr, totalqty: StOut_Head.totalqty, totalweight: StOut_Head.totalweight, transactiondate: transactiondate, transtime: transtime, updatedDatetime: updatedDatetime, updateduserid: updateduserid, data: data))
    }
    // log("Stout_Batch::" + Stout_Batch.length.toString());
    //// log("Stout_Batch.qty::" + Stout_Batch[0].qty!.toString());
    // log("Stout_Line::" + Stout_Line.length.toString());
    // log("savedraftBill::" + savedraftBill.length.toString());

    //// log("DDRAFT::" + savedraftBill.length.toString());
  }

  valPass(int scanQty) {
    msg = "";
    // ScannigVal = scanQty;
    notifyListeners();
  }

  PageIndexvalue(int? index) {
    pageIndex = index!;
    notifyListeners();
  }

  passINDEX(int? index) {
    i_value = index!;
    notifyListeners();
  }

  int? listI = 0;
  int? batch_i = 0;

  StockOutwardDetails? batch_datalist;
  passindexBachPage(
    int? index,
    int i,
    StockOutwardDetails? datalist,
  ) {
    // print("test222::"+datalist!.serialbatchList!.length.toString());
    // listI = 0;
    // print("datalist datalist::" + datalist!.serialbatchList!.length.toString());
    listI = index!;
    batch_i = i;
    // selectedBaceDocentry = baceDocentry;
    batch_datalist = datalist;
    StockOutward[index].data[i] = datalist!;
    // for (int ind = 0; ind < StockOutward.length; ind++) {
    //   for (int ij = 0; ij < StockOutward[ind].data.length; ij++) {
    if (StockOutward[index].data[i].serialbatchList != null) {
      //log("StockOutward[ind].data[ij].serialbatchList::${StockOutward[index].data[i].serialbatchList!.length}");
      for (int ik = 0;
          ik < StockOutward[index].data[i].serialbatchList!.length;
          ik++) {
        qtymycontroller[ik].text =
            StockOutward[index].data[i].serialbatchList![ik].qty.toString();
      }
      notifyListeners();

      // }
    }
    notifyListeners();
  }

  Future<bool> onbackpress() async {
    DateTime now = DateTime.now();
    if (pageIndex == 1) {
      print("object");

      // page.animateToPage(--pageIndex,
      //     duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    } else if (pageIndex == 2) {
      // log("object");
      // stoutLineRefersh(listI!, batch_i!);
      // getBatchData(int index, int list_i);
      // await stoutLineRefersh(listI!);
      notifyListeners();
      // page.animateToPage(--pageIndex,
      //     duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    }
    return Future.value(false);
  }

  // Future<bool> onbackpress2() async {
  //   DateTime now = DateTime.now();
  //   if (tappageIndex == 1) {
  //     print("object");

  //     tappage.animateToPage(--tappageIndex,
  //         duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
  //   } else if (tappageIndex == 2) {
  //    // log("object");
  //     tappage.animateToPage(--tappageIndex,
  //         duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
  //   }
  //   return Future.value(false);
  // }
  Future<bool> onbackpress2() async {
    // print("stockoutwardddddd $tappageIndex ");
    DateTime now = DateTime.now();
    // if (tappageIndex == 1) {
    //   print("object");

    //   tappage.animateToPage(--tappageIndex,
    //       duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    // } else if (tappageIndex == 2) {
    //   // log("object");
    //   tappage.animateToPage(--tappageIndex,
    //       duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    // } else if (tappageIndex == 0) {
    //   return Future.value(true);
    // }
    return Future.value(false);
  }

  List<StockOutwardDetails>? passdata = [];
  passList(List<StockOutwardDetails>? data) {
    passdata = data!;
    // getBatchData(index, list_i);
    // for (int i = 0; i < data.length; i++) {
    //   for (int j = 0; j < data[i].serialbatchList!.length; j++) {
    //     data[i].Scanned_Qty = data[i].serialbatchList![j].qty;
    //   }
    // }
    notifyListeners();
  }

  List<StockOutwardList> StockOutward = [];

  clearmsg() {
    msg = "";
    // ScannigVal = 0;
    notifyListeners();
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    // page.previousPage(
    //   duration: Duration(milliseconds: 200),
    //   curve: Curves.linear,
    // );
    return Future.value(false);
  }

  mapvalue(List<StockOutwardList> StockOut, int index) async {
    StockOutward2.clear();
    StOutController2[50].text = "";
    if (isselect == true) {
      isselect = false;
    }
    List<StockOutwardDetails> stoutDetails = [];
    List<StockOutwardList> stoutList = [];
    final Database db = (await DBHelper.getInstance())!;
    for (int j = 0; j < StockOut[index].data.length; j++) {
      List<StockOutSerialbatch> stoutSeralBatchList = [];
      print("Stockline Length in hold:::" +
          StockOut[index].data[j].serialbatchList!.length.toString());

      for (int k = 0;
          k < StockOut[index].data[j].serialbatchList!.length;
          k++) {
        stoutSeralBatchList.add(StockOutSerialbatch(
          lineno: StockOut[index].data[j].lineNo.toString(),
          baseDocentry: StockOut[index].data[j].baseDocentry.toString(),
          itemcode: StockOut[index].data[j].itemcode.toString(),
          qty: StockOut[index].data[j].serialbatchList![k].qty,
          // scannedQty: StockOut[index].data[j].Scanned_Qty,
          serialbatch: StockOut[index]
              .data[j]
              .serialbatchList![k]
              .serialbatch
              .toString(),
        ));
        // }
      }
      //log("stoutSeralBatchList::${stoutSeralBatchList.length}");
      stoutDetails.add(StockOutwardDetails(
          createdUserID: StockOut[index].data[j].createdUserID,
          createdateTime: StockOut[index].data[j].createdateTime,
          baseDocentry: StockOut[index].data[j].baseDocentry,
          docentry: StockOut[index].data[j].docentry,
          dscription: StockOut[index].data[j].dscription,
          itemcode: StockOut[index].data[j].itemcode,
          lastupdateIp: StockOut[index].data[j].lastupdateIp,
          lineNo: StockOut[index].data[j].lineNo,
          qty: StockOut[index].data[j].qty,
          status: StockOut[index].data[j].status,
          updatedDatetime: StockOut[index].data[j].updatedDatetime,
          updateduserid: StockOut[index].data[j].updateduserid,
          price: StockOut[index].data[j].price,
          serialBatch: StockOut[index].data[j].serialBatch,
          taxRate: StockOut[index].data[j].taxRate,
          taxType: StockOut[index].data[j].taxType,
          trans_Qty: StockOut[index].data[j].trans_Qty,
          Scanned_Qty: StockOut[index].data[j].Scanned_Qty,
          balQty:
              StockOut[index].data[j].qty! - StockOut[index].data[j].trans_Qty!,
          baseDocline: StockOut[index].data[j].baseDocline,
          serialbatchList: stoutSeralBatchList));
      //log("stoutDetails::${stoutDetails[0].serialbatchList!.length}");
    }
    StOutController[50].text = StockOut[index].remarks.toString();
    stoutList.add(StockOutwardList(
      data: stoutDetails,
      branch: StockOut[index].branch,
      remarks: StockOut[index].remarks.toString(),
      // createdUserID: StockOut[index].createdUserID,
      // createdateTime: StockOut[index].createdateTime,
      docentry: StockOut[index].docentry,
      baceDocentry: StockOut[index].baceDocentry,
      docstatus: StockOut[index].docstatus,
      documentno: StockOut[index].documentno,
      reqfromWhs: StockOut[index].reqfromWhs,
      reqtoWhs: StockOut[index].reqtoWhs,
      reqtransdate: StockOut[index].reqtransdate,
      sapbaceDocentry: StockOut[index].sapbaceDocentry,
      // reqsystime: StockOut[index].reqsystime,

      // isagainstorder: StockOut[index].isagainstorder,
      // isagainststock: StockOut[index].isagainststock,
      // lastupdateIp: StockOut[index].lastupdateIp,
      // reqdocno: StockOut[index].reqdocno,
      // reqdocseries: StockOut[index].reqdocseries,
      // reqdocseriesno: StockOut[index].reqdocseriesno,
      // reqdoctime: StockOut[index].reqdoctime,

      // salesexec: StockOut[index].salesexec,
      // seresid: StockOut[index].seresid,
      // seriesnum: StockOut[index].seriesnum,
      // sysdatetime: StockOut[index].sysdatetime,
      // totalitems: StockOut[index].totalitems,
      // totalltr: StockOut[index].totalltr,
      // totalqty: StockOut[index].totalqty,
      // totalweight: StockOut[index].totalweight,
      // transactiondate: StockOut[index].transactiondate,
      // transtime: StockOut[index].transtime,
      // updatedDatetime: StockOut[index].updatedDatetime,
      // updateduserid: StockOut[index].updateduserid,
    ));

    int? count = await dupilicateHoldDataCheck(stoutList);

    if (count != null) {
      //log("StockOutward Length::" + StockOutward.length.toString());
      //log("StockOut Length::" + StockOut.length.toString());

      //log("Remove I::" + count.toString());

      StockOutward.removeAt(count);
      StockOutward.addAll(stoutList);
      //log("XXX::${StockOutward[index].data.length}");

      // await DBOperation.UpdateSTOUT_HeaderDocstatus(
      //     db, int.parse(StockOut[index].baceDocentry.toString()));
    } else {
      //log("message");
      //log("Remove I::" + count.toString());

      StockOutward.addAll(stoutList);
      // log("StockOutward[ind].data[ij].serialbatchList::${StockOutward[1].data[0].serialbatchList!.length}");

      // await DBOperation.UpdateSTOUT_HeaderDocstatus(
      //     db, int.parse(StockOut[index].baceDocentry.toString()));
    }

    log(StockOutward.length.toString());
    passdata = StockOutward[StockOutward.length - 1].data;
    i_value = StockOutward.length - 1;
    selectIndex = StockOutward.length - 1;

    notifyListeners();
  }

  Future<int?> dupilicateHoldDataCheck(List<StockOutwardList> stoutList) {
    for (int i = 0; i < StockOutward.length; i++) {
      if (StockOutward[i].baceDocentry == stoutList[0].baceDocentry) {
        //log("Basedocentry::" + StockOutward[i].baceDocentry.toString());
        //log("i-----------------::" + i.toString());

        return Future.value(i);
      }
    }
    return Future.value(null);
  }

  dupilicateDRAFTDataCheck(StockOutwardList stoutList) {
    for (int i = 0; i < savedraftBill.length; i++) {
      if (savedraftBill[i].baceDocentry == stoutList.baceDocentry) {
        return i;
      }
    }
  }

  int balQtity = 0;
  getStockReqData() async {
    log("step1");
    StockOutward = [];
    List<StockOutwardList> StockOutDATA = [];
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getStockReqValues =
        await DBOperation.getStockReq(db); //com
    print("loop111===${getStockReqValues.length}");

    if (getStockReqValues.isNotEmpty) {
      for (int i = 0; i < getStockReqValues.length; i++) {
        //log("reqtoWhs::" + getStockReqValues[i]["reqtoWhs"].toString());
        if (getStockReqValues[i]["reqtoWhs"].toString() == AppConstant.branch) {
          StockOutDATA = [];

          print(
              "getStockReqValues reqtoWhs::${getStockReqValues[i]["reqtoWhs"].toString()}");

          dbDataTrue = false;

          List<Map<String, Object?>> getStockReqLineData =
              await DBOperation.getTrasferQty(
                  //com
                  db,
                  int.parse(getStockReqValues[i]["docentry"].toString()));
          print("stock docE::" + getStockReqValues.toString());
          List<StockOutwardDetails> stockDetails = [];
          for (int j = 0; j < getStockReqLineData.length; j++) {
            if (getStockReqValues[i]["reqfromWhs"].toString() ==
                getStockReqLineData[j]["branch"].toString()) {
              print("loop 1");
              stockDetails.add(StockOutwardDetails(
                  baseDocentry:
                      int.parse(getStockReqLineData[j]["docentry"].toString()),
                  baseDocline:
                      int.parse(getStockReqLineData[j]["lineNo"].toString()),
                  createdUserID: int.parse(
                      getStockReqLineData[j]["createdUserID"].toString()),
                  createdateTime:
                      getStockReqLineData[j]["createdateTime"].toString(),
                  dscription: "",
                  itemcode: getStockReqLineData[j]["itemcode"].toString(),
                  lastupdateIp:
                      getStockReqLineData[j]["lastupdateIp"].toString(),
                  lineNo:
                      int.parse(getStockReqLineData[j]["lineNo"].toString()),
                  qty: int.parse(getStockReqLineData[j]["quantity"].toString()),
                  status: "",
                  updatedDatetime:
                      getStockReqLineData[j]["UpdatedDatetime"].toString(),
                  updateduserid: int.parse(
                      getStockReqLineData[j]["createdUserID"].toString()),
                  price:
                      double.parse(getStockReqLineData[j]["price"].toString()),
                  serialBatch: getStockReqLineData[j]["serialBatch"].toString(),
                  taxRate: 0.0,
                  balQty:
                      int.parse(getStockReqLineData[j]["balqty"].toString()),
                  Scanned_Qty:
                      int.parse(getStockReqLineData[j]["scanndQty"].toString()),
                  trans_Qty: int.parse(
                          getStockReqLineData[j]["quantity"].toString()) -
                      int.parse(getStockReqLineData[j]["balqty"].toString()),
                  taxType: ""));
            }
          }
          print(
            " getStockReqValues reqfromWhs ::" +
                getStockReqValues[i]["reqfromWhs"].toString(),
          );
          StockOutward.add(StockOutwardList(
              remarks: "",
              branch: getStockReqValues[i]["branch"].toString(),
              baceDocentry: getStockReqValues[i]["docentry"].toString(),
              docstatus: getStockReqValues[i]["docstatus"].toString(),
              documentno: getStockReqValues[i]["documentno"].toString(),
              reqfromWhs: getStockReqValues[i]["reqfromWhs"].toString(),
              reqtoWhs: getStockReqValues[i]["reqtoWhs"].toString(),
              reqtransdate: getStockReqValues[i]["reqtransdate"].toString(),
              data: stockDetails,
              sapbaceDocentry: getStockReqValues[i]['sapDocentry'].toString()));
          RequestedWarehouse = getStockReqValues[i]["reqfromWhs"].toString();
          //log('StockOutward length::' + StockOutward.length.toString());
        } else {
          dbDataTrue = true;
          notifyListeners();
        }
      }

      notifyListeners();
    } else {
      dbDataTrue = true;
      notifyListeners();
    }
    // StockOutward.addAll(StockOutDATA);
    print("object::==" + StockOutward.length.toString());
    notifyListeners();
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }

  clickcancelbtn(BuildContext context, ThemeData theme) async {
    if (sapDocentry == null) {
      await sapLoginApi(context);
      await callSerlaySalesQuoAPI(context, theme);

      if (sapstkoutwarddata.isNotEmpty) {
        for (int i = 0; i < sapstkoutwarddata.length; i++) {
          // if (sapstkoutwarddata[i].lineStatus == "bost_Open") {
          await callSerlaySalesCancelQuoAPI(context, theme);
          notifyListeners();
          // }
        }
      }
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
        StockOutward.clear();
        StockOutward2.clear();
        StOutController2[50].text = "";
        getStockReqData();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  sapLoginApi(BuildContext context) async {
    final pref2 = await pref;

    await PostOutwardLoginAPi.getGlobalData().then((value) async {
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
    log("  AppConstant.sapSessionID::${AppConstant.sapSessionID}");
  }

  callSerlaySalesQuoAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    // List<Map<String, Object?>> getqstatusdata =
    //     await DBOperation.getSaleQuorQstatusDB(db);

    log("sapDocentrysapDocentrysapDocentry:::$sapDocentry");

    await SerlaySalesOutwardAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.stockTransferLines.isNotEmpty) {
          sapstkoutwarddata = value.stockTransferLines;

          //log("sapInvocieModelDatasapInvocieModelData::${sapstkoutwarddata[0].lineStatus}");

          custserieserrormsg = '';
        } else {
          //log("Error11");

          // custserieserrormsg = value.message!.toString();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        //log("Error22");
        custserieserrormsg = value.error!.message!.value.toString();
        //log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
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
                      content: custserieserrormsg.toString(),
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          sapDocentry = '';
          sapDocuNumber = '';
          StockOutward.clear();
          StockOutward2.clear();
          StOutController2[50].text = "";
          getStockReqData();
          notifyListeners();
        });
      } else {
        //log("Error33");

        // custserieserrormsg = value.message!.toString();
      }
    });
  }

  ErrorModel? errorModel = ErrorModel();
  callSerlaySalesCancelQuoAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    if (sapstkoutwarddata.isNotEmpty) {
      for (int ij = 0; ij < sapstkoutwarddata.length; ij++) {
        if (sapstkoutwarddata[ij].lineStatus == "bost_Open") {
          await SerlayvOutwardCancelAPI.getData(sapDocentry.toString())
              .then((value) async {
            if (value.statusCode! >= 200 && value.statusCode! <= 204) {
              cancelbtn = false;
              //log("sapstkoutwarddatasapstkoutwarddata::${sapstkoutwarddata[0].lineStatus}");

              await DBOperation.updateSalesQuoclosedocsts(
                  db, sapDocentry.toString());

              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        contentPadding: EdgeInsets.all(0),
                        content: AlertBox(
                          payMent: 'Success',
                          errormsg: true,
                          widget: Center(
                              child: ContentContainer(
                            content: 'Document is successfully cancelled ..!!',
                            theme: theme,
                          )),
                          buttonName: null,
                        ));
                  }).then((value) {
                sapDocentry = '';
                sapDocuNumber = '';
                StockOutward.clear();
                StockOutward2.clear();
                StOutController2[50].text = "";
                getStockReqData();
                notifyListeners();
              });

              custserieserrormsg = '';
            } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
              cancelbtn = false;
              //log("Error22");
              custserieserrormsg = errorModel!.message!.value.toString();
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
                StockOutward.clear();
                StockOutward2.clear();
                StOutController2[50].text = "";
                getStockReqData();
                notifyListeners();
              });
              //log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
            } else {
              //log("Error33");
            }
          });
        } else if (sapstkoutwarddata[ij].lineStatus == "bost_Close") {
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
            StockOutward.clear();
            StockOutward2.clear();
            StOutController2[50].text = "";
            getStockReqData();
            notifyListeners();
          });
          notifyListeners();
        }
      }
    }
  }

  PostRabitMq(int docentry, int baseDocentry, String toWhs) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDB_StoutHeader =
        await DBOperation.getStockOutHeader(db, docentry); //com
    List<Map<String, Object?>> getDB_StoutLine =
        await DBOperation.holdStOutLineDB(
            db, docentry, baseDocentry.toString()); //com
    List<Map<String, Object?>> getDB_StOutBatch =
        await DBOperation.getStockOutBatch(
            db, docentry, baseDocentry.toString()); //com
    String stOutHeader = json.encode(getDB_StoutHeader);
    String stOutLine = json.encode(getDB_StoutLine);
    String stOutBatch = json.encode(getDB_StOutBatch);

    var ddd = json.encode({
      "ObjectType": 5,
      "ActionType": "Add",
      "StockOutwardHeader": stOutHeader,
      "StockOutwardLine": stOutLine,
      "StockOutwardBatch": stOutBatch,
    });
    log("payload : $ddd");

    //RabitMQ
    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        //AppConstant.ip
        port: 5672,
        authProvider: PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();
//from
    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    // properties.headers = {"Branch": AppConstant.branch};
    // exchange.publish(ddd, "", properties: properties);

    //cs

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);

    //to
    // properties.headers = {"Branch": toWhs};
    // exchange.publish(ddd, "", properties: properties);

    client1.close();
  }

  PostRabitMq2(int docentry, String baseDocentry, String toWhs) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDB_StoutHeader =
        await DBOperation.getStockOutHeader(db, docentry); //com
    List<Map<String, Object?>> getDB_StoutLine =
        await DBOperation.holdStOutLineDB(
            db, docentry, baseDocentry.toString()); //com
    List<Map<String, Object?>> getDB_StOutBatch =
        await DBOperation.getStockOutBatch(db, docentry, baseDocentry); //com
    String stOutHeader = json.encode(getDB_StoutHeader);
    String stOutLine = json.encode(getDB_StoutLine);
    String stOutBatch = json.encode(getDB_StOutBatch);
    log("stOutLinevstOutLine::$stOutLine");
    var ddd = json.encode({
      "ObjectType": 5,
      "ActionType": "Add",
      "StockOutwardHeader": stOutHeader,
      "StockOutwardLine": stOutLine,
      "StockOutwardBatch": stOutBatch,
    });
    log("payload : $ddd");

    //RabitMQ
    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        //AppConstant.ip
        port: 5672,
        authProvider: PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();
//from
    properties.headers = {"Branch": AppConstant.branch};
    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    exchange.publish(ddd, "", properties: properties);

    //cs

    // properties.headers = {"Branch": "Server"};
    // exchange.publish(ddd, "", properties: properties);

    //to
    properties.headers = {"Branch": toWhs};
    exchange.publish(ddd, "", properties: properties);

    client1.close();
  }
}
