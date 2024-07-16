// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:provider/provider.dart';
import '../../../Controller/PaymentReceiptController/PayReceiptController.dart';
import '../../../Widgets/AlertBox.dart';

class PayCustomerDetails extends StatefulWidget {
  PayCustomerDetails(
      {Key? key,
      required this.theme,
      required this.custHeight,
      required this.custWidth})
      : super(key: key);

  final ThemeData theme;
  double custHeight;
  double custWidth;

  @override
  State<PayCustomerDetails> createState() => _PayCustomerDetailsState();
}

class _PayCustomerDetailsState extends State<PayCustomerDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(
          top: widget.custHeight * 0.01,
          bottom: widget.custHeight * 0.01,
          left: widget.custWidth * 0.01,
          right: widget.custWidth * 0.01),
      width: widget.custWidth,
      //height: custHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          context.read<PayreceiptController>().selectedcust2 != null
              ? Container()
              : Container(
                  // width: custWidth * 0.7,
                  width: widget.custWidth * 1,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 240, 235, 235)),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.001),
                  ),
                  child: TextFormField(
                    controller:
                        context.read<PayreceiptController>().mycontroller[81],
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (v) {},
                    onEditingComplete: () {
                      setState(() {
                        context
                            .read<PayreceiptController>()
                            .custcodeScan(context, theme);
                      });
                    },
                    onTap: () {
                      setState(
                        () {
                          context.read<PayreceiptController>().clearTextField();
                          context
                              .read<PayreceiptController>()
                              .refreshfiltercust();
                        },
                      );
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<PayreceiptController>()
                                .clearTextField();
                            context
                                .read<PayreceiptController>()
                                .refreshfiltercust();
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                        payMent: 'Select Customer',
                                        widget: forSearchBtn(context),
                                        buttonName: "Add New",
                                        callback: () {
                                          Navigator.pop(context);
                                          // context.read<PayreceiptController>().mapcustseriesNo = null;

                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    content: AlertBox(
                                                      payMent: 'New Customer',
                                                      widget:
                                                          forAddNewBtn(context),
                                                      buttonName: null,
                                                      // callback: () {
                                                      //   context
                                                      //       .read<
                                                      //           PayreceiptController>()
                                                      //       .createnewchagescustaddres(
                                                      //           context,
                                                      //           theme,
                                                      //           6);
                                                      //   // .addnewCustomer(
                                                      //   //     context, 6);
                                                      //   // prdCD.addNewCus(context, 6);
                                                      // },
                                                    ));
                                              });
                                        },
                                      ));
                                });
                          },

                          // size: custHeight * 0.08,
                          color: Colors.grey,
                          icon: const Icon(Icons.search)),
                      hintText: 'Customers',
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(
                          // color: Colors.grey
                          ),
                      filled: false,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: widget.custHeight * 0.02,
          ),
          context.watch<PayreceiptController>().getselectedcust2 != null
              ? Container(
                  color:
                      context.watch<PayreceiptController>().getselectedcust2 !=
                              null
                          ? Colors.grey[300]
                          : Colors.grey[50],
                  padding: EdgeInsets.symmetric(
                      vertical: widget.custHeight * 0.02,
                      horizontal: widget.custWidth * 0.02),
                  // height: custHeight * 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: widget.custWidth,
                          alignment: Alignment.centerRight,
                          // height: custHeight * 0.02,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                // color: Colors.green,
                                width: widget.custWidth * 0.8,
                                child: Text(
                                  context
                                      .watch<PayreceiptController>()
                                      .getselectedcust2!
                                      .name
                                      .toString(),
                                  maxLines: 1,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ],
                          ) // IconButton(onPressed: (){}, icon: Icon(Icons.close_sharp))
                          ),
                      SizedBox(
                        height: widget.custHeight * 0.01,
                      ),
                      SizedBox(
                        width: widget.custWidth,
                        // color: Colors.green,
                        child: Row(
                          children: [
                            Container(
                              // color: Colors.green,
                              // height: custHeight * 0.02,
                              child: Row(
                                children: [
                                  Container(
                                    child: const Icon(
                                      Icons.phone,
                                      color: Colors.black54,
                                      // size: custHeight * 0.05,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .phNo!
                                                .isNotEmpty
                                            ? " ${context.watch<PayreceiptController>().getselectedcust2!.phNo}  |  "
                                            : '',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: const Icon(
                                      Icons.mail_outline,
                                      color: Colors.black54,
                                      // size: custHeight * 0.05,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .email!
                                                .isNotEmpty
                                            ? " ${context.watch<PayreceiptController>().getselectedcust2!.email}"
                                            : "",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.custHeight * 0.01,
                      ),
                      SizedBox(
                        width: widget.custWidth,
                        // color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: widget.custWidth * 0.465,
                              //  color: Colors.green,
                              // height: custHeight * 0.02,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("GST",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: widget.custWidth * 0.02,
                                    ),
                                    child: Text(
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .tarNo!
                                                .isNotEmpty
                                            ? "${context.watch<PayreceiptController>().getselectedcust2!.tarNo}"
                                            : "",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: widget.custWidth * 0.465,
                              //  color: Colors.red,
                              // height: custHeight * 0.02,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("Balance",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    child: Text(
                                        context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2!
                                                    .accBalance! !=
                                                0
                                            ? context
                                                .watch<PayreceiptController>()
                                                .config
                                                .splitValues(context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2!
                                                    .accBalance
                                                    .toString())
                                            : '0.00',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.custHeight * 0.01,
                      ),
                      SizedBox(
                        width: widget.custWidth,
                        // color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: widget.custWidth * 0.465,
                              //  color: Colors.green,
                              // height: custHeight * 0.02,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("Code#",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: widget.custWidth * 0.02,
                                    ),
                                    child: Text(
                                        "${context.watch<PayreceiptController>().getselectedcust2!.cardCode}",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              width: widget.custWidth * 0.465,
                              // color: Colors.red,
                              // height: custHeight * 0.02,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("Points",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    child: Text(
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .point!
                                                .isNotEmpty
                                            ? "${context.watch<PayreceiptController>().getselectedcust2!.point}"
                                            : "",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: widget.custHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widget.custWidth * 0.465,
                            // color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: widget.custWidth * 0.465,
                                  padding: EdgeInsets.only(
                                      right: widget.custWidth * 0.02),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Text(
                                        "Billing Address",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                      SizedBox(
                                          width: widget.custWidth * 0.04,
                                          child: const Icon(
                                            Icons.arrow_drop_down,
                                            // size: 30,
                                          ))
                                    ],
                                  ),
                                ),
                                context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        "${context.watch<PayreceiptController>().getselectedcust2!.address![0].address1 == null || context.watch<PayreceiptController>().getselectedcust2!.address![0].address1!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust2!.address![0].address1.toString()},"
                                        "${context.watch<PayreceiptController>().getselectedcust2!.address![0].address2 == null || context.watch<PayreceiptController>().getselectedcust2!.address![0].address2!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust2!.address![0].address2.toString()},"
                                        " ${context.watch<PayreceiptController>().getselectedcust2!.address![0].address3 == null || context.watch<PayreceiptController>().getselectedcust2!.address![0].address3!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust2!.address![0].address3.toString()}",
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billCity
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billCity
                                                .toString()
                                            : "",
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billPincode
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billPincode
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billstate
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billstate
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: widget.custWidth * 0.465,
                            //color: Colors.green,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: widget.custWidth * 0.465,
                                  padding: EdgeInsets.only(
                                      right: widget.custWidth * 0.02),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Text(
                                        "Shipping Address",
                                        maxLines: 2,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                      SizedBox(
                                          width: widget.custWidth * 0.04,
                                          child: const Icon(
                                            Icons.arrow_drop_down,
                                            // size: 30,
                                          ))
                                    ],
                                  ),
                                ),
                                context
                                                .watch<PayreceiptController>()
                                                .getselectedcust25 ==
                                            null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust25!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        "${context.watch<PayreceiptController>().getselectedcust25!.address![0].address1!.isNotEmpty ? context.watch<PayreceiptController>().getselectedcust25!.address![0].address1.toString() : ""},"
                                        "${context.watch<PayreceiptController>().getselectedcust25!.address![0].address2!.isNotEmpty ? context.watch<PayreceiptController>().getselectedcust25!.address![0].address2.toString() : ""},"
                                        "${context.watch<PayreceiptController>().getselectedcust25!.address![0].address3!.isNotEmpty ? context.watch<PayreceiptController>().getselectedcust25!.address![0].address3.toString() : ""}",
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                context
                                                .watch<PayreceiptController>()
                                                .getselectedcust25 ==
                                            null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .getselectedcust25!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .read<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billCity
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billCity
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                context
                                                .read<PayreceiptController>()
                                                .getselectedcust25 ==
                                            null ||
                                        context
                                            .read<PayreceiptController>()
                                            .getselectedcust25!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .read<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billPincode
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billPincode
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                context
                                                .read<PayreceiptController>()
                                                .getselectedcust25 ==
                                            null ||
                                        context
                                            .read<PayreceiptController>()
                                            .getselectedcust25!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .read<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billstate
                                                .isNotEmpty
                                            ? context
                                                .watch<PayreceiptController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billstate
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      ))
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : context.watch<PayreceiptController>().getselectedcust == null
                  ? Container(
                      height: widget.custHeight * 1.14,
                      padding: EdgeInsets.symmetric(
                          vertical: widget.custHeight * 0.02,
                          horizontal: widget.custWidth * 0.02),
                      child: SingleChildScrollView(
                        child: Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children: listContainersProduct(
                              context,
                              theme,
                            )),
                      ),
                    )
                  : Container(
                      color: Colors.grey[50],
                      padding: EdgeInsets.symmetric(
                          vertical: widget.custHeight * 0.02,
                          horizontal: widget.custWidth * 0.02),
                      // height: custHeight * 0.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: widget.custWidth,
                              alignment: Alignment.centerRight,
                              // height: custHeight * 0.02,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    // color: Colors.green,
                                    width: widget.custWidth * 0.8,
                                    child: Text(
                                      context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust!
                                                  .name ==
                                              null
                                          ? ""
                                          : context
                                              .watch<PayreceiptController>()
                                              .getselectedcust!
                                              .name
                                              .toString(),
                                      maxLines: 1,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 20),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        context
                                            .read<PayreceiptController>()
                                            .checkboxx = false;
                                        context
                                            .read<PayreceiptController>()
                                            .mapUpdateCustomer(context
                                                .read<PayreceiptController>()
                                                .getselectedCustomer);
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  contentPadding:
                                                      const EdgeInsets.all(0),
                                                  content: AlertBox(
                                                    payMent: 'Update Customer',
                                                    widget: forEditBtn(context),
                                                    buttonName: "Save",
                                                    callback: () {
                                                      context
                                                          .read<
                                                              PayreceiptController>()
                                                          .updateAAAA(
                                                              context,
                                                              theme,
                                                              context
                                                                  .read<
                                                                      PayreceiptController>()
                                                                  .getselectedBillAdress!,
                                                              context
                                                                  .read<
                                                                      PayreceiptController>()
                                                                  .getselectedShipAdress!);

                                                      //  updateType(
                                                      //     context,
                                                      // context
                                                      //     .read<
                                                      //         PayreceiptController>()
                                                      //     .getselectedBillAdress!,
                                                      // context
                                                      //     .read<
                                                      //         PayreceiptController>()
                                                      //     .getselectedShipAdress!),
                                                      // );
                                                      // });
                                                      //   showDialog(
                                                      //       context: context,
                                                      //       barrierDismissible:
                                                      //           false,
                                                      //       builder: (BuildContext
                                                      //           context) {
                                                      //         return AlertDialog(
                                                      //             contentPadding:
                                                      //                 EdgeInsets
                                                      //                     .all(0),
                                                      //             content:
                                                    },
                                                  ));
                                            });
                                      },
                                      child: Container(
                                        width: widget.custWidth * 0.06,
                                        alignment: Alignment.center,
                                        //     color: Colors.red,
                                        child: const Icon(Icons.edit),
                                      )),
                                  InkWell(
                                      onTap: () {
                                        context
                                            .read<PayreceiptController>()
                                            .clearpayData();
                                      },
                                      child: Container(
                                        width: widget.custWidth * 0.06,
                                        alignment: Alignment.center,
                                        //     color: Colors.blue,
                                        child: const Icon(Icons.close_sharp),
                                      )),
                                ],
                              ) // IconButton(onPressed: (){}, icon: Icon(Icons.close_sharp))
                              ),
                          SizedBox(
                            height: widget.custHeight * 0.01,
                          ),
                          SizedBox(
                            width: widget.custWidth,
                            // color: Colors.green,
                            child: Row(
                              children: [
                                Container(
                                  // color: Colors.green,
                                  // height: custHeight * 0.02,
                                  child: Row(
                                    children: [
                                      Container(
                                        child: const Icon(
                                          Icons.phone,
                                          color: Colors.black54,
                                          // size: custHeight * 0.05,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                            context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust!
                                                    .phNo!
                                                    .isNotEmpty
                                                ? " ${context.watch<PayreceiptController>().getselectedcust!.phNo}  |  "
                                                : '',
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: const Icon(
                                          Icons.mail_outline,
                                          color: Colors.black54,
                                          // size: custHeight * 0.05,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                            context
                                                            .read<
                                                                PayreceiptController>()
                                                            .getselectedcust!
                                                            .email ==
                                                        null ||
                                                    context
                                                            .read<
                                                                PayreceiptController>()
                                                            .getselectedcust!
                                                            .email ==
                                                        'null' ||
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .getselectedcust!
                                                        .email!
                                                        .isEmpty
                                                ? ""
                                                : " ${context.watch<PayreceiptController>().getselectedcust!.email}",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: widget.custHeight * 0.01,
                          ),
                          SizedBox(
                            width: widget.custWidth,
                            // color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: widget.custWidth * 0.465,
                                  //  color: Colors.green,
                                  // height: custHeight * 0.02,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                            "GST", //${AppLocalizations.of(context)!.gst}
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: widget.custWidth * 0.02,
                                        ),
                                        child: Text(
                                            context
                                                            .read<
                                                                PayreceiptController>()
                                                            .getselectedcust!
                                                            .tarNo ==
                                                        null ||
                                                    context
                                                            .read<
                                                                PayreceiptController>()
                                                            .getselectedcust!
                                                            .tarNo ==
                                                        'null' ||
                                                    context
                                                        .read<
                                                            PayreceiptController>()
                                                        .getselectedcust!
                                                        .tarNo!
                                                        .isEmpty
                                                ? ""
                                                : "${context.watch<PayreceiptController>().getselectedcust!.tarNo}",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: widget.custWidth * 0.465,
                                  //  color: Colors.red,
                                  // height: custHeight * 0.02,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Balance",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                      Container(
                                        child: Text(
                                            context
                                                        .watch<
                                                            PayreceiptController>()
                                                        .getselectedcust!
                                                        .accBalance !=
                                                    0
                                                ? context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .config
                                                    .slpitCurrency2(context
                                                        .watch<
                                                            PayreceiptController>()
                                                        .getselectedcust!
                                                        .accBalance!
                                                        .toStringAsFixed(2))
                                                : '0.00',
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: widget.custHeight * 0.01,
                          ),
                          SizedBox(
                            width: widget.custWidth,
                            // color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: widget.custWidth * 0.465,
                                  //  color: Colors.green,
                                  // height: custHeight * 0.02,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Code#",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: widget.custWidth * 0.02,
                                        ),
                                        child: Text(
                                            "${context.watch<PayreceiptController>().getselectedcust!.cardCode}",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: widget.custWidth * 0.465,
                                  // color: Colors.red,
                                  // height: custHeight * 0.02,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Points",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                      Container(
                                        child: Text(
                                            context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getselectedcust!
                                                    .point!
                                                    .isNotEmpty
                                                ? "${context.watch<PayreceiptController>().getselectedcust!.point}"
                                                : "",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: widget.custHeight * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  context
                                      .read<PayreceiptController>()
                                      .clearTextField();
                                  billAddress(context);
                                  await context
                                      .read<PayreceiptController>()
                                      .billaddresslist();

                                  context
                                      .read<PayreceiptController>()
                                      .disableKeyBoard(context);
                                },
                                child: SizedBox(
                                  width: widget.custWidth * 0.465,
                                  // color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: widget.custWidth * 0.465,
                                        padding: EdgeInsets.only(
                                            right: widget.custWidth * 0.02),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                child: Text(
                                              "Billing Address",
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )),
                                            SizedBox(
                                                width: widget.custWidth * 0.04,
                                                child: const Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 30,
                                                ))
                                          ],
                                        ),
                                      ),
                                      context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getselectedcust ==
                                                  null ||
                                              context
                                                  .read<PayreceiptController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty ||
                                              context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address ==
                                                  null
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              " ${context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address1 == null || context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address1!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address1.toString()},"
                                              "${context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address2 == null || context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address2!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address2.toString()},"
                                              " ${context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address3 == null || context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address3!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedBillAdress!].address3.toString()}",
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )),
                                      context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedcust !=
                                                      null &&
                                                  context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedcust!
                                                          .address ==
                                                      null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedcust!
                                                          .address![context
                                                              .watch<
                                                                  PayreceiptController>()
                                                              .getselectedBillAdress!]
                                                          .billCity
                                                          .isNotEmpty ||
                                                      context
                                                              .watch<
                                                                  PayreceiptController>()
                                                              .getselectedcust!
                                                              .address![context
                                                                  .watch<
                                                                      PayreceiptController>()
                                                                  .getselectedBillAdress!]
                                                              .billCity !=
                                                          null
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedBillAdress!]
                                                      .billCity
                                                      .toString()
                                                  : "",
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )),
                                      context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust ==
                                                  null ||
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address ==
                                                  null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedBillAdress!]
                                                      .billPincode
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedBillAdress!]
                                                      .billPincode
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )),
                                      context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address ==
                                                  null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedBillAdress!]
                                                      .billstate
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedBillAdress!]
                                                      .billstate
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(
                                    () {
                                      context
                                          .read<PayreceiptController>()
                                          .clearTextField();
                                      sipaddress(context);
                                      context
                                          .read<PayreceiptController>()
                                          .shippinfaddresslist();
                                    },
                                  );

                                  context
                                      .read<PayreceiptController>()
                                      .disableKeyBoard(context);
                                },
                                child: SizedBox(
                                  width: widget.custWidth * 0.465,
                                  //color: Colors.green,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: widget.custWidth * 0.465,
                                        padding: EdgeInsets.only(
                                            right: widget.custWidth * 0.02),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                child: Text(
                                              "Shipping Address",
                                              maxLines: 2,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )),
                                            SizedBox(
                                                width: widget.custWidth * 0.04,
                                                child: const Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 30,
                                                ))
                                          ],
                                        ),
                                      ),
                                      context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55 ==
                                                  null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isEmpty ||
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address ==
                                                  null
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              " ${context.watch<PayreceiptController>().getselectedcust55!.address == null || context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address1!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address1.toString()},"
                                              "${context.watch<PayreceiptController>().getselectedcust55!.address == null || context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address2!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address2.toString()},"
                                              " ${context.watch<PayreceiptController>().getselectedcust55!.address == null || context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address3!.isEmpty ? "" : context.watch<PayreceiptController>().getselectedcust55!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address3.toString()}",

                                              // '${context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address1.toString()},' +
                                              //     '${context.watch<PayreceiptController>().getselectedcust!.address![context.watch<PayreceiptController>().getselectedShipAdress!].address2.toString()},' +
                                              //     context.watch<PayreceiptController>()
                                              //         .getselectedcust!
                                              //         .address![context.watch<PayreceiptController>()
                                              //             .getselectedShipAdress!]
                                              //         .address3
                                              //         .toString(),
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )),
                                      context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55 ==
                                                  null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isEmpty ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billCity
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billCity
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )),
                                      context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55 ==
                                                  null ||
                                              context
                                                  .watch<PayreceiptController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billPincode
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billPincode
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )),
                                      context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getselectedcust55 !=
                                                  null &&
                                              context
                                                  .read<PayreceiptController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isNotEmpty
                                          ? Container(
                                              child: Text(
                                              context
                                                      .read<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .read<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billstate
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<
                                                          PayreceiptController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PayreceiptController>()
                                                          .getselectedShipAdress!]
                                                      .billstate
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ))
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
        ],
      ),
    );
  }

  forSearchBtn(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: widget.custHeight * 0.05,
            left: widget.custHeight * 0.05,
            right: widget.custHeight * 0.05,
            bottom: widget.custHeight * 0.05),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: widget.custWidth * 1.1,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller:
                    context.read<PayreceiptController>().mycontroller[2],
                cursorColor: Colors.grey,
                autofocus: true,
                onChanged: (v) {
                  st(() {
                    context.read<PayreceiptController>().filtercustomerList(v);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search customer..!!',
                  hintStyle:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  filled: false,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 25,
                  ),
                ),
              ),
            ),
            SizedBox(height: widget.custHeight * 0.05),
            SizedBox(
                height: widget.custHeight * 2,
                width: widget.custWidth * 1.1,
                child: ListView.builder(
                    itemCount: context
                        .read<PayreceiptController>()
                        .getfiltercustList1
                        .length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          padding: EdgeInsets.only(
                              top: widget.custHeight * 0.01,
                              left: widget.custHeight * 0.01,
                              right: widget.custHeight * 0.01,
                              bottom: widget.custHeight * 0.03),
                          // height: custHeight * 0.2,
                          child: StatefulBuilder(builder: (context, st) {
                            return ListTile(
                              onTap: () {
                                // st(() {
                                Navigator.pop(context);
                                context
                                    .read<PayreceiptController>()
                                    .custSelected(
                                        context
                                            .read<PayreceiptController>()
                                            .getfiltercustList1[index],
                                        context,
                                        theme);
                                // context.read<PayreceiptController>().custSelected(
                                //       context
                                //           .read<PayreceiptController>()
                                //           .getfiltercustList[index],
                                //       context,theme
                                //     );
                                // });
                              },
                              title: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(context
                                            .watch<PayreceiptController>()
                                            .getfiltercustList1[index]
                                            .cardCode!),
                                      ),
                                      Container(
                                        child: Text(context
                                            .watch<PayreceiptController>()
                                            .getfiltercustList1[index]
                                            .accBalance!
                                            .toString()),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: widget.custWidth * 0.75,
                                        child: Text(
                                          context
                                              .watch<PayreceiptController>()
                                              .getfiltercustList1[index]
                                              .name!,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        child: Text(context
                                            .watch<PayreceiptController>()
                                            .getfiltercustList1[index]
                                            .phNo!),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    })),
            SizedBox(height: widget.custHeight * 0.09),
          ],
        ),
      );
    });
  }

  forAddNewBtn(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: widget.custHeight * 0.1,
                left: widget.custHeight * 0.1,
                right: widget.custHeight * 0.1,
                bottom: widget.custHeight * 0.02),
            width: widget.custWidth * 1.1,
            height: widget.custHeight * 2.5,
            // color: Colors.red,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: context.read<PayreceiptController>().formkey[6],
                    child: Column(
                      children: [
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 20.0),
                          child: DropdownButtonFormField<String>(
                              validator: (value) => value == null
                                  ? context
                                      .read<PayreceiptController>()
                                      .textError = 'Select a series'
                                  : null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              value: context
                                  .read<PayreceiptController>()
                                  .custseriesNo,
                              items: context
                                  .read<PayreceiptController>()
                                  .seriesData
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: "${e.Series}",
                                    child: Container(
                                        child: Text(e.SeriesName.toString())));
                              }).toList(),
                              hint: const Text(
                                "Select series",
                              ),
                              onChanged: (value) {
                                setState(
                                  () {
                                    context
                                        .read<PayreceiptController>()
                                        .custseriesNo = value!;
                                    // context.read<PayreceiptController>().mapcustseriesNo = context.read<PayreceiptController>().custseriesNo;

                                    context
                                        .read<PayreceiptController>()
                                        .custCodeReadOnly();

                                    print(
                                        "sleect code: ${context.read<PayreceiptController>().custseriesNo}");
                                  },
                                );
                              }),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            readOnly: context
                                .watch<PayreceiptController>()
                                .seriesValuebool,
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[3],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     context.read<PayreceiptController>().textError =
                            //         "Please Enter the Customer Code";

                            //     return "Please Enter the Customer Code";
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            decoration: InputDecoration(
                              labelText: 'Customer Code',
                              filled: false,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          // height: custHeight * 0.15,
                          // width: custWidth * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[4],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Mobile Number";

                                return "Please Enter the Mobile Number";
                              } else if (value.length < 10) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the 10 Digit Mobile Number";

                                return "Please Enter the 10 Digit Mobile Number";
                              } else {
                                return null;
                              }
                            },
                            maxLength: 10,
                            decoration: InputDecoration(
                              counterText: '',
                              labelText: 'Mobile Number',
                              filled: false,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          // width: custWidth * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            // autofocus: true,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[5],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},

                            decoration: InputDecoration(
                              labelText: "Gst",
                              filled: false,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.09,
                        ),
                        Container(
                          // height: custHeight * 0.15,
                          // width: custWidth * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[6],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Name";

                                return "Please Enter the Name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Name",
                              filled: false,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 10.0),
                          child: DropdownButtonFormField<String>(
                              validator: (value) => value == null
                                  ? context
                                      .read<PayreceiptController>()
                                      .textError = 'Selecta  Group'
                                  : null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              icon: Icon(Icons.arrow_drop_down),
                              value: context
                                  .read<PayreceiptController>()
                                  .codeValue,
                              items: context
                                  .watch<PayreceiptController>()
                                  .groupcData
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: "${e.GroupCode}",
                                    child: Container(
                                        child: Text(e.GroupName.toString())));
                              }).toList(),
                              hint: Text("Select Group",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.black54)),
                              onChanged: (String? value) {
                                setState(() {
                                  context
                                      .read<PayreceiptController>()
                                      .codeValue = value!;
                                  print("codeValue: " +
                                      context
                                          .read<PayreceiptController>()
                                          .codeValue
                                          .toString());
                                });
                              }),
                        ),

                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        //addreswidget
                        AddressWidget(
                          theme: theme,
                          custHeight: widget.custHeight,
                          custWidth: widget.custWidth,
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          // height: custHeight * 0.15,
                          // width: custWidth * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[46],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Tin";

                                return "Please Enter the Tin";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Tin",
                              filled: false,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red),
                              ),
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
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.03,
                        ),
                        Container(
                          // height: custHeight * 0.15,
                          // width: custWidth * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[47],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Vat";

                                return "Please Enter the Vat";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Vat",
                              filled: false,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red),
                              ),
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
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        SizedBox(
                          width: widget.custWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.custWidth * 0.35,
                                    child: Text("Select Tin File"),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            context
                                                .read<PayreceiptController>()
                                                .selectattachment();
                                            context
                                                .read<PayreceiptController>()
                                                .fileValidation = false;
                                          });
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                              top: widget.custHeight * 0.01,
                                              left: widget.custWidth * 0.02,
                                              right: widget.custWidth * 0.01,
                                              bottom: widget.custHeight * 0.01,
                                            ),
                                            color: Colors.white,
                                            width: widget.custWidth * 0.2,
                                            child: Icon(Icons.photo)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              context
                                      .watch<PayreceiptController>()
                                      .tinfileError
                                      .isEmpty
                                  ? Container()
                                  : Text(
                                      context
                                          .watch<PayreceiptController>()
                                          .tinfileError,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.red)),
                            ],
                          ),
                        ),
                        context.read<PayreceiptController>().tinFiles == null
                            ? SizedBox()
                            : ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int i) {
                                  if (context
                                      .read<PayreceiptController>()
                                      .tinFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("png")) {
                                    return Container(
                                        child: Column(children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    // color: Colors.green,
                                                    ),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/img.jpg"))),
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                // height: Screens.padingHeight(context) * 0.06,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .tinFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                  // overflow: TextOverflow.ellipsis,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .tinFiles = null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ])
                                        // )
                                        );
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .tinFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("jp")) {
                                    return Container(
                                        child: Column(children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    // color: Colors.green,
                                                    ),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/img.jpg"))),
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                // height: Screens.padingHeight(context) * 0.06,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .tinFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .tinFiles = null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ])
                                        // )
                                        );
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .tinFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("pdf")) {
                                    return Container(
                                        child: Column(children: [
                                      SizedBox(
                                        height: widget.custHeight * 0.01,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(),
                                              width: widget.custWidth * 0.1,
                                              height: widget.custHeight * 0.13,
                                              child: Center(
                                                  child: Image.asset(
                                                      "assets/PDFimg.png")),
                                            ),
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                // height: Screens.padingHeight(context) * 0.06,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .tinFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .tinFiles = null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]));
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .tinFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("xlsx")) {
                                    return Container(
                                        child: Column(children: [
                                      SizedBox(
                                        height: widget.custHeight * 0.01,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/xls.png"))),
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                // height: Screens.padingHeight(context) * 0.06,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .tinFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .tinFiles = null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ])
                                        // )
                                        );
                                  }
                                  return Container(
                                      child: Column(children: [
                                    SizedBox(
                                      height: widget.custHeight * 0.01,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(),
                                              width: widget.custWidth * 0.09,
                                              height: widget.custHeight * 0.06,
                                              child: Center(
                                                  child: Image.asset(
                                                      "assets/txt.png"))),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(),
                                              width: widget.custWidth * 0.6,
                                              // height: Screens.padingHeight(context) * 0.06,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                context
                                                    .read<
                                                        PayreceiptController>()
                                                    .tinFiles!
                                                    .path
                                                    .split('/')
                                                    .last,
                                              )),
                                          Container(
                                              alignment: Alignment.center,
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              PayreceiptController>()
                                                          .tinFiles = null;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.grey,
                                                  )))
                                        ])
                                  ]));
                                }),

                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),

                        SizedBox(
                          width: widget.custWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.custWidth * 0.3,
                                    child: Text("Select Vat File"),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            context
                                                .read<PayreceiptController>()
                                                .selectVatattachment();
                                            context
                                                .read<PayreceiptController>()
                                                .fileValidation = false;
                                          });
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                              top: widget.custHeight * 0.01,
                                              left: widget.custWidth * 0.02,
                                              right: widget.custWidth * 0.01,
                                              bottom: widget.custHeight * 0.01,
                                            ),
                                            color: Colors.white,
                                            width: widget.custWidth * 0.2,
                                            child: Icon(Icons.photo)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              context
                                      .watch<PayreceiptController>()
                                      .vatfileError
                                      .isEmpty
                                  ? Container()
                                  : Text(
                                      context
                                          .watch<PayreceiptController>()
                                          .vatfileError,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.red)),
                            ],
                          ),
                        ),
                        context.read<PayreceiptController>().vatFiles == null
                            ? SizedBox()
                            : ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int i) {
                                  if (context
                                      .read<PayreceiptController>()
                                      .vatFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("png")) {
                                    return Container(
                                        child: Column(children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/img.jpg"))),
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                // height: Screens.padingHeight(context) * 0.06,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .vatFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                  // overflow: TextOverflow.ellipsis,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .vatFiles = null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ])
                                        // )
                                        );
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .vatFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("jp")) {
                                    return Container(
                                        child: Column(children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/img.jpg"))),
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                // height: Screens.padingHeight(context) * 0.06,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .vatFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .vatFiles = null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ])
                                        // )
                                        );
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .vatFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("pdf")) {
                                    return Container(
                                        child: Column(children: [
                                      SizedBox(
                                        height: widget.custHeight * 0.01,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(),
                                              width: widget.custWidth * 0.1,
                                              height: widget.custHeight * 0.13,
                                              child: Center(
                                                  child: Image.asset(
                                                      "assets/PDFimg.png")),
                                            ),
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                // height: Screens.padingHeight(context) * 0.06,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .vatFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .vatFiles = null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ]));
                                  } else if (context
                                      .read<PayreceiptController>()
                                      .vatFiles!
                                      .path
                                      .split('/')
                                      .last
                                      .contains("xlsx")) {
                                    return Container(
                                        child: Column(children: [
                                      SizedBox(
                                        height: widget.custHeight * 0.01,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.1,
                                                height:
                                                    widget.custHeight * 0.13,
                                                child: Center(
                                                    child: Image.asset(
                                                        "assets/xls.png"))),
                                            Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(),
                                                width: widget.custWidth * 0.6,
                                                // height: Screens.padingHeight(context) * 0.06,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  context
                                                      .read<
                                                          PayreceiptController>()
                                                      .vatFiles!
                                                      .path
                                                      .split('/')
                                                      .last,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                PayreceiptController>()
                                                            .vatFiles = null;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.grey,
                                                    )))
                                          ])
                                    ])
                                        // )
                                        );
                                  }
                                  return Container(
                                      child: Column(children: [
                                    SizedBox(
                                      height: widget.custHeight * 0.01,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(),
                                              width: widget.custWidth * 0.09,
                                              height: widget.custHeight * 0.06,
                                              child: Center(
                                                  child: Image.asset(
                                                      "assets/txt.png"))),
                                          Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(),
                                              width: widget.custWidth * 0.6,
                                              // height: Screens.padingHeight(context) * 0.06,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                context
                                                    .read<
                                                        PayreceiptController>()
                                                    .vatFiles!
                                                    .path
                                                    .split('/')
                                                    .last,
                                              )),
                                          Container(
                                              alignment: Alignment.center,
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              PayreceiptController>()
                                                          .vatFiles = null;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.grey,
                                                  )))
                                        ])
                                  ]));
                                }),

                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 10.0),
                          child: DropdownButtonFormField<String>(
                              validator: (value) => value == null
                                  ? context
                                      .read<PayreceiptController>()
                                      .textError = 'Select a Territory'
                                  : null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              icon: Icon(Icons.arrow_drop_down),
                              value: context
                                  .read<PayreceiptController>()
                                  .teriteriValue,
                              items: context
                                  .watch<PayreceiptController>()
                                  .teriteritData
                                  .map((e) {
                                return DropdownMenuItem(
                                    value: "${e.teriID}",
                                    child: Container(
                                        child: Text(e.descript.toString())));
                              }).toList(),
                              hint: Text("Select Territory",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.black54)),
                              onChanged: (String? value) {
                                setState(() {
                                  context
                                      .read<PayreceiptController>()
                                      .teriteriValue = value!;
                                  print("teriteriValue: " +
                                      context
                                          .read<PayreceiptController>()
                                          .teriteriValue
                                          .toString());
                                });
                              }),
                        ),

                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          // height: custHeight * 0.15,
                          // width: custWidth * 0.65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            // textCapitalization: TextCapitalization.sentences,
                            readOnly: true,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[48],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Sales Person Code";
                                return "Please Enter the Sales Person Code";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Sales Person Code",
                              filled: false,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red),
                              ),
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
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          // height: custHeight * 0.15,
                          // width: custWidth * 0.65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[51],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Contact Person";
                                return "Please Enter the Contact Person";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Contact Person",
                              filled: false,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red),
                              ),
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
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          // height: custHeight * 0.15,
                          // width: custWidth * 0.65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            // textCapitalization: TextCapitalization.sentences,

                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[21],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.black),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                //   context.read<PayreceiptController>().textError =
                                //       "Please Enter the Email Address";

                                //   return "Please Enter the Email Address";
                                // } else
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  context
                                          .read<PayreceiptController>()
                                          .textError =
                                      "Please Enter the Valid Email";

                                  return "Please Enter the Valid Email";
                                }
                              } else {
                                return null;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Email",
                              filled: false,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 10.0),
                          child: DropdownButtonFormField<String>(
                              validator: (value) => value == null
                                  ? context
                                      .read<PayreceiptController>()
                                      .textError = 'Payment a Terms'
                                  : null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              icon: Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              value: context
                                  .watch<PayreceiptController>()
                                  .paygrpValue,
                              items: context
                                  .watch<PayreceiptController>()
                                  .paygroupData!
                                  .map((e) {
                                return DropdownMenuItem(
                                    // ignore: unnecessary_brace_in_string_interps
                                    value: "${e.GroupNum}",
                                    child: Container(
                                        // height: Screens.bodyheight(context)*0.1,
                                        child: Text(e.PymntGroup.toString())));
                              }).toList(),
                              hint: Text("Payment Terms",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.black54)),
                              onChanged: (String? value) {
                                setState(() {
                                  context
                                      .read<PayreceiptController>()
                                      .paygrpValue = value!;
                                  print("paygrpValue: " +
                                      context
                                          .read<PayreceiptController>()
                                          .paygrpValue
                                          .toString());
                                });
                              }),
                        ),

                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            // color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[49],
                            // maxLines: 4,
                            validator: (value) {
                              if (value!.isEmpty) {
                                context.read<PayreceiptController>().textError =
                                    "Please Enter the Credit Limit";

                                return "Please Enter the Credit Limit";
                              } else {
                                return null;
                              }
                            },
                            onTap: () {
                              context
                                      .read<PayreceiptController>()
                                      .mycontroller[49]
                                      .text =
                                  context
                                      .read<PayreceiptController>()
                                      .mycontroller[49]
                                      .text
                                      .replaceAll(',', '');
                            },
                            onEditingComplete: () {
                              context
                                      .read<PayreceiptController>()
                                      .mycontroller[49]
                                      .text =
                                  context
                                      .read<PayreceiptController>()
                                      .config
                                      .splitValues(context
                                          .read<PayreceiptController>()
                                          .mycontroller[49]
                                          .text);
                              context
                                  .read<PayreceiptController>()
                                  .disableKeyBoard(context);
                            },

                            decoration: InputDecoration(
                                hintText: 'Credit Limit',
                                // filled: true,
                                // fillColor: theme.primaryColor.withOpacity(0.15),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.2, horizontal: 10),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          height: widget.custHeight * 0.02,
                        ),
                        Container(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            onTap: () {
                              context
                                      .read<PayreceiptController>()
                                      .mycontroller[49]
                                      .text =
                                  context
                                      .read<PayreceiptController>()
                                      .config
                                      .splitValues(context
                                          .read<PayreceiptController>()
                                          .mycontroller[49]
                                          .text);
                            },
                            controller: context
                                .read<PayreceiptController>()
                                .mycontroller[50],
                            maxLines: 4,
                            decoration: InputDecoration(
                                hintText: 'Remarks',
                                // filled: true,
                                // fillColor: theme.primaryColor.withOpacity(0.15),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.2, horizontal: 10),
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: widget.custHeight * 0.02,
          ),
          Container(
            height: widget.custHeight * 0.2,
            width: widget.custWidth * 1.1,
            child: ElevatedButton(
                onPressed:
                    context.read<PayreceiptController>().loadingBtn == false
                        ? () {
                            setState(() {
                              context
                                  .read<PayreceiptController>()
                                  .createnewchagescustaddres(context, theme, 6);
                            });
                          }
                        : null,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    backgroundColor: theme.primaryColor),
                child: context.read<PayreceiptController>().loadingBtn == false
                    ? Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    : SizedBox(
                        width: widget.custWidth * 0.05,
                        height: widget.custHeight * 0.15,
                        child: CircularProgressIndicator(),
                      )),
          )
        ],
      );
    });
  }

  forEditBtn(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: widget.custHeight * 0.1,
            left: widget.custHeight * 0.1,
            right: widget.custHeight * 0.1,
            bottom: widget.custHeight * 0.02),
        width: widget.custWidth * 1.1,
        height: widget.custHeight * 2.5,
        // color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: context.read<PayreceiptController>().formkey[6],
                child: Column(
                  children: [
                    SizedBox(
                      height: widget.custHeight * 0.03,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.grey),
                    //     borderRadius: BorderRadius.circular(3),
                    //     color: Colors.grey.withOpacity(0.01),
                    //   ),
                    //   alignment: Alignment.topCenter,
                    //   padding:
                    //       EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
                    //   child: DropdownButtonFormField<String>(
                    //       validator: (value) =>
                    //           value == null ? 'Select the series' : null,
                    //       decoration: InputDecoration(
                    //         border: InputBorder.none,
                    //         focusedBorder: InputBorder.none,
                    //         enabledBorder: InputBorder.none,
                    //         errorBorder: InputBorder.none,
                    //         disabledBorder: InputBorder.none,
                    //       ),
                    //       icon: Icon(Icons.arrow_drop_down),
                    //       value: context.read<PayreceiptController>().seriesValue,
                    //       items: context
                    //           .read<PayreceiptController>()
                    //           .seriesData
                    //           .map((e) {
                    //         return DropdownMenuItem(
                    //             value: "${e.Series}",
                    //             child: Container(
                    //                 child: Text(e.SeriesName.toString())));
                    //       }).toList(),
                    //       hint: Text(
                    //         "Select series",
                    //       ),
                    //       onChanged: (value) {
                    //         setState(
                    //           () {
                    //             context.read<PayreceiptController>().custseriesNo=
                    //                 value!;
                    //             log('seriesValueAA ${context.read<PayreceiptController>().seriesValue}');
                    //             if (context
                    //                     .read<PayreceiptController>()
                    //                     .seriesValue
                    //                     .toString()
                    //                     .toLowerCase() ==
                    //                 '218') {
                    //               context
                    //                   .read<PayreceiptController>()
                    //                   .seriesValuebool = false;

                    //               log('seriesValuebool11 ${context.read<PayreceiptController>().seriesValuebool}');
                    //             } else {
                    //               context
                    //                   .read<PayreceiptController>()
                    //                   .seriesValuebool = true;
                    //               log('seriesValuebool222 ${context.read<PayreceiptController>().seriesValuebool}');
                    //             }
                    //             print("sleect code: " +
                    //                 context
                    //                     .read<PayreceiptController>()
                    //                     .seriesValue
                    //                     .toString());
                    //           },
                    //         );
                    //       }),
                    // ),
                    // SizedBox(
                    //   height: widget.custHeight * 0.03,
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(3),
                    //     color: Colors.grey.withOpacity(0.01),
                    //   ),
                    //   child: TextFormField(
                    //     readOnly:
                    //         context.read<PayreceiptController>().seriesValuebool,
                    //     textCapitalization: TextCapitalization.sentences,
                    //     controller:
                    //         context.read<PayreceiptController>().mycontroller[3],
                    //     cursorColor: Colors.grey,
                    //     style: theme.textTheme.bodyLarge
                    //         ?.copyWith(color: Colors.black),
                    //     onChanged: (v) {},
                    //     decoration: InputDecoration(
                    //       labelText: 'Customer Code',
                    //       filled: false,
                    //       errorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.red),
                    //       ),
                    //       focusedErrorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.red),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       contentPadding: const EdgeInsets.symmetric(
                    //         vertical: 5,
                    //         horizontal: 10,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: widget.custHeight * 0.03,
                    // ),
                    Container(
                      // height: custHeight * 0.15,
                      // width: custWidth * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[4],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Mobile Number";
                            return "Please Enter the Mobile Number";
                          } else if (value.length < 10) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the 10 Digit Mobile Number";

                            return "Please Enter the 10 Digit Mobile Number";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: 'Mobile Number',
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widget.custHeight * 0.03,
                    ),
                    Container(
                      // width: custWidth * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        // autofocus: true,
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[5],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},

                        decoration: InputDecoration(
                          labelText: "Gst",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widget.custHeight * 0.09,
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      // width: custWidth * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[6],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Name";

                            return "Please Enter the Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Name",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widget.custHeight * 0.02,
                    ),
                    //addreswidget
                    AddressWidget(
                      theme: theme,
                      custHeight: widget.custHeight,
                      custWidth: widget.custWidth,
                    ),

                    SizedBox(
                      height: widget.custHeight * 0.02,
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      // width: custWidth * 0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        // textCapitalization: TextCapitalization.sentences,

                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[21],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            //   // context.read<PayreceiptController>().textError =
                            //   //     "Please Enter the Email Address";
                            //   return "Please Enter the Email Address";
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              context.read<PayreceiptController>().textError =
                                  "Please Enter the Valid Email";
                              return "Please Enter the Valid Email";
                            }
                          } else {
                            return null;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  List<Widget> listContainersProduct(
    BuildContext context,
    ThemeData theme,
  ) {
    return List.generate(
      context.read<PayreceiptController>().custList2.length,
      (ind) {
        print('custList2::{custList2.lenght}');
        return TopCustomer(ind: ind, theme: theme);
      },
    );
  }
}

class TopCustomer extends StatelessWidget {
  TopCustomer({
    Key? key,
    required this.ind,
    required this.theme,
  }) : super(key: key);
  ThemeData theme;
  int ind;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Datatatat: ");
        // print(posC.custList[ind].name);
        context.read<PayreceiptController>().custSelected(
            context.read<PayreceiptController>().custList2[ind],
            context,
            theme);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: theme.primaryColor,
            border: Border.all(color: theme.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Text(context.watch<PayreceiptController>().custList2[ind].name!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.white,
            )),
      ),
    );
  }
}

Widget updateType(BuildContext context, int i, int ij) {
  final theme = Theme.of(context);
  return SizedBox(
    width: Screens.width(context) * 0.8,
    //  height: Screens.padingHeight(context) * 0.4,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          height: Screens.padingHeight(context) * 0.05,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(5), topRight: Radius.circular(5))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.red,
                width: Screens.width(context) * 0.4,
                alignment: Alignment.center,
                child: Text(
                  "Confrim update",
                  textAlign: TextAlign.center,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: Screens.padingHeight(context) * 0.025,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: Screens.bodyheight(context) * 0.02,
        ),
        Container(
          width: Screens.width(context) * 0.8,
          padding: EdgeInsets.symmetric(
            vertical: Screens.padingHeight(context) * 0.01,
            horizontal: Screens.width(context) * 0.01,
          ),
          child: Column(
            children: [
              Container(
                child: const Text(
                    "Do you want to update this customer for this sale or update to server..!!"),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Screens.width(context) * 0.3,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context
                              .read<PayreceiptController>()
                              .updateCustomer(context, i, ij);
                          Navigator.pop(context);
                        },
                        child: const Text("Update to server")),
                  ),
                  SizedBox(
                      width: Screens.width(context) * 0.3,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context
                                .read<PayreceiptController>()
                                .updateCustomer(context, i, ij);
                            Navigator.pop(context);
                          },
                          child: const Text("This sale"))),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

billAddress(BuildContext context) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Address',
              widget: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Screens.padingHeight(context) * 0.01,
                  horizontal: Screens.width(context) * 0.01,
                ),
                child: Column(
                  children: [
                    Container(
                      height: Screens.padingHeight(context) * 0.3,
                      width: Screens.width(context) * 0.45,
                      padding: EdgeInsets.symmetric(
                        vertical: Screens.padingHeight(context) * 0.01,
                        horizontal: Screens.width(context) * 0.01,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: context
                            .watch<PayreceiptController>()
                            .
                            // .getselectedcust!
                            // .address!
                            billadrrssItemlist
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              context
                                  .read<PayreceiptController>()
                                  .changeBillAddress(index);
                              Navigator.pop(context);
                            },
                            child: Card(
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                          Screens.padingHeight(context) * 0.01,
                                      horizontal: Screens.width(context) * 0.01,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //             ListTile(
                                        //   title: Text( pos.getselectedcust!.address[index].billAddress,
                                        //       style: theme.textTheme.bodySmall),
                                        //   onTap: () {
                                        //     pos.changeBillAddress(index);
                                        //     //pos.getselectedcust!.address[pos.selectedAdress].billAddress = pos.getselectedcust!.address[index].billAddress;
                                        //     Navigator.pop(context);
                                        //   },
                                        // ),
                                        Container(
                                          child: Text(
                                              "${context.watch<PayreceiptController>().billadrrssItemlist[index].address1 ?? ''},"
                                              "${context.watch<PayreceiptController>().billadrrssItemlist[index].address2 ?? ''},"
                                              "${context.watch<PayreceiptController>().billadrrssItemlist[index].address3 ?? ''}"),
                                        ),
                                        Container(
                                          child: Text(context
                                              .watch<PayreceiptController>()
                                              .billadrrssItemlist[index]
                                              .billCity),
                                        ),
                                        Container(
                                          child: Text(context
                                              .watch<PayreceiptController>()
                                              .billadrrssItemlist[index]
                                              .billPincode),
                                        ),
                                        Container(
                                          child: Text(context
                                              .watch<PayreceiptController>()
                                              .billadrrssItemlist[index]
                                              .billstate),
                                        )
                                      ],
                                    ))),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              buttonName: "Create Address",
              callback: () {
                Navigator.pop(context);
                context.read<PayreceiptController>().clearTextField();
                context.read<PayreceiptController>().checkboxx = false;

                createBillAddress(context, theme);
              },
            ));
      });
}

sipaddress(BuildContext context) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Address',
              widget: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Screens.padingHeight(context) * 0.01,
                  horizontal: Screens.width(context) * 0.01,
                ),
                height: Screens.padingHeight(context) * 0.3,
                width: Screens.width(context) * 0.45,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: context
                      .watch<PayreceiptController>()
                      .shipadrrssItemlist
                      .length,
                  // getselectedcust!.address!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        context
                            .read<PayreceiptController>()
                            .changeShipAddress(index);
                        Navigator.pop(context);
                      },
                      child: Card(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Screens.padingHeight(context) * 0.01,
                                horizontal: Screens.width(context) * 0.01,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                        "${context.watch<PayreceiptController>().shipadrrssItemlist[index].address1 ?? ''}${context.watch<PayreceiptController>().shipadrrssItemlist[index].address2 ?? ''}${context.watch<PayreceiptController>().shipadrrssItemlist[index].address3 ?? ''}"),
                                  ),
                                  Container(
                                    child: Text(context
                                            .watch<PayreceiptController>()
                                            .shipadrrssItemlist[index]
                                            .billCity
                                            .isNotEmpty
                                        ? context
                                            .watch<PayreceiptController>()
                                            .shipadrrssItemlist[index]
                                            .billCity
                                        : ''),
                                  ),
                                  Container(
                                    child: Text(context
                                                .read<PayreceiptController>()
                                                .shipadrrssItemlist[index]
                                                .billPincode !=
                                            null
                                        ? context
                                            .watch<PayreceiptController>()
                                            .shipadrrssItemlist[index]
                                            .billPincode
                                        : ""),
                                  ),
                                  Container(
                                    child: Text(context
                                        .watch<PayreceiptController>()
                                        .shipadrrssItemlist[index]
                                        .billstate),
                                  )
                                  //             ListTile(
                                  //   title: Text(pos.getselectedcust!.address[index].shipAddress,
                                  //       style: theme.textTheme.bodySmall),
                                  //   onTap: () {
                                  //     pos.changeShipAddress(index);
                                  //     // pos.getselectedcust!.address[0].shipAddress =
                                  //     //     pos.getselectedcust!.address[index].shipAddress;
                                  //     Navigator.pop(context);
                                  //   },
                                  // ),
                                  // Container(
                                  //   child: Text(
                                  //       "${pos.getselectedcust!.address![index].shipAddress}"),
                                  // ),
                                  // Container(
                                  //   child: Text(
                                  //       "${pos.getselectedcust!.address![index].shipCity}"),
                                  // ),
                                  // Container(
                                  //   child: Text(
                                  //       "${pos.getselectedcust!.address![index].shipPincode}"),
                                  // ),
                                  // Container(
                                  //   child: Text(
                                  //       "${pos.getselectedcust!.address![index].shipstate}"),
                                  // )
                                ],
                              ))),
                    );
                  },
                ),
              ),
              buttonName: "Create Address",
              callback: () {
                Navigator.pop(context);
                context.read<PayreceiptController>().clearTextField();
                context.read<PayreceiptController>().checkboxx = false;
                createShippAddress(context, theme);
                // context.read<PayreceiptController>().checkboxx = false;
                // context.read<PayreceiptController>().clearTextField();
                // createShippAddress(context, theme);
              },
            ));
      });
}

createBillAddress(BuildContext context, ThemeData theme) async {
  final theme = Theme.of(context);
  context.read<PayreceiptController>().checkboxx = false;
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Create Address',
              widget: createBillAddressMethod(theme, context),
              buttonName: null,
              // "Save",
              // callback: () {
              //   context.read<PayreceiptController>().insertnewbilladdresscreation(context, theme);
              // },
            ));
      });
}

createShippAddress(BuildContext context, ThemeData theme) async {
  final theme = Theme.of(context);
  // context.read<PayreceiptController>().checkboxx = false;
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Create Address',
              widget: createShipAddressMethod(theme, context),
              buttonName: null,
              // callback: () async {
              //   await context.read<PayreceiptController>().insertnewshipaddresscreation(context, theme);
              // },
            ));
      });
}

Container createAddressMethod(ThemeData theme, BuildContext context) {
  context.read<PayreceiptController>().checkboxx = false;
  return Container(
    width: Screens.width(context) * 0.5,
    height: Screens.padingHeight(context) * 0.65,
    padding: EdgeInsets.symmetric(
      horizontal: Screens.width(context) * 0.02,
      vertical: Screens.padingHeight(context) * 0.02,
    ),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AddressWidget(
            theme: theme,
            custHeight: Screens.width(context) * 0.4,
            custWidth: Screens.width(context) * 0.7,
          ),
        ],
      ),
    ),
  );
}

Container createBillAddressMethod(ThemeData theme, BuildContext context) {
  // context.read<PayreceiptController>().checkboxx = false;
  return Container(
    child: Column(
      children: [
        Container(
          width: Screens.width(context) * 0.5,
          height: Screens.padingHeight(context) * 0.51,
          padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.02,
            vertical: Screens.padingHeight(context) * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BillAddressWidget(
                  theme: theme,
                  custHeight: Screens.width(context) * 0.4,
                  custWidth: Screens.width(context) * 0.7,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Screens.padingHeight(context) * 0.055,
          width: Screens.width(context) * 0.499,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  side: BorderSide(
                    // width: 5.0,
                    color: theme.primaryColor,
                  )),
              onPressed:
                  context.watch<PayreceiptController>().adOndDisablebutton ==
                          false
                      ? () {
                          context
                              .read<PayreceiptController>()
                              .insertnewbilladdresscreation(context, theme);
                        }
                      : null,
              child: Text(
                "Save",
                style:
                    theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
              )),
        ),
      ],
    ),
  );
}

Container createShipAddressMethod(ThemeData theme, BuildContext context) {
  // context.read<PayreceiptController>().checkboxx = false;
  return Container(
    child: Column(
      children: [
        Container(
          width: Screens.width(context) * 0.5,
          height: Screens.padingHeight(context) * 0.51,
          padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.02,
            vertical: Screens.padingHeight(context) * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShipAddressWidget(
                  theme: theme,
                  custHeight: Screens.width(context) * 0.4,
                  custWidth: Screens.width(context) * 0.7,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Screens.padingHeight(context) * 0.055,
          width: Screens.width(context) * 0.499,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  side: BorderSide(
                    // width: 5.0,
                    color: theme.primaryColor,
                  )),
              onPressed:
                  context.watch<PayreceiptController>().adOndDisablebutton ==
                          false
                      ? () {
                          context
                              .read<PayreceiptController>()
                              .insertnewshipaddresscreation(context, theme);
                        }
                      : null,
              child: Text(
                "Save",
                style:
                    theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
              )),
        ),
      ],
    ),
  );
}

class AddressWidget extends StatelessWidget {
  const AddressWidget(
      {Key? key,
      required this.theme,
      required this.custHeight,
      required this.custWidth})
      : super(key: key);

  final ThemeData theme;
  final double custHeight;
  final double custWidth;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Column(
        children: [
          SizedBox(
            height: custHeight * 0.02,
          ),
          Form(
            key: context.read<PayreceiptController>().formkeyAd,
            child: Column(
              children: [
                Container(
                  // height: custHeight * 0.15,
                  // width: custWidth * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    controller:
                        context.read<PayreceiptController>().mycontroller[7],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address1";

                        return "Please Enter the Address1";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Bill Address1",
                      filled: false,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Container(
                  // height: custHeight * 0.15,
                  // width: custWidth * 0.75,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller:
                        context.read<PayreceiptController>().mycontroller[8],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address2";
                        return "Please Enter the Address2";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Bill Address2",
                      filled: false,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Container(
                  // height: custHeight * 0.15,
                  // width: custWidth * 0.75,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    controller:
                        context.read<PayreceiptController>().mycontroller[9],
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address3";
                        return "Please Enter the Address3";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Bill Address3",
                      filled: false,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[10],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the City Name";

                            return "Please Enter the City Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "City",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[11],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Pin Code";

                            return "Please Enter the Pin Code";
                          } else if (value.length < 6) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter 6 Digit Pin Code";

                            return "Please Enter 6 Digit Pin Code";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: "Pin Code",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[12],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the State";

                            return "Please Enter the State";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "State",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        // readOnly: true,
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[13],
                        textCapitalization: TextCapitalization.sentences,

                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Country";

                            return "Please Enter the Country";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Country",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: custHeight * 0.1,
                      child: const Text("Copy As Ship Address"),
                    ),
                    SizedBox(
                      width: custWidth * 0.2,
                    ),
                    Checkbox(
                        side: const BorderSide(color: Colors.grey),
                        activeColor: Colors.green,
                        value: context.watch<PayreceiptController>().checkboxx,
                        onChanged: (val) {
                          st(() {
                            context.read<PayreceiptController>().checkboxx =
                                val!;
                            context
                                .read<PayreceiptController>()
                                .billToShip(val);
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // height: custHeight * 0.15,
                        // width: custWidth * 0.65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.grey.withOpacity(0.01),
                        ),
                        child: TextFormField(
                          // autofocus: true,
                          controller: context
                              .read<PayreceiptController>()
                              .mycontroller[14],
                          textCapitalization: TextCapitalization.sentences,

                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PayreceiptController>().textError =
                                  "Please Enter the Ship_Address1";

                              return "Please Enter the Ship Address1";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Ship Address1',
                            filled: false,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: custHeight * 0.02,
                      ),
                      Container(
                        // height: custHeight * 0.15,
                        // width: custWidth * 0.65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.grey.withOpacity(0.01),
                        ),
                        child: TextFormField(
                          autofocus: true,
                          controller: context
                              .read<PayreceiptController>()
                              .mycontroller[15],
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PayreceiptController>().textError =
                                  "Please Enter the Ship_Address2";
                              return "Please Enter the Ship Address2";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Ship Address2',
                            filled: false,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: custHeight * 0.02,
                      ),
                      Container(
                        // height: custHeight * 0.15,
                        // width: custWidth * 0.65,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 240, 235, 235)),
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.grey.withOpacity(0.01),
                        ),
                        child: TextFormField(
                          autofocus: true,
                          controller: context
                              .read<PayreceiptController>()
                              .mycontroller[16],
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PayreceiptController>().textError =
                                  "Please Enter the Ship_Address3";
                              return "Please Enter the Ship Address3";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Ship Address3",
                            filled: false,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[17],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_City Name";

                            return "Please Enter the City Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "City",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[18],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_PinCode";

                            return "Please Enter the Pin Code";
                          } else if (value.length < 6) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter 6 Digit Ship_PinCode";

                            return "Please Enter 6 Digit Pin Code";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: "Pin Code",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[19],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_State";

                            return "Please Enter the State";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "State",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        // readOnly: true,
                        textCapitalization: TextCapitalization.sentences,

                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[20],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Ship_Country";

                            return "Please Enter the Country";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Country",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class BillAddressWidget extends StatelessWidget {
  const BillAddressWidget(
      {Key? key,
      required this.theme,
      required this.custHeight,
      required this.custWidth})
      : super(key: key);

  final ThemeData theme;
  final double custHeight;
  final double custWidth;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Column(
        children: [
          SizedBox(
            height: custHeight * 0.02,
          ),
          Form(
            key: context.read<PayreceiptController>().formkeyAd,
            child: Column(
              children: [
                Container(
                  // height: custHeight * 0.15,
                  // width: custWidth * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    controller:
                        context.read<PayreceiptController>().mycontroller[7],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address1";
                        return "Please Enter the Address1";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Bill Address1",
                      filled: false,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Container(
                  // height: custHeight * 0.15,
                  // width: custWidth * 0.75,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller:
                        context.read<PayreceiptController>().mycontroller[8],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address2";
                        return "Please Enter the Address2";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Bill Address2",
                      filled: false,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Container(
                  // height: custHeight * 0.15,
                  // width: custWidth * 0.75,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller:
                        context.read<PayreceiptController>().mycontroller[9],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PayreceiptController>().textError =
                            "Please Enter the Address3";
                        return "Please Enter the Address3";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Bill Address3",
                      filled: false,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[10],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the City Name";
                            return "Please Enter the City Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "City",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[11],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the PinCode";
                            return "Please Enter the PinCode";
                          } else if (value.length < 6) {
                            context.read<PayreceiptController>().textError =
                                " Please Enter 6 Digit Pin Code";
                            return "Please Enter 6 Digit Pin Code";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: "Pin Code",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[12],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the State";
                            return "Please Enter the State";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "State",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        // readOnly: true,
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[13],
                        textCapitalization: TextCapitalization.sentences,

                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Country";
                            return "Please Enter the Country";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Country",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: custHeight * 0.1,
                      child: const Text("Copy As Ship Address"),
                    ),
                    SizedBox(
                      width: custWidth * 0.1,
                    ),
                    Checkbox(
                        side: const BorderSide(color: Colors.grey),
                        activeColor: Colors.green,
                        value: context.watch<PayreceiptController>().checkboxx,
                        onChanged: (val) {
                          st(() {
                            context.read<PayreceiptController>().checkboxx =
                                val!;
                            context
                                .read<PayreceiptController>()
                                .billToShip(val);
                          });
                        }),
                  ],
                ),
                // SizedBox(
                //   height: custHeight * 0.02,
                // ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class ShipAddressWidget extends StatelessWidget {
  const ShipAddressWidget(
      {Key? key,
      required this.theme,
      required this.custHeight,
      required this.custWidth})
      : super(key: key);

  final ThemeData theme;
  final double custHeight;
  final double custWidth;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Column(
        children: [
          SizedBox(
            height: custHeight * 0.02,
          ),
          Form(
            key: context.read<PayreceiptController>().formkeyShipAd,
            child: Column(
              children: [
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // height: custHeight * 0.15,
                        // width: custWidth * 0.65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.grey.withOpacity(0.01),
                        ),
                        child: TextFormField(
                          autofocus: true,
                          controller: context
                              .read<PayreceiptController>()
                              .mycontroller[14],
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PayreceiptController>().textError =
                                  "Please Enter the Ship_Address1";

                              return "Please Enter the Ship Address1";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Ship Address1',
                            filled: false,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: custHeight * 0.02,
                      ),
                      Container(
                        // height: custHeight * 0.15,
                        // width: custWidth * 0.65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.grey.withOpacity(0.01),
                        ),
                        child: TextFormField(
                          controller: context
                              .read<PayreceiptController>()
                              .mycontroller[15],
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PayreceiptController>().textError =
                                  "Please Enter the Ship_Address2";

                              return "Please Enter the Ship Address2";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Ship Address2',
                            filled: false,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: custHeight * 0.02,
                      ),
                      Container(
                        // height: custHeight * 0.15,
                        // width: custWidth * 0.65,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 240, 235, 235)),
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.grey.withOpacity(0.01),
                        ),
                        child: TextFormField(
                          autofocus: true,
                          controller: context
                              .read<PayreceiptController>()
                              .mycontroller[16],
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PayreceiptController>().textError =
                                  "Please Enter the Ship_Address3";

                              return "Please Enter the Ship Address3";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Ship Address3",
                            filled: false,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[17],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the City Name";

                            return "Please Enter the City Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "City",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[18],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Pin Code";
                            return "Please Enter the Pin Code";
                          } else if (value.length < 6) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter 6 Digit Pin Code";
                            return "Please Enter 6 Digit Pin Code";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: '',
                          labelText: "Pin Code",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[19],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the State";
                            return "Please Enter the State";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "State",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: custHeight * 0.15,
                      width: custWidth * 0.32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        // readOnly: true,
                        controller: context
                            .read<PayreceiptController>()
                            .mycontroller[20],
                        textCapitalization: TextCapitalization.sentences,

                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PayreceiptController>().textError =
                                "Please Enter the Country";
                            return "Please Enter the Country";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Country",
                          filled: false,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: custHeight * 0.1,
                      child: const Text("Copy As Bill Address"),
                    ),
                    SizedBox(
                      width: custWidth * 0.1,
                    ),
                    Checkbox(
                        side: const BorderSide(color: Colors.grey),
                        activeColor: Colors.green,
                        value: context.watch<PayreceiptController>().checkboxx,
                        onChanged: (val) {
                          st(() {
                            context.read<PayreceiptController>().checkboxx =
                                val!;
                            context
                                .read<PayreceiptController>()
                                .shipToBill(val);
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
