// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:provider/provider.dart';
import '../../../Controller/SalesInvoice/SalesInvoiceController.dart';
import '../../../Widgets/AlertBox.dart';
import '../../SalesOrder/Widgets/Dialog Box/AlertBox.dart';

class CustomerDetails extends StatefulWidget {
  CustomerDetails(
      {Key? key,
      required this.theme,
      required this.custHeight,
      required this.custWidth})
      : super(key: key);

  final ThemeData theme;
  double custHeight;
  double custWidth;

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
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
          bottom: widget.custHeight * 0.02,
          left: widget.custHeight * 0.01,
          right: widget.custHeight * 0.01),
      width: widget.custWidth,
      //height: custHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.read<PosController>().selectedcust2 != null
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
                    // controller: context.read<PosController>().searchcontroller,
                    onChanged: (v) {},
                    readOnly: true,
                    onTap: () {
                      setState(
                        () {
                          context.read<PosController>().clearTextField();
                          context.read<PosController>().refreshfiltercust();
                        },
                      );
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                contentPadding: const EdgeInsets.all(0),
                                content: AlertBox(
                                  payMent: 'Select Customer',
                                  widget: forSearchBtn(context),
                                  buttonName: 'Add New',
                                  callback: () {
                                    Navigator.pop(context);

                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                payMent: 'New Customer',
                                                widget: forAddNewBtn(context),
                                                buttonName: null,
                                                // callback: () {
                                                //   setState(() {
                                                //     context
                                                //         .read<PosController>()
                                                //         .
                                                //         // .addnewCustomer(
                                                //         createnewchagescustaddres(
                                                //             context, theme, 6);
                                                //   });

                                                //   print('AddNew Customer');
                                                // },
                                              ));
                                        });
                                  },
                                ));
                          });
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                        // size: custHeight * 0.08,
                        color: Colors.grey,
                      ),
                      // suffixIcon: IconButton(
                      //   icon: Icon(
                      //     Icons.search,
                      //     // size: custHeight * 0.08,
                      //     color: Colors.grey,
                      //   ),
                      //   onPressed: () {
                      //     context.read<PosController>().clearTextField();
                      //     context.read<PosController>().refresCufstList();

                      //     showDialog(
                      //         context: context,
                      //         barrierDismissible: false,
                      //         builder: (BuildContext context) {
                      //           return AlertDialog(
                      //               contentPadding: EdgeInsets.all(0),
                      //               content: AlertBox(
                      //                 payMent: 'Select Customer',
                      //                 widget: forSearchBtn(context),
                      //                 buttonName: 'Add new',
                      //                 callback: () {
                      //                   Navigator.pop(context);

                      //                   showDialog(
                      //                       context: context,
                      //                       barrierDismissible: false,
                      //                       builder: (BuildContext context) {
                      //                         return AlertDialog(
                      //                             contentPadding:
                      //                                 EdgeInsets.all(0),
                      //                             content: AlertBox(
                      //                               payMent: 'New Customer',
                      //                               widget:
                      //                                   forAddNewBtn(context),
                      //                               buttonName: "Save",
                      //                               callback: () {
                      //                                 context
                      //                                     .read<PosController>()
                      //                                     .createnewchagescustaddres(
                      //                                         // addnewCustomer(
                      //                                         context,
                      //                                         theme,
                      //                                         6);
                      //                                 // context
                      //                                 //     .read<PosController>()
                      //                                 //     .getNewCustandadd();

                      //                                 print('AddNew Customer');
                      //                               },
                      //                             ));
                      //                       });
                      //                 },
                      //               ));
                      //         });
                      //     // context.read<PosController>().viewSalesheader();
                      //     // context.watch<PosController>(). insertSalesHeaderToDB();
                      //     // context.watch<PosController>().viewDbtable();
                      //     // context.watch<PosController>().CareateNewBillAdd();
                      //     // showDialog(
                      //     //     context: context,
                      //     //     barrierDismissible: true,
                      //     //     builder: (BuildContext context) {
                      //     //       return AlertDialog(
                      //     //           contentPadding: EdgeInsets.all(0),
                      //     //           content: AlertBox(
                      //     //             payMent: 'Select Customer',
                      //     //             widget: forSearchBtn(context, context.watch<PosController>()),
                      //     //             buttonName: 'Add new',
                      //     //             callback: () {
                      //     //               Navigator.pop(context);
                      //     //               showDialog(
                      //     //                   context: context,
                      //     //                   barrierDismissible: false,
                      //     //                   builder: (BuildContext context) {
                      //     //                     return AlertDialog(
                      //     //                         contentPadding: EdgeInsets.all(0),
                      //     //                         content: AlertBox(
                      //     //                           payMent: 'New Customer',
                      //     //                           widget:
                      //     //                               forAddNewBtn(context, context.watch<PosController>()),
                      //     //                           buttonName: "Save",
                      //     //                           callback: () {
                      //     //                             Navigator.pop(context);

                      //     //                             context.watch<PosController>().insertAddNewCusToDB(
                      //     //                                 context, 6);

                      //     //                             context.watch<PosController>().getCustDetFDB();
                      //     //                           },
                      //     //                         ));
                      //     //                   });
                      //     //             },
                      //     //           ));
                      //     //     });
                      //   },
                      //   color: theme.primaryColor,
                      // ),

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
          context.read<PosController>().getselectedcust2 != null
              ? Container(
                  color: context.read<PosController>().getselectedcust2 != null
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
                                      .watch<PosController>()
                                      .getselectedcust2!
                                      .name
                                      .toString(),
                                  maxLines: 1,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                              // InkWell(
                              //     onTap: () {
                              // context.watch<PosController>().mapUpdateCustomer(
                              //     context.watch<PosController>().getselectedCustomer);
                              // showDialog(
                              //     context: context,
                              //     barrierDismissible: false,
                              //     builder: (BuildContext context) {
                              //       return AlertDialog(
                              //           contentPadding: EdgeInsets.all(0),
                              //           content: AlertBox(
                              //             payMent: 'Update Customer',
                              //             widget: forAddNewBtn(
                              //                 context, context.watch<PosController>()),
                              //             buttonName: "Save",
                              //             callback: () {
                              //               showDialog(
                              //                   context: context,
                              //                   barrierDismissible: false,
                              //                   builder: (BuildContext
                              //                       context) {
                              //                     return AlertDialog(
                              //                       contentPadding:
                              //                           EdgeInsets.all(0),
                              //                       content:
                              //                           //     updateSaveBtn(
                              //                           //         context,
                              //                           //         context.watch<PosController>(),
                              //                           //         6)
                              //                           updateType(
                              //                               context,
                              //                               context.watch<PosController>(),
                              //                               context.watch<PosController>()
                              //                                   .getselectedBillAdress!),
                              //                     );
                              //                   });
                              //             },
                              //           ));
                              //     });
                              // },
                              // child: Container(
                              //   width: widget.custWidth * 0.06,
                              //   alignment: Alignment.center,
                              //   //     color: Colors.red,
                              //   child: Icon(Icons.edit),
                              // )),
                              // InkWell(
                              //     onTap: () {
                              //       // context.watch<PosController>().clearData();
                              //     },
                              //     child: Container(
                              //       width: widget.custWidth * 0.06,
                              //       alignment: Alignment.center,
                              //       //     color: Colors.blue,
                              //       child: Icon(Icons.close_sharp),
                              //     )),
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
                                                .read<PosController>()
                                                .getselectedcust2!
                                                .phNo!
                                                .isNotEmpty
                                            ? " ${context.watch<PosController>().getselectedcust2!.phNo}  |  "
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
                                                .read<PosController>()
                                                .getselectedcust2!
                                                .email!
                                                .isNotEmpty
                                            ? " ${context.watch<PosController>().getselectedcust2!.email}"
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
                                                .read<PosController>()
                                                .getselectedcust2!
                                                .tarNo!
                                                .isNotEmpty
                                            ? "${context.watch<PosController>().getselectedcust2!.tarNo}"
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
                                                    .read<PosController>()
                                                    .getselectedcust2!
                                                    .accBalance! !=
                                                0
                                            ? context
                                                .watch<PosController>()
                                                .config
                                                .splitValues(context
                                                    .watch<PosController>()
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
                                        "${context.watch<PosController>().getselectedcust2!.cardCode}",
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
                                                .read<PosController>()
                                                .getselectedcust2!
                                                .point!
                                                .isNotEmpty
                                            ? "${context.watch<PosController>().getselectedcust2!.point}"
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
                                                    .watch<PosController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<PosController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PosController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        " ${context.watch<PosController>().getselectedcust2!.address![0].address1!.isNotEmpty ? context.watch<PosController>().getselectedcust2!.address![0].address1.toString() : ""},"
                                        "${context.watch<PosController>().getselectedcust2!.address![0].address2!.isNotEmpty ? context.watch<PosController>().getselectedcust2!.address![0].address2.toString() : ""},"
                                        " ${context.watch<PosController>().getselectedcust2!.address![0].address3!.isNotEmpty ? context.watch<PosController>().getselectedcust2!.address![0].address3.toString() : ""}",
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                context
                                                    .watch<PosController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<PosController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PosController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .watch<PosController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billCity
                                                .isNotEmpty
                                            ? context
                                                .watch<PosController>()
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
                                                    .watch<PosController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<PosController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PosController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .watch<PosController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billPincode
                                                .isNotEmpty
                                            ? context
                                                .watch<PosController>()
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
                                                    .watch<PosController>()
                                                    .getselectedcust2 ==
                                                null &&
                                            context
                                                    .watch<PosController>()
                                                    .getselectedcust2!
                                                    .address ==
                                                null ||
                                        context
                                            .watch<PosController>()
                                            .getselectedcust2!
                                            .address!
                                            .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .watch<PosController>()
                                                .getselectedcust2!
                                                .address![0]
                                                .billstate
                                                .isNotEmpty
                                            ? context
                                                .watch<PosController>()
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
                                // context.read<PosController>().getselectedcust25 ==
                                //             null ||
                                context
                                        .watch<PosController>()
                                        .getselectedcust25!
                                        .address!
                                        .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        "${context.watch<PosController>().getselectedcust25!.address![0].address1!.isNotEmpty ? context.watch<PosController>().getselectedcust25!.address![0].address1.toString() : ""},",
                                        // "${context.read<PosController>().getselectedcust25!.address![0].address2!.isNotEmpty ? context.watch<PosController>().getselectedcust25!.address![0].address2.toString() : ""},"
                                        // "${context.read<PosController>().getselectedcust25!.address![0].address3!.isNotEmpty ? context.watch<PosController>().getselectedcust25!.address![0].address3.toString() : ""}",
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),

                                // context.read<PosController>().getselectedcust25 ==
                                //             null||
                                context
                                        .read<PosController>()
                                        .getselectedcust25!
                                        .address!
                                        .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .read<PosController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billCity
                                                .isNotEmpty
                                            ? context
                                                .watch<PosController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billCity
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                // context.read<PosController>().getselectedcust25 ==
                                //             null ||
                                context
                                        .read<PosController>()
                                        .getselectedcust25!
                                        .address!
                                        .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .read<PosController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billPincode
                                                .isNotEmpty
                                            ? context
                                                .watch<PosController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billPincode
                                                .toString()
                                            : '',
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                // context.read<PosController>().getselectedcust25 ==
                                //             null ||
                                context
                                        .read<PosController>()
                                        .getselectedcust25!
                                        .address!
                                        .isEmpty
                                    ? Container()
                                    : Container(
                                        child: Text(
                                        context
                                                .read<PosController>()
                                                .getselectedcust25!
                                                .address![0]
                                                .billstate
                                                .isNotEmpty
                                            ? context
                                                .watch<PosController>()
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
              : context.watch<PosController>().getselectedcust == null
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
                                                  .watch<PosController>()
                                                  .getselectedcust!
                                                  .name ==
                                              null
                                          ? ""
                                          : context
                                              .watch<PosController>()
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
                                            .read<PosController>()
                                            .mapUpdateCustomer(context
                                                .read<PosController>()
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
                                                      context.read<PosController>().updateAAAA(
                                                          context,
                                                          theme,
                                                          context
                                                              .read<
                                                                  PosController>()
                                                              .getselectedBillAdress!,
                                                          context
                                                              .read<
                                                                  PosController>()
                                                              .getselectedShipAdress!);

                                                      //  updateType(
                                                      //     context,
                                                      // context
                                                      //     .read<
                                                      //         PosController>()
                                                      //     .getselectedBillAdress!,
                                                      // context
                                                      //     .read<
                                                      //         PosController>()
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
                                            .read<PosController>()
                                            .clearData();
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
                                                    .watch<PosController>()
                                                    .getselectedcust!
                                                    .phNo!
                                                    .isNotEmpty
                                                ? " ${context.watch<PosController>().getselectedcust!.phNo}  |  "
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
                                                                PosController>()
                                                            .getselectedcust!
                                                            .email ==
                                                        null ||
                                                    context
                                                            .read<
                                                                PosController>()
                                                            .getselectedcust!
                                                            .email ==
                                                        'null' ||
                                                    context
                                                        .read<PosController>()
                                                        .getselectedcust!
                                                        .email!
                                                        .isEmpty
                                                ? ""
                                                : " ${context.watch<PosController>().getselectedcust!.email}",
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
                                                                PosController>()
                                                            .getselectedcust!
                                                            .tarNo ==
                                                        null ||
                                                    context
                                                            .read<
                                                                PosController>()
                                                            .getselectedcust!
                                                            .tarNo ==
                                                        'null' ||
                                                    context
                                                        .read<PosController>()
                                                        .getselectedcust!
                                                        .tarNo!
                                                        .isEmpty
                                                ? ""
                                                : "${context.watch<PosController>().getselectedcust!.tarNo}",
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
                                                        .watch<PosController>()
                                                        .getselectedcust!
                                                        .accBalance !=
                                                    0
                                                ? context
                                                    .watch<PosController>()
                                                    .config
                                                    .splitValues(context
                                                        .watch<PosController>()
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
                                            "${context.watch<PosController>().getselectedcust!.cardCode}",
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
                                                    .watch<PosController>()
                                                    .getselectedcust!
                                                    .point!
                                                    .isNotEmpty
                                                ? "${context.watch<PosController>().getselectedcust!.point}"
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
                                      .read<PosController>()
                                      .clearTextField();
                                  billAddress(context);
                                  await context
                                      .read<PosController>()
                                      .billaddresslist();

                                  context
                                      .read<PosController>()
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
                                                          .watch<
                                                              PosController>()
                                                          .getselectedcust ==
                                                      null &&
                                                  context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedcust!
                                                          .address ==
                                                      null ||
                                              context
                                                  .watch<PosController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              " ${context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address1!.isNotEmpty ? context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address1.toString() : ""},"
                                              "${context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address2!.isNotEmpty ? context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address2.toString() : ""},"
                                              " ${context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address3!.isNotEmpty ? context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address3.toString() : ""}",
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )),
                                      context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedcust ==
                                                      null &&
                                                  context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedcust!
                                                          .address ==
                                                      null ||
                                              context
                                                  .watch<PosController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              context
                                                      .watch<PosController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedBillAdress!]
                                                      .billCity
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<PosController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
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
                                                              PosController>()
                                                          .getselectedcust ==
                                                      null &&
                                                  context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedcust!
                                                          .address ==
                                                      null ||
                                              context
                                                  .watch<PosController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              context
                                                      .watch<PosController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedBillAdress!]
                                                      .billPincode
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<PosController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
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
                                                      .watch<PosController>()
                                                      .getselectedcust!
                                                      .address ==
                                                  null ||
                                              context
                                                  .watch<PosController>()
                                                  .getselectedcust!
                                                  .address!
                                                  .isEmpty
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              context
                                                      .watch<PosController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedBillAdress!]
                                                      .billstate
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<PosController>()
                                                      .getselectedcust!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
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
                                          .read<PosController>()
                                          .clearTextField();
                                      sipaddress(context);
                                      context
                                          .read<PosController>()
                                          .shippinfaddresslist();
                                    },
                                  );

                                  context
                                      .read<PosController>()
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
                                                      .watch<PosController>()
                                                      .getselectedcust55 ==
                                                  null ||
                                              context
                                                  .watch<PosController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isEmpty ||
                                              context
                                                      .watch<PosController>()
                                                      .getselectedcust55!
                                                      .address ==
                                                  null
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              " ${context.watch<PosController>().getselectedcust55!.address == null || context.watch<PosController>().getselectedcust55!.address![context.watch<PosController>().getselectedShipAdress!].address1!.isEmpty ? "" : context.watch<PosController>().getselectedcust55!.address![context.watch<PosController>().getselectedShipAdress!].address1.toString()},"
                                              "${context.watch<PosController>().getselectedcust55!.address == null || context.watch<PosController>().getselectedcust55!.address![context.watch<PosController>().getselectedShipAdress!].address2!.isEmpty ? "" : context.watch<PosController>().getselectedcust55!.address![context.watch<PosController>().getselectedShipAdress!].address2.toString()},"
                                              " ${context.watch<PosController>().getselectedcust55!.address == null || context.watch<PosController>().getselectedcust55!.address![context.watch<PosController>().getselectedShipAdress!].address3!.isEmpty ? "" : context.watch<PosController>().getselectedcust55!.address![context.watch<PosController>().getselectedShipAdress!].address3.toString()},",
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            )),
                                      context
                                                      .watch<PosController>()
                                                      .getselectedcust55 !=
                                                  null &&
                                              context
                                                  .watch<PosController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isNotEmpty
                                          ? Container(
                                              child: Text(
                                              context
                                                      .watch<PosController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedShipAdress!]
                                                      .billCity
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<PosController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedShipAdress!]
                                                      .billCity
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ))
                                          : Container(),
                                      context
                                                      .watch<PosController>()
                                                      .getselectedcust55 !=
                                                  null &&
                                              context
                                                  .watch<PosController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isNotEmpty
                                          ? Container(
                                              child: Text(
                                              context
                                                      .watch<PosController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedShipAdress!]
                                                      .billPincode
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<PosController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedShipAdress!]
                                                      .billPincode
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54),
                                            ))
                                          : Container(),
                                      context
                                                      .watch<PosController>()
                                                      .getselectedcust55 !=
                                                  null &&
                                              context
                                                  .watch<PosController>()
                                                  .getselectedcust55!
                                                  .address!
                                                  .isNotEmpty
                                          ? Container(
                                              child: Text(
                                              context
                                                      .watch<PosController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
                                                          .getselectedShipAdress!]
                                                      .billstate
                                                      .isNotEmpty
                                                  ? context
                                                      .watch<PosController>()
                                                      .getselectedcust55!
                                                      .address![context
                                                          .watch<
                                                              PosController>()
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
                controller: context.read<PosController>().searchcontroller,
                cursorColor: Colors.grey,
                autofocus: true,
                onChanged: (v) {
                  st(() {
                    context.read<PosController>().filterList(v);
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
                    itemCount:
                        context.read<PosController>().getfiltercustList.length,
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

                                context.read<PosController>().custSelected(
                                      context
                                          .read<PosController>()
                                          .getfiltercustList[index],
                                      context,
                                    );
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
                                            .watch<PosController>()
                                            .getfiltercustList[index]
                                            .cardCode!),
                                      ),
                                      Container(
                                          child: Text(
                                        context
                                            .watch<PosController>()
                                            .config
                                            .splitValues(context
                                                .watch<PosController>()
                                                .getfiltercustList[index]
                                                .accBalance!
                                                .toString()),
                                      )),
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
                                              .watch<PosController>()
                                              .getfiltercustList[index]
                                              .name!,
                                          maxLines: 2,
                                        ),
                                      ),
                                      Container(
                                        child: Text(context
                                            .watch<PosController>()
                                            .getfiltercustList[index]
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
      return Container(
        child: Column(
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
                      key: context.read<PosController>().formkeyy[6],
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
                                    ? context.read<PosController>().textError =
                                        'Select the series'
                                    : null,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                icon: const Icon(Icons.arrow_drop_down),
                                value:
                                    context.read<PosController>().custseriesNo,
                                items: context
                                    .read<PosController>()
                                    .seriesData
                                    .map((e) {
                                  return DropdownMenuItem(
                                      value: "${e.Series}",
                                      child: Container(
                                          child:
                                              Text(e.SeriesName.toString())));
                                }).toList(),
                                hint: const Text(
                                  "Select series",
                                ),
                                onChanged: (value) {
                                  setState(
                                    () {
                                      context
                                          .read<PosController>()
                                          .custseriesNo = value!;

                                      log('seriesValueAA ${context.read<PosController>().custseriesNo}');
                                      context
                                          .read<PosController>()
                                          .custCodeReadOnly();

                                      print(
                                          "sleect code: ${context.read<PosController>().custseriesNo}");
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
                                  .watch<PosController>()
                                  .seriesValuebool,
                              textCapitalization: TextCapitalization.sentences,
                              controller:
                                  context.read<PosController>().mycontroller[3],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black),
                              onChanged: (v) {},
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     context.read<PosController>().textError =
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
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
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
                              controller:
                                  context.read<PosController>().mycontroller[4],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  context.read<PosController>().textError =
                                      "Please Enter the Mobile Number";
                                  return "Please Enter the Mobile Number";
                                } else if (value.length < 10) {
                                  context.read<PosController>().textError =
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
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
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
                              controller:
                                  context.read<PosController>().mycontroller[5],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black),
                              onChanged: (v) {},

                              decoration: InputDecoration(
                                labelText: "Gst",
                                filled: false,
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller:
                                  context.read<PosController>().mycontroller[6],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  context.read<PosController>().textError =
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
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
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
                                    ? context.read<PosController>().textError =
                                        'Select a Group'
                                    : null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                icon: Icon(Icons.arrow_drop_down),
                                value: context.read<PosController>().codeValue,
                                items: context
                                    .watch<PosController>()
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
                                    context.read<PosController>().codeValue =
                                        value!;
                                    print("codeValue: " +
                                        context
                                            .read<PosController>()
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
                                  .read<PosController>()
                                  .mycontroller[46],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  context.read<PosController>().textError =
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
                                  .read<PosController>()
                                  .mycontroller[47],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  context.read<PosController>().textError =
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
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          context
                                              .read<PosController>()
                                              .selectattachment();
                                          context
                                              .read<PosController>()
                                              .fileValidation = false;
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                            top: widget.custHeight * 0.02,
                                            left: widget.custWidth * 0.02,
                                            right: widget.custWidth * 0.01,
                                            bottom: widget.custHeight * 0.02,
                                          ),
                                          color: Colors.white,
                                          width: widget.custWidth * 0.2,
                                          child: Icon(Icons.photo)),
                                    ),
                                  ],
                                ),
                                context
                                        .watch<PosController>()
                                        .tinfileError
                                        .isEmpty
                                    ? Container()
                                    : Text(
                                        context
                                            .watch<PosController>()
                                            .tinfileError,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.red)),
                              ],
                            ),
                          ),
                          context.read<PosController>().tinFiles == null
                              ? SizedBox()
                              : ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int i) {
                                    if (context
                                        .read<PosController>()
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
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width: widget.custWidth * 0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    context
                                                        .read<PosController>()
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
                                                                  PosController>()
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
                                        .read<PosController>()
                                        .tinFiles!
                                        .path
                                        .split('/')
                                        .last
                                        .contains("jp")) {
                                      return Container(
                                          child: Column(children: [
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    context
                                                        .read<PosController>()
                                                        .tinFiles!
                                                        .path
                                                        .split('/')
                                                        .last,
                                                  )),
                                              Container(
                                                  alignment: Alignment.center,
                                                  // color: Colors.red,
                                                  // width: widget.custWidth * 0.1,
                                                  // height:
                                                  //     widget.custHeight * 0.1,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  PosController>()
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
                                        .read<PosController>()
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
                                                  height:
                                                      widget.custHeight * 0.13,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/PDFimg.png"))),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width: widget.custWidth * 0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    context
                                                        .read<PosController>()
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
                                                                  PosController>()
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
                                        .read<PosController>()
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    context
                                                        .read<PosController>()
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
                                                                  PosController>()
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
                                                height:
                                                    widget.custHeight * 0.06,
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
                                                      .read<PosController>()
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
                                                                PosController>()
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
                                                  .read<PosController>()
                                                  .selectVatattachment();
                                              context
                                                  .read<PosController>()
                                                  .fileValidation = false;
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                top: widget.custHeight * 0.02,
                                                left: widget.custWidth * 0.02,
                                                right: widget.custWidth * 0.01,
                                                bottom:
                                                    widget.custHeight * 0.02,
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
                                        .watch<PosController>()
                                        .vatfileError
                                        .isEmpty
                                    ? Container()
                                    : Text(
                                        context
                                            .watch<PosController>()
                                            .vatfileError,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.red)),
                              ],
                            ),
                          ),
                          context.read<PosController>().vatFiles == null
                              ? SizedBox()
                              : ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int i) {
                                    if (context
                                        .read<PosController>()
                                        .vatFiles!
                                        .path
                                        .split('/')
                                        .last
                                        .contains("png")) {
                                      return Container(
                                          child: Column(children: [
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Container(
                                              //     decoration: BoxDecoration(),
                                              //     width: widget.custWidth * 0.09,
                                              //     height: widget.custHeight * 0.06,
                                              //     child: Center(
                                              //         child: Image.asset(
                                              //             "assets/CRM/img.jpg"))),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width: widget.custWidth * 0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    context
                                                        .read<PosController>()
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
                                                                  PosController>()
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
                                        .read<PosController>()
                                        .vatFiles!
                                        .path
                                        .split('/')
                                        .last
                                        .contains("jp")) {
                                      return Container(
                                          child: Column(children: [
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    context
                                                        .read<PosController>()
                                                        .vatFiles!
                                                        .path
                                                        .split('/')
                                                        .last,
                                                  )),
                                              Container(
                                                  alignment: Alignment.center,
                                                  // color: Colors.red,
                                                  // SizedBox(
                                                  //     width: widget.custWidth * 0.1,
                                                  //     height:
                                                  //         widget.custHeight * 0.06,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  PosController>()
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
                                        .read<PosController>()
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
                                                  height:
                                                      widget.custHeight * 0.13,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/PDFimg.png"))),
                                              Container(
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(),
                                                  width: widget.custWidth * 0.6,
                                                  // height: Screens.padingHeight(context) * 0.06,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    context
                                                        .read<PosController>()
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
                                                                  PosController>()
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
                                        .read<PosController>()
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    context
                                                        .read<PosController>()
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
                                                                  PosController>()
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
                                                height:
                                                    widget.custHeight * 0.06,
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
                                                      .read<PosController>()
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
                                                                PosController>()
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
                                    ? context.read<PosController>().textError =
                                        'Select a Territory'
                                    : null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                                icon: Icon(Icons.arrow_drop_down),
                                value:
                                    context.read<PosController>().teriteriValue,
                                items: context
                                    .watch<PosController>()
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
                                        .read<PosController>()
                                        .teriteriValue = value!;
                                    print("teriteriValue: " +
                                        context
                                            .read<PosController>()
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
                                  .read<PosController>()
                                  .mycontroller[48],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  context.read<PosController>().textError =
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
                                  .read<PosController>()
                                  .mycontroller[51],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  context.read<PosController>().textError =
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
                                  .read<PosController>()
                                  .mycontroller[21],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.black),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  // context.read<PosController>().textError =
                                  //     "Please Enter the Email Address";

                                  // return "Please Enter the Email Address";
                                  // } else
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    context.read<PosController>().textError =
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
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
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
                                    ? context.read<PosController>().textError =
                                        'select a Payment Terms'
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
                                value:
                                    context.watch<PosController>().paygrpValue,
                                items: context
                                    .watch<PosController>()
                                    .paygroupData!
                                    .map((e) {
                                  return DropdownMenuItem(
                                      // ignore: unnecessary_brace_in_string_interps
                                      value: "${e.GroupNum}",
                                      child: Container(
                                          // height: Screens.bodyheight(context)*0.1,
                                          child:
                                              Text(e.PymntGroup.toString())));
                                }).toList(),
                                hint: Text("Payment terms",
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54)),
                                onChanged: (String? value) {
                                  setState(() {
                                    context.read<PosController>().paygrpValue =
                                        value!;
                                    print("paygrpValue: " +
                                        context
                                            .read<PosController>()
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
                                  .read<PosController>()
                                  .mycontroller[49],
                              // maxLines: 4,
                              onTap: () {
                                context
                                        .read<PosController>()
                                        .mycontroller[49]
                                        .text =
                                    context
                                        .read<PosController>()
                                        .mycontroller[49]
                                        .text
                                        .replaceAll(',', '');
                              },
                              onEditingComplete: () {
                                context
                                        .read<PosController>()
                                        .mycontroller[49]
                                        .text =
                                    context
                                        .read<PosController>()
                                        .config
                                        .splitValues(context
                                            .read<PosController>()
                                            .mycontroller[49]
                                            .text);
                                context
                                    .read<PosController>()
                                    .disableKeyBoard(context);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  context.read<PosController>().textError =
                                      "Please Enter the Credit Limit";

                                  return "Please Enter the Credit Limit";
                                } else {
                                  return null;
                                }
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
                                        .read<PosController>()
                                        .mycontroller[49]
                                        .text =
                                    context
                                        .read<PosController>()
                                        .config
                                        .splitValues(context
                                            .read<PosController>()
                                            .mycontroller[49]
                                            .text);
                              },
                              controller: context
                                  .read<PosController>()
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
                  onPressed: context.read<PosController>().loadingBtn == false
                      ? () {
                          setState(() {
                            context
                                .read<PosController>()
                                .createnewchagescustaddres(context, theme, 6);
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      backgroundColor: theme.primaryColor),
                  child: context.read<PosController>().loadingBtn == false
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
        ),
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
                key: context.read<PosController>().formkeyy[6],
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
                    //       value: context.read<PosController>().seriesValue,
                    //       items: context
                    //           .read<PosController>()
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
                    //             context.read<PosController>().custseriesNo=
                    //                 value!;
                    //             log('seriesValueAA ${context.read<PosController>().seriesValue}');
                    //             if (context
                    //                     .read<PosController>()
                    //                     .seriesValue
                    //                     .toString()
                    //                     .toLowerCase() ==
                    //                 '218') {
                    //               context
                    //                   .read<PosController>()
                    //                   .seriesValuebool = false;

                    //               log('seriesValuebool11 ${context.read<PosController>().seriesValuebool}');
                    //             } else {
                    //               context
                    //                   .read<PosController>()
                    //                   .seriesValuebool = true;
                    //               log('seriesValuebool222 ${context.read<PosController>().seriesValuebool}');
                    //             }
                    //             print("sleect code: " +
                    //                 context
                    //                     .read<PosController>()
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
                    //         context.read<PosController>().seriesValuebool,
                    //     textCapitalization: TextCapitalization.sentences,
                    //     controller:
                    //         context.read<PosController>().mycontroller[3],
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller:
                            context.read<PosController>().mycontroller[4],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
                                "Please Enter the Mobile Number";
                            return "Please Enter the Mobile Number";
                          } else if (value.length < 10) {
                            context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[5],
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
                        controller:
                            context.read<PosController>().mycontroller[6],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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

                        controller:
                            context.read<PosController>().mycontroller[21],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            //   // context.read<PosController>().textError =
                            //   //     "Please Enter the Email Address";
                            //   return "Please Enter the Email Address";
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              context.read<PosController>().textError =
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
      context.read<PosController>().custList2.length,
      (ind) {
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
        context.read<PosController>().custSelected(
              context.read<PosController>().custList2[ind],
              context,
            );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: theme.primaryColor,
            border: Border.all(color: theme.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Text(context.watch<PosController>().custList2[ind].name!,
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
                              .read<PosController>()
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
                                .read<PosController>()
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
                            .watch<PosController>()
                            .
                            // .getselectedcust!
                            // .address!
                            billadrrssItemlist
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              context
                                  .read<PosController>()
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
                                              "${context.watch<PosController>().billadrrssItemlist[index].address1 ?? ''},"
                                              "${context.watch<PosController>().billadrrssItemlist[index].address2 ?? ''},"
                                              "${context.watch<PosController>().billadrrssItemlist[index].address3 ?? ''}"),
                                        ),
                                        Container(
                                          child: Text(context
                                              .watch<PosController>()
                                              .billadrrssItemlist[index]
                                              .billCity),
                                        ),
                                        Container(
                                          child: Text(context
                                              .watch<PosController>()
                                              .billadrrssItemlist[index]
                                              .billPincode),
                                        ),
                                        Container(
                                          child: Text(context
                                              .watch<PosController>()
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
                context.read<PosController>().clearTextField();
                context.read<PosController>().checkboxx = false;

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
                  itemCount:
                      context.watch<PosController>().shipadrrssItemlist.length,
                  // getselectedcust!.address!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        context.read<PosController>().changeShipAddress(index);
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
                                        "${context.watch<PosController>().shipadrrssItemlist[index].address1 ?? ''}${context.watch<PosController>().shipadrrssItemlist[index].address2 ?? ''}${context.watch<PosController>().shipadrrssItemlist[index].address3 ?? ''}"),
                                  ),
                                  Container(
                                    child: Text(context
                                            .watch<PosController>()
                                            .shipadrrssItemlist[index]
                                            .billCity
                                            .isNotEmpty
                                        ? context
                                            .watch<PosController>()
                                            .shipadrrssItemlist[index]
                                            .billCity
                                        : ''),
                                  ),
                                  Container(
                                    child: Text(context
                                                .read<PosController>()
                                                .shipadrrssItemlist[index]
                                                .billPincode !=
                                            null
                                        ? context
                                            .watch<PosController>()
                                            .shipadrrssItemlist[index]
                                            .billPincode
                                        : ""),
                                  ),
                                  Container(
                                    child: Text(context
                                        .watch<PosController>()
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
                context.read<PosController>().clearTextField();
                context.read<PosController>().checkboxx = false;
                createShippAddress(context, theme);
                // context.read<PosController>().checkboxx = false;
                // context.read<PosController>().clearTextField();
                // createShippAddress(context, theme);
              },
            ));
      });
}

// createAddress(BuildContext context, ThemeData theme) async {
//   final theme = Theme.of(context);
//   context.read<PosController>().checkboxx = false;
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             contentPadding: EdgeInsets.all(0),
//             content: AlertBox(
//               payMent: 'Create Address',
//               widget: createAddressMethod(theme, context),
//               buttonName: "Save",
//               callback: () async {
//                 await context
//                     .read<PosController>()
//                     .insertnewaddresscreation(context, theme);
//               },
//             ));
//       });
// }

createBillAddress(BuildContext context, ThemeData theme) async {
  final theme = Theme.of(context);
  // context.read<PosController>().checkboxx = false;
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: AlertBox(
                payMent: 'Create Address',
                widget: createBillAddressMethod(theme, context),
                buttonName: null
                // "Save",
                // callback: () {
                //   context
                //       .read<PosController>()
                //       .insertnewbilladdresscreation(context, theme);
                // },
                ));
      });
}

createShippAddress(BuildContext context, ThemeData theme) async {
  final theme = Theme.of(context);
  // context.read<PosController>().checkboxx = false;
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, st) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: AlertBox(
                payMent: 'Create Address',
                widget: createShipAddressMethod(theme, context),
                buttonName: null,

                // "Save",
                // callback: () async {
                // await context
                //     .read<PosController>()
                //     .insertnewshipaddresscreation(context, theme);
                // },
              ));
        });
      });
}

Container createAddressMethod(ThemeData theme, BuildContext context) {
  context.read<PosController>().checkboxx = false;
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
  // context.read<PosController>().checkboxx = false;
  return Container(
    child: Column(
      children: [
        Container(
          width: Screens.width(context) * 0.5,
          height: Screens.padingHeight(context) * 0.51,
          padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.02,
            // vertical: Screens.padingHeight(context) * 0.02,
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
                  context.watch<PosController>().OndDisablebutton == false
                      ? () {
                          log("context.read<PosController>().OndDisablebutton:::${context.read<PosController>().OndDisablebutton}");
                          context
                              .read<PosController>()
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
  // context.read<PosController>().checkboxx = false;
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
                  context.watch<PosController>().OndDisablebutton == false
                      ? () {
                          context
                              .read<PosController>()
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
            key: context.read<PosController>().formkeyAdd,
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
                    controller: context.read<PosController>().mycontroller[7],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PosController>().textError =
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
                    controller: context.read<PosController>().mycontroller[8],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PosController>().textError =
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
                    controller: context.read<PosController>().mycontroller[9],
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[10],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[11],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
                                "Please Enter the Pin Code";

                            return "Please Enter the Pin Code";
                          } else if (value.length < 6) {
                            context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[12],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[13],
                        textCapitalization: TextCapitalization.sentences,

                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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
                        value: context.watch<PosController>().checkboxx,
                        onChanged: (val) {
                          st(() {
                            context.read<PosController>().checkboxx = val!;
                            context.read<PosController>().billToShip(val);
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
                          controller:
                              context.read<PosController>().mycontroller[14],
                          textCapitalization: TextCapitalization.sentences,

                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PosController>().textError =
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
                          controller:
                              context.read<PosController>().mycontroller[15],
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PosController>().textError =
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
                          controller:
                              context.read<PosController>().mycontroller[16],
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[17],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[18],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
                                "Please Enter the Ship_PinCode";

                            return "Please Enter the PinCode";
                          } else if (value.length < 6) {
                            context.read<PosController>().textError =
                                "Please Enter 6 Digit Ship_PinCode";

                            return "Please Enter 6 Digit PinCode";
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
                        controller:
                            context.read<PosController>().mycontroller[19],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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

                        controller:
                            context.read<PosController>().mycontroller[20],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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
            key: context.read<PosController>().formkeyAdd,
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
                    controller: context.read<PosController>().mycontroller[7],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PosController>().textError =
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
                    controller: context.read<PosController>().mycontroller[8],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PosController>().textError =
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
                    controller: context.read<PosController>().mycontroller[9],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[10],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[11],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
                                "Please Enter the Pin Code";

                            return "Please Enter the Pin Code";
                          } else if (value.length < 6) {
                            context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[12],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[13],
                        textCapitalization: TextCapitalization.sentences,

                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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
                        value: context.watch<PosController>().checkboxx,
                        onChanged: (val) {
                          st(() {
                            context.read<PosController>().checkboxx = val!;
                            context.read<PosController>().billToShip(val);
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: custHeight * 0.02,
                ),
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
            key: context.read<PosController>().formkeyShipAdd,
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
                          controller:
                              context.read<PosController>().mycontroller[14],
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PosController>().textError =
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
                          controller:
                              context.read<PosController>().mycontroller[15],
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PosController>().textError =
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
                          controller:
                              context.read<PosController>().mycontroller[16],
                          textCapitalization: TextCapitalization.sentences,
                          cursorColor: Colors.grey,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: Colors.black),
                          onChanged: (v) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[17],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
                                "Please Enter the Ship_City";

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
                        controller:
                            context.read<PosController>().mycontroller[18],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
                                "Please Enter the PinCode";

                            return "Please Enter the Pin Code";
                          } else if (value.length < 6) {
                            context.read<PosController>().textError =
                                "Please Enter the 6 Digit PinCode";

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
                        controller:
                            context.read<PosController>().mycontroller[19],
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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
                        controller:
                            context.read<PosController>().mycontroller[20],
                        textCapitalization: TextCapitalization.sentences,

                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            context.read<PosController>().textError =
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
                        value: context.watch<PosController>().checkboxx,
                        onChanged: (val) {
                          st(() {
                            context.read<PosController>().checkboxx = val!;
                            context.read<PosController>().shipToBill(val);
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

// // ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, unnecessary_null_in_if_null_operators, prefer_interpolation_to_compose_strings

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:posproject/Constant/Screen.dart';
// import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
// import 'package:posproject/Pages/Sales%20Screen/Widgets/Dialog%20Box/AlertBox.dart';
// import 'package:provider/provider.dart';

// class CustomerDetails extends StatefulWidget {
//   CustomerDetails(
//       {Key? key,
//       required this.theme,
//       required this.custHeight,
//       required this.custWidth})
//       : super(key: key);

//   final ThemeData theme;
//   double custHeight;
//   double custWidth;

//   @override
//   State<CustomerDetails> createState() => _CustomerDetailsState();
// }

// class _CustomerDetailsState extends State<CustomerDetails> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.white,
//       ),
//       padding: EdgeInsets.only(
//           top: widget.custHeight * 0.01,
//           bottom: widget.custHeight * 0.02,
//           left: widget.custHeight * 0.01,
//           right: widget.custHeight * 0.01),
//       width: widget.custWidth,
//       //height: custHeight,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           context.read<PosController>().selectedcust2 != null
//               ? Container()
//               : Container(
//                   // width: custWidth * 0.7,
//                   width: widget.custWidth * 1,
//                   decoration: BoxDecoration(
//                     border:
//                         Border.all(color: Color.fromARGB(255, 240, 235, 235)),
//                     borderRadius: BorderRadius.circular(3),
//                     color: Colors.grey.withOpacity(0.001),
//                   ),
//                   child: TextFormField(
//                     controller: context.read<PosController>().mycontroller[98],
//                     textCapitalization: TextCapitalization.sentences,
//                     onChanged: (v) {},
//                     readOnly: true,
//                     onTap: () {
//                       context.read<PosController>().clearTextField();
//                       context.read<PosController>().refreshfiltercust();
//                       showDialog(
//                           context: context,
//                           barrierDismissible: false,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                                 contentPadding: EdgeInsets.all(0),
//                                 content: AlertBox(
//                                   payMent: 'Select Customer',
//                                   widget: forSearchBtn(context),
//                                   buttonName: 'Add new',
//                                   callback: () {
//                                     Navigator.pop(context);

//                                     showDialog(
//                                         context: context,
//                                         barrierDismissible: false,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                               contentPadding: EdgeInsets.all(0),
//                                               content: AlertBox(
//                                                 payMent: 'New Customer',
//                                                 widget: forAddNewBtn(context),
//                                                 buttonName: "Save",
//                                                 callback: () {
//                                                   setState(() {
//                                                     context
//                                                         .read<PosController>()
//                                                         .createnewchagescustaddres(
//                                                             context, theme, 6);
//                                                   });

//                                                   // .addnewCustomer(
//                                                   //     context, 6);

//                                                   print('AddNew Customer');
//                                                 },
//                                               ));
//                                         });
//                                   },
//                                 ));
//                           });
//                       // });
//                     },
//                     decoration: InputDecoration(
//                       suffixIcon: Icon(
//                         Icons.search,
//                         // size: custHeight * 0.08,
//                         color: Colors.grey,
//                       ),

//                       // showDialog(
//                       //     context: context,
//                       //     barrierDismissible: true,
//                       //     builder: (BuildContext context) {
//                       //       return AlertDialog(
//                       //           contentPadding: EdgeInsets.all(0),
//                       //           content: AlertBox(
//                       //             payMent: 'Select Customer',
//                       //             widget: forSearchBtn(context, context.watch<PosController>()),
//                       //             buttonName: 'Add new',
//                       //             callback: () {
//                       //               Navigator.pop(context);
//                       //               showDialog(
//                       //                   context: context,
//                       //                   barrierDismissible: false,
//                       //                   builder: (BuildContext context) {
//                       //                     return AlertDialog(
//                       //                         contentPadding: EdgeInsets.all(0),
//                       //                         content: AlertBox(
//                       //                           payMent: 'New Customer',
//                       //                           widget:
//                       //                               forAddNewBtn(context, context.watch<PosController>()),
//                       //                           buttonName: "Save",
//                       //                           callback: () {
//                       //                             Navigator.pop(context);

//                       //                               context.watch<PosController>().insertAddNewCusToDB(
//                       //                                 context, 6);

//                       //                               context.watch<PosController>().getCustDetFDB();
//                       //                           },
//                       //                         ));
//                       //                   });
//                       //             },
//                       //           ));
//                       //     });

//                       // color: theme.primaryColor,

//                       hintText: 'Customers',
//                       hintStyle: theme.textTheme.bodyLarge?.copyWith(
//                           // color: Colors.grey
//                           ),
//                       filled: false,
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 15,
//                         horizontal: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//           SizedBox(
//             height: widget.custHeight * 0.02,
//           ),
//           context.read<PosController>().selectedcust2 != null
//               ? Container(
//                   color: context.read<PosController>().selectedcust2 != null
//                       ? Colors.grey[300]
//                       : Colors.grey[50],
//                   padding: EdgeInsets.symmetric(
//                       vertical: widget.custHeight * 0.02,
//                       horizontal: widget.custWidth * 0.02),
//                   // height: custHeight * 0.75,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         width: widget.custWidth,
//                         alignment: Alignment.centerRight,
//                         // height: custHeight * 0.02,
//                         // child:
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //   children: [
//                         //     SizedBox(
//                         //       // color: Colors.green,
//                         //       width: custWidth * 0.8,
//                         //       child: Text(
//                         //         context
//                         //             .watch<PosController>()
//                         //             .selectedcust2!
//                         //             .name
//                         //             .toString(),
//                         //         style: theme.textTheme.bodyLarge?.copyWith(
//                         //             color: Colors.black, fontSize: 20),
//                         //       ),
//                         //     ),
//                         //     InkWell(
//                         //         onTap: () {},
//                         //         child: Container(
//                         //           width: custWidth * 0.06,
//                         //           alignment: Alignment.center,
//                         //           //     color: Colors.red,
//                         //           child: Icon(Icons.edit),
//                         //         )),
//                         //     InkWell(
//                         //         onTap: () {
//                         //           //   context.watch<PosController>().clearData();
//                         //         },
//                         //         child: Container(
//                         //           width: custWidth * 0.06,
//                         //           alignment: Alignment.center,
//                         //           //     color: Colors.blue,
//                         //           child: Icon(Icons.close_sharp),
//                         //         )),
//                         //   ],
//                         // ) // IconButton(onPressed: (){}, icon: Icon(Icons.close_sharp))
//                       ),
//                       SizedBox(
//                         height: widget.custHeight * 0.01,
//                       ),
//                       SizedBox(
//                         width: widget.custWidth,
//                         // color: Colors.green,
//                         child: Row(
//                           children: [
//                             Container(
//                               // color: Colors.green,
//                               // height: custHeight * 0.02,
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     child: Icon(
//                                       Icons.phone,
//                                       color: Colors.black54,
//                                       // size: custHeight * 0.05,
//                                     ),
//                                   ),
//                                   Container(
//                                     child: Text(
//                                         context
//                                                 .read<PosController>()
//                                                 .selectedcust2!
//                                                 .phNo!
//                                                 .isNotEmpty
//                                             ? " ${context.watch<PosController>().selectedcust2!.phNo}  |  "
//                                             : '',
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     child: Icon(
//                                       Icons.mail_outline,
//                                       color: Colors.black54,
//                                       // size: custHeight * 0.05,
//                                     ),
//                                   ),
//                                   Container(
//                                     child: Text(
//                                         context
//                                                 .read<PosController>()
//                                                 .selectedcust2!
//                                                 .email!
//                                                 .isNotEmpty
//                                             ? context
//                                                 .watch<PosController>()
//                                                 .selectedcust2!
//                                                 .email
//                                                 .toString()
//                                             : "",
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: widget.custHeight * 0.01,
//                       ),
//                       SizedBox(
//                         width: widget.custWidth,
//                         // color: Colors.green,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               width: widget.custWidth * 0.465,
//                               //  color: Colors.green,
//                               // height: custHeight * 0.02,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     child: Text("GST",
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                       right: widget.custWidth * 0.02,
//                                     ),
//                                     child: Text(
//                                         context
//                                                 .read<PosController>()
//                                                 .selectedcust2!
//                                                 .tarNo!
//                                                 .isNotEmpty
//                                             ? context
//                                                 .watch<PosController>()
//                                                 .selectedcust2!
//                                                 .tarNo
//                                                 .toString()
//                                             : "",
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.centerRight,
//                               width: widget.custWidth * 0.465,
//                               //  color: Colors.red,
//                               // height: custHeight * 0.02,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     child: Text("Balance",
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                   Container(
//                                     child: Text(
//                                         context
//                                                     .read<PosController>()
//                                                     .selectedcust2!
//                                                     .accBalance! !=
//                                                 0
//                                             ? context
//                                                 .watch<PosController>()
//                                                 .selectedcust2!
//                                                 .accBalance
//                                                 .toString()
//                                             : '0.00',
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: widget.custHeight * 0.01,
//                       ),
//                       SizedBox(
//                         width: widget.custWidth,
//                         // color: Colors.green,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               width: widget.custWidth * 0.465,
//                               //  color: Colors.green,
//                               // height: custHeight * 0.02,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     child: Text("Code#",
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                       right: widget.custWidth * 0.02,
//                                     ),
//                                     child: Text(
//                                         context
//                                             .watch<PosController>()
//                                             .selectedcust2!
//                                             .cardCode
//                                             .toString(),
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.centerRight,
//                               width: widget.custWidth * 0.465,
//                               // color: Colors.red,
//                               // height: custHeight * 0.02,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     child: Text("Points",
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                   Container(
//                                     child: Text(
//                                         context
//                                                 .read<PosController>()
//                                                 .selectedcust2!
//                                                 .point!
//                                                 .isNotEmpty
//                                             ? context
//                                                 .watch<PosController>()
//                                                 .selectedcust2!
//                                                 .point
//                                                 .toString()
//                                             : "",
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: widget.custHeight * 0.01,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               // loteg(" pos.getselectedcust!.address!.length:${  context.watch<PosController>().getselectedcust!.address!.length}");
//                               //   context.watch<PosController>().clearTextField();
//                               //   context.watch<PosController>().getcustaddresslist();
//                               // billAddress(context);
//                             },
//                             child: SizedBox(
//                               width: widget.custWidth * 0.465,
//                               // color: Colors.red,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     width: widget.custWidth * 0.465,
//                                     padding: EdgeInsets.only(
//                                         right: widget.custWidth * 0.02),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                             child: Text(
//                                           "Billing Address",
//                                           style: theme.textTheme.bodyLarge
//                                               ?.copyWith(color: Colors.black54),
//                                         )),
//                                         SizedBox(
//                                             width: widget.custWidth * 0.04,
//                                             child: Icon(
//                                               Icons.arrow_drop_down,
//                                               size: 30,
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                       child: Text(
//                                     " ${context.read<PosController>().selectedcust2!.address![0].address1!.isNotEmpty ? context.watch<PosController>().selectedcust2!.address![0].address1.toString() : ""},"
//                                     "${context.read<PosController>().selectedcust2!.address![0].address2!.isNotEmpty ? context.watch<PosController>().selectedcust2!.address![0].address2.toString() : ""},"
//                                     " ${context.read<PosController>().selectedcust2!.address![0].address3!.isNotEmpty ? context.watch<PosController>().selectedcust2!.address![0].address3.toString() : ""}",
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyLarge
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     context
//                                             .read<PosController>()
//                                             .selectedcust2!
//                                             .address![0]
//                                             .billCity
//                                             .isNotEmpty
//                                         ? context
//                                             .watch<PosController>()
//                                             .selectedcust2!
//                                             .address![0]
//                                             .billCity
//                                             .toString()
//                                         : " ",
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyLarge
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     context
//                                             .read<PosController>()
//                                             .selectedcust2!
//                                             .address![0]
//                                             .billPincode
//                                             .isNotEmpty
//                                         ? context
//                                             .watch<PosController>()
//                                             .selectedcust2!
//                                             .address![0]
//                                             .billPincode
//                                             .toString()
//                                         : '',
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyLarge
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     context
//                                             .read<PosController>()
//                                             .selectedcust2!
//                                             .address![0]
//                                             .billstate
//                                             .isNotEmpty
//                                         ? context
//                                             .watch<PosController>()
//                                             .selectedcust2!
//                                             .address![0]
//                                             .billstate
//                                             .toString()
//                                         : '',
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyLarge
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {},
//                             child: SizedBox(
//                               width: widget.custWidth * 0.465,
//                               //color: Colors.green,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     width: widget.custWidth * 0.465,
//                                     padding: EdgeInsets.only(
//                                         right: widget.custWidth * 0.02),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                             child: Text(
//                                           "Shipping Address",
//                                           maxLines: 2,
//                                           style: theme.textTheme.bodyLarge
//                                               ?.copyWith(color: Colors.black54),
//                                         )),
//                                         SizedBox(
//                                             width: widget.custWidth * 0.04,
//                                             child: Icon(
//                                               Icons.arrow_drop_down,
//                                               size: 30,
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                       child: Text(
//                                     "${context.watch<PosController>().shipaddress}",
//                                     // " ${  context.watch<PosController>().selectedcust2!.address![  context.watch<PosController>().getselectedShipAdress!].address1!.isNotEmpty ?   context.watch<PosController>().selectedcust2!.address![  context.watch<PosController>().getselectedShipAdress!].address1.toString() : "null"}," +
//                                     //     "${  context.watch<PosController>().selectedcust2!.address![  context.watch<PosController>().getselectedShipAdress!].address2!.isNotEmpty ?   context.watch<PosController>().selectedcust2!.address![  context.watch<PosController>().getselectedShipAdress!].address2.toString() : "null"}," +
//                                     //     " ${  context.watch<PosController>().selectedcust2!.address![  context.watch<PosController>().getselectedShipAdress!].address3!.isNotEmpty ?   context.watch<PosController>().selectedcust2!.address![  context.watch<PosController>().getselectedShipAdress!].address3.toString() : "null"}",

//                                     // '${  context.watch<PosController>().getselectedcust!.address![  context.watch<PosController>().getselectedShipAdress!].address1.toString()},' +
//                                     //     '${  context.watch<PosController>().getselectedcust!.address![  context.watch<PosController>().getselectedShipAdress!].address2.toString()},' +
//                                     //     context.watch<PosController>()
//                                     //         .getselectedcust!
//                                     //         .address![context.watch<PosController>()
//                                     //             .getselectedShipAdress!]
//                                     //         .address3
//                                     //         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyLarge
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     context
//                                             .read<PosController>()
//                                             .selectedcust2!
//                                             .address![context
//                                                 .read<PosController>()
//                                                 .getselectedBillAdress!]
//                                             .billCity
//                                             .isNotEmpty
//                                         ? context
//                                             .read<PosController>()
//                                             .selectedcust2!
//                                             .address![context
//                                                 .read<PosController>()
//                                                 .getselectedBillAdress!]
//                                             .billCity
//                                             .toString()
//                                         : '',
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyLarge
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     context
//                                             .read<PosController>()
//                                             .selectedcust2!
//                                             .address![context
//                                                 .read<PosController>()
//                                                 .getselectedBillAdress!]
//                                             .billPincode
//                                             .isNotEmpty
//                                         ? context
//                                             .watch<PosController>()
//                                             .selectedcust2!
//                                             .address![context
//                                                 .watch<PosController>()
//                                                 .getselectedBillAdress!]
//                                             .billPincode
//                                             .toString()
//                                         : '',
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyLarge
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     context
//                                             .read<PosController>()
//                                             .selectedcust2!
//                                             .address![context
//                                                 .read<PosController>()
//                                                 .getselectedBillAdress!]
//                                             .billstate
//                                             .isNotEmpty
//                                         ? context
//                                             .watch<PosController>()
//                                             .selectedcust2!
//                                             .address![context
//                                                 .watch<PosController>()
//                                                 .getselectedBillAdress!]
//                                             .billstate
//                                             .toString()
//                                         : '',
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyLarge
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 )
//               : context.read<PosController>().getselectedcust == null
//                   ? Container(
//                       // color: Colors.amber,
//                       height: widget.custHeight * 1.14,
//                       padding: EdgeInsets.symmetric(
//                           vertical: widget.custHeight * 0.02,
//                           horizontal: widget.custWidth * 0.02),
//                       child: SingleChildScrollView(
//                         child: Wrap(
//                             spacing: 10.0,
//                             runSpacing: 10.0,
//                             children: listContainersProduct(
//                               context,
//                               theme,
//                             )),
//                       ),
//                     )
//                   : Container(
//                       color: Colors.grey[50],
//                       padding: EdgeInsets.symmetric(
//                           vertical: widget.custHeight * 0.02,
//                           horizontal: widget.custWidth * 0.02),
//                       // height: custHeight * 0.75,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                               width: widget.custWidth,
//                               alignment: Alignment.centerRight,
//                               // height: custHeight * 0.02,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     // color: Colors.green,
//                                     width: widget.custWidth * 0.8,
//                                     child: Text(
//                                       context
//                                                   .watch<PosController>()
//                                                   .getselectedcust!
//                                                   .name ==
//                                               null
//                                           ? ""
//                                           : context
//                                               .watch<PosController>()
//                                               .getselectedcust!
//                                               .name
//                                               .toString(),
//                                       style: theme.textTheme.bodyLarge
//                                           ?.copyWith(
//                                               color: Colors.black,
//                                               fontSize: 20),
//                                     ),
//                                   ),
//                                   InkWell(
//                                       onTap: () {
//                                         // setState(() {
//                                         context
//                                             .read<PosController>()
//                                             .mapUpdateCustomer(context
//                                                 .read<PosController>()
//                                                 .getselectedCustomer);
//                                         // });

//                                         showDialog(
//                                             context: context,
//                                             barrierDismissible: false,
//                                             builder: (BuildContext context) {
//                                               return AlertDialog(
//                                                   contentPadding:
//                                                       EdgeInsets.all(0),
//                                                   content: AlertBox(
//                                                     payMent: 'Update Customer',
//                                                     widget: forAddNewBtn(
//                                                       context,
//                                                     ),
//                                                     buttonName: "Update",
//                                                     callback: () {
//                                                       showDialog(
//                                                           context: context,
//                                                           barrierDismissible:
//                                                               false,
//                                                           builder: (BuildContext
//                                                               context) {
//                                                             return AlertDialog(
//                                                               contentPadding:
//                                                                   EdgeInsets
//                                                                       .all(0),
//                                                               content: updateType(
//                                                                   context,
//                                                                   context
//                                                                       .watch<
//                                                                           PosController>()
//                                                                       .getselectedBillAdress!,
//                                                                   context
//                                                                       .watch<
//                                                                           PosController>()
//                                                                       .getselectedShipAdress!),
//                                                             );
//                                                           });
//                                                     },
//                                                   ));
//                                             });
//                                       },
//                                       child: Container(
//                                         width: widget.custWidth * 0.06,
//                                         alignment: Alignment.center,
//                                         //     color: Colors.red,
//                                         child: Icon(Icons.edit),
//                                       )),
//                                   InkWell(
//                                       onTap: () {
//                                         // setState(() {
//                                         context
//                                             .read<PosController>()
//                                             .clearData();
//                                         // });
//                                       },
//                                       child: Container(
//                                         width: widget.custWidth * 0.06,
//                                         alignment: Alignment.center,
//                                         //     color: Colors.blue,
//                                         child: Icon(Icons.close_sharp),
//                                       )),
//                                 ],
//                               )),
//                           SizedBox(
//                             height: widget.custHeight * 0.01,
//                           ),
//                           SizedBox(
//                             width: widget.custWidth,
//                             // color: Colors.green,
//                             child: Row(
//                               children: [
//                                 Container(
//                                   // color: Colors.green,
//                                   // height: custHeight * 0.02,
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         child: Icon(
//                                           Icons.phone,
//                                           color: Colors.black54,
//                                           // size: custHeight * 0.05,
//                                         ),
//                                       ),
//                                       Container(
//                                         child: Text(
//                                             context
//                                                     .watch<PosController>()
//                                                     .getselectedcust!
//                                                     .phNo!
//                                                     .isNotEmpty
//                                                 ? " ${context.watch<PosController>().getselectedcust!.phNo}  |  "
//                                                 : '',
//                                             style: theme.textTheme.bodyLarge
//                                                 ?.copyWith(
//                                                     color: Colors.black54)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         child: Icon(
//                                           Icons.mail_outline,
//                                           color: Colors.black54,
//                                           // size: custHeight * 0.05,
//                                         ),
//                                       ),
//                                       Container(
//                                         child: Text(
//                                             context
//                                                         .read<PosController>()
//                                                         .getselectedcust!
//                                                         .email!
//                                                         .isNotEmpty ||
//                                                     context
//                                                             .read<
//                                                                 PosController>()
//                                                             .getselectedcust!
//                                                             .email !=
//                                                         null
//                                                 ? " ${context.watch<PosController>().getselectedcust!.email}"
//                                                 : "",
//                                             style: theme.textTheme.bodyLarge
//                                                 ?.copyWith(
//                                                     color: Colors.black54)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: widget.custHeight * 0.01,
//                           ),
//                           SizedBox(
//                             width: widget.custWidth,
//                             // color: Colors.green,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 SizedBox(
//                                   width: widget.custWidth * 0.465,
//                                   //  color: Colors.green,
//                                   // height: custHeight * 0.02,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         child: Text("Gst",
//                                             style: theme.textTheme.bodyLarge
//                                                 ?.copyWith(
//                                                     color: Colors.black54)),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(
//                                           right: widget.custWidth * 0.02,
//                                         ),
//                                         child: Text(
//                                             context
//                                                         .read<PosController>()
//                                                         .getselectedcust!
//                                                         .tarNo!
//                                                         .isNotEmpty ||
//                                                     context
//                                                             .read<
//                                                                 PosController>()
//                                                             .getselectedcust!
//                                                             .tarNo !=
//                                                         null
//                                                 ? "${context.watch<PosController>().getselectedcust!.tarNo.toString()}"
//                                                 : "",
//                                             style: theme.textTheme.bodyLarge
//                                                 ?.copyWith(
//                                                     color: Colors.black54)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   alignment: Alignment.centerRight,
//                                   width: widget.custWidth * 0.465,
//                                   //  color: Colors.red,
//                                   // height: custHeight * 0.02,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         child: Text("Balance",
//                                             style: theme.textTheme.bodyLarge
//                                                 ?.copyWith(
//                                                     color: Colors.black54)),
//                                       ),
//                                       // Container(
//                                       //   child: Text(
//                                       //       context
//                                       //                   .read<PosController>()
//                                       //                   .getselectedcust!
//                                       //                   .accBalance! !=
//                                       //               0
//                                       //           ? "${context.watch<PosController>().config.splitValues(context.watch<PosController>().getselectedcust!.accBalance!.toStringAsFixed(2))}"
//                                       //           : '0.00',
//                                       //       style: theme.textTheme.bodyText1
//                                       //           ?.copyWith(
//                                       //               color: Colors.black54)),
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: widget.custHeight * 0.01,
//                           ),
//                           SizedBox(
//                             width: widget.custWidth,
//                             // color: Colors.green,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 SizedBox(
//                                   width: widget.custWidth * 0.465,
//                                   //  color: Colors.green,
//                                   // height: custHeight * 0.02,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         child: Text("Code#",
//                                             style: theme.textTheme.bodyLarge
//                                                 ?.copyWith(
//                                                     color: Colors.black54)),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(
//                                           right: widget.custWidth * 0.02,
//                                         ),
//                                         child: Text(
//                                             "${context.watch<PosController>().getselectedcust!.cardCode}",
//                                             style: theme.textTheme.bodyLarge
//                                                 ?.copyWith(
//                                                     color: Colors.black54)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   alignment: Alignment.centerRight,
//                                   width: widget.custWidth * 0.465,
//                                   // color: Colors.red,
//                                   // height: custHeight * 0.02,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         child: Text("Points",
//                                             style: theme.textTheme.bodyLarge
//                                                 ?.copyWith(
//                                                     color: Colors.black54)),
//                                       ),
//                                       Container(
//                                         child: Text(
//                                             context
//                                                     .read<PosController>()
//                                                     .getselectedcust!
//                                                     .point!
//                                                     .isNotEmpty
//                                                 ? "${context.watch<PosController>().getselectedcust!.point}"
//                                                 : "",
//                                             style: theme.textTheme.bodyLarge
//                                                 ?.copyWith(
//                                                     color: Colors.black54)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: widget.custHeight * 0.01,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               InkWell(
//                                 onTap: () async {
//                                   // setState(() {

//                                   // context
//                                   //     .read<PosController>()
//                                   //     .getcustaddresslist();
//     context
//                                       .read<PosController>()
//                                       .clearTextField();
//                                   await context
//                                       .read<PosController>()
//                                       .getCustDetFDB();
//                                   await context
//                                       .read<PosController>()
//                                       .billaddresslist();
//                                   billAddress(context);
//                                   context
//                                       .read<PosController>()
//                                       .disableKeyBoard(context);

//                                   // });
//                                 },
//                                 child: SizedBox(
//                                   width: widget.custWidth * 0.465,
//                                   // color: Colors.red,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: widget.custWidth * 0.465,
//                                         padding: EdgeInsets.only(
//                                             right: widget.custWidth * 0.02),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Container(
//                                                 child: Text(
//                                               "Billing Address",
//                                               style: theme.textTheme.bodyLarge
//                                                   ?.copyWith(
//                                                       color: Colors.black54),
//                                             )),
//                                             SizedBox(
//                                                 width: widget.custWidth * 0.04,
//                                                 child: Icon(
//                                                   Icons.arrow_drop_down,
//                                                   size: 30,
//                                                 ))
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                           child: Text(
//                                         " ${context.read<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address1 != null ? context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address1.toString() : ""},"
//                                         "${context.read<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address2 != null ? context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address2.toString() : ""},"
//                                         " ${context.read<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address3 != null ? context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedBillAdress!].address3.toString() : ""},",
//                                         maxLines: 1,
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54),
//                                       )),
//                                       Container(
//                                           child: Text(
//                                         context
//                                                 .read<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .read<PosController>()
//                                                     .getselectedBillAdress!]
//                                                 .billCity
//                                                 .isNotEmpty
//                                             ? context
//                                                 .watch<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .watch<PosController>()
//                                                     .getselectedBillAdress!]
//                                                 .billCity
//                                                 .toString()
//                                             : "",
//                                         maxLines: 1,
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54),
//                                       )),
//                                       Container(
//                                           child: Text(
//                                         context
//                                                 .read<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .read<PosController>()
//                                                     .getselectedBillAdress!]
//                                                 .billPincode
//                                                 .isNotEmpty
//                                             ? context
//                                                 .watch<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .watch<PosController>()
//                                                     .getselectedBillAdress!]
//                                                 .billPincode
//                                                 .toString()
//                                             : '',
//                                         maxLines: 1,
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54),
//                                       )),
//                                       Container(
//                                           child: Text(
//                                         context
//                                                 .read<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .read<PosController>()
//                                                     .getselectedBillAdress!]
//                                                 .billstate
//                                                 .isNotEmpty
//                                             ? context
//                                                 .watch<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .watch<PosController>()
//                                                     .getselectedBillAdress!]
//                                                 .billstate
//                                                 .toString()
//                                             : '',
//                                         maxLines: 1,
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54),
//                                       )),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () async {
//                                   context
//                                       .read<PosController>().clearTextField();
//                                   await context
//                                       .read<PosController>()
//                                       .getCustDetFDB();

//                                   await context
//                                       .read<PosController>()
//                                       .shippinfaddresslist();
//                                   sipaddress(context);

//                                   context
//                                       .read<PosController>()
//                                       .disableKeyBoard(context);
//                                 },
//                                 child: SizedBox(
//                                   width: widget.custWidth * 0.465,
//                                   //color: Colors.green,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: widget.custWidth * 0.465,
//                                         padding: EdgeInsets.only(
//                                             right: widget.custWidth * 0.02),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Container(
//                                                 child: Text(
//                                               "Shipping Address",
//                                               maxLines: 2,
//                                               style: theme.textTheme.bodyLarge
//                                                   ?.copyWith(
//                                                       color: Colors.black54),
//                                             )),
//                                             SizedBox(
//                                                 width: widget.custWidth * 0.04,
//                                                 child: Icon(
//                                                   Icons.arrow_drop_down,
//                                                   size: 30,
//                                                 ))
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                           child: Text(
//                                         "${context.read<PosController>().getselectedcust!.address![context.read<PosController>().getselectedShipAdress!].address1 != null ? context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedShipAdress!].address1.toString() : ""},"
//                                         "${context.read<PosController>().getselectedcust!.address![context.read<PosController>().getselectedShipAdress!].address2 != null ? context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedShipAdress!].address2.toString() : ""},"
//                                         " ${context.read<PosController>().getselectedcust!.address![context.read<PosController>().getselectedShipAdress!].address3 != null ? context.watch<PosController>().getselectedcust!.address![context.watch<PosController>().getselectedShipAdress!].address3.toString() : ""},",

//                                         // '${  context.watch<PosController>().getselectedcust!.address![  context.watch<PosController>().getselectedShipAdress!].address1.toString()},' +
//                                         //     '${  context.watch<PosController>().getselectedcust!.address![  context.watch<PosController>().getselectedShipAdress!].address2.toString()},' +
//                                         //     context.watch<PosController>()
//                                         //         .getselectedcust!
//                                         //         .address![context.watch<PosController>()
//                                         //             .getselectedShipAdress!]
//                                         //         .address3
//                                         //         .toString(),
//                                         maxLines: 1,
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54),
//                                       )),
//                                       Container(
//                                           child: Text(
//                                         context
//                                                 .read<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .read<PosController>()
//                                                     .getselectedShipAdress!]
//                                                 .billCity
//                                                 .isNotEmpty
//                                             ? context
//                                                 .watch<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .watch<PosController>()
//                                                     .getselectedShipAdress!]
//                                                 .billCity
//                                                 .toString()
//                                             : '',
//                                         maxLines: 1,
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54),
//                                       )),
//                                       Container(
//                                           child: Text(
//                                         context
//                                                 .read<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .read<PosController>()
//                                                     .getselectedShipAdress!]
//                                                 .billPincode
//                                                 .isNotEmpty
//                                             ? context
//                                                 .watch<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .watch<PosController>()
//                                                     .getselectedShipAdress!]
//                                                 .billPincode
//                                                 .toString()
//                                             : '',
//                                         maxLines: 1,
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54),
//                                       )),
//                                       Container(
//                                           child: Text(
//                                         context
//                                                 .read<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .read<PosController>()
//                                                     .getselectedShipAdress!]
//                                                 .billstate
//                                                 .isNotEmpty
//                                             ? context
//                                                 .watch<PosController>()
//                                                 .getselectedcust!
//                                                 .address![context
//                                                     .watch<PosController>()
//                                                     .getselectedShipAdress!]
//                                                 .billstate
//                                                 .toString()
//                                             : '',
//                                         maxLines: 1,
//                                         style: theme.textTheme.bodyLarge
//                                             ?.copyWith(color: Colors.black54),
//                                       )),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//         ],
//       ),
//     );
//   }

//   forSearchBtn(BuildContext context) {
//     final theme = Theme.of(context);
//     return StatefulBuilder(builder: (context, st) {
//       return Container(
//         padding: EdgeInsets.only(
//             top: widget.custHeight * 0.05,
//             left: widget.custHeight * 0.05,
//             right: widget.custHeight * 0.05,
//             bottom: widget.custHeight * 0.05),
//         color: Colors.white,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               width: widget.custWidth * 1.1,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
//                 borderRadius: BorderRadius.circular(3),
//                 color: Colors.grey.withOpacity(0.01),
//               ),
//               child: TextFormField(
//                 controller: context.read<PosController>().searchcontroller,
//                 textCapitalization: TextCapitalization.sentences,
//                 cursorColor: Colors.grey,
//                 onChanged: (v) {
//                   st(() {
//                     context.read<PosController>().filterList(v);
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Search customer..!!',
//                   hintStyle:
//                       theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
//                   enabledBorder: InputBorder.none,
//                   focusedBorder: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(
//                     vertical: 12,
//                     horizontal: 25,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: widget.custHeight * 0.05),
//             SizedBox(
//                 height: widget.custHeight * 1.5,
//                 width: widget.custWidth * 1.1,
//                 child: ListView.builder(
//                     itemCount:
//                         context.read<PosController>().getfiltercustList.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         child: Container(
//                           padding: EdgeInsets.only(
//                               top: widget.custHeight * 0.01,
//                               left: widget.custHeight * 0.01,
//                               right: widget.custHeight * 0.01,
//                               bottom: widget.custHeight * 0.03),
//                           // height: custHeight * 0.2,
//                           child: ListTile(
//                             onTap: () {
//                               st(() {
//                                 context.read<PosController>().custSelected(
//                                       context
//                                           .read<PosController>()
//                                           .getfiltercustList[index],
//                                       context,
//                                     );
//                               });

//                               Navigator.pop(context);
//                             },
//                             title: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Text(context
//                                           .watch<PosController>()
//                                           .getfiltercustList[index]
//                                           .cardCode!),
//                                     ),
//                                     Container(
//                                       child: Text(context
//                                           .watch<PosController>()
//                                           .config
//                                           .splitValues(context
//                                               .watch<PosController>()
//                                               .getfiltercustList[index]
//                                               .accBalance!
//                                               .toString())),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       child: Text(context
//                                           .watch<PosController>()
//                                           .getfiltercustList[index]
//                                           .name!),
//                                     ),
//                                     Container(
//                                       child: Text(context
//                                           .watch<PosController>()
//                                           .getfiltercustList[index]
//                                           .phNo!),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     })),
//             SizedBox(height: widget.custHeight * 0.09),
//           ],
//         ),
//       );
//     });
//   }

//   forAddNewBtn(
//     BuildContext context,
//   ) {
//     final theme = Theme.of(context);
//     return StatefulBuilder(builder: (context, st) {
//       return Container(
//         padding: EdgeInsets.only(
//             top: widget.custHeight * 0.1,
//             left: widget.custHeight * 0.1,
//             right: widget.custHeight * 0.1,
//             bottom: widget.custHeight * 0.02),
//         width: widget.custWidth * 1.1,
//         height: widget.custHeight * 1.5,
//         // color: Colors.red,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Form(
//                 key: context.read<PosController>().formkey[6],
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: widget.custHeight * 0.03,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         autofocus: true,
//                 textCapitalization: TextCapitalization.sentences,

//                         // readOnly: true,
//                         controller:
//                             context.read<PosController>().mycontroller[3],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Customer Code";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Customer Code',
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: widget.custHeight * 0.03,
//                     ),
//                     Container(
//                       // height: custHeight * 0.15,
//                       // width: custWidth * 1,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         autofocus: true,
//                         keyboardType: TextInputType.number,
//                         controller:
//                             context.read<PosController>().mycontroller[4],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         // validator: (value) {
//                         //   if (value!.isEmpty) {
//                         //     return "Please Enter the Mobile Number";
//                         //   } else {
//                         //     return null;
//                         //   }
//                         // },
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Mobile Number";
//                           } else if (value.length < 10) {
//                             return "Please Enter the 10 Digit Mobile Number";
//                           } else {
//                             return null;
//                           }
//                         },
//                         maxLength: 10,
//                         decoration: InputDecoration(
//                           counterText: '',
//                           labelText: 'Mobile Number',
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: widget.custHeight * 0.03,
//                     ),
//                     Container(
//                       // width: custWidth * 1,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         autofocus: true,
//                         controller:
//                             context.read<PosController>().mycontroller[5],
//                 textCapitalization: TextCapitalization.sentences,

//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},

//                         decoration: InputDecoration(
//                           labelText: "Gst",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: widget.custHeight * 0.09,
//                     ),
//                     Container(
//                       // height: custHeight * 0.15,
//                       // width: custWidth * 1,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                 textCapitalization: TextCapitalization.sentences,

//                         controller:
//                             context.read<PosController>().mycontroller[6],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Name";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "Name",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: widget.custHeight * 0.02,
//                     ),
//                     //addreswidget
//                     AddressWidget(
//                       theme: theme,
//                       custHeight: widget.custHeight,
//                       custWidth: widget.custWidth,
//                     ),

//                     SizedBox(
//                       height: widget.custHeight * 0.02,
//                     ),
//                     Container(
//                       // height: custHeight * 0.15,
//                       // width: custWidth * 0.65,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         controller:
//                             context.read<PosController>().mycontroller[21],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Email Address";
//                           } else if (!RegExp(
//                                   r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                               .hasMatch(value)) {
//                             log("value::" + value.toString());
//                             return "Please Enter a Valid Email";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "Email",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   List<Widget> listContainersProduct(
//     BuildContext context,
//     ThemeData theme,
//   ) {
//     return List.generate(
//       context.watch<PosController>().custList2.length,
//       (ind) {
//         return TopCustomer(ind: ind, theme: theme);
//       },
//     );
//   }
// }

// class TopCustomer extends StatelessWidget {
//   TopCustomer({
//     Key? key,
//     required this.ind,
//     required this.theme,
//   }) : super(key: key);
//   ThemeData theme;
//   int ind;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         print("Datatatat: ");
//         // print(posC.custList[ind].name);
//         context.read<PosController>().custSelected(
//               context.read<PosController>().custList2[ind],
//               context,
//             );
//       },
//       child: Container(
//         padding: EdgeInsets.all(5),
//         decoration: BoxDecoration(
//             color: theme.primaryColor,
//             border: Border.all(color: theme.primaryColor, width: 1),
//             borderRadius: BorderRadius.circular(5)),
//         child: Text(context.watch<PosController>().custList2[ind].name!,
//             textAlign: TextAlign.center,
//             style: theme.textTheme.bodyLarge?.copyWith(
//               fontWeight: FontWeight.normal,
//               fontSize: 16,
//               color: Colors.white,
//             )),
//       ),
//     );
//   }
// }

// Widget updateType(BuildContext context, int i, int ij) {
//   final theme = Theme.of(context);
//   return StatefulBuilder(builder: (context, st) {
//     return SizedBox(
//       width: Screens.width(context) * 0.8,
//       //  height: Screens.padingHeight(context) * 0.4,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             alignment: Alignment.center,
//             height: Screens.padingHeight(context) * 0.05,
//             decoration: BoxDecoration(
//               color: theme.primaryColor,
//               // borderRadius: BorderRadius.only(
//               //     topLeft: Radius.circular(5), topRight: Radius.circular(5))
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   // color: Colors.red,
//                   width: Screens.width(context) * 0.4,
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Confirm update",
//                     textAlign: TextAlign.center,
//                     style: theme.textTheme.bodyLarge
//                         ?.copyWith(color: Colors.white),
//                   ),
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.close,
//                       size: Screens.padingHeight(context) * 0.025,
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: Screens.bodyheight(context) * 0.02,
//           ),
//           Container(
//             width: Screens.width(context) * 0.8,
//             padding: EdgeInsets.symmetric(
//               vertical: Screens.padingHeight(context) * 0.01,
//               horizontal: Screens.width(context) * 0.01,
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   child: Text(
//                       "Do you want to update this customer for this sale or update to server..!!"),
//                 ),
//                 SizedBox(
//                   height: Screens.bodyheight(context) * 0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: Screens.width(context) * 0.3,
//                       child: ElevatedButton(
//                           onPressed: () {
//                             st(() {
//                               Navigator.pop(context);
//                               context
//                                   .read<PosController>()
//                                   .updateCustomer(context, i, ij);
//                               Navigator.pop(context);
//                             });
//                           },
//                           child: Text("Update to server")),
//                     ),
//                     SizedBox(
//                         width: Screens.width(context) * 0.3,
//                         child: ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               context
//                                   .read<PosController>()
//                                   .updateCustomer(context, i, ij);
//                               Navigator.pop(context);
//                             },
//                             child: Text("This sale"))),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   });
// }

// billAddress( BuildContext context,) async {
//   final theme = Theme.of(context);
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             contentPadding: EdgeInsets.all(0),
//             content: AlertBox(
//               payMent: 'Address',
//               widget: Container(
//                 padding: EdgeInsets.symmetric(
//                   vertical: Screens.padingHeight(context) * 0.01,
//                   horizontal: Screens.width(context) * 0.01,
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: Screens.padingHeight(context) * 0.3,
//                       width: Screens.width(context) * 0.45,
//                       padding: EdgeInsets.symmetric(
//                         vertical: Screens.padingHeight(context) * 0.01,
//                         horizontal: Screens.width(context) * 0.01,
//                       ),
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: context
//                             .watch<PosController>()
//                             .billadrrssItemlist
//                             .length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return InkWell(
//                             onTap: () {
//                               context
//                                   .read<PosController>()
//                                   .changeBillAddress(index);
//                               Navigator.pop(context);
//                             },
//                             child: Card(
//                                 child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                       vertical:
//                                           Screens.padingHeight(context) * 0.01,
//                                       horizontal: Screens.width(context) * 0.01,
//                                     ),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         //             ListTile(
//                                         //   title: Text( pos.selectedcust!.address[index].billAddress,
//                                         //       style: theme.textTheme.bodySmall),
//                                         //   onTap: () {
//                                         //     pos.changeBillAddress(index);
//                                         //     //pos.selectedcust!.address[pos.selectedAdress].billAddress = pos.selectedcust!.address[index].billAddress;
//                                         //     Navigator.pop(context);
//                                         //   },
//                                         // ),
//                                         Container(

//                                           child: Text(
//                                               "${context.watch<PosController>().billadrrssItemlist[index].address1 ?? ''},"
//                                               "${context.watch<PosController>().billadrrssItemlist[index].address2 ?? ''},"
//                                               "${context.watch<PosController>().billadrrssItemlist[index].address3 ?? ''}"),
//                                         ),
//                                         Container(
//                                           child: Text(
//                                               "${context.watch<PosController>().billadrrssItemlist[index].billCity}"),
//                                         ),
//                                         Container(
//                                           child: Text(
//                                               "${context.watch<PosController>().billadrrssItemlist[index].billPincode}"),
//                                         ),
//                                         Container(
//                                           child: Text(
//                                               "${context.watch<PosController>().billadrrssItemlist[index].billstate}"),
//                                         )
//                                       ],
//                                     ))),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               buttonName: "Create Address",
//               callback: () {
//                 Navigator.pop(context);
//                 createBillAddress(
//                   context,
//                   theme,
//                 );
//               },
//             ));
//       });
// }

// sipaddress(BuildContext context,) async {
//   final theme = Theme.of(context);
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             contentPadding: EdgeInsets.all(0),
//             content: AlertBox(
//               payMent: 'Address',
//               widget: Container(
//                 padding: EdgeInsets.symmetric(
//                   vertical: Screens.padingHeight(context) * 0.01,
//                   horizontal: Screens.width(context) * 0.01,
//                 ),
//                 height: Screens.padingHeight(context) * 0.3,
//                 width: Screens.width(context) * 0.45,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount:
//                       context.watch<PosController>().shipadrrssItemlist.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return InkWell(
//                       onTap: () {
//                         context.read<PosController>().changeShipAddress(index);
//                         Navigator.pop(context);
//                       },
//                       child: Card(
//                           child: Container(
//                               padding: EdgeInsets.symmetric(
//                                 vertical: Screens.padingHeight(context) * 0.01,
//                                 horizontal: Screens.width(context) * 0.01,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     child: Text(
//                                         "${context.watch<PosController>().shipadrrssItemlist[index].address1 ?? ''}${context.watch<PosController>().getselectedcust!.address![index].address2 ?? ''}${context.watch<PosController>().getselectedcust!.address![index].address3 ?? ''}"),
//                                   ),
//                                   Container(
//                                     child: Text(context
//                                                 .read<PosController>()
//                                                 .shipadrrssItemlist[index]
//                                                 .billCity !=
//                                             null
//                                         ? context
//                                             .watch<PosController>()
//                                             .shipadrrssItemlist[index]
//                                             .billCity
//                                         : ""),
//                                   ),
//                                   Container(
//                                     child: Text(context
//                                                 .read<PosController>()
//                                                 .shipadrrssItemlist[index]
//                                                 .billPincode !=
//                                             null
//                                         ? "${context.watch<PosController>().shipadrrssItemlist[index].billPincode}"
//                                         : ""),
//                                   ),
//                                   Container(
//                                     child: Text(
//                                         "${context.watch<PosController>().shipadrrssItemlist[index].billstate}"),
//                                   )
//                                   //             ListTile(
//                                   //   title: Text(pos.selectedcust!.address[index].shipAddress,
//                                   //       style: theme.textTheme.bodySmall),
//                                   //   onTap: () {
//                                   //     pos.changeShipAddress(index);
//                                   //     // pos.selectedcust!.address[0].shipAddress =
//                                   //     //     pos.selectedcust!.address[index].shipAddress;
//                                   //     Navigator.pop(context);
//                                   //   },
//                                   // ),
//                                   // Container(
//                                   //   child: Text(
//                                   //       "${pos.getselectedcust!.address![index].shipAddress}"),
//                                   // ),
//                                   // Container(
//                                   //   child: Text(
//                                   //       "${pos.getselectedcust!.address![index].shipCity}"),
//                                   // ),
//                                   // Container(
//                                   //   child: Text(
//                                   //       "${pos.getselectedcust!.address![index].shipPincode}"),
//                                   // ),
//                                   // Container(
//                                   //   child: Text(
//                                   //       "${pos.getselectedcust!.address![index].shipstate}"),
//                                   // )
//                                 ],
//                               ))),
//                     );
//                   },
//                 ),
//               ),
//               buttonName: "Create Address",
//               callback: () {
//                 Navigator.pop(context);

//                 createShippAddress(
//                   context,
//                   theme,
//                 );
//               },
//             ));
//       });
// }

// createAddress(
//   BuildContext context,
//   ThemeData theme,
// ) async {
//   final theme = Theme.of(context);
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             contentPadding: EdgeInsets.all(0),
//             content: AlertBox(
//               payMent: 'Create Address',
//               widget: createAddressMethod(
//                 theme,
//                 context,
//               ),
//               buttonName: "Save",
//               callback: () {
//                 context
//                     .read<PosController>()
//                     .insertnewaddresscreation(context, theme);

//                 // context.read<PosController>().createadd(context);
//               },
//             ));
//       });
// }

// createBillAddress(BuildContext context, ThemeData theme) async {
//   final theme = Theme.of(context);
//   context.read<PosController>().checkboxx = false;
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             contentPadding: EdgeInsets.all(0),
//             content: AlertBox(
//               payMent: 'Create Address',
//               widget: createBillAddressMethod(theme, context),
//               buttonName: "Save",
//               callback: () {
//                 context
//                     .read<PosController>()
//                     .insertnewaddresscreation(context, theme);
//                 Navigator.pop(context);

//               },
//             ));
//       });
// }

// createShippAddress(BuildContext context, ThemeData theme) async {
//   final theme = Theme.of(context);
//   context.read<PosController>().checkboxx = false;
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             contentPadding: EdgeInsets.all(0),
//             content: AlertBox(
//               payMent: 'Create Address',
//               widget: createShipAddressMethod(theme, context),
//               buttonName: "Save",
//               callback: () async {
//                 await context
//                     .read<PosController>()
//                     .insertnewshipaddresscreation(context, theme);

//               },
//             ));
//       });
// }

// Container createAddressMethod(
//   ThemeData theme,
//   BuildContext context,
// ) {
//   return Container(
//     width: Screens.width(context) * 0.7,
//     height: Screens.padingHeight(context) * 0.4,
//     padding: EdgeInsets.symmetric(
//       horizontal: Screens.width(context) * 0.02,
//       vertical: Screens.padingHeight(context) * 0.02,
//     ),
//     child: SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           AddressWidget(
//             theme: theme,
//             custHeight: Screens.width(context) * 0.4,
//             custWidth: Screens.width(context) * 0.7,
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Container createBillAddressMethod(ThemeData theme, BuildContext context) {
//   context.read<PosController>().checkboxx = false;
//   return Container(
//     width: Screens.width(context) * 0.5,
//     height: Screens.padingHeight(context) * 0.51,
//     padding: EdgeInsets.symmetric(
//       horizontal: Screens.width(context) * 0.02,
//       vertical: Screens.padingHeight(context) * 0.02,
//     ),
//     child: SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           BillAddressWidget(
//             theme: theme,
//             custHeight: Screens.width(context) * 0.4,
//             custWidth: Screens.width(context) * 0.7,
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Container createShipAddressMethod(ThemeData theme, BuildContext context) {
//   context.read<PosController>().checkboxx = false;
//   return Container(
//     width: Screens.width(context) * 0.5,
//     height: Screens.padingHeight(context) * 0.51,
//     padding: EdgeInsets.symmetric(
//       horizontal: Screens.width(context) * 0.02,
//       vertical: Screens.padingHeight(context) * 0.02,
//     ),
//     child: SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ShipAddressWidget(
//             theme: theme,
//             custHeight: Screens.width(context) * 0.4,
//             custWidth: Screens.width(context) * 0.7,
//           ),
//         ],
//       ),
//     ),
//   );
// }

// class AddressWidget extends StatelessWidget {
//   const AddressWidget(
//       {Key? key,
//       required this.theme,
//       required this.custHeight,
//       required this.custWidth})
//       : super(key: key);

//   final ThemeData theme;
//   final double custHeight;
//   final double custWidth;

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, st) {
//       return Column(
//         children: [
//           Form(
//             key: context.read<PosController>().formkeyAd,
//             // SizedBox(
//             //   height: custHeight * 0.02,
//             // ),

//             child: Container(
//               // height: custHeight * 0.15,
//               // width: custWidth * 1,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(3),
//                 color: Colors.grey.withOpacity(0.01),
//               ),

//               child: TextFormField(
//                 autofocus: true,
//                 controller: context.read<PosController>().mycontroller[7],
//                 textCapitalization: TextCapitalization.sentences,
//                 cursorColor: Colors.grey,
//                 style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
//                 onChanged: (v) {},
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "Please Enter the Address1";
//                   } else {
//                     return null;
//                   }
//                 },
//                 decoration: InputDecoration(
//                   labelText: "Bill Address1",
//                   filled: false,
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: BorderSide(color: Colors.red),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: BorderSide(color: Colors.red),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(
//                     vertical: 5,
//                     horizontal: 10,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Container(
//             // height: custHeight * 0.15,
//             // width: custWidth * 1,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(3),
//               color: Colors.grey.withOpacity(0.01),
//             ),
//             child: TextFormField(
//               controller: context.read<PosController>().mycontroller[8],
//                 textCapitalization: TextCapitalization.sentences,

//               cursorColor: Colors.grey,
//               style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
//               onChanged: (v) {},
//               // validator: (value) {
//               //   if (value!.isEmpty) {
//               //     return "Please Enter the Address2";
//               //   } else {
//               //     return null;
//               //   }
//               // },
//               decoration: InputDecoration(
//                 labelText: "Bill Address2",
//                 filled: false,
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 5,
//                   horizontal: 10,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Container(
//             // height: custHeight * 0.15,
//             // width: custWidth * 1,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(3),
//               color: Colors.grey.withOpacity(0.01),
//             ),
//             child: TextFormField(
//               controller: context.read<PosController>().mycontroller[9],
//               textCapitalization: TextCapitalization.sentences,

//               cursorColor: Colors.grey,
//               style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
//               onChanged: (v) {},
//               // validator: (value) {
//               //   if (value!.isEmpty) {
//               //     return "Please Enter the Address3";
//               //   } else {
//               //     return null;
//               //   }
//               // },
//               decoration: InputDecoration(
//                 labelText: "Bill Address3",
//                 filled: false,
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.red),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 5,
//                   horizontal: 10,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 // height: custHeight * 0.15,
//                 width: custWidth * 0.45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   controller: context.read<PosController>().mycontroller[10],
//                   textCapitalization: TextCapitalization.sentences,
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the City Name";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: "City",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 // height: custHeight * 0.15,
//                 width: custWidth * 0.45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   controller: context.read<PosController>().mycontroller[11],
//                   textCapitalization: TextCapitalization.sentences,
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the Pin Code";
//                     } else if (value.length < 6) {
//                       return "Please Enter 6 Digit Pin Code";
//                     } else {
//                       return null;
//                     }
//                   },
//                   maxLength: 6,
//                   decoration: InputDecoration(
//                     counterText: '',
//                     labelText: "Pin Code",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 // height: custHeight * 0.15,
//                 width: custWidth * 0.45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   controller: context.read<PosController>().mycontroller[12],
//                   textCapitalization: TextCapitalization.sentences,
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the State";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: "State",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 // height: custHeight * 0.15,
//                 width: custWidth * 0.45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   // readOnly: true,
//                   controller: context.read<PosController>().mycontroller[13],
//                   textCapitalization: TextCapitalization.sentences,

//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the Country";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Country",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 alignment: Alignment.centerLeft,
//                 height: custHeight * 0.1,
//                 child: Text("Copy As Ship Address"),
//               ),
//               SizedBox(
//                 width: custWidth * 0.2,
//               ),
//               Checkbox(
//                   side: BorderSide(color: Colors.grey),
//                   activeColor: Colors.green,
//                   value: context.read<PosController>().checkboxx,
//                   onChanged: (val) {
//                     st(() {
//                       context.read<PosController>().checkboxx = val!;
//                       context.read<PosController>().billToShip(val);
//                     });
//                   }),
//             ],
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   // height: custHeight * 0.15,
//                   // width: custWidth * 0.65,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(3),
//                     color: Colors.grey.withOpacity(0.01),
//                   ),
//                   child: TextFormField(
//                     // autofocus: true,
//                     controller: context.read<PosController>().mycontroller[14],
//                     textCapitalization: TextCapitalization.sentences,

//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyLarge
//                         ?.copyWith(color: Colors.black),
//                     onChanged: (v) {},
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please Enter the Ship Address1";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Ship Address1',
//                       filled: false,
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Container(
//                   // height: custHeight * 0.15,
//                   // width: custWidth * 0.65,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(3),
//                     color: Colors.grey.withOpacity(0.01),
//                   ),
//                   child: TextFormField(
//                     autofocus: true,
//                     controller: context.read<PosController>().mycontroller[15],
//                     textCapitalization: TextCapitalization.sentences,

//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyLarge
//                         ?.copyWith(color: Colors.black),
//                     onChanged: (v) {},
//                     // validator: (value) {
//                     //   if (value!.isEmpty) {
//                     //     return "Please Enter the Ship Address2";
//                     //   } else {
//                     //     return null;
//                     //   }
//                     // },
//                     decoration: InputDecoration(
//                       labelText: 'Ship Address2',
//                       filled: false,
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Container(
//                   // height: custHeight * 0.15,
//                   // width: custWidth * 0.65,
//                   decoration: BoxDecoration(
//                     border:
//                         Border.all(color: Color.fromARGB(255, 240, 235, 235)),
//                     borderRadius: BorderRadius.circular(3),
//                     color: Colors.grey.withOpacity(0.01),
//                   ),
//                   child: TextFormField(
//                     autofocus: true,
//                     controller: context.read<PosController>().mycontroller[16],
//                     textCapitalization: TextCapitalization.sentences,

//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyLarge
//                         ?.copyWith(color: Colors.black),
//                     onChanged: (v) {},
//                     // validator: (value) {
//                     //   if (value!.isEmpty) {
//                     //     return "Please Enter the Ship Address3";
//                     //   } else {
//                     //     return null;
//                     //   }
//                     // },
//                     decoration: InputDecoration(
//                       labelText: "Ship Address3",
//                       filled: false,
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 // height: custHeight * 0.15,
//                 width: custWidth * 0.45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   controller: context.read<PosController>().mycontroller[17],
//                   textCapitalization: TextCapitalization.sentences,
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the City Name";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: "City",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 // height: custHeight * 0.15,
//                 width: custWidth * 0.45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   controller: context.read<PosController>().mycontroller[18],
//                   textCapitalization: TextCapitalization.sentences,
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the Pin Code";
//                     } else if (value.length < 6) {
//                       return "Please Enter 6 Digit Pin Code";
//                     } else {
//                       return null;
//                     }
//                   },
//                   maxLength: 6,
//                   decoration: InputDecoration(
//                     counterText: '',
//                     labelText: "Pin Code",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 // height: custHeight * 0.15,
//                 width: custWidth * 0.45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   textCapitalization: TextCapitalization.sentences,
//                   controller: context.read<PosController>().mycontroller[19],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the State";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     labelText: "State",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 // height: custHeight * 0.15,
//                 width: custWidth * 0.45,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   // readOnly: true,
//                   textCapitalization: TextCapitalization.sentences,
//                   controller: context.read<PosController>().mycontroller[20],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the Country";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Country",
//                     filled: false,
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     focusedErrorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       borderSide: BorderSide(color: Colors.grey),
//                     ),
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       );
//     });
//   }
// }

// class BillAddressWidget extends StatelessWidget {
//   const BillAddressWidget(
//       {Key? key,
//       required this.theme,
//       required this.custHeight,
//       required this.custWidth})
//       : super(key: key);

//   final ThemeData theme;
//   final double custHeight;
//   final double custWidth;

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, st) {
//       return Column(
//         children: [
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Form(
//             key: context.read<PosController>().formkeyAd,
//             child: Column(
//               children: [
//                 Container(
//                   // height: custHeight * 0.15,
//                   // width: custWidth * 0.75,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(3),
//                     color: Colors.grey.withOpacity(0.01),
//                   ),
//                   child: TextFormField(
//                     autofocus: true,
//                     textCapitalization: TextCapitalization.sentences,
//                     controller: context.read<PosController>().mycontroller[7],
//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyLarge
//                         ?.copyWith(color: Colors.black),
//                     onChanged: (v) {},
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please Enter the Address1";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: "Bill Address1",
//                       filled: false,
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Container(
//                   // height: custHeight * 0.15,
//                   // width: custWidth * 0.75,

//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(3),
//                     color: Colors.grey.withOpacity(0.01),
//                   ),
//                   child: TextFormField(
//                     textCapitalization: TextCapitalization.sentences,
//                     controller: context.read<PosController>().mycontroller[8],
//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyLarge
//                         ?.copyWith(color: Colors.black),
//                     onChanged: (v) {},
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please Enter the Address2";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: "Bill Address2",
//                       filled: false,
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Container(
//                   // height: custHeight * 0.15,
//                   // width: custWidth * 0.75,

//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(3),
//                     color: Colors.grey.withOpacity(0.01),
//                   ),
//                   child: TextFormField(
//                     textCapitalization: TextCapitalization.sentences,
//                     controller: context.read<PosController>().mycontroller[9],
//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyLarge
//                         ?.copyWith(color: Colors.black),
//                     onChanged: (v) {},
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please Enter the Address3";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       labelText: "Bill Address3",
//                       filled: false,
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedErrorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(color: Colors.grey),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 5,
//                         horizontal: 10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // height: custHeight * 0.15,
//                       width: custWidth * 0.32,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         controller:
//                             context.read<PosController>().mycontroller[10],
//                         textCapitalization: TextCapitalization.sentences,
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the City Name";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "City",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // height: custHeight * 0.15,
//                       width: custWidth * 0.32,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller:
//                             context.read<PosController>().mycontroller[11],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Pin Code";
//                           } else if (value.length < 6) {
//                             return "Please Enter 6 Digit Pin Code";
//                           } else {
//                             return null;
//                           }
//                         },
//                         maxLength: 6,
//                         decoration: InputDecoration(
//                           counterText: '',
//                           labelText: "Pin Code",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // height: custHeight * 0.15,
//                       width: custWidth * 0.32,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         controller:
//                             context.read<PosController>().mycontroller[12],
//                         textCapitalization: TextCapitalization.sentences,
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the State";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "State",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // height: custHeight * 0.15,
//                       width: custWidth * 0.32,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         // readOnly: true,
//                         controller:
//                             context.read<PosController>().mycontroller[13],
//                         textCapitalization: TextCapitalization.sentences,

//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Country";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Country",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Row(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       height: custHeight * 0.1,
//                       child: Text("Copy As Ship Address"),
//                     ),
//                     SizedBox(
//                       width: custWidth * 0.1,
//                     ),
//                     Checkbox(
//                         side: BorderSide(color: Colors.grey),
//                         activeColor: Colors.green,
//                         value: context.watch<PosController>().checkboxx,
//                         onChanged: (val) {
//                           st(() {
//                             context.read<PosController>().checkboxx = val!;
//                             context.read<PosController>().billToShip(val);
//                           });
//                         }),
//                   ],
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }

// class ShipAddressWidget extends StatelessWidget {
//   const ShipAddressWidget(
//       {Key? key,
//       required this.theme,
//       required this.custHeight,
//       required this.custWidth})
//       : super(key: key);

//   final ThemeData theme;
//   final double custHeight;
//   final double custWidth;

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, st) {
//       return Column(
//         children: [
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           Form(
//             key: context.read<PosController>().formkeyShipAd,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         // height: custHeight * 0.15,
//                         // width: custWidth * 0.65,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(3),
//                           color: Colors.grey.withOpacity(0.01),
//                         ),
//                         child: TextFormField(
//                           autofocus: true,
//                           controller:
//                               context.read<PosController>().mycontroller[14],
//                           textCapitalization: TextCapitalization.sentences,
//                           cursorColor: Colors.grey,
//                           style: theme.textTheme.bodyLarge
//                               ?.copyWith(color: Colors.black),
//                           onChanged: (v) {},
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Please Enter the Ship Address1";
//                             } else {
//                               return null;
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Ship Address1',
//                             filled: false,
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.red),
//                             ),
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.red),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 5,
//                               horizontal: 10,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: custHeight * 0.02,
//                       ),
//                       Container(
//                         // height: custHeight * 0.15,
//                         // width: custWidth * 0.65,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(3),
//                           color: Colors.grey.withOpacity(0.01),
//                         ),
//                         child: TextFormField(
//                           controller:
//                               context.read<PosController>().mycontroller[15],
//                           textCapitalization: TextCapitalization.sentences,
//                           cursorColor: Colors.grey,
//                           style: theme.textTheme.bodyLarge
//                               ?.copyWith(color: Colors.black),
//                           onChanged: (v) {},
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Please Enter the Ship Address2";
//                             } else {
//                               return null;
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Ship Address2',
//                             filled: false,
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.red),
//                             ),
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.red),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 5,
//                               horizontal: 10,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: custHeight * 0.02,
//                       ),
//                       Container(
//                         // height: custHeight * 0.15,
//                         // width: custWidth * 0.65,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               color: Color.fromARGB(255, 240, 235, 235)),
//                           borderRadius: BorderRadius.circular(3),
//                           color: Colors.grey.withOpacity(0.01),
//                         ),
//                         child: TextFormField(
//                           autofocus: true,
//                           controller:
//                               context.read<PosController>().mycontroller[16],
//                           textCapitalization: TextCapitalization.sentences,
//                           cursorColor: Colors.grey,
//                           style: theme.textTheme.bodyLarge
//                               ?.copyWith(color: Colors.black),
//                           onChanged: (v) {},
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Please Enter the Ship Address3";
//                             } else {
//                               return null;
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: "Ship Address3",
//                             filled: false,
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.red),
//                             ),
//                             focusedErrorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.red),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(color: Colors.grey),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 5,
//                               horizontal: 10,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // height: custHeight * 0.15,
//                       width: custWidth * 0.32,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         controller:
//                             context.read<PosController>().mycontroller[17],
//                         textCapitalization: TextCapitalization.sentences,
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the City Name";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "City",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // height: custHeight * 0.15,
//                       width: custWidth * 0.32,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         controller:
//                             context.read<PosController>().mycontroller[18],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Pin Code";
//                           } else if (value.length < 6) {
//                             return "Please Enter 6 Digit Pin Code";
//                           } else {
//                             return null;
//                           }
//                         },
//                         maxLength: 6,
//                         decoration: InputDecoration(
//                           counterText: '',
//                           labelText: "Pin Code",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: custHeight * 0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // height: custHeight * 0.15,
//                       width: custWidth * 0.32,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         controller:
//                             context.read<PosController>().mycontroller[19],
//                         textCapitalization: TextCapitalization.sentences,
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the State";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           labelText: "State",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       // height: custHeight * 0.15,
//                       width: custWidth * 0.32,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         // readOnly: true,
//                         controller:
//                             context.read<PosController>().mycontroller[20],
//                         textCapitalization: TextCapitalization.sentences,
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyLarge
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Country";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Country",
//                           filled: false,
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                             borderSide: BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 5,
//                             horizontal: 10,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       height: custHeight * 0.1,
//                       child: Text("Copy As Bill Address"),
//                     ),
//                     SizedBox(
//                       width: custWidth * 0.1,
//                     ),
//                     Checkbox(
//                         side: BorderSide(color: Colors.grey),
//                         activeColor: Colors.green,
//                         value: context.watch<PosController>().checkboxx,
//                         onChanged: (val) {
//                           st(() {
//                             context.read<PosController>().checkboxx = val!;
//                             context.read<PosController>().shipToBill(val);
//                           });
//                         }),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
