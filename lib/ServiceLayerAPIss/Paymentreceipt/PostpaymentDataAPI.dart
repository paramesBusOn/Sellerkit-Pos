// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, noop_primitive_operations, unnecessary_statements, unnecessary_parenthesis

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Models/ServiceLayerModel/ReceiptModel/PostReceiptLineMode.dart';
import '../../Models/ServiceLayerModel/ReceiptModel/ReceiptDataModel.dart';
import '../../Models/ServiceLayerModel/SapInvoiceModel/InvPostingLineModel.dart';

import '../../url/url.dart';

class ReceiptPostAPi {
  static String? docType;
  static String? cardCodePost;
  static String? cashAccount;
  static double? cashSum;
  static List<PostPaymentCheck>? docPaymentChecks;
  static List<PostPaymentInvoice>? docPaymentInvoices;
  static String? transferReference;
  static String? checkAccount;
  static String? transferAccount;
  static double? transferSum;
  static String? transferDate;
  static String? docDate;
  static String? dueDate;
  static String? remarks;
  static void method() {
    final data = json.encode({
      "CardCode": "$cardCodePost",
      "DocDate": "$docDate",
      "Remarks": "$remarks",
      "CashAccount": cashAccount,
      "CashSum": cashSum,
      "DocType": docType,
      "CheckAccount": checkAccount,
      "TransferAccount": transferAccount,
      "TransferSum": transferSum,
      "TransferReference": transferReference,
      "PaymentChecks": docPaymentChecks!.map((e) => e.toJson2()).toList(),
      "PaymentInvoices": docPaymentInvoices!.map((e) => e.toJson3()).toList(),
    });
  }

  static Future<SapReceiptModel> getGlobalData() async {
    try {
      log(URL.sapUrl + "/IncomingPayments");
      final response = await http.post(
        Uri.parse(
          URL.sapUrl + "/IncomingPayments",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
          // "Prefer":"return-no-content"
        },
        body: json.encode({
          "CardCode": "$cardCodePost",
          "DocDate": "$docDate",
          "Remarks": "$remarks",
          "CashAccount": cashAccount,
          "CashSum": cashSum,
          "DocType": docType,
          "CheckAccount": checkAccount,
          "TransferAccount": transferAccount,
          "TransferSum": transferSum,
          "TransferReference": transferReference,
          "PaymentChecks": docPaymentChecks!.map((e) => e.toJson2()).toList(),
          "PaymentInvoices":
              docPaymentInvoices!.map((e) => e.toJson3()).toList(),
        }),
      );

      log(
        "datatatat: " +
            json.encode({
              "CardCode": "$cardCodePost",
              "DocDate": "$docDate",
              "Remarks": "$remarks",
              "CashAccount": cashAccount,
              "CashSum": cashSum,
              "DocType": docType,
              "CheckAccount": checkAccount,
              "TransferAccount": transferAccount,
              "TransferSum": transferSum,
              "TransferReference": transferReference,
              "PaymentChecks":
                  docPaymentChecks!.map((e) => e.toJson2()).toList(),
              "PaymentInvoices":
                  docPaymentInvoices!.map((e) => e.toJson3()).toList(),
            }),
      );
      // log("Responce: " + (json.decode(response.body).toString()));
      log("statucCode: " + response.statusCode.toString());
      log("SapReceiptModel res: " + response.body.toString());

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        // final dynamic data = json.decode(response.body.toString());
        return SapReceiptModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // throw Exception('Restart the app or contact the admin!!..');
        return SapReceiptModel.issue(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      print(e);
      // throw Exception(e);'Restart the app or contact the admin!!..\n'
      return SapReceiptModel.exception(e.toString(), 500);
    }
  }
}
