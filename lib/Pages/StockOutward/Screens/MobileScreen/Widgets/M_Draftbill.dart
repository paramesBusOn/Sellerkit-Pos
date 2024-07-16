// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';

import '../../../../../Controller/StockOutwardController/StockOutwardController.dart';


class M_StockOutDraftbill extends StatelessWidget {
  M_StockOutDraftbill(
      {Key? key,
      required this.theme,
      required this.prdsrch,
      required this.searchHeight,
      required this.searchWidth,
      required this.StockOut})
      : super(key: key);

  final ThemeData theme;
  StockOutwardController prdsrch;
  double searchHeight;
  double searchWidth;
  List<StockOutwardList> StockOut;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: searchWidth * 1,
        //  height:searchHeight*0.9 ,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: Text("Pending Inwards",
              //       style: theme.textTheme.bodyMedium
              //           ?.copyWith(fontWeight: FontWeight.bold)),
              // ),
              Container(
                height: searchHeight,
                // color: Colors.green,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: ListView.builder(
                    itemCount: StockOut.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                            prdsrch.mapvalue(StockOut, index);
                          Navigator.pop(context);
                      
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Request From ${StockOut[index].reqfromWhs}",
                                    style: theme.textTheme.bodyMedium),
                                Row(
                                  children: [
                                    Text(
                                        "# ${StockOut[index].docentry}  |  ",
                                        style: theme.textTheme.bodyMedium),
                                    Text(
                                        '${StockOut[index].reqtransdate}',
                                        style: theme.textTheme.bodyMedium)
                                  ],
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
