// To parse this JSON data, do
//
//     final sapReceiptModel = sapReceiptModelFromJson(jsonString?);

import 'dart:convert';

import '../ErrorModell/ErrorModelSl.dart';

// SapReceiptModel sapReceiptModelFromJson(String? str) => SapReceiptModel.fromJson(json.decode(str));

// String? sapReceiptModelToJson(SapReceiptModel data) => json.encode(data.toJson());

class SapReceiptModel {
  int? stscode;
  ErrorModel? error;
 String? exception;
  // String? odataMetadata;
  int? docNum;
  int? docEntry;
  // String? docType;
  // int? cashSum;
  // String? docDate;
  // String? cardCode;
  // String? cardName;
  // String? checkAccount;
  // String? cashAccount;
  // dynamic transferAccount;
  // int? transferSum;
  // dynamic transferDate;
  // dynamic transferReference;
  List<PaymentCheck>? paymentChecks;
  List<PaymentInvoice>? paymentInvoices;
  // String? handWritten;
  // String? print?ed;

  // String? address;

  // String? docCurrency;

  // String? localCurrency;
  // int? docRate;
  // String? reference1;
  // dynamic reference2;
  // String? counterReference;
  // String? remarks;
  // String? journalRemarks;
  // String? splitTransaction;
  // dynamic contactPersonCode;
  // String? applyVat;
  // DateTime taxDate;
  // int? series;
  // dynamic bankCode;
  // dynamic bankAccount;
  // int? discountPercent;
  // dynamic projectCode;
  // String? currencyIsLocal;
  // int? deductionPercent;
  // int? deductionSum;
  // int? cashSumFc;
  // int? cashSumSys;
  // dynamic boeAccount;
  // int? billOfExchangeAmount;
  // dynamic billofExchangeStatus;
  // int? billOfExchangeAmountFc;
  // int? billOfExchangeAmountSc;
  // dynamic billOfExchangeAgent;
  // dynamic wtCode;
  // int? wtAmount;
  // int? wtAmountFc;
  // int? wtAmountSc;
  // dynamic wtAccount;
  // int? wtTaxableAmount;
  // String? proforma;
  // dynamic payToBankCode;
  // dynamic payToBankBranch;
  // dynamic payToBankAccountNo;
  // String? payToCode;
  // dynamic payToBankCountry;
  // String? isPayToBank;
  //
  // String? paymentPriority;
  // dynamic taxGroup;
  // int? bankChargeAmount;
  // int? bankChargeAmountInFc;
  // int? bankChargeAmountInSc;
  // int? underOverpaymentdifference;
  // int? underOverpaymentdiffSc;
  // int? wtBaseSum;
  // int? wtBaseSumFc;
  // int? wtBaseSumSc;
  // DateTime vatDate;
  // String? transactionCode;
  // String? paymentType;
  // int? transferRealAmount;
  // String? docObjectCode;
  // String? docTypte;
  // DateTime dueDate;
  // dynamic locationCode;
  // String? cancelled;
  // String? controlAccount;
  // int? underOverpaymentdiffFc;
  // String? authorizationStatus;
  // dynamic bplid;
  // dynamic bplName;
  // dynamic vatRegNum;
  // dynamic blanketAgreement;
  // String? paymentByWtCertif;
  // dynamic cig;
  // dynamic cup;
  // dynamic attachmentEntry;
  // dynamic uRefSeries;
  // dynamic uPrnNumber;
  // String? uDccIspl;
  // String? uDccco;
  // dynamic uint?Key;
  // dynamic uRvc;
  // dynamic uVat;

  // List<dynamic> paymentCreditCards;
  // List<dynamic> paymentAccounts;
  // List<dynamic> paymentDocumentReferencesCollection;
  // BillOfExchange billOfExchange;
  // List<dynamic> withholdingTaxCertificatesCollection;
  // List<dynamic> electronicProtocols;
  // List<dynamic> cashFlowAssignments;
  // List<dynamic> paymentsApprovalRequests;
  // List<dynamic> withholdingTaxDataWtxCollection;

  SapReceiptModel({
    required this.stscode,
    required this.error,
    this.exception,
    // required this.odataMetadata,
    required this.docNum,
    required this.docEntry,

    // required this.docType,
    // required this.handWritten,
    // required this.print?ed,
    // required this.docDate,
    // required this.cardCode,
    // required this.cardName,
    // // required this.address,
    // required this.cashAccount,
    // // required this.docCurrency,
    // required this.cashSum,
    // required this.checkAccount,
    // required this.transferAccount,
    // required this.transferSum,
    // required this.transferDate,
    // required this.transferReference,
    required this.paymentChecks,
    required this.paymentInvoices,
    // required this.localCurrency,
    // required this.docRate,
    // required this.reference1,
    // required this.reference2,
    // required this.counterReference,
    // required this.remarks,
    // required this.journalRemarks,
    // required this.splitTransaction,
    // required this.contactPersonCode,
    // required this.applyVat,
    // required this.taxDate,
    // required this.series,
    // required this.bankCode,
    // required this.bankAccount,
    // required this.discountPercent,
    // required this.projectCode,
    // required this.currencyIsLocal,
    // required this.deductionPercent,
    // required this.deductionSum,
    // required this.cashSumFc,
    // required this.cashSumSys,
    // required this.boeAccount,
    // required this.billOfExchangeAmount,
    // required this.billofExchangeStatus,
    // required this.billOfExchangeAmountFc,
    // required this.billOfExchangeAmountSc,
    // required this.billOfExchangeAgent,
    // required this.wtCode,
    // required this.wtAmount,
    // required this.wtAmountFc,
    // required this.wtAmountSc,
    // required this.wtAccount,
    // required this.wtTaxableAmount,
    // required this.proforma,
    // required this.payToBankCode,
    // required this.payToBankBranch,
    // required this.payToBankAccountNo,
    // required this.payToCode,
    // required this.payToBankCountry,
    // required this.isPayToBank,
    // required this.paymentPriority,
    // required this.taxGroup,
    // required this.bankChargeAmount,
    // required this.bankChargeAmountInFc,
    // required this.bankChargeAmountInSc,
    // required this.underOverpaymentdifference,
    // required this.underOverpaymentdiffSc,
    // required this.wtBaseSum,
    // required this.wtBaseSumFc,
    // required this.wtBaseSumSc,
    // required this.vatDate,
    // required this.transactionCode,
    // required this.paymentType,
    // required this.transferRealAmount,
    // required this.docObjectCode,
    // required this.docTypte,
    // required this.dueDate,
    // required this.locationCode,
    // required this.cancelled,
    // required this.controlAccount,
    // required this.underOverpaymentdiffFc,
    // required this.authorizationStatus,
    // required this.bplid,
    // required this.bplName,
    // required this.vatRegNum,
    // required this.blanketAgreement,
    // required this.paymentByWtCertif,
    // required this.cig,
    // required this.cup,
    // required this.attachmentEntry,
    // required this.uRefSeries,
    // required this.uPrnNumber,
    // required this.uDccIspl,
    // required this.uDccco,
    // required this.uint?Key,
    // required this.uRvc,
    // required this.uVat,

    // required this.paymentCreditCards,
    // required this.paymentAccounts,
    // required this.paymentDocumentReferencesCollection,
    // required this.billOfExchange,
    // required this.withholdingTaxCertificatesCollection,
    // required this.electronicProtocols,
    // required this.cashFlowAssignments,
    // required this.paymentsApprovalRequests,
    // required this.withholdingTaxDataWtxCollection,
  });

  factory SapReceiptModel.fromJson(Map<String?, dynamic> json, int? stsCodee) =>
      SapReceiptModel(
        stscode: stsCodee,
        error: null,
        // odataMetadata: json["odata.metadata"],
        docNum: json["DocNum"],
        // docType: json["DocType"],
        // handWritten: json["HandWritten"],
        // print?ed: json["Print?ed"],
        // docDate: json["DocDate"],
        // cardCode: json["CardCode"],
        // cardName: json["CardName"],
        // // address: json["Address"],
        // cashAccount: json["CashAccount"],
        // // docCurrency: json["DocCurrency"],
        // cashSum: json["CashSum"],
        // checkAccount: json["CheckAccount"],
        // transferAccount: json["TransferAccount"],
        // transferSum: json["TransferSum"],
        // transferDate: json["TransferDate"],
        // transferReference: json["TransferReference"],
        // localCurrency: json["LocalCurrency"],
        // docRate: json["DocRate"],
        // reference1: json["Reference1"],
        // reference2: json["Reference2"],
        // counterReference: json["CounterReference"],
        // remarks: json["Remarks"],
        // journalRemarks: json["JournalRemarks"],
        // splitTransaction: json["SplitTransaction"],
        // contactPersonCode: json["ContactPersonCode"],
        // applyVat: json["ApplyVAT"],
        // taxDate: DateTime.parse(json["TaxDate"]),
        // series: json["Series"],
        // bankCode: json["BankCode"],
        // bankAccount: json["BankAccount"],
        // discountPercent: json["DiscountPercent"],
        // projectCode: json["ProjectCode"],
        // currencyIsLocal: json["CurrencyIsLocal"],
        // deductionPercent: json["DeductionPercent"],
        // deductionSum: json["DeductionSum"],
        // cashSumFc: json["CashSumFC"],
        // cashSumSys: json["CashSumSys"],
        // boeAccount: json["BoeAccount"],
        // billOfExchangeAmount: json["BillOfExchangeAmount"],
        // billofExchangeStatus: json["BillofExchangeStatus"],
        // billOfExchangeAmountFc: json["BillOfExchangeAmountFC"],
        // billOfExchangeAmountSc: json["BillOfExchangeAmountSC"],
        // billOfExchangeAgent: json["BillOfExchangeAgent"],
        // wtCode: json["WTCode"],
        // wtAmount: json["WTAmount"],
        // wtAmountFc: json["WTAmountFC"],
        // wtAmountSc: json["WTAmountSC"],
        // wtAccount: json["WTAccount"],
        // wtTaxableAmount: json["WTTaxableAmount"],
        // proforma: json["Proforma"],
        // payToBankCode: json["PayToBankCode"],
        // payToBankBranch: json["PayToBankBranch"],
        // payToBankAccountNo: json["PayToBankAccountNo"],
        // payToCode: json["PayToCode"],
        // payToBankCountry: json["PayToBankCountry"],
        // isPayToBank: json["IsPayToBank"],
        docEntry: json["DocEntry"],
        // paymentPriority: json["PaymentPriority"],
        // taxGroup: json["TaxGroup"],
        // bankChargeAmount: json["BankChargeAmount"],
        // bankChargeAmountInFc: json["BankChargeAmountInFC"],
        // bankChargeAmountInSc: json["BankChargeAmountInSC"],
        // underOverpaymentdifference: json["UnderOverpaymentdifference"],
        // underOverpaymentdiffSc: json["UnderOverpaymentdiffSC"],
        // wtBaseSum: json["WtBaseSum"],
        // wtBaseSumFc: json["WtBaseSumFC"],
        // wtBaseSumSc: json["WtBaseSumSC"],
        // vatDate: DateTime.parse(json["VatDate"]),
        // transactionCode: json["TransactionCode"],
        // paymentType: json["PaymentType"],
        // transferRealAmount: json["TransferRealAmount"],
        // docObjectCode: json["DocObjectCode"],
        // docTypte: json["DocTypte"],
        // dueDate: DateTime.parse(json["DueDate"]),
        // locationCode: json["LocationCode"],
        // cancelled: json["Cancelled"],
        // controlAccount: json["ControlAccount"],
        // underOverpaymentdiffFc: json["UnderOverpaymentdiffFC"],
        // authorizationStatus: json["AuthorizationStatus"],
        // bplid: json["BPLID"],
        // bplName: json["BPLName"],
        // vatRegNum: json["VATRegNum"],
        // blanketAgreement: json["BlanketAgreement"],
        // paymentByWtCertif: json["PaymentByWTCertif"],
        // cig: json["Cig"],
        // cup: json["Cup"],
        // attachmentEntry: json["AttachmentEntry"],
        // uRefSeries: json["U_Ref_Series"],
        // uPrnNumber: json["U_PRN_Number"],
        // uDccIspl: json["U_DCC_ISPL"],
        // uDccco: json["U_DCCCO"],
        // uint?Key: json["U_int?Key"],
        // uRvc: json["U_RVC"],
        // uVat: json["U_VAT"],
        paymentChecks: List<PaymentCheck>.from(
            json["PaymentChecks"].map((x) => PaymentCheck.fromJson(x))),
        paymentInvoices: List<PaymentInvoice>.from(
            json["PaymentInvoices"].map((x) => PaymentInvoice.fromJson(x))),
        // paymentCreditCards:
        //     List<dynamic>.from(json["PaymentCreditCards"].map((x) => x)),
        // paymentAccounts:
        //     List<dynamic>.from(json["PaymentAccounts"].map((x) => x)),
        // paymentDocumentReferencesCollection: List<dynamic>.from(
        //     json["PaymentDocumentReferencesCollection"].map((x) => x)),
        // billOfExchange: BillOfExchange.fromJson(json["BillOfExchange"]),
        // withholdingTaxCertificatesCollection: List<dynamic>.from(
        //     json["WithholdingTaxCertificatesCollection"].map((x) => x)),
        // electronicProtocols:
        //     List<dynamic>.from(json["ElectronicProtocols"].map((x) => x)),
        // cashFlowAssignments:
        //     List<dynamic>.from(json["CashFlowAssignments"].map((x) => x)),
        // paymentsApprovalRequests:
        //     List<dynamic>.from(json["Payments_ApprovalRequests"].map((x) => x)),
        // withholdingTaxDataWtxCollection: List<dynamic>.from(
        //     json["WithholdingTaxDataWTXCollection"].map((x) => x)),
      );

  factory SapReceiptModel.issue(Map<String?, dynamic> json, int? stsCodee) =>
      SapReceiptModel(
        // odataMetadata: null,
        docNum: null,
        // docType: null,
        docEntry: null,
        // docDate: null,
        // cardCode: null,
        // cardName: null,
        // cashAccount: null,
        // cashSum: null,
        // checkAccount: null,
        // transferAccount: null,
        // transferSum: null,
        // transferDate: null,
        // transferReference: null,
        paymentChecks: null,
        paymentInvoices: null,
        // List<PaymentInvoice>.from(
        //     json["PaymentInvoices"].map((x) => PaymentInvoice.fromJson(x))),
        stscode: stsCodee,
        error: ErrorModel.fromJson(json['error']),
      );
 factory SapReceiptModel.exception(String e,int stsCode) =>
      SapReceiptModel(
        // odataMetadata: null,
        docNum: null,
        // docType: null,
        docEntry: null,
        // docDate: null,
        // cardCode: null,
        // cardName: null,
        // cashAccount: null,
        // cashSum: null,
        // checkAccount: null,
        // transferAccount: null,
        // transferSum: null,
        // transferDate: null,
        // transferReference: null,
        paymentChecks: null,
        paymentInvoices: null,
        stscode: stsCode,
        error: null,
        exception: e
      );

  Map<String?, dynamic> toJson() => {
        // "odata.metadata": odataMetadata,
        "DocNum": docNum,
        // "DocType": docType,
        // // "HandWritten": handWritten,
        // // "Print?ed": print?ed,
        // "DocDate": docDate,
        // // "${docDate.year.toString?().padLeft(4, '0')}-${docDate.month.toString?().padLeft(2, '0')}-${docDate.day.toString?().padLeft(2, '0')}",
        // "CardCode": cardCode,
        // "CardName": cardName,
        // // "Address": address,
        // "CashAccount": cashAccount,
        // // "DocCurrency": docCurrency,
        // "CashSum": cashSum,
        // "CheckAccount": checkAccount,
        // "TransferAccount": transferAccount,
        // "TransferSum": transferSum,
        // "TransferDate": transferDate,
        // "TransferReference": transferReference,
        // "LocalCurrency": localCurrency,
        // "DocRate": docRate,
        // "Reference1": reference1,
        // "Reference2": reference2,
        // "CounterReference": counterReference,
        // "Remarks": remarks,
        // "JournalRemarks": journalRemarks,
        // "SplitTransaction": splitTransaction,
        // "ContactPersonCode": contactPersonCode,
        // "ApplyVAT": applyVat,
        // "TaxDate":
        //     "${taxDate.year.toString?().padLeft(4, '0')}-${taxDate.month.toString?().padLeft(2, '0')}-${taxDate.day.toString?().padLeft(2, '0')}",
        // "Series": series,
        // "BankCode": bankCode,
        // "BankAccount": bankAccount,
        // "DiscountPercent": discountPercent,
        // "ProjectCode": projectCode,
        // "CurrencyIsLocal": currencyIsLocal,
        // "DeductionPercent": deductionPercent,
        // "DeductionSum": deductionSum,
        // "CashSumFC": cashSumFc,
        // "CashSumSys": cashSumSys,
        // "BoeAccount": boeAccount,
        // "BillOfExchangeAmount": billOfExchangeAmount,
        // "BillofExchangeStatus": billofExchangeStatus,
        // "BillOfExchangeAmountFC": billOfExchangeAmountFc,
        // "BillOfExchangeAmountSC": billOfExchangeAmountSc,
        // "BillOfExchangeAgent": billOfExchangeAgent,
        // "WTCode": wtCode,
        // "WTAmount": wtAmount,
        // "WTAmountFC": wtAmountFc,
        // "WTAmountSC": wtAmountSc,
        // "WTAccount": wtAccount,
        // "WTTaxableAmount": wtTaxableAmount,
        // "Proforma": proforma,
        // "PayToBankCode": payToBankCode,
        // "PayToBankBranch": payToBankBranch,
        // "PayToBankAccountNo": payToBankAccountNo,
        // "PayToCode": payToCode,
        // "PayToBankCountry": payToBankCountry,
        // "IsPayToBank": isPayToBank,
        "DocEntry": docEntry,
        // "PaymentPriority": paymentPriority,
        // "TaxGroup": taxGroup,
        // "BankChargeAmount": bankChargeAmount,
        // "BankChargeAmountInFC": bankChargeAmountInFc,
        // "BankChargeAmountInSC": bankChargeAmountInSc,
        // "UnderOverpaymentdifference": underOverpaymentdifference,
        // "UnderOverpaymentdiffSC": underOverpaymentdiffSc,
        // "WtBaseSum": wtBaseSum,
        // "WtBaseSumFC": wtBaseSumFc,
        // "WtBaseSumSC": wtBaseSumSc,
        // "VatDate":
        //     "${vatDate.year.toString?().padLeft(4, '0')}-${vatDate.month.toString?().padLeft(2, '0')}-${vatDate.day.toString?().padLeft(2, '0')}",
        // "TransactionCode": transactionCode,
        // "PaymentType": paymentType,
        // "TransferRealAmount": transferRealAmount,
        // "DocObjectCode": docObjectCode,
        // "DocTypte": docTypte,
        // "DueDate":
        //     "${dueDate.year.toString?().padLeft(4, '0')}-${dueDate.month.toString?().padLeft(2, '0')}-${dueDate.day.toString?().padLeft(2, '0')}",
        // "LocationCode": locationCode,
        // "Cancelled": cancelled,
        // "ControlAccount": controlAccount,
        // "UnderOverpaymentdiffFC": underOverpaymentdiffFc,
        // "AuthorizationStatus": authorizationStatus,
        // "BPLID": bplid,
        // "BPLName": bplName,
        // "VATRegNum": vatRegNum,
        // "BlanketAgreement": blanketAgreement,
        // "PaymentByWTCertif": paymentByWtCertif,
        // "Cig": cig,
        // "Cup": cup,
        // "AttachmentEntry": attachmentEntry,
        // "U_Ref_Series": uRefSeries,
        // "U_PRN_Number": uPrnNumber,
        // "U_DCC_ISPL": uDccIspl,
        // "U_DCCCO": uDccco,
        // "U_int?Key": uint?Key,
        // "U_RVC": uRvc,
        // "U_VAT": uVat,
        "PaymentChecks":
            List<dynamic>.from(paymentChecks!.map((x) => x.toJson2())),
        "PaymentInvoices":
            List<dynamic>.from(paymentInvoices!.map((x) => x.toJson3())),
        // "PaymentCreditCards":
        //     List<dynamic>.from(paymentCreditCards.map((x) => x)),
        // "PaymentAccounts": List<dynamic>.from(paymentAccounts.map((x) => x)),
        // "PaymentDocumentReferencesCollection": List<dynamic>.from(
        //     paymentDocumentReferencesCollection.map((x) => x)),
        // "BillOfExchange": billOfExchange.toJson(),
        // "WithholdingTaxCertificatesCollection": List<dynamic>.from(
        //     withholdingTaxCertificatesCollection.map((x) => x)),
        // "ElectronicProtocols":
        //     List<dynamic>.from(electronicProtocols.map((x) => x)),
        // "CashFlowAssignments":
        //     List<dynamic>.from(cashFlowAssignments.map((x) => x)),
        // "Payments_ApprovalRequests":
        //     List<dynamic>.from(paymentsApprovalRequests.map((x) => x)),
        // "WithholdingTaxDataWTXCollection":
        //     List<dynamic>.from(withholdingTaxDataWtxCollection.map((x) => x)),
      };
}

class BillOfExchange {
  BillOfExchange();

  factory BillOfExchange.fromJson(Map<String?, dynamic> json) =>
      BillOfExchange();

  Map<String?, dynamic> toJson() => {};
}

class PaymentCheck {
  int? lineNum;
  // String? dueDate;
  // int? checkNumber;
  // String? bankCode;
  // String? branch;
  // String? accounttNum;
  // dynamic details;
  // String? trnsfrable;
  // double? checkSum;
  // String? currency;
  // String? countryCode;
  // int? checkAbsEntry;
  // String? checkAccount;
  // String? manualCheck;
  // dynamic fiscalId;
  // dynamic originallyIssuedBy;
  // String? endorse;
  // dynamic endorsableCheckNo;

  PaymentCheck({
    required this.lineNum,
    // required this.dueDate,
    // required this.checkNumber,
    // required this.bankCode,
    // required this.branch,
    // required this.accounttNum,
    // // required this.details,
    // // required this.trnsfrable,
    // required this.checkSum,
    // required this.currency,
    // required this.countryCode,
    // required this.checkAbsEntry,
    // required this.checkAccount,
    // required this.manualCheck,
    // required this.fiscalId,
    // required this.originallyIssuedBy,
    // required this.endorse,
    // required this.endorsableCheckNo,
  });

  factory PaymentCheck.fromJson(Map<String?, dynamic> json) => PaymentCheck(
        lineNum: json["LineNum"],
        // dueDate: json["DueDate"],
        // checkNumber: json["CheckNumber"],
        // bankCode: json["BankCode"],
        // branch: json["Branch"],
        // accounttNum: json["AccounttNum"],
        // checkSum: json["CheckSum"],

        // details: json["Details"],
        // trnsfrable: json["Trnsfrable"],
        // currency: json["Currency"],
        // countryCode: json["CountryCode"],
        // checkAbsEntry: json["CheckAbsEntry"],
        // checkAccount: json["CheckAccount"],
        // manualCheck: json["ManualCheck"],
        // fiscalId: json["FiscalID"],
        // originallyIssuedBy: json["OriginallyIssuedBy"],
        // endorse: json["Endorse"],
        // endorsableCheckNo: json["EndorsableCheckNo"],
      );

  Map<String?, dynamic> toJson2() => {
        "LineNum": lineNum,
        // "DueDate": dueDate,
        // "${dueDate.year.toString?().padLeft(4, '0')}-${dueDate.month.toString?().padLeft(2, '0')}-${dueDate.day.toString?().padLeft(2, '0')}",
        // "CheckNumber": checkNumber,
        // "BankCode": bankCode,
        // "Branch": branch,
        // "AccounttNum": accounttNum,
        // // "Details": details,
        // // "Trnsfrable": trnsfrable,
        // "CheckSum": checkSum,
        // "Currency": currency,
        // "CountryCode": countryCode,
        // "CheckAbsEntry": checkAbsEntry,
        // "CheckAccount": checkAccount,
        // "ManualCheck": manualCheck,
        // "FiscalID": fiscalId,
        // "OriginallyIssuedBy": originallyIssuedBy,
        // "Endorse": endorse,
        // "EndorsableCheckNo": endorsableCheckNo,
      };
}

class PaymentInvoice {
  int? lineNum;
  int? docEntry;
  double? sumApplied;
  // int? appliedFc;
  // double? appliedSys;
  // int? docRate;
  // int? docLine;
  // String? invoiceType;
  // int? discountPercent;
  // int? paidSum;
  // int? installmentId;
  // int? witholdingTaxApplied;
  // int? witholdingTaxAppliedFc;
  // int? witholdingTaxAppliedSc;
  // dynamic linkDate;
  // dynamic distributionRule;
  // dynamic distributionRule2;
  // dynamic distributionRule3;
  // dynamic distributionRule4;
  // dynamic distributionRule5;
  // int? totalDiscount;
  // int? totalDiscountFc;
  // int? totalDiscountSc;

  PaymentInvoice({
    required this.lineNum,
    required this.docEntry,
    required this.sumApplied,
    // required this.appliedFc,
    // required this.appliedSys,
    // required this.docRate,
    // required this.docLine,
    // required this.invoiceType,
    // required this.discountPercent,
    // required this.paidSum,
    // required this.installmentId,
    // required this.witholdingTaxApplied,
    // required this.witholdingTaxAppliedFc,
    // required this.witholdingTaxAppliedSc,
    // required this.linkDate,
    // required this.distributionRule,
    // required this.distributionRule2,
    // required this.distributionRule3,
    // required this.distributionRule4,
    // required this.distributionRule5,
    // required this.totalDiscount,
    // required this.totalDiscountFc,
    // required this.totalDiscountSc,
  });

  factory PaymentInvoice.fromJson(Map<String?, dynamic> json) => PaymentInvoice(
        lineNum: json["LineNum"],
        docEntry: json["DocEntry"],
        sumApplied: json["SumApplied"],
        // appliedFc: int.parse(json["AppliedFC"]),
        // appliedSys: json["AppliedSys"],
        // docRate: int.parse(json["DocRate"]),
        // docLine: json["DocLine"],
        // invoiceType: json["InvoiceType"],
        // discountPercent: json["DiscountPercent"],
        // paidSum: json["PaidSum"],
        // installmentId: json["InstallmentId"],
        // witholdingTaxApplied: json["WitholdingTaxApplied"],
        // witholdingTaxAppliedFc: json["WitholdingTaxAppliedFC"],
        // witholdingTaxAppliedSc: json["WitholdingTaxAppliedSC"],
        // linkDate: json["LinkDate"],
        // distributionRule: json["DistributionRule"],
        // distributionRule2: json["DistributionRule2"],
        // distributionRule3: json["DistributionRule3"],
        // distributionRule4: json["DistributionRule4"],
        // distributionRule5: json["DistributionRule5"],
        // totalDiscount: json["TotalDiscount"],
        // totalDiscountFc: json["TotalDiscountFC"],
        // totalDiscountSc: json["TotalDiscountSC"],
      );

  Map<String?, dynamic> toJson3() => {
        "LineNum": lineNum,
        "DocEntry": docEntry,
        "SumApplied": sumApplied,
        // "AppliedFC": appliedFc,
        // "AppliedSys": appliedSys,
        // "DocRate": docRate,
        // "DocLine": docLine,
        // "InvoiceType": invoiceType,
        // "DiscountPercent": discountPercent,
        // "PaidSum": paidSum,
        // "InstallmentId": installmentId,
        // "WitholdingTaxApplied": witholdingTaxApplied,
        // "WitholdingTaxAppliedFC": witholdingTaxAppliedFc,
        // "WitholdingTaxAppliedSC": witholdingTaxAppliedSc,
        // "LinkDate": linkDate,
        // "DistributionRule": distributionRule,
        // "DistributionRule2": distributionRule2,
        // "DistributionRule3": distributionRule3,
        // "DistributionRule4": distributionRule4,
        // "DistributionRule5": distributionRule5,
        // "TotalDiscount": totalDiscount,
        // "TotalDiscountFC": totalDiscountFc,
        // "TotalDiscountSC": totalDiscountSc,
      };
}
