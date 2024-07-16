// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/SharedPreference.dart';
import 'package:posproject/main.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/Branch.dart';
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/ItemMaster.dart';
import '../../DBModel/StockSnap.dart';
import '../../Service/AddressMasterAPI.dart';
import '../../Service/BranchMasterAPI.dart';
import '../../Service/CustomerMasterAPI.dart';
import '../../Service/StockSnapApi.dart';
import '../../Service/productMasterApi.dart';

class ApiSettingsController extends ChangeNotifier {
  init() {
    // reievervb();
    getqueueDetails();
    getMasterApiCount();
  }

  String? queueName;
  String? countOfCounsumer;
  getqueueDetails() async {
    // await SharedPref.getConsumerCount();
    // await SharedPref.getQueueName();
    queueName = "";
    countOfCounsumer = "";
    // log(qname.toString());
    queueName = await SharedPref.getQueueName();
    countOfCounsumer = await SharedPref.getConsumerCount();

    notifyListeners();
  }

  clearmethod() async {
    queueName = "";
    countOfCounsumer = "";
    await getqueueDetails();
    notifyListeners();
  }

  resetClickEvent() {
    clearmethod();
    receivervb();
    notifyListeners();
  }

//ItemMaster Api-StockSnap Table
  int itemMasterCount = 0;
  int get getitemMasterCount => itemMasterCount;
  bool progressItemMaster = false;
  bool get getprogressItemMaster => progressItemMaster;

//Product Master Api - ItemMaster Table
  int productMasterCount = 0;
  int get getproductMasterCount => productMasterCount;
  bool progressProductMaster = false;
  bool get getprogressProductMaster => progressProductMaster;
//branch Master Api - BranchMaster Table
  int branchMasterCount = 0;
  int get getBranchMasterCount => branchMasterCount;
  bool progressBranchMaster = false;
  bool get getprogressBranchMaster => progressBranchMaster;
//customer Master Api - customerMaster Table
  int customerMasterCount = 0;
  int get getCustomerMasterCount => customerMasterCount;
  bool progressCustomerMaster = false;
  bool get getprogressCustomerMaster => progressCustomerMaster;
//customerAddress Master Api - customerAddressMaster Table
  int customerAddressMasterCount = 0;
  int get getCustomerAddressMasterCount => customerAddressMasterCount;
  bool progressCustomerAddressMaster = false;
  bool get getprogressCustomerAddressMaster => progressCustomerAddressMaster;

  getMasterApiCount() async {
    itemMasterCount = 0;
    productMasterCount = 0;
    branchMasterCount = 0;
    customerMasterCount = 0;
    customerAddressMasterCount = 0;

    final Database db = (await DBHelper.getInstance())!;
    itemMasterCount = (await DBOperation.getItemMasterCount(db))!;
    productMasterCount = (await DBOperation.getProductMasterCount(db))!;
    branchMasterCount = (await DBOperation.getBranchMasterCount(db))!;
    customerMasterCount = (await DBOperation.getCustomerMasterCount(db))!;
    customerAddressMasterCount =
        (await DBOperation.getCustomerAddressMasterCount(db))!;
    notifyListeners();
  }

  getItemMasterData(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    progressItemMaster = true;

    if (itemMasterCount == 0) {
      List<StockSnapTModelDB> stockSnap = [];

      await DBOperation.truncateStockSnap(db);
      await StockSnapModelApi.getData().then((value) {
        if (value.stcode! >= 200 && value.stcode! <= 210) {
          if (value.stocksnapitemdata != null) {
            for (int i = 0; i < value.stocksnapitemdata!.length; i++) {
              stockSnap.add(StockSnapTModelDB(
                terminal: UserValues.terminal,
                branchcode: value.stocksnapitemdata![i].Branch,
                branch: UserValues.branch,
                createdUserID: int.parse(
                    value.stocksnapitemdata![i].createdUserID.toString()),
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
                specialprice:
                    value.stocksnapitemdata![i].specialprice.toString(),
                updatedDatetime: value.stocksnapitemdata![i].updatedDatetime,
                updateduserid: int.parse(
                    value.stocksnapitemdata![i].updateduserid.toString()),
                itemname: value.stocksnapitemdata![i].ItemName.toString(),
                weight: value.stocksnapitemdata![i].weight,
                liter: value.stocksnapitemdata![i].liter,
                uPackSize: value.stocksnapitemdata![i].uPackSize.toString(),
                uTINSPERBOX: int.parse(
                    value.stocksnapitemdata![i].uTINSPERBOX.toString()),
                uSpecificGravity:
                    value.stocksnapitemdata![i].uSpecificGravity.toString(),
                uPackSizeuom:
                    value.stocksnapitemdata![i].uPackSizeuom.toString(),
              ));
            }
            // percent = 0.1;
            notifyListeners();
          } else if (value.stocksnapitemdata == null) {
            var snackBar = SnackBar(
                elevation: 1.9,
                width: Screens.width(context) * 0.7,
                backgroundColor: Colors.grey,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 1),
                // duration: Duration(seconds: 2),
                content: Text('${value.exception}..'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
      await DBOperation.insertStockSnap(db, stockSnap).then((value) async {
        log("insert stockSnap");
        itemMasterCount = (await DBOperation.getItemMasterCount(db))!;

        progressItemMaster = false;
        notifyListeners();
      });
      progressItemMaster = false;
    } else {
      // ignore: prefer_const_constructors
      var snackBar = SnackBar(
          elevation: 1.9,
          width: Screens.width(context) * 0.7,
          backgroundColor: Colors.grey,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          // duration: Duration(seconds: 2),
          content: const Text('ItemMaster Already Synced..'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      progressItemMaster = false;
    }
    notifyListeners();
  }

  getProductMasterData(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    progressProductMaster = true;
    List<ItemMasterModelDB> itemMasterDB = [];

    if (productMasterCount == 0) {
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
                uPackSize: value.itemdata![i].uPackSize.toString(),
                uPackSizeuom: value.itemdata![i].uPackSizeuom.toString(),
                uTINSPERBOX: value.itemdata![i].uTINSPERBOX != null
                    ? value.itemdata![i].uTINSPERBOX!
                    : 0,
                uSpecificGravity: value.itemdata![i].uSpecificGravity != null
                    ? value.itemdata![i].uSpecificGravity.toString()
                    : '',
              ));
            }
            notifyListeners();
          } else if (value.itemdata == null) {
            var snackBar = SnackBar(
                elevation: 1.9,
                width: Screens.width(context) * 0.7,
                backgroundColor: Colors.grey,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 1),
                // duration: Duration(seconds: 2),
                content: Text('${value.exception}..'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });

      await DBOperation.insertItemter(db, itemMasterDB).then((value) async {
        log(" inseted insertProductMaster");
        itemMasterCount = (await DBOperation.getItemMasterCount(db))!;
        progressProductMaster = false;

        notifyListeners();
      });
      progressProductMaster = false;
    } else {
      var snackBar = SnackBar(
          elevation: 1.9,
          width: Screens.width(context) * 0.7,
          backgroundColor: Colors.grey,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          // duration: Duration(seconds: 2),
          content: const Text('Product Master Already Synced..'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      progressProductMaster = false;
    }
    notifyListeners();
  }

  getBranchMasterData(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    progressBranchMaster = true;
    List<BranchTModelDB> branchValues = [];

    if (branchMasterCount == 0) {
      await DBOperation.truncateBranchMaster(db);

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
            // percent = 0.3;
            notifyListeners();
          } else if (value.branchdata == null) {
            var snackBar = SnackBar(
                elevation: 1.9,
                width: Screens.width(context) * 0.7,
                backgroundColor: Colors.grey,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 1),
                // duration: Duration(seconds: 2),
                content: Text('${value.exception}..'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // exception = value.exception!;
        } else {
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
      await DBOperation.insertBranchTable(db, branchValues).then((value) async {
        log("inseted insertBranchTable");
        progressBranchMaster = false;
        branchMasterCount = (await DBOperation.getBranchMasterCount(db))!;
        notifyListeners();
      });
      progressBranchMaster = false;
    } else {
      progressBranchMaster = false;
      var snackBar = SnackBar(
          elevation: 1.9,
          width: Screens.width(context) * 0.7,
          backgroundColor: Colors.grey,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          // duration: Duration(seconds: 2),
          content: const Text('Branch Master Already Synced..'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    progressBranchMaster = false;
    notifyListeners();
  }

  getCustomerMasterData(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    progressCustomerMaster = true;
    List<CustomerModelDB> custValues = [];

    if (customerMasterCount == 0) {
      await DBOperation.truncateCustomerMaster(db);
      await CustomerMasterApi.getData().then((value) async {
        if (value.stcode! >= 200 && value.stcode! <= 210) {
          log("value.customerdata length:::${value.customerdata!.length}");

          if (value.customerdata != null) {
            for (int i = 0; i < value.customerdata!.length; i++) {
              custValues.add(CustomerModelDB(
                customerCode: value.customerdata![i].cardCode,
                createdUserID: value.customerdata![i].createdUserID,
                createdateTime: value.customerdata![i].createdateTime,
                updatedDatetime: value.customerdata![i].updatedDatetime,
                updateduserid:
                    int.parse(value.customerdata![i].updateduserid.toString()),
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
            // percent = 0.5;
            notifyListeners();
          } else if (value.customerdata == null) {
            var snackBar = SnackBar(
                elevation: 1.9,
                width: Screens.width(context) * 0.7,
                backgroundColor: Colors.grey,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 1),
                // duration: Duration(seconds: 2),
                content: Text('${value.exception}..'));

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
      await DBOperation.insertCustomer(db, custValues).then((value) async {
        log("inseted CustomerMaster");
        progressCustomerMaster = false;
        customerMasterCount = (await DBOperation.getCustomerMasterCount(db))!;

        notifyListeners();
      });

      progressCustomerMaster = false;
    } else {
      progressCustomerMaster = false;
      var snackBar = SnackBar(
          elevation: 1.9,
          width: Screens.width(context) * 0.7,
          backgroundColor: Colors.grey,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          // duration: Duration(seconds: 2),
          content: const Text('Customer Master Already Synced..'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    progressCustomerMaster = false;
    notifyListeners();
  }

  getCustomerAddressMasterData(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    progressCustomerAddressMaster = true;
    List<CustomerAddressModelDB> addrsvalue = [];

    if (customerAddressMasterCount == 0) {
      await DBOperation.truncateCustomerMasterAddress(db);
      await AddressMasterApi.getData().then((value) async {
        if (value.stcode! >= 200 && value.stcode! <= 210) {
          // log("value.addressdata length:::${value.addressdata!.length}");
          // print(
          //     " UserValues.branch  address table" + UserValues.branch.toString());
          if (value.addressdata != null) {
            for (int i = 0; i < value.addressdata!.length; i++) {
              addrsvalue.add(CustomerAddressModelDB(
                terminal: UserValues.terminal,
                branch: UserValues.branch,
                createdUserID: value.addressdata![i].createdUserID,
                createdateTime: value.addressdata![i].createdateTime,
                lastupdateIp: value.addressdata![i].lastupdateIp!.isNotEmpty
                    ? value.addressdata![i].lastupdateIp.toString()
                    : "",
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
            // percent = 0.4;
            notifyListeners();
          }
        } else if (value.addressdata == null) {
          // exception = value.message!;
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (value.stcode! >= 400 && value.stcode! <= 410) {
          // exception = value.exception!;
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          // exception = value.exception!;
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
      await DBOperation.insertCustomerAddress(db, addrsvalue)
          .then((value) async {
        log("inseted CustomerAddressMaster");
        progressCustomerAddressMaster = false;
        customerAddressMasterCount =
            (await DBOperation.getCustomerMasterCount(db))!;

        notifyListeners();
      });

      progressCustomerAddressMaster = false;
    } else {
      progressCustomerAddressMaster = false;
      var snackBar = SnackBar(
          elevation: 1.9,
          width: Screens.width(context) * 0.7,
          backgroundColor: Colors.grey,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
          // duration: Duration(seconds: 2),
          content: const Text('Customer Address Master Already Synced..'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    progressCustomerAddressMaster = false;
    notifyListeners();
  }
}
