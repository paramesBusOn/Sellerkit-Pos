// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';
import 'package:flutter/services.dart';

class StockInscanPage extends StatefulWidget {
  StockInscanPage({Key? key, required this.theme, required this.ind, required this.index, required this.searchHeight, required this.searchWidth, required this.datalist}) : super(key: key);

  final ThemeData theme;
  int? index;
  int? ind;
  StockInwardDetails? datalist;
  double searchHeight;
  double searchWidth;

  @override
  State<StockInscanPage> createState() => _StockInscanPageState();
}

class _StockInscanPageState extends State<StockInscanPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: widget.searchHeight * 0.02,
          left: widget.searchWidth * 0.01,
          right: widget.searchWidth * 0.01,
          bottom: widget.searchHeight * 0.01,
        ),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
        width: widget.searchWidth * 1,
        //  height:searchHeight*0.9 ,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: Text(" Pending Request",
              //       style: theme.textTheme.bodyText2
              //           ?.copyWith(fontWeight: FontWeight.bold)),
              // ),
              // SizedBox(
              //   height: searchHeight * 0.01,
              // ),
              SizedBox(
                width: widget.searchWidth * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: widget.searchHeight * 0.01,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: widget.searchWidth * 1.18,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromARGB(255, 207, 201, 201)),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            style: widget.theme.textTheme.bodyMedium,
                            cursorColor: Colors.grey,
                            controller: context.read<StockInwrdController>().StInController[0],
                            onEditingComplete: () {
                              setState(() {
                                context.read<StockInwrdController>().scanmethod(widget.index!, widget.datalist!, widget.ind!);
                              });
                              context.read<StockInwrdController>().disableKeyBoard(context);
                              // StOut_Con.scanmethod(index,datalist!.serialBatch!, ind!,);
                              // StOut_Con.scan3(datalist,
                              //     StOut_Con.StOutController[0].text, Stock_i, StList_i);
                            },
                            onChanged: (v) {
                              if (v.isNotEmpty) {
                                context.read<StockInwrdController>().msg = "";
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              hintText: 'Scan Here..',
                              hintStyle: widget.theme.textTheme.bodyMedium?.copyWith(
                                  //  color: Colors.grey
                                  //   fontWeight: FontWeight.normal
                                  ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                            ),
                          )),
                      Row(
                        children: [
                          Text(
                            "  ${context.watch<StockInwrdController>().msg}",
                            style: widget.theme.textTheme.bodySmall!.copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                      SizedBox(height: widget.searchHeight * 0.008),
                      SizedBox(
                        width: widget.searchWidth * 1.18,
                        height: widget.searchHeight * 0.908,
                        // color: Colors.red,
                        child: context.read<StockInwrdController>().StockInward.isEmpty
                            ? Container()
                            : context.read<StockInwrdController>().StockInward[context.read<StockInwrdController>().get_i_value].data[context.read<StockInwrdController>().batch_i!].serialbatchList == null
                                ? Center(
                                    child: Text("Scan Item.."),
                                  )
                                : ListView.builder(
                                    itemCount: context.read<StockInwrdController>().StockInward[context.watch<StockInwrdController>().get_i_value].data[context.read<StockInwrdController>().batch_i!].serialbatchList!.length,
                                    // datalist!.serialbatchList!.length,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, i) {
                                      return Card(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: widget.searchHeight * 0.01,
                                            left: widget.searchHeight * 0.01,
                                            right: widget.searchHeight * 0.01,
                                            bottom: widget.searchHeight * 0.01,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                // datalist.serialbatchList![i].scanbool ==
                                                //         true
                                                //     ? Color(0xFFebfaef)
                                                //     :
                                                Colors.grey.withOpacity(0.04),
                                            border: Border.all(
                                                color:
                                                    //datalist.serialbatchList![i].scanbool ==
                                                    //         true
                                                    //     ? Colors.green.withOpacity(0.3)
                                                    //     :
                                                    Colors.white),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color:
                                            //         Colors.grey.withOpacity(0.5),
                                            //     spreadRadius: 3,
                                            //     blurRadius: 7,
                                            //     offset: Offset(0,
                                            //         3), // changes position of shadow
                                            //   ),
                                            // ]
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                SizedBox(
                                                  // color: Colors.amber,

                                                  width: widget.searchWidth * 0.2,
                                                  child: Text(
                                                    "${context.read<StockInwrdController>().StockInward[context.watch<StockInwrdController>().get_i_value].data[context.read<StockInwrdController>().batch_i!].serialbatchList![i].itemcode}",
                                                    style: widget.theme.textTheme.bodyLarge,
                                                  ),
                                                ),
                                                // Container(
                                                //   alignment: Alignment.center,
                                                //   // color: Colors.amber,
                                                //   width:  searchWidth * 0.35,
                                                //   child: Text(
                                                //     "${datalist.serialbatchList![i].docentry}",
                                                //     style: theme.textTheme.bodyText1,
                                                //   ),
                                                // ),
                                                Container(
                                                  alignment: Alignment.centerRight,
                                                  // color: Colors.amber,
                                                  width: widget.searchWidth * 0.2,
                                                  child: Text(
                                                    "${context.read<StockInwrdController>().StockInward[context.watch<StockInwrdController>().get_i_value].data[context.read<StockInwrdController>().batch_i!].serialbatchList![i].serialbatch}",
                                                    style: widget.theme.textTheme.bodyLarge,
                                                  ),
                                                ),
                                              ]),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    // color: Colors.amber,
                                                    width: widget.searchWidth * 0.2,
                                                    child: Text(
                                                      "Scanned Qty : ${context.read<StockInwrdController>().StockInward[context.watch<StockInwrdController>().get_i_value].data[context.read<StockInwrdController>().batch_i!].serialbatchList![i].qty}",
                                                      style: widget.theme.textTheme.bodyLarge,
                                                    ),
                                                  ),

                                                  Container(
                                                      width: widget.searchWidth * 0.1,
                                                      height: widget.searchHeight * 0.07,
                                                      alignment: Alignment.center,
                                                      // width: Screens.width(context) * 0.015,
                                                      padding: EdgeInsets.symmetric(horizontal: widget.searchWidth * 0.005),
                                                      // height: searchHeight *
                                                      //     0.025,
                                                      child: TextFormField(
                                                        textAlign: TextAlign.right,
                                                        onTap: () {
                                                          context.read<StockInwrdController>().sinqtycontroller[i].text = context.read<StockInwrdController>().sinqtycontroller[i].text;
                                                          context.read<StockInwrdController>().sinqtycontroller[i].selection = TextSelection(
                                                            baseOffset: 0,
                                                            extentOffset: context.read<StockInwrdController>().sinqtycontroller[i].text.length,
                                                          );
                                                        },
                                                        style: widget.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                        onChanged: (v) {
                                                          // context
                                                          //     .read<
                                                          //         StockInwrdController>()
                                                          //     .qtyEdited(index,
                                                          //         context, theme);
                                                        },
                                                        cursorColor: Colors.grey,
                                                        textDirection: TextDirection.ltr,
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                        onEditingComplete: () {
                                                          setState(() {
                                                            context.read<StockInwrdController>().stkInEditQty(
                                                                context.read<StockInwrdController>().get_i_value,
                                                                context.read<StockInwrdController>().StockInward[context.read<StockInwrdController>().get_i_value].data[context.read<StockInwrdController>().batch_i!].serialbatchList![i].serialbatch!,
                                                                context.read<StockInwrdController>().batch_i!,
                                                                context.read<StockInwrdController>().StockInward[context.read<StockInwrdController>().get_i_value].data[context.read<StockInwrdController>().batch_i!].itemcode!,
                                                                i);
                                                          });
                                                          context.read<StockInwrdController>().disableKeyBoard(context);
                                                        },
                                                        controller: context.read<StockInwrdController>().sinqtycontroller[i],
                                                        decoration: InputDecoration(
                                                          filled: false,
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                            borderSide: BorderSide(color: Colors.grey),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                            borderSide: BorderSide(color: Colors.grey),
                                                          ),
                                                          contentPadding: const EdgeInsets.symmetric(
                                                            vertical: 0,
                                                            horizontal: 5,
                                                          ),
                                                        ),
                                                      )),

                                                  // Container(
                                                  //     alignment: Alignment.center,
                                                  //     // color: Colors.amber,
                                                  //     height: Screens.bodyheight(
                                                  //             context) *
                                                  //         0.06,
                                                  //     width: searchWidth * 0.1,
                                                  //     decoration: BoxDecoration(
                                                  //         color: Colors.blue,
                                                  //         shape: BoxShape.circle),
                                                  //     child: IconButton(
                                                  //         color: Colors.white,
                                                  //         padding: EdgeInsets.zero,
                                                  //         iconSize: 18,
                                                  //         onPressed: () {
                                                  //           StOut_Con.scanqtyRemove(
                                                  //               index!, ind!, i);
                                                  //         },
                                                  //         icon:
                                                  //             Icon(Icons.remove))),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                      ),
                      SizedBox(
                        height: widget.searchHeight * 0.05,
                      ),
                      SizedBox(

                          // height: searchHeight * 0.06,
                          width: widget.searchWidth,
                          child: ElevatedButton(
                              onPressed: () {
                                // context
                                //     .read<StockInwrdController>()
                                //     .StInLineRefersh(index!, ind!);
                                context.read<StockInwrdController>().StInLineRefersh(widget.index!, widget.ind!, context.read<StockInwrdController>().StockInward[widget.index!].data[widget.ind!].serialbatchList);
                                context.read<StockInwrdController>().passData(widget.theme, context, widget.index!);
                                context.read<StockInwrdController>().isselectmethod();
                                // context
                                //     .read<StockInwrdController>()
                                //     .getBatchData(
                                //         index!,
                                //         context
                                //             .read<StockInwrdController>()
                                //             .selectIndex2);

                                // context
                                //     .read<StockInwrdController>()
                                //     .pageminus();
                              },
                              child: Text("Save and Back"))),
                      SizedBox(
                        height: widget.searchHeight * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
