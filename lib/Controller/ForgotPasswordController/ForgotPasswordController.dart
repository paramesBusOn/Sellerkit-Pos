// ignore_for_file: prefer_const_constructors

// import 'dart:math';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Pages/ForgotPassword/widgets/ConfirmPassword.dart';
import 'package:posproject/Pages/LoginScreen/LoginScreen.dart';

import '../../Pages/ForgotPassword/Mobile  Screen/widgets/MobConfirmPassword.dart';

class ForgotPasswordController extends ChangeNotifier {
  ForgotPasswordController() {
    disPosed();
  }
  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(100, (i) => TextEditingController());
//   Config config = new Config();

  String otpMsg = '';
  String get getotpMsg => otpMsg;
  String otpexp = '';
  String get getotpexp => otpexp;
// //random num
  int? randomnum;
  String? randomgenerate;
  String? get getrandomgenerate => randomgenerate;
  String? userrandomgenerate;
  String? get getuserrandomgenerate => userrandomgenerate;

  bool? isLoading = false;
  // bool? isLoading2 = false;
  // bool visibleNPCnt = false;

// //timer visisble
  bool managertimmervisible = false;
  bool get getmanagertimmervisible => managertimmervisible;
  bool usertimmervisible = false;
  bool get getusertimmervisible => usertimmervisible;
// //resend otp
  bool resendOTP = false;
  bool get getresendOTP => resendOTP;
  bool userresendOTP = false;
  bool get getuserresendOTP => userresendOTP;
// //colors
  bool managerotpcompleted = true;
  bool get getmanagerotpcompleted => managerotpcompleted;
  bool usergray = true;
  bool get getusergray => usergray;

//   bool progressVisible = false;
  bool isLoadingRest = false;
// // button non visible
  bool isButtonDisabled = false;
  bool get getisButtonDisabled => isButtonDisabled;
  bool userisButtonDisabled = true;
  bool get getuserisButtonDisabled => userisButtonDisabled;
// //otp box enable
  bool managerboxenable = false;
  bool get getmanagerboxenable => managerboxenable;
  bool userboxenable = false;
  bool get getuserboxenable => userboxenable;
// //confirm password
  String errorMsh = '';
  bool erroMsgVisble = false;

//   List<GlobalKey<FormState>> formkey =
//       List.generate(5, (i) => GlobalKey<FormState>());

  disPosed() {
    // mycontroller[0].dispose();
    // mycontroller[1].dispose();
    // mycontroller[2].dispose();
    // mycontroller[3].dispose();
    // mycontroller[4].dispose();
    // mycontroller[5].dispose();
    // mycontroller[6].dispose();
    mycontroller[0].clear();
    mycontroller[1].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[7].clear();
    isLoading = false;
    // isLoading2 = false;
    // visibleNPCnt = false;
    managertimmervisible = false;
    usertimmervisible = false;
    resendOTP = false;
    // progressVisible = false;
    isLoadingRest = false;
    managerotpcompleted = true;
    usergray = true;
    userboxenable = false;
    managerboxenable = false;
    userisButtonDisabled = true;
    randomgenerate = '';
    userrandomgenerate = '';
    // managerhasError = false;
    // userhasError = false;
    notifyListeners();
  }

  managerpincodecompleted(BuildContext context) {
    print("Completed");
    FocusScope.of(context).requestFocus(FocusNode());
    if (mycontroller[6].text == randomgenerate) {
      print("same OTP:$randomgenerate" == mycontroller[6].text);
      managerotpcompleted = false;
      usergray = false;
      isButtonDisabled = true;
      userisButtonDisabled = false;
      managertimmervisible = false;
      managerboxenable = false;
      resendOTP = false;
    } else if (resendOTP == true) {
      resendOTP = true;
      showOtpNotMatchedtDialog(context, "User OTP is not matched");
      mycontroller[6].clear();
    } else {
      resendOTP = false;
      managertimmervisible = true;
      isButtonDisabled = true;
      managerotpcompleted = true;
      userisButtonDisabled = true;

      showOtpNotMatchedtDialog(context, "User OTP is not matched");
      mycontroller[6].clear();
    }
    notifyListeners();
  }

  userPincodeCompleted(BuildContext context) {
    print("Completed");
    FocusScope.of(context).requestFocus(FocusNode());
    if (mycontroller[7].text == userrandomgenerate) {
      usertimmervisible = false;
      userisButtonDisabled = true;
      usergray = true;
      usertimmervisible = false;
      userboxenable = false;
      // userhasError = false;
      userresendOTP = false;

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConfirmPasswordPage()));
      // Get.toNamed(ConstantRoutes.confirmPassWord);

      notifyListeners();
    } else if (userresendOTP == true) {
      userresendOTP = true;
      showOtpNotMatchedtDialog(context, "Manager OTP is not matched");
      mycontroller[7].clear();
    } else {
      userresendOTP = false;
      usertimmervisible = true;
      usergray = false;
      userisButtonDisabled = true;
      showOtpNotMatchedtDialog(context, "Manager OTP is not matched");
      mycontroller[7].clear();
    }
    notifyListeners();
    Future.delayed(const Duration(seconds: 3));
    // isloadingFalse);
  }

//   void isloadingFalse() {
//     progressVisible = false;
//     resendOTP = false;
//     managerotpcompleted == true;
//     usergray = true;
//     visibleNPCnt = true;
//     notifyListeners();
//     print("Completed22");
//   }

//   void resetClicked(BuildContext context) {
//     if (formkey[2].currentState!.validate()) {
//       isLoadingRest = true;
//       notifyListeners();
//       Future.delayed(const Duration(seconds: 2), () {
//         isLoadingRest = false;
//         notifyListeners();
//         config.disableKeyBoard(context);
//         Get.back();
//       });
//     } else {
//       // final snackBar =
//       //     SnackBar(content: Text("Password doesn't match"));
//       // ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }

  onTime() {
    print("object enddd");
    isButtonDisabled = false; //button not click
    managertimmervisible = false;
    print("isButtonDisabled:$isButtonDisabled");
    resendOTP = true;
    managerboxenable = false;
    randomgenerate = '';
    mycontroller[6].clear();
    notifyListeners();
  }

  useronTime() {
    print("object enddd");
    userisButtonDisabled = false; //button click
    usertimmervisible = false;
    print("isButtonDisabled:$isButtonDisabled");
    userresendOTP = true;
    userboxenable = false;
    mycontroller[7].clear();
    userrandomgenerate = '';
    notifyListeners();
  }

//   resentTimer(BuildContext context) {
//     managertimmervisible = false;
//     print("Data");
//     // resendOTP = true;
//     notifyListeners();
//     Future.delayed(Duration(seconds: 1), () {
//       managertimmervisible = true;
//       usertimmervisible = true;
//       FocusScope.of(context).requestFocus(FocusNode());
//       mycontroller[6].clear();
//       mycontroller[7].clear();
//       notifyListeners();
//     });
//   }

  userwhatsappOTP(BuildContext context) async {
    isButtonDisabled = true;
    notifyListeners();
    randomgenerate = await generateRandomNumber();
    // await UserOTPApi1.getOTPApi1(randomgenerate).then((value) {
    //   if (value.statuscode! >= 200 && value.statuscode! <= 210) {
    //     print("1");
    //     if (value.send == "true") {
    //  Utils. showTopSnackBar(context,'User OTP is $randomgenerate',Colors.red);
    var snackBar = SnackBar(
        duration: Duration(seconds: 6),
      content: Text('User OTP is $randomgenerate'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print("2");
    print("randomgenerate:$randomgenerate");
    managerboxenable = true;
    managertimmervisible = true;
    if (resendOTP == true) {
      // isButtonDisabled = true;
      managertimmervisible = false;
      managerotpcompleted = true;
      resendOTP = true;

      Future.delayed(Duration(seconds: 1), () {
        managertimmervisible = true;
        // isButtonDisabled = true;
        notifyListeners();
      });
    } else {
      isButtonDisabled = true;
      managertimmervisible = true;
    }
    print("randomgenerate.toString():$randomgenerate");
    notifyListeners();
    print("otpMsg:$otpMsg");
    //     } else if (value.send == null) {
    //       print("3");
    //       otpexp = 'No  Data in otp Api..!!';
    //       managertimmervisible = false;
    //     }
    //   } else if (value.statuscode! >= 400 && value.statuscode! <= 410) {
    //     otpexp = 'Something went wrong in otp Api..!!';
    //   } else if (value.statuscode == 500) {
    //     if (value.exception == 'No route to host') {
    //       otpexp = 'Check your Internet Connection...!!';
    //     } else {
    //       otpexp = 'Something went wrong try again...!!';
    //     }
    //   }
    //   notifyListeners();
    // });
  }

  managwhatsappOTP(BuildContext context) async {
    userisButtonDisabled = true;
    notifyListeners();
    userrandomgenerate = await generateRandomNumber();
    // await ManagerOTPApi1.getManagerOTPApi1(userrandomgenerate).then((value) {
    //   if (value.statuscode! >= 200 && value.statuscode! <= 210) {
    var snackBar = SnackBar(
        duration: Duration(seconds: 6),
        dismissDirection: DismissDirection.up,
      content: Text('User OTP is $userrandomgenerate'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print("user1");
    // if (value.send == "true") {
    print("user2");
    print("randomgenerate:$userrandomgenerate");
    // otpMsg = value.send!;
    usertimmervisible = true;
    userboxenable = true;
    userisButtonDisabled = true;
    usergray = false;
    if (userresendOTP == true) {
      userisButtonDisabled = false;
      usertimmervisible = false;
      usergray = false;
      Future.delayed(Duration(seconds: 1), () {
        usertimmervisible = true;
        // userisButtonDisabled = true;
        usergray = false;
        notifyListeners();
      });
      //       } else {
      //         userisButtonDisabled = true;
      //         usertimmervisible = true;
      //         usergray = false;
      //       }
      //       notifyListeners();
      //       print("otpMsg:$otpMsg");
      //     } else if (value.send == null) {
      //       print("3");
      //       otpexp = 'No  Data in otp Api..!!';
      //       usertimmervisible = false;
      //     }
      //   } else if (value.statuscode! >= 400 && value.statuscode! <= 410) {
      //     otpexp = 'Something went wrong in otp Api..!!';
      //   } else if (value.statuscode == 500) {
      //     if (value.exception == 'No route to host') {
      //       otpexp = 'Check your Internet Connection...!!';
      //     } else {
      //       otpexp = 'Something went wrong try again...!!';
      //     }
      //   }
      //   notifyListeners();
      // });
    }
  }

  showOtpNotMatchedtDialog(BuildContext context, String texterror) {
    final theme = Theme.of(context);
    AlertDialog alert = AlertDialog(
      content: Text(
        texterror,
        style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor),
      ),
      actions: [
        MaterialButton(
          child: Container(
              width: Screens.padingHeight(context) * 0.5,
              height: Screens.padingHeight(context) * 0.05,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: theme.primaryColor),
              child: Center(
                child: Text("OK",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white)),
              )),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  valdationconfirmpwd(BuildContext context) {
    if (formkey[2].currentState!.validate()) {
      if (mycontroller[4].text == mycontroller[5].text) {
        print("pwd matched");
        confirmpwd(context);
        notifyListeners();
      } else {
        print("pwd not matched");
      }
    }
  }

// String confirmsuccess='';
  String confirmpwed = '';
// String userNamee='';
// String  licenkey='';

  confirmpwd(BuildContext context) async {
//   await HelperFunctions.getLogginUserCodeSharedPreference ().then((value) {
//       if (value != null) {
//         userNamee = value;
//            print("con userNamee: ${userNamee}");
//       }});

// await HelperFunctions.getLicenseKeySharedPreference ().then((value) {
//       if (value != null) {
//         licenkey = value;
//            print("con licenkey : ${licenkey}");
//       }

//     });
    confirmpwed = mycontroller[5].text;
//   await ConfirmPwdAPi.getConfirmPwdData(userNamee,licenkey,confirmpwed).then((value) async {
//   if (value.statuscode! >= 200 && value.statuscode! <= 210) {
//   print("SSSSSSSSSSs");
//   if (value.status=='Success') {
//             confirmsuccess=value.updateMsg.toString();

    confirmPwdDialog(context, "Your Password is Successfully Changed");
    isLoading = false;
    erroMsgVisble = false;
    errorMsh = '';
    print("confirmpwed:$confirmpwed");
// print("confirmsuccess:${value.updateMsg}");

    notifyListeners();
//  Future.delayed(Duration(seconds: 2), () {

//     });
//        }  } else if (value.status=='Failed') {

//             isLoading = false;
//             erroMsgVisble = true;
//             errorMsh = value.updateMsg!;
//             print("errorMsh:$errorMsh");
//             notifyListeners();
//           }

//         else if (value.statuscode! >= 400 && value.statuscode! <= 420) {
//        isLoading = false;
//             erroMsgVisble = true;
//         errorMsh = value.exception!;
//         print("value.exception:${value.exception}");
//       }
//         else {
//           if (value.exception == 'No route to host') {
//             isLoading = false;
//             erroMsgVisble = true;
//             errorMsh = 'Check your Internet Connection...!!';
//           } else {
//             isLoading = false;
//             erroMsgVisble = true;
//             errorMsh = 'Something went wrong try again...!!';
//           }
//           notifyListeners();
//         }
//       });
    // Get.offAllNamed(ConstantRoutes.dashboard);
    // }
  }

  confirmPwdDialog(BuildContext context, String texterror) {
    showDialog<dynamic>(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            final theme = Theme.of(context);
            return WillPopScope(
              onWillPop: () => Future.value(false),
              child: AlertDialog(
                content: Text(
                  texterror,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.primaryColor),
                ),
                actions: [
                  MaterialButton(
                    child: Container(
                        width: Screens.padingHeight(context) * 0.5,
                        height: Screens.padingHeight(context) * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: theme.primaryColor),
                        child: Center(
                          child: Text("OK",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white)),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                      // Get.offAllNamed(ConstantRoutes.login);
                    },
                  )
                ],
              ),
            );
          });
        });
  }
  // DateTime? currentBackPressLoginn;

  //  Future<bool> onbackpresslogin1() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressLoginn == null ||
  //       now.difference(currentBackPressLoginn!) > Duration(seconds: 2)) {
  //     currentBackPressLoginn = now;
  //     Get.offAllNamed(ConstantRoutes.login);
  //     return Future.value(false);
  //   }
  //   return Future.value(false);
  // }

  Future<String> generateRandomNumber() {
    var random = Random();
    for (var i = 0; i < 4; i++) {
      randomnum = random.nextInt(9999) + 1000;
    }
    print(randomnum);
    notifyListeners();

    return Future.value(randomnum.toString().substring(0, 4));
  }

  forMobUserPincodeCompleted(BuildContext context) {
    print("Completed");
    FocusScope.of(context).requestFocus(FocusNode());
    if (mycontroller[7].text == userrandomgenerate) {
      usertimmervisible = false;
      userisButtonDisabled = true;
      usergray = true;
      usertimmervisible = false;
      userboxenable = false;
      // userhasError = false;
      userresendOTP = false;

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MobileConfirmPassword()));
      // Get.toNamed(ConstantRoutes.confirmPassWord);

      notifyListeners();
    } else if (userresendOTP == true) {
      userresendOTP = true;
      showOtpNotMatchedtDialog(context, "Manager OTP is not matched");
      mycontroller[7].clear();
    } else {
      userresendOTP = false;
      usertimmervisible = true;
      usergray = false;
      userisButtonDisabled = true;
      showOtpNotMatchedtDialog(context, "Manager OTP is not matched");
      mycontroller[7].clear();
    }
    notifyListeners();
    Future.delayed(const Duration(seconds: 3));
    // isloadingFalse);
  }
//   ElevatedButton(
//       onPressed: () {
//         var snackBar = SnackBar(content: Text('Hello World'));
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       },
//       child: Text('Show SnackBar'),
//     ),
//   );
// }
}
