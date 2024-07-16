// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesQuotationController/SalesQuotationController.dart';
import '../../../Widgets/ContentContainer.dart';
import '../../../Widgets/AlertBox.dart';
import 'Dialog Box/SearchProduct.dart';

class SQuotationSearchWidget extends StatefulWidget {
  SQuotationSearchWidget(
      {Key? key,
      required this.theme,
      //required this.prdsrch,
      required this.searchHeight,
      required this.searchWidth})
      : super(key: key);

  final ThemeData theme;
  //SOCon prdsrch;
  double searchHeight;
  double searchWidth;

  @override
  State<SQuotationSearchWidget> createState() => _SQuotationSearchWidgetState();
}

class _SQuotationSearchWidgetState extends State<SQuotationSearchWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: widget.searchHeight,
      width: widget.searchWidth,
      padding: EdgeInsets.only(
          top: widget.searchHeight * 0.01,
          left: widget.searchHeight * 0.01,
          right: widget.searchHeight * 0.01,
          bottom: widget.searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.read<SalesQuotationCon>().scanneditemData2.isNotEmpty
              ? Container()
              : Container(
                  alignment: Alignment.center,
                  width: widget.searchWidth * 1,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    readOnly: context.watch<SalesQuotationCon>().editqty,
                    autofocus: true,
                    // focusNode: context.watch<SalesQuotationCon>().focusnode[0],
                    style: theme.textTheme.bodyMedium,
                    cursorColor: Colors.grey,
                    controller: context.read<SalesQuotationCon>().searchcon,
                    onEditingComplete: () async {
                      await context.read<SalesQuotationCon>().getAllList(context
                          .read<SalesQuotationCon>()
                          .searchcon
                          .text
                          .trim());

                      if (context
                          .read<SalesQuotationCon>()
                          .getSearchedData
                          .isEmpty) {
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
                                      content: 'Wrong Itemcode Scanned..!!',
                                      theme: theme,
                                    )),
                                    buttonName: null,
                                  ));
                            });
                      } else if (context
                              .read<SalesQuotationCon>()
                              .getSearchedData
                              .length ==
                          1) {
                        context
                            .read<SalesQuotationCon>()
                            .singleitemsearch(context, theme, 0);
                      } else {
                        showDialog<dynamic>(
                            context: context,
                            builder: (_) {
                              return SearchItemsSQ();
                            });
                      }
                      context
                          .read<SalesQuotationCon>()
                          .disableKeyBoard(context);
                    },
                    decoration: InputDecoration(
                      filled: false,
                      hintText: 'Inventories',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed:
                            context.read<SalesQuotationCon>().editqty == true
                                ? null
                                : () {
                                    context
                                        .read<SalesQuotationCon>()
                                        .getAllList(context
                                            .read<SalesQuotationCon>()
                                            .searchcon
                                            .text
                                            .trim())
                                        .then((value) {
                                      showDialog<dynamic>(
                                          context: context,
                                          builder: (_) {
                                            return SearchItemsSQ();
                                          });
                                    });
                                  },
                        icon: Icon(
                          Icons.search,
                          // size: searchHeight * 0.05,
                          color: Colors.grey,
                        ),
                        color: theme.primaryColor,
                      ),
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
                  onTap: () {
                    // context.read<SalesQuotationCon>().viewdetails();
                    // prdsrch.getcustaddresslist();
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
                  // color: Colors.green,
                  width: widget.searchWidth * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          // color: Colors.red,
                          alignment: Alignment.center,
                          width: widget.searchWidth * 0.07,
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
                          width: widget.searchWidth * 0.15,
                          child: Text(
                            "Tax %",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          )),
                      Container(
                          // color: Colors.red,
                          alignment: Alignment.center,
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
          Expanded(
              child: context
                      .watch<SalesQuotationCon>()
                      .getScanneditemData2
                      .isNotEmpty
                  ? ListView.builder(
                      itemCount: context
                          .watch<SalesQuotationCon>()
                          .getScanneditemData2
                          .length,
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
                                            // color: Colors.yellow,

                                            width: widget.searchWidth * 0.4,
                                            // height: searchHeight * 0.02,
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "${context.watch<SalesQuotationCon>().getScanneditemData2[index].ItemName.toString()}",
                                                  maxLines: 2,
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ))),
                                      ],
                                    ),
                                    SizedBox(
                                      // width: widget.searchWidth * 0.55,
                                      // color: Colors.yellow,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: widget.searchWidth * 0.1,
                                              height:
                                                  widget.searchHeight * 0.07,
                                              alignment: Alignment.center,
                                              // width: Screens.width(context) * 0.015,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      widget.searchWidth *
                                                          0.005),
                                              // height: searchHeight *
                                              //     0.025,
                                              child: TextFormField(
                                                readOnly: true,
                                                textAlign: TextAlign.right,
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black),
                                                onChanged: (v) {},
                                                cursorColor: Colors.grey,
                                                textDirection:
                                                    TextDirection.ltr,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                onTap: () {
                                                  // context.read<SalesQuotationCon>().qtymycontroller2[index].text = context.read<SalesQuotationCon>().qtymycontroller2[index].text;
                                                  // context.read<SalesQuotationCon>().qtymycontroller2[index].selection = TextSelection(
                                                  //   baseOffset: 0,
                                                  //   extentOffset: context.read<SalesQuotationCon>().qtymycontroller2[index].text.length,
                                                  // );
                                                },
                                                onEditingComplete: () {
                                                  // context.read<SalesQuotationCon>().postqtyEdited(index, context, theme);
                                                  // context.read<SalesQuotationCon>().disableKeyBoard(context);
                                                },
                                                controller: context
                                                    .read<SalesQuotationCon>()
                                                    .qtymycontroller2[index],
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
                                              )),
                                          Container(
                                              width: widget.searchWidth * 0.09,
                                              height:
                                                  widget.searchHeight * 0.07,
                                              // color: Colors.blue,
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                readOnly: true,
                                                textAlign: TextAlign.right,
                                                style:
                                                    theme.textTheme.bodyMedium,
                                                onChanged: (v) {},
                                                onEditingComplete: () {},
                                                cursorColor: Colors.grey,
                                                textDirection:
                                                    TextDirection.ltr,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: context
                                                    .read<SalesQuotationCon>()
                                                    .discountcontroller2[index],
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
                                              )),
                                          Container(
                                            width: widget.searchWidth * 0.17,
                                            // color: Colors.blue,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                context
                                                            .watch<
                                                                SalesQuotationCon>()
                                                            .getScanneditemData2[
                                                                index]
                                                            .TaxRate ==
                                                        null
                                                    ? '00'
                                                    : ' ${context.watch<SalesQuotationCon>().getScanneditemData2[index].TaxRate}',
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black)),
                                          ),
                                          Container(
                                            // color: Colors.blue,
                                            width: widget.searchWidth * 0.17,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              context
                                                  .watch<SalesQuotationCon>()
                                                  .config
                                                  .splitValues(
                                                      "${context.watch<SalesQuotationCon>().getScanneditemData2[index].SellPrice}"),
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.black),
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
                                          "${context.watch<SalesQuotationCon>().getScanneditemData2[index].SerialBatch}",
                                          textAlign: TextAlign.start,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(),
                                        )),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      // width: searchWidth * 0.13,
                                      child: Text(
                                        // "  |  DC-ABV12K-1YR",
                                        "${context.watch<SalesQuotationCon>().getScanneditemData2[index].ItemCode}",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                    ),
                                  ],
                                )
                              ])),
                        );
                      })
                  : ListView.builder(
                      itemCount: context
                          .watch<SalesQuotationCon>()
                          .getScanneditemData
                          .length,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: widget.searchWidth * 0.4,
                                              // color: Colors.green,
                                              // height: searchHeight * 0.02,
                                              alignment: Alignment.centerLeft,
                                              child: TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    context
                                                            .watch<
                                                                SalesQuotationCon>()
                                                            .getScanneditemData[
                                                                index]
                                                            .ItemName ??
                                                        '', // "${context.watch<SalesQuotationCon>().getScanneditemData[index].ItemName}",
                                                    maxLines: 2,
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black),
                                                  ))),
                                        ],
                                      ),
                                      SizedBox(
                                        width: widget.searchWidth * 0.5,
                                        // color: Colors.yellow,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: widget.searchWidth * 0.1,
                                                height:
                                                    widget.searchHeight * 0.07,
                                                alignment: Alignment.center,
                                                // width: Screens.width(context) * 0.015,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        widget.searchWidth *
                                                            0.005),
                                                // height: searchHeight *
                                                //     0.025,
                                                child: TextFormField(
                                                  textAlign: TextAlign.right,
                                                  onTap: () {
                                                    context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .qtymycontroller[index]
                                                            .text =
                                                        context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .qtymycontroller[
                                                                index]
                                                            .text;
                                                    context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .qtymycontroller[index]
                                                        .selection = TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset: context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .qtymycontroller[
                                                              index]
                                                          .text
                                                          .length,
                                                    );
                                                  },
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                  onChanged: (v) {
                                                    // context
                                                    //     .read<
                                                    //         SalesQuotationCon>()
                                                    //     .qtyEdited(index,
                                                    //         context, theme);
                                                  },
                                                  cursorColor: Colors.grey,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  onEditingComplete: () {
                                                    context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .qtyEdited(index,
                                                            context, theme);
                                                    context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .disableKeyBoard(
                                                            context);
                                                  },
                                                  controller: context
                                                      .read<SalesQuotationCon>()
                                                      .qtymycontroller[index],
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
                                                )

                                                // Text(
                                                //     "${prdsrch.getScanneditemData[index].Qty}",
                                                // style: theme.textTheme.bodyText2
                                                //     ?.copyWith(
                                                //         color: Colors.black)),
                                                ),
                                            Container(
                                                width:
                                                    widget.searchWidth * 0.09,
                                                height:
                                                    widget.searchHeight * 0.07,
                                                // color: Colors.blue,
                                                alignment: Alignment.center,
                                                child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.right,
                                                  style: theme
                                                      .textTheme.bodyMedium,
                                                  onChanged: (v) {},
                                                  onTap: () {
                                                    context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .discountcontroller[
                                                                index]
                                                            .text =
                                                        context
                                                            .read<
                                                                SalesQuotationCon>()
                                                            .discountcontroller[
                                                                index]
                                                            .text;
                                                    context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .discountcontroller[
                                                            index]
                                                        .selection = TextSelection(
                                                      baseOffset: 0,
                                                      extentOffset: context
                                                          .read<
                                                              SalesQuotationCon>()
                                                          .discountcontroller[
                                                              index]
                                                          .text
                                                          .length,
                                                    );
                                                  },
                                                  onEditingComplete: () {
                                                    context
                                                        .read<
                                                            SalesQuotationCon>()
                                                        .calCulateDocVal(
                                                            context, theme);
                                                  },
                                                  cursorColor: Colors.grey,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: context
                                                      .read<SalesQuotationCon>()
                                                      .discountcontroller[index],
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
                                                )
                                                // //   Text(
                                                // //  "${prdsrch.getScanneditemData[index].discount.toString()}",
                                                // // //  getScanneditemData[index].
                                                // // //   Maxdiscount}",
                                                // //     style: theme.textTheme.bodyText2
                                                // //         ?.copyWith(color: Colors.black),
                                                // //   ),
                                                ),
                                            Container(
                                              width: widget.searchWidth * 0.12,
                                              // color: Colors.blue,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  context
                                                              .watch<
                                                                  SalesQuotationCon>()
                                                              .getScanneditemData[
                                                                  index]
                                                              .TaxRate ==
                                                          null
                                                      ? '00'
                                                      : ' ${context.watch<SalesQuotationCon>().getScanneditemData[index].TaxRate}',
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black)),
                                            ),
                                            Container(
                                              // color: Colors.blue,
                                              width: widget.searchWidth * 0.17,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                context
                                                    .watch<SalesQuotationCon>()
                                                    .config
                                                    .splitValues(
                                                        "${context.watch<SalesQuotationCon>().getScanneditemData[index].SellPrice}"),
                                                style: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black),
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
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Container(
                                        //     alignment: Alignment.centerLeft,
                                        //     child: Text(
                                        //       "${context.watch<SalesQuotationCon>().getScanneditemData[index].SerialBatch}",
                                        //       textAlign: TextAlign.start,
                                        //       style: theme.textTheme.bodyMedium
                                        //           ?.copyWith(),
                                        //     )),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          // width: searchWidth * 0.13,
                                          child: Text(
                                            // "  |  DC-ABV12K-1YR",
                                            " ${context.watch<SalesQuotationCon>().getScanneditemData[index].ItemCode}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                                        ),
                                        // context
                                        //             .watch<SalesQuotationCon>()
                                        //             .editqty ==
                                        //         true
                                        //     ? GestureDetector(
                                        //         onTap: (() {}),
                                        //         child: Container(
                                        //             padding: EdgeInsets.only(
                                        //                 right:
                                        //                     widget.searchWidth *
                                        //                         0.05),
                                        //             alignment:
                                        //                 Alignment.centerLeft,
                                        //             child: Icon(
                                        //               Icons
                                        //                   .delete_outline_sharp,
                                        //               color: Colors.red,
                                        //               size:
                                        //                   widget.searchHeight *
                                        //                       0.06,
                                        //             )),
                                        //       )
                                        //     : Container(),
                                      ],
                                    ),
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
