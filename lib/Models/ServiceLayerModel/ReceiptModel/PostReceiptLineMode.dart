class PostPaymentCheck {
  String? dueDate;
  int? checkNumber;
  String? bankCode;

  String? accounttNum;
  String details;
  double? checkSum;

  PostPaymentCheck({
    required this.dueDate,
    required this.checkNumber,
    required this.bankCode,
    required this.accounttNum,
    required this.details,
    required this.checkSum,
  });

  Map<String?, dynamic> toJson2() => {
        "DueDate": dueDate,
        "CheckNumber": checkNumber,
        "BankCode": bankCode,
        "AccounttNum": accounttNum,
        "Details": details,
        "CheckSum": checkSum,
      };
}

class PostPaymentInvoice {
 
  int? docEntry;
  double? sumApplied;
  String? invoiceType;

  PostPaymentInvoice({

    required this.docEntry,
    required this.sumApplied,
    required this.invoiceType,
  });

  Map<String?, dynamic> toJson3() => {
    
        "DocEntry": docEntry,
        "SumApplied": sumApplied,
        "InvoiceType": invoiceType,
      };
}
