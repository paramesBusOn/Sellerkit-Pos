// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({Key? key, required this.theme, required this.searchHeight, required this.searchWidth}) : super(key: key);

  final ThemeData theme;

  double searchHeight;
  double searchWidth;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: widget.searchHeight,
      width: widget.searchWidth,
      padding: EdgeInsets.only(top: widget.searchHeight * 0.01, left: widget.searchHeight * 0.01, right: widget.searchHeight * 0.01, bottom: widget.searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.watch<PosController>().scanneditemData2.isNotEmpty
              ? Container()
              : Container(
                  alignment: Alignment.center,
                  width: widget.searchWidth * 1,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    readOnly: context.watch<PosController>().cpyfrmso.isNotEmpty ? true : false,
                    // focusNode: context.watch<PosController>().focusnode[0],
                    style: theme.textTheme.bodyMedium,
                    onChanged: (v) {},
                    cursorColor: Colors.grey,
                    controller: context.read<PosController>().mycontroller[99],
                    onEditingComplete: () async {
                      // if (context
                      //         .read<PosController>()
                      //         .itemcodelistitem55
                      //         .length ==
                      //     1) {
                      //   await context
                      //       .read<PosController>()
                      //       .aaaabbb(context, theme, 0);
                      // } else {
                      setState(() {
                        context.read<PosController>().checkBatchAvail(context.read<PosController>().mycontroller[99].text.toString().trim().toUpperCase(), context, theme);
                      });
                      // }
                    },
                    decoration: InputDecoration(
                      filled: false,
                      hintText: 'Inventories',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      //
                      //   IconButton(
                      // icon: Icon(
                      //   Icons.search,
                      //   color: Colors.grey,
                      // ),
                      // onPressed: () async {
                      // context.read<PosController>().source1 = await context.read<PosController>().getPathOFDB();
                      // context.read<PosController>().copyTo = await context.read<PosController>().getDirectory();

                      // bool permission = await context.read<PosController>().getPermissionStorage();
                      // if (permission == true) {
                      //   if ((await context.read<PosController>().copyTo!.exists())) {
                      //     print("EXISTS");
                      //     context.read<PosController>().createDBFile(context.read<PosController>().copyTo!.path);
                      //   } else {
                      //     print("Not EXISTS");
                      //     context.read<PosController>().createDirectory();
                      //   }
                      // } else if (permission == false) {
                      //   context.read<PosController>().showSnackBars('Please give stoage permission to continue!!..', Colors.red);
                      // }
                      // },
                      // color: theme.primaryColor,
                      // ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                  )),
          SizedBox(
            height: widget.searchHeight * 0.01,
          ),
          Container(
            padding: EdgeInsets.only(
              top: widget.searchHeight * 0.01,
              left: widget.searchHeight * 0.01,
              right: widget.searchHeight * 0.01,
              bottom: widget.searchHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            //  height: searchHeight * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    context.read<PosController>().source1 = await context.read<PosController>().getPathOFDB();
                    context.read<PosController>().copyTo = await context.read<PosController>().getDirectory();

                    bool permission = await context.read<PosController>().getPermissionStorage();
                    if (permission == true) {
                      if ((await context.read<PosController>().copyTo!.exists())) {
                        print("EXISTS");
                        context.read<PosController>().createDBFile(context.read<PosController>().copyTo!.path);
                      } else {
                        print("Not EXISTS");
                        context.read<PosController>().createDirectory();
                      }
                    } else if (permission == false) {
                      context.read<PosController>().showSnackBars('Please give stoage permission to continue!!..', Colors.red);
                    }
                    // 
                    // prdsrch.getcustaddresslist();
                  },
                  child: Container(
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                        left: widget.searchHeight * 0.01,
                      ),
                      alignment: Alignment.centerLeft,
                      width: widget.searchWidth * 0.42,
                      child: Text(
                        "Product Information",
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                      )),
                ),
                SizedBox(
                  // color: Colors.green,
                  width: widget.searchWidth * 0.54,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          // color: Colors.red,
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.07,
                          child: Text(
                            "Qty",
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                          )),
                      Container(
                          // color: Colors.red,
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.13,
                          child: Text(
                            "Discount %",
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                          )),
                      Container(
                          // color: Colors.red,
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.15,
                          child: Text(
                            "Tax %",
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                          )),
                      GestureDetector(
                        onTap: () {
                          context.read<PosController>().viewSalesRet();
                        },
                        child: Container(
                            // color: Colors.red,
                            alignment: Alignment.center,
                            width: widget.searchWidth * 0.15,
                            child: Text(
                              "Price",
                              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child:
                  // widget.prdsrch.
                  context.read<PosController>().getScanneditemData2.isNotEmpty
                      ? ListView.builder(
                          itemCount:
                              // widget.prdsrch.
                              context.watch<PosController>().getScanneditemData2.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                    padding: EdgeInsets.only(
                                      top: widget.searchHeight * 0.01,
                                      left: widget.searchHeight * 0.01,
                                      right: widget.searchHeight * 0.01,
                                      bottom: widget.searchHeight * 0.02,
                                    ),
                                    decoration: BoxDecoration(
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
                                                  width: widget.searchWidth * 0.4,
                                                  // height: searchHeight * 0.02,
                                                  alignment: Alignment.centerLeft,
                                                  child: TextButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        // "${widget.prdsrch
                                                        "${context.watch<PosController>().getScanneditemData2[index].ItemName}",
                                                        maxLines: 2,
                                                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                      ))),
                                            ],
                                          ),
                                          SizedBox(
                                            width: widget.searchWidth * 0.55,
                                            // color: Colors.yellow,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // Container(
                                                //   width: searchWidth * 0.1,
                                                //   child: Row(
                                                //     mainAxisAlignment:
                                                //         MainAxisAlignment.spaceEvenly,
                                                //     children: [
                                                // InkWell(
                                                //   onTap: () {
                                                //     prdsrch.itemdecrement(
                                                //         context, theme, index);
                                                //   },
                                                //   child: Container(
                                                //     alignment: Alignment.center,
                                                //     width: searchWidth * 0.05,
                                                //     height: searchHeight * 0.05,
                                                //     color: Colors.blue,
                                                //     child: Icon(
                                                //       Icons.remove,
                                                //       color: Colors.white,
                                                //       size: searchHeight * 0.05,
                                                //     ),
                                                //   ),
                                                // ),
                                                Container(
                                                    width: widget.searchWidth * 0.1,
                                                    height: widget.searchHeight * 0.07,
                                                    alignment: Alignment.center,
                                                    // width: Screens.width(context) * 0.015,
                                                    padding: EdgeInsets.symmetric(horizontal: widget.searchWidth * 0.005),
                                                    // height: searchHeight *
                                                    //     0.025,
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                      onChanged: (v) {},
                                                      cursorColor: Colors.grey,
                                                      textDirection: TextDirection.rtl,
                                                      keyboardType: TextInputType.number,
                                                      onEditingComplete: () {
                                                        // prdsrch.itemIncrement11(
                                                        //     index, context, theme);
                                                      },
                                                      controller:
                                                          // widget.prdsrch
                                                          context.read<PosController>().qtymycontroller2[index],
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
                                                    )

                                                    // Text(
                                                    //     "${prdsrch.getScanneditemData[index].Qty}",
                                                    // style: theme.textTheme.bodyText2
                                                    //     ?.copyWith(
                                                    //         color: Colors.black)),
                                                    ),
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
                                                //     ],
                                                //   ),
                                                // ),

                                                Container(
                                                    width: widget.searchWidth * 0.09,
                                                    height: widget.searchHeight * 0.07,
                                                    // color: Colors.blue,
                                                    alignment: Alignment.center,
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      style: theme.textTheme.bodyMedium,
                                                      onChanged: (v) {},
                                                      onEditingComplete: () {},
                                                      cursorColor: Colors.grey,
                                                      textDirection: TextDirection.rtl,
                                                      keyboardType: TextInputType.number,
                                                      controller: context.read<PosController>().mycontroller2[index],
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
                                                    )
                                                    //   Text(
                                                    //  "${prdsrch.getScanneditemData[index].discount.toString()}",
                                                    // //  getScanneditemData[index].
                                                    // //   Maxdiscount}",
                                                    //     style: theme.textTheme.bodyText2
                                                    //         ?.copyWith(color: Colors.black),
                                                    //   ),
                                                    ),
                                                Container(
                                                  width: widget.searchWidth * 0.17,
                                                  // color: Colors.blue,
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      // widget
                                                      //             .prdsrch
                                                      context.watch<PosController>().getScanneditemData2[index].TaxRate == null ? '00' : ' ${context.watch<PosController>().getScanneditemData2[index].TaxRate}',
                                                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black)),
                                                ),
                                                Container(
                                                  // color: Colors.blue,
                                                  width: widget.searchWidth * 0.17,
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                    context.watch<PosController>().config.splitValues("${context.watch<PosController>().getScanneditemData2[index].SellPrice}"),
                                                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: widget.searchHeight * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "${context.watch<PosController>().getScanneditemData2[index].SerialBatch}",
                                                textAlign: TextAlign.start,
                                                style: theme.textTheme.bodyMedium?.copyWith(),
                                              )),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            // width: searchWidth * 0.13,
                                            child: Text(
                                              // "  |  DC-ABV12K-1YR",
                                              "  |  ${context.watch<PosController>().getScanneditemData2[index].ItemCode}",
                                              style: theme.textTheme.bodyMedium?.copyWith(),
                                            ),
                                          ),
                                        ],
                                      )
                                    ])),
                              ),
                            );
                          })
                      : ListView.builder(
                          itemCount: context.watch<PosController>().getScanneditemData.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                    padding: EdgeInsets.only(
                                      top: widget.searchHeight * 0.01,
                                      left: widget.searchHeight * 0.01,
                                      right: widget.searchHeight * 0.01,
                                      bottom: widget.searchHeight * 0.02,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
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
                                                  width: widget.searchWidth * 0.4,
                                                  // height: searchHeight * 0.02,
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "${context.watch<PosController>().getScanneditemData[index].ItemName}",
                                                    maxLines: 2,
                                                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: widget.searchWidth * 0.55,
                                            // color: Colors.yellow,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // Container(
                                                //   width: searchWidth * 0.1,
                                                //   child: Row(
                                                //     mainAxisAlignment:
                                                //         MainAxisAlignment.spaceEvenly,
                                                //     children: [
                                                // InkWell(
                                                //   onTap: () {
                                                //     prdsrch.itemdecrement(
                                                //         context, theme, index);
                                                //   },
                                                //   child: Container(
                                                //     alignment: Alignment.center,
                                                //     width: searchWidth * 0.05,
                                                //     height: searchHeight * 0.05,
                                                //     color: Colors.blue,
                                                //     child: Icon(
                                                //       Icons.remove,
                                                //       color: Colors.white,
                                                //       size: searchHeight * 0.05,
                                                //     ),
                                                //   ),
                                                // ),
                                                Container(
                                                    width: widget.searchWidth * 0.1,
                                                    height: widget.searchHeight * 0.07,
                                                    alignment: Alignment.center,
                                                    // width: Screens.width(context) * 0.015,
                                                    padding: EdgeInsets.symmetric(horizontal: widget.searchWidth * 0.005),
                                                    // height: searchHeight *
                                                    //     0.025,
                                                    child: TextFormField(
                                                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                      onTap: () {
                                                        context.read<PosController>().qtymycontroller[index].text =
                                                            // widget
                                                            //     .prdsrch
                                                            context.read<PosController>().qtymycontroller[index].text;
                                                        // widget
                                                        //     .prdsrch
                                                        context.read<PosController>().qtymycontroller[index].selection = TextSelection(
                                                          baseOffset: 0,
                                                          extentOffset:
                                                              // widget
                                                              //     .prdsrch
                                                              context.read<PosController>().qtymycontroller[index].text.length,
                                                        );
                                                      },
                                                      cursorColor: Colors.grey,
                                                      textDirection: TextDirection.rtl,
                                                      keyboardType: TextInputType.number,
                                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                      onEditingComplete: () {
                                                        context.read<PosController>().itemIncrement11(index, context, theme);
                                                      },
                                                      readOnly: context.read<PosController>().cpyfrmso.isNotEmpty ? true : false,
                                                      controller: context.read<PosController>().qtymycontroller[index],
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
                                                    )

                                                    // Text(
                                                    //     "${prdsrch.getScanneditemData[index].Qty}",
                                                    // style: theme.textTheme.bodyText2
                                                    //     ?.copyWith(
                                                    //         color: Colors.black)),
                                                    ),
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
                                                //     ],
                                                //   ),
                                                // ),

                                                Container(
                                                    width: widget.searchWidth * 0.09,
                                                    height: widget.searchHeight * 0.07,
                                                    // color: Colors.blue,
                                                    alignment: Alignment.center,
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      // widget.prdsrch
                                                      // context
                                                      //         .read<
                                                      //             PosController>()
                                                      //         .cpyfrmso
                                                      //         .isNotEmpty
                                                      //     ? true
                                                      //     : false,
                                                      style: theme.textTheme.bodyMedium,
                                                      onTap: () {
                                                        // widget
                                                        //         .prdsrch
                                                        context.read<PosController>().discountcontroller[index].text =
                                                            // widget
                                                            //     .prdsrch
                                                            context.read<PosController>().discountcontroller[index].text;
                                                        // widget
                                                        //         .prdsrch
                                                        context.read<PosController>().discountcontroller[index].selection = TextSelection(
                                                          baseOffset: 0,
                                                          extentOffset:
                                                              //  widget
                                                              //     .prdsrch
                                                              context.read<PosController>().discountcontroller[index].text.length,
                                                        );
                                                      },
                                                      onEditingComplete: () {
                                                        setState(() {
                                                          context.read<PosController>().calCulateDocVal(context, theme);
                                                        });
                                                        // widget.prdsrch
                                                      },
                                                      cursorColor: Colors.grey,
                                                      textDirection: TextDirection.rtl,
                                                      keyboardType: TextInputType.number,
                                                      controller: context.read<PosController>().discountcontroller[index],
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
                                                    )
                                                    //   Text(
                                                    //  "${prdsrch.getScanneditemData[index].discount.toString()}",
                                                    // //  getScanneditemData[index].
                                                    // //   Maxdiscount}",
                                                    //     style: theme.textTheme.bodyText2
                                                    //         ?.copyWith(color: Colors.black),
                                                    //   ),
                                                    ),
                                                Container(
                                                  width: widget.searchWidth * 0.17,
                                                  // color: Colors.blue,
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      // widget
                                                      //             .prdsrch
                                                      // context
                                                      //             .watch<
                                                      //                 PosController>()
                                                      //             .getScanneditemData[
                                                      //                 index]
                                                      //             .TaxRate.
                                                      //     ? '00'
                                                      //     :
                                                      ' ${context.watch<PosController>().getScanneditemData[index].TaxRate}',
                                                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black)),
                                                ),
                                                Container(
                                                  // color: Colors.blue,
                                                  width: widget.searchWidth * 0.17,
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                    context.watch<PosController>().config.splitValues("${context.watch<PosController>().getScanneditemData[index].SellPrice}"),
                                                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: widget.searchHeight * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "${context.watch<PosController>().getScanneditemData[index].SerialBatch}",
                                                textAlign: TextAlign.start,
                                                style: theme.textTheme.bodyMedium?.copyWith(),
                                              )),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            // width: searchWidth * 0.13,
                                            child: Text(
                                              // "  |  DC-ABV12K-1YR",
                                              "  |  ${context.watch<PosController>().getScanneditemData[index].ItemCode}",
                                              style: theme.textTheme.bodyMedium?.copyWith(),
                                            ),
                                          ),
                                        ],
                                      )
                                    ])),
                              ),
                            );
                          })),
        ],
      ),
    );
  }
}
