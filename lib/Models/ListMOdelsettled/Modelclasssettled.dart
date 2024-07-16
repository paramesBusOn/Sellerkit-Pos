// ignore_for_file: non_constant_identifier_names
class Paylist {
  String? ApprovelNo;
  String? Cardref;
  String? rupees;
  String? name;
  int? PhNo;
  String? Date;
  int? onchanged;
  bool? checkClr;
  String? ChequeNo;
  String? ChequeDate;
  String? walletname;
  String? couponname;
  String? payNo;
  String? cardType;
  String? amounthand;
  String? amountsettledoff;
  String? settlementaccount;
  String? paymode;
  String? paycardterminal;
  String? walletterminal;
  String? couponterminal;
  Paylist(
      {this.amounthand,
      this.amountsettledoff,
      this.settlementaccount,
      this.paymode,
      this.ApprovelNo,
      this.Cardref,
      this.rupees,
      this.name,
      this.onchanged,
      this.PhNo,
      this.Date,
      this.checkClr,
      this.ChequeNo,
      this.ChequeDate,
      this.walletname,
      this.payNo,
      this.couponname,
      this.cardType,
      this.paycardterminal,
      this.walletterminal,
      this.couponterminal});
}

class cashlist {
  String rcdocentry;
  String rcdoctno;
  String? basedoctype;
  String? basedocentry;
  String? baselineid;
  String? docentry;
  String? ApprovelNo;
  String? Cardref;
  String? rupees;
  String? name;
  int? PhNo;
  String? Date;
  int? onchanged;
  bool? checkClr;
  String? cardterminal;
  cashlist(
      {this.basedoctype,
      required this.rcdocentry,
      required this.rcdoctno,
      this.basedocentry,
      this.baselineid,
      this.docentry,
      this.ApprovelNo,
      this.Cardref,
      this.rupees,
      this.name,
      this.onchanged,
      this.PhNo,
      this.Date,
      this.checkClr,
      this.cardterminal});
}

class cardlist {
  String? basedoctype;
  String? basedocentry;
  String? baselineid;
  String? docentry;
  String ApprovelNo;
  String Cardref;
  String rupees;
  String name;
  int? PhNo;
  String Date;
  int? onchanged;
  bool? checkClr;
  String? cardterminal;
  cardlist(
      {this.basedoctype,
      this.docentry,
      this.basedocentry,
      this.baselineid,
      required this.ApprovelNo,
      required this.Cardref,
      required this.rupees,
      required this.name,
      this.onchanged,
      required this.PhNo,
      required this.Date,
      this.checkClr,
      this.cardterminal});
}

//cheque List
class chequelist {
  String rcdocentry;
  String rcdoctno;
  String? basedoctype;
  String? basedocentry;
  String? baselineid;
  String? docentry;
  String name;
  int PhNo;
  String rupees;
  String ChequeNo;
  String ChequeDate;
  String? docno;
  String? rcmode;
  int? onchanged;
  bool? checkClr;

  chequelist({
    this.docno,
    this.rcmode,
    this.basedoctype,
    this.docentry,
    this.basedocentry,
    this.baselineid,
    required this.rcdocentry,
    required this.rcdoctno,
    required this.name,
    required this.PhNo,
    required this.rupees,
    this.onchanged,
    required this.ChequeNo,
    required this.ChequeDate,
    this.checkClr,
  });
}

//wallet List
class walletlist {
  String? basedoctype;
  String? basedocentry;
  String? baselineid;
  String? docentry;
  String walletname;

  String rupees;
  String Date;
  String name;
  int PhNo;
  String payNo;

  int? onchanged;
  bool? checkClr;
  walletlist({
    this.basedoctype,
    this.docentry,
    this.basedocentry,
    this.baselineid,
    required this.walletname,
    required this.payNo,
    required this.rupees,
    required this.name,
    this.onchanged,
    required this.PhNo,
    required this.Date,
    this.checkClr,
  });
}

//Coupon List
class couponcodelist {
  String? basedoctype;
  String? docentry;
  String? basedocentry;
  String? baselineid;
  String couponname;

  String rupees;
  String Date;
  String name;
  int PhNo;
  String payNo;

  int? onchanged;
  bool? checkClr;

  couponcodelist({
    this.basedoctype,
    this.docentry,
    this.basedocentry,
    this.baselineid,
    required this.couponname,
    required this.payNo,
    required this.rupees,
    required this.name,
    this.onchanged,
    required this.PhNo,
    required this.Date,
    this.checkClr,
  });
}
