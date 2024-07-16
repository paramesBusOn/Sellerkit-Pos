

// ignore_for_file: prefer_final_locals, omit_local_variable_types, prefer_single_quotes

import 'dart:convert';
import 'dart:developer';

class CreateCustPostModel {
  CreateCustPostModel(
      {
      required this.CardCode,
     required this.error,
      required this.statusCode,
      required this.ErrorMsg
      });

  String? error;
  int ? statusCode;
  String ? CardCode;
  Errors? ErrorMsg;

  factory CreateCustPostModel.fromJson(String resp, int stcode) {
    var jsons =   json.decode(resp) as Map<String, dynamic>;
    print('jsons :::$jsons');

    if(stcode >= 200 && stcode <= 210){
      return CreateCustPostModel(
        CardCode: jsons['CardCode'] as String,
         error: null, 
        statusCode: stcode,
        ErrorMsg:null
      );
    }else{
       return CreateCustPostModel(
        CardCode: null,
         error: resp, 
        statusCode: stcode,
        ErrorMsg:jsons["error"] ==null?null: Errors.fromJson(jsons["error"]),
      );
    }
  }

  factory CreateCustPostModel.issue(String resp, int stcode) {
    var jsons =   json.decode(resp) as Map<String, dynamic>;
    log('jsons :::$jsons');

   
       return CreateCustPostModel(
        CardCode: null,
         error: resp, 
        statusCode: stcode,
        ErrorMsg:jsons["error"] ==null?null: Errors.fromJson(jsons["error"]),
      );
    
  }

}

class Errors{
String? Code;
 Message ?message;

Errors({
   this.Code,
   this.message,
});

 factory Errors.fromJson(dynamic jsons) {
    return Errors(
      Code: jsons['code'].toString(), 
      message:Message.fromJson(jsons['message']), 
       );
 }
}

class Message{
  String? Value;
  Message({
    this.Value
  });
   factory Message.fromJson(dynamic jsons) {
    return Message(
      Value: jsons['value'].toString(), 
       );
 }
}



