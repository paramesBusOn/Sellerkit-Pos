// import 'dart:convert';



// ignore_for_file: prefer_final_locals, omit_local_variable_types, require_trailing_commas

import 'dart:convert';

class SeriesModel {
  SeriesModel({
    required this.status,
    required this.message,
    required this.seriescustData,
    required this.statusCode
    });

  bool? status;
  String? message;
  List<SeriesModelData>? seriescustData;
  int ? statusCode;

  factory SeriesModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<SeriesModelData> dataList = list
          .map((dynamic enquiries) => SeriesModelData.fromJson(enquiries))
          .toList();
      return SeriesModel(
        seriescustData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        statusCode: stcode,
      );
    } else {
      return SeriesModel(
        message: jsons['data'].toString(),
        status: jsons['status'] as bool,
        seriescustData:null,
        statusCode: stcode,
      );
    }
    }else{
       return SeriesModel(
        message: resp,
        status: null,
        seriescustData:null,
        statusCode: stcode,
      );
    }
  }
}

class SeriesModelData{
  int? Series;
String ? SeriesName;

SeriesModelData({
required  this.Series,
required this.SeriesName,
});
     
factory SeriesModelData.fromJson(dynamic jsons) {  
    return SeriesModelData(
    Series:jsons['Series']==null? 0 : jsons['Series']as int,
    SeriesName:  jsons['SeriesName']==null? '' : jsons['SeriesName']as String);}}

// class SeriesModel {
//   SeriesModel(
//       {required this.status,
//       required this.message,
//       required this.seriescustData,
//       required this.statusCode,
//       required this.exception});

//   bool? status;
//   String? message;
//   List<SeriesModelData>? seriescustData;
//   int? statusCode;
//   String? exception;

//   factory SeriesModel.fromJson(String jsons, int stcode) {
//     if (jsons['message'] == "Success") {
//       var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
//       List<SeriesModelData> dataList = list
//           .map((dynamic enquiries) => SeriesModelData.fromJson(enquiries))
//           .toList();
//       return SeriesModel(
//         seriescustData: dataList,
//         message: jsons['message'].toString(),
//         status: jsons['status'],
//         statusCode: stcode,
//         exception: null,
//       );
//     } else {
//       return SeriesModel(
//         message: jsons['message'].toString(),
//         status: jsons['status'] as bool,
//         seriescustData: null,
//         statusCode: stcode,
//         exception: null,
//       );
//     }
//   }
//   factory SeriesModel.error(String jsons, int stcode) {
//     return SeriesModel(
//         seriescustData: null,
//         message: null,
//         status: null,
//         statusCode: stcode,
//         exception: jsons);
//   }
// }

// class SeriesModelData {
//   int? Series;
//   String? SeriesName;

//   SeriesModelData({
//     required this.Series,
//     required this.SeriesName,
//   });

//   factory SeriesModelData.fromJson(Map<String, dynamic> jsons) {
//     return SeriesModelData(
//         Series: jsons['Series'], SeriesName: jsons['SeriesName'].toString());
//   }
// }
