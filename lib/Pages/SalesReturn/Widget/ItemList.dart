// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesReturnController/SalesReturnController.dart';

class SalesReturnItem extends StatefulWidget {
  SalesReturnItem(
      {Key? key,
      required this.theme,
      // required this.prdsrch,
      required this.searchHeight,
      required this.searchWidth})
      : super(key: key);

  final ThemeData theme;
  // SalesReturnController prdsrch;
  double searchHeight;
  double searchWidth;

  @override
  State<SalesReturnItem> createState() => _SalesReturnItemState();
}

class _SalesReturnItemState extends State<SalesReturnItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: widget.searchHeight,
      width: widget.searchWidth,
      padding: EdgeInsets.only(
          top: widget.searchHeight * 0.05,
          left: widget.searchHeight * 0.01,
          right: widget.searchHeight * 0.01,
          bottom: widget.searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                GestureDetector(
                  onTap: () {
                    context.read<SalesReturnController>().viewSalesRet();
                    // context.read<SalesReturnController>().balanceqtycheck();
                  },
                  child: Container(
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                        left: widget.searchHeight * 0.01,
                      ),
                      alignment: Alignment.centerLeft,
                      width: widget.searchWidth * 0.4,
                      child: Text(
                        "Product Information",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      )),
                ),
                SizedBox(
                  width: widget.searchWidth * 0.55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.06,
                          child: Text(
                            "Qty",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Container(
                          // color: Colors.red,
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.13,
                          child: Text(
                            "Discount %",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Container(
                          // color: Colors.red,
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.13,
                          child: Text(
                            "Tax %",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Container(
                          // color: Colors.red,
                          alignment: Alignment.centerRight,
                          width: widget.searchWidth * 0.15,
                          child: Text(
                            "Price",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          context.watch<SalesReturnController>().getScanneditemData2.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      itemCount: context
                          .watch<SalesReturnController>()
                          .getScanneditemData2
                          .length,
                      //prdsrch.getsalesInvoiceData[0].item!.length,
                      itemBuilder: (context, index) {
                        return Card(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: widget.searchWidth * 0.37,
                                            // height: searchHeight * 0.02,
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "${context.watch<SalesReturnController>().getScanneditemData2[index].ItemName}", //  "${prdsrch.getsalesInvoiceData[index].item![index].ItemName}",
                                                  maxLines: 2,
                                                  //  "${prdsrch.getScanneditemData[index].ItemName}",
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ))),
                                      ],
                                    ),
                                    Container(
                                        width: widget.searchWidth * 0.09,
                                        height: widget.searchHeight * 0.07,
                                        alignment: Alignment.center,
                                        // width: Screens.width(context) * 0.015,
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                widget.searchWidth * 0.005),
                                        // height: searchHeight *
                                        //     0.025,
                                        child: TextFormField(
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black),
                                          onChanged: (v) {},
                                          cursorColor: Colors.grey,
                                          textDirection: TextDirection.rtl,
                                          keyboardType: TextInputType.number,
                                          readOnly: true,
                                          onEditingComplete: () {},
                                          controller: context
                                              .watch<SalesReturnController>()
                                              .qtymycontroller2[index],
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
                                        )

                                        // Text(
                                        //     "${prdsrch.getScanneditemData[index].Qty}",
                                        // style: theme.textTheme.bodyText2
                                        //     ?.copyWith(
                                        //         color: Colors.black)),
                                        ),
                                    // Container(
                                    //   width: searchWidth * 0.15,
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceEvenly,
                                    //     children: [
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
                                    //       Container(
                                    //         alignment: Alignment.center,
                                    //         // width: Screens.width(context) * 0.015,
                                    //         padding: EdgeInsets.symmetric(
                                    //             horizontal:
                                    //                 searchWidth * 0.005),
                                    //         // height: searchHeight *
                                    //         //     0.025,
                                    //         child: Text(
                                    //             "${prdsrch.getScanneditemData[index].Qty}", //    "${prdsrch.getsalesInvoiceData[index].item![index].Qty}",
                                    //             style: theme.textTheme.bodyText2
                                    //                 ?.copyWith(
                                    //                     color: Colors.black)),
                                    //       ),
                                    //        InkWell(
                                    //       onTap: () {
                                    //         prdsrch.itemIncrement(
                                    //             index, context, theme);
                                    //       },
                                    //       child: Container(
                                    //         alignment: Alignment.center,
                                    //         width: searchWidth * 0.05,
                                    //         height: searchHeight * 0.05,
                                    //         color: Colors.blue,
                                    //         child: Icon(
                                    //           Icons.add,
                                    //           color: Colors.white,
                                    //           size: searchHeight * 0.05,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      width: widget.searchWidth * 0.08,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${context.watch<SalesReturnController>().getScanneditemData2[index].discountper.toString()}",
                                        //  getScanneditemData[index].
                                        //   Maxdiscount}",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      width: widget.searchWidth * 0.16,
                                      // color: Colors.blue,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          context
                                              .watch<SalesReturnController>()
                                              .getScanneditemData2[index]
                                              .TaxRate!
                                              .toStringAsFixed(2),
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black)),
                                    ),
                                    Container(
                                      width: widget.searchWidth * 0.16,
                                      // color: Colors.blue,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "₹ ${context.watch<SalesReturnController>().getScanneditemData2[index].SellPrice!.toStringAsFixed(2)}", //  "${prdsrch.getsalesInvoiceData[index].item![index].SellPrice}",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.black),
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
                                          "${context.watch<SalesReturnController>().getScanneditemData2[index].SerialBatch}", //      "${prdsrch.getsalesInvoiceData[index].item![index].SerialBatch}",
                                          textAlign: TextAlign.start,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(),
                                        )),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      // width: searchWidth * 0.13,
                                      child: Text(
                                        // "  |  DC-ABV12K-1YR",
                                        "  |  ${context.watch<SalesReturnController>().getScanneditemData2[index].ItemCode}", //    "  |  ${prdsrch.getsalesInvoiceData[index].item![index].ItemCode}",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                    ),
                                  ],
                                )
                              ])),
                        );
                      }))
              : context
                          .watch<SalesReturnController>()
                          .getScanneditemData
                          .isEmpty ||
                      context
                              .watch<SalesReturnController>()
                              .getScanneditemData
                              .length ==
                          0
                  ? Container()
                  : Expanded(
                      child: ListView.builder(
                          itemCount: context
                              .watch<SalesReturnController>()
                              .getScanneditemData
                              .length,
                          //prdsrch.getsalesInvoiceData[0].item!.length,
                          itemBuilder: (context, index) {
                            return Card(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:
                                                    widget.searchWidth * 0.37,
                                                // height: searchHeight * 0.02,
                                                alignment: Alignment.centerLeft,
                                                child: TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      "${context.watch<SalesReturnController>().getScanneditemData[index].ItemName}", //  "${prdsrch.getsalesInvoiceData[index].item![index].ItemName}",
                                                      maxLines: 2,
                                                      //  "${prdsrch.getScanneditemData[index].ItemName}",
                                                      style: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ))),
                                          ],
                                        ),
                                        Container(
                                            width: widget.searchWidth * 0.09,
                                            height: widget.searchHeight * 0.07,
                                            alignment: Alignment.center,
                                            // width: Screens.width(context) * 0.015,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    widget.searchWidth * 0.005),
                                            // height: searchHeight *
                                            //     0.025,
                                            child: TextFormField(
                                              onTap: () {
                                                context
                                                        .read<
                                                            SalesReturnController>()
                                                        .qtymycontroller[index]
                                                        .text =
                                                    context
                                                        .read<
                                                            SalesReturnController>()
                                                        .qtymycontroller[index]
                                                        .text;
                                                context
                                                    .read<
                                                        SalesReturnController>()
                                                    .qtymycontroller[index]
                                                    .selection = TextSelection(
                                                  baseOffset: 0,
                                                  extentOffset: context
                                                      .read<
                                                          SalesReturnController>()
                                                      .qtymycontroller[index]
                                                      .text
                                                      .length,
                                                );
                                              },
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.black),
                                              cursorColor: Colors.grey,
                                              textDirection: TextDirection.rtl,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              onEditingComplete: () {
                                                setState(() {
                                                  context
                                                      .read<
                                                          SalesReturnController>()
                                                      .itemIncrement11(index,
                                                          context, theme);
                                                  context
                                                      .read<
                                                          SalesReturnController>()
                                                      .calCulateDocVal();
                                                });

                                                context
                                                    .read<
                                                        SalesReturnController>()
                                                    .disableKeyBoard(context);
                                              },
                                              controller: context
                                                  .read<SalesReturnController>()
                                                  .qtymycontroller[index],
                                              decoration: InputDecoration(
                                                filled: false,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
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
                                            )

                                            // Text(
                                            //     "${prdsrch.getScanneditemData[index].Qty}",
                                            // style: theme.textTheme.bodyText2
                                            //     ?.copyWith(
                                            //         color: Colors.black)),
                                            ),
                                        // Container(
                                        //   width: searchWidth * 0.15,
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.spaceEvenly,
                                        //     children: [
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
                                        //       Container(
                                        //         alignment: Alignment.center,
                                        //         // width: Screens.width(context) * 0.015,
                                        //         padding: EdgeInsets.symmetric(
                                        //             horizontal:
                                        //                 searchWidth * 0.005),
                                        //         // height: searchHeight *
                                        //         //     0.025,
                                        //         child: Text(
                                        //             "${prdsrch.getScanneditemData[index].Qty}", //    "${prdsrch.getsalesInvoiceData[index].item![index].Qty}",
                                        //             style: theme.textTheme.bodyText2
                                        //                 ?.copyWith(
                                        //                     color: Colors.black)),
                                        //       ),
                                        //        InkWell(
                                        //       onTap: () {
                                        //         prdsrch.itemIncrement(
                                        //             index, context, theme);
                                        //       },
                                        //       child: Container(
                                        //         alignment: Alignment.center,
                                        //         width: searchWidth * 0.05,
                                        //         height: searchHeight * 0.05,
                                        //         color: Colors.blue,
                                        //         child: Icon(
                                        //           Icons.add,
                                        //           color: Colors.white,
                                        //           size: searchHeight * 0.05,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          width: widget.searchWidth * 0.08,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${context.watch<SalesReturnController>().getScanneditemData[index].discountper.toString()}",
                                            //  getScanneditemData[index].
                                            //   Maxdiscount}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          width: widget.searchWidth * 0.16,
                                          // color: Colors.blue,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                              context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .getScanneditemData[index]
                                                  .TaxRate
                                                  .toString(),
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.black)),
                                        ),
                                        Container(
                                          width: widget.searchWidth * 0.16,
                                          // color: Colors.blue,
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "₹  ${context.watch<SalesReturnController>().getScanneditemData[index].SellPrice!.toStringAsFixed(2)}", //  "${prdsrch.getsalesInvoiceData[index].item![index].SellPrice}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
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
                                              "${context.watch<SalesReturnController>().getScanneditemData[index].SerialBatch}", //      "${prdsrch.getsalesInvoiceData[index].item![index].SerialBatch}",
                                              textAlign: TextAlign.start,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(),
                                            )),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          // width: searchWidth * 0.13,
                                          child: Text(
                                            // "  |  DC-ABV12K-1YR",
                                            "  |  ${context.watch<SalesReturnController>().getScanneditemData[index].ItemCode}", //    "  |  ${prdsrch.getsalesInvoiceData[index].item![index].ItemCode}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(),
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
