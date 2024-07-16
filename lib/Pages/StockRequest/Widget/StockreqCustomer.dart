// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

class StockReqCustomer extends StatefulWidget {
  StockReqCustomer(
      {Key? key,
      required this.theme,
      required this.custHeight,
      required this.custWidth})
      : super(key: key);

  final ThemeData theme;
  double custHeight;
  double custWidth;

  @override
  State<StockReqCustomer> createState() => _StockReqCustomerState();
}

class _StockReqCustomerState extends State<StockReqCustomer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.only(
          top: widget.custHeight * 0.01,
          bottom: widget.custHeight * 0.01,
          left: widget.custHeight * 0.01,
          right: widget.custHeight * 0.01),
      width: widget.custWidth,
      //height: custHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.watch<StockReqController>().getScanneditemData2.isEmpty
              ? Container(
                  width: widget.custWidth * 1,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.001),
                  ),
                  child: TextFormField(
                    controller:
                        context.read<StockReqController>().mycontroller[1],
                    onChanged: (v) {},
                    readOnly: true,
                    onTap: () {
                      setState(() {
                        print(context.read<StockReqController>().filsterwhsList.length);
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  contentPadding: EdgeInsets.all(0),
                                  content: AlertBox(
                                    payMent: 'Select WareHouse',
                                    widget: forSearchBtn(
                                      context,
                                    ),
                                    buttonName: null,
                                  ));
                            }).then((value) {
                              setState(() {
                                
                              });
                            });
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          // size: custHeight * 0.08,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    contentPadding: EdgeInsets.all(0),
                                    content: AlertBox(
                                      payMent: 'Select WareHouse',
                                      widget: forSearchBtn(
                                        context,
                                      ),
                                      buttonName: null,
                                    ));
                              });
                        },
                        color: theme.primaryColor,
                      ),
                      hintText: 'Locations',
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
                )
              : Container(),
          SizedBox(
            height: widget.custHeight * 0.01,
          ),
          context.watch<StockReqController>().get_WhsselectedList2 != null
              ? Container(
                  color: Colors.grey[300],

                  padding: EdgeInsets.symmetric(
                      vertical: widget.custHeight * 0.01,
                      horizontal: widget.custWidth * 0.02),
                  // height: custHeight * 0.15,

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
                                width: widget.custWidth * 0.8,
                                child: Text(
                                  "${context.watch<StockReqController>().get_WhsselectedList2!.whsName}",
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              // InkWell(
                              //     onTap: () {
                              //       // SR_Con.clearData();
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
                                        "${context.watch<StockReqController>().get_WhsselectedList2!.whsPhoNo}  |  ",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.grey)),
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
                                        "${context.watch<StockReqController>().get_WhsselectedList2!.whsmailID}",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.grey)),
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
                              width: widget.custWidth * 0.7,
                              //  color: Colors.green,
                              // height: custHeight * 0.02,
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.custWidth * 0.2,
                                    // color: Colors.amber,
                                    child: Text("GST#",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.grey)),
                                  ),
                                  Container(
                                    // color: Colors.amber,
                                    padding: EdgeInsets.only(
                                      right: widget.custWidth * 0.02,
                                    ),
                                    child: Text(
                                        "${context.watch<StockReqController>().get_WhsselectedList2!.whsGst}",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.grey)),
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
                              width: widget.custWidth * 0.7,
                              //  color: Colors.green,
                              // height: custHeight * 0.02,
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.custWidth * 0.2,
                                    child: Text("Code#",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.grey)),
                                  ),
                                  Container(
                                    // alignment: Alignment.centerLeft,
                                    // padding: EdgeInsets.only(
                                    //   right: custWidth * 0.02,
                                    // ),
                                    child: Text(
                                        "${context.watch<StockReqController>().get_WhsselectedList2!.whsCode}",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(color: Colors.grey)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: widget.custWidth * 0.01,
                            ),
                            SizedBox(
                              //  color: Colors.amber,
                              width: widget.custWidth * 0.9,
                              child: Text(
                                  "${context.watch<StockReqController>().get_WhsselectedList2!.whsAddress}",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.grey)),
                            ),
                            SizedBox(
                              width: widget.custWidth * 0.9,
                              child: Text(
                                  "${context.watch<StockReqController>().get_WhsselectedList2!.whsCity}",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.grey)),
                            ),
                            SizedBox(
                              width: widget.custWidth * 0.9,
                              child: Text(
                                  "${context.watch<StockReqController>().get_WhsselectedList2!.pinCode}",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.grey)),
                            ),
                            SizedBox(
                              width: widget.custWidth * 0.9,
                              child: Text(
                                  "${context.watch<StockReqController>().get_WhsselectedList2!.whsState}",
                                  style: theme.textTheme.bodyLarge
                                      ?.copyWith(color: Colors.grey)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : context.watch<StockReqController>().get_WhsselectedList == null
                  ? Container()
                  // Container(
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: custHeight * 0.02,
                  //         horizontal: custWidth * 0.02),
                  //     child: Wrap(
                  //         spacing: 10.0,
                  //         runSpacing: 10.0,
                  //         children: listContainersProduct(
                  //           context,
                  //           theme,
                  //           SR_Con,
                  //         )),
                  //   )
                  : Container(
                      color: Colors.grey[50],

                      padding: EdgeInsets.symmetric(
                          vertical: widget.custHeight * 0.01,
                          horizontal: widget.custWidth * 0.02),
                      // height: custHeight * 0.15,

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
                                    width: widget.custWidth * 0.8,
                                    child: Text(
                                      "${context.watch<StockReqController>().get_WhsselectedList!.whsName}",
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        context
                                            .read<StockReqController>()
                                            .clearData();
                                      },
                                      child: Container(
                                        width: widget.custWidth * 0.06,
                                        alignment: Alignment.center,
                                        //     color: Colors.blue,
                                        child: Icon(Icons.close_sharp),
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
                                            "${context.watch<StockReqController>().get_WhsselectedList!.whsPhoNo}  |  ",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.grey)),
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
                                            "${context.watch<StockReqController>().get_WhsselectedList!.whsmailID}",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.grey)),
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
                                  width: widget.custWidth * 0.7,
                                  //  color: Colors.green,
                                  // height: custHeight * 0.02,
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: widget.custWidth * 0.2,
                                        // color: Colors.amber,
                                        child: Text("GST#",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.grey)),
                                      ),
                                      Container(
                                        // color: Colors.amber,
                                        padding: EdgeInsets.only(
                                          right: widget.custWidth * 0.02,
                                        ),
                                        child: Text(
                                            "${context.watch<StockReqController>().get_WhsselectedList!.whsGst}",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.grey)),
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
                                  width: widget.custWidth * 0.7,
                                  //  color: Colors.green,
                                  // height: custHeight * 0.02,
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: widget.custWidth * 0.2,
                                        child: Text("Code#",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.grey)),
                                      ),
                                      Container(
                                        // alignment: Alignment.centerLeft,
                                        // padding: EdgeInsets.only(
                                        //   right: custWidth * 0.02,
                                        // ),
                                        child: Text(
                                            "${context.watch<StockReqController>().get_WhsselectedList!.whsCode}",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(color: Colors.grey)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: widget.custWidth * 0.01,
                                ),
                                SizedBox(
                                  //  color: Colors.amber,
                                  width: widget.custWidth * 0.9,
                                  child: Text(
                                      "${context.watch<StockReqController>().get_WhsselectedList!.whsAddress}",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: widget.custWidth * 0.9,
                                  child: Text(
                                      "${context.watch<StockReqController>().get_WhsselectedList!.whsCity}",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: widget.custWidth * 0.9,
                                  child: Text(
                                      "${context.watch<StockReqController>().get_WhsselectedList!.pinCode}",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.grey)),
                                ),
                                SizedBox(
                                  width: widget.custWidth * 0.9,
                                  child: Text(
                                      "${context.watch<StockReqController>().get_WhsselectedList!.whsState}",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.grey)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
          SizedBox(
            height: widget.custHeight * 0.02,
          ),
          context.watch<StockReqController>().fromAddressList2 != null
              ? Container(
                  padding: EdgeInsets.only(
                      top: widget.custHeight * 0.01,
                      bottom: widget.custHeight * 0.01,
                      left: widget.custHeight * 0.04,
                      right: widget.custHeight * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      // showDialog(
                      //     context: context,
                      //     barrierDismissible: false,
                      //     builder: (BuildContext context) {
                      //       return AlertDialog(
                      //           shape: RoundedRectangleBorder(
                      //               borderRadius:
                      //                   BorderRadius.all(Radius.circular(4))),
                      //           contentPadding: EdgeInsets.all(0),
                      //           // backgroundColor: Colors.transparent,
                      //           insetPadding: EdgeInsets.all(
                      //               Screens.bodyheight(context) * 0.02),
                      //           content: AlertBox(
                      //             payMent: 'Select Branch',
                      //             widget: ForbranchList(context, SR_Con),
                      //             buttonName: null,
                      //           ));
                      //     });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // width: custWidth * 0.465,
                          // padding: EdgeInsets.onl/y(right: custWidth * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Text(
                                "Delivery Address",
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.black54),
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
                            // // SR_Con.ShipSelectedList == null
                            // //     ?
                            // "Cbe1,kk Nagar,coimbatore",
                            "${context.watch<StockReqController>().fromAddressList2!.whsName}",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          child: Text(
                            // SR_Con.ShipSelectedList == null
                            //     ?
                            "${context.watch<StockReqController>().fromAddressList2!.whsAddress}",
                            // : "${SR_Con.ShipSelectedList!.billCity}",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          child: Text(
                            // SR_Con.ShipSelectedList == null
                            //     ?
                            "${context.watch<StockReqController>().fromAddressList2!.whsCity}",
                            // : "${SR_Con.ShipSelectedList!.billPincode}",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.grey),
                          ),
                        ),
                        Container(
                          child: Text(
                            // SR_Con.ShipSelectedList == null
                            //     ?
                            "${context.watch<StockReqController>().fromAddressList2!.pinCode}",
                            // : "${SR_Con.ShipSelectedList!.billstate}",
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.grey),
                          ),
                        ),
                        // Container(
                        //   child: Text(
                        //     // SR_Con.ShipSelectedList == null
                        //     //     ?
                        //     "${SR_Con.fromAddressList2!.whsState}",
                        //     // : "${SR_Con.ShipSelectedList!.billstate}",
                        //     style: theme.textTheme.bodyText2!
                        //         .copyWith(color: Colors.grey),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              : context.watch<StockReqController>().fromAddressList == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(
                          top: widget.custHeight * 0.01,
                          bottom: widget.custHeight * 0.01,
                          left: widget.custHeight * 0.04,
                          right: widget.custHeight * 0.01),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        onTap: () {
                          // showDialog(
                          //     context: context,
                          //     barrierDismissible: false,
                          //     builder: (BuildContext context) {
                          //       return AlertDialog(
                          //           shape: RoundedRectangleBorder(
                          //               borderRadius:
                          //                   BorderRadius.all(Radius.circular(4))),
                          //           contentPadding: EdgeInsets.all(0),
                          //           // backgroundColor: Colors.transparent,
                          //           insetPadding: EdgeInsets.all(
                          //               Screens.bodyheight(context) * 0.02),
                          //           content: AlertBox(
                          //             payMent: 'Select Branch',
                          //             widget: ForbranchList(context, SR_Con),
                          //             buttonName: null,
                          //           ));
                          //     });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // width: custWidth * 0.465,
                              // padding: EdgeInsets.onl/y(right: custWidth * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Text(
                                    "Delivery Address",
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black),
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
                                // // SR_Con.ShipSelectedList == null
                                // //     ?
                                // "Cbe1,kk Nagar,coimbatore",
                                "${context.watch<StockReqController>().fromAddressList!.whsName}",
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                            Container(
                              child: Text(
                                // SR_Con.ShipSelectedList == null
                                //     ?
                                "${context.watch<StockReqController>().fromAddressList!.whsAddress}",
                                // : "${SR_Con.ShipSelectedList!.billCity}",
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                            Container(
                              child: Text(
                                // SR_Con.ShipSelectedList == null
                                //     ?
                                "${context.watch<StockReqController>().fromAddressList!.whsCity}",
                                // : "${SR_Con.ShipSelectedList!.billPincode}",
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                            Container(
                              child: Text(
                                // SR_Con.ShipSelectedList == null
                                //     ?
                                "${context.watch<StockReqController>().fromAddressList!.pinCode}",
                                // : "${SR_Con.ShipSelectedList!.billstate}",
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                            // Container(
                            //   child: Text(
                            //     // SR_Con.ShipSelectedList == null
                            //     //     ?
                            //     "${SR_Con.fromAddressList!.whsState}",
                            //     // : "${SR_Con.ShipSelectedList!.billstate}",
                            //     style: theme.textTheme.bodyText2!
                            //         .copyWith(color: Colors.grey),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }

  forSearchBtn(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return StatefulBuilder(builder: (context, st) {
        final theme = Theme.of(context);
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
                  controller:
                      context.read<StockReqController>().mycontroller[2],
                  cursorColor: Colors.grey,
                  onChanged: (v) {
                    st(() {
                      context.read<StockReqController>().filterList(v);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Warehose..!!',
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
                  height: widget.custHeight * 1.45,
                  width: widget.custWidth * 1.1,
                  child: ListView.builder(
                      itemCount: context
                          .watch<StockReqController>()
                          .filsterwhsList
                          .length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.04),
                                borderRadius: BorderRadius.circular(5)
                                //   boxShadow: [
                                //     BoxShadow(
                                //       color: Colors.grey.withOpacity(0.5),
                                //       spreadRadius: 3,
                                //       blurRadius: 7,
                                //       offset:
                                //           Offset(0, 3), // changes position of shadow
                                //     ),
                                //   ],

                                ),
                            padding: EdgeInsets.only(
                                top: widget.custHeight * 0.01,
                                left: widget.custHeight * 0.01,
                                right: widget.custHeight * 0.01,
                                bottom: widget.custHeight * 0.03),
                            // height: custHeight * 0.2,
                            child: ListTile(
                              onTap: () {
                                context.read<StockReqController>().WhsSelected(
                                    context
                                        .read<StockReqController>()
                                        .filsterwhsList[index],
                                    context);
                                Navigator.pop(context);
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
                                        child: Text(
                                          // "A0001",
                                          context
                                              .watch<StockReqController>()
                                              .filsterwhsList[index]
                                              .whsCode!,
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                            // "2000.00",
                                            context
                                                .watch<StockReqController>()
                                                .filsterwhsList[index]
                                                .whsPhoNo!,
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(color: Colors.black)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                            // "Jco Retails",
                                            context
                                                .watch<StockReqController>()
                                                .filsterwhsList[index]
                                                .whsName!,
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(color: Colors.black)),
                                      ),
                                      Container(
                                        child: Text(
                                            // "1234567890",
                                            context
                                                .watch<StockReqController>()
                                                .filsterwhsList[index]
                                                .whsmailID!,
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(color: Colors.black)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
            ],
          ),
        );
      });
    });
  }

  List<Widget> listContainersProduct(
      BuildContext context, ThemeData theme, PosController posC) {
    return List.generate(
      posC.custList.length >= 10 ? 10 : posC.custList.length,
      (ind) {
        return TopCustomer(ind: ind, posC: posC, theme: theme);
      },
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
        decoration: BoxDecoration(
            color: theme.primaryColor,
            border: Border.all(color: theme.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(5)),
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

// billAddress(BuildContext context, PosController pos) async {
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
//                                           child: Text("${pos.selectedcust!.address![index].address1}," +
//                                               "${pos.selectedcust!.address![index].address2}," +
//                                               "${pos.selectedcust!.address![index].address2}"),
//                                         ),
//                                         Container(
//                                           child: Text(
//                                               "${pos.selectedcust!.address![index].billCity}"),
//                                         ),
//                                         Container(
//                                           child: Text(
//                                               "${pos.selectedcust!.address![index].billPincode}"),
//                                         ),
//                                         Container(
//                                           child: Text(
//                                               "${pos.selectedcust!.address![index].billstate}"),
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

// sipaddress(BuildContext context, PosController pos) async {
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
//                           //             ListTile(
//                           //   title: Text(pos.selectedcust!.address[index].shipAddress,
//                           //       style: theme.textTheme.bodySmall),
//                           //   onTap: () {
//                           //     pos.changeShipAddress(index);
//                           //     // pos.selectedcust!.address[0].shipAddress =
//                           //     //     pos.selectedcust!.address[index].shipAddress;
//                           //     Navigator.pop(context);
//                           //   },
//                           // ),
//                           Container(
//                             child: Text("${pos.selectedcust!.address![index].address1}," +
//                                 "${pos.selectedcust!.address![index].address2}," +
//                                 "${pos.selectedcust!.address![index].address2}"),
//                             // Text(
//                             // "${pos.selectedcust!.address![index].shipAddress}"),
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

// createAddress(BuildContext context, ThemeData theme, PosController pos) async {
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
//                 // pos.addadress(context);
//               },
//             ));
//       });
// }

// Container createAddressMethod(
//     ThemeData theme, BuildContext context, PosController pos) {
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
//             posController: pos,
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
//       required this.posController,
//       required this.custHeight,
//       required this.custWidth})
//       : super(key: key);

//   final ThemeData theme;
//   final double custHeight;
//   final double custWidth;

//   final PosController posController;

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
//               controller: posController.mycontroller[7],
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
//               controller: posController.mycontroller[8],
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
//               controller: posController.mycontroller[9],
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
//                   controller: posController.mycontroller[10],
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
//                   controller: posController.mycontroller[11],
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
//                   controller: posController.mycontroller[12],
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
//                   controller: posController.mycontroller[13],
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
//                   value: posController.checkboxx,
//                   onChanged: (val) {
//                     st(() {
//                       posController.checkboxx = val!;
//                       posController.billToShip(val);
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
//                     controller: posController.mycontroller[14],
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
//                     controller: posController.mycontroller[15],
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
//                     controller: posController.mycontroller[16],
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
//                   controller: posController.mycontroller[17],
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
//                   controller: posController.mycontroller[18],
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
//                   controller: posController.mycontroller[19],
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
//                   controller: posController.mycontroller[20],
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

// ForbranchList(BuildContext context, StockReqController SR_Con) {
//   final theme = Theme.of(context);
//   return StatefulBuilder(builder: (context, st) {
//     return Container(
//       padding: EdgeInsets.only(
//           top: Screens.bodyheight(context) * 0.008,
//           left: Screens.width(context) * 0.008,
//           right: Screens.width(context) * 0.008,
//           bottom: Screens.bodyheight(context) * 0.008),
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             width: Screens.width(context) * 1.1,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 3,
//                   blurRadius: 7,
//                   offset: Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//               border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
//               borderRadius: BorderRadius.circular(3),
//               // color: Colors.grey.withOpacity(0.01),
//             ),
//             child: TextFormField(
//               // controller: SR_Con.mycontroller[2],
//               cursorColor: Colors.grey,
//               onChanged: (v) {
//                 st(() {
//                   SR_Con.filterbranchList(v);
//                 });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search WareHouse..!!',
//                 hintStyle:
//                     theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
//                 filled: false,
//                 enabledBorder: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 5,
//                   horizontal: 5,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: Screens.bodyheight(context) * 0.008),
//           Container(
//               height: Screens.bodyheight(context) * 0.5,
//               width: Screens.width(context) * 1.1,
//               // color: Colors.blue,
//               child: ListView.builder(
//                   itemCount: SR_Con.filterShipAddressList.length,
//                   //  SR_Con.getfiltercustList.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         st(() {
//                           print("object");
//                           SR_Con.branchSelected(
//                               SR_Con.filterShipAddressList[index], context);
//                         });

//                         Navigator.pop(context);
//                       },
//                       child: Card(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 3,
//                                 blurRadius: 7,
//                                 offset:
//                                     Offset(0, 3), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           padding: EdgeInsets.only(
//                               top: Screens.bodyheight(context) * 0.008,
//                               left: Screens.bodyheight(context) * 0.008,
//                               right: Screens.bodyheight(context) * 0.008,
//                               bottom: Screens.bodyheight(context) * 0.008),
//                           // height: Screens.bodyheight(context) * 0.2,
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: Screens.width(context),
//                                 // color: Colors.amber,
//                                 child: Text(
//                                   // "A0001",
//                                   "${SR_Con.filterShipAddressList[index].billAddress}",
//                                   style: theme.textTheme.bodyText2!
//                                       .copyWith(color: Colors.black),
//                                 ),
//                               ),
//                               Container(
//                                 width: Screens.width(context),
//                                 // color: Colors.amber,
//                                 child: Text(
//                                     // "2000.00",
//                                     "${SR_Con.filterShipAddressList[index].billCity}",
//                                     style: theme.textTheme.bodyText2!
//                                         .copyWith(color: Colors.black)),
//                               ),
//                               Container(
//                                 width: Screens.width(context),
//                                 // color: Colors.amber,
//                                 child: Text(
//                                     // "Jco Retails",
//                                     "${SR_Con.filterShipAddressList[index].billstate}",
//                                     style: theme.textTheme.bodyText2!
//                                         .copyWith(color: Colors.black)),
//                               ),
//                               Container(
//                                 width: Screens.width(context),
//                                 // color: Colors.amber,
//                                 child: Text(
//                                     // "1234567890",
//                                     "${SR_Con.filterShipAddressList[index].billCountry}",
//                                     style: theme.textTheme.bodyText2!
//                                         .copyWith(color: Colors.black)),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   })),
//         ],
//       ),
//     );
//   });
// }
