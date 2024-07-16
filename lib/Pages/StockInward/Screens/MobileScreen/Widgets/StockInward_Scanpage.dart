// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import '../../../../../Constant/Screen.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../../../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';

class MyWidget extends StatefulWidget {
  MyWidget(
      {Key? key,
      required this.StIn_Con,
      required this.datalist,
      required this.ind,
      required this.index})
      : super(key: key);
  StockInwrdController StIn_Con;
  StockInwardDetails? datalist;
  int? ind;
  int? index;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double StOut_Height = Screens.bodyheight(context) * 0.5;
    double StOut_Width = Screens.width(context);

    return Container(
      padding: EdgeInsets.only(
          top: StOut_Height * 0.01,
          left: StOut_Height * 0.01,
          right: StOut_Height * 0.01,
          bottom: StOut_Height * 0.008),
      child: SingleChildScrollView(
        //  shrinkWrap: true,
        physics: const BouncingScrollPhysics(), // new
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: StOut_Width,
              padding: EdgeInsets.all(
                StOut_Height * 0.01,
              ),
              // height: StOut_Height * 0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: StOut_Height * 0.6,
                    // color: Colors.amber,
                    child: Text("Itemcode\n${widget.datalist!.itemcode}"),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    // width:StOut_Height * 0.2,
                    // color: Colors.amber,
                    child: Text("SerialBatch\n${widget.datalist!.serialBatch}"),
                  )
                ],
              ),
            ),
            SizedBox(
              height: StOut_Height * 0.015,
            ),
            Container(
                height: StOut_Height * 1.58,
                width: StOut_Width * 1.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: StOut_Height * 0.015,
                    ),
                    Container(
                      width: StOut_Width * 0.95,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 190, 183, 183)),
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: widget.StIn_Con.StInController[0],
                        cursorColor: Colors.grey,
                        onChanged: (v) {
                          if (v.isNotEmpty) {
                            setState(() {
                              widget.StIn_Con.msg = "";
                            });
                          }
                        },
                        onEditingComplete: () {
                          setState(() {
                            // widget.StIn_Con.scanmethod(widget.index!,
                            //     widget.datalist!.serialBatch!, widget.ind!);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Scan here..',
                          hintStyle: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey),
                          filled: false,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            // vertical: 12,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.StIn_Con.msg}",
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: StOut_Height * 0.001),
                    widget.datalist!.serialbatchList == null
                        ? Center(
                            child: Text("Scan Item.."),
                          )
                        : widget.StIn_Con.OnScanDisable==true? Center(
                            child: CircularProgressIndicator(),
                          ) :ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(), // new

                            itemCount: widget.datalist!.serialbatchList!.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                  padding: EdgeInsets.all(StOut_Height * 0.005),
                                  child: Container(
                                    width: StOut_Height * 0.95,
                                    // height: ProHeight * 0.3,
                                    padding: EdgeInsets.all(
                                        Screens.bodyheight(context) * 0.008),
                                    decoration: BoxDecoration(
                                        color:
                                            //     datalist.serialbatchList![i].scanbool ==
                                            //             true
                                            //         ? Color(0xFFebfaef)
                                            //         : Colors.white,
                                            // border: Border.all(
                                            //     color: datalist.serialbatchList![i]
                                            //                 .scanbool ==
                                            //             true
                                            //         ? Colors.green.withOpacity(0.3)
                                            //         :
                                            Colors.white,
                                        //  ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      Screens.width(context) *
                                                          0.45,
                                                  // color: Colors.amber,
                                                  child: Text(
                                                    widget
                                                        .datalist!
                                                        .serialbatchList![i]
                                                        .itemcode!,
                                                    style: theme
                                                        .textTheme.bodyMedium,
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  width:
                                                      Screens.width(context) *
                                                          0.4,
                                                  // color: Colors.blue,
                                                  child: Text(
                                                    widget
                                                        .datalist!
                                                        .serialbatchList![i]
                                                        .serialbatch!,
                                                    style: theme
                                                        .textTheme.bodyMedium,
                                                  ),
                                                ),
                                                // IconButton(
                                                //   iconSize:
                                                //       Screens.bodyheight(context) *
                                                //           0.04,
                                                //   onPressed: () {
                                                //     datalist.serialbatchList!.remove(
                                                //         datalist.serialbatchList![i]);
                                                //     widget.StIn_Con.ScannigVal - 1;
                                                //     widget.StIn_Con.disableKeyBoard(context);
                                                //   },
                                                //   icon: Icon(Icons.delete),
                                                //   color: Colors.red,
                                                // )
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width:
                                                      Screens.width(context) *
                                                          0.4,
                                                  // color: Colors.amber,
                                                  child: Text(
                                                    "Scaned Qty: ${widget.datalist!.serialbatchList![i].qty}",
                                                    style: theme
                                                        .textTheme.bodyMedium,
                                                  ),
                                                ),
                                                // Container(
                                                //     alignment:
                                                //         Alignment.center,
                                                //     width:
                                                //         Screens.width(context) *
                                                //             0.15,
                                                //     height: Screens.bodyheight(
                                                //             context) *
                                                //         0.035,
                                                //     decoration: BoxDecoration(
                                                //         color: Colors.blue,
                                                //         shape: BoxShape.circle),
                                                //     child: IconButton(
                                                //         color: Colors.white,
                                                //         padding:
                                                //             EdgeInsets.zero,
                                                //         iconSize: 12,
                                                //         onPressed: () {
                                                //          widget. StIn_Con.scanqtyRemove(widget.index!, widget.ind!, i);
                                                //         },
                                                //         icon: Icon(
                                                //             Icons.remove))),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ));
                            }),
                  ],
                )),
            SizedBox(
              height: StOut_Height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.all(StOut_Height * 0.006),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: Screens.width(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.95,
                      child: ElevatedButton(
                        onPressed: () {
                          // widget.StIn_Con.StInLineRefersh(
                          //     widget.index!, widget.ind!);
                          // widget.StIn_Con.page.animateToPage(
                          //     --widget.StIn_Con.pageIndex,
                          //     duration: Duration(milliseconds: 250),
                          //     curve: Curves.bounceIn);
                        },
                        child: Text(
                          "Save and Back",
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                        // style: ElevatedButton.styleFrom(
                        //   primary: Colors.white,
                        //   side: BorderSide(
                        //       color: theme.primaryColor,
                        //       width: Screens.width(context) * 0.001),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            // GestureDetector(
            //     onTap: () {
            //       widget.StIn_Con.AcceptButton(ind!, index!, context);
            //       // StOut_Con.AcceptValidation(
            //       //     context, data, datatotal, index, Stock_i);
            //     },
            //     child: Container(
            //       padding: EdgeInsets.only(
            //           top: StOut_Height * 0.01,
            //           left: StOut_Height * 0.02,
            //           right: StOut_Height * 0.02,
            //           bottom: StOut_Height * 0.01),
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //           // color: Colors.grey[200],
            //           borderRadius: BorderRadius.circular(5),
            //           border: Border.all(
            //             color: theme.primaryColor,
            //           )),
            //       height: StOut_Height * 0.06,
            //       width: StOut_Width * 0.4,
            //       child: Text("Accept",
            //           style: theme.textTheme.bodyText2?.copyWith(
            //             color: theme.primaryColor,
            //           )),
            //     )),
            // SizedBox(
            //   height: StOut_Height * 0.01,
            // ),
          ],
        ),
      ),
    );
  }
}
