// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/StockOutwardController/StockOutwardController.dart';

class StockOutReqList extends StatefulWidget {
  StockOutReqList(
      {Key? key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth})
      : super(key: key);

  final ThemeData theme;
  double searchHeight;
  double searchWidth;

  @override
  State<StockOutReqList> createState() => _StockOutReqListState();
}

class _StockOutReqListState extends State<StockOutReqList> {
  @override
  Widget build(BuildContext context) {
    return
        //  StockOutReqList(BuildContext context, ThemeData theme,double searchHeight,double searchWidth){
        // final theme = Theme.of(context);
        // return StatefulBuilder(builder: (context, st) {
        //   return
        Container(
            padding: EdgeInsets.only(
              top: widget.searchHeight * 0.02,
              left: widget.searchHeight * 0.01,
              right: widget.searchHeight * 0.01,
              bottom: widget.searchHeight * 0.01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            width: widget.searchWidth * 1,
            //  height:searchHeight*0.9 ,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<StockOutwardController>().deletereq();
                        },
                        child: Text(" Pending Request",
                            style: widget.theme.textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                          onPressed: () {
                            context.read<StockOutwardController>().init();
                          },
                          icon: Icon(Icons.refresh))
                    ],
                  ),
                ),
                SizedBox(
                  height: widget.searchHeight * 0.01,
                ),

                SizedBox(
                  height: widget.searchHeight,
                  // color: Colors.green,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //  borderRadius: BorderRadius.circular(5)
                  //   ),
                  child: context
                          .read<StockOutwardController>()
                          .StockOutward2
                          .isNotEmpty
                      ? ListView.builder(
                          itemCount: context
                              .watch<StockOutwardController>()
                              .StockOutward2
                              .length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: widget.searchHeight * 0.01,
                                      left: widget.searchHeight * 0.01,
                                      right: widget.searchHeight * 0.01,
                                      bottom: widget.searchHeight * 0.01),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey
                                      //         .withOpacity(0.5),
                                      //     spreadRadius: 3,
                                      //     blurRadius: 7,
                                      //     offset: Offset(0,
                                      //         3), // changes position of shadow
                                      //   ),
                                      // ],
                                      border: Border.all(
                                        color: Colors.white,
                                      )
                                      // border: Border.all(
                                      //    color: StOut_Con.StockOutward[index].scanToatal !=
                                      //         StOut_Con.StockOutward[index].transTotal
                                      //     ? Colors.red.withOpacity(0.3)
                                      //     // Color(0xFFfcedee)
                                      //     : (StOut_Con.StockOutward[index].scanToatal ==
                                      //                 StOut_Con.StockOutward[index]
                                      //                     .transTotal) &&
                                      //             (StOut_Con.StockOutward[index]
                                      //                         .scanToatal !=
                                      //                     0 &&
                                      //                 StOut_Con.StockOutward[index]
                                      //                         .transTotal !=
                                      //                     0)
                                      //         ? Colors.green.withOpacity(0.3)
                                      //         // Color(0xFFebfaef)
                                      //         : StOut_Con.mainScannedTotal == 0 &&
                                      //                 StOut_Con.mainTranTotal == 0
                                      //             ? Colors.white
                                      //             : Colors.white,),
                                      ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Request From ${context.watch<StockOutwardController>().StockOutward2[index].reqfromWhs}",
                                          style:
                                              widget.theme.textTheme.bodyLarge),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              context
                                                          .watch<
                                                              StockOutwardController>()
                                                          .StockOutward2[index]
                                                          .docstatus ==
                                                      "3"
                                                  ? "# Against Stock  "
                                                  : "# Against Order ",
                                              style: widget
                                                  .theme.textTheme.bodyLarge),
                                          Text(
                                              context
                                                  .read<
                                                      StockOutwardController>()
                                                  .config
                                                  .alignDate(context
                                                      .read<
                                                          StockOutwardController>()
                                                      .StockOutward2[index]
                                                      .reqtransdate
                                                      .toString()),
                                              style: widget
                                                  .theme.textTheme.bodyLarge)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : context
                                  .read<StockOutwardController>()
                                  .StockOutward
                                  .isEmpty &&
                              context
                                      .read<StockOutwardController>()
                                      .dbDataTrue ==
                                  true &&
                              context
                                  .read<StockOutwardController>()
                                  .savedraftBill
                                  .isEmpty
                          ? Center(
                              child: Text(
                                "No data From Stock Request..!!",
                                style: widget.theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.black),
                              ),
                            )
                          : context
                                      .read<StockOutwardController>()
                                      .StockOutward
                                      .isEmpty &&
                                  context
                                      .read<StockOutwardController>()
                                      .savedraftBill
                                      .isNotEmpty
                              ? Center(
                                  child: Text(
                                    "Data Save as Draft Bill..!!",
                                    style: widget.theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                )
                              : context
                                          .read<StockOutwardController>()
                                          .StockOutward
                                          .isEmpty &&
                                      context
                                              .read<StockOutwardController>()
                                              .dbDataTrue ==
                                          false
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemCount: context
                                          .read<StockOutwardController>()
                                          .StockOutward
                                          .length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              context
                                                      .read<
                                                          StockOutwardController>()
                                                      .StOutController[50]
                                                      .text =
                                                  context
                                                      .read<
                                                          StockOutwardController>()
                                                      .StockOutward[index]
                                                      .remarks!;
                                              context
                                                  .read<
                                                      StockOutwardController>()
                                                  .passData(widget.theme,
                                                      context, index);
                                              context
                                                  .read<
                                                      StockOutwardController>()
                                                  .setstatemethod();
                                            });
                                          },
                                          child: Card(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: widget.searchHeight *
                                                      0.01,
                                                  left: widget.searchHeight *
                                                      0.01,
                                                  right: widget.searchHeight *
                                                      0.01,
                                                  bottom: widget.searchHeight *
                                                      0.01),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: context
                                                                .read<
                                                                    StockOutwardController>()
                                                                .selectIndex ==
                                                            index
                                                        ? Colors.green
                                                        : Colors.white),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "Request From ${context.watch<StockOutwardController>().StockOutward[index].reqfromWhs}  ",
                                                          style: widget
                                                              .theme
                                                              .textTheme
                                                              .bodyLarge),
                                                      Text(
                                                          context
                                                                      .watch<
                                                                          StockOutwardController>()
                                                                      .StockOutward[
                                                                          index]
                                                                      .docstatus ==
                                                                  "3"
                                                              ? "Against Stock"
                                                              : "Against Order",
                                                          style: widget
                                                              .theme
                                                              .textTheme
                                                              .bodyLarge),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "# ${context.watch<StockOutwardController>().StockOutward[index].documentno.toString()}",
                                                          style: widget
                                                              .theme
                                                              .textTheme
                                                              .bodyLarge),
                                                      Text(
                                                          context
                                                              .read<
                                                                  StockOutwardController>()
                                                              .config
                                                              .alignDate(context
                                                                  .watch<
                                                                      StockOutwardController>()
                                                                  .StockOutward[
                                                                      index]
                                                                  .reqtransdate
                                                                  .toString()),
                                                          style: widget
                                                              .theme
                                                              .textTheme
                                                              .bodyLarge)
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
            ));

    // });
  }
}
// }
