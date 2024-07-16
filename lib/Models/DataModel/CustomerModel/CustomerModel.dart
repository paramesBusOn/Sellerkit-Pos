class CustomerDetals {
  String? customerSeriesNo;
  String? autoId;
  String? docentry;
  String? custRefNum;

  String? basedocnum;
  String? cardCode;
  String? phNo;
  String? name;
  List<Address>? address;
  double? accBalance;
  String? tarNo;
  String? email;
  String? point;
  String? tinno;
  String? vatregno;
  String? invoicenum;
  String? uDeviceId;
  String? uOrderDate;
  String? uOrderType;
  String? uGPApproval;
  String? uReceivedTime;
  String? invoiceDate;
  double? totalPayment;
  CustomerDetals(
      {this.name,
      this.custRefNum,
      this.customerSeriesNo,
      this.autoId,
      this.phNo,
      this.tinno,
      this.vatregno,
      this.docentry,
      this.cardCode,
      this.accBalance,
      this.point,
      this.address,
      this.tarNo,
      this.email,
      this.invoicenum,
      this.invoiceDate,
      this.uDeviceId,
      this.uOrderDate,
      this.uOrderType,
      this.uGPApproval,
      this.uReceivedTime,
      this.totalPayment});
}

class Address {
  int? autoId;
  String? addresstype;
  String? custcode;
  String? address1;
  String? address2;
  String? address3;
  String billCity;
  String billstate;
  String billPincode;
  String billCountry;
  Address({
    this.autoId,
    this.address1,
    this.address2,
    this.address3,
    this.custcode,
    this.addresstype,
    required this.billCity,
    required this.billCountry,
    required this.billPincode,
    required this.billstate,
  });
}

class ShipAddress {
  int? autoId;
  String? addresstype;
  String? custcode;
  String? address1;
  String? address2;
  String? address3;
  String shipCity;
  String shipstate;
  String shipPincode;
  String shipCountry;
  ShipAddress({
    this.autoId,
    required this.address1,
    this.address2,
    this.address3,
    this.custcode,
    this.addresstype,
    required this.shipCity,
    required this.shipCountry,
    required this.shipPincode,
    required this.shipstate,
  });
}
