
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screen.dart';
import 'package:intl/intl.dart';

class Configure {
  void showDialogBox(String title, String msg, BuildContext context) {
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final theme = Theme.of(context);
            return AlertDialog(
              title: Center(
                  child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(color: Colors.black),
              )),
              content: SizedBox(
                width: Screens.width(context) * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      msg,
                      style: theme.textTheme.bodyLarge?.copyWith(),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
 Future<bool> haveInterNet() async {
    final result = await Connectivity().checkConnectivity();
    final hasInternet = result != ConnectivityResult.none;
    return hasInternet;
  }
  
  String alignDate(String date) {
    // log("message"+date);
    if(date == 'null'||date.isEmpty){
      return '';
    }
    var dates = DateTime.parse(date);
    // print(
    //     "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}");
    return "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}";
  }

  String aligntimeDate(String date) {
    var dates = DateTime.parse(date);

    String currentDateTime =
        "${dates.day.toString()}-${dates.month.toString().padLeft(2, '0')}-${dates.year.toString().padLeft(2, '0')} ${dates.hour.toString().padLeft(2, '0')}:${dates.minute.toString().padLeft(2, '0')}:${dates.second.toString().padLeft(2, '0')}";
    return currentDateTime;
  }
  String alignDate1(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var date1 = inputFormat.parse(date);
    // log("------------------------------------------------------------------------------------------------");
    var dates = DateTime.parse(date1.toString());
    return "${dates.year}-${dates.month.toString().padLeft(2, '0')}-${dates.day.toString().padLeft(2, '0')}";
    // return date1.toString();
  }

  String alignDateT(String date) {
    // if (date.toString() != "null" && date.isNotEmpty) {
    //   var inputFormat = DateFormat('yyyy-MM-dd');
    //   var date1 = inputFormat.parse(date);
    //   log("date1 $date1");
    //   var outputFormat = DateFormat('dd-MM-yyyy');

    //   var date2 = outputFormat.format(date1);
    //   log("date2 $date2");

    var dates = DateTime.parse(date);
    print(
        "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}");
    return "${dates.day.toString().padLeft(2, '0')}-${dates.month.toString().padLeft(2, '0')}-${dates.year}";
    // } else {
    //   return '';
    // }
  }

  String alignDate2(String date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var date1 = inputFormat.parse(date);
    var dates = DateTime.parse(date1.toString());
    return "${dates.year}-${dates.month.toString().padLeft(2, '0')}-${dates.day.toString().padLeft(2, '0') }";
    
    // return date1.toString();
  }

  String currentDate() {
    DateTime now = DateTime.now();
    String currentDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    return currentDateTime;
  }
String currentDate2() {
    DateTime now = DateTime.now();
    String currentDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    return currentDateTime;
  }
  String slpitCurrency2(String value) {
    double values = double.parse(value);
    var format = NumberFormat.currency(
      name: "INR", locale: 'en_IN',
      decimalDigits: 2, // change it to get decimal places
      symbol: '',
    );
    String formattedCurrency = format.format(values);
    //  double formattedvalue =  double.parse(formattedCurrency);
    return formattedCurrency;
  }

  String splitValues(String val) {
    // print("vvvvv: "+val);
    var formatter = NumberFormat('###,000.00');
    double formatNO = double.parse(val);
    // print("formatedd: "+formatter.format(formatNO));
    String retunVal = formatter.format(formatNO).toString();
    return retunVal;
  }
   void showDialogSucessB(String msg,String title){
      Get.defaultDialog<void>(
        title: title,
        content: Container(
          child: Column(
            children: [
              Text(msg),
            ],
          ),
        )
      ).then((value) {
        Get.back<void>();
      });
  }
 Future<void> showDialogg(String msg,String title) async{
      Get.defaultDialog<void>(
        title: title,
        content: Container(
          child: Column(
            children: [
              Text(msg),
            ],
          ),
        )
      );
  }
}
