import 'dart:developer';

class SapConsumeQueue {
  int? ObjectType;
  String? ActionType;
  int? TransId;
  String? Branch;
  String? Terminal;
  int? DocNumber;
  int? DocEntry;
  bool? Status;
  String? ErrorMessage;
  String? MyProperty1;
  String? MyProperty2;
  SapConsumeQueue(
      {required this.ActionType,
      //
      required this.Branch,
      required this.DocEntry,
      required this.ObjectType,
      required this.MyProperty1,
      required this.MyProperty2,
      required this.DocNumber,
      required this.Terminal,
      required this.TransId,
      required this.Status,
      required this.ErrorMessage});

  factory SapConsumeQueue.fromjson(Map<String, dynamic> resp) {
    log(' resp DocEntry::' + resp['DocEntry'].toString());
    return SapConsumeQueue(
      ActionType: resp['ActionType'],
      Branch: resp['Branch'],
      DocEntry: resp['DocEntry'] == null ? null : int.parse(resp['DocEntry'].toString()),
      ObjectType: resp['ObjectType'],
      DocNumber: resp['DocNumber'] == null ? null : int.parse(resp['DocNumber'].toString()),
      Terminal: resp['Terminal'] == null ? null : resp['Terminal'].toString(),
      TransId: resp['TransId'] != null ? int.parse(resp['TransId']) : null,
      Status: resp['Status'],
      ErrorMessage: resp['ErrorMessage'].toString(),
      MyProperty1: resp['MyProperty1'],
      MyProperty2: resp['MyProperty2'],
    );
  }
}
