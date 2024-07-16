// ignore_for_file: avoid_redundant_argument_values, avoid_print, unnecessary_lambdas, prefer_const_constructors, prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/ForgotPasswordController/ForgotPasswordController.dart';
import '../../../Controller/LoginController/LoginController.dart';
import '../../../Widgets/custom_elevatedBtn.dart';

class ForgotBodySection extends StatefulWidget {
  ForgotBodySection(
      {Key? key, required this.forgetHeight, required this.forgetwidth})
      : super(key: key);

  double forgetHeight;
  double forgetwidth;

  @override
  _ForgotBodySectionState createState() => _ForgotBodySectionState();
}

class _ForgotBodySectionState extends State<ForgotBodySection> {
  Paddings constant = Paddings();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider<ForgotPasswordController>(
        create: (context) => ForgotPasswordController(),
        builder: (context, child) {
          return Consumer<ForgotPasswordController>(
              builder: (BuildContext context, prdfpw, Widget? child) {
            return Container(
                alignment: Alignment.center,
                width: widget.forgetwidth,
                padding: constant.padding2(context),
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: widget.forgetwidth,
                          child: Text(
                            "Forgot Password",
                            style: theme.textTheme.titleLarge
                                ?.copyWith(color: theme.primaryColor),
                          ),
                        ),

                        Form(
                          key: prdfpw.formkey[0],
                          // child: Visibility(
                          //   visible: prdfpw.managertimmervisible,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: widget.forgetHeight * 0.04,
                                  // Screens.padingHeight(context) * 0.04,
                                ),
                                Center(
                                  child: Container(
                                      padding: EdgeInsets.all(
                                          widget.forgetHeight * 0.02),
                                      // padding: constant.padding2(context),
                                      width: widget.forgetwidth * 0.65,
                                      // height: Screens.padingHeight(context) * 0.08,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                prdfpw.getmanagerotpcompleted ==
                                                        true
                                                    ? theme.primaryColor
                                                    : Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        children: [
                                          Container(
                                              child: Text(
                                            "User OTP",
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                    color:
                                                        prdfpw.getmanagerotpcompleted ==
                                                                true
                                                            ? theme.primaryColor
                                                            : Colors.grey),
                                          )),
                                          SizedBox(
                                            height: widget.forgetHeight * 0.03,
                                            // Screens.padingHeight(
                                            //         context) *
                                            //     0.03
                                          ),
                                          PinCodeTextField(
                                            autoFocus: true,
                                            enablePinAutofill: true,
                                            enabled: prdfpw.getmanagerboxenable,
                                            appContext: context,
                                            pastedTextStyle: TextStyle(
                                              color: Colors.blue.shade600, //
                                              fontWeight: FontWeight.bold,
                                            ),
                                            autoDisposeControllers: true,
                                            length: 4,
                                            obscureText: true,
                                            obscuringCharacter: '*',
                                            blinkWhenObscuring: true,
                                            animationType: AnimationType.fade,
                                            pinTheme: PinTheme(
                                              shape: PinCodeFieldShape.box,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              fieldHeight:
                                                  widget.forgetHeight * 0.07,
                                              // Screens.padingHeight(
                                              //         context) *
                                              //     0.07,
                                              fieldWidth:
                                                  widget.forgetwidth * 0.12,
                                              inactiveFillColor: Colors.white,
                                              inactiveColor:
                                                  prdfpw.getmanagerotpcompleted ==
                                                          true
                                                      ? theme.primaryColor
                                                      : Colors.grey,
                                              activeFillColor: Colors.white,
                                              activeColor:
                                                  prdfpw.getmanagerotpcompleted ==
                                                          true
                                                      ? theme.primaryColor
                                                      : Colors.grey,
                                              selectedColor: theme.primaryColor,
                                              selectedFillColor:
                                                  theme.disabledColor,
                                            ),
                                            cursorColor: theme.primaryColor,
                                            animationDuration:
                                                Duration(milliseconds: 300),
                                            enableActiveFill: true,
                                            controller: prdfpw.mycontroller[6],
                                            keyboardType: TextInputType.number,
                                            boxShadows: const [
                                              BoxShadow(
                                                offset: Offset(0, 1),
                                                color: Colors.black12,
                                                blurRadius: 10,
                                              )
                                            ],
                                            onCompleted: (manval) {
                                              prdfpw.managerpincodecompleted(
                                                  context);
                                            },
                                            onChanged: (manvalue) {
                                              print("manvalue:" + manvalue);
                                              //        if (prdfpw.mycontroller[4].text !=
                                              //     prdfpw.mycontroller[5].text) {
                                              //   return "*Not Match";
                                              // } else if (prdfpw
                                              //     .mycontroller[5].text.isEmpty) {
                                              //   return "Please Enter Password";
                                              // }

                                              // return null;
                                            },
                                            beforeTextPaste: (text) {
                                              print("Allowing to paste $text");
                                              return true;
                                            },
                                          ),
                                          // Visibility(
                                          // visible:
                                          //     prdfpw.getmanagerhasError,
                                          //  child: showOtpNotMatchedtDialog(context)
                                          // Text(
                                          //   "*User OTP is not matched",
                                          //   style: theme
                                          //       .textTheme.bodyText2
                                          //       ?.copyWith(
                                          //           color: theme
                                          //               .primaryColor),
                                          // )
                                          // ),
                                          Visibility(
                                            visible:
                                                prdfpw.getmanagertimmervisible,
                                            child: TweenAnimationBuilder<
                                                    Duration>(
                                                duration: Duration(seconds: 60),
                                                tween: Tween(
                                                    begin:
                                                        Duration(seconds: 60),
                                                    end: Duration.zero),
                                                onEnd: () {
                                                  prdfpw.onTime();
                                                  // .resentTimer(context);
                                                  //   print('Timer ended');
                                                  // Get.back();
                                                },
                                                builder: (BuildContext context,
                                                    Duration value,
                                                    Widget? child) {
                                                  final minutes =
                                                      value.inMinutes;

                                                  final seconds =
                                                      value.inSeconds % 60;

                                                  return Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical:
                                                              Screens.width(
                                                                      context) *
                                                                  0.005),
                                                      child: Text(
                                                          '$minutes:$seconds',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: widget
                                                                      .forgetwidth *
                                                                  0.055)));
                                                }),
                                          ),
                                          SizedBox(
                                            height: widget.forgetHeight * 0.03,
                                            // Screens.padingHeight(
                                            //     context) *
                                            // 0.03,
                                          ),
                                          CustomSpinkitdButton(
                                            onTap:
                                                //  () {
                                                prdfpw.getisButtonDisabled ==
                                                        true
                                                    ? null
                                                    : () {
                                                        print("loadingg,,,,: " +
                                                            LoginController
                                                                .loginPageScrn
                                                                .toString());
                                                        prdfpw
                                                            .userwhatsappOTP(context);
                                                      },
                                            label: prdfpw.getresendOTP == false
                                                ? 'Send OTP'
                                                : "Resend OTP",
                                            labelLoading:
                                                prdfpw.getresendOTP == false
                                                    ? "Send OTP"
                                                    : "Resend OTP",
                                            textcolor:
                                                prdfpw.getmanagerotpcompleted ==
                                                        true
                                                    ? Colors.white
                                                    : Colors.grey,
                                          )
                                        ],
                                      )),
                                ),
                              ]),
                        ),
                        SizedBox(height: widget.forgetHeight * 0.08
                            // Screens.padingHeight(context) * 0.08,
                            ),
                        // ),

                        Form(
                            key: prdfpw.formkey[1],
                            child: Center(
                              child: Container(
                                  // padding: constant.padding2(context),
                                  // width: widget.forgetwidth * 0.85,
                                  width: widget.forgetwidth * 0.65,
                                  padding: EdgeInsets.all(
                                      widget.forgetHeight * 0.02),
                                  // height: Screens.padingHeight(context) * 0.08,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: prdfpw.getusergray == true
                                            ? Colors.grey
                                            : theme.primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    children: [
                                      Container(
                                          child: Text(
                                        "Manager OTP",
                                        style:
                                            theme.textTheme.titleMedium?.copyWith(
                                          color: prdfpw.getusergray == true
                                              ? Colors.grey
                                              : theme.primaryColor,
                                        ),
                                      )),
                                      SizedBox(
                                          height: widget.forgetHeight * 0.03),
                                      // Screens.padingHeight(context) *
                                      //     0.03),
                                      PinCodeTextField(
                                        autoFocus: true,
                                        enablePinAutofill: true,
                                        enabled: prdfpw.getuserboxenable,
                                        appContext: context,
                                        pastedTextStyle: TextStyle(
                                          color: Colors.blue.shade600, //
                                          fontWeight: FontWeight.bold,
                                        ),
                                        autoDisposeControllers: false,
                                        length: 4,
                                        obscureText: true,
                                        obscuringCharacter: '*',
                                        blinkWhenObscuring: true,
                                        animationType: AnimationType.fade,
                                        pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          fieldHeight:
                                              widget.forgetHeight * 0.07,
                                          // Screens.padingHeight(context) *
                                          //     0.07,
                                          fieldWidth: widget.forgetwidth * 0.12,
                                          inactiveFillColor: Colors.white,
                                          inactiveColor:
                                              prdfpw.getusergray == true
                                                  ? Colors.grey
                                                  : theme.primaryColor,
                                          activeFillColor: Colors.white,
                                          activeColor:
                                              prdfpw.getusergray == true
                                                  ? Colors.grey
                                                  : theme.primaryColor,
                                          selectedColor: theme.primaryColor,
                                          selectedFillColor:
                                              theme.disabledColor,
                                        ),
                                        cursorColor: theme.primaryColor,
                                        animationDuration:
                                            Duration(milliseconds: 300),
                                        enableActiveFill: true,
                                        controller: prdfpw.mycontroller[7],
                                        keyboardType: TextInputType.number,
                                        boxShadows: const [
                                          BoxShadow(
                                            offset: Offset(0, 1),
                                            color: Colors.black12,
                                            blurRadius: 10,
                                          )
                                        ],
                                        onCompleted: (userv) {
                                          prdfpw.userPincodeCompleted(context);
                                        },
                                        onChanged: (uservalue) {},
                                        beforeTextPaste: (usertext) {
                                          print("Allowing to paste $usertext");
                                          return true;
                                        },
                                      ),
                                      // Visibility(
                                      //     visible: prdfpw.getuserhasError,
                                      //     child: Text(
                                      //       "*Manager OTP is not matched",
                                      // style: theme.textTheme.bodyText2
                                      //     ?.copyWith(
                                      //         color:
                                      //             theme.primaryColor),
                                      //     )),
                                      Visibility(
                                        visible: prdfpw.getusertimmervisible,
                                        child: TweenAnimationBuilder<Duration>(
                                            duration: Duration(seconds: 60),
                                            tween: Tween(
                                                begin: Duration(seconds: 60),
                                                end: Duration.zero),
                                            onEnd: () {
                                              //   print('Timer ended');
                                              // Get.back();
                                              prdfpw.useronTime();
                                            },
                                            builder: (BuildContext context,
                                                Duration value, Widget? child) {
                                              final minutes = value.inMinutes;

                                              final seconds =
                                                  value.inSeconds % 60;

                                              return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          widget.forgetwidth *
                                                              0.005),
                                                  child: Text(
                                                      '$minutes:$seconds',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: widget
                                                                  .forgetwidth *
                                                              0.055)));
                                            }),
                                      ),
                                      SizedBox(
                                          height: widget.forgetHeight *
                                              // Screens.padingHeight(context) *
                                              0.03),
                                      CustomSpinkitdButton(
                                          onTap:
                                              prdfpw.getuserisButtonDisabled ==
                                                      true
                                                  ? null
                                                  : () {
                                                      prdfpw.managwhatsappOTP(context);
                                                    },
                                          label:
                                              prdfpw.getuserresendOTP == false
                                                  ? 'Send OTP'
                                                  : "Resend OTP",
                                          labelLoading:
                                              prdfpw.getuserresendOTP == false
                                                  ? "Send OTP"
                                                  : "Resend OTP",
                                          textcolor: prdfpw.getusergray == true
                                              ? Colors.grey
                                              : Colors.white)
                                    ],
                                  )),
                            ))
                      ]),
                ));
          });
        });
  }
}
