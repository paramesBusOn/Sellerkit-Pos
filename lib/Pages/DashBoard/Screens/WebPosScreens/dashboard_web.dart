// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Pages/DashBoard/Widget/AnnounceMent.dart';
import 'package:posproject/Pages/DashBoard/Widget/SalesDetails.dart';
import 'package:posproject/Pages/DashBoard/Widget/StockTable.dart';
import 'package:posproject/Pages/DashBoard/Widget/Transaction.dart';
import 'package:posproject/Pages/DashBoard/Widget/Userlogindetail.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/DashBoardController/DashboardController.dart';

class DashboardWeb extends StatefulWidget {
  DashboardWeb({super.key, required this.theme});
  ThemeData theme;

  @override
  State<DashboardWeb> createState() => _TabDashScreenState();
}

class _TabDashScreenState extends State<DashboardWeb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Column(children: [
        AppBar(
          title: const Text("Dashboard"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    context.read<DashBoardController>().refresh();
                  });
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        Container(
          padding: EdgeInsets.all(
            Screens.bodyheight(context) * 0.005,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  // top: Screens.bodyheight(context) * 0.02,
                  left: Screens.bodyheight(context) * 0.01,
                  right: Screens.bodyheight(context) * 0.01,
                  bottom: Screens.bodyheight(context) * 0.01,
                ),
                // height: Screens.bodyheight(context) * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserLoginDetail(
                      theme: widget.theme,
                      userWidth: Screens.width(context) * 0.49,
                      userheight: Screens.bodyheight(context) * 0.09,
                    ),
                    SizedBox(height: Screens.bodyheight(context) * 0.01),
                    SalesDetails(
                      theme: widget.theme,
                      salesWidth: Screens.width(context) * 0.49,
                      salesheight: Screens.bodyheight(context) * 0.355,
                      // salesheight: Screens.bodyheight(context) * 0.35,
                    ),
                    SizedBox(height: Screens.bodyheight(context) * 0.02),
                    Announcement(
                      theme: widget.theme,
                      dbHeight: Screens.bodyheight(context) * 0.31,
                      dbWidth: Screens.width(context) * 0.49,
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StockTable(
                    theme: widget.theme,
                    dbHeight: Screens.bodyheight(context) * 0.4,
                    dbWidth: Screens.width(context) * 0.49,
                  ),
                  SizedBox(height: Screens.bodyheight(context) * 0.02),
                  Transaction(
                    theme: widget.theme,
                    dbHeight: Screens.bodyheight(context) * 0.4,
                    dbWidth: Screens.width(context) * 0.49,
                  )
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
