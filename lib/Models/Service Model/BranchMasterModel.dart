import 'dart:convert';

class BarnchMasterModel {
  List<BranchMasterData>? branchdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  BarnchMasterModel(
      {required this.branchdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory BarnchMasterModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = jsonDecode(jsons["data"]) as List;
      List<BranchMasterData> dataList =
          list.map((data) => BranchMasterData.fromJson(data)).toList();
      return BarnchMasterModel(
          branchdata: dataList,
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return BarnchMasterModel(
          branchdata: null,
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory BarnchMasterModel.error(String jsons, int stcode) {
    return BarnchMasterModel(
        branchdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class BranchMasterData {
  String? whsCode;
  String? whsName;
  String? priceList;
  String? customerGroup;
  String? cashAccount;
  String? creditAccount;
  String? chequeAccount;
  String? transFerAccount;
  String? customerAcct;
  String? disAcct1;
  String? disAcct2;
  String? creditCard;
  String? stateCode;
  String? gSTNo;
  String? location;
  String? companyName;
  String? companyHeader;
  String? e_Mail;
  String? cOGSAcct;
  String? pAN;
  String? address1;
  String? address2;
  String? city;
  String? pincode;

  BranchMasterData({
    required this.whsCode,
    required this.whsName,
    required this.priceList,
    required this.customerGroup,
    required this.cashAccount,
    required this.creditAccount,
    required this.chequeAccount,
    required this.transFerAccount,
    required this.customerAcct,
    required this.disAcct1,
    required this.disAcct2,
    required this.creditCard,
    required this.stateCode,
    required this.gSTNo,
    required this.location,
    required this.companyName,
    required this.companyHeader,
    required this.e_Mail,
    required this.cOGSAcct,
    required this.pAN,
    required this.address1,
    required this.address2,
    required this.city,
    required this.pincode,
  });
  factory BranchMasterData.fromJson(Map<String, dynamic> json) =>
      BranchMasterData(
          whsCode: json['WhsCode'] ?? '',
          whsName: json['WhsName'] ?? '',
          priceList: json['PriceList'] ?? '',
          customerGroup: json['CustomerGroup'] ?? '',
          cashAccount: json['CashAccount'] ?? '',
          creditAccount: json['CreditAccount'] ?? '',
          chequeAccount: json['ChequeAccount'] ?? '',
          transFerAccount: json['TransFerAccount'] ?? '',
          customerAcct: json['CustomerAcct'] ?? '',
          disAcct1: json['DisAcct1'] ?? '',
          disAcct2: json['DisAcct2'] ?? '',
          creditCard: json['CreditCard'] ?? '',
          stateCode: json['StateCode'] ?? '',
          gSTNo: json['GSTNo'] ?? '',
          location: json['Location'] ?? '',
          companyName: json['CompanyName'] ?? '',
          companyHeader: json['CompanyHeader'] ?? '',
          e_Mail: json['E_Mail'] ?? '',
          cOGSAcct: json['COGSAcct'] ?? '',
          pAN: json['PAN'] ?? '',
          address1: json['Address1'] ?? '',
          address2: json['Address2'] ?? '',
          city: json['City'] ?? '',
          pincode: json['Pincode'] ?? '');
}
