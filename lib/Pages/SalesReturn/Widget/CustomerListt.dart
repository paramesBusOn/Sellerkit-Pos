// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Controller/SalesReturnController/SalesReturnController.dart';

class CustomerListt extends StatefulWidget {
  CustomerListt(
      {Key? key,
      required this.theme,
      // required this.prdSR,
      required this.custHeight,
      required this.custWidth})
      : super(key: key);

  final ThemeData theme;
  // SalesReturnController prdSR;
  double custHeight;
  double custWidth;

  @override
  State<CustomerListt> createState() => _CustomerListtState();
}

class _CustomerListtState extends State<CustomerListt> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(top: widget.custHeight * 0.01, bottom: widget.custHeight * 0.02, left: widget.custHeight * 0.01, right: widget.custHeight * 0.01),
      width: widget.custWidth,
      //height: custHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.watch<SalesReturnController>().scanneditemData2.isNotEmpty
              ? Container()
              : Container(
                  // width: custWidth * 0.7,
                  width: widget.custWidth * 1,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.001),
                  ),
                  child: TextFormField(
                    controller: context.read<SalesReturnController>().srmycontroller[1],
                    onChanged: (v) {},
                    onEditingComplete: () {
                      context.read<SalesReturnController>().invoiceScan(
                            context,
                            theme,
                          );
                      context.read<SalesReturnController>().disableKeyBoard(context);
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          // size: custHeight * 0.08,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          //  context.watch<SalesReturnController>().callCheckout();
                        },
                        color: theme.primaryColor,
                      ),
                      hintText: 'Invoice Number',
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
          context.read<SalesReturnController>().scanneditemData2.isNotEmpty
              ? Container(
                  color: Colors.grey[300],
                  padding: EdgeInsets.symmetric(vertical: widget.custHeight * 0.02, horizontal: widget.custWidth * 0.02),
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
                                  context.watch<SalesReturnController>().getselectedcust2!.name.toString(),
                                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 20),
                                ),
                              ),
                              // InkWell(
                              //     onTap: () {
                              //        context.watch<SalesReturnController>().clearData();
                              //     },
                              //     child: Container(
                              //       width: custWidth * 0.06,
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
                                    child: Text(" ${context.watch<SalesReturnController>().getselectedcust2!.phNo}  |  ", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                                    child: Text(" ${context.watch<SalesReturnController>().getselectedcust2!.email}", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("Gst", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: widget.custWidth * 0.02,
                                    ),
                                    child: Text("${context.watch<SalesReturnController>().getselectedcust2!.tarNo}", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("Balance", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    child: Text("₹${context.watch<SalesReturnController>().getselectedcust2!.accBalance}", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("Code#", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: widget.custWidth * 0.02,
                                    ),
                                    child: Text("${context.watch<SalesReturnController>().getselectedcust2!.cardCode}", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("Point", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
                                  ),
                                  Container(
                                    child: Text("${context.watch<SalesReturnController>().getselectedcust2!.point}", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                                    padding: EdgeInsets.only(right: widget.custWidth * 0.02),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            child: Text(
                                          "Billing Address",
                                          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                        )),
                                        // Container(
                                        //     width: custWidth * 0.04,
                                        //     child: Icon(
                                        //       Icons.arrow_drop_down,
                                        //       size: 30,
                                        //     ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: Text(
                                    "${context.watch<SalesReturnController>().getselectedcust2!.address![0].address1 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address1.toString() : ''}${context.watch<SalesReturnController>().getselectedcust2!.address![0].address2 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address2.toString() : ""}${context.watch<SalesReturnController>().getselectedcust2!.address![0].address3 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address3.toString() : ""}",
                                    // prdSR
                                    //     .getselectedcust!
                                    //     .address![ context.watch<SalesReturnController>().getselectedBillAdress!]
                                    //     .billAddress
                                    //     .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    //  context.watch<SalesReturnController>().getScanneditemData[0].billCity,
                                    context
                                        .watch<SalesReturnController>()
                                        .getselectedcust2!
                                        .address![0]
                                        .
                                        // [ context.watch<SalesReturnController>().getselectedBillAdress!]
                                        billCity
                                        .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    context
                                        .watch<SalesReturnController>()
                                        .getselectedcust2!
                                        .address![0]
                                        // ?[prdCD.getselectedBillAdress!]
                                        .billPincode
                                        .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    context.watch<SalesReturnController>().getselectedcust2!.address![0].billstate.toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
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
                                    padding: EdgeInsets.only(right: widget.custWidth * 0.02),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            child: Text(
                                          "Shipping Address",
                                          maxLines: 2,
                                          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                        )),
                                        // Container(
                                        //     width: custWidth * 0.04,
                                        //     child: Icon(
                                        //       Icons.arrow_drop_down,
                                        //       size: 30,
                                        //     ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: Text(
                                    "${context.watch<SalesReturnController>().getselectedcust2!.address![0].address1 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address1.toString() : ''}${context.watch<SalesReturnController>().getselectedcust2!.address![0].address2 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address2.toString() : ""}${context.watch<SalesReturnController>().getselectedcust2!.address![0].address3 != null ? context.watch<SalesReturnController>().getselectedcust2!.address![0].address3.toString() : ""}",
                                    //  context.watch<SalesReturnController>().getselectedcust!.address![0].shipAddress
                                    //     // prdCD
                                    //     //     .getselectedcust!
                                    //     //     .address![prdCD.getselectedShipAdress!]
                                    //     //     .shipAddress
                                    //     .toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    context.watch<SalesReturnController>().getselectedcust2!.address![0].billCity.toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    context.watch<SalesReturnController>().getselectedcust2!.address![0].billPincode.toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                  )),
                                  Container(
                                      child: Text(
                                    context.watch<SalesReturnController>().getselectedcust2!.address![0].billstate.toString(),
                                    maxLines: 1,
                                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
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
              : context.read<SalesReturnController>().getselectedcust == null
                  ? Container(padding: EdgeInsets.symmetric(vertical: widget.custHeight * 0.02, horizontal: widget.custWidth * 0.02), child: Text(""))
                  : Container(
                      color: Colors.grey[50],
                      padding: EdgeInsets.symmetric(vertical: widget.custHeight * 0.02, horizontal: widget.custWidth * 0.02),
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
                                      context.watch<SalesReturnController>().getselectedcust!.name.toString(),
                                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                  // InkWell(
                                  //     onTap: () {
                                  //        context.watch<SalesReturnController>().clearData();
                                  //     },
                                  //     child: Container(
                                  //       width: custWidth * 0.06,
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
                                        child: Text(" ${context.watch<SalesReturnController>().getselectedcust!.phNo}  |  ", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                                            context.watch<SalesReturnController>().getselectedcust!.email == null || context.watch<SalesReturnController>().getselectedcust!.email == 'null' || context.watch<SalesReturnController>().getselectedcust!.email!.isEmpty
                                                ? ""
                                                : " ${context.watch<SalesReturnController>().getselectedcust!.email.toString()}",
                                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Gst", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: widget.custWidth * 0.02,
                                        ),
                                        child: Text(
                                            context.watch<SalesReturnController>().getselectedcust!.tarNo == null || context.watch<SalesReturnController>().getselectedcust!.tarNo == 'null' || context.watch<SalesReturnController>().getselectedcust!.tarNo!.isEmpty
                                                ? ""
                                                : "${context.watch<SalesReturnController>().getselectedcust!.tarNo}",
                                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Balance", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
                                      ),
                                      Container(
                                        child: Text("₹ ${context.watch<SalesReturnController>().config.slpitCurrency2(context.watch<SalesReturnController>().getselectedcust!.accBalance!.toStringAsFixed(2))}", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Code#", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: widget.custWidth * 0.02,
                                        ),
                                        child: Text("${context.watch<SalesReturnController>().getselectedcust!.cardCode}", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text("Point", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
                                      ),
                                      Container(
                                        child: Text("${context.watch<SalesReturnController>().getselectedcust!.point}", style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54)),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: widget.custWidth * 0.465,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: widget.custWidth * 0.465,
                                      padding: EdgeInsets.only(right: widget.custWidth * 0.02),
                                      child: Container(
                                          child: Text(
                                        "Billing Address",
                                        style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                      )),
                                    ),
                                    context.watch<SalesReturnController>().getselectedcust2 == null || context.watch<SalesReturnController>().getselectedcust2!.address! == null || context.watch<SalesReturnController>().getselectedcust2!.address!.isEmpty
                                        ? Container()
                                        : Container(
                                            child: Text(
                                            "${context.watch<SalesReturnController>().getselectedcust!.address![0].address1 == null || context.watch<SalesReturnController>().getselectedcust!.address![0].address1!.isNotEmpty || context.watch<SalesReturnController>().getselectedcust!.address![0].address1!.isEmpty ? '' : context.watch<SalesReturnController>().getselectedcust!.address![0].address1.toString()}"
                                            "${context.watch<SalesReturnController>().getselectedcust!.address![0].address2 == null || context.watch<SalesReturnController>().getselectedcust!.address![0].address2!.isNotEmpty || context.watch<SalesReturnController>().getselectedcust!.address![0].address2!.isEmpty ? '' : context.watch<SalesReturnController>().getselectedcust!.address![0].address2.toString()}"
                                            "${context.watch<SalesReturnController>().getselectedcust!.address![0].address3 == null || context.watch<SalesReturnController>().getselectedcust!.address![0].address3!.isNotEmpty || context.watch<SalesReturnController>().getselectedcust!.address![0].address3!.isEmpty ? '' : context.watch<SalesReturnController>().getselectedcust!.address![0].address3.toString()}",

                                            // prdSR
                                            //     .getselectedcust!
                                            //     .address![ context.watch<SalesReturnController>().getselectedBillAdress!]
                                            //     .billAddress
                                            //     .toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                          )),
                                    context.watch<SalesReturnController>().getselectedcust2 == null || context.watch<SalesReturnController>().getselectedcust2!.address! == null || context.watch<SalesReturnController>().getselectedcust2!.address!.isEmpty
                                        ? Container()
                                        : Container(
                                            child: Text(
                                            //  context.watch<SalesReturnController>().getScanneditemData[0].billCity,
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust!
                                                .address![0]
                                                .
                                                // [ context.watch<SalesReturnController>().getselectedBillAdress!]
                                                billCity
                                                .toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                          )),
                                    context.watch<SalesReturnController>().getselectedcust2 == null || context.watch<SalesReturnController>().getselectedcust2!.address! == null || context.watch<SalesReturnController>().getselectedcust2!.address!.isEmpty
                                        ? Container()
                                        : Container(
                                            child: Text(
                                            context
                                                .watch<SalesReturnController>()
                                                .getselectedcust!
                                                .address![0]
                                                // ?[prdCD.getselectedBillAdress!]
                                                .billPincode
                                                .toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                          )),
                                    context.watch<SalesReturnController>().getselectedcust2 == null || context.watch<SalesReturnController>().getselectedcust2!.address! == null || context.watch<SalesReturnController>().getselectedcust2!.address!.isEmpty
                                        ? Container()
                                        : Container(
                                            child: Text(
                                            context.watch<SalesReturnController>().getselectedcust!.address![0].billstate.toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
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
                                      padding: EdgeInsets.only(right: widget.custWidth * 0.02),
                                      child: Container(
                                          child: Text(
                                        "Shipping Address",
                                        maxLines: 2,
                                        style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                      )),
                                    ),
                                    context.watch<SalesReturnController>().getselectedcust55!.address!.isNotEmpty
                                        ? Container(
                                            child: Text(
                                            "${context.watch<SalesReturnController>().getselectedcust55!.address![0].address1 != null ? context.watch<SalesReturnController>().getselectedcust55!.address![0].address1.toString() : ''}"
                                            "${context.watch<SalesReturnController>().getselectedcust55!.address![0].address2 != null ? context.watch<SalesReturnController>().getselectedcust55!.address![0].address2.toString() : ""}"
                                            "${context.watch<SalesReturnController>().getselectedcust55!.address![0].address3 != null ? context.watch<SalesReturnController>().getselectedcust55!.address![0].address3.toString() : ""}",

                                            //  context.watch<SalesReturnController>().getselectedcust!.address![0].shipAddress
                                            //     // prdCD
                                            //     //     .getselectedcust!
                                            //     //     .address![prdCD.getselectedShipAdress!]
                                            //     //     .shipAddress
                                            //     .toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                          ))
                                        : Container(),
                                    context.watch<SalesReturnController>().getselectedcust55!.address!.isNotEmpty
                                        ? Container(
                                            child: Text(
                                            context.watch<SalesReturnController>().getselectedcust55!.address![0].billCity.toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                          ))
                                        : Container(),
                                    context.watch<SalesReturnController>().getselectedcust55!.address!.isNotEmpty
                                        ? Container(
                                            child: Text(
                                            context.watch<SalesReturnController>().getselectedcust55!.address![0].billPincode.toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                          ))
                                        : Container(),
                                    context.watch<SalesReturnController>().getselectedcust55!.address!.isNotEmpty
                                        ? Container(
                                            child: Text(
                                            context.watch<SalesReturnController>().getselectedcust55!.address![0].billstate.toString(),
                                            maxLines: 1,
                                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                                          ))
                                        : Container(),
                                  ],
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
}

class TopCustomer extends StatelessWidget {
  TopCustomer({
    Key? key,
    required this.ind,
    required this.posC,
    required this.theme,
  }) : super(key: key);
  PosController posC;
  ThemeData theme;
  int ind;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Datatatat: ");
        // print(posC.custList[ind].name);
        posC.custSelected(
          posC.custList[ind],
          context,
        );
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: theme.primaryColor, border: Border.all(color: theme.primaryColor, width: 1), borderRadius: BorderRadius.circular(5)),
        child: Text(posC.custList[ind].name!,
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

Widget updateType(BuildContext context, PosController pos) {
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
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
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
                child: Text("Do you want to update this customer for this sale or update to server..!!"),
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
                          // pos.updateCustomer();
                          Navigator.pop(context);
                        },
                        child: Text("Update to server")),
                  ),
                  SizedBox(
                      width: Screens.width(context) * 0.3,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // pos.updateCustomer();
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

billAddress(BuildContext context, PosController pos) async {
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
                        itemCount: pos.selectedcust!.address!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              pos.changeBillAddress(index);
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
                                          child: Text("${pos.selectedcust!.address![index].address1}${pos.selectedcust!.address![index].address2}${pos.selectedcust!.address![index].address3}"),
                                        ),
                                        Container(
                                          child: Text("${pos.selectedcust!.address![index].billCity}"),
                                        ),
                                        Container(
                                          child: Text("${pos.selectedcust!.address![index].billPincode}"),
                                        ),
                                        Container(
                                          child: Text("${pos.selectedcust!.address![index].billstate}"),
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
                createAddress(context, theme, pos);
              },
            ));
      });
}

sipaddress(BuildContext context, PosController pos) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Address',
              widget: SizedBox(
                height: Screens.padingHeight(context) * 0.3,
                width: Screens.width(context) * 0.25,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: pos.selectedcust!.address!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        pos.changeShipAddress(index);
                        Navigator.pop(context);
                      },
                      child: Card(
                          child: Container(
                              child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("${pos.selectedcust!.address![index].address1}${pos.selectedcust!.address![index].address2}${pos.selectedcust!.address![index].address3}"),
                          ),
                          Container(
                            child: Text("${pos.selectedcust!.address![index].billCity}"),
                          ),
                          Container(
                            child: Text("${pos.selectedcust!.address![index].billPincode}"),
                          ),
                          Container(
                            child: Text("${pos.selectedcust!.address![index].billstate}"),
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
                          //       "${pos.selectedcust!.address![index].shipAddress}"),
                          // ),
                          // Container(
                          //   child: Text(
                          //       "${pos.selectedcust!.address![index].shipCity}"),
                          // ),
                          // Container(
                          //   child: Text(
                          //       "${pos.selectedcust!.address![index].shipPincode}"),
                          // ),
                          // Container(
                          //   child: Text(
                          //       "${pos.selectedcust!.address![index].shipstate}"),
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
                createAddress(context, theme, pos);
              },
            ));
      });
}

createAddress(BuildContext context, ThemeData theme, PosController pos) async {
  final theme = Theme.of(context);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: AlertBox(
              payMent: 'Create Address',
              widget: createAddressMethod(theme, context, pos),
              buttonName: "Save",
              callback: () {
                // pos.addadress(context);
              },
            ));
      });
}

Container createAddressMethod(ThemeData theme, BuildContext context, PosController pos) {
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
            posController: pos,
            custHeight: Screens.width(context) * 0.4,
            custWidth: Screens.width(context) * 0.7,
          ),
        ],
      ),
    ),
  );
}

class AddressWidget extends StatelessWidget {
  const AddressWidget({Key? key, required this.theme, required this.posController, required this.custHeight, required this.custWidth}) : super(key: key);

  final ThemeData theme;
  final double custHeight;
  final double custWidth;

  final PosController posController;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, st) {
      return Column(
        children: [
          Container(
            // height: custHeight * 0.15,
            // width: custWidth * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey.withOpacity(0.01),
            ),
            child: TextFormField(
              controller: posController.mycontroller[4],
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
              controller: posController.mycontroller[5],
              cursorColor: Colors.grey,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
              onChanged: (v) {},
              validator: (value) {
                if (value!.isEmpty) {
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
              controller: posController.mycontroller[6],
              cursorColor: Colors.grey,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
              onChanged: (v) {},
              validator: (value) {
                if (value!.isEmpty) {
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
                  controller: posController.mycontroller[29],
                  cursorColor: Colors.grey,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
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
                  controller: posController.mycontroller[30],
                  cursorColor: Colors.grey,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
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
                  controller: posController.mycontroller[31],
                  cursorColor: Colors.grey,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
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
                  controller: posController.mycontroller[32],
                  cursorColor: Colors.grey,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please Enter the State";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  decoration: InputDecoration(
                    hintText: "Ind",
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
                  value: posController.checkboxx,
                  onChanged: (val) {
                    st(() {
                      posController.checkboxx = val!;
                      posController.billToShip(val);
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
                    autofocus: true,
                    controller: posController.mycontroller[7],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
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
                    controller: posController.mycontroller[8],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
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
                    border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    controller: posController.mycontroller[9],
                    cursorColor: Colors.grey,
                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                    onChanged: (v) {},
                    validator: (value) {
                      if (value!.isEmpty) {
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
                  controller: posController.mycontroller[33],
                  cursorColor: Colors.grey,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
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
                  controller: posController.mycontroller[34],
                  cursorColor: Colors.grey,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
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
                  controller: posController.mycontroller[35],
                  cursorColor: Colors.grey,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
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
                  controller: posController.mycontroller[36],
                  cursorColor: Colors.grey,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  onChanged: (v) {},
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Please Enter the State";
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  decoration: InputDecoration(
                    hintText: "Ind",
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
      );
    });
  }

  //
}
