// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/ContentContainer.dart';
import '../../../Widgets/AlertBox.dart';
import '../Screens/StockMobile/Widgets/SearchItems.dart';

class RequestItem extends StatefulWidget {
  RequestItem({Key? key, required this.theme, required this.searchHeight, required this.searchWidth}) : super(key: key);

  final ThemeData theme;
  double searchHeight;
  double searchWidth;

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // height: searchHeight,
      width: widget.searchWidth,
      padding: EdgeInsets.only(top: widget.searchHeight * 0.01, left: widget.searchHeight * 0.01, right: widget.searchHeight * 0.01, bottom: widget.searchHeight * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.watch<StockReqController>().getScanneditemData2.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  width: widget.searchWidth * 1,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    // autofocus: false,
                    //  autofocus: true,
                    // keyboardType: TextInputType.text,
                    focusNode: context.watch<StockReqController>().inven,
                    style: theme.textTheme.bodyMedium,
                    cursorColor: Colors.grey,
                    // textAlign: TextAlign.right,

                    onChanged: (v) {},
                    controller: context.read<StockReqController>().searchcon, //prdsrch.mycontroller[0],
                    onEditingComplete: () {
                      setState(() {
                        context.read<StockReqController>().removeEmptyList(context);
                        context.read<StockReqController>().disableKeyBoard(context);
                        // prdsrch.scannBAtch(context, theme);
                        context.read<StockReqController>().getAllList(context.read<StockReqController>().searchcon.text.trim()).then((value) {
                          if (value.length == 1) {
                            context.read<StockReqController>().onseletFst(context, theme, context.read<StockReqController>().getfilterSearchedData[0]);
                          } else {
                            if (context.read<StockReqController>().WhsselectedList == null) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        content: AlertBox(
                                          payMent: 'Alert',
                                          errormsg: true,
                                          widget: Center(
                                              child: ContentContainer(
                                            content: 'Choose warehuse address..!!',
                                            theme: theme,
                                          )),
                                          buttonName: null,
                                        ));
                                  });
                            } else {
                              showDialog<dynamic>(
                                  context: context,
                                  builder: (_) {
                                    return SearchItems();
                                  });
                            }
                          }
                        });
                      });
                    },
                    decoration: InputDecoration(
                      // filled: false,

                      hintText: 'Inventories',
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(
                          //  color: Colors.grey
                          //   fontWeight: FontWeight.normal
                          ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          // size: searchHeight * 0.05,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            context.read<StockReqController>().removeEmptyList(context);
                            context.read<StockReqController>().disableKeyBoard(context);
                            // prdsrch.scannBAtch(context, theme);
                            context.read<StockReqController>().getAllList(context.read<StockReqController>().searchcon.text.trim()).then((value) {
                              if (value.length == 1) {
                                context.read<StockReqController>().onseletFst(context, theme, context.read<StockReqController>().getfilterSearchedData[0]);
                              } else {
                                if (context.read<StockReqController>().WhsselectedList == null) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            contentPadding: const EdgeInsets.all(0),
                                            content: AlertBox(
                                              payMent: 'Alert',
                                              errormsg: true,
                                              widget: Center(
                                                  child: ContentContainer(
                                                content: 'Choose warehuse address..!!',
                                                theme: theme,
                                              )),
                                              buttonName: null,
                                            ));
                                      });
                                } else {
                                  showDialog<dynamic>(
                                      context: context,
                                      builder: (_) {
                                        return SearchItems();
                                      });
                                }
                              }
                            });
                          });
                        },
                        color: theme.primaryColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                  ))
              : Container(),
          SizedBox(
            height: widget.searchHeight * 0.01,
          ),
          Container(
            padding: EdgeInsets.only(
              top: widget.searchHeight * 0.01,
              left: widget.searchHeight * 0.01,
              right: widget.searchHeight * 0.02,
              bottom: widget.searchHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            //  height: searchHeight * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    // color: Colors.red,
                    padding: EdgeInsets.only(
                      left: widget.searchHeight * 0.01,
                    ),
                    alignment: Alignment.centerLeft,
                    width: widget.searchWidth * 0.55,
                    child: Text(
                      "Product Information",
                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                    )),
                Container(
                    alignment: Alignment.center,
                    width: widget.searchWidth * 0.2,
                    child: Text(
                      "Quantity",
                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                    )),
              ],
            ),
          ),
          Expanded(
              child: context.watch<StockReqController>().getScanneditemData2.isNotEmpty
                  ? ListView.builder(
                      itemCount: context.watch<StockReqController>().getScanneditemData2.length,
                      itemBuilder: (context, index) {
                        print('   prdsrch.getScanneditemData.length:${context.watch<StockReqController>().getScanneditemData.length}');
                        return Card(
                          child: Container(
                              padding: EdgeInsets.only(
                                top: widget.searchHeight * 0.01,
                                left: widget.searchHeight * 0.01,
                                right: widget.searchHeight * 0.01,
                                bottom: widget.searchHeight * 0.02,
                              ),
                              decoration: BoxDecoration(
                                // color: Colors.white,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.5),
                                //     spreadRadius: 3,
                                //     blurRadius: 7,
                                //     offset:
                                //         Offset(0, 3), // changes position of shadow
                                //   ),
                                // ],
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[300],
                              ),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            // color: Colors.amber,
                                            width: widget.searchWidth * 0.7,
                                            // height: searchHeight * 0.02,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${context.watch<StockReqController>().getScanneditemData2[index].ItemName}",
                                              // maxLines: 2,
                                              //  "${prdsrch.getScanneditemData[index].ItemName}",
                                              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      // color: Colors.amber,
                                      width: widget.searchWidth * 0.2,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // InkWell(
                                          //   onTap: () {
                                          //     // prdsrch.itemdecrement(index);
                                          //   },
                                          //   child: Container(
                                          //     alignment: Alignment.center,
                                          //     width: widget.searchWidth * 0.05,
                                          //     height:
                                          //         widget.searchHeight * 0.05,
                                          //     color: Colors.blue,
                                          //     child: Icon(
                                          //       Icons.remove,
                                          //       color: Colors.white,
                                          //       size:
                                          //           widget.searchHeight * 0.05,
                                          //     ),
                                          //   ),
                                          // ),

                                          Container(
                                            alignment: Alignment.center,
                                            // width: Screens.width(context) * 0.015,
                                            padding: EdgeInsets.symmetric(horizontal: widget.searchWidth * 0.005),
                                            // height: searchHeight *
                                            //     0.025,
                                            child: Text("${context.watch<StockReqController>().getScanneditemData2[index].Qty}", style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black)),
                                          ),

                                          // InkWell(
                                          //   onTap: () {
                                          //     // prdsrch.itemIncrement(
                                          //     //     index, context, theme);
                                          //   },
                                          //   child: Container(
                                          //     alignment: Alignment.center,
                                          //     width: widget.searchWidth * 0.05,
                                          //     height:
                                          //         widget.searchHeight * 0.05,
                                          //     color: Colors.blue,
                                          //     child: Icon(
                                          //       Icons.add,
                                          //       color: Colors.white,
                                          //       size:
                                          //           widget.searchHeight * 0.05,
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    // Container(
                                    //   width: searchWidth * 0.16,
                                    //   // color: Colors.blue,
                                    //   alignment: Alignment.centerRight,
                                    //   child: Text(

                                    //      "${prdsrch.getScanneditemData[index].SellPrice}",
                                    //     style: theme.textTheme.bodyText2
                                    //         ?.copyWith(color: Colors.black),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: widget.searchHeight * 0.01,
                                ),
                                Row(
                                  children: [
                                    // Container(
                                    //     // color: Colors.amber,
                                    //     width: Screens.width(context) * 0.12,
                                    //     alignment: Alignment.centerLeft,
                                    //     child: Text(
                                    //       "${widget.prdsrch.getScanneditemData2[index].SerialBatch}",
                                    //       textAlign: TextAlign.start,
                                    //       style: theme.textTheme.bodyText1
                                    //           ?.copyWith(),
                                    //     )),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      width: Screens.width(context) * 0.12,
                                      child: Text(
                                        // "  |  DC-ABV12K-1YR",
                                        "${context.watch<StockReqController>().getScanneditemData2[index].ItemCode}",
                                        style: theme.textTheme.bodyLarge?.copyWith(),
                                      ),
                                    ),
                                  ],
                                )
                              ])),
                        );
                      })
                  : (context.watch<StockReqController>().loadShelfReqbool == true && context.watch<StockReqController>().loadShelfReqmsg!.isNotEmpty && context.watch<StockReqController>().scanneditemData.isEmpty)
                      ? Center(
                          child: Text("${context.watch<StockReqController>().loadShelfReqmsg}"),
                        )
                      : (context.watch<StockReqController>().loadLastSoldItemsbool == true && context.watch<StockReqController>().loadLastSoldItemsmsg!.isNotEmpty && context.watch<StockReqController>().scanneditemData.isEmpty)
                          ? Center(
                              child: Text("${context.watch<StockReqController>().loadLastSoldItemsmsg}"),
                            )
                          : (context.watch<StockReqController>().loadMiniMaxbool == true && context.watch<StockReqController>().loadMiniMaxmsg!.isNotEmpty && context.watch<StockReqController>().scanneditemData.isEmpty)
                              ? Center(
                                  child: Text("${context.watch<StockReqController>().loadMiniMaxmsg}"),
                                )
                              : ListView.builder(
                                  itemCount: context.watch<StockReqController>().getScanneditemData.length,
                                  itemBuilder: (context, index) {
                                    print('   prdsrch.getScanneditemData.length:${context.watch<StockReqController>().getScanneditemData.length}');
                                    return Card(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                            top: widget.searchHeight * 0.01,
                                            left: widget.searchHeight * 0.01,
                                            right: widget.searchHeight * 0.01,
                                            bottom: widget.searchHeight * 0.02,
                                          ),
                                          decoration: BoxDecoration(
                                            // color: Colors.white,
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Colors.grey.withOpacity(0.5),
                                            //     spreadRadius: 3,
                                            //     blurRadius: 7,
                                            //     offset:
                                            //         Offset(0, 3), // changes position of shadow
                                            //   ),
                                            // ],
                                            color: Colors.grey.withOpacity(0.04),
                                          ),
                                          child: Column(children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                        // color: Colors.amber,
                                                        width: widget.searchWidth * 0.7,
                                                        // height: searchHeight * 0.02,
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                          "${context.watch<StockReqController>().getScanneditemData[index].ItemName}",
                                                          // maxLines: 2,
                                                          //  "${prdsrch.getScanneditemData[index].ItemName}",
                                                          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  // color: Colors.amber,
                                                  width: widget.searchWidth * 0.2,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      //       InkWell(
                                                      //         onTap: () {
                                                      //           prdsrch.itemdecrement(index);
                                                      //         },
                                                      //         child: Container(
                                                      //           alignment: Alignment.center,
                                                      //           width: searchWidth * 0.05,
                                                      //           height: searchHeight * 0.05,
                                                      //           color: Colors.blue,
                                                      //           child: Icon(
                                                      //             Icons.remove,
                                                      //             color: Colors.white,
                                                      //             size: searchHeight * 0.05,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      Container(
                                                          width: Screens.width(context) * 0.06,
                                                          height: Screens.padingHeight(context) * 0.05,
                                                          // color: Colors.blue,
                                                          alignment: Alignment.center,
                                                          child: TextFormField(
                                                            autofocus: true,
                                                            style: theme.textTheme.bodyMedium,
                                                            onChanged: ((value) {
                                                              setState(() {
                                                                if (value == "0") {
                                                                  context.read<StockReqController>().qtyCont.removeAt(index);

                                                                  context.read<StockReqController>().scanneditemData.removeAt(index);
                                                                  // context
                                                                  //     .read<
                                                                  //         StockReqController>()
                                                                  //     .setvalues();
                                                                }
                                                              });
                                                            }),
                                                            onTap: () {
                                                              context.read<StockReqController>().qtyCont[index].text = context.read<StockReqController>().qtyCont[index].text;
                                                              context.read<StockReqController>().qtyCont[index].selection = TextSelection(
                                                                baseOffset: 0,
                                                                extentOffset: context.read<StockReqController>().qtyCont[index].text.length,
                                                              );
                                                            },
                                                            cursorColor: Colors.grey,
                                                            textDirection: TextDirection.rtl,
                                                            keyboardType: TextInputType.number,
                                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                            textAlign: TextAlign.right,
                                                            onEditingComplete: () {
                                                              context.read<StockReqController>().editqty(index);
                                                              context.read<StockReqController>().restartFocus(context);
                                                              context.read<StockReqController>().disableKeyBoard(context);
                                                              //prdsrch.calCulateDocVal(context, theme);
                                                            },
                                                            controller: context.read<StockReqController>().qtyCont[index],
                                                            decoration: InputDecoration(
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(5),
                                                                borderSide: BorderSide(color: Colors.grey),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(5),
                                                                borderSide: BorderSide(color: Colors.grey),
                                                              ),
                                                              contentPadding: const EdgeInsets.symmetric(
                                                                vertical: 5,
                                                                horizontal: 5,
                                                              ),
                                                            ),
                                                          )),
                                                      // Container(
                                                      //   alignment: Alignment.center,
                                                      //    width: Screens.width(context) * 0.1,
                                                      //   padding: EdgeInsets.symmetric(
                                                      //       horizontal: searchWidth * 0.005),

                                                      // height: searchHeight *
                                                      //     0.025,
                                                      // child: Text(
                                                      //     "${prdsrch.getScanneditemData[index].Qty}",
                                                      //     style: theme.textTheme.bodyText2
                                                      //         ?.copyWith(
                                                      //             color: Colors.black)),
                                                      // ),
                                                      // InkWell(
                                                      //   onTap: () {
                                                      //     prdsrch.itemIncrement(
                                                      //         index, context, theme);
                                                      //   },
                                                      //   child: Container(
                                                      //     alignment: Alignment.center,
                                                      //     width: searchWidth * 0.05,
                                                      //     height: searchHeight * 0.05,
                                                      //     color: Colors.blue,
                                                      //     child: Icon(
                                                      //       Icons.add,
                                                      //       color: Colors.white,
                                                      //       size: searchHeight * 0.05,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                // Container(
                                                //   width: searchWidth * 0.16,
                                                //   // color: Colors.blue,
                                                //   alignment: Alignment.centerRight,
                                                //   child: Text(

                                                //      "${prdsrch.getScanneditemData[index].SellPrice}",
                                                //     style: theme.textTheme.bodyText2
                                                //         ?.copyWith(color: Colors.black),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: widget.searchHeight * 0.01,
                                            ),
                                            Row(
                                              children: [
                                                // Container(
                                                //     // color: Colors.amber,
                                                //     width: Screens.width(context) * 0.12,
                                                //     alignment: Alignment.centerLeft,
                                                //     child: Text(
                                                //       "${widget.prdsrch.getScanneditemData[index].SerialBatch}",
                                                //       textAlign: TextAlign.start,
                                                //       style:
                                                //           theme.textTheme.bodyText1?.copyWith(),
                                                //     )),
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  width: Screens.width(context) * 0.12,
                                                  child: Text(
                                                    // "  |  DC-ABV12K-1YR",
                                                    "${context.watch<StockReqController>().getScanneditemData[index].ItemCode}",
                                                    style: theme.textTheme.bodyLarge?.copyWith(),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ])),
                                    );
                                  })),
        ],
      ),
    );
  }
}
