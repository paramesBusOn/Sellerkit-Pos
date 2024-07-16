// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:posproject/Models/DataModel/StockReqModel/orderModel.dart';
import 'package:provider/provider.dart';

class StockReqDraftbill extends StatelessWidget {
  StockReqDraftbill(
      {Key? key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth,
      required this.StockReq})
      : super(key: key);

  final ThemeData theme;
  double searchHeight;
  double searchWidth;
  List<Orderdetails> StockReq;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: searchWidth * 1,
        //  height:searchHeight*0.9 ,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(" Pending Inwards",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Container(
                height: searchHeight,
                // color: Colors.green,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: ListView.builder(
                    itemCount: StockReq.length,
                    itemBuilder: (context, index) {
                      log("StockReq.length::${StockReq.length}");
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          context
                              .read<StockReqController>()
                              .mapData(StockReq, index, context, theme);
                          // prdsrch.StockReqward.addAll(StockReq);
                          // StockReq.removeAt(index);
                          // prdsrch.callList();
                          // Navigator.pop(context);
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: searchHeight * 0.01,
                                left: searchHeight * 0.01,
                                right: searchHeight * 0.01,
                                bottom: searchHeight * 0.01),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                border: Border.all(color: Colors.white)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${StockReq[index].whsAdd!.whsName}",
                                        style: theme.textTheme.bodyMedium),
                                    Row(
                                      children: [
                                        Text(
                                            "${StockReq[index].whsAdd!.whsCode}  |  ",
                                            style: theme.textTheme.bodyMedium),
                                        Text(
                                            '${StockReq[index].whsAdd!.whsCity}',
                                            style: theme.textTheme.bodyMedium)
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  context.watch<StockReqController>().config.aligntimeDate(StockReq[index].whsAdd!.createdateTime.toString()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )

// Container(),
            ],
          ),
        ));
  }
}
