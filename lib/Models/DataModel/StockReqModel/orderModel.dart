import 'package:posproject/Models/DataModel/StockReqModel/warehouseModel.dart';
import 'package:posproject/Models/Service%20Model/StockSnapModelApi.dart';


class Orderdetails {
  WhsDetails? whsAdd;
  String orderType;
  String remarks;
  List<StocksnapModelData>scannData;
  Orderdetails({
   required this.remarks,
    required this.whsAdd,
    required this.orderType,
    required this.scannData
  });
}

// class orderdetails {
//   // ShipAddress? shipAdd;
//   WhsDetails? whsAdd;
//   TotalPayment? totalPayment;
//   String orderType;
//   List<ItemMasterModelData>scannData;
//   orderdetails({
//     // required this.shipAdd,
//     required this.whsAdd,
//     required this.totalPayment,
//     required this.orderType,required this.scannData
//   });
// }
