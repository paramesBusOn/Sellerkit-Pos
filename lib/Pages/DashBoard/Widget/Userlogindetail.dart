// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Constant/AppConstant.dart';
import 'package:provider/provider.dart';

import '../../../Constant/UserValues.dart';
import '../../../Controller/DashBoardController/DashboardController.dart';

class UserLoginDetail extends StatefulWidget {
  UserLoginDetail({
    super.key,
    required this.theme,
    required this.userWidth,
    required this.userheight,
  });
  double userheight;
  double userWidth;
  ThemeData theme;

  @override
  State<UserLoginDetail> createState() => _UserLoginDetailState();
}

class _UserLoginDetailState extends State<UserLoginDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.userheight,
        width: widget.userWidth,
        padding: EdgeInsets.all(widget.userheight * 0.008),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white
            // color: Colors.grey.withOpacity(0.1),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: widget.userWidth * 0.56,
                  child: Row(
                    children: [
                      Container(
                          width: widget.userWidth * 0.16,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "User Name  ",
                            style: widget.theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                          )),
                      Container(
                          width: widget.userWidth * 0.4,
                          //  height: userheight * 1.2,
                          //  color: Colors.black,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '  ${UserValues.username}',
                            style: widget.theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                          )),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: userWidth * 0.0,
                // ),
                SizedBox(
                  width: widget.userWidth * 0.4,
                  // color: Colors.red,
                  // width: userWidth * 0.22,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          alignment: Alignment.centerRight,
                          width: widget.userWidth * 0.16,
                          child: Text(
                            "Logged In ",
                            style: widget.theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                          )),
                      Container(
                          width: widget.userWidth * 0.2,
                          alignment: Alignment.centerRight,
                          child: Text(
                            context.watch<DashBoardController>().config.alignDate(context.watch<DashBoardController>().config.currentDate()),
                            style: widget.theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  // color: Colors.blueAccent,
                  width: widget.userWidth * 0.56,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: widget.userWidth * 0.16,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Branch  ",
                            style: widget.theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                          )),
                      // Container(
                      //   alignment: Alignment.center,
                      //   child:
                      //       Text(':', style: theme.textTheme.bodyText2?.copyWith()),
                      // ),
                      Container(
                          width: widget.userWidth * 0.4,
                        
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppConstant.branch,
                            style: widget.theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: widget.userWidth * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          width: widget.userWidth * 0.16,
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Terminal  ",
                            style: widget.theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                          )),
                      Container(
                          width: widget.userWidth * 0.2,
                          alignment: Alignment.centerRight,
                          child: Text(
                            AppConstant.terminal,
                            style: widget.theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
