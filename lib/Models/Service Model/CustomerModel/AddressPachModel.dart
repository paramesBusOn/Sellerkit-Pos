// ignore_for_file: prefer_final_locals, omit_local_variable_types, prefer_single_quotes

import 'dart:convert';
import 'dart:developer';

import '../CreateCustPostModel.dart';

class CreatePatchModel {
  CreatePatchModel(
      {required this.error, required this.statusCode, required this.ErrorMsg});

  String? error;
  int? statusCode;
  Errors? ErrorMsg;

  factory CreatePatchModel.fromJson(int stcode) {
    return CreatePatchModel(error: null, statusCode: stcode, ErrorMsg: null);
  }
  factory CreatePatchModel.fromJson2(Map<String, dynamic> jsons, int stcode) {
    return CreatePatchModel(
      error: null,
      statusCode: stcode,
      ErrorMsg: Errors.fromJson(jsons["error"]),
    );
  }
  factory CreatePatchModel.issue(String resp, int stcode) {
    return CreatePatchModel(error: resp, statusCode: stcode, ErrorMsg: null);
  }
}
