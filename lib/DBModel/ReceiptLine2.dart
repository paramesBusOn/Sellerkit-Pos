// // ignore_for_file: non_constant_identifier_names

const String tableReceiptLine2 = "ReceiptLine2";

class ReceiptLine2T {
  static String docentry = "docentry";
  static String lineId = "lineId";

  static String rcdocentry = "rcdocentry";
  static String branch = "branch";
  static String terminal = "terminal";
  static String rcnumber = "rcnumber";
  static String rcdatetime = "rcdatetime";
  static String rcmode = "rcmode";
  static String rcamount = "rcamount";
  static String reference = 'reference';
  static String chequeno = 'chequeno';
  static String chequedate = 'chequedate';
  static String remarks = 'remarks';
  static String amt = 'amt';
  static String Ref2 = "Ref2";
  static String Ref3 = "Ref3";
  static String Ref4 = "Ref4";
  static String Ref5 = 'Ref5';
  static String VouchCode = 'VouchCode';
  static String VouchCode2 = 'VouchCode2';
  static String cardterminal = 'cardterminal';
  static String cardApprno = 'cardApprno';
  // static String cardref = 'cardref';
  static String wallettype = 'wallettype';
  static String walletid = 'walletid';
  // static String walletref = 'walletref';
  static String transtype = 'transtype';
  // static String transref = 'transref';
  static String coupontype = 'coupontype';
  static String couponcode = 'couponcode';
  static String availablept = 'availablept';
  static String redeempoint = 'redeempoint';
  static String discounttype = 'discounttype';
  static String discountcode = 'discountcode';
  // static String creditref = 'creditref';
  static String recoverydate = 'recoverydate';
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class ReceiptLine2TDB {
  String? lineId;
  String? docentry;
  String? rcdocentry;
  String? rcnumber;
  String? rcdatetime;
  String? rcmode;
  String? terminal;
  String? branch;
  String? reference;
  String? rcamount;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  String? chequeno;
  String? chequedate;
  String? remarks;
  String? amt;
  String? cardterminal;
  String? cardApprno;
  // String? cardref;
  String? wallettype;
  String? walletid;
  // String? walletref;
  String? transtype;
  // String? transref;
  String? coupontype;
  String? couponcode;
  String? availablept;
  String? redeempoint;
  String? discounttype;
  String? discountcode;
  // String? creditref;
  String? recoverydate;
  String? Ref2;
  String? Ref3;
  String? Ref4;
  String? Ref5;
  String? VouchCode;
  String? VouchCode2;
  ReceiptLine2TDB(
      {required this.createdUserID,
      required this.createdateTime,
      required this.docentry,
      required this.lineId,
      required this.lastupdateIp,
      required this.rcamount,
      required this.rcdatetime,
      required this.rcdocentry,
      required this.rcmode,
      required this.rcnumber,
      required this.updatedDatetime,
      required this.updateduserid,
      required this.reference,
      this.amt,
      required this.branch,
      required this.terminal,
      required this.Ref2,
      required this.Ref3,
      required this.Ref4,
      required this.Ref5,
      required this.VouchCode,
      required this.VouchCode2,
      required this.availablept,
      required this.cardApprno,
      // required this.cardref,
      required this.cardterminal,
      required this.chequedate,
      required this.chequeno,
      required this.couponcode,
      required this.coupontype,
      // required this.creditref,
      required this.discountcode,
      required this.discounttype,
      required this.recoverydate,
      required this.redeempoint,
      required this.remarks,
      // required this.transref,
      required this.transtype,
      required this.walletid,
      // required this.walletref,
      required this.wallettype});
  factory ReceiptLine2TDB.fromjson(Map<String, dynamic> resp) {
    return ReceiptLine2TDB(
        createdUserID: resp['createdUserID'].toString(),
        createdateTime: resp['createdateTime'],
        docentry: resp['docentry'].toString(),
        lineId: resp['lineId'].toString(),
        lastupdateIp: resp['lastupdateIp'],
        rcamount: resp['rcamount'].toString(),
        rcdatetime: resp['rcdatetime'],
        rcdocentry: resp['rcdocentry'].toString(),
        rcmode: resp['rcmode'],
        rcnumber: resp['rcnumber'],
        updatedDatetime: resp['updatedDatetime'],
        updateduserid: resp['updateduserid'].toString(),
        reference: resp['reference'],
        branch: resp['branch'],
        terminal: resp['terminal'],
        Ref2: resp['Ref2'],
        Ref3: resp['Ref3'],
        Ref4: resp['Ref4'],
        Ref5: resp['Ref5'],
        VouchCode: resp['VouchCode'],
        VouchCode2: resp['VouchCode2'],
        availablept: resp['availablept'],
        cardApprno: resp['cardApprno'],
        cardterminal: resp['cardterminal'],
        chequedate: resp['chequedate'],
        chequeno: resp['chequeno'],
        couponcode: resp['couponcode'],
        coupontype: resp['coupontype'],
        discountcode: resp['discountcode'],
        discounttype: resp['discounttype'],
        recoverydate: resp['recoverydate'],
        redeempoint: resp['redeempoint'],
        remarks: resp['remarks'],
        transtype: resp['transtype'],
        walletid: resp['walletid'],
        wallettype: resp['wallettype']);
  }

  Map<String, Object?> toMap(int docentry) => {
        ReceiptLine2T.createdUserID: createdUserID,
        ReceiptLine2T.createdateTime: createdateTime,
        ReceiptLine2T.docentry: docentry,
        ReceiptLine2T.lineId: lineId,
        ReceiptLine2T.lastupdateIp: lastupdateIp,
        ReceiptLine2T.rcamount: rcamount,
        ReceiptLine2T.rcdatetime: rcdatetime,
        ReceiptLine2T.rcdocentry: rcdocentry,
        ReceiptLine2T.rcmode: rcmode,
        ReceiptLine2T.rcnumber: rcnumber,
        ReceiptLine2T.updatedDatetime: updatedDatetime,
        ReceiptLine2T.updateduserid: updateduserid,
        ReceiptLine2T.amt: amt,
        ReceiptLine2T.branch: branch,
        ReceiptLine2T.terminal: terminal,
        ReceiptLine2T.reference: reference,
        ReceiptLine2T.availablept: availablept,
        ReceiptLine2T.cardApprno: cardApprno,
        // ReceiptLine2T.cardref: cardref,
        ReceiptLine2T.cardterminal: cardterminal,
        ReceiptLine2T.chequedate: chequedate,
        ReceiptLine2T.chequeno: chequeno,
        ReceiptLine2T.couponcode: couponcode,
        ReceiptLine2T.coupontype: coupontype,
        // ReceiptLine2T.creditref: creditref,
        ReceiptLine2T.discountcode: discountcode,
        ReceiptLine2T.discounttype: discounttype,
        ReceiptLine2T.recoverydate: recoverydate,
        ReceiptLine2T.redeempoint: redeempoint,
        ReceiptLine2T.remarks: remarks,
        // ReceiptLine2T.transref: transref,
        ReceiptLine2T.transtype: transtype,
        ReceiptLine2T.walletid: walletid,
        // ReceiptLine2T.walletref: walletref,
        ReceiptLine2T.Ref2: Ref2,
        ReceiptLine2T.Ref3: Ref3,
        ReceiptLine2T.Ref4: Ref4,
        ReceiptLine2T.Ref5: Ref5,
        ReceiptLine2T.VouchCode: VouchCode,
        ReceiptLine2T.VouchCode2: VouchCode2,
        ReceiptLine2T.wallettype: wallettype
      };
}





// const String tableReceiptLine2 = "ReceiptLine2";

// class ReceiptLine2T {
//   static String docentry = "docentry";
//   static String rc_entry = "rc_entry";
//   static String ModeofPay = "ModeofPay";
//   static String Amount = "Amount";
//   static String TransRef = "TransRef";
  // static String Ref2 = "Ref2";
  // static String Ref3 = "Ref3";
  // static String Ref4 = "Ref4";
  // static String Ref5 = 'Ref5';
  // static String VouchCode = 'VouchCode';
  // static String VouchCode2 = 'VouchCode2';
//   static String RefAmt = 'RefAmt';
//   static String PointAmt = 'PointAmt';
//   static String ReedemAmt = 'ReedemAmt';
//   static String createdateTime = 'createdateTime';
//   static String updatedDatetime = "UpdatedDatetime";
//   static String createdUserID = "createdUserID";
//   static String updateduserid = "updateduserid";
//   static String lastupdateIp = "lastupdateIp";
// }

// class ReceiptLine2TDB {
//   int? docentry;
//   String? rc_entry;
//   String ?ModeofPay;
//   String ?Amount;
//   String ?TransRef;
  // String ?Ref2;
  // String? Ref3 ;
  // String? Ref4;
  // String? Ref5;
  // String? VouchCode ;
  // String? VouchCode2 ;
//   String? RefAmt ;
//   String? PointAmt;
//   String? ReedemAmt ;
//   String? createdateTime ;
//   String? updatedDatetime ;
//   String? createdUserID ;
//   String? updateduserid;
//   String? lastupdateIp ;

//   ReceiptLine2TDB({
//    required this.Amount,
//    required this.ModeofPay,
//    required this.PointAmt,
//    required this.ReedemAmt,
//    required this.Ref2,
//    required this.Ref3,
//    required this.Ref4,
//    required this.Ref5,
//    required this.RefAmt,
//    required this.TransRef,
  //  required this.VouchCode,
  //  required this.VouchCode2,
//    required this.createdUserID,
//    required this.createdateTime,
//    required this.docentry,
//    required this.lastupdateIp,
//    required this.rc_entry,
//    required this.updatedDatetime,
//    required this.updateduserid
//       });

//   Map<String, Object?> toMap() => {
//       ReceiptLine2T.Amount:Amount,
//       ReceiptLine2T.ModeofPay:ModeofPay,
//       ReceiptLine2T.PointAmt:PointAmt,
//       ReceiptLine2T.ReedemAmt:ReedemAmt,
      // ReceiptLine2T.Ref2:Ref2,
      // ReceiptLine2T.Ref3:Ref3,
      // ReceiptLine2T.Ref4:Ref4,
      // ReceiptLine2T.Ref5:Ref5,
//       ReceiptLine2T.RefAmt:RefAmt,
//       ReceiptLine2T.TransRef:TransRef,
      // ReceiptLine2T.VouchCode:VouchCode,
      // ReceiptLine2T.VouchCode2:VouchCode2,
//       ReceiptLine2T.createdUserID:createdUserID,
//       ReceiptLine2T.createdateTime:createdateTime,
//       ReceiptLine2T.docentry:docentry,
//       ReceiptLine2T.lastupdateIp:lastupdateIp,
//       ReceiptLine2T.rc_entry:rc_entry,
//       ReceiptLine2T.updatedDatetime:updatedDatetime,
//       ReceiptLine2T.updateduserid:updateduserid
//       };
// }
