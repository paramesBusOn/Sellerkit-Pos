// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, must_be_immutable
import 'package:flutter/material.dart';
import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';

class PayReceipt_ProWidget extends StatefulWidget {
  PayReceipt_ProWidget({
    Key? key,
    required this.theme,
    required this.prdsrch,
    required this.ProHeight,
    required this.ProWidth,
  }) : super(key: key);
  double ProHeight;
  double ProWidth;

  final ThemeData theme;
  PayreceiptController prdsrch;
  @override
  State<PayReceipt_ProWidget> createState() => _PayReceipt_ProWidgetState();
}

class _PayReceipt_ProWidgetState extends State<PayReceipt_ProWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(
        widget.ProHeight * 0.01,
      ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: widget.ProHeight * 0.13,
            width: widget.ProWidth * 0.97,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3), //color of shadow
                  spreadRadius: 3, //spread radius
                  blurRadius: 2, // blur radius
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: TextFormField(
              controller: widget.prdsrch.mycontroller[80],
              style: theme.textTheme.bodySmall!.copyWith(color: Colors.black),
              keyboardType: TextInputType.number,

              onChanged: (val) {},
              onEditingComplete: () {
                widget.prdsrch.invoiceScan(context, theme);
              },
              // Only numbers can be entered
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8),
                hintText: "Invoice Number",
                hintStyle: theme.textTheme.bodySmall!
                    .copyWith(color: Colors.grey[600]),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(widget.ProHeight * 0.005),
                  child: Container(
                    width: widget.ProWidth * 0.05,
                    height: widget.ProHeight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        shape: BoxShape.rectangle),
                    child: IconButton(
                      onPressed: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: ((context) =>
                        //               SettingScreens())));

                        //   // Get.toNamed(ConstantRoutes.SettingScreens);
                      },
                      icon: Icon(
                        Icons.search,
                      ),
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: widget.ProHeight * 0.008,
          ),
          widget.prdsrch.scanneditemData.isEmpty
              ? Container(
                height: widget.ProHeight * 0.15,
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.prdsrch.AAAAdvance("Advance", context, theme);
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(widget.ProHeight * 0.01),
                        decoration: BoxDecoration(
                            border: Border.all(color: theme.primaryColor),
                            borderRadius: BorderRadius.circular(5),
                            color: theme.primaryColor
                            // color: Colors.grey.withOpacity(0.05),
                            ),
                        height: widget.ProHeight * 0.1,
                        width: widget.ProWidth * 0.2,
                        child: Text(
                          "Advance",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  )
              : SizedBox(
                  width: widget.ProWidth * 0.97,
                  height: widget.ProHeight * 0.82,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: widget.ProHeight * 0.7,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: widget.prdsrch.getScanneditemData.length,
                            // widget.prdsrch.getselectcust!.payItem!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  child: Container(
                                height: widget.ProHeight * 0.15,
                                padding: EdgeInsets.only(
                                  top: widget.ProHeight * 0.01,
                                  left: widget.ProHeight * 0.01,
                                  right: widget.ProHeight * 0.01,
                                  bottom: widget.ProHeight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: widget
                                                    .prdsrch
                                                    .getScanneditemData[index]
                                                    // .getselectcust!

                                                    // .payItem![index]
                                                    .checkbx ==
                                                1 &&
                                            widget
                                                    .prdsrch
                                                    .getScanneditemData[index]
                                                    .checkClr ==
                                                true
                                        ? Colors.blue.withOpacity(0.3)
                                        : Colors.grey.withOpacity(0.15)),
                                child: CheckboxListTile(
                                    visualDensity: VisualDensity.compact,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    contentPadding:
                                        EdgeInsets.all(widget.ProHeight * 0.0),
                                    onChanged: (val) {
                                      widget.prdsrch.itemDeSelect(index);
                                    },
                                    value: widget.prdsrch
                                        .getScanneditemData[index].checkClr,
                                    title: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "${widget.prdsrch.getScanneditemData[index].doctype} - ${widget.prdsrch.getScanneditemData[index].docNum}"),
                                                Text(widget.prdsrch.config
                                                    .alignDate(widget
                                                        .prdsrch
                                                        .getScanneditemData[
                                                            index]
                                                        .date
                                                        .toString()))
                                              ],
                                            ),
                                          ),
                                          Text(
                                            widget
                                                .prdsrch
                                                .getScanneditemData[index]
                                                .amount!
                                                .toStringAsFixed(2)
                                                .toString(),
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                          ),
                                          Container(
                                              width: widget.ProWidth * 0.22,
                                              height: widget.ProHeight * 0.08,
                                              alignment: Alignment.center,
                                              // width: Screens.width(context) * 0.015,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      widget.ProWidth * 0.005),
                                              // height: searchHeight *
                                              //     0.025,
                                              child: TextFormField(
                                                style: theme.textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black),
                                                onChanged: (v) {},
                                                cursorColor: Colors.grey,
                                                textDirection:
                                                    TextDirection.rtl,
                                                keyboardType:
                                                    TextInputType.number,
                                                onEditingComplete: () {
                                                  widget.prdsrch.totalpaidamt(
                                                      context, theme);
                                                },
                                                controller: widget.prdsrch
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
                              ));
                            }),
                      ),
                      SizedBox(
                        height: widget.ProHeight * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.all(widget.ProHeight * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: widget.ProWidth * 0.45,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      widget.prdsrch.selectall();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(
                                          widget.ProHeight * 0.01),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: theme.primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        // color: Colors.red
                                        color: Colors.grey.withOpacity(0.05),
                                      ),
                                      height: widget.ProHeight * 0.08,
                                      width: widget.ProWidth * 0.2,
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
                                      widget.prdsrch.deSelectall();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(
                                          widget.ProHeight * 0.01),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: theme.primaryColor),
                                        borderRadius: BorderRadius.circular(5),
                                        // color: Colors.red
                                        color: Colors.grey.withOpacity(0.05),
                                      ),
                                      height: widget.ProHeight * 0.08,
                                      width: widget.ProWidth * 0.2,
                                      child: Text(
                                        "Deselect All",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: theme.primaryColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  // widget.prdsrch.forOnAccPaid("Advance",context,theme);
                                  widget.prdsrch.deSelectalladv(
                                      "Advance", context, theme);
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding:
                                    EdgeInsets.all(widget.ProHeight * 0.01),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: theme.primaryColor),
                                    borderRadius: BorderRadius.circular(5),
                                    color: theme.primaryColor
                                    // color: Colors.grey.withOpacity(0.05),
                                    ),
                                height: widget.ProHeight * 0.08,
                                width: widget.ProWidth * 0.22,
                                child: Text(
                                  "Advance",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
