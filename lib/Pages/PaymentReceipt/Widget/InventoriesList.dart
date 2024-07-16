import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/PaymentReceiptController/PayReceiptController.dart';

class Inventories extends StatefulWidget {
  Inventories(
      {Key? key,
      required this.theme,
      required this.searchHeight,
      required this.searchWidth})
      : super(key: key);

  final ThemeData theme;
  double searchHeight;
  double searchWidth;
  @override
  State<Inventories> createState() => _InventoriesState();
}

class _InventoriesState extends State<Inventories> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        height: widget.searchHeight * 1.06,
        width: widget.searchWidth,
        padding: EdgeInsets.only(
            top: widget.searchHeight * 0.01,
            left: widget.searchHeight * 0.01,
            right: widget.searchHeight * 0.01,
            bottom: widget.searchHeight * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  context.read<PayreceiptController>().selectedcust2 != null
            //       ? Container()
            // :
            Container(
                alignment: Alignment.center,
                width: widget.searchWidth * 1,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.01),
                ),
                child: TextFormField(
                  style: theme.textTheme.bodyLarge,
                  cursorColor: Colors.grey,
                  onChanged: (v) {
                    context.read<PayreceiptController>().filterInvoiceList(v);
                  },
                  controller:
                      context.read<PayreceiptController>().mycontroller[80],
                  onEditingComplete: () {
                    context
                        .read<PayreceiptController>()
                        .invoiceScan(context, theme);
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: 'Invoice Information',
                    hintStyle: theme.textTheme.bodyLarge?.copyWith(),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    // suffixIcon: IconButton(
                    //   icon: Icon(
                    //     Icons.search,
                    //     // size: searchHeight * 0.05,
                    //     color: Colors.grey,
                    //   ),
                    //   onPressed: () {
                    //     // Navigator.push((context),
                    //     //     MaterialPageRoute(builder: (_) => SettingScreens()));
                    //   },
                    //   color: theme.primaryColor,
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
            context.read<PayreceiptController>().getScanneditemData2.isNotEmpty
                ? SizedBox(
                    height: widget.searchHeight * 0.75,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: context
                            .watch<PayreceiptController>()
                            .getScanneditemData2
                            .length,
                        itemBuilder: (context, index) {
                          print(
                              "ScanneditemData.length::${context.read<PayreceiptController>().getScanneditemData2.length.toString()}");
                          return Card(
                            child: Container(
                                padding: EdgeInsets.only(
                                  top: widget.searchHeight * 0.01,
                                  left: widget.searchHeight * 0.01,
                                  right: widget.searchHeight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[300]),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                    "${context.watch<PayreceiptController>().getScanneditemData2[index].doctype} - ${context.watch<PayreceiptController>().getScanneditemData2[index].docNum}")
                                              ],
                                            ),
                                            Text(context
                                                .read<PayreceiptController>()
                                                .config
                                                .alignDate(context
                                                    .read<
                                                        PayreceiptController>()
                                                    .getScanneditemData2[index]
                                                    .date
                                                    .toString()))
                                          ],
                                        ),
                                      ),
                                      Container(
                                          width: widget.searchWidth * 0.15,
                                          height: widget.searchHeight * 0.08,
                                          alignment: Alignment.center,
                                          // width: Screens.width(context) * 0.015,
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  widget.searchWidth * 0.005),
                                          // height: searchHeight *
                                          //     0.025,
                                          child: TextFormField(
                                            readOnly: true,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                            onChanged: (v) {},
                                            cursorColor: Colors.grey,
                                            textDirection: TextDirection.rtl,
                                            keyboardType: TextInputType.number,
                                            onEditingComplete: () {
                                              context
                                                  .read<PayreceiptController>()
                                                  .totalpaidamt(context, theme);
                                              context
                                                  .read<PayreceiptController>()
                                                  .disableKeyBoard(context);
                                            },
                                            controller: context
                                                .read<PayreceiptController>()
                                                .mycontroller2[index],
                                            decoration: InputDecoration(
                                              filled: false,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal: 5,
                                              ),
                                            ),
                                          ))
                                    ])),
                          );
                        }),
                  )
                : context
                        .watch<PayreceiptController>()
                        .getScanneditemData
                        .isEmpty
                    ? Container(
                        // height: widget.searchHeight * 0.5,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: widget.theme.primaryColor,
                                side: BorderSide(
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<PayreceiptController>()
                                        .advancests ==
                                    true
                                ? null
                                : () {
                                    context
                                        .read<PayreceiptController>()
                                        .advancests = true;

                                    setState(() {
                                      context
                                          .read<PayreceiptController>()
                                          .AAAAdvance(
                                              "Advance", context, theme);
                                      context
                                          .read<PayreceiptController>()
                                          .disableKeyBoard(context);
                                    });
                                  },
                            child: Text(
                              "Advance",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.white),
                            )),
                      )
                    : SizedBox(
                        height: widget.searchHeight * 0.75,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: context
                                .watch<PayreceiptController>()
                                .getScanneditemData
                                .length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: widget.searchHeight * 0.01,
                                    left: widget.searchHeight * 0.01,
                                    right: widget.searchHeight * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getScanneditemData[index]
                                                      .checkbx ==
                                                  1 &&
                                              context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getScanneditemData[index]
                                                      .checkClr ==
                                                  true
                                          ? Colors.blue.withOpacity(0.35)
                                          : Colors.grey.withOpacity(0.2)),
                                  child: CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      onChanged: (val) {
                                        context
                                            .read<PayreceiptController>()
                                            .advancests = false;

                                        context
                                            .read<PayreceiptController>()
                                            .itemDeSelect(index);
                                      },
                                      value: context
                                          .read<PayreceiptController>()
                                          .getScanneditemData[index]
                                          .checkClr,
                                      title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(context
                                                              .watch<
                                                                  PayreceiptController>()
                                                              .getScanneditemData[
                                                                  index]
                                                              .doctype
                                                              .toString() +
                                                          " - " +
                                                          context
                                                              .watch<
                                                                  PayreceiptController>()
                                                              .getScanneditemData[
                                                                  index]
                                                              .docNum
                                                              .toString())
                                                    ],
                                                  ),
                                                  Text(context
                                                      .read<
                                                          PayreceiptController>()
                                                      .config
                                                      .alignDate(context
                                                          .read<
                                                              PayreceiptController>()
                                                          .getScanneditemData[
                                                              index]
                                                          .date
                                                          .toString()))
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Text("Invoice Amt"),
                                                  ),
                                                  Container(
                                                      child: Text(
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .config
                                                        .splitValues(context
                                                            .read<
                                                                PayreceiptController>()
                                                            .getScanneditemData[
                                                                index]
                                                            .amount!
                                                            .toStringAsFixed(
                                                                2)),
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                  )),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                width:
                                                    widget.searchWidth * 0.15,
                                                height:
                                                    widget.searchHeight * 0.08,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        widget.searchWidth *
                                                            0.005),
                                                // height: searchHeight *
                                                //     0.025,
                                                child: TextFormField(
                                                  readOnly: context
                                                              .watch<
                                                                  PayreceiptController>()
                                                              .getScanneditemData[
                                                                  index]
                                                              .checkClr ==
                                                          true
                                                      ? false
                                                      : true,
                                                  onTap: () {
                                                    context
                                                            .read<
                                                                PayreceiptController>()
                                                            .mycontroller[index]
                                                            .text =
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .mycontroller[index]
                                                            .text;
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .mycontroller[index]
                                                        .selection = TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset: context
                                                          .read<
                                                              PayreceiptController>()
                                                          .mycontroller[index]
                                                          .text
                                                          .length,
                                                    );
                                                  },
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                  onChanged: (v) {},
                                                  cursorColor: Colors.grey,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onEditingComplete: () {
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .totalpaidamt(
                                                            context, theme);
                                                  },
                                                  controller: context
                                                      .read<
                                                          PayreceiptController>()
                                                      .mycontroller[index],
                                                  decoration: InputDecoration(
                                                    filled: false,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      vertical: 0,
                                                      horizontal: 5,
                                                    ),
                                                  ),
                                                ))
                                          ])),
                                ),
                              );
                            }),
                      ),
            SizedBox(
              height: widget.searchHeight * 0.04,
            ),
            context.read<PayreceiptController>().scanneditemData2.isNotEmpty
                ? Container()
                : context.read<PayreceiptController>().scanneditemData.isEmpty
                    ? Container()
                    : Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            SizedBox(
                              width: widget.searchWidth * 0.45,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<PayreceiptController>()
                                            .selectall();
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(
                                          widget.searchHeight * 0.01),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: theme.primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.grey.withOpacity(0.05),
                                      ),
                                      height: widget.searchHeight * 0.06,
                                      width: widget.searchWidth * 0.2,
                                      child: Text(
                                        "Select All",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<PayreceiptController>()
                                            .deSelectall();
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(
                                          widget.searchHeight * 0.01),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: theme.primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        // color: Colors.red
                                        color: Colors.grey.withOpacity(0.05),
                                      ),
                                      height: widget.searchHeight * 0.06,
                                      width: widget.searchWidth * 0.2,
                                      child: Text(
                                        "Deselect All",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              // color: Colors.red,
                              height: widget.searchHeight * 0.09,
                              width: widget.searchWidth * 0.2,
                              padding: EdgeInsets.all(6),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: widget.theme.primaryColor,
                                    side: BorderSide(
                                      color: widget.theme.primaryColor,
                                    )),
                                onPressed: context
                                            .read<PayreceiptController>()
                                            .advancests ==
                                        true
                                    ? null
                                    : () {
                                        setState(() {
                                          context
                                              .read<PayreceiptController>()
                                              .advancests = true;
                                          context
                                              .read<PayreceiptController>()
                                              .deSelectalladv(
                                                  "Advance", context, theme);
                                        });
                                      },

                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                // context.read<PayreceiptController>().advancests = true;
                                // context.read<PayreceiptController>().deSelectalladv("Advance", context, theme);
                                //     });
                                //   },
                                //   child: Container(
                                //     alignment: Alignment.center,
                                //     padding: EdgeInsets.all(widget.searchHeight * 0.01),
                                //     decoration: BoxDecoration(border: Border.all(color: theme.primaryColor), borderRadius: BorderRadius.circular(5), color: theme.primaryColor
                                //         ),
                                // height: widget.searchHeight * 0.06,
                                // width: widget.searchWidth * 0.2,
                                child: Text(
                                  "Advance",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ]))
          ],
        ));
  }
}
