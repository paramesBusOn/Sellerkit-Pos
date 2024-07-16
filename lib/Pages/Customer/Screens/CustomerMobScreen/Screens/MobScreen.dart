// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/CustomerController/CustomerController.dart';
import '../Widget/MobCustomerdetailPage.dart';
import '../Widget/MobSearchwidget.dart';


class MobCustomerScreens extends StatefulWidget {
   MobCustomerScreens({super.key,required this.stkCtrl});
CustomerController stkCtrl;

  @override
  State<MobCustomerScreens> createState() => _MobCustomerScreensState();
}

class _MobCustomerScreensState extends State<MobCustomerScreens> {
  @override
  Widget build(BuildContext context) {
    return Container(

        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.05),
      ),
      padding: EdgeInsets.only(
          top: Screens.bodyheight(context) * 0.01,
          bottom: Screens.bodyheight(context) * 0.01,
          left: Screens.width(context) * 0.01,
          right: Screens.width(context) * 0.01),
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.95,
      child: 
      
      PageView(
        scrollDirection: Axis.horizontal,
                        pageSnapping: true,
                           controller: widget.stkCtrl.tappage,
                        //  physics: new NeverScrollableScrollPhysics(),
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MobSearch_Widget(
                    stChCon:widget.stkCtrl,
                    searchHeight: Screens.bodyheight(context),
                    searchWidth: Screens.width(context)),
                   
              ],
            ),
         
          ),
         MobCustomerdetailPage(
          stChCon: widget.stkCtrl, 
          searchHeight: Screens.bodyheight(context), 
          searchWidth: Screens.width(context),
          cusList:widget.stkCtrl.cusList1,
          )
        ],
      ),
    );
  }
}