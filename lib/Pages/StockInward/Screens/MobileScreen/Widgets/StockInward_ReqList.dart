// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable, camel_case_types

import 'package:flutter/material.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../../../../Widgets/ContentContainer.dart';
import '../../../../../Widgets/AlertBox.dart';

class StockIn_ListWidget extends StatelessWidget {
  StockIn_ListWidget({
    Key? key,
    required this.theme,
    required this.StIn_Con,
    required this.SIN_Heigh,
    required this.SIN_Width,
  }) : super(key: key);
  double SIN_Heigh;
  double SIN_Width;

  final ThemeData theme;
  StockInwrdController StIn_Con;

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(SIN_Heigh * 0.012),
      child: Container(
        alignment: Alignment.center,
        height: SIN_Heigh,
        width: SIN_Width,
        padding: EdgeInsets.all(
          SIN_Heigh * 0.008,
        ),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          // border: Border.all(color: theme.primaryColor.withOpacity(0.3))
        ),
        child: SizedBox(
          width: SIN_Width,
          height: SIN_Heigh,
          child:  StIn_Con.StockInward.isEmpty &&
                  StIn_Con.dbDataTrue == true
              ? Center(
                  child: Text(
                    "No data From Stock Outward..!!",
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                )
              : 
              StIn_Con.StockInward.isEmpty &&
                      StIn_Con.dbDataTrue == false
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(), // new

                  itemCount: StIn_Con.StockInward.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(SIN_Heigh * 0.005),
                      child: InkWell(
                        onTap: () {
                         if (StIn_Con.StockInward[index].data.isNotEmpty) {
                           
                            StIn_Con.Selectindex(index);
                            StIn_Con.passINDEX(index);
                            StIn_Con.passList(StIn_Con.StockInward[index].data);
                            StIn_Con.page.animateToPage(++StIn_Con.pageIndex,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.linearToEaseOut);
                          } else if (StIn_Con
                              .StockInward[index].data.isEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: EdgeInsets.all(0),
                                      content: AlertBox(
                                          payMent: 'Alert',
                                          errormsg: true,
                                          widget: Center(
                                              child: ContentContainer(
                                            content:
                                                'This Item Saved in DraftBill..!!',
                                            theme: theme,
                                          )),
                                          buttonName: null));
                                });
                          }
                        },
                        child: Container(
                            width: SIN_Heigh * 0.95,
                            // height: SIN_Heigh * 0.3,
                            padding: EdgeInsets.all(
                              SIN_Heigh * 0.01,
                            ),
                            decoration: BoxDecoration(
                            color: (StIn_Con.totalqty(index) !=
                                            StIn_Con.totalscannedqty(index) &&
                                        StIn_Con.totalValdationqty(index) != 0)
                                    ?
                                    // Colors.red
                                    Color(0xFFfcedee)
                                    // Color(0xFFebfaef)
                                    : (StIn_Con.totalqty(index) ==
                                                StIn_Con.totalscannedqty(
                                                    index) &&
                                            StIn_Con.totalValdationqty(
                                                    index) !=
                                                0)
                                        ?
                                        // Colors.green
                                        Color(0xFFebfaef)
                                        : (StIn_Con.totalqty(index) ==
                                                    StIn_Con.totalscannedqty(
                                                        index) &&
                                                StIn_Con.totalValdationqty(
                                                        index) ==
                                                    0)
                                            ? Colors.white
                                            : Colors.white,
                                    boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                border: Border.all(
                                  color: (StIn_Con.totalqty(index) !=
                                            StIn_Con.totalscannedqty(index) &&
                                        StIn_Con.totalValdationqty(index) != 0)
                                    ?
                                    // Colors.red
                                    Colors.red.withOpacity(0.3)
                                    // Color(0xFFebfaef)
                                    : (StIn_Con.totalqty(index) ==
                                                StIn_Con.totalscannedqty(
                                                    index) &&
                                            StIn_Con.totalValdationqty(
                                                    index) !=
                                                0)
                                        ?
                                        // Colors.green
                                        Colors.green.withOpacity(0.3)
                                        : (StIn_Con.totalqty(index) ==
                                                    StIn_Con.totalscannedqty(
                                                        index) &&
                                                StIn_Con.totalValdationqty(
                                                        index) ==
                                                    0)
                                            ? Colors.white
                                            : Colors.white,
                                )),
                            child: IntrinsicHeight(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: SIN_Width,
                                      // color: Colors.amber,
                                      padding:
                                          EdgeInsets.all(SIN_Heigh * 0.006),
                                      decoration: BoxDecoration(
                                          // color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Text(
                                        "Inventory Transfer From ${StIn_Con.StockInward[index].reqtoWhs}",
                                        // "${StIn_Con.getScanneditemData[index].ItemName}",
                                        style:
                                            theme.textTheme.bodyMedium!.copyWith(
                                          // fontSize: 12,
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: SIN_Heigh * 0.002,
                                    ),
                                    SizedBox(
                                      width: SIN_Width,
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  SIN_Heigh * 0.005),

                                              // width: SIN_Width * 0.3,
                                              decoration: BoxDecoration(
                                                  // color: Colors.grey[600],
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              // color: Colors.blue,
                                              child: Text(
                                                "# ${StIn_Con.StockInward[index].reqtransdate}",
                                                // "${StIn_Con.getScanneditemData[index].SerialBatch}",
                                                style: theme
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                  // color: Colors.green,
                                                  // fontSize: 10,
                                                  // fontWeight:
                                                  //     FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // width: SIN_Width * 0.6,
                                              decoration: BoxDecoration(
                                                  // color: Colors.amber,
                                                  ),
                                              child: Text(
                                                "${StIn_Con.StockInward[index].branch}",
                                                // "${StIn_Con.getScanneditemData[index].ItemCode}",
                                                style: theme
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                        // color: Colors.blueGrey,
                                                        // fontSize: 12,
                                                        // fontWeight:
                                                        //     FontWeight.bold
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                            )),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
