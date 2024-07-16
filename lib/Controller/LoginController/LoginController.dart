// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names, empty_constructor_bodies, unnecessary_null_comparison, unused_local_variable, prefer_const_constructors, use_build_context_synchronously, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:posproject/DB%20Helper/DBhelper.dart';
import 'package:posproject/DBModel/UserDBModel.dart';
import 'package:posproject/Models/Service%20Model/LoginUserModel.dart';
import 'package:posproject/Service/LoginUserApi.dart';
import 'package:posproject/Service/UsersAPI.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/SharedPreference.dart';
import '../../DB Helper/DBOperation.dart';
import '../../main.dart';

class LoginController extends ChangeNotifier {
  void init() {
    createDB();
    GetDeviceID();
  }

  List<GlobalKey<FormState>> formkey = List.generate(10, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller = List.generate(50, (i) => TextEditingController());
  static bool loginPageScrn = false;
  bool hidePassword = true;
  bool get getHidepassword => hidePassword;
  String settingMsg = '';
  String get getSettingMsg => settingMsg;
  String siteCode = '';
  List<String> catchmsg = [];
  List<UserModelDB> usersValues = [];

  createDB() async {
    await DBHelper.getInstance().then((value) {
      print("Created...");
    });
  }

  void obsecure() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  void validate(BuildContext context) async {
    final theme = Theme.of(context);
    if (formkey[0].currentState!.validate()) {
      String? host = await SharedPref.getHostDSP();
      String? siteCode = await SharedPref.getBranchSSP();
      if (host != null && siteCode != null) {
        callLoginApi();

        // checkWithDB(context);
      }
    }
  }

  final formkeysetting = GlobalKey<FormState>();
  void settingvalidate(BuildContext context) async {
    if (formkey[1].currentState!.validate()) {
      await SharedPref.saveHostSP(mycontroller[2].text.trim());
      await SharedPref.saveBranchSP(mycontroller[4].text.trim());
      await SharedPref.saveTerminal(mycontroller[5].text.trim());
      siteCode = mycontroller[4].text.trim();
      settingMsg = "";
      getIP();
      setreadonly();
      await insertuserTable();
      notifyListeners();
      Navigator.pop(context);
    }
  }

  getIP() async {
    String? ip = await SharedPref.getHostDSP();
    String? branch = await getBranch();
    String? terminal = await getTerminal();

    if (ip != null && ip != 'null' && branch != null && branch != 'null' && terminal != null && terminal != 'null') {
      AppConstant.branch = branch.toString();
      AppConstant.terminal = terminal.toString();
      AppConstant.ip = ip;
      print("ip: ${AppConstant.branch} ");
      receivervb();
    }
  }

  void ClearSp() async {
    await SharedPref.clearDeviceID();
    await SharedPref.clearHost();
    await SharedPref.clearSiteCode();
  }

  settingsget() async {
    String? sata = await SharedPref.getStngIPSP();
    print("shared get: " + sata.toString());
  }

  clearController() async {
    mycontroller[2].clear();
    mycontroller[4].clear();
  }

  bool isalreadyset = false;

  GetDeviceID() async {
    // int? logRecord = await getUserData();
    // if (logRecord! < 1) {
    //   insertDb('U101', 'bala', '1234', 'B1234', 'HOFG', 'T1', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //   insertDb('U102', 'test', '1234', 'B1234', 'HOFG', 'T2', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //   insertDb('U103', 'paramesh', '1234', 'B1234', 'HOFG', 'T3', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //   insertDb('U104', 'anbu', '1234', 'B1234', 'HOFG', 'T4', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //   insertDb('U105', 'sharmi', '1234', 'B1234', 'ARSFG', 'T1', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //        insertDb('U107', 'admin', '1234', 'B1234', 'ARSFG', 'T2', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    //         insertDb('U106', 'bala1', '1234', 'B1234', 'HOGIT', 'T1', 'Y', 'user',
    //       'buson123B', '', '2023-02-01', '2023-02-01', 1, 1, '192.198.182.1');
    // }
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();

    String? spDeviceID = await SharedPref.getDeviceIDSP();
    String? host = await SharedPref.getHostDSP();
    String? siteCode2 = await SharedPref.getBranchSSP();
    String? terminal = await SharedPref.getTerminal();
    int alreadyset = 0;
    siteCode = siteCode2.toString();
    // log(spDeviceID.toString());
    // log(siteCode.toString());
    if (spDeviceID == null) {
      spDeviceID = (await PlatformDeviceId.getDeviceId)!;
      SharedPref.saveDeviceIDSP(spDeviceID);
      mycontroller[3].text = (await SharedPref.getDeviceIDSP())!;
      notifyListeners();
    } else if (spDeviceID != null) {
      mycontroller[3].text = (await SharedPref.getDeviceIDSP())!;
      notifyListeners();
    }
    if (host != null) {
      mycontroller[2].text = host;
      alreadyset = alreadyset + 1;
    }
//log("siteCode2: " + siteCode2.toString());
    if (siteCode2 != null || siteCode2 != 'null') {
  //log("siteCode2: " + siteCode2.toString());
      mycontroller[4].text = siteCode2.toString();
      alreadyset = alreadyset + 1;
    }
    if (terminal != null) {
      mycontroller[5].text = terminal.toString();
      alreadyset = alreadyset + 1;
    }
    if (siteCode2 == null || host == null) {
      mycontroller[4].text = "";
      settingMsg = "Complete the setup..!!";
      notifyListeners();
    } else if ((siteCode2 != null || siteCode2 != 'null') || host != null) {
      settingMsg = "";
      notifyListeners();
    }

    setreadonly();

    if (mycontroller[4].text == "null") {
      mycontroller[4].text = "";
    }
  }

  setreadonly() async {
    String? host = await SharedPref.getHostDSP();
    String? siteCode2 = await SharedPref.getSiteCodeSP();
    String? terminal = await SharedPref.getTerminal();
    int alreadyset = 0;

    if (host != null) {
      // log("count=1");
      alreadyset = alreadyset + 1;
    }
    if (siteCode2 != null || siteCode2 != 'null') {
      alreadyset = alreadyset + 1;
      // log("count=2");
    }
    if (terminal != null) {
      alreadyset = alreadyset + 1;
      // log("count=3");
    }
    if (alreadyset == 3) {
      isalreadyset = true;
    }
    // log("alreadyset"+alreadyset.toString());

    notifyListeners();
  }
  // GetDeviceID() async { //old
  // int? logRecord =  await getUserData();
  // if(logRecord!<1){
  //    insertDb(
  //        'U101','Bala','1234','B1234','cbe1','Y','user','buson123B','','2023-02-01','2023-02-01',
  //        1,1,'192.198.182.1' );
  // }

  //   mycontroller[2].clear();
  //   mycontroller[3].clear();
  //   mycontroller[4].clear();
  //   String? spDeviceID = await SharedPref.getDeviceIDSP();
  //   String? host = await SharedPref.getHostDSP();
  //   String? siteCode2 = await SharedPref.getSiteCodeSP();
  //   siteCode = siteCode2.toString();
  //   // log(spDeviceID.toString());
  //   // log(siteCode.toString());
  //   if (spDeviceID == null) {
  //     spDeviceID = (await PlatformDeviceId.getDeviceId)!;
  //     SharedPref.saveDeviceIDSP(spDeviceID);
  //     mycontroller[3].text = (await SharedPref.getDeviceIDSP())!;
  //     notifyListeners();
  //   } else if (spDeviceID != null) {
  //     mycontroller[3].text = (await SharedPref.getDeviceIDSP())!;
  //     notifyListeners();
  //   }
  //   if (host != null) {
  //     mycontroller[2].text = host;
  //   }
  //   if (siteCode2 != null && siteCode2 != 'null' ) {
  // //log("siteCode2: "+siteCode2.toString());
  //     mycontroller[4].text = siteCode2.toString();
  //   }
  //   if (siteCode2 == null || host == null) {
  //     settingMsg = "Complete the setup..!!";
  //     notifyListeners();
  //   } else if ((siteCode2 != null && siteCode2 != 'null')|| host != null ) {
  //     settingMsg = "";
  //     notifyListeners();
  //   }
  // }

  checkWithDB(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> result = await DBOperation.checkUSerAvail(db, mycontroller[0].text.trim(), mycontroller[1].text.trim(), siteCode);
    if (result.isNotEmpty) {
      await SharedPref.saveBranchSP(result[0]['branch'].toString());
      await SharedPref.saveLicenseSP(result[0]['licensekey'].toString());
      await SharedPref.saveLoggedInSP(true);
      await SharedPref.saveUserIdeSP(result[0]['autoId'].toString());
      await SharedPref.saveUserSP(result[0]['usercode'].toString());

      String? branch = await SharedPref.getBranchSSP();
      String? getLicenseSP = await SharedPref.getLicenseSP();
      bool? getLoggedINSP = await SharedPref.getLoggedINSP();
      String? getUSerSP = await SharedPref.getUSerSP();
      String? getUserIdSP = await SharedPref.getUserIdSP();

      settingMsg = '';
      notifyListeners();
      Get.offNamed(ConstantRoutes.DownloadPage);
    } else if (result.isEmpty) {
      final theme = Theme.of(context);
      settingMsg = 'Invalid Credential..!!';
      notifyListeners();
    }
  }

  insertuserTable() async {
    usersValues = [];
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.truncateUserMaster(db);
    print("value.users length:::${AppConstant.branch}");
    await UsersAPI.getData(
      AppConstant.branch,
    ).then((value) async {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        print("value.users length:::${value.loginuserList!.length}");
        if (value.loginuserList != null) {
          for (int i = 0; i < value.loginuserList!.length; i++) {
            usersValues.add(UserModelDB(
                usercode: value.loginuserList![i].usercode,
                userName: value.loginuserList![i].userName,
                branch: value.loginuserList![i].branch,
                terminal: value.loginuserList![i].terminal,
                createdUserID: value.loginuserList![i].createdUserID,
                createdateTime: value.loginuserList![i].createdateTime,
                lastpasswordchanged: value.loginuserList![i].lastpasswordchanged,
                lastupdateIp: value.loginuserList![i].lastupdateIp,
                licensekey: value.loginuserList![i].licensekey,
                lockpin: value.loginuserList![i].lockpin,
                password: value.loginuserList![i].password,
                updatedDatetime: value.loginuserList![i].updatedDatetime,
                updateduserid: value.loginuserList![i].updateduserid,
                userstatus: value.loginuserList![i].userstatus,
                usertype: value.loginuserList![i].usertype));
          }
          print("---------------${usersValues.length}");

          await DBOperation.insertUsers(db, usersValues).then((value) {
            print("---------------4 InsertUsers value");

            notifyListeners();
          });
          await DBOperation.getusers(db);
          notifyListeners();
        } else if (value.loginuserList == null) {
          // exception = value.message!;
          catchmsg.add("Users details: " + value.exception!);
        }
      } else if (value.statuscode >= 400 && value.statuscode <= 410) {
        // exception = value.exception!;
        catchmsg.add("Users details: " + value.exception!);

 await Get.defaultDialog(
                title: "Alert",
                middleText: 'Something Went Wrong',
                backgroundColor: Colors.white,
                titleStyle: TextStyle(color: Colors.red),
                middleTextStyle: TextStyle(color: Colors.black),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text("Close"),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
   
          notifyListeners();
        });

      } else {
        // exception = value.exception!;
        catchmsg.add("Users details: " + value.exception!);
      }
    });
  }

  List<LoginUserData> userdetails = [];
  callLoginApi() async {
    final Database db = (await DBHelper.getInstance())!;
    if (mycontroller[0].text.isNotEmpty && mycontroller[1].text.isNotEmpty) {
      List<Map<String, Object?>> userData = await DBOperation.getusersvaldata(db, mycontroller[0].text.toString());
  //log("userData.length::${userData.length}");
      for (int i = 0; i < userData.length; i++) {
        userdetails.add(LoginUserData(
          autoId: int.parse(userData[i]['autoId'].toString()),
          usercode: userData[i]['usercode'].toString(),
          userName: userData[i]['userName'].toString(),
          branch: userData[i]['branch'].toString(),
          terminal: userData[i]['terminal'].toString(),
          createdUserID: userData[i]['createdUserID'].toString(),
          createdateTime: userData[i]['createdateTime'].toString(),
          lastpasswordchanged: userData[i]['lastpasswordchanged'].toString(),
          lastupdateIp: userData[i]['lastupdateIp'].toString(),
          licensekey: userData[i]['licensekey'].toString(),
          lockpin: userData[i]['lockpin'].toString(),
          password: userData[i]['password'].toString(),
          updatedDatetime: userData[i]['UpdatedDatetime'].toString(),
          updateduserid: int.parse(userData[i]['updateduserid'].toString()),
          userstatus: userData[i]['userstatus'].toString(),
          usertype: userData[i]['usertype'].toString(),
        ));
        notifyListeners();
      }
  //log("HHHHHHH:::::${userdetails[0].usercode.toString()}");

      await LoginUserAPI.getData(userdetails[0].usercode.toString()).then((value) async {
        if (value.statuscode >= 200 && value.statuscode <= 210) {
      //log("value.users length:::${value.loginuserList!.length}");
          if (value.loginuserList != null) {
            for (int i = 0; i < value.loginuserList!.length; i++) {
              if (value.loginuserList![i].userName == mycontroller[0].text && value.loginuserList![i].password == mycontroller[1].text) {
                await SharedPref.saveBranchSP(value.loginuserList![i].branch.toString());
                await SharedPref.saveLicenseSP(value.loginuserList![i].licensekey.toString());
                await SharedPref.saveLoggedInSP(true);
                await SharedPref.saveUserIdeSP(value.loginuserList![i].autoId.toString());
                await SharedPref.saveUserSP(value.loginuserList![i].usercode.toString());

                String? branch = await SharedPref.getBranchSSP();
                String? getLicenseSP = await SharedPref.getLicenseSP();
                bool? getLoggedINSP = await SharedPref.getLoggedINSP();
                String? getUSerSP = await SharedPref.getUSerSP();
                String? getUserIdSP = await SharedPref.getUserIdSP();
            //log("Successfully");
                Get.offNamed(ConstantRoutes.DownloadPage);
                notifyListeners();
              } else {
                settingMsg = 'Invalid Credential..!!';
                notifyListeners();
              }
            }
            notifyListeners();

            notifyListeners();
          } else if (value.loginuserList == null) {
            settingMsg = 'Invalid Credential..!!';
            // catchmsg.add("Users details: " + value.exception!);
            notifyListeners();
          }
        } else if (value.statuscode >= 400 && value.statuscode <= 410) {
          catchmsg.add("Users details: " + value.exception!);
        } else {
          catchmsg.add("Users details: " + value.exception!);
        }
      });
      notifyListeners();
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to exit an app"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("No"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("yes"))
            ],
          ),
        )) ??
        false;
  }

  insertDb(String usc, usn, pass, lockpin, brch, termial, usrSts, usrtp, lcsky, lstpasc, creDt, upDT, int cUID, int upUID, lasIP) async {
    final Database db = (await DBHelper.getInstance())!;
    db.rawQuery("""
insert into Users 
(usercode,username,password,lockpin,branch,terminal,userstatus,usertype,licensekey,lastpasswordchanged,
createdateTime,UpdatedDatetime,createdUserID,updateduserid,lastupdateIp)
values 
('$usc','$usn','$pass','$lockpin','$brch','$termial','$usrSts','$usrtp','$lcsky','$lstpasc',
'$creDt','$upDT','$cUID','$upUID','$lasIP')
 """);
  }

  Future<int?> getUserData() async {
    final Database db = (await DBHelper.getInstance())!;
    final List<Map<String, Object?>> result = await db.rawQuery("select * from Users");

//log('Users ${result}');

    return result.length;
  }

  deleteUser() async {
    final Database db = (await DBHelper.getInstance())!;

    db.rawQuery("delete from users where autoId = 4 ");

    final List<Map<String, Object?>> result = await db.rawQuery("select * from Users");

//log('1 ${result}');
  }
}



//  showDialog(
//                     context: context,
//                     barrierDismissible: true,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                           shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(4))),
//                               contentPadding: EdgeInsets.all(0),
//                               insetPadding: EdgeInsets.all(
//                                   Screens.bodyheight(context) * 0.02),
//                           content: StatefulBuilder(builder: (context, st) {
//       return Container(
//         padding: EdgeInsets.only(
//             top: Screens.padingHeight(context) * 0.01,
//             left: Screens.width(context) * 0.03,
//             right: Screens.width(context) * 0.03,
//             bottom: Screens.padingHeight(context) * 0.01),
//         width: Screens.width(context) * 1.1,
//         // color: Colors.red,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//                 Container(
//                       width: Screens.width(context),
//                       height: Screens.padingHeight(context) * 0.05,
//                       color: theme.primaryColor,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.only(
//                                 left: Screens.padingHeight(context) * 0.02,
//                                 right: Screens.padingHeight(context) * 0.02),
//                             // color: Colors.red,
//                             width: Screens.width(context) * 0.7,
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Alert",
//                               style: theme.textTheme.bodyText2
//                                   ?.copyWith(color: Colors.white),
//                             ),
//                           ),
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: Icon(
//                                 Icons.close,
//                                 size: Screens.padingHeight(context) * 0.025,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                       SizedBox(
//               height: Screens.bodyheight(context) * 0.01,
//             ),
//             Container(
//                 child: Text("Invalid user credential..!!"),
//             ),
//               SizedBox(height: Screens.padingHeight(context) * 0.01),
//             InkWell(
//               onTap: () {
//               st(() {
//               //logCon.ClearSp();
//               });
//               },
//               child: Container(
//               alignment: Alignment.center,
//               height: Screens.padingHeight(context) * 0.045,
//               decoration: BoxDecoration(
//                color: theme.primaryColor,
//               ),
//               child: Center(
//                child: Container(
//                  alignment: Alignment.center,
//                  child: Text(
//                    "Set",
//                    textAlign: TextAlign.center,
//                    style: theme.textTheme.bodyText1
//                        ?.copyWith(color: Colors.white),
//                  ),
//                ),
//               ),
//               ),
//             ),
//       ])));
//     }),
//                           );
//                     });