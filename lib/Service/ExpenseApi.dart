import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Constant/AppConstant.dart';
import '../Models/ExpenseModel/ExpenseGetModel.dart';

class ExpanseMasterApi {
  static Future<ExpenseGetModel> getData() async {
    int resCode = 500;
    try {
      print("http://102.69.167.106:1888/api/POSMaster/ExpenseMaster/${AppConstant.branch}/${AppConstant.terminal}");
      final response = await http.get(
        Uri.parse('http://102.69.167.106:1888/api/POSMaster/ExpenseMaster/${AppConstant.branch}/${AppConstant.terminal}'),
        headers: {
          "content-type": "application/json",
        },
      );
      resCode = response.statusCode;
      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        return ExpenseGetModel.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error Exp: ${json.decode(response.body)}");
        return ExpenseGetModel.error('404 not found..!!', response.statusCode);
      }
    } catch (e) {
      print("Exception Exp: $e");
      return ExpenseGetModel.error(e.toString(), 500);
    }
  }
}
