import 'package:posproject/Models/ServiceLayerModel/SAPStockRequest/SapStkRequestModel.dart';

class StockReqPostiModel {
  int lineNum;
  String ItemCode;
  String ItemDescription;
  int Quantity;
  String Currency;
  String toWarehouseCode;
  String? FromWarehouseCode;
  StockReqPostiModel(
      {required this.Currency,
      required this.FromWarehouseCode,
      required this.ItemCode,
      required this.ItemDescription,
      required this.Quantity,
      required this.toWarehouseCode,
      required this.lineNum});
  Map<String, dynamic> tojson() {
    Map<String, String> map = {
      "ItemCode": ItemCode.toString(),
      "ItemDescription": ItemDescription,
      "LineNum": lineNum.toString(),
      "Quantity": Quantity.toString(),
      "Currency": Currency,
      "FromWarehouseCode":FromWarehouseCode!,
      "WarehouseCode": toWarehouseCode.toString(),
    };
    return map;
  }
}
