// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable, camel_case_types, unused_import
import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import '../../../../../Controller/StockOutwardController/StockOutwardController.dart';
import '../../../../../Widgets/ContentContainer.dart';
import 'package:posproject/Widgets/AlertBox.dart';

class StockOut_ListWidget extends StatelessWidget {
  StockOut_ListWidget({
    Key? key,
    required this.theme,
    required this.StOut_Con,
    required this.SOut_Heigh,
    required this.SOut_Width,
  }) : super(key: key);
  double SOut_Heigh;
  double SOut_Width;

  final ThemeData theme;
  StockOutwardController StOut_Con;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(SOut_Heigh * 0.012),
      child: Container(
        alignment: Alignment.center,
        height: SOut_Heigh,
        width: SOut_Width,
        padding: EdgeInsets.all(
          SOut_Heigh * 0.008,
        ),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          // border: Border.all(color: theme.primaryColor.withOpacity(0.3))
        ),
        child: SizedBox(
          width: SOut_Width,
          height: SOut_Heigh,
          child: StOut_Con.StockOutward.isEmpty &&
                  StOut_Con.dbDataTrue == true &&
                  StOut_Con.savedraftBill.isEmpty
              ? Center(
                  child: Text(
                    "No data From Stock Request..!!",
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                )
              : StOut_Con.StockOutward.isEmpty &&
                      StOut_Con.savedraftBill.isNotEmpty
                  ? Center(
                      child: Text(
                        "Data Save as Draft Bill..!!",
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.black),
                      ),
                    )
                  : StOut_Con.StockOutward.isEmpty &&
                          StOut_Con.dbDataTrue == false
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(), // new

                          itemCount: StOut_Con.StockOutward.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(SOut_Heigh * 0.005),
                              child: InkWell(
                                onTap: () {
                                  if (StOut_Con
                                      .StockOutward[index].data.isNotEmpty) {
                                    StOut_Con.Selectindex(index);
                                    StOut_Con.passINDEX(index);
                                    StOut_Con.passList(
                                        StOut_Con.StockOutward[index].data);
                                    // StOut_Con.page.animateToPage(
                                    //     ++StOut_Con.pageIndex,
                                    //     duration: Duration(milliseconds: 400),
                                    //     curve: Curves.linearToEaseOut);
                                  } else if (StOut_Con
                                      .StockOutward[index].data.isEmpty) {
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
                                    width: SOut_Heigh * 0.95,
                                    // height: SOut_Heigh * 0.3,
                                    padding: EdgeInsets.all(
                                      SOut_Heigh * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                        color: (StOut_Con.totalqty(index) !=
                                                    StOut_Con.totalscannedqty(
                                                        index) &&
                                                StOut_Con.totalValdationqty(
                                                        index) !=
                                                    0)
                                            ?
                                            // Colors.red
                                            Color(0xFFfcedee)
                                            // Color(0xFFebfaef)
                                            : (StOut_Con.totalqty(index) ==
                                                        StOut_Con.totalscannedqty(
                                                            index) &&
                                                    StOut_Con.totalValdationqty(
                                                            index) !=
                                                        0)
                                                ?
                                                // Colors.green
                                                Color(0xFFebfaef)
                                                : (StOut_Con.totalqty(index) ==
                                                            StOut_Con
                                                                .totalscannedqty(
                                                                    index) &&
                                                        StOut_Con.totalValdationqty(
                                                                index) ==
                                                            0)
                                                    ? Colors.white
                                                    : Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        border: Border.all(
                                          color: (StOut_Con.totalqty(index) !=
                                                      StOut_Con.totalscannedqty(
                                                          index) &&
                                                  StOut_Con.totalValdationqty(
                                                          index) !=
                                                      0)
                                              ?
                                              // Colors.red
                                              Colors.red.withOpacity(0.3)
                                              // Color(0xFFebfaef)
                                              : (StOut_Con.totalqty(index) ==
                                                          StOut_Con.totalscannedqty(
                                                              index) &&
                                                      StOut_Con.totalValdationqty(
                                                              index) !=
                                                          0)
                                                  ?
                                                  // Colors.green
                                                  Colors.green.withOpacity(0.3)
                                                  : (StOut_Con.totalqty(index) ==
                                                              StOut_Con.totalscannedqty(
                                                                  index) &&
                                                          StOut_Con.totalValdationqty(
                                                                  index) ==
                                                              0)
                                                      ? Colors.white
                                                      : Colors.white,
                                        )),
                                    child: IntrinsicHeight(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: SOut_Width,
                                              // color: Colors.amber,
                                              padding: EdgeInsets.all(
                                                  SOut_Heigh * 0.006),
                                              decoration: BoxDecoration(
                                                  // color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Text(
                                                "Request From ${StOut_Con.StockOutward[index].reqfromWhs}",
                                                // "${StOut_Con.getScanneditemData[index].ItemName}",
                                                style: theme
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                        // fontSize: 12,
                                                        // color: Colors.grey,
                                                        // fontWeight: FontWeight.bold
                                                        ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: SOut_Heigh * 0.002,
                                            ),
                                            SizedBox(
                                              width: SOut_Width,
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                          SOut_Heigh * 0.005),

                                                      // width: SOut_Width * 0.3,
                                                      decoration: BoxDecoration(
                                                          // color: Colors.grey[600],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      // color: Colors.blue,
                                                      child: Text(
                                                        StOut_Con
                                                                    .StockOutward[
                                                                        index]
                                                                    .docstatus ==
                                                                "3"
                                                            ? "# Stock Against "
                                                            : "# Stock Order ",
                                                        // "${StOut_Con.getScanneditemData[index].SerialBatch}",
                                                        style: theme.textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                // color: Colors.green,
                                                                // fontSize: 10,
                                                                // fontWeight:
                                                                //     FontWeight.bold
                                                                ),
                                                      ),
                                                    ),
                                                    Container(
                                                      // width: SOut_Width * 0.6,
                                                      decoration: BoxDecoration(
                                                          // color: Colors.amber,
                                                          ),
                                                      child: Text(
                                                        "${StOut_Con.StockOutward[index].reqtransdate}",
                                                        // "${StOut_Con.getScanneditemData[index].ItemCode}",
                                                        style: theme.textTheme
                                                            .bodyMedium!
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
