// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Models/ExpenseDialogModel/Expensedialog.dart';
import 'package:posproject/Models/ExpenseModel/paidfrom.dart';
import 'package:posproject/Service/ExpenseApi.dart';
import 'package:posproject/Service/PettyCashApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/ExpenseDBModel.dart';
import '../../Models/ExpenseModel/ExpenseGetModel.dart';
import '../../Models/ExpenseModel/expensecode.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/ServiceLayerModel/SapExpensModel/ExpePostingList.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/PostringExpAPI.dart';
import '../../Widgets/AlertBox.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/ExpenseCancelAPI.dart';
import '../../ServiceLayerAPIss/ExpensesAPI/ExpenseLoginnAPI.dart';
import '../../Widgets/ContentContainer.dart';

class ExpenseController extends ChangeNotifier {
  Configure config = Configure();

  void init() {
    clearData();
    getcodeExpense();
    getpaidfomExpense();
    getdraftindex();
    callExpenseApi();
    callPettyCashApi();
    notifyListeners();
    expenseModel = [];
  }

  List<searchModel> filtersearchData = [];
  bool OndDisablebutton = false;
  bool cancelbtn = false;
  String? codeValue;
  String? displayExpanseValue;
  String? custserieserrormsg = '';
  bool loadingscrn = false;

  String? chosenValue;
  final List<GlobalKey<FormState>> formkey =
      List.generate(2, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  List<codeforexpense> expCode = [];
  List finalcode = [];
  String holddocentry = '';
  List<PaidFrom> paidFromData = [];
  List<EpenseDataModel> expenseModel = [];
  String? sapDocentry = '';
  String? sapDocuNumber = '';
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  callExpenseApi() async {
    ExpanseMasterApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.addressdata != null) {
          expenseModel = value.addressdata!;
          notifyListeners();
        } else {
          Get.defaultDialog(title: 'Alert', middleText: 'No Expense Data..!!')
              .then((value) {
            Get.back();
          });
        }
      } else {
        Get.defaultDialog(
                title: 'Alert',
                middleText: 'Something went wrong try again..!!')
            .then((value) {
          Get.back();
        });
      }
    });
  }

  String? pettyCashAmt;
  callPettyCashApi() async {
    PettyCashModelAPI.getData(AppConstant.branch).then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.pettyCashList != null) {
          pettyCashAmt = value.pettyCashList![0].currTotal!;
          //log("message pettyCashAmt:::${value.pettyCashList![0].currTotal!}");
          notifyListeners();
        } else {
          Get.defaultDialog(title: 'Alert', middleText: 'No Data..!!')
              .then((value) {
            Get.back();
          });
        }
      } else {
        Get.defaultDialog(
                title: 'Alert',
                middleText: 'Something went wrong try again..!!')
            .then((value) {
          Get.back();
        });
      }
    });
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  pettyCashValidation() {
    int expval = int.parse(mycontroller[1].text.toString());
    log("pettyCashAmtpettyCashAmt:::${pettyCashAmt}");
    if (chosenValue == "Petty Cash") {
      if (expval <= double.parse(pettyCashAmt.toString())) {
        mycontroller[1].text = expval.toString();
        notifyListeners();
      } else {
        Get.defaultDialog(
                title: 'Alert',
                middleText: 'Please enter the correct amount..!!')
            .then((value) {});
        mycontroller[1].text = '';
      }
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
  bool searchbool = false;
// bool searchError=false;
  List<searchModel> searchData = [];

  getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getExpenseDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));
    // List<Map<String, Object?>> getSalesLine =
    //     await DBOperation.getSalesLineDateWise(
    //         db, config.alignDate2(fromdate), config.alignDate2(todate));
    // List<Map<String, Object?>> getSalesPay =
    //     await DBOperation.getSalesPayDateWise(
    //         db, config.alignDate1(fromdate), config.alignDate1(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();
    filtersearchData.clear();
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
          customeraName: "",
          doctotal: getSalesHeader[i]["rcamount"] == null
              ? 0
              : double.parse(getSalesHeader[i]["rcamount"].toString())));
    }
    searchData.addAll(searchdata2);
    filtersearchData = searchData;
    // log("header::" + getSalesHeader.toString());
    //// log("Line::" + getSalesLine.toString());
    //// log("Pay::" + getSalesPay.toString());
    searchbool = false;
    notifyListeners();
  }

  bool expBool = false;
  bool PaidfromBool = false;

  String? shipaddress = "";
  fixDataMethod(int docentry) async {
    sapDocentry = '';
    sapDocuNumber = '';
    mycontroller[9].text = "";
    mycontroller[10].text = "";
    mycontroller[11].text = "";
    mycontroller[12].text = "";
    mycontroller[13].text = "";
    mycontroller[14].text = "";

    //background service
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBExpensesHeader =
        await DBOperation.getExpensHeaderData(db, docentry);
    if (getDBExpensesHeader.isNotEmpty) {
      sapDocentry = getDBExpensesHeader[0]["sapDocentry"] != null
          ? getDBExpensesHeader[0]["sapDocentry"].toString()
          : "";
      sapDocuNumber = getDBExpensesHeader[0]["sapDocNo"] != null
          ? getDBExpensesHeader[0]["sapDocNo"].toString()
          : '';
      expBool = true;
      //log("message------------------------" +
      // getDBExpensesHeader[0]["sapDocentry"].toString());
      mycontroller[9].text = getDBExpensesHeader[0]["expencecode"].toString();
      mycontroller[10].text = getDBExpensesHeader[0]["reference"].toString();
      mycontroller[11].text = getDBExpensesHeader[0]["rcamount"].toString();
      mycontroller[12].text = getDBExpensesHeader[0]["paidto"].toString();
      mycontroller[13].text = getDBExpensesHeader[0]["paidfrom"].toString();
      mycontroller[14].text = getDBExpensesHeader[0]["remarks"].toString();
      //log('  mycontroller[9].text::' + mycontroller[9].text.toString());

      notifyListeners();
    } else {
      expBool = false;
      notifyListeners();
    }

    notifyListeners();
  }

  clearData() {
    //formkey = List.generate(2, (i) => GlobalKey<FormState>());
    mycontroller = List.generate(150, (i) => TextEditingController());
    mycontroller[9].text = "";
    displayExpanseValue = null;
    sapDocentry = '';
    sapDocuNumber = '';
    mycontroller[10].text = "";
    mycontroller[11].text = "";
    mycontroller[12].text = "";
    mycontroller[13].text = "";
    mycontroller[14].text = "";
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    codeValue = null;
    chosenValue = null;
    codeValue = null;
    expBool = false;
    expCode = [];
    finalcode = [];
    paidFromData = [];
    cancelbtn = false;
    OndDisablebutton = false;
    itemsDocDetails = [];
    notifyListeners();
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

    // log("datattata doc : " + data.substring(8));
    return listdata; // int.parse(data.substring(8));
  }

  saveValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    if (formkey[0].currentState!.validate()) {
      if (docstatus.toLowerCase() == "hold") {
        if (holddocentry.isNotEmpty) {
          await DBOperation.deleteExpenseHold(db, holddocentry.toString())
              .then((value) {
            onholdfilter = [];
            holddocentry = '';
            onhold.clear();
          });
        }
        insertExpenseTable(docstatus, context, theme);
      } else if (docstatus.toLowerCase() == "submit") {
        if (holddocentry.isNotEmpty) {
          await DBOperation.deleteExpenseHold(db, holddocentry.toString())
              .then((value) {
            onholdfilter = [];
            holddocentry = '';
            onhold.clear();
          });
        }
        insertExpenseTable(docstatus, context, theme);
      }
      notifyListeners();
    } else {
      OndDisablebutton = false;
      notifyListeners();
    }
  }

  insertExpenseTable(
      String docstatus, BuildContext context, ThemeData theme) async {
    OndDisablebutton = true;
    notifyListeners();

    final Database db = (await DBHelper.getInstance())!;
    List<ExpenseDBModel> values = [];
    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "Expense");
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
          await DBOperation.generateDocentr(db, "docentry", "Expense");
    }

    // docnumber generatiom

    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 8);

    List<String> getseriesvalue = await checkingdoc(8);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    documentNum = finlDocnum + documentN0.toString();
    // docnumber generatiom
    values.add(ExpenseDBModel(
        lineid: "",
        docentry: docEntryCreated.toString(),
        doctype: "Expense",
        rcmode: "Cash",
        branch: UserValues.branch,
        createdateTime: config.currentDate(),
        expensecode: codeValue,
        terminal: UserValues.terminal,
        documentno: documentNum.toString(),
        reference: mycontroller[0].text,
        rcamount: mycontroller[1].text,
        paidto: mycontroller[2].text,
        paidfrom: chosenValue,
        docstatus: docstatus == "hold"
            ? "1"
            : docstatus == "submit"
                ? "2"
                : "null",
        qStatus: "No",
        sapDocNo: null,
        sapDocentry: null,
        remarks: mycontroller[3].text.toString()));
    // getdraft(ji);

    int? docentry2 = await DBOperation.insertExpense(db, values);
    await DBOperation.updatenextno(db, 8, nextno);

    if (docstatus == "hold") {
      chosenValue = null;
      displayExpanseValue = null;

      getdraftindex();
      mycontroller[0].text = "";
      mycontroller[1].text = "";
      mycontroller[2].text = "";
      mycontroller[3].text = '';
      codeValue = null;
      OndDisablebutton = true;
      chosenValue = null;
      displayExpanseValue = null;
      await Get.defaultDialog(
              title: "Success",
              middleText: docstatus == "hold" ? "Saved as draft" : "null",
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
        OndDisablebutton = false;
        displayExpanseValue = null;
        notifyListeners();
      });
      notifyListeners();
    } else if (docstatus == "submit") {
      bool? netbool = await config.haveInterNet();

      // log("config.haveInterNet():::" + netbool.toString());
      if (netbool == true) {
        await callExpPostApi(context, theme, docentry2!, docstatus);
        // await PostRabitMqExpense(docentry2!);
      }
    }
    // mycontroller[0].text = "";
    // mycontroller[1].text = "";
    // mycontroller[2].text = "";
    // mycontroller[3].text = '';
    // codeValue = null;
    // OndDisablebutton = true;
    // chosenValue = null;
    // displayExpanseValue = null;
    // await Get.defaultDialog(
    //         title: "Success",
    //         middleText: docstatus == "submit"
    //             ? 'Successfully Done'
    //             : docstatus == "hold"
    //                 ? "Saved as draft"
    //                   : "null",
    //         backgroundColor: Colors.white,
    //         titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
    //         middleTextStyle: theme.textTheme.bodyLarge,
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
    //   if (docstatus == "submit") {
    //     Get.offAllNamed(ConstantRoutes.dashboard);
    //   }
    //   OndDisablebutton = false;
    //   displayExpanseValue = null;
    //   notifyListeners();
    // });

    notifyListeners();

    OndDisablebutton = false;
    notifyListeners();
  }

  callExpPostApi(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
  ) async {
    await sapLoginApi(context);
    await postingExp(context, theme, docEntry, docstatus);
    notifyListeners();
  }

  List<ExpenseListMoel> itemsDocDetails = [];
  addAccLine() {
    itemsDocDetails = [];
    itemsDocDetails.add(ExpenseListMoel(
        accountCode: codeValue.toString(),
        decription: mycontroller[3].text.toString(),
        grossAmount: double.parse(mycontroller[1].text),
        sumPaid: double.parse(mycontroller[1].text.toString())));
    notifyListeners();
  }

  postingExp(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    addAccLine();
    PostExpenseAPi.CashAccount = "_SYS00000000117";
    PostExpenseAPi.docDate = config.currentDate();
    PostExpenseAPi.DocType = "rAccount";
    PostExpenseAPi.CashSum = mycontroller[1].text;
    PostExpenseAPi.Remarks = mycontroller[3].text.toString();
    PostExpenseAPi.paymentAccounts = itemsDocDetails;
    var uuid = Uuid();
    String? uuidg = uuid.v1();
    // PostExpenseAPi.method(uuidg);
    await PostExpenseAPi.getGlobalData(uuidg).then((value) async {
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
              int.parse(sapDocuNumber!), docEntry, 'Expense');
          await PostRabitMqExpense2(int.parse(docEntry.toString()));

          mycontroller = List.generate(150, (i) => TextEditingController());

          OndDisablebutton = false;

          notifyListeners();
          mycontroller[0].text = "";
          mycontroller[1].text = "";
          mycontroller[2].text = "";
          mycontroller[3].text = '';
          codeValue = null;
          OndDisablebutton = true;
          chosenValue = null;
          displayExpanseValue = null;
          await Get.defaultDialog(
                  title: "Success",
                  middleText: docstatus == "submit"
                      ? 'Successfully Done ,Document Number is $sapDocuNumber'
                      : "null",
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
            if (docstatus == "submit") {
              Get.offAllNamed(ConstantRoutes.dashboard);
            }
            OndDisablebutton = false;
            displayExpanseValue = null;
            itemsDocDetails = [];
            notifyListeners();
          });

          custserieserrormsg = '';
        } else {
          //log("Error11");

          custserieserrormsg = value.error!.message.toString();
          mycontroller = List.generate(150, (i) => TextEditingController());

          OndDisablebutton = false;
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
          OndDisablebutton = false;
        });
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
                      content: 'Something wwent Wrong..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          mycontroller = List.generate(150, (i) => TextEditingController());
        });
      }
      OndDisablebutton = false;
    });
    OndDisablebutton = false;

    notifyListeners();
  }

  clearSuspendedData(BuildContext context, ThemeData theme) {
    displayExpanseValue = null;
    codeValue = null;
    OndDisablebutton = false;
    codeValue = null;
    mycontroller[0].text = "";
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = '';
    codeValue = null;
    OndDisablebutton = false;
    chosenValue = null;
    notifyListeners();
    Get.defaultDialog(
            title: "Success",
            middleText: "Successfully Suspended ..!!",
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
      codeValue = null;
      mycontroller[0].text = "";
      mycontroller[1].text = "";
      mycontroller[2].text = "";
      mycontroller[3].text = '';
      codeValue = null;
      OndDisablebutton = false;
      chosenValue = null;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> PostRabitMqExpense(int docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBExpensesHeader =
        await DBOperation.getExpensHeaderData(db, docentry);
    String BExpensesHeader = json.encode(getDBExpensesHeader);

    var ddd = json.encode({
      "ObjectType": 8,
      "ActionType": "Add",
      "ExpensesHeader": BExpensesHeader,
    });
//log("payload : $ddd");

    //RabitMQ
    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        //  AppConstant.ip,
        //"102.69.167.106"
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    // properties.headers = {"Branch": UserValues.branch};
    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    // exchange.publish(ddd, "", properties: properties);

    //cs

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  Future<void> PostRabitMqExpense2(int docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBExpensesHeader =
        await DBOperation.getExpensHeaderData(db, docentry);
    String BExpensesHeader = json.encode(getDBExpensesHeader);

    var ddd = json.encode({
      "ObjectType": 8,
      "ActionType": "Add",
      "ExpensesHeader": BExpensesHeader,
    });
//log("payload : $ddd");

    //RabitMQ
    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        //  AppConstant.ip,
        //"102.69.167.106"
        port: 5672,
        authProvider: PlainAuthenticator("buson", "BusOn123"));
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

  Future getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getExpenseDB(db);
    onholdfilter = [];
    onhold = [];
    for (int i = 0; i < getDBholddata5.length; i++) {
      print("AAAnbu");
      // log("getDBholddata5 doc entry:${getDBholddata5[i]['docentry']}");
      getdraft(i);
    }
    notifyListeners();
  }

  List<Expensedummy> onhold = [];
  List<Expensedummy> onholdfilter = [];
  List<Expensedummy> expenceval2 = [];

  getdraft(int i) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getExpenseDB(db);
    onholdfilter = [];
    // onhold = [];
    //   for (int i = 0; i < getDBholddata5.length; i++){
    Expensedummy expenceval = Expensedummy(
      expensecode: getDBholddata5[i]['expencecode'].toString(),
      reference: getDBholddata5[i]['reference'].toString(),
      rcamount: (int.parse(getDBholddata5[i]['rcamount'].toString()))
          .toStringAsFixed(2),
      paidto: getDBholddata5[i]['paidto'].toString(),
      paidfrom: getDBholddata5[i]['paidfrom'].toString(),
      docstatus: getDBholddata5[i]['docstatus'].toString(),
      createDate: getDBholddata5[i]['createdateTime'].toString(),
      docentry: getDBholddata5[i]['docentry'].toString(),
      remarks: getDBholddata5[i]['remarks'].toString(),
    );
    expenceval2.add(expenceval);
    onhold.add(expenceval);
    onholdfilter = onhold;
    notifyListeners();
  }

  filterListOnHold(String v) {
    if (v.isNotEmpty) {
      onholdfilter = onhold
          .where((e) =>
              e.rcamount!.toLowerCase().contains(v.toLowerCase()) ||
              e.expensecode!.toLowerCase().contains(v.toLowerCase()))
          // e.invoceDate!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      onholdfilter = onhold;
      notifyListeners();
    }
  }

  mapHoldValues(int i, BuildContext context, ThemeData theme) async {
    await selectedName(onholdfilter[i].expensecode.toString());
    codeValue = onholdfilter[i].expensecode.toString();
    mycontroller[0].text = onholdfilter[i].reference.toString();
    mycontroller[1].text = onholdfilter[i].rcamount.toString();
    mycontroller[2].text = onholdfilter[i].paidto.toString();
    chosenValue = onholdfilter[i].paidfrom.toString();
    mycontroller[3].text = onholdfilter[i].remarks.toString();
    notifyListeners();
    final Database db = (await DBHelper.getInstance())!;
    holddocentry = onholdfilter[i].docentry.toString();

    // await DBOperation.deleteExpenseHold(db, holddocentry.toString()).then((value) {
    //   onhold.clear();
    //   holddocentry = '';
    //   getdraftindex();
    //   notifyListeners();
    // });
    notifyListeners();
  }

  clickcancelbtn(BuildContext context, ThemeData theme) async {
//log("sapDocentrysapDocentry::$sapDocentry");
    if (sapDocentry != null) {
      await sapLoginApi(context);
      await callSerlaySalesCancelQuoAPI(context, theme);
      notifyListeners();
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
        clearData();
        sapDocentry = '';
        sapDocuNumber = '';
        mycontroller[9].text = "";
        mycontroller[10].text = "";
        mycontroller[11].text = "";
        mycontroller[12].text = "";
        mycontroller[13].text = "";
        mycontroller[14].text = "";
        notifyListeners();
      });
      notifyListeners();
    }
  }

  sapLoginApi(BuildContext context) async {
    final pref2 = await pref;

    await PostExpensesLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          print("sessionID: " + value.sessionId.toString());
          getSession();
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

  void getSession() async {
    var preff = await SharedPreferences.getInstance();
    AppConstant.sapSessionID = preff.getString('sessionId')!;
//log("  AppConstant.sapSessionID::${AppConstant.sapSessionID}");
  }

  callSerlaySalesCancelQuoAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    await SerlayExpensesCancelAPI.getData(sapDocentry.toString())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 204) {
        cancelbtn = false;
        await DBOperation.updateExpclosedocsts(db, sapDocentry.toString());
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
          clearData();
          sapDocentry = '';
          sapDocuNumber = '';
          mycontroller[9].text = "";
          mycontroller[10].text = "";
          mycontroller[11].text = "";
          mycontroller[12].text = "";
          mycontroller[13].text = "";
          mycontroller[14].text = "";
          notifyListeners();
        });
        custserieserrormsg = '';
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        cancelbtn = false;
        custserieserrormsg = value.exception!.message!.value.toString();
        //log("Error22:;$custserieserrormsg");

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
                      content: '$custserieserrormsg',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          clearData();
          sapDocentry = '';
          sapDocuNumber = '';
          mycontroller[9].text = "";
          mycontroller[10].text = "";
          mycontroller[11].text = "";
          mycontroller[12].text = "";
          mycontroller[13].text = "";
          mycontroller[14].text = "";
          notifyListeners();
        });
        //log("custserieserrormsgcustserieserrormsg::$custserieserrormsg");
      } else {
        //log("Error33");

        // custserieserrormsg = value.message!.toString();
      }
    });
    notifyListeners();
  }
  //  else  {
  //   //:bost_Close

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
  //                 content: 'Document is already closed..!!',
  //                 theme: theme,
  //               )),
  //               buttonName: null,
  //             ));
  //       }).then((value) {
  //     sapDocentry = '';
  //     sapDocuNumber = '';
  //   });
  //   notifyListeners();
  // }
  // }

  getcodeExpense() async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getExpenseMaster(db);
    for (int i = 0; i < getDBholddata5.length; i++) {
      expCode.add(codeforexpense(
          expensecode: getDBholddata5[i]["expensecode"].toString(),
          expensename: getDBholddata5[i]["expensename"].toString(),
          debit: getDBholddata5[i]["debit"].toString(),
          credit: getDBholddata5[i]["credit"].toString(),
          limit: getDBholddata5[i]["limitval"].toString()));
      notifyListeners();

      // finalcode.add(codeexpense[i].expensecode);
      //// log("acount nbae2222:" + expCode[i].expensecode.toString());
    }
    // log("acount nbae111:" + expCode.length.toString());

    notifyListeners();
  }

  getpaidfomExpense() async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getExpensepaidfrom(db);
    for (int i = 0; i < getDBholddata5.length; i++) {
      paidFromData.add(PaidFrom(
          accountcode: getDBholddata5[i]["accountcode"].toString(),
          accountname: getDBholddata5[i]["accountname"].toString(),
          balance: getDBholddata5[i]["balance"].toString()));
      // log("acount nbae:" + paidFromData.length.toString());
      // log("acount nbae:" + paidFromData[i].accountname.toString());
      notifyListeners();
    }
    notifyListeners();
  }

  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    if (checkAnyValue() == true) {
      Get.defaultDialog(
          barrierDismissible: false,
          title: 'Warning..!!',
          //   middleText: 'Are sure to close this expence all data will lost',
          content: StatefulBuilder(builder: (context, st) {
            return Container(
              width: Screens.width(context) * 0.3,
              // height: Screens.bodyheight(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.005,
                  ),
                  Container(
                    child: Text(
                        'Are sure to close this expence all data will lost'),
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.08,
                        child: ElevatedButton(
                            onPressed: () {
                              clearAllDataHold();
                            },
                            child: Text('Ok')),
                      ),
                      Container(
                        width: Screens.width(context) * 0.08,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('Cancel')),
                      ),
                    ],
                  )
                ],
              ),
            );
          }));
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  clearAllDataHold() {
    Get.back();
    Get.back();
    clearData();
  }

  bool checkAnyValue() {
    bool result = false;
    if (codeValue != null ||
        chosenValue != null ||
        mycontroller[0].text.isNotEmpty ||
        mycontroller[1].text.isNotEmpty ||
        mycontroller[3].text.isNotEmpty ||
        mycontroller[4].text.isNotEmpty) {
      result = true;
    }
    return result;
  }

  void selectedCode(String value) {
    displayExpanseValue = value;
    for (int i = 0; i < expenseModel.length; i++) {
      if (value == expenseModel[i].name) {
        codeValue = expenseModel[i].code;
      }
    }
//log("dadada: " + displayExpanseValue.toString());
//log(" expenseModel[i].code::${codeValue}");

    notifyListeners();
  }

  Future selectedName(String code) async {
    for (int i = 0; i < expenseModel.length; i++) {
      if (code == expenseModel[i].code) {
        displayExpanseValue = expenseModel[i].name;
      }
    }
    notifyListeners();
  }
}
