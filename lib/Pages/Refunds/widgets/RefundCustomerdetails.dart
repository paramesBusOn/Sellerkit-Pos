// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, unnecessary_null_in_if_null_operators, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, prefer_if_null_operators, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Controller/RefundsController/RefundController.dart';

class RefundCustomerDetails extends StatefulWidget {
  RefundCustomerDetails(
      {Key? key,
      required this.theme,
      required this.custHeight,
      required this.custWidth})
      : super(key: key);

  final ThemeData theme;
  double custHeight;
  double custWidth;

  @override
  State<RefundCustomerDetails> createState() => _RefundCustomerDetailsState();
}

class _RefundCustomerDetailsState extends State<RefundCustomerDetails> {
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
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.read<RefundController>().selectedcust2 != null
              ? Container()
              : Container(
                  // width: custWidth * 0.7,
                  width: widget.custWidth * 1,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.001),
                  ),
                  child: StatefulBuilder(builder: (context, st) {
                    return TextFormField(
                      controller:
                          context.read<RefundController>().mycontroller[81],
                      onChanged: (v) {},
                      onEditingComplete: () {
                        st(() {
                          //  context.read<RefundController>().cardCodeScan(context, theme);
                          context.read<RefundController>().scancardcode(
                              context
                                  .read<RefundController>()
                                  .mycontroller[81]
                                  .text
                                  .toString()
                                  .trim()
                                  .toUpperCase(),
                              context,
                              theme);
                        });
                      },
                      decoration: InputDecoration(
                        // suffixIcon: IconButton(
                        //     onPressed: () {
                        //       context.read<RefundController>().clearTextField();
                        //       // context
                        //       //     .read<RefundController>()
                        //       //     .refreshfiltercust();
                        //       // showDialog(
                        //       //     context: context,
                        //       //     barrierDismissible: false,
                        //       //     builder: (BuildContext context) {
                        //       //       return AlertDialog(
                        //       //           contentPadding: EdgeInsets.all(0),
                        //       //           content: AlertBox(
                        //       //             payMent: 'Select Customer',
                        //       //             widget: forSearchBtn(context),
                        //       //             buttonName: "Add New",
                        //       //             callback: () {
                        //       //               Navigator.pop(context);
                        //       //               showDialog(
                        //       //                   context: context,
                        //       //                   barrierDismissible: false,
                        //       //                   builder:
                        //       //                       (BuildContext context) {
                        //       //                     return AlertDialog(
                        //       //                         contentPadding:
                        //       //                             EdgeInsets.all(0),
                        //       //                         content: AlertBox(
                        //       //                           payMent: 'New Customer',
                        //       //                           widget: forAddNewBtn(
                        //       //                               context),
                        //       //                           buttonName: "Save",
                        //       //                           callback: () {
                        //       //                             // context
                        //       //                             //     .read<
                        //       //                             //         RefundController>()
                        //       //                             //     .addnewCustomer(
                        //       //                             //         context, 6);
                        //       //                             // prdCD.addNewCus(context, 6);
                        //       //                           },
                        //       //                         ));
                        //       //                   });
                        //       //             },
                        //       //           ));
                        //       //     });
                        //     },

                        // size: custHeight * 0.08,
                        // color: Colors.grey,
                        // icon: Icon(Icons.search)),
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
                    );
                  }),
                ),
          SizedBox(
            height: widget.custHeight * 0.02,
          ),
          context.read<RefundController>().selectedcust2 != null
              ? Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.symmetric(
                      vertical: widget.custHeight * 0.02,
                      horizontal: widget.custWidth * 0.02),
                  // height: custHeight * 0.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                              .read<RefundController>()
                                              .getselectedcust2!
                                              .name !=
                                          null
                                      ? '${context.watch<RefundController>().getselectedcust2!.name}'
                                      : "",
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                              // InkWell(
                              //     onTap: () {
                              //       // prdCD.mapUpdateCustomer(
                              //       //     prdCD.getselectedCustomer);
                              //       // showDialog(
                              //       //     context: context,
                              //       //     barrierDismissible: false,
                              //       //     builder: (BuildContext context) {
                              //       //       return AlertDialog(
                              //       //           contentPadding: EdgeInsets.all(0),
                              //       //           content: AlertBox(
                              //       //             payMent: 'Update Customer',
                              //       //             widget: forAddNewBtn(
                              //       //                 context, prdCD),
                              //       //             buttonName: "Save",
                              //       //             callback: () {
                              //       //               showDialog(
                              //       //                   context: context,
                              //       //                   barrierDismissible: false,
                              //       //                   builder: (BuildContext
                              //       //                       context) {
                              //       //                     return AlertDialog(
                              //       //                       contentPadding:
                              //       //                           EdgeInsets.all(0),
                              //       //                       content: updateType(
                              //       //                           context,
                              //       //                           prdCD,
                              //       //                           prdCD
                              //       //                               .getselectedBillAdress!),
                              //       //                     );
                              //       //                   });
                              //       //             },
                              //       //           ));
                              //       //     });
                              //     },
                              // child: Container(
                              //   width: widget.custWidth * 0.06,
                              //   alignment: Alignment.center,
                              //   //     color: Colors.red,
                              //   child: Icon(Icons.edit),
                              // )),
                              // StatefulBuilder(builder: (context, st) {
                              //   return InkWell(
                              //       onTap: () {
                              //         st(() {
                              //           // context
                              //           //     .read<RefundController>()
                              //           //     .clearpayData();
                              //         });
                              //       },
                              //       child: Container(
                              //         width: widget.custWidth * 0.06,
                              //         alignment: Alignment.center,
                              //         //     color: Colors.blue,
                              //         child: Icon(Icons.close_sharp),
                              //       ));
                              // }),
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
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.black54,
                                      // size: custHeight * 0.05,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                        " ${context.watch<RefundController>().getselectedcust2!.phNo}  |  ",
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
                                    child: Icon(
                                      Icons.mail_outline,
                                      color: Colors.black54,
                                      // size: custHeight * 0.05,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                        " ${context.watch<RefundController>().getselectedcust2!.email}",
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: widget.custWidth * 0.465,
                              // height: custHeight * 0.02,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        "${context.watch<RefundController>().getselectedcust2!.tarNo}",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("Balance",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                      child: context
                                                  .read<RefundController>()
                                                  .getselectedcust2 !=
                                              null
                                          ? Text(
                                              "${context.read<RefundController>().config.splitValues(context.read<RefundController>().getselectedcust2!.accBalance!.toStringAsFixed(2))}",
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54))
                                          : null
                                      // Text(
                                      //     prdCD.onAccPayment
                                      //         .toString()
                                      //         .replaceAll(",", ""),
                                      //     style: theme.textTheme.bodyText1
                                      //         ?.copyWith(
                                      //             color: Colors.black54)),
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
                                        "${context.watch<RefundController>().getselectedcust2!.cardCode}",
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
                                    child: Text("Point",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    child: Text(
                                        "${context.watch<RefundController>().getselectedcust2!.point}",
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
                          InkWell(
                            onTap: () {
                              // prdCD.clearTextField();
                              // billAddress(context, prdCD);
                            },
                            child: SizedBox(
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
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: Text(
                                    // [prdCD.getselectedBillAdress!]
                                    "${context.watch<RefundController>().getselectedcust2!.address![0].address1.toString()}, " "${context.watch<RefundController>().getselectedcust2!.address![0].address2.toString()}, " +
                                        context
                                            .watch<RefundController>()
                                            .getselectedcust2!
                                            .address![0]
                                            .address3
                                            .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    context
                                        .watch<RefundController>()
                                        .getselectedcust2!
                                        .address![0]
                                        .billCity
                                        .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    context
                                        .watch<RefundController>()
                                        .getselectedcust2!
                                        .address![0]
                                        .billPincode
                                        .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    context
                                        .watch<RefundController>()
                                        .getselectedcust2!
                                        .address![0]
                                        .billstate
                                        .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // sipaddress(context, prdCD);
                            },
                            child: SizedBox(
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
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 30,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: Text(
                                    "${context.watch<RefundController>().getselectedcust2!.address![0].address1.toString()}, " "${context.watch<RefundController>().getselectedcust2!.address![0].address2.toString()}, " +
                                        context
                                            .watch<RefundController>()
                                            .getselectedcust2!
                                            .address![0]
                                            .address3
                                            .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    context
                                        .read<RefundController>()
                                        .getselectedcust2!
                                        .address![0]
                                        // [prdCD.getselectedBillAdress!]
                                        .billCity
                                        .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    context
                                        .watch<RefundController>()
                                        .getselectedcust2!
                                        .address![0]
                                        .billPincode
                                        .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    context
                                        .watch<RefundController>()
                                        .getselectedcust2!
                                        .address![0]
                                        .billstate
                                        .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black54),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : context.read<RefundController>().selectedcust == null
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          vertical: widget.custHeight * 0.02,
                          horizontal: widget.custWidth * 0.02),
                      child: Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: listContainersProduct(
                            context,
                            theme,
                          )),
                    )
                  : Container(
                      color: Colors.grey[50],
                      padding: EdgeInsets.symmetric(
                          vertical: widget.custHeight * 0.02,
                          horizontal: widget.custWidth * 0.02),
                      // height: custHeight * 0.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  .read<RefundController>()
                                                  .getselectedcust!
                                                  .name !=
                                              null
                                          ? '${context.watch<RefundController>().getselectedcust!.name}'
                                          : "",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 20),
                                    ),
                                  ),
                                  // InkWell(
                                  //     onTap: () {
                                  //       // context
                                  //       //     .read<RefundController>()
                                  //       //     .mapUpdateCustomer(context
                                  //       //         .read<RefundController>()
                                  //       //         .getselectedCustomer);
                                  //       showDialog(
                                  //           context: context,
                                  //           barrierDismissible: false,
                                  //           builder: (BuildContext context) {
                                  //             return AlertDialog(
                                  //                 contentPadding:
                                  //                     EdgeInsets.all(0),
                                  //                 content: AlertBox(
                                  //                   payMent: 'Update Customer',
                                  //                   widget:
                                  //                       forAddNewBtn(context),
                                  //                   buttonName: "Save",
                                  //                   callback: () {
                                  //                     showDialog(
                                  //                         context: context,
                                  //                         barrierDismissible:
                                  //                             false,
                                  //                         builder: (BuildContext
                                  //                             context) {
                                  //                           return AlertDialog(
                                  //                             contentPadding:
                                  //                                 EdgeInsets
                                  //                                     .all(0),
                                  //                             content: updateType(
                                  //                                 context,
                                  //                                 context
                                  //                                     .read<
                                  //                                         RefundController>()
                                  //                                     .getselectedBillAdress!),
                                  //                           );
                                  //                         });
                                  //                   },
                                  //                 ));
                                  //           });
                                  //     },
                                  //     child: Container(
                                  //       width: widget.custWidth * 0.06,
                                  //       alignment: Alignment.center,
                                  //       //     color: Colors.red,
                                  //       child: Icon(Icons.edit),
                                  //     )),
                                  // InkWell(
                                  //     onTap: () {
                                  //       // context
                                  //       //     .read<RefundController>()
                                  //       //     .clearpayData();
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
                                        child: Icon(
                                          Icons.phone,
                                          color: Colors.black54,
                                          // size: custHeight * 0.05,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                            " ${context.watch<RefundController>().getselectedcust!.phNo}  |  ",
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
                                        child: Icon(
                                          Icons.mail_outline,
                                          color: Colors.black54,
                                          // size: custHeight * 0.05,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                            " ${context.watch<RefundController>().getselectedcust!.email}",
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: widget.custWidth * 0.465,
                                  // height: custHeight * 0.02,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Gst",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: widget.custWidth * 0.02,
                                        ),
                                        child: Text(
                                            "${context.watch<RefundController>().getselectedcust!.tarNo}",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                          .read<
                                                              RefundController>()
                                                          .getselectedcust !=
                                                      null
                                                  ? context
                                                      .read<RefundController>()
                                                      .config
                                                      .splitValues(context
                                                          .read<
                                                              RefundController>()
                                                          .getselectedcust!
                                                          .accBalance
                                                          .toString())
                                                  : "",
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black54))

                                          // Text(
                                          //     prdCD.onAccPayment
                                          //         .toString()
                                          //         .replaceAll(",", ""),
                                          //     style: theme.textTheme.bodyText1
                                          //         ?.copyWith(
                                          //             color: Colors.black54)),
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
                                            "${context.watch<RefundController>().getselectedcust!.cardCode}",
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
                                        child: Text("Point",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    color: Colors.black54)),
                                      ),
                                      Container(
                                        child: Text(
                                            "${context.watch<RefundController>().getselectedcust!.point}",
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
                            children: [
                              InkWell(
                                onTap: () {
                                  context
                                      .read<RefundController>()
                                      .clearTextField();
                                  billAddress(context);
                                  // context
                                  //     .read<RefundController>()
                                  //     .disableKeyBoard(context);
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
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 30,
                                                ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                          child: Text(
                                        // [prdCD.getselectedBillAdress!]
                                        "${context.watch<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedBillAdress!].address1 != null ? context.read<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedBillAdress!].address1.toString() : ""} " "${context.read<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedBillAdress!].address2 != null ? context.read<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedBillAdress!].address2.toString() : ""} " "${context.read<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedBillAdress!].address3 != null ? context.read<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedBillAdress!].address3.toString() : ""}",
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                      Container(
                                          child: Text(
                                        context
                                            .read<RefundController>()
                                            .getselectedcust!
                                            .address![context
                                                .read<RefundController>()
                                                .getselectedBillAdress!]
                                            .billCity
                                            .toString(),
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                      Container(
                                          child: Text(
                                        context
                                            .read<RefundController>()
                                            .getselectedcust!
                                            .address![context
                                                .read<RefundController>()
                                                .getselectedBillAdress!]
                                            .billPincode
                                            .toString(),
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                      Container(
                                          child: Text(
                                        context
                                            .read<RefundController>()
                                            .getselectedcust!
                                            .address![context
                                                .read<RefundController>()
                                                .getselectedBillAdress!]
                                            .billstate
                                            .toString(),
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  sipaddress(context);
                                  // context
                                  //     .read<RefundController>()
                                  //     .disableKeyBoard(context);
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
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 30,
                                                ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                          child: Text(
                                        "${context.read<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedShipAdress!].address1 != null ? context.read<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedShipAdress!].address1.toString() : ""} " "${context.read<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedShipAdress!].address2 != null ? context.read<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedShipAdress!].address2.toString() : ""} " "${context.read<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedShipAdress!].address3 != null ? context.read<RefundController>().getselectedcust!.address![context.read<RefundController>().getselectedShipAdress!].address3.toString() : ""}",

                                        // "${prdCD.getselectedcust!.address![0].address1.toString()}, " +
                                        //     "${prdCD.getselectedcust!.address![0].address2.toString()}, " +
                                        //     prdCD.getselectedcust!.address![0]
                                        //         .address3
                                        //         .toString(),
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                      Container(
                                          child: Text(
                                        context
                                            .read<RefundController>()
                                            .getselectedcust!
                                            .address![context
                                                .read<RefundController>()
                                                .getselectedShipAdress!]
                                            // [prdCD.getselectedBillAdress!]
                                            .billCity
                                            .toString(),
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                      Container(
                                          child: Text(
                                        context
                                            .read<RefundController>()
                                            .getselectedcust!
                                            .address![context
                                                .read<RefundController>()
                                                .getselectedShipAdress!]
                                            .billPincode
                                            .toString(),
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
                                      Container(
                                          child: Text(
                                        context
                                            .read<RefundController>()
                                            .getselectedcust!
                                            .address![context
                                                .read<RefundController>()
                                                .getselectedShipAdress!]
                                            .billstate
                                            .toString(),
                                        maxLines: 1,
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.black54),
                                      )),
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
                border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                controller: context.read<RefundController>().mycontroller[2],
                cursorColor: Colors.grey,
                onChanged: (v) {
                  st(() {
                    // context.read<RefundController>().filtercustomerList(v);
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
                height: widget.custHeight * 1.5,
                width: widget.custWidth * 1.1,
                child: ListView.builder(
                    itemCount: context
                        .watch<RefundController>()
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
                          child: ListTile(
                            onTap: () {
                              context.read<RefundController>().custSelected(
                                  context
                                      .read<RefundController>()
                                      .getfiltercustList1[index],
                                  context,
                                  theme);
                              Navigator.pop(context);
                            },
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(context
                                          .read<RefundController>()
                                          .getfiltercustList1[index]
                                          .cardCode!),
                                    ),
                                    Container(
                                      child: Text(context
                                          .read<RefundController>()
                                          .config
                                          .splitValues(context
                                              .read<RefundController>()
                                              .getfiltercustList1[index]
                                              .accBalance!
                                              .toString())),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(context
                                          .watch<RefundController>()
                                          .getfiltercustList1[index]
                                          .name!),
                                    ),
                                    Container(
                                      child: Text(context
                                          .watch<RefundController>()
                                          .getfiltercustList1[index]
                                          .phNo!),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
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
        padding: EdgeInsets.only(
            top: widget.custHeight * 0.1,
            left: widget.custHeight * 0.1,
            right: widget.custHeight * 0.1,
            bottom: widget.custHeight * 0.02),
        width: widget.custWidth * 1.1,
        height: widget.custHeight * 1.5,
        // color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: context.read<RefundController>().formkey[6],
                child: Column(
                  children: [
                    SizedBox(
                      height: widget.custHeight * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        controller:
                            context.read<RefundController>().mycontroller[3],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the Customer Code";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Customer Code',
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
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        controller:
                            context.read<RefundController>().mycontroller[4],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the Mobile Number";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
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
                      // width: custWidth * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.01),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        controller:
                            context.read<RefundController>().mycontroller[5],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Please Enter the GST No";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        decoration: InputDecoration(
                          labelText: "Gst",
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
                        controller:
                            context.read<RefundController>().mycontroller[6],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
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
                        controller:
                            context.read<RefundController>().mycontroller[21],
                        cursorColor: Colors.grey,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.black),
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter the Email Address";
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            log("value::" + value.toString());
                            return "Please Enter a Valid Email";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
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
      context.watch<RefundController>().custList2.length,
      (ind) {
        return TopCustomer(ind: ind, theme: theme);
      },
    );
  }
}

class TopCustomer extends StatefulWidget {
  TopCustomer({
    Key? key,
    required this.ind,
    required this.theme,
  }) : super(key: key);
  ThemeData theme;
  int ind;

  @override
  State<TopCustomer> createState() => _TopCustomerState();
}

class _TopCustomerState extends State<TopCustomer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Datatatat: ");
        // print(posC.custList[ind].name);
        context.read<RefundController>().custSelected(
            context.read<RefundController>().custList2[widget.ind],
            context,
            widget.theme);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: widget.theme.primaryColor,
            border: Border.all(color: widget.theme.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child:
            Text(context.read<RefundController>().custList2[widget.ind].name!,
                textAlign: TextAlign.center,
                style: widget.theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.white,
                )),
      ),
    );
  }
}

Widget updateType(BuildContext context, int ii) {
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
                  "Confirm update",
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
                child: Text(
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
                          // context
                          //     .read<RefundController>()
                          //     .updateCustomer(ii);
                          Navigator.pop(context);
                        },
                        child: Text("Update to server")),
                  ),
                  SizedBox(
                      width: Screens.width(context) * 0.3,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // context
                            //     .read<RefundController>()
                            //     .updateCustomer(ii);
                            Navigator.pop(context);
                          },
                          child: Text("This sale"))),
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
            contentPadding: EdgeInsets.all(0),
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
                            .watch<RefundController>()
                            .getselectedcust!
                            .address!
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              context.read<RefundController>().clearTextField();
                              // context
                              //     .read<RefundController>()
                              //     .changeBillAddress(index);
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
                                        //   title: Text( pos.selectedcust!.address[index].billAddress,
                                        //       style: theme.textTheme.bodySmall),
                                        //   onTap: () {
                                        //     pos.changeBillAddress(index);
                                        //     //pos.selectedcust!.address[pos.selectedAdress].billAddress = pos.selectedcust!.address[index].billAddress;
                                        //     Navigator.pop(context);
                                        //   },
                                        // ),
                                        Container(
                                          child: Text("${context.watch<RefundController>().getselectedcust!.address![index].address1 ?? ''}," "${context.watch<RefundController>().getselectedcust!.address![index].address2 ?? ''}," "${context.watch<RefundController>().getselectedcust!.address![index].address3 ?? ''}"),
                                        ),
                                        Container(
                                          child: Text(
                                              "${context.watch<RefundController>().getselectedcust!.address![index].billCity}"),
                                        ),
                                        Container(
                                          child: Text(
                                              "${context.watch<RefundController>().getselectedcust!.address![index].billPincode}"),
                                        ),
                                        Container(
                                          child: Text(
                                              "${context.watch<RefundController>().getselectedcust!.address![index].billstate}"),
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
                createAddress(context, theme);
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
            contentPadding: EdgeInsets.all(0),
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
                      .watch<RefundController>()
                      .getselectedcust!
                      .address!
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        // context
                        //     .read<RefundController>()
                        //     .changeShipAddress(index);
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
                                        "${context.watch<RefundController>().getselectedcust!.address![index].address1 ?? ''}${context.watch<RefundController>().getselectedcust!.address![index].address2 ?? ''}${context.watch<RefundController>().getselectedcust!.address![index].address3 ?? ''}"),
                                  ),
                                  Container(
                                    child: Text(context
                                                .watch<RefundController>()
                                                .getselectedcust!
                                                .address![index]
                                                .billCity !=
                                            null
                                        ? context
                                            .watch<RefundController>()
                                            .getselectedcust!
                                            .address![index]
                                            .billCity
                                        : ""),
                                  ),
                                  Container(
                                    child: Text(context
                                                .watch<RefundController>()
                                                .getselectedcust!
                                                .address![index]
                                                .billPincode !=
                                            null
                                        ? "${context.watch<RefundController>().getselectedcust!.address![index].billPincode}"
                                        : ""),
                                  ),
                                  Container(
                                    child: Text(
                                        "${context.watch<RefundController>().getselectedcust!.address![index].billstate}"),
                                  )
                                  //             ListTile(
                                  //   title: Text(pos.selectedcust!.address[index].shipAddress,
                                  //       style: theme.textTheme.bodySmall),
                                  //   onTap: () {
                                  //     pos.changeShipAddress(index);
                                  //     // pos.selectedcust!.address[0].shipAddress =
                                  //     //     pos.selectedcust!.address[index].shipAddress;
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
                context.watch<RefundController>().clearTextField();
                Navigator.pop(context);

                createAddress(context, theme);
              },
            ));
      });
}

createAddress(BuildContext context, ThemeData theme) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Create Address',
              widget: createAddressMethod(theme, context),
              buttonName: "Save",
              callback: () {
                // context.read<RefundController>().createadd(context);
                // Navigator.pop(context);
                // pos.insertCreatenewAddress();
              },
            ));
      });
}

Container createAddressMethod(ThemeData theme, BuildContext context) {
  return Container(
    width: Screens.width(context) * 0.7,
    height: Screens.padingHeight(context) * 0.4,
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
      return Form(
        key: context.read<RefundController>().formkeyAd,
        child: Column(
          children: [
            SizedBox(
              height: custHeight * 0.02,
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
                controller: context.read<RefundController>().mycontroller[7],
                cursorColor: Colors.grey,
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                onChanged: (v) {},
                validator: (value) {
                  if (value!.isEmpty) {
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
              height: custHeight * 0.02,
            ),
            Container(
              // height: custHeight * 0.15,
              // width: custWidth * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                controller: context.read<RefundController>().mycontroller[8],
                cursorColor: Colors.grey,
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                onChanged: (v) {},
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return "Please Enter the Address2";
                //   } else {
                //     return null;
                //   }
                // },
                decoration: InputDecoration(
                  labelText: "Bill Address2",
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
              height: custHeight * 0.02,
            ),
            Container(
              // height: custHeight * 0.15,
              // width: custWidth * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                controller: context.read<RefundController>().mycontroller[9],
                cursorColor: Colors.grey,
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                onChanged: (v) {},
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return "Please Enter the Address3";
                //   } else {
                //     return null;
                //   }
                // },
                decoration: InputDecoration(
                  labelText: "Bill Address3",
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
              height: custHeight * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // height: custHeight * 0.15,
                  width: custWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    controller:
                        context.read<RefundController>().mycontroller[10],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
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
                Container(
                  // height: custHeight * 0.15,
                  width: custWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller:
                        context.read<RefundController>().mycontroller[11],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter the Pin Code";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Pin Code",
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
                  width: custWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    controller:
                        context.read<RefundController>().mycontroller[12],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
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
                Container(
                  // height: custHeight * 0.15,
                  width: custWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller:
                        context.read<RefundController>().mycontroller[13],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter the State";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    decoration: InputDecoration(
                      hintText: "TZ",
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
                  child: Text("Copy As Ship Address"),
                ),
                SizedBox(
                  width: custWidth * 0.2,
                ),
                Checkbox(
                    side: BorderSide(color: Colors.grey),
                    activeColor: Colors.green,
                    value: context.read<RefundController>().checkboxx,
                    onChanged: (val) {
                      st(() {
                        context.read<RefundController>().checkboxx = val!;
                        // context.read<RefundController>().billToShip(val);
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
                          context.read<RefundController>().mycontroller[14],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                      onChanged: (v) {},
                      validator: (value) {
                        if (value!.isEmpty) {
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
                          context.read<RefundController>().mycontroller[15],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                      onChanged: (v) {},
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Please Enter the Ship Address2";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      decoration: InputDecoration(
                        labelText: 'Ship Address2',
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
                    height: custHeight * 0.02,
                  ),
                  Container(
                    // height: custHeight * 0.15,
                    // width: custWidth * 0.65,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.grey.withOpacity(0.01),
                    ),
                    child: TextFormField(
                      autofocus: true,
                      controller:
                          context.read<RefundController>().mycontroller[16],
                      cursorColor: Colors.grey,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black),
                      onChanged: (v) {},
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Please Enter the Ship Address3";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      decoration: InputDecoration(
                        labelText: "Ship Address3",
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
                  width: custWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    controller:
                        context.read<RefundController>().mycontroller[17],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
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
                Container(
                  // height: custHeight * 0.15,
                  width: custWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller:
                        context.read<RefundController>().mycontroller[18],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter the Pin Code";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Pin Code",
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
                  width: custWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    controller:
                        context.read<RefundController>().mycontroller[19],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
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
                Container(
                  // height: custHeight * 0.15,
                  width: custWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    readOnly: true,
                    controller:
                        context.read<RefundController>().mycontroller[20],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "Please Enter the State";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    decoration: InputDecoration(
                      hintText: "TZ",
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
              ],
            ),
          ],
        ),
      );
    });
  }
}



// // ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:posproject/Constant/Screen.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:posproject/Pages/Sales%20Screen/Widgets/Dialog%20Box/AlertBox.dart';

// import '../../../Controller/PaymentReceiptController/RefundController.dart';

// class RefundCustomerDetails extends StatelessWidget {
//   RefundCustomerDetails(
//       {Key? key,
//       required this.theme,
//       required this.prdCD,
//       required this.custHeight,
//       required this.custWidth})
//       : super(key: key);

//   final ThemeData theme;
//   RefundController prdCD;
//   double custHeight;
//   double custWidth;
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.white,
//       ),
//       padding: EdgeInsets.only(
//           top: custHeight * 0.01,
//           bottom: custHeight * 0.02,
//           left: custHeight * 0.01,
//           right: custHeight * 0.01),
//       width: custWidth,
//       //height: custHeight,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             // width: custWidth * 0.7,
//             width: custWidth * 1,
//             decoration: BoxDecoration(
//               border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
//               borderRadius: BorderRadius.circular(3),
//               color: Colors.grey.withOpacity(0.001),
//             ),
//             child: TextFormField(
//               controller: prdCD.mycontroller[81],
//               onChanged: (v) {},
//               onEditingComplete: () {
//                 prdCD.custcodeScan(context, theme);
//               },
//               decoration: InputDecoration(
//                 suffixIcon: IconButton(
//                     onPressed: () {
//                       showDialog(
//                           context: context,
//                           barrierDismissible: false,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                                 contentPadding: EdgeInsets.all(0),
//                                 content: AlertBox(
//                                   payMent: 'Select Customer',
//                                   widget: forSearchBtn(context, prdCD),
//                                   buttonName: null,
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
//                                                 widget: forAddNewBtn(
//                                                     context, prdCD),
//                                                 buttonName: "Save",
//                                                 callback: () {
//                                                   // prdCD.addNewCus(context, 6);
//                                                 },
//                                               ));
//                                         });
//                                   },
//                                 ));
//                           });
//                     },

//                     // size: custHeight * 0.08,
//                     color: Colors.grey,
//                     icon: Icon(Icons.search)),
//                 hintText: 'Customers',
//                 hintStyle: theme.textTheme.bodyText1?.copyWith(
//                     // color: Colors.grey
//                     ),
//                 filled: false,
//                 enabledBorder: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 15,
//                   horizontal: 10,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: custHeight * 0.02,
//           ),
//           prdCD.getScanneditemData.isEmpty
//               ? Container(
//                   padding: EdgeInsets.symmetric(
//                       vertical: custHeight * 0.02,
//                       horizontal: custWidth * 0.02),
//                   child: Wrap(
//                       spacing: 10.0,
//                       runSpacing: 10.0,
//                       children: listContainersProduct(
//                         context,
//                         theme,
//                         prdCD,
//                       )),
//                 )
//               : Container(
//                   color: Colors.grey[50],
//                   padding: EdgeInsets.symmetric(
//                       vertical: custHeight * 0.02,
//                       horizontal: custWidth * 0.02),
//                   // height: custHeight * 0.75,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                           width: custWidth,
//                           alignment: Alignment.centerRight,
//                           // height: custHeight * 0.02,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 // color: Colors.green,
//                                 width: custWidth * 0.8,
//                                 child: Text(
//                                   prdCD.getselectedcust!.name != null
//                                       ? '${prdCD.getselectedcust!.name}'
//                                       : "",
//                                   style: theme.textTheme.bodyText1?.copyWith(
//                                       color: Colors.black, fontSize: 20),
//                                 ),
//                               ),
//                               // InkWell(
//                               //     onTap: () {
//                               //       prdCD.mapUpdateCustomer(
//                               //           prdCD.getselectedCustomer);
//                               //       showDialog(
//                               //           context: context,
//                               //           barrierDismissible: false,
//                               //           builder: (BuildContext context) {
//                               //             return AlertDialog(
//                               //                 contentPadding: EdgeInsets.all(0),
//                               //                 content: AlertBox(
//                               //                   payMent: 'Update Customer',
//                               //                   widget: forAddNewBtn(
//                               //                       context, prdCD),
//                               //                   buttonName: "Save",
//                               //                   callback: () {
//                               //                     showDialog(
//                               //                         context: context,
//                               //                         barrierDismissible: false,
//                               //                         builder: (BuildContext
//                               //                             context) {
//                               //                           return AlertDialog(
//                               //                             contentPadding:
//                               //                                 EdgeInsets.all(0),
//                               //                             content: updateType(
//                               //                                 context, prdCD),
//                               //                           );
//                               //                         });
//                               //                   },
//                               //                 ));
//                               //           });
//                               //     },
//                               //     child: Container(
//                               //       width: custWidth * 0.06,
//                               //       alignment: Alignment.center,
//                               //       //     color: Colors.red,
//                               //       child: Icon(Icons.edit),
//                               //     )),
//                               // InkWell(
//                               //     onTap: () {
//                               //       prdCD.clearpayData();
//                               //     },
//                               //     child: Container(
//                               //       width: custWidth * 0.06,
//                               //       alignment: Alignment.center,
//                               //       //     color: Colors.blue,
//                               //       child: Icon(Icons.close_sharp),
//                               //     )),
//                             ],
//                           ) // IconButton(onPressed: (){}, icon: Icon(Icons.close_sharp))
//                           ),
//                       SizedBox(
//                         height: custHeight * 0.01,
//                       ),
//                       Container(
//                         width: custWidth,
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
//                                         " ${prdCD.getselectedcust!.phNo}  |  ",
//                                         style: theme.textTheme.bodyText1
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
//                                         " ${prdCD.getselectedcust!.email}",
//                                         style: theme.textTheme.bodyText1
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: custHeight * 0.01,
//                       ),
//                       Container(
//                         width: custWidth,
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: custWidth * 0.465,
//                               // height: custHeight * 0.02,
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     child: Text(
//                                         "${AppLocalizations.of(context)!.gst}",
//                                         style: theme.textTheme.bodyText1
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                       right: custWidth * 0.02,
//                                     ),
//                                     child: Text(
//                                         "${prdCD.getselectedcust!.tarNo}",
//                                         style: theme.textTheme.bodyText1
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.centerRight,
//                               width: custWidth * 0.465,
//                               //  color: Colors.red,
//                               // height: custHeight * 0.02,
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     child: Text("Balance",
//                                         style: theme.textTheme.bodyText1
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                   Container(
//                                       child: prdCD.getselectedcust != null
//                                           ? Text(
//                                               prdCD.getselectedcust!.accBalance
//                                                   .toString()
//                                                   .replaceAll(",", ""),
//                                               style: theme.textTheme.bodyText1
//                                                   ?.copyWith(
//                                                       color: Colors.black54))
//                                           : null
//                                       // Text(
//                                       //     prdCD.onAccPayment
//                                       //         .toString()
//                                       //         .replaceAll(",", ""),
//                                       //     style: theme.textTheme.bodyText1
//                                       //         ?.copyWith(
//                                       //             color: Colors.black54)),
//                                       ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: custHeight * 0.01,
//                       ),
//                       Container(
//                         width: custWidth,
//                         // color: Colors.green,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: custWidth * 0.465,
//                               //  color: Colors.green,
//                               // height: custHeight * 0.02,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     child: Text("Code#",
//                                         style: theme.textTheme.bodyText1
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                       right: custWidth * 0.02,
//                                     ),
//                                     child: Text(
//                                         "${prdCD.getselectedcust!.cardCode}",
//                                         style: theme.textTheme.bodyText1
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               alignment: Alignment.centerRight,
//                               width: custWidth * 0.465,
//                               // color: Colors.red,
//                               // height: custHeight * 0.02,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     child: Text("Point",
//                                         style: theme.textTheme.bodyText1
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                   Container(
//                                     child: Text(
//                                         "${prdCD.getselectedcust!.point}",
//                                         style: theme.textTheme.bodyText1
//                                             ?.copyWith(color: Colors.black54)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: custHeight * 0.01,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               // billAddress(context, prdCD);
//                             },
//                             child: Container(
//                               width: custWidth * 0.465,
//                               // color: Colors.red,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     width: custWidth * 0.465,
//                                     padding: EdgeInsets.only(
//                                         right: custWidth * 0.02),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                             child: Text(
//                                           "Bill Address",
//                                           style: theme.textTheme.bodyText1
//                                               ?.copyWith(color: Colors.black54),
//                                         )),
//                                         Container(
//                                             width: custWidth * 0.04,
//                                             child: Icon(
//                                               Icons.arrow_drop_down,
//                                               size: 30,
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                       child: Text(
//                                     // [prdCD.getselectedBillAdress!]
//                                     "${prdCD.getselectedcust!.address![0].address1.toString()}, " + //
//                                         "${prdCD.getselectedcust!.address![0].address2.toString()}, " +
//                                         prdCD.getselectedcust!.address![0]
//                                             .address3
//                                             .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyText1
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD.getselectedcust!.address![0].billCity
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyText1
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD.getselectedcust!.address![0]
//                                         .billPincode
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyText1
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD.getselectedcust!.address![0].billstate
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyText1
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {
//                               // sipaddress(context, prdCD);
//                             },
//                             child: Container(
//                               width: custWidth * 0.465,
//                               //color: Colors.green,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     width: custWidth * 0.465,
//                                     padding: EdgeInsets.only(
//                                         right: custWidth * 0.02),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(
//                                             child: Text(
//                                           "Ship Address",
//                                           maxLines: 2,
//                                           style: theme.textTheme.bodyText1
//                                               ?.copyWith(color: Colors.black54),
//                                         )),
//                                         Container(
//                                             width: custWidth * 0.04,
//                                             child: Icon(
//                                               Icons.arrow_drop_down,
//                                               size: 30,
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                       child: Text(
//                                     "${prdCD.getselectedcust!.address![0].address1.toString()}, " +
//                                         "${prdCD.getselectedcust!.address![0].address2.toString()}, " +
//                                         prdCD.getselectedcust!.address![0]
//                                             .address3
//                                             .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyText1
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD
//                                         .getselectedcust!
//                                         .address![0]
//                                         // [prdCD.getselectedBillAdress!]
//                                         .billCity
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyText1
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD.getselectedcust!.address![0]
//                                         .billPincode
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyText1
//                                         ?.copyWith(color: Colors.black54),
//                                   )),
//                                   Container(
//                                       child: Text(
//                                     prdCD.getselectedcust!.address![0].billstate
//                                         .toString(),
//                                     maxLines: 1,
//                                     style: theme.textTheme.bodyText1
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
//                 ),
//         ],
//       ),
//     );
//   }

//   forSearchBtn(BuildContext context, RefundController prdsrcbtn) {
//     final theme = Theme.of(context);
//     return StatefulBuilder(builder: (context, st) {
//       return SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.only(
//               top: custHeight * 0.05,
//               left: custHeight * 0.05,
//               right: custHeight * 0.05,
//               bottom: custHeight * 0.01),
//           color: Colors.white,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 width: custWidth * 1.1,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
//                   borderRadius: BorderRadius.circular(3),
//                   color: Colors.grey.withOpacity(0.01),
//                 ),
//                 child: TextFormField(
//                   controller: prdsrcbtn.mycontroller[2],
//                   cursorColor: Colors.grey,
//                   onChanged: (v) {
//                     st(() {
//                       prdsrcbtn.filtertop10List(v);
//                     });
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Search customer..!!',
//                     hintStyle:
//                         theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
//                     filled: false,
//                     enabledBorder: InputBorder.none,
//                     focusedBorder: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 12,
//                       horizontal: 25,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: custHeight * 0.05),
//               Container(
//                   height: custHeight * 0.8,
//                   width: custWidth * 1.1,
//                   child: ListView.builder(
//                       itemCount:
//                           // prdsrcbtn.getselectedModell.length,
//                           prdsrcbtn.getfiltercustList1.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           child: Container(
//                             padding: EdgeInsets.only(
//                                 top: custHeight * 0.01,
//                                 left: custHeight * 0.01,
//                                 right: custHeight * 0.01,
//                                 bottom: custHeight * 0.02),
//                             // height: custHeight * 0.2,
//                             child: ListTile(
//                               onTap: () {
//                                 Navigator.pop(context);
//                                 prdsrcbtn.custSelected(
//                                   prdsrcbtn.getfiltercustList1[index],
//                                   context,
//                                 );
//                               },
//                               title: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         child: Text(prdsrcbtn
//                                             .getfiltercustList1[index]
//                                             .cardCode!),
//                                       ),
//                                       Container(
//                                         child: Text(prdsrcbtn
//                                             .getfiltercustList1[index]
//                                             .accBalance!
//                                             .toString()),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         child: Text(prdsrcbtn
//                                             .getfiltercustList1[index].name!),
//                                       ),
//                                       Container(
//                                         child: Text(prdsrcbtn
//                                             .getfiltercustList1[index].phNo!),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       })),
//               // SizedBox(height: custHeight * 0.09),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   forAddNewBtn(BuildContext context, RefundController prdadd) {
//     final theme = Theme.of(context);
//     return StatefulBuilder(builder: (context, st) {
//       return Container(
//         padding: EdgeInsets.only(
//             top: custHeight * 0.1,
//             left: custHeight * 0.1,
//             right: custHeight * 0.1,
//             bottom: custHeight * 0.02),
//         width: custWidth * 1.1,
//         height: custHeight * 1.5,
//         // color: Colors.red,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Form(
//                 key: prdadd.formkey[6],
//                 child: Column(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         autofocus: true,
//                         controller: prdadd.mycontroller[3],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyText1
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
//                       height: custHeight * 0.03,
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
//                         controller: prdadd.mycontroller[4],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyText1
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Mobile Number";
//                           } else {
//                             return null;
//                           }
//                         },
//                         decoration: InputDecoration(
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
//                       height: custHeight * 0.03,
//                     ),
//                     Container(
//                       // width: custWidth * 1,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         autofocus: true,
//                         controller: prdadd.mycontroller[5],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyText1
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the GST No";
//                           } else {
//                             return null;
//                           }
//                         },
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
//                       height: custHeight * 0.09,
//                     ),
//                     Container(
//                       // height: custHeight * 0.15,
//                       // width: custWidth * 1,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         controller: prdadd.mycontroller[6],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyText1
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
//                       height: custHeight * 0.02,
//                     ),
//                     //addreswidget
//                     AddressWidget(
//                       theme: theme,
//                       payController: prdadd,
//                       custHeight: custHeight,
//                       custWidth: custWidth,
//                     ),

//                     SizedBox(
//                       height: custHeight * 0.02,
//                     ),
//                     Container(
//                       // height: custHeight * 0.15,
//                       // width: custWidth * 0.65,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         controller: prdadd.mycontroller[21],
//                         cursorColor: Colors.grey,
//                         style: theme.textTheme.bodyText1
//                             ?.copyWith(color: Colors.black),
//                         onChanged: (v) {},
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please Enter the Email Address";
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
//       BuildContext context, ThemeData theme, RefundController posC) {
//     return List.generate(
//       posC.custList.length >= 10 ? 10 : posC.custList.length,
//       (ind) {
//         return TopCustomer(ind: ind, posC: posC, theme: theme);
//       },
//     );
//   }
// }

// class TopCustomer extends StatelessWidget {
//   TopCustomer({
//     Key? key,
//     required this.ind,
//     required this.posC,
//     required this.theme,
//   }) : super(key: key);
//   RefundController posC;
//   ThemeData theme;
//   int ind;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         print("Datatatat: ");

//         posC.custSelected(
//           posC.custList[ind],
//           context,
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.all(5),
//         decoration: BoxDecoration(
//             color: theme.primaryColor,
//             border: Border.all(color: theme.primaryColor, width: 1),
//             borderRadius: BorderRadius.circular(5)),
//         child: Text(posC.custList[ind].name!,
//             textAlign: TextAlign.center,
//             style: theme.textTheme.bodyText1?.copyWith(
//               fontWeight: FontWeight.normal,
//               fontSize: 16,
//               color: Colors.white,
//             )),
//       ),
//     );
//   }
// }

// Widget updateType(BuildContext context, RefundController pos) {
//   final theme = Theme.of(context);
//   return Container(
//     width: Screens.width(context) * 0.8,
//     //  height: Screens.padingHeight(context) * 0.4,
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           alignment: Alignment.center,
//           height: Screens.padingHeight(context) * 0.05,
//           decoration: BoxDecoration(
//             color: theme.primaryColor,
//             // borderRadius: BorderRadius.only(
//             //     topLeft: Radius.circular(5), topRight: Radius.circular(5))
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 // color: Colors.red,
//                 width: Screens.width(context) * 0.4,
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Confrim update",
//                   textAlign: TextAlign.center,
//                   style:
//                       theme.textTheme.bodyText1?.copyWith(color: Colors.white),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.close,
//                     size: Screens.padingHeight(context) * 0.025,
//                     color: Colors.white,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         SizedBox(
//           height: Screens.bodyheight(context) * 0.02,
//         ),
//         Container(
//           width: Screens.width(context) * 0.8,
//           padding: EdgeInsets.symmetric(
//             vertical: Screens.padingHeight(context) * 0.01,
//             horizontal: Screens.width(context) * 0.01,
//           ),
//           child: Column(
//             children: [
//               Container(
//                 child: Text(
//                     "Do you want to update this customer for this sale or update to server..!!"),
//               ),
//               SizedBox(
//                 height: Screens.bodyheight(context) * 0.02,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: Screens.width(context) * 0.3,
//                     child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                           pos.updateCustomer();
//                           Navigator.pop(context);
//                         },
//                         child: Text("Update to server")),
//                   ),
//                   Container(
//                       width: Screens.width(context) * 0.3,
//                       child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                             pos.updateCustomer();
//                             Navigator.pop(context);
//                           },
//                           child: Text("This sale"))),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// billAddress(BuildContext context, RefundController pos) async {
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
//                         itemCount: pos.selectedcust!.address!.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return InkWell(
//                             onTap: () {
//                               pos.changeBillAddress(index);
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
//                                           child: Text("${pos.getselectedcust!.address![index].address1}," +
//                                               "${pos.getselectedcust!.address![index].address2}," +
//                                               "${pos.getselectedcust!.address![index].address3},"),
//                                         ),
//                                         Container(
//                                           child: Text(
//                                               "${pos.getselectedcust!.address![index].billCity}"),
//                                         ),
//                                         Container(
//                                           child: Text(
//                                               "${pos.getselectedcust!.address![index].billPincode}"),
//                                         ),
//                                         Container(
//                                           child: Text(
//                                               "${pos.getselectedcust!.address![index].billstate}"),
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
//                 createAddress(context, theme, pos);
//               },
//             ));
//       });
// }

// sipaddress(BuildContext context, RefundController pos) async {
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
//                 height: Screens.padingHeight(context) * 0.3,
//                 width: Screens.width(context) * 0.25,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: pos.selectedcust!.address!.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return InkWell(
//                       onTap: () {
//                         pos.changeShipAddress(index);
//                         Navigator.pop(context);
//                       },
//                       child: Card(
//                           child: Container(
//                               child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ListTile(
//                             title: Text(
//                                 "${pos.selectedcust!.address![index].address1!}," +
//                                     "${pos.selectedcust!.address![index].address2!}" +
//                                     "${pos.selectedcust!.address![index].address3!}",
//                                 style: theme.textTheme.bodySmall),
//                             //   onTap: () {
//                             //     pos.changeShipAddress(index);
//                             //     // pos.selectedcust!.address[0].shipAddress =
//                             //     //     pos.selectedcust!.address[index].shipAddress;
//                             //     Navigator.pop(context);
//                             //   },
//                           ),
//                           Container(
//                             child: Text(
//                                 "${pos.selectedcust!.address![index].address1! + pos.selectedcust!.address![index].address2! + pos.selectedcust!.address![index].address3!}"),
//                           ),
//                           Container(
//                             child: Text(
//                                 "${pos.selectedcust!.address![index].billCity}"),
//                           ),
//                           Container(
//                             child: Text(
//                                 "${pos.selectedcust!.address![index].billPincode}"),
//                           ),
//                           Container(
//                             child: Text(
//                                 "${pos.selectedcust!.address![index].billstate}"),
//                           )
//                         ],
//                       ))),
//                     );
//                   },
//                 ),
//               ),
//               buttonName: "Create Address",
//               callback: () {
//                 Navigator.pop(context);
//                 createAddress(context, theme, pos);
//               },
//             ));
//       });
// }

// createAddress(
//     BuildContext context, ThemeData theme, RefundController pos) async {
//   final theme = Theme.of(context);
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             contentPadding: EdgeInsets.all(0),
//             content: AlertBox(
//               payMent: 'Create Address',
//               widget: createAddressMethod(theme, context, pos),
//               buttonName: "Save",
//               callback: () {
//                 pos.addadress(context);
//               },
//             ));
//       });
// }

// Container createAddressMethod(
//     ThemeData theme, BuildContext context, RefundController pos) {
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
//             payController: pos,
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
//       required this.payController,
//       required this.custHeight,
//       required this.custWidth})
//       : super(key: key);

//   final ThemeData theme;
//   final double custHeight;
//   final double custWidth;

//   final RefundController payController;

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, st) {
//       return Column(
//         children: [
//           Container(
//             // height: custHeight * 0.15,
//             // width: custWidth * 1,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(3),
//               color: Colors.grey.withOpacity(0.01),
//             ),
//             child: TextFormField(
//               controller: payController.mycontroller[7],
//               cursorColor: Colors.grey,
//               style: theme.textTheme.bodyText1?.copyWith(color: Colors.black),
//               onChanged: (v) {},
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Please Enter the Address1";
//                 } else {
//                   return null;
//                 }
//               },
//               decoration: InputDecoration(
//                 labelText: "Bill Address1",
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
//               controller: payController.mycontroller[8],
//               cursorColor: Colors.grey,
//               style: theme.textTheme.bodyText1?.copyWith(color: Colors.black),
//               onChanged: (v) {},
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Please Enter the Address2";
//                 } else {
//                   return null;
//                 }
//               },
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
//               controller: payController.mycontroller[9],
//               cursorColor: Colors.grey,
//               style: theme.textTheme.bodyText1?.copyWith(color: Colors.black),
//               onChanged: (v) {},
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "Please Enter the Address3";
//                 } else {
//                   return null;
//                 }
//               },
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
//                   controller: payController.mycontroller[10],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyText1?.copyWith(color: Colors.black),
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
//                   controller: payController.mycontroller[11],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyText1?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the Pin Code";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
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
//                   controller: payController.mycontroller[12],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyText1?.copyWith(color: Colors.black),
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
//                   readOnly: true,
//                   controller: payController.mycontroller[13],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyText1?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   // validator: (value) {
//                   //   if (value!.isEmpty) {
//                   //     return "Please Enter the State";
//                   //   } else {
//                   //     return null;
//                   //   }
//                   // },
//                   decoration: InputDecoration(
//                     hintText: "Ind",
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
//                   value: payController.checkboxx,
//                   onChanged: (val) {
//                     st(() {
//                       payController.checkboxx = val!;
//                       payController.billToShip(val);
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
//                     autofocus: true,
//                     controller: payController.mycontroller[14],
//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyText1
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
//                     controller: payController.mycontroller[15],
//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyText1
//                         ?.copyWith(color: Colors.black),
//                     onChanged: (v) {},
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please Enter the Ship Address2";
//                       } else {
//                         return null;
//                       }
//                     },
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
//                     controller: payController.mycontroller[16],
//                     cursorColor: Colors.grey,
//                     style: theme.textTheme.bodyText1
//                         ?.copyWith(color: Colors.black),
//                     onChanged: (v) {},
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please Enter the Ship Address3";
//                       } else {
//                         return null;
//                       }
//                     },
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
//                   controller: payController.mycontroller[17],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyText1?.copyWith(color: Colors.black),
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
//                   controller: payController.mycontroller[18],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyText1?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return "Please Enter the Pin Code";
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
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
//                   controller: payController.mycontroller[19],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyText1?.copyWith(color: Colors.black),
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
//                   readOnly: true,
//                   controller: payController.mycontroller[20],
//                   cursorColor: Colors.grey,
//                   style:
//                       theme.textTheme.bodyText1?.copyWith(color: Colors.black),
//                   onChanged: (v) {},
//                   // validator: (value) {
//                   //   if (value!.isEmpty) {
//                   //     return "Please Enter the State";
//                   //   } else {
//                   //     return null;
//                   //   }
//                   // },
//                   decoration: InputDecoration(
//                     hintText: "Ind",
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

//   //
// }
