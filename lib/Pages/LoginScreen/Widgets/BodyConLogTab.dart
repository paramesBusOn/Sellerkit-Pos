// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/LoginController/LoginController.dart';
import '../../ForgotPassword/Screens/Screens.dart';

class BodyLoginTab extends StatelessWidget {
  const BodyLoginTab({
    super.key,
    required this.height,
    required this.theme,
    required this.width
  });

  //final LoginController logCon;
  final ThemeData theme;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      //  color: Colors.red,
      // margin: EdgeInsets.symmetric(vertical: 10),
      height: height * 0.50,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Form(
        key: context.read<LoginController>().formkey[0],
        child: Column(
          children: [
            context.watch<LoginController>().getSettingMsg.isNotEmpty
                ? SizedBox(
                    width: Screens.width(context),
                    child: Text(
                      context.watch<LoginController>().getSettingMsg,
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                    ),
                  )
                : Container(),
            context.watch<LoginController>().getSettingMsg.isNotEmpty
                ? SizedBox(height: height * 0.02)
                : SizedBox(
                    height: 0,
                  ),
            TextFormField(
              controller: context.read<LoginController>().mycontroller[0],
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.grey[200],
                filled: true,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 3)),
                labelText: 'User',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'User Required';
                }
                return null;
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextFormField(
              controller: context.read<LoginController>().mycontroller[1],
              obscureText: context.read<LoginController>().getHidepassword,
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 3)),
                suffixIcon: IconButton(
                  icon: context.watch<LoginController>().getHidepassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  onPressed: () {
                    context.read<LoginController>().obsecure();
                  },
                ),
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password Required';
                }
                return null;
              },
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 90),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotMainScreen()
                                  // ForgotPasswordPage(
                                  //     forgetHeight:
                                  //         Screens.bodyheight(
                                  //             context),
                                  //     forgetwidth:
                                  //         Screens.width(context)*0.5)
                                  ));
                        },
                        child: Text(
                          'Recover Password?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: width,
              height:height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  context.read<LoginController>().validate(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    )),
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
