import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/Configuration.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import '../../Models/DataModel/SalesOrderModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';

class PendingOrderController extends ChangeNotifier {
  init() {
    clearAllData();
    getSOValue();
    notifyListeners();
  }

  Configure config = Configure();

  TotalPayment? totalPayment;
  TotalPayment? get gettotalPayment => totalPayment;
  List<SalesModel> soSalesmodl = [];
  List<StocksnapModelData> filteritems = [];

  List<TextEditingController> searchcontroller = List.generate(150, (i) => TextEditingController());

  List<StocksnapModelData> soData = [];
  List<StocksnapModelData> get getsoData => soData;

  clearAllData() {
    config = Configure();
    totalPayment = null;
    soSalesmodl = [];
    filteritems = [];
    searchcontroller = List.generate(150, (i) => TextEditingController());
    soData = [];
    notifyListeners();
  }

  getSOValue() async {
    List<StocksnapModelData> scannData = [];
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getheaderData = await DBOperation.getSalesOrdervalueDB(db);
    for (int ik = 0; ik < getheaderData.length; ik++) {
      List<Map<String, Object?>> lineData = await DBOperation.getSalesOrderLinevalueDB(db, getheaderData[ik]['docentry'].toString());
      //log("getheaderDatagetheaderData ${getheaderData.length}");
      for (int i = 0; i < lineData.length; i++) {
        //log("lineData[i]['Balanceqty'].lineData[i]['Balanceqty']:${lineData[i]['Balanceqty'].toString()}");
        if (getheaderData[ik]['docentry'].toString() == lineData[i]['docentry'].toString()) {
          // qtymycontroller[i].text = lineData[i]['quantity'].toString();
          scannData.add(StocksnapModelData(
              basedocentry: lineData[i]['docentry'].toString(),
              baselineid: lineData[i]['lineID'].toString(),
              basic: lineData[i]['basic'] != null ? double.parse(lineData[i]['basic'].toString()) : 00,
              netvalue: lineData[i]['netlinetotal'] != null ? double.parse(lineData[i]['netlinetotal'].toString()) : null,
              TransID: int.parse(lineData[i]['docentry'].toString()),
              Branch: lineData[i]['branch'].toString(),
              ItemCode: lineData[i]['itemcode'].toString(),
              ItemName: lineData[i]['itemname'].toString(),
              SerialBatch: lineData[i]['serialbatch'].toString(),
              OpenQty: lineData[i]['Balanceqty'] != null ? int.parse(lineData[i]['Balanceqty'].toString()) : int.parse(lineData[i]['quantity'].toString()),
              Qty:
                  //lineData[i]['Balanceqty'] != null
                  //     ? int.parse(lineData[i]['Balanceqty'].toString())
                  int.parse(lineData[i]['quantity'].toString()),
              InDate: lineData[i][''].toString(),
              InType: lineData[i][''].toString(),
              VenCode: lineData[i][''].toString(),
              VenName: lineData[i][''].toString(),
              MRP: 0,
              SellPrice: double.parse(lineData[i]['price'].toString()),
              Cost: 0,
              discount: lineData[i]['discperunit'] != null ? double.parse(lineData[i]['discperunit'].toString()) : 00,
              taxvalue: lineData[i]['taxtotal'] != null ? double.parse(lineData[i]['taxtotal'].toString()) : 00,
              TaxRate: double.parse(lineData[i]['taxrate'].toString()),
              TaxType: lineData[i]['taxtype'].toString(),
              Maxdiscount: lineData[i]['maxdiscount'].toString(),
              discountper: lineData[i]['discperc'] == null ? 0.0 : double.parse(lineData[i]['discperc'].toString()),
              createdUserID: '',
              createdateTime: lineData[i]['createdateTime'].toString(),
              lastupdateIp: '',
              purchasedate: '',
              snapdatetime: '',
              specialprice: 0,
              updatedDatetime: '',
              updateduserid: '',
              liter: lineData[i]['liter'] == null ? 0.0 : double.parse(lineData[i]['liter'].toString()),
              weight: lineData[i]['weight'] == null ? 0.0 : double.parse(lineData[i]['weight'].toString())));
          notifyListeners();
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
        invoceAmount: double.parse(getheaderData[ik]['doctotal'].toString()),
        invoceDate: config.alignDate(getheaderData[ik]['createdateTime'].toString()),
        invoiceNum: getheaderData[ik]['documentno'].toString(),
        address: [Address(address1: getheaderData[ik]['billaddressid'].toString(), billCity: getheaderData[ik]['city'].toString(), billCountry: getheaderData[ik]['country'].toString(), billPincode: getheaderData[ik]['pinno'].toString(), billstate: getheaderData[ik]['state'].toString())],
        totalPayment: TotalPayment(
          balance: getheaderData[ik]['baltopay'] == null ? 0.00 : double.parse(getheaderData[ik]['baltopay'].toString()),

          discount2: getheaderData[ik]['docdiscamt'] == null ? 0.00 : double.parse(getheaderData[ik]['docdiscamt'].toString()),
          discount: getheaderData[ik]['docdiscamt'] == null ? 0.00 : double.parse(getheaderData[ik]['docdiscamt'].toString()),
          totalTX: double.parse(getheaderData[ik]['taxamount'] == null ? '0' : getheaderData[ik]['taxamount'].toString().replaceAll(',', '')),

          subtotal: double.parse(getheaderData[ik]['docbasic'] == null ? '0' : getheaderData[ik]['docbasic'].toString().replaceAll(',', '')), //doctotal

          total: totalPayment == null ? 0 : int.parse(totalPayment!.total!.toString()),
          totalDue: double.parse(getheaderData[ik]['doctotal'] == null ? '0' : getheaderData[ik]['doctotal'].toString().replaceAll(',', '')),
          totpaid: double.parse(getheaderData[ik]['amtpaid'] == null ? '0' : getheaderData[ik]['amtpaid'].toString().replaceAll(',', '')),
        ),
        item: scannData,
      );
      soSalesmodl.add(salesM);
 //log("soSalesmodlsoSalesmodl::${soSalesmodl.length}");
      notifyListeners();
      // soOrderdata(ik);
      // soTotal = double.parse(getheaderData[ik]['baltopay'].toString());
      notifyListeners();
    }
    notifyListeners();
  }

  filterListItem(String v) {
    if (v.isNotEmpty) {
      filteritems = soData.where((e) => e.ItemCode!.toLowerCase().contains(v.toLowerCase()) || e.ItemName!.toLowerCase().contains(v.toLowerCase())).toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filteritems = soData;
      notifyListeners();
    }
  }

  soOrderdata(String basedoc, int ih) {
    soData.clear();
    filteritems.clear();
    for (int ik = 0; ik < soSalesmodl[ih].item!.length; ik++) {
 //log("soSalesmodl[ih].docentry::${soSalesmodl[ih].docentry}:;${soSalesmodl[ih].item![ik].basedocentry.toString()}");
      if (soSalesmodl[ih].item![ik].basedocentry.toString() == basedoc.toString()) {
        if (soSalesmodl[ih].item![ik].Qty != 0) {
          soData.add(StocksnapModelData(
            docentry: basedoc.toString(),
            basedocentry: soSalesmodl[ih].item![ik].basedocentry,
            baselineid: soSalesmodl[ih].item![ik].baselineid,
            Branch: soSalesmodl[ih].item![ik].Branch,
            ItemCode: soSalesmodl[ih].item![ik].ItemCode,
            ItemName: soSalesmodl[ih].item![ik].ItemName,
            SerialBatch: "",
            // soSalesmodl[ih].item![ik].SerialBatch,
            OpenQty: soSalesmodl[ih].item![ik].OpenQty,
            Qty: soSalesmodl[ih].item![ik].Qty,
            MRP: double.parse(soSalesmodl[ih].item![ik].MRP.toString()),
            createdUserID: soSalesmodl[ih].item![ik].createdUserID.toString(),
            createdateTime: config.alignDate(soSalesmodl[ih].item![ik].createdateTime.toString()),
            lastupdateIp: soSalesmodl[ih].item![ik].lastupdateIp,
            purchasedate: soSalesmodl[ih].item![ik].purchasedate,
            snapdatetime: soSalesmodl[ih].item![ik].snapdatetime,
            specialprice: double.parse(soSalesmodl[ih].item![ik].specialprice.toString()),
            updatedDatetime: soSalesmodl[ih].item![ik].updatedDatetime,
            updateduserid: soSalesmodl[ih].item![ik].updateduserid.toString(),
            SellPrice: double.parse(soSalesmodl[ih].item![ik].SellPrice.toString()),
            Maxdiscount: soSalesmodl[ih].item![ik].Maxdiscount != null ? soSalesmodl[ih].item![ik].Maxdiscount.toString() : '',
            TaxRate: soSalesmodl[ih].item![ik].TaxRate != null ? double.parse(soSalesmodl[ih].item![ik].TaxRate.toString()) : 0.0,
            discountper: double.parse(soSalesmodl[ih].item![ik].discountper!.toString()),
            InDate: '',
            Cost: 0,
            TaxType: '',
            InType: '',
            VenCode: '',
            VenName: '',
            liter: soSalesmodl[ih].item![ik].liter != null ? double.parse(soSalesmodl[ih].item![ik].liter.toString()) : 0.0,
            weight: soSalesmodl[ih].item![ik].weight != null ? double.parse(soSalesmodl[ih].item![ik].weight.toString()) : 0.0,
          ));
          notifyListeners();
        }

        filteritems = soData;
        notifyListeners();
      }
      // sBatchFrmStksnap(ik);
 //log("ikik::${ik}");
      notifyListeners();
    }
  }

  sBatchFrmStksnap(int indexx) async {
    print("LLLLLLL${indexx}LLLLLLLLLLLL::${soData.length}");
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> serailbatchCheck = await DBOperation.cfoserialBatchCheck(db, soData[indexx].ItemCode.toString());
    for (int i = 0; i < serailbatchCheck.length; i++) {
      if (soData[indexx].ItemCode == serailbatchCheck[i]['itemcode'].toString()) {
        soData[indexx].SerialBatch = serailbatchCheck[i]['serialbatch'].toString();
        // log("serailbatchCheck[i]['serialbatch']::" +
        //     serailbatchCheck[i]['serialbatch'].toString());
        notifyListeners();
      }
    }
    notifyListeners();
  }
}
