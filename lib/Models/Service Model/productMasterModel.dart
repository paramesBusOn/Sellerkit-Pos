// ignore_for_file: non_constant_identifier_names, prefer_if_null_operators

import 'dart:convert';

class ProductMasterModel {
  List<ProductMasterModelData>? itemdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ProductMasterModel(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ProductMasterModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = jsonDecode(jsons["data"]) as List;
      List<ProductMasterModelData> dataList =
          list.map((data) => ProductMasterModelData.fromJson(data)).toList();
      return ProductMasterModel(
          itemdata: dataList,
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return ProductMasterModel(
          itemdata: null,
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory ProductMasterModel.error(String jsons, int stcode) {
    return ProductMasterModel(
        itemdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ProductMasterModelData {
  int? autoId;
  String? itemcode;
  String? itemnamelong;
  String? itemnameshort;
  String? skucode;
  double? sellprice;
  double? mrpprice;
  int? quantity;
  String? brand;
  String? category;
  String? subcategory;
  String? hsnsac;
  double? taxrate;
  String? isinventory;
  String? isfreeby;
  String? isActive;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  String? isserialBatch;
  String? issellpricebyscrbat;
  double? maxdiscount;
  int? maximumQty;
  int? minimumQty;
  double? weight;
  double? liter;
  int? displayQty;
  String? searchString;
double? uPackSize;
  int? uTINSPERBOX;
   String? uPackSizeuom;
  double? uSpecificGravity;
  ProductMasterModelData({
     required this.uPackSize,
      required this.uTINSPERBOX,
      required this.uSpecificGravity,
     required this.uPackSizeuom,
    required this.autoId,
    required this.maximumQty,
    required this.minimumQty,
    required this.weight,
    required this.liter,
    required this.displayQty,
    required this.searchString,
    required this.brand,
    required this.category,
    this.quantity,
    required this.createdUserID,
    required this.createdateTime,
    required this.mrpprice,
    required this.sellprice,
    required this.hsnsac,
    required this.isActive,
    required this.isfreeby,
    required this.isinventory,
    required this.issellpricebyscrbat,
    required this.isserialBatch,
    required this.itemcode,
    required this.itemnamelong,
    required this.itemnameshort,
    required this.lastupdateIp,
    required this.maxdiscount,
    required this.skucode,
    required this.subcategory,
    required this.taxrate,
    required this.updatedDatetime,
    required this.updateduserid,
  });
// {\"itemname\":\"2K EPOXY HARDNER - 1LTR\",\"itemcode\":\"10000019E\",\"maximumQty\":\"10\",
//\"minimumQty\":\"100\",\"displayQty\":\"10\",\"searchString\":\"10000019E,2K EPOXY HARDNER - 1LTR,2K EPOXY HARDNER - 1LTR,GALAXY\",
//\"category\":\"\",\"BRAND\":\"GALAXY\",\"liter\":1.000000,\"category1\":\"\",\"BRAND1\":\"GALAXY\",
//\"weight\":0.000000,\"hsnsac\":\"\",\"isActive\":\"N\",\"isfreeby\":\"FALSE\",\"isinventory\":\"TRUE\",
//\"issellpricebyscrbat\":\"FALSE\",\"itemnamelong\":\"10000019E,2K EPOXY HARDNER - 1LTR,2K EPOXY HARDNER - 1LTR,GALAXY\",
//\"taxrate\":18.000000,\"itemnameshort\":\"2K EPOXY HARDNER - 1LTR\",\"skucode\":\"10000019E\",\"subcategory\":\"\",
//\"sellprice\":17500.000000,\"mrpprice\":17500.000000,\"specialprice\":17500.000000,\"maxdiscount\":\"50\",
//\"snapdatetime\":\"2023-08-22T12:27:06.46\",\"purchasedate\":\"2023-08-22T12:27:06.46\",
//\"createdateTime\":\"2023-08-22T12:27:06.46\",\"updatedDatetime\":\"2023-08-22T12:27:06.46\",\"createdUserID\":\"1\",
//\"updateduserid\":\"1\",\"lastupdateIp\":\"\"}

  factory ProductMasterModelData.fromJson(Map<String, dynamic> json) =>
      ProductMasterModelData(
        autoId:
            json['AutoId'] == null ? 0 : int.parse(json['AutoId'].toString()),
        maximumQty: json['maximumQty'] == null
            ? 0
            : int.parse(json['maximumQty'].toString()),
        minimumQty: json['minimumQty'] == null
            ? 0
            : int.parse(json['minimumQty'].toString()),
        weight: json['weight'] == null ? 0.00 : json['weight'],
        liter: json['weight'] == null ? 0.00 : json['liter'],
        displayQty: json['displayQty'] == null
            ? 0
            : int.parse(json['displayQty'].toString()),
        searchString: json['searchString'] ?? '',
        createdUserID: json['createdUserID'] ?? '',
        createdateTime: json['createdateTime'] ?? '',
        lastupdateIp: json['lastupdateIp'] ?? '',
        brand: json['BRAND1'] ?? '',
        category: json['category'] ?? '',
        // quantity: json['quantity'] == null
        //     ? 0
        //     : int.parse(json['quantity'].toString()),
        updatedDatetime: json['updatedDatetime'] ?? '',
        updateduserid: json['updateduserid'] ?? '',
        mrpprice: json['mrpprice'],
        sellprice: json['sellprice'] == null ? "" : json['sellprice'],
        taxrate: json['taxrate'] == null ? "" : json['taxrate'],
        hsnsac: json['hsnsac'] ?? '',
        isActive: json['isActive'] ?? '',
        subcategory: json['subcategory'] ?? '',
        skucode: json['skucode'] ?? '',
        isfreeby: json['isfreeby'] ?? '',
        isinventory: json['isinventory'] ?? '',
        issellpricebyscrbat: json['issellpricebyscrbat'].toString(),
        isserialBatch:
            json['is_serialBatch'] == null ? "" : json['is_serialBatch'],
        itemcode: json['itemcode'] ?? '',
        itemnamelong: json['itemnamelong'] ?? '',
        maxdiscount: json['maxdiscount'] == null
            ? 0.00
            : double.parse(json['maxdiscount'].toString()),
        itemnameshort: json['itemnameshort'] ?? '',
         uPackSize: json['U_Pack_Size'],
        uTINSPERBOX: json['U_TINS_PER_BOX'],
        uSpecificGravity: json['U_Specific_Gravity'],
        uPackSizeuom: json['U_Pack_Size_uom'].toString(),
      );

  // Map<String, Object?> toMap() => {
  //       PosColumn.branch: Branch,
  //       PosColumn.itemCode: ItemCode,
  //       PosColumn.itemName: ItemName,
  //       PosColumn.transId: TransID,
  //       PosColumn.serialBatch: SerialBatch,
  //       PosColumn.qty: Qty,
  //       PosColumn.openQty: OpenQty,
  //       PosColumn.venCode: VenCode,
  //       PosColumn.venName: VenName,
  //       PosColumn.inDate: Branch,
  //       PosColumn.inType: ItemCode,
  //       PosColumn.sellPrice: SellPrice,
  //       PosColumn.mrp: MRP,
  //       PosColumn.cost: Cost,
  //       PosColumn.taxRate: TaxRate,
  //       PosColumn.taxType: TaxType,
  //     };
}
