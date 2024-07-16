import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/SchemeOrderModel/SchemeOrderModel.dart';

class SchemeOrderAPi {
  static String? deviceId;
  static String? userCode;
  static String? password;

  static Future<SchemeOrderModal> getGlobalData(
      List<SalesOrderScheme> salesOderScheme) async {
    try {
      print("DDDDDDDDDDDDDD1");

      //http://102.69.167.106:80/Api/DisCalculation_Order

      print('http://102.69.167.106:80/Api/DisCalculation_Order');
      final response = await http.post(
          Uri.parse('http://102.69.167.106:80/Api/DisCalculation_Order'),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            "SCHEMES": salesOderScheme.map((e) => e.toMap()).toList(),
          }));
      print("DDDDDDDDDDDDDD2");

      print("Json:${json.encode({ "SCHEMES": salesOderScheme.map((e) => e.toMap()).toList()})}");
      print("DDDDDDDDDDDDDD3");

      print("json ressss: ${response.body}");
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SchemeOrderModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print(json.decode(response.body));

        print("error: ");
        throw Exception("Error!!...");
        // return SchemeOrderModal.issue(
        //   response.statusCode,
        // );
      }
    } catch (e) {
      print("e: $e");

      // throw Exception("Exceptionsss: $e");
      return SchemeOrderModal.exception(
          'Restart the app or contact the admin!!..', 500);
    }
  }
}
