// ignore_for_file: non_constant_identifier_names

class StockOutwardList {
  String? docentry;
  String? baceDocentry;
  String? sapbaceDocentry;

  String? remarks;
  String? branch;
  // int? reqdocno;
  // String? reqdocseries;
  // int? reqdocseriesno;
  String? reqtransdate;
  // String? reqdoctime;
  // String? reqsystime;
  String? documentno;
  // int? seresid;
  // int? seriesnum;
  // String? transactiondate;
  // String? transtime;
  // String? sysdatetime;
  String? reqfromWhs;
  String? reqtoWhs;
  // int? totalitems;
  // double? totalweight;
  // double? totalqty;
  // double? totalltr;
  // String? isagainstorder;
  // String? isagainststock;
  String? docstatus;
  // String? salesexec;
  // String? createdateTime;
  // String? updatedDatetime;
  // int? createdUserID;
  // int? updateduserid;
  // String? lastupdateIp;
  // int?scanToatal;
  // int? transTotal;
  List<StockOutwardDetails> data;

  StockOutwardList(
      {required this.branch,
      // required this.createdUserID,
      // required this.createdateTime,
      required this.baceDocentry,
      this.docentry,
      required this.docstatus,
      required this.documentno,
      required this. sapbaceDocentry,
      // required this.isagainstorder,
      // required this.isagainststock,
      // required this.lastupdateIp,
      // required this.reqdocno,
      // required this.reqdocseries,
      // required this.reqdocseriesno,
      // required this.reqdoctime,
      required this.reqfromWhs,
      // required this.reqsystime,
      required this.remarks,
      required this.reqtoWhs,
      required this.reqtransdate,
      // required this.salesexec,
      // required this.seresid,
      // required this.seriesnum,
      // required this.sysdatetime,
      // required this.totalitems,
      // required this.totalltr,
      // required this.totalqty,
      // required this.totalweight,
      // required this.transactiondate,
      // required this.transtime,
      // required this.updatedDatetime,
      // required this.updateduserid,
      // this.scanToatal,
      // this.transTotal,

      required this.data});
}

class StockOutwardDetails {
  int? docentry;
  int? baseDocentry;
  int? baseDocline;

  int? lineNo;
  String? itemcode;
  String? serialBatch;
  String? dscription;
  int? qty;
  double? price;
  double? taxRate;
  String? taxType;
  String? status;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;
  int? balQty;
  int? Scanned_Qty = 0;
  int? trans_Qty;
  // String? serialbatch;
  List<StockOutSerialbatch>? serialbatchList;

  StockOutwardDetails(
      {required this.createdUserID,
      required this.createdateTime,
      this.docentry,
      this.balQty,
      required this.baseDocline,
      required this.dscription,
      required this.itemcode,
      required this.lastupdateIp,
      required this.lineNo,
      required this.qty,
      required this.baseDocentry,
      this.serialbatchList,
      required this.status,
      required this.updatedDatetime,
      required this.updateduserid,
      required this.price,
      required this.serialBatch,
      required this.taxRate,
      required this.taxType,
      this.Scanned_Qty,
      this.trans_Qty});
}

class StockOutSerialbatch {
  String? docentry;
  String? baseDocentry;
  String? lineno;
  String? itemcode;
  int? qty;
  // int? openQty;
  String? serialbatch;
  String? docstatus;
  bool? scanbool = false;
  int? scannedQty;

  StockOutSerialbatch(
      {required this.lineno,
      this.docentry,
      required this.itemcode,
      required this.qty,
      this.scanbool,
      this.docstatus,
      required this.baseDocentry,
      required this.serialbatch});
}
