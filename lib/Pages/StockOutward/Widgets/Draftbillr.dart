// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';

class StockOutDraftbill extends StatelessWidget {
  StockOutDraftbill({Key? key, required this.theme, required this.searchHeight, required this.searchWidth, required this.StockOut}) : super(key: key);

  final ThemeData theme;
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
              //   child: Text(" Pending Inwards",
              //       style: theme.textTheme.bodyMedium
              //           ?.copyWith(fontWeight: FontWeight.bold)),
              // ),
              Container(
                height: searchHeight,
                // color: Colors.green,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: ListView.builder(
                    itemCount: StockOut.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<StockOutwardController>().mapvalue(StockOut, index);
                          Navigator.pop(context);
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.only(top: searchHeight * 0.01, left: searchHeight * 0.01, right: searchHeight * 0.01, bottom: searchHeight * 0.01),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.04),
                                borderRadius: BorderRadius.circular(5),
                            
                                border: Border.all(color: Colors.white)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Request From ${StockOut[index].reqfromWhs}", style: theme.textTheme.bodyMedium),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('# ${StockOut[index].documentno}', style: theme.textTheme.bodyMedium),
                                    Text(context.read<StockOutwardController>().config.alignDate(StockOut[index].reqtransdate.toString()), style: theme.textTheme.bodyMedium),
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
