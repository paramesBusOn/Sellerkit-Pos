class ItemCodeListModel {
  ItemCodeListModel({
    this.basic,
    this.discount,
    this.taxvalue,
    this.netvalue,
    this.taxable,
    this.Maxdiscount,
    this.discountper,
    this.DocEntry,
    this.baselineid,
    this.Branch,
    this.ItemCode,
    this.ItemName,
    this.SerialBatch,
    this.OpenQty,
    this.Qty,
    this.specialprice,
    this.purchasedate,
    this.createdateTime,
    this.snapdatetime,
    this.updatedDatetime,
    this.createdUserID,
    this.lastupdateIp,
    this.updateduserid,
    this.InDate,
    this.InType,
    this.VenCode,
    this.VenName,
    this.MRP,
    this.SellPrice,
    this.Cost,
    this.TaxRate,
    this.TaxType,
    this.invoiceNo,
    this.liter,
    required this.uPackSize,
    required this.uTINSPERBOX,
    required this.uSpecificGravity,
     this.weight,
  });
  double? uPackSize;
  int? uTINSPERBOX;
  double? uSpecificGravity;
  String? Maxdiscount;
  double? basic;
  double? taxable;
  double? discount;
  double? taxvalue;
  double? netvalue;
  double? discountper;
  String? DocEntry;

  int? baselineid;
  String? Branch;
  String? ItemCode;
  String? ItemName;
  String? SerialBatch;
  int? OpenQty;
  int? Qty;
  String? InDate;
  String? InType;
  String? VenCode;
  String? VenName;
  double? MRP;
  double? SellPrice;
  double? specialprice;
  String? purchasedate;
  String? snapdatetime;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  int? Cost;
  double? TaxRate;
  String? TaxType;
  String? invoiceNo;
  double? liter;
  double? weight;
}
