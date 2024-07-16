// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/DBModel/UserDBModel.dart';
import 'package:posproject/Service/UsersAPI.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/SharedPreference.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/Branch.dart';
import '../../DBModel/CouponDetailsDBModel.dart';
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/ItemMaster.dart';
import '../../DBModel/StockSnap.dart';
import '../../Models/DataModel/CouponsDetailsModel/CouponDetModel.dart';
import '../../Service/AddressMasterAPI.dart';
import '../../Service/BranchMasterAPI.dart';
import '../../Service/CustomerMasterAPI.dart';
import '../../Service/StockSnapApi.dart';
import '../../Service/productMasterApi.dart';
import '../../main.dart';

class DownLoadController extends ChangeNotifier {
  String errorMsg = 'Some thing went wrong';
  bool exception = false;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;
  String loadingMsg = '';
  Configure config = Configure();
  int count = 0;

  double percent = 0.0;
  double get getpercent => percent;

  // DownLoadController() {
  //   getIP();
  //   CallApi();
  // }

  void init() {
    percent = 0.0;
    getIP().then((value) {
      CallApi();
    });
  }

  Future getIP() async {
    String? ip = await SharedPref.getHostDSP();
    String? branch = await getBranch();
    String? terminal = await getTerminal();

    if (ip != null && ip != 'null' && branch != null && branch != 'null' && terminal != null && terminal != 'null') {
      AppConstant.branch = branch.toString();
      AppConstant.terminal = terminal.toString();
      AppConstant.ip = ip;
  //log("ip: ${AppConstant.ip} ");
    }
  }

  CallApi() async {
    final Database db = (await DBHelper.getInstance())!;
    List<StockSnapTModelDB> stockSnap = [];
    List<ItemMasterModelDB> itemMasterDB = [];
    List<BranchTModelDB> branchValues = [];

    List<CouponDetailDB> coupondetlsMaster = [];
    List<CustomerAddressModelDB> addrsvalue = [];
    List<CustomerModelDB> custValues = [];
    List<String> catchmsg = [];
    loadingMsg = '';
    await DBOperation.truncateItemMaster(db);
    await DBOperation.truncateStockSnap(db);
    await DBOperation.truncateBranchMaster(db);
    await DBOperation.truncateCouponDetailsMaster(db);
    await DBOperation.truncateCustomerMasterAddress(db);
    await DBOperation.truncateCustomerMaster(db);
    loadingMsg = "Loading Item Master";
    notifyListeners();
    await StockSnapModelApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.stocksnapitemdata != null) {
          for (int i = 0; i < value.stocksnapitemdata!.length; i++) {
            stockSnap.add(StockSnapTModelDB(
              terminal: AppConstant.terminal,
              branchcode: value.stocksnapitemdata![i].Branch,
              branch: AppConstant.branch,
              createdUserID: int.parse(value.stocksnapitemdata![i].createdUserID.toString()),
              createdateTime: value.stocksnapitemdata![i].createdateTime,
              itemcode: value.stocksnapitemdata![i].ItemCode,
              lastupdateIp: value.stocksnapitemdata![i].lastupdateIp,
              maxdiscount: value.stocksnapitemdata![i].Maxdiscount.toString(),
              taxrate: value.stocksnapitemdata![i].TaxRate.toString(),
              mrpprice: value.stocksnapitemdata![i].MRP.toString(),
              purchasedate: value.stocksnapitemdata![i].purchasedate,
              quantity: value.stocksnapitemdata![i].Qty.toString(),
              sellprice: value.stocksnapitemdata![i].SellPrice.toString(),
              serialbatch: value.stocksnapitemdata![i].SerialBatch,
              snapdatetime: value.stocksnapitemdata![i].snapdatetime,
              specialprice: value.stocksnapitemdata![i].specialprice.toString(),
              updatedDatetime: value.stocksnapitemdata![i].updatedDatetime,
              updateduserid: int.parse(value.stocksnapitemdata![i].updateduserid.toString()),
              itemname: value.stocksnapitemdata![i].ItemName.toString(),
              weight: value.stocksnapitemdata![i].weight,
              liter: value.stocksnapitemdata![i].liter,
              uPackSize: value.stocksnapitemdata![i].uPackSize.toString(),
              uPackSizeuom:  value.stocksnapitemdata![i].uPackSizeuom.toString(),
              uTINSPERBOX:value.stocksnapitemdata![i].uTINSPERBOX!=null? value.stocksnapitemdata![i].uTINSPERBOX!:0,
              uSpecificGravity:value.stocksnapitemdata![i].uSpecificGravity!=null? value.stocksnapitemdata![i].uSpecificGravity.toString():'',
            ));
          }
          percent = 0.1;
          notifyListeners();
        } else if (value.stocksnapitemdata == null) {
      //log("TTTTTTTTTTTT1");
          // exception = value.message!;
          // catchmsg.add("Stock details: " + value.message!);
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
    //log("TTTTTTTTTTTT2");

        // exception = value.exception!;
        // catchmsg.add("Stock details: " + value.exception!);
      } else {
    //log("TTTTTTTTTTTT3");

        // exception = value.exception!;
        // catchmsg.add("Stcok details: " + value.exception!);
      }
    });
    //
    loadingMsg = "Loading Product Master";
    await ProductMasterApi.getData(AppConstant.branch, AppConstant.terminal).then((value) {
      Stopwatch s = new Stopwatch();
      sleep(new Duration(seconds: 1));
      print("Start in Elapse::" + s.elapsedMilliseconds.toString()); // 0
      s.start();
      sleep(new Duration(seconds: 1));
      print("isRunning::" + s.isRunning.toString()); // true
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
              brand: value.itemdata![i].brand,
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
              maxdiscount: value.itemdata![i].maxdiscount == null ? 0.00 : double.parse(value.itemdata![i].maxdiscount.toString()),
              skucode: value.itemdata![i].skucode,
              subcategory: value.itemdata![i].subcategory,
              taxrate: value.itemdata![i].taxrate.toString(),
              updatedDatetime: value.itemdata![i].updatedDatetime,
              updateduserid: value.itemdata![i].updateduserid.toString(),
              mrpprice: value.itemdata![i].mrpprice!.toString(),
              sellprice: value.itemdata![i].sellprice!.toString(),
              quantity: value.itemdata![i].quantity == null ? 0 : int.parse(value.itemdata![i].quantity.toString()),
                 uPackSize: value.itemdata![i].uPackSize.toString(),
              uPackSizeuom:  value.itemdata![i].uPackSizeuom.toString(),
              uTINSPERBOX:value.itemdata![i].uTINSPERBOX!=null? value.itemdata![i].uTINSPERBOX!:0,
              uSpecificGravity:value.itemdata![i].uSpecificGravity!=null? value.itemdata![i].uSpecificGravity.toString():'',
       
            ));
          }
          percent = 0.2;

          print("executed in Elapse222::" + s.elapsedMilliseconds.toString());

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
    //
    loadingMsg = "Loading Branch Master";
    await BranchMasterApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.branchdata != null) {
          for (int i = 0; i < value.branchdata!.length; i++) {
            branchValues.add(BranchTModelDB(
                whsCode: value.branchdata![i].whsCode.toString(),
                whsName: value.branchdata![i].whsName,
                priceList: value.branchdata![i].priceList,
                customerGroup: value.branchdata![i].customerGroup,
                cashAccount: value.branchdata![i].cashAccount,
                creditAccount: value.branchdata![i].creditAccount,
                chequeAccount: value.branchdata![i].chequeAccount,
                transFerAccount: value.branchdata![i].transFerAccount,
                customerAcct: value.branchdata![i].customerAcct,
                disAcct1: value.branchdata![i].disAcct1,
                disAcct2: value.branchdata![i].disAcct2,
                creditCard: value.branchdata![i].creditCard,
                stateCode: value.branchdata![i].stateCode,
                gSTNo: value.branchdata![i].gSTNo,
                location: value.branchdata![i].location,
                companyName: value.branchdata![i].companyName,
                companyHeader: value.branchdata![i].companyHeader,
                e_Mail: value.branchdata![i].e_Mail,
                cOGSAcct: value.branchdata![i].cOGSAcct,
                pAN: value.branchdata![i].pAN,
                address1: value.branchdata![i].address1,
                address2: value.branchdata![i].address2,
                city: value.branchdata![i].city,
                pincode: value.branchdata![i].pincode));
          }
          percent = 0.3;

          notifyListeners();
        } else if (value.branchdata == null) {
          // exception = value.message!;
          // log("1111111");
          catchmsg.add("BranchMaster details: " + value.exception!);
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // log("2222222");
        catchmsg.add("BranchMaster details: " + value.exception!);

        // exception = value.exception!;
      } else {
        // log("33333");
        catchmsg.add("BranchMaster details: " + value.exception!);

        // exception = value.exception!;
      }
    });
    //
    //

    for (int i = 0; i < coupondetails.length; i++) {
      coupondetlsMaster.add(CouponDetailDB(
          status: coupondetails[i].status,
          //
          doctype: coupondetails[i].doctype,
          cardcode: coupondetails[i].cardcode,
          coupontype: coupondetails[i].coupontype,
          couponno: coupondetails[i].couponcode,
          couponamt: coupondetails[i].couponamt));
    }

    //
    loadingMsg = "Loading Address Master";

    await AddressMasterApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        // log("value.addressdata length:::${value.addressdata!.length}");
        // print(
        //     " UserValues.branch  address table" + UserValues.branch.toString());
        if (value.addressdata != null) {
          for (int i = 0; i < value.addressdata!.length; i++) {
            addrsvalue.add(CustomerAddressModelDB(
              terminal: AppConstant.terminal,
              branch: AppConstant.branch,
              createdUserID: value.addressdata![i].createdUserID,
              createdateTime: value.addressdata![i].createdateTime,
              lastupdateIp: value.addressdata![i].lastupdateIp!.isNotEmpty ? value.addressdata![i].lastupdateIp.toString() : "",
              updatedDatetime: value.addressdata![i].updatedDatetime,
              updateduserid: value.addressdata![i].updateduserid.toString(),
              address1: value.addressdata![i].address1,
              address2: value.addressdata![i].address2,
              pincode: value.addressdata![i].billPincode,
              city: value.addressdata![i].billCity,
              countrycode: value.addressdata![i].billCountry,
              custcode: value.addressdata![i].custCode,
              geolocation1: value.addressdata![i].location1,
              geolocation2: value.addressdata![i].location2,
              statecode: value.addressdata![i].billstate,
              address3: '',
              addresstype: value.addressdata![i].addresstype,
            ));
          }
          percent = 0.4;

          notifyListeners();
        }
      } else if (value.addressdata == null) {
        // exception = value.message!;
        catchmsg.add("AddressMaster details: " + value.exception!);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // exception = value.exception!;
        catchmsg.add("AddressMaster details: " + value.exception!);
      } else {
        // exception = value.exception!;
        catchmsg.add("AddressMaster details: " + value.exception!);
      }
    });
    loadingMsg = "Loading Customer Master";

    await CustomerMasterApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
    //log("value.customerdata length:::${value.customerdata!.length}");

        if (value.customerdata != null) {
          for (int i = 0; i < value.customerdata!.length; i++) {
            custValues.add(CustomerModelDB(
              customerCode: value.customerdata![i].cardCode,
              createdUserID: value.customerdata![i].createdUserID,
              createdateTime: value.customerdata![i].createdateTime,
              updatedDatetime: value.customerdata![i].updatedDatetime,
              updateduserid: int.parse(value.customerdata![i].updateduserid.toString()),
              balance: value.customerdata![i].accBalance!,
              createdbybranch: UserValues.branch.toString(),
              customername: value.customerdata![i].name,
              customertype: value.customerdata![i].customertype,
              emalid: value.customerdata![i].email,
              phoneno1: value.customerdata![i].phNo,
              phoneno2: value.customerdata![i].Phno2,
              points: double.parse(value.customerdata![i].point.toString()),
              lastupdateIp: value.customerdata![i].lastupdateIp.toString(),
              // != null
              //     ? int.parse(value.customerdata![i].lastupdateIp!.toString())
              //     : 0,
              premiumid: value.customerdata![i].premiumid,
              snapdatetime: value.customerdata![i].snapdatetime,
              taxno: value.customerdata![i].taxNo,
              terminal: UserValues.terminal, tinNo: '', vatregno: '',
            ));
          }
          percent = 0.5;

          notifyListeners();
        } else if (value.customerdata == null) {
          // exception = value.message!;
          catchmsg.add("CustomerMaster details: " + value.exception!);
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // exception = value.exception!;
        catchmsg.add("CustomerMaster details: " + value.exception!);
      } else {
        // exception = value.exception!;
        catchmsg.add("CustomerMaster details: " + value.exception!);
      }
    });
    loadingMsg = "Loading Users Masters";

    await DBOperation.insertStockSnap(db, stockSnap).then((value) {
  //log("---------------1 inserted stocksnap");
      percent = 0.6;
      loadingMsg = "Inserted Item Master";

      notifyListeners();
    });
    await DBOperation.insertItemter(db, itemMasterDB).then((value) {
  //log("---------------2 inserted insertItemter");
      percent = 0.7;
      loadingMsg = "Inserted Product Master";

      notifyListeners();
    });
    await DBOperation.insertBranchTable(db, branchValues).then((value) {
  //log("---------------3 inserted insertBranchTable");
      percent = 0.7;
      loadingMsg = "Inserted Branch Master";

      notifyListeners();
    });
    await DBOperation.insertCustomer(db, custValues).then((value) {
  //log("---------------6 inseted Customer");
      percent = 0.8;
      loadingMsg = "Inserted Customer Master";

      notifyListeners();
    });
    await DBOperation.insertCouponmaster(db, coupondetlsMaster).then((value) => {log("---------------5 coupondetlsMaster")});
    percent = 0.8;
    notifyListeners();

    await DBOperation.insertCustomerAddress(db, addrsvalue).then((value) {
  //log("---------------4 insertCustomerAddress");
      percent = 0.95;
      loadingMsg = "Inserted Address Master";

      notifyListeners();
    });
    // await DBOperation.insertUsers(db, usersValues).then((value) {
    //   log("---------------4 InsertUsers value");
    //   percent = 0.5;
    //   loadingMsg = "Inserted Users Table";

    //   notifyListeners();
    // });
    if (catchmsg.isEmpty) {
      Get.defaultDialog(title: 'Alert', middleText: 'These data are not downloaded please manualy download it\n${catchmsg.toList().toString()}').then((value) async {
        await SharedPref.saveDatadonld(true);
        Get.offAllNamed(ConstantRoutes.dashboard);
      });
    } else {
      await SharedPref.saveDatadonld(true);
      Get.offAllNamed(ConstantRoutes.dashboard);
    }
    notifyListeners();
  }

  List<CouponDetModel> coupondetails = [
    CouponDetModel(coupontype: "GroupOn", createdUserID: UserValues.userID, couponcode: '12356', lastupdateIp: UserValues.lastUpdateIp, couponamt: 500, updateduserid: UserValues.userID, cardcode: 'B1111', doctype: 'SalesInvoice', status: 'Open'),
    CouponDetModel(coupontype: "AMAZON PAY", createdUserID: UserValues.userID, couponcode: '1234', lastupdateIp: UserValues.lastUpdateIp, couponamt: 1000, updateduserid: UserValues.userID, cardcode: 'B2222', doctype: 'SalesInvoice', status: 'Open'),
    CouponDetModel(coupontype: "FLIPKART CORPORATE", createdUserID: UserValues.userID, couponcode: '12347', lastupdateIp: UserValues.lastUpdateIp, couponamt: 2000, updateduserid: UserValues.userID, cardcode: 'B5555', doctype: 'SalesInvoice', status: 'Open'),
    CouponDetModel(coupontype: "HDFC Gift Plus", createdUserID: UserValues.userID, couponcode: '12346', lastupdateIp: UserValues.lastUpdateIp, couponamt: 2200, updateduserid: UserValues.userID, cardcode: 'B1111', doctype: 'SalesInvoice', status: 'Open'),
    CouponDetModel(coupontype: "ICICI GIFT COUPON", createdUserID: UserValues.userID, couponcode: '1256', lastupdateIp: UserValues.lastUpdateIp, couponamt: 1000, updateduserid: UserValues.userID, cardcode: 'B3333', doctype: 'SalesInvoice', status: 'Open'),
    CouponDetModel(coupontype: "UNILET COUPONS", createdUserID: UserValues.userID, couponcode: '43245', lastupdateIp: UserValues.lastUpdateIp, couponamt: 900, updateduserid: UserValues.userID, cardcode: 'B1111', doctype: 'SalesInvoice', status: 'Open'),
    CouponDetModel(coupontype: "INSIGNIA COUPONS", createdUserID: UserValues.userID, couponcode: '432456', lastupdateIp: UserValues.lastUpdateIp, couponamt: 1000, updateduserid: UserValues.userID, cardcode: 'B2222', doctype: 'SalesInvoice', status: 'Open'),
  ];
}
