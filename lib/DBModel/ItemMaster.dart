const String tableItemMaster = "ItemMaster";

class ItemMasterT {
  static String autoId = "AutoId";
  static String itemcode = "Itemcode";
  static String itemnamelong = "itemname_long";
  static String itemnameshort = "itemname_short";
  static String skucode = "skucode";
  static String brand = "brand";
  static String category = "category";
  static String subcategory = "subcategory";
  static String hsnsac = "hsn_sac";
  static String taxrate = "taxrate";
  static String isinventory = "is_inventory";
  static String isfreeby = "is_freeby";
  static String isActive = "is_Active";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
  static String isserialBatch = 'is_serialBatch';
  static String issellpricebyscrbat = "is_sellpricebyscrbat";
  static String maxdiscount = "maxdiscount";
  static String quantity = "quantity";
  static String minimumQty = "minimumQty";
  static String maximumQty = "maximumQty";
  static String weight = "weight";
  static String liter = "liter";
  static String displayQty = "displayQty";
  static String searchString = "searchString";
  static String sellprice = "sellprice";
  static String mrpprice = "mrpprice";
  static String isselected = "IsSelected";
   static String uPackSize = "UPackSize";
  static String uTINSPERBOX = "UTINSPERBOX";
  static String uSpecificGravity = "USpecificGravity";
   static String  uPackSizeuom="UPackSizeUom";
}

class ItemMasterModelDB {
  int? autoId;
  String? itemcode;
  String? itemnamelong;
  String? itemnameshort;
  String? skucode;
  String? sellprice;
  String? mrpprice;
  int? quantity;
  String? brand;
  String? category;
  String? subcategory;
  String? hsnsac;
  String? taxrate;
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
  int? isselected;
  String uPackSize;
  int uTINSPERBOX;
  String uSpecificGravity;
   String?  uPackSizeuom;
  ItemMasterModelDB({
    required this.isselected,
    required this.autoId,
    required this.maximumQty,
    required this.minimumQty,
    required this.weight,
    required this.liter,
    required this.displayQty,
    required this.searchString,
    required this.brand,
    required this.category,
    required this.quantity,
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
    required this.uPackSizeuom,
    required this.uPackSize,
    required this.uTINSPERBOX,
    required this.uSpecificGravity,
  });

  factory ItemMasterModelDB.fromMap(Map<String, dynamic> item) =>
      ItemMasterModelDB(
        autoId: item['autoId'],
        quantity: item['autoId'],
        brand: item['autoId'],
        category: item['autoId'],
        createdUserID: item['autoId'],
        createdateTime: item['autoId'],
        hsnsac: item['autoId'],
        isActive: item['autoId'],
        isfreeby: item['autoId'],
        isinventory: item['autoId'],
        issellpricebyscrbat: item['autoId'],
        isserialBatch: item['autoId'],
        itemcode: item['autoId'],
        itemnamelong: item['autoId'],
        itemnameshort: item['autoId'],
        lastupdateIp: item['autoId'],
        maxdiscount: item['autoId'],
        skucode: item['autoId'],
        subcategory: item['autoId'],
        taxrate: item['autoId'],
        sellprice: item['autoId'],
        mrpprice: item['autoId'],
        updatedDatetime: item['autoId'],
        updateduserid: item['autoId'],
        minimumQty: item['autoId'],
        maximumQty: item['autoId'],
        displayQty: item['autoId'],
        searchString: item['autoId'],
        weight: item['autoId'],
        isselected: item['autoId'],
        liter: item['autoId'],

        uTINSPERBOX: item['autoId'],
        uPackSizeuom: item['autoId'],
        uPackSize: item['autoId'],
        uSpecificGravity: item['autoId'],
      );

  Map<String, Object?> toMap() => {
        ItemMasterT.autoId: autoId,
        ItemMasterT.brand: brand,
        ItemMasterT.quantity: quantity,
        ItemMasterT.category: category,
        ItemMasterT.createdUserID: createdUserID,
        ItemMasterT.createdateTime: createdateTime,
        ItemMasterT.hsnsac: hsnsac,
        ItemMasterT.isActive: isActive,
        ItemMasterT.isfreeby: isfreeby,
        ItemMasterT.isinventory: isinventory,
        ItemMasterT.issellpricebyscrbat: issellpricebyscrbat,
        ItemMasterT.isserialBatch: isserialBatch,
        ItemMasterT.itemcode: itemcode,
        ItemMasterT.itemnamelong: itemnamelong,
        ItemMasterT.itemnameshort: itemnameshort,
        ItemMasterT.lastupdateIp: lastupdateIp,
        ItemMasterT.maxdiscount: maxdiscount,
        ItemMasterT.skucode: skucode,
        ItemMasterT.subcategory: subcategory,
        ItemMasterT.taxrate: taxrate,
        ItemMasterT.sellprice: sellprice,
        ItemMasterT.mrpprice: mrpprice,
        ItemMasterT.updatedDatetime: updatedDatetime,
        ItemMasterT.updateduserid: updateduserid,
        ItemMasterT.minimumQty: minimumQty,
        ItemMasterT.maximumQty: maximumQty,
        ItemMasterT.displayQty: displayQty,
        ItemMasterT.searchString: searchString,
        ItemMasterT.weight: weight,
        ItemMasterT.liter: liter,
        ItemMasterT.isselected: isselected,
        ItemMasterT.uPackSizeuom:uPackSizeuom,
        ItemMasterT.uPackSize: uPackSize,
        ItemMasterT.uTINSPERBOX: uTINSPERBOX,
        ItemMasterT.uSpecificGravity: uSpecificGravity,
      };
}
