// ignore_for_file: non_constant_identifier_names

class StockInwardList {
  String? docentry;
  String? baceDocentry;
  String? sapbaceDocentry;

  String? branch;
  String? remarks;
String? reqdocumentno;
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
  List<StockInwardDetails> data;

  StockInwardList(
      {required this.branch,
      this.remarks,
      // required this.createdUserID,
      // required this.createdateTime,
      required this.docentry,
      required this.docstatus,
      required this.documentno,
       this.reqdocumentno,

      // required this.isagainstorder,
      // required this.isagainststock,
      // required this.lastupdateIp,
      // required this.reqdocno,
      // required this.reqdocseries,
      // required this.reqdocseriesno,
      // required this.reqdoctime,
      required this.reqfromWhs,
      // required this.reqsystime,
      required this.reqtoWhs,
      required this.baceDocentry,
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
      // r,
      required this.data});
}

class StockInwardDetails {
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
  int? Scanned_Qty = 0;
  int? trans_Qty;
  List<StOutSerialbatch>? StOutSerialbatchList;

  // String? serialbatch;
  List<StockInSerialbatch>? serialbatchList;

  StockInwardDetails(
      {required this.createdUserID,
      required this.createdateTime,
      this.docentry,
      required this.baseDocline,
      required this.dscription,
      required this.itemcode,
      required this.lastupdateIp,
      required this.lineNo,
      required this.qty,
      required this.baseDocentry,
      this.serialbatchList,
       this.StOutSerialbatchList,
      required this.status,
       this.updatedDatetime,
      required this.updateduserid,
      required this.price,
      required this.serialBatch,
      required this.taxRate,
      required this.taxType,
      this.Scanned_Qty,
      this.trans_Qty});
}

class StockInSerialbatch {
  String? baseDocentry;
  String? docentry;
  String? lineno;
  String? itemcode;
  int? qty;
  String? serialbatch;
  String? docstatus;
  bool? scanbool = false;
  int? scannedQty;

  StockInSerialbatch(
      {required this.lineno,
      required this.docentry,
      required this.baseDocentry,
      required this.itemcode,
      required this.qty,
      this.scanbool,
      this.docstatus,
      // required this.scannedQty,
      required this.serialbatch});
}

class StOutSerialbatch {
  String? baseDocentry;
  String? docentry;
  String? lineno;
  String? itemcode;
  int? qty;
  String? serialbatch;
  String? docstatus;
  bool? scanbool = false;
  int? scannedQty;

  StOutSerialbatch(
      {required this.lineno,
      required this.docentry,
      required this.baseDocentry,
      required this.itemcode,
      required this.qty,
      this.scanbool,
      this.docstatus,
      // required this.scannedQty,
      required this.serialbatch});
}
