import 'package:flutter/cupertino.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/NumberingSeries.dart';

class NumberSeriesCtrl extends ChangeNotifier{
  Configure config = Configure();
List<TextEditingController> nxtnocontroller =List.generate(150, (index) => TextEditingController());
List<TextEditingController> frstnocontroller =List.generate(150, (index) => TextEditingController());
List<TextEditingController> lstnocontroller =List.generate(150, (index) => TextEditingController());
List<TextEditingController> prfixcontroller =List.generate(150, (index) => TextEditingController());
List<TextEditingController> frmdatecontroller =List.generate(150, (index) => TextEditingController());
List<TextEditingController> todatecontroller =List.generate(150, (index) => TextEditingController());

List<NumberingSriesTDB> numberSerisList=[];
init(){
clearData();
getNumberSeriesList();
notifyListeners();
}
clearData(){
  numberSerisList=[];
  nxtnocontroller =List.generate(150, (index) => TextEditingController());
    notifyListeners();

}
getNumberSeriesList() async{
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> numberSeriesData = await DBOperation.getNumberSeries(db);
    for(int i=0;i<numberSeriesData.length;i++){
numberSerisList.add(NumberingSriesTDB(id: int.parse(numberSeriesData[i]['id'].toString()), 
//
DocID:
 int.parse(numberSeriesData[i]['DocID'].toString()),
 FirstNo: int.parse(numberSeriesData[i]['FirstNo'].toString()), 
 FromDate:numberSeriesData[i]['FromDate'].toString(), 
 LastNo: int.parse(numberSeriesData[i]['LastNo'].toString()), 
 NextNo: int.parse(numberSeriesData[i]['NextNo'].toString()), 
 Prefix: numberSeriesData[i]['Prefix'].toString(), 
 Terminal: numberSeriesData[i]['Terminal'].toString(), 
 ToDate:  numberSeriesData[i]['ToDate'].toString(),
  WareHouse: numberSeriesData[i]['WareHouse'].toString(), 
  DocName: numberSeriesData[i]['DocName'].toString()));
    }
    notifyListeners();
for(int ij=0;ij<numberSerisList.length;ij++){
nxtnocontroller[ij].text=numberSerisList[ij].NextNo.toString();
frstnocontroller[ij].text=numberSerisList[ij].FirstNo.toString();
lstnocontroller[ij].text=numberSerisList[ij].LastNo.toString();
prfixcontroller[ij].text=numberSerisList[ij].Prefix.toString();
frmdatecontroller[ij].text= config.alignDate(numberSerisList[ij].FromDate.toString());
todatecontroller[ij].text= config.alignDate(numberSerisList[ij].ToDate.toString());

    notifyListeners();

}
    notifyListeners();

}
 disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }
updateNxtnoTable(int ij) async{
    final Database db = (await DBHelper.getInstance())!;
    // if(int.parse(nxtnocontroller[ij].text)>=numberSerisList[ij].NextNo){
numberSerisList[ij].NextNo=int.parse(nxtnocontroller[ij].text);
    await DBOperation.updatenextno(db,numberSerisList[ij].id!, numberSerisList[ij].NextNo);
print('updated'); 
notifyListeners();
// }
// else{
// print('not updated '); 

// }
// notifyListeners();

}
updateLastnoTable(int ij) async{
    final Database db = (await DBHelper.getInstance())!;
    // if(int.parse(lstnocontroller[ij].text)>=numberSerisList[ij].LastNo!){
numberSerisList[ij].NextNo=int.parse(lstnocontroller[ij].text);
    await DBOperation.updatelastno(db,numberSerisList[ij].id!, numberSerisList[ij].NextNo);
print('updated'); 
notifyListeners();
// }
// else{
// print('not updated '); 

// }
// notifyListeners();

}
updateFirstnoTable(int ij) async{
    final Database db = (await DBHelper.getInstance())!;
    // if(int.parse(frstnocontroller[ij].text)>=numberSerisList[ij].NextNo){
numberSerisList[ij].NextNo=int.parse(frstnocontroller[ij].text);
    await DBOperation.updatefirstno(db,numberSerisList[ij].id!, numberSerisList[ij].FirstNo!);
print('updated'); 
notifyListeners();
// }
// else{
// print('not updated '); 

// }
// notifyListeners();

}
updatePrfixnoTable(int ij) async{
    final Database db = (await DBHelper.getInstance())!;
numberSerisList[ij].Prefix=prfixcontroller[ij].text;
    await DBOperation.updateprefixno(db,numberSerisList[ij].id!, numberSerisList[ij].Prefix.toString());
    // int? documentN0 = await DBOperation.getnumbSer(db, "nextno", "NumberingSeries",numberSerisList[ij].id!);
    //    int nextno = documentN0!;
    //      await DBOperation.updatenextno(db,numberSerisList[ij].id!, nextno);
print('updated'); 
notifyListeners();

}
updateFrmDateTable(int ij) async{
    final Database db = (await DBHelper.getInstance())!;
    // if(int.parse(frmdatecontroller[ij].text)>=numberSerisList[ij].NextNo){
numberSerisList[ij].FromDate=frmdatecontroller[ij].text;
    await DBOperation.updatefromdate(db,numberSerisList[ij].id!,config.alignDate2( numberSerisList[ij].FromDate.toString()));
print('updated'); 
notifyListeners();
// }
// else{
// print('not updated '); 

// }
// notifyListeners();

}
updatetoDateTable(int ij) async{
    final Database db = (await DBHelper.getInstance())!;
    // if(int.parse(todatecontroller[ij].text)>=numberSerisList[ij].NextNo){
numberSerisList[ij].NextNo=int.parse(todatecontroller[ij].text);
    await DBOperation.updatetodate(db,numberSerisList[ij].id!,config.alignDate2(numberSerisList[ij].ToDate.toString()));
print('updated'); 
notifyListeners();
// }
// else{
// print('not updated '); 

// }
// notifyListeners();

}
}