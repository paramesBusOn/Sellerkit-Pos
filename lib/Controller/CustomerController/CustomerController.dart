import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:posproject/Service/AccountBalanceAPI.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';

class CustomerController extends ChangeNotifier {
  init() {
    clearalldata();
    getcustomerMaster();
  }

  List<TextEditingController> mycontroller = List.generate(150, (i) => TextEditingController());
  PageController tappage = PageController(initialPage: 0);
  int tappageIndex = 0;

  Future<bool> onbackpress() async {
    log("objectaaaaaaaaaaaaaaaaaaa:::::$tappageIndex");
    if (tappageIndex == 0) {
      Get.offAllNamed(ConstantRoutes.dashboard);
    } else {
      log("objectbbbbbbbbbb:::::$tappageIndex");
      await tappage.animateToPage(--tappageIndex, duration: const Duration(milliseconds: 250), curve: Curves.bounceIn);
      getcustomerMaster();
      mycontroller[0].clear();
      notifyListeners();
      // return Future.value(true);
      log("object:::::$tappageIndex");
    }
    // else if(tappageIndex == 1){
    //   //  tappage.animateToPage(--tappageIndex,
    //   //     duration: Duration(milliseconds: 250), curve: Curves.bounceIn);

    // };
    return Future.value(false);
  }

  pageplus() {
    int page = 0;
    // tappageIndex=0;
    if (page == 0) {
      tappage.animateToPage(++tappageIndex, duration: const Duration(milliseconds: 400), curve: Curves.linearToEaseOut);
      // Get.toNamed(ConstantRoutes.dashboard);
    }
  }

  routecustome() {
    // if (tappageIndex == 2) {
    tappage.animateToPage(--tappageIndex, duration: const Duration(milliseconds: 400), curve: Curves.linearToEaseOut);
    log("page ajajajd::::$tappageIndex");
    return true;

    // }
    // else {
    //   return false;
    // }
  }

  // Future<bool> onWillPop(BuildContext context) async {
  //   return (
  //     await
  //   showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: Text("Are you sure?"),
  //           content: Text("Do you want to exit an app"),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.of(context).pop(false),
  //               child: Text("No"),
  //             ),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(true);
  //                 },
  //                 child: Text("yes"))
  //           ],
  //         ),
  //       )) ??
  //       false;
  // }
  List<CustomerMasterList> customerList = [];
  List<CustomerMasterList> filtercustomerList = [];
  bool listbool = false;
  getcustomerMaster() async {
    double? updateCustBal;
    listbool = true;
    customerList.clear();
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getCustomerData = await DBOperation.getCstmMasforcustomerpage(db);
    if (getCustomerData.isNotEmpty) {
      for (int i = 0; i < getCustomerData.length; i++) {
        customerList.add(CustomerMasterList(
          customerCode: getCustomerData[i]["customercode"].toString(),
          customername: getCustomerData[i]["customername"].toString(),
          balance: double.parse(getCustomerData[i]["balance"].toString()),
          points: getCustomerData[i]["points"].toString(),
          emalid: getCustomerData[i]["emalid"].toString(),
          customertype: getCustomerData[i]["customertype"].toString(),
          phoneno1: getCustomerData[i]["phoneno1"].toString(),
          taxno: getCustomerData[i]["taxno"].toString(),
        ));

        //   await AccountBalApi.getData(getCustomerData[i]["customercode"].toString()).then((value) {
        //     // loadingscrn = false;
        //     if (value.statuscode >= 200 && value.statuscode <= 210) {
        //       print("Account Balance");
        //       customerList[i].customerCode = double.parse(value.accBalanceData![0].balance.toString()).toString();
        //       // selectedcust55!.accBalance = double.parse(value.accBalanceData![0].balance.toString());
        //       notifyListeners();
        //     }
        //   });
      }

      filtercustomerList = customerList;
      // notifyListeners();
    } else {
      listbool = false;
      notifyListeners();
    }
    notifyListeners();
  }

  filterListSearched(String v) {
    //y
    if (v.isNotEmpty) {
      filtercustomerList = customerList
          .where((e) => e.customername!.toLowerCase().contains(v.toLowerCase()) || e.customerCode!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.serialbatch!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtercustomerList = customerList;
      notifyListeners();
    }
  }

  List<CustomerMasterDetail> cutomerdetail = [];
  DetailsMetod(String customerCode) async {
    cutomerdetail.clear();
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getCustomerDetails = await DBOperation.getcustomerdetails(db, customerCode);
    if (getCustomerDetails.isEmpty) {
      log("Customer details is Empty");
    } else {
      for (int i = 0; i < getCustomerDetails.length; i++) {
        cutomerdetail.add(CustomerMasterDetail(
            createdUserID: getCustomerDetails[i]["createdUserID"].toString(),
            createdateTime: getCustomerDetails[i]["createdateTime"].toString(),
            lastupdateIp: getCustomerDetails[i]["lastupdateIp"].toString(),
            updatedDatetime: getCustomerDetails[i]["UpdatedDatetime"].toString(),
            updateduserid: getCustomerDetails[i]["updateduserid"].toString(),
            address1: getCustomerDetails[i]["address1"].toString(),
            address2: getCustomerDetails[i]["address2"].toString(),
            address3: getCustomerDetails[i]["address3"].toString(),
            pincode: getCustomerDetails[i]["pincode"].toString(),
            city: getCustomerDetails[i]["city"].toString(),
            countrycode: getCustomerDetails[i]["countrycode"].toString(),
            custcode: getCustomerDetails[i]["custcode"].toString(),
            geolocation1: getCustomerDetails[i]["geolocation1"].toString(),
            geolocation2: getCustomerDetails[i]["geolocation2"].toString(),
            statecode: getCustomerDetails[i]["statecode"].toString()));
      }
      log("Customer details1:::::::::::::::${getCustomerDetails[0]["custcode"]}");
      log("Customer details::::${cutomerdetail[0].custcode}");
    }
    notifyListeners();
  }

  // int list_i = 0;
  CustomerMasterList? cusList1;
  ListPasss(CustomerMasterList cusList) {
    // cusList=null;
    cusList1 = cusList;
    notifyListeners();
  }

  morecusdetail() async {
    listbool = true;
    customerList.clear();
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getCustomerData = await DBOperation.getMoreCstmMasforcuspage(db, mycontroller[0].text);
    if (getCustomerData.isNotEmpty) {
      for (int i = 0; i < getCustomerData.length; i++) {
        customerList.add(CustomerMasterList(
          customerCode: getCustomerData[i]["customercode"].toString(),
          customername: getCustomerData[i]["customername"].toString(),
          balance: double.parse(getCustomerData[i]["balance"].toString()),
          points: getCustomerData[i]["points"].toString(),
          emalid: getCustomerData[i]["emalid"].toString(),
          customertype: getCustomerData[i]["customertype"].toString(),
          phoneno1: getCustomerData[i]["phoneno1"].toString(),
          taxno: getCustomerData[i]["taxno"].toString(),
        ));
      }
      filtercustomerList = customerList;
      mycontroller[0].text = '';
      // notifyListeners();
    } else {
      // customerList.clear();
      //  getcustomerMaster();
      listbool = false;
      notifyListeners();
    }
    notifyListeners();
  }

  clearalldata() {
    //  tappage = PageController(initialPage: 0);
    tappageIndex = 0;
    filtercustomerList.clear();
    listbool = false;
    customerList.clear();
    cutomerdetail.clear();
    mycontroller[0].clear();
    notifyListeners();
  }
}

class CustomerMasterList {
  String? customerCode;
  String? customername;
  double? balance;
  String? points;
  String? emalid;
  String? taxno;
  String? phoneno1;
  String? customertype;

  CustomerMasterList({
    required this.customerCode,
    required this.customername,
    required this.balance,
    required this.points,
    required this.emalid,
    required this.taxno,
    required this.phoneno1,
    required this.customertype,
  });
}

class CustomerMasterDetail {
  String? pincode;
  String? custcode;
  String? address1;
  String? address2;
  String? address3;
  String? city;
  String statecode;
  String? countrycode;
  String? geolocation1;
  String? geolocation2;

  // String? terminal;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  CustomerMasterDetail(
      {required this.createdUserID,
      required this.createdateTime,
      required this.lastupdateIp,
      required this.updatedDatetime,
      required this.updateduserid,
      required this.address1,
      required this.address2,
      required this.address3,
      required this.pincode,
      required this.city,
      required this.countrycode,
      required this.custcode,
      // required this.terminal,
      required this.geolocation1,
      required this.geolocation2,
      required this.statecode});
}
