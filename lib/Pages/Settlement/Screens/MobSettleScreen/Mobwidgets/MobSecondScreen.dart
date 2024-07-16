// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';

import '../../../../../Controller/DepositController/DepositsController.dart';
import '../../../../../Widgets/Drawer.dart';

class SettledScecondScreen extends StatefulWidget {
  SettledScecondScreen({super.key, required this.settleCon});

  DepositsController settleCon;

  @override
  State<SettledScecondScreen> createState() => _SettledScecondScreenState();
}

class _SettledScecondScreenState extends State<SettledScecondScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Desposits Screen"),
        ),
        drawer: naviDrawer(context),
        body: SafeArea(
          child: SizedBox(
            height: Screens.padingHeight(context) * 1,
            width: double.infinity,
            // padding: EdgeInsets.only(left: Screens.width(context) * 0.01),
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //  color: Colors.amber,

                  child: TabBar(isScrollable: true, tabs: [
                    Tab(
                        child: TextButton(
                      onPressed: () {},
                      child: Text("Cash",
                          style: theme.textTheme.bodyLarge!.copyWith()),
                    )),
                    Tab(
                      child: Text("Card",
                          style: theme.textTheme.bodyLarge!.copyWith()),
                    ),
                    Tab(
                      child: Text("Cheque",
                          style: theme.textTheme.bodyLarge!.copyWith()),
                    ),
                    // Tab(
                    //   child: Text("Wallet",
                    //       style: theme.textTheme.bodyText1!.copyWith()),
                    // ),
                    // Tab(

                    //   child: Text("Coupon",
                    //       style: theme.textTheme.bodyText1!.copyWith()),
                    // ),
                  ]),
                ),
                Expanded(
                  // color: Colors.amber,
                  // height: Screens.padingHeight(context)*0.50,
                  // width: double.infinity,

                  child: TabBarView(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: Screens.padingHeight(context) * 0.01,
                          bottom: Screens.padingHeight(context) * 0.01,
                          left: Screens.width(context) * 0.01,
                          right: Screens.width(context) * 0.01),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            top: Screens.padingHeight(context) * 0.01,
                            bottom: Screens.padingHeight(context) * 0.01,
                            left: Screens.width(context) * 0.01,
                            right: Screens.width(context) * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Form(
                               // key: widget.settleCon.fomkeySet[5],
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            //  color: Colors.amber,
                                            width:
                                                Screens.width(context) * 0.40,
                                            child: Text("Amount in Hand")),
                                        SizedBox(
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.06,
                                            width:
                                                Screens.width(context) * 0.55,
                                            child: TextField(
                                              readOnly: true,
                                              controller: widget
                                                  .settleCon.mycontroller[4],
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 5.0,
                                                          horizontal: 5.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  hintText: "",
                                                  hintStyle: theme
                                                      .textTheme.bodyLarge),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            // color: Colors.amber,
                                            width:
                                                Screens.width(context) * 0.40,
                                            child:
                                                Text("Amount to Settle off")),
                                        SizedBox(
                                            // height:
                                            //     Screens.padingHeight(context) *
                                            //         0.06,
                                            width:
                                                Screens.width(context) * 0.55,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Requierd";
                                                }
                                                return null;
                                              },
                                              // readOnly: true,
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: widget
                                                  .settleCon.mycontroller[5],
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 5.0,
                                                          horizontal: 5.0),
                                                  // border: InputBorder.none,
                                                  // focusedBorder: InputBorder.none,
                                                  // enabledBorder: InputBorder.none,
                                                  // errorBorder: OutlineInputBorder(borderSide: BorderSide()),
                                                  // disabledBorder: InputBorder.none,

                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  hintText: "",
                                                  hintStyle: theme
                                                      .textTheme.bodyLarge),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            //    color: Colors.amber,
                                            width:
                                                Screens.width(context) * 0.40,
                                            child: Text("Settlement Account")),
                                        Container(
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.06,
                                            width:
                                                Screens.width(context) * 0.55,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Center(
                                              child: DropdownButtonFormField(
                                                decoration:
                                                    InputDecoration.collapsed(
                                                        hintText:
                                                            " Settlement Account",
                                                        hintStyle: theme
                                                            .textTheme
                                                            .bodyLarge),
                                                value: widget
                                                    .settleCon.valuechoose,
                                                onChanged: (newvalue) {
                                                  widget.settleCon
                                                      .dropdownchoose(newvalue);
                                                },
                                                items: widget
                                                    .settleCon.Listitems
                                                    .map((valueitem) {
                                                  return DropdownMenuItem(
                                                    value: valueitem,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: Screens.width(
                                                                  context) *
                                                              0.01),
                                                      child: Text(
                                                        valueitem,
                                                        style: theme.textTheme
                                                            .bodyLarge,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            //   color: Colors.amber,

                                            width:
                                                Screens.width(context) * 0.40,
                                            child: Text("Remarks")),
                                        SizedBox(
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.06,
                                            width:
                                                Screens.width(context) * 0.55,
                                            child: TextField(
                                              controller: widget
                                                  .settleCon.mycontroller[6],
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 5.0,
                                                          horizontal: 5.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  hintText: "Remarks...",
                                                  hintStyle: theme
                                                      .textTheme.bodyLarge),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.01,
                            ),
                            Container(
                              //alignment: Alignment.center,
                              // color: Colors.amber,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        widget.settleCon
                                            .insertsettledheader("Cash", theme,context);
                                      },
                                      child: Text("Save")),
                                  SizedBox(
                                    width: Screens.width(context) * 0.02,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel")),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Screens.padingHeight(context) * 0.01,
                          bottom: Screens.padingHeight(context) * 0.01,
                          left: Screens.width(context) * 0.01,
                          right: Screens.width(context) * 0.01),
                      child: Form(
                       // key: widget.settleCon.fomkeySet[2],
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: Screens.padingHeight(context) * 0.01,
                                bottom: Screens.padingHeight(context) * 0.01,
                                left: Screens.width(context) * 0.01,
                                right: Screens.width(context) * 0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //   Container(
                                          //  //  color: Colors.amber, // height: Screens.padingHeight(context)*0.20,
                                          //     // width: Screens.padingHeight(context)*0.19,
                                          //     child: Text("Pay Terminal")),
                                          Container(
                                            // color: Colors.blue,
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.06,
                                            width:
                                                Screens.padingHeight(context) *
                                                    0.30,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Center(
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  focusColor: Colors.white,
                                                  hint: Text(
                                                    " Choose Payment Terminal",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: widget.settleCon
                                                                  .gethintcolor ==
                                                              false
                                                          ? Colors.grey
                                                          : Colors.red,
                                                    ),
                                                  ),
                                                  items: widget.settleCon
                                                      .CardpayTerminallist
                                                      .map((valueitem) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: valueitem,
                                                            child: Text(
                                                              valueitem,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ))
                                                      .toList(),
                                                  value: widget.settleCon
                                                      .paytermvaluechoose,
                                                  onChanged: (newvalue) {
                                                    setState(() {
                                                      widget.settleCon
                                                          .payTermdropdown(
                                                              newvalue);
                                                    });
                                                  },
                                                ),
                                              ),
                                              // DropdownButtonFormField(
                                              // isExpanded: true,
                                              //   validator: (value) =>
                                              //       value == null
                                              //           ? 'field required'
                                              //           : null,
                                              //   decoration:
                                              //       InputDecoration.collapsed(
                                              //     filled: true,
                                              //     hintText: "payment Terminal",
                                              //   ),
                                              // value: widget.settleCon
                                              //     .paytermvaluechoose,
                                              //   onChanged: (newvalue) {
                                              // widget.settleCon
                                              //     .payTermdropdown(
                                              //         newvalue);
                                              //   },
                                              // items: widget.settleCon
                                              //     .CardpayTerminallist
                                              //     .map((valueitem) {
                                              //     return DropdownMenuItem(
                                              //       value: valueitem,
                                              //       child: Padding(
                                              //         padding: EdgeInsets.only(
                                              //             left: Screens.width(
                                              //                     context) *
                                              //                 0.01),
                                              //         child: Text(
                                              //           valueitem,
                                              //           style: theme.textTheme
                                              //               .bodyText1,
                                              //         ),
                                              //       ),
                                              //     );
                                              //   }).toList(),
                                              // ),
                                            ),
                                          ),

                                          Container(
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.06,
                                            width:
                                                Screens.width(context) * 0.20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: theme.primaryColor,
                                            ),
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    widget.settleCon
                                                        .forcardlistorder(
                                                            context,
                                                            "Card",
                                                            theme,1);
                                                  });
                                                },
                                                child: Text(
                                                  "Load",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.01,
                                      ),
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.50,
                                        width: Screens.width(context),
                                        // color: Colors.amber,
                                        child:
                                            widget.settleCon.finalcardsettled
                                                    .isEmpty
                                                ? Container(
                                                    child: Center(
                                                        child: Text(
                                                            "No data Found")))
                                                : ListView.builder(
                                                    itemCount: widget
                                                        .settleCon
                                                        .finalcardsettled
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Card(
                                                          color:
                                                              Colors.grey[200],
                                                          child:
                                                              CheckboxListTile(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            activeColor:
                                                                Colors.green,
                                                            value: widget
                                                                .settleCon
                                                                .finalcardsettled[
                                                                    index]
                                                                .checkClr,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                widget.settleCon
                                                                    .carditemDeSelect(
                                                                        index);
                                                              });
                                                            },
                                                            title: Container(
                                                              //   // color: Colors.blue,
                                                              // width: Screens.width(context)*0.03,
                                                              child: Row(
                                                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      //width: Screens.width(context)*0.80,
                                                                      //  color: Colors.amber,
                                                                      SizedBox(
                                                                        //   color: Colors.amber,
                                                                        width: Screens.width(context) *
                                                                            0.77,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            // Container(child: Text("Approval NO:")),
                                                                            Container(
                                                                                padding: EdgeInsets.only(left: Screens.width(context) * 0.01),
                                                                                child: Text(widget.settleCon.finalcardsettled[index].cardterminal.toString(), style: theme.textTheme.bodyLarge!.copyWith())),

                                                                            // Container(child: Text("Card Ref:")),
                                                                            Container(
                                                                                child: Row(
                                                                              children: [
                                                                                //  Text("Amount:"),
                                                                                Text(
                                                                                  widget.settleCon.finalcardsettled[index].Cardref.toString(),
                                                                                  style: theme.textTheme.bodyLarge!.copyWith(),
                                                                                )
                                                                              ],
                                                                            )),
                                                                            Container(
                                                                                child: Row(
                                                                              children: [
                                                                                // Text("Amount:"),
                                                                                Text(widget.settleCon.finalcardsettled[index].rupees.toString(), style: theme.textTheme.bodyLarge!.copyWith(fontSize: 15))
                                                                              ],
                                                                            )),
                                                                          ],
                                                                        ),
                                                                      ),

                                                                      SizedBox(
                                                                        // color: Colors.deepOrange,
                                                                        width: Screens.width(context) *
                                                                            0.7,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: Screens.bodyheight(context) * 0.008),
                                                                          child: Text(
                                                                              widget.settleCon.finalcardsettled[index].Date.toString(),
                                                                              style: theme.textTheme.bodyLarge!.copyWith()),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    }),
                                      ),
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.01,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  //alignment: Alignment.center,
                                  // color: Colors.amber,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            widget.settleCon
                                                .insertsettledheader(
                                              "Card",
                                              theme,context
                                            );
                                          },
                                          child: Text("Save")),
                                      SizedBox(
                                        width: Screens.width(context) * 0.02,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel")),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Screens.padingHeight(context) * 0.01,
                          bottom: Screens.padingHeight(context) * 0.01,
                          left: Screens.width(context) * 0.01,
                          right: Screens.width(context) * 0.01),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            top: Screens.padingHeight(context) * 0.01,
                            bottom: Screens.padingHeight(context) * 0.01,
                            left: Screens.width(context) * 0.01,
                            right: Screens.width(context) * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          // color: Colors.amber, // height: Screens.padingHeight(context)*0.20,
                                          // width:
                                          //     Screens.padingHeight(context) * 0.25,
                                          child: Row(
                                        children: [
                                          Text("Total Unsettled Cheque Value:"),
                                          Container(
                                              child: widget
                                                          .settleCon
                                                          .mycontroller[14]
                                                          .text
                                                          .toString ==
                                                      ""
                                                  ? Text("Rs.0.00")
                                                  : Text(widget
                                                      .settleCon.totalCheque
                                                      .toString())),
                                        ],
                                      )),
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.06,
                                        width: Screens.width(context) * 0.20,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                widget.settleCon.isload = true;
                                                widget.settleCon
                                                    .forChequelistorder(context,
                                                        "Cheque", theme,1);
                                                // widget.settleCon.ontapisload();
                                              });
                                            },
                                            child: Text("Load")),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.50,
                                    width: double.infinity,
                                    // color: Colors.amber,
                                    child: ListView.builder(
                                        itemCount: widget.settleCon
                                            .finalchequesettled.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                              color: Colors.grey[200],
                                              child: CheckboxListTile(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                activeColor: Colors.green,
                                                value: widget
                                                    .settleCon
                                                    .finalchequesettled[index]
                                                    .checkClr,
                                                onChanged: (val) {
                                                  setState(() {
                                                    widget.settleCon
                                                        .chequeitemDeSelect(
                                                            index,val!);
                                                  });
                                                },
                                                title: SizedBox(
                                                  // color: Colors.blue,
                                                  width:
                                                      Screens.width(context) *
                                                          0.03,
                                                  child: Row(
                                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            //   color: Colors.amber,

                                                            width: Screens.width(
                                                                    context) *
                                                                0.77,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                // Container(child: Text("Approval NO:")),
                                                                Container(
                                                                    padding: EdgeInsets.only(
                                                                        left: Screens.width(context) *
                                                                            0.01),
                                                                    child: Text(
                                                                        widget
                                                                            .settleCon
                                                                            .finalchequesettled[
                                                                                index]
                                                                            .ChequeDate
                                                                            .toString(),
                                                                        style: theme
                                                                            .textTheme
                                                                            .bodyLarge!
                                                                            .copyWith())),
                                                                SizedBox(
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.001,
                                                                ),

                                                                // Container(child: Text("Card Ref:")),

                                                                Container(
                                                                    child: Row(
                                                                  children: [
                                                                    // Text("Amount:"),
                                                                    Text(
                                                                        widget
                                                                            .settleCon
                                                                            .finalchequesettled[
                                                                                index]
                                                                            .rupees
                                                                            .toString(),
                                                                        style: theme
                                                                            .textTheme
                                                                            .bodyLarge!
                                                                            .copyWith(fontSize: 18))
                                                                  ],
                                                                )),
                                                              ],
                                                            ),
                                                          ),
                                                          // Container(
                                                          //   // color: Colors.deepOrange,
                                                          //   width: Screens.width(
                                                          //           context) *
                                                          //       0.77,
                                                          //   child: Row(
                                                          //     mainAxisAlignment:
                                                          //         MainAxisAlignment
                                                          //             .spaceBetween,
                                                          //     children: [
                                                          //       Container(
                                                          //           padding: EdgeInsets.only(
                                                          //               left: Screens.width(context) *
                                                          //                   0.01),
                                                          //           child: Row(
                                                          //             children: [
                                                          //               // Text(
                                                          //               //     "Cheque No:",
                                                          //               //     style: theme
                                                          //               //         .textTheme
                                                          //               //         .bodyText1!
                                                          //               //         .copyWith()),
                                                          //               Container(
                                                          //                   child:
                                                          //                       Text(widget.settleCon.finalchequesettled[index].ChequeNo.toString(), style: theme.textTheme.bodyText1!.copyWith())),
                                                          //             ],
                                                          //           )),
                                                          //       Container(
                                                          //           child: Row(
                                                          //         children: [
                                                          //           // Text(
                                                          //           //     "Cheque Date:",
                                                          //           //     style: theme
                                                          //           //         .textTheme
                                                          //           //         .bodyText1!
                                                          //           //         .copyWith()),
                                                          //           Container(
                                                          //               child: Text(
                                                          //                   widget.settleCon.finalchequesettled[index].ChequeDate
                                                          //                       .toString(),
                                                          //                   style:
                                                          //                       theme.textTheme.bodyText1!.copyWith())),
                                                          //         ],
                                                          //       )),
                                                          //     ],
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.01,
                            ),
                            Container(
                              //alignment: Alignment.center,
                              // color: Colors.amber,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        widget.settleCon.insertsettledheader(
                                            "Cheque", theme,context);
                                      },
                                      child: Text("Save")),
                                  SizedBox(
                                    width: Screens.width(context) * 0.02,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel")),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: Screens.padingHeight(context) * 0.01,
//                           bottom: Screens.padingHeight(context) * 0.01,
//                           left: Screens.width(context) * 0.01,
//                           right: Screens.width(context) * 0.01),
//                       child: Form(
//                         key: widget.settleCon.fomkeySet[1],
//                         child: Container(
//                           color: Colors.white,
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 top: Screens.padingHeight(context) * 0.01,
//                                 bottom: Screens.padingHeight(context) * 0.01,
//                                 left: Screens.width(context) * 0.01,
//                                 right: Screens.width(context) * 0.01),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Container(
//                                               //  color: Colors.amber, // height: Screens.padingHeight(context)*0.20,
//                                               // width: Screens.padingHeight(context)*0.20,
//                                               child: Text("Wallet Code")),
//                                           Container(
//                                             // color: Colors.blue,
//                                             height:
//                                                 Screens.padingHeight(context) *
//                                                     0.06,
//                                             width:
//                                                 Screens.padingHeight(context) *
//                                                     0.25,
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                     color: Colors.grey),
//                                                 borderRadius:
//                                                     BorderRadius.circular(4)),
//                                             child: Center(
//                                               child: DropdownButtonFormField(
//                                                 validator: (value) =>
//                                                     value == null
//                                                         ? 'field required'
//                                                         : null,
//                                                 decoration:
//                                                     InputDecoration.collapsed(
//                                                   hintText: " ",
//                                                 ),
//                                                 value: widget.settleCon
//                                                     .walletvaluechoose,
//                                                 onChanged: (newvalue) {
//                                                   widget.settleCon
//                                                       .walletdropdown(newvalue);
//                                                 },
//                                                 items: widget
//                                                     .settleCon.Walletlist
//                                                     .map((valueitem) {
//                                                   return DropdownMenuItem(
//                                                     value: valueitem,
//                                                     child: Padding(
//                                                       padding: EdgeInsets.only(
//                                                           left: Screens.width(
//                                                                   context) *
//                                                               0.01),
//                                                       child: Text(valueitem),
//                                                     ),
//                                                   );
//                                                 }).toList(),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height:
//                                                 Screens.padingHeight(context) *
//                                                     0.06,
//                                             width:
//                                                 Screens.width(context) * 0.20,
//                                             child: ElevatedButton(
//                                                 onPressed: () {
//                                                   setState(() {
//                                                     widget.settleCon.isload =
//                                                         true;
//                                                     widget.settleCon
//                                                         .forwalletlistorder(
//                                                             context,
//                                                             "Wallet",
//                                                             theme);
//                                                     //
//                                                     // widget.settleCon.ontapisload();

// //widget.settleCon.finalwalletsettled.clear();
//                                                   });
//                                                 },
//                                                 child: Text("Load")),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: Screens.padingHeight(context) *
//                                             0.01,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text("Total Balance:"),
//                                           Text("Rs.0.00"),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: Screens.padingHeight(context) *
//                                             0.01,
//                                       ),
//                                       Container(
//                                         height: Screens.padingHeight(context) *
//                                             0.50,
//                                         width: double.infinity,
//                                         // color: Colors.amber,
//                                         child: Visibility(
//                                           visible: widget.settleCon.isload,
//                                           child: ListView.builder(
//                                               itemCount: widget.settleCon
//                                                   .finalwalletsettled.length,
//                                               itemBuilder: (context, index) {
//                                                 return Card(
//                                                     color: Colors.grey[200],
//                                                     child: CheckboxListTile(
//                                                       contentPadding:
//                                                           EdgeInsets.all(0),
//                                                       activeColor: Colors.green,
//                                                       value: widget
//                                                           .settleCon
//                                                           .finalwalletsettled[
//                                                               index]
//                                                           .checkClr,
//                                                       onChanged: (val) {
//                                                         setState(() {
//                                                           widget.settleCon
//                                                               .walletitemDeSelect(
//                                                                   index);
//                                                         });
//                                                       },
//                                                       title: Container(
//                                                         // color: Colors.blue,
//                                                         // width: Screens.width(context)*0.03,
//                                                         child: Row(
//                                                           //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                           children: [
//                                                             Column(
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .start,
//                                                               children: [
//                                                                 //width: Screens.width(context)*0.80,
//                                                                 //  color: Colors.amber,
//                                                                 Container(
//                                                                   //   color: Colors.amber,
//                                                                   width: Screens
//                                                                           .width(
//                                                                               context) *
//                                                                       0.77,
//                                                                   child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       // Container(child: Text("Approval NO:")),
//                                                                       Container(
//                                                                           padding: EdgeInsets.only(
//                                                                               left: Screens.width(context) *
//                                                                                   0.01),
//                                                                           child: Text(
//                                                                               widget.settleCon.finalwalletsettled[index].walletname.toString(),
//                                                                               style: theme.textTheme.bodyText1!.copyWith())),

//                                                                       // Container(child: Text("Card Ref:")),
//                                                                       Container(
//                                                                           child:
//                                                                               Row(
//                                                                         children: [
//                                                                           //  Text("Amount:"),
//                                                                           Text(
//                                                                             widget.settleCon.finalwalletsettled[index].rupees.toString(),
//                                                                             style:
//                                                                                 theme.textTheme.bodyText1!.copyWith(fontSize: 18),
//                                                                           )
//                                                                         ],
//                                                                       )),
//                                                                       Container(
//                                                                           child:
//                                                                               Row(
//                                                                         children: [
//                                                                           //     Text("Date:"),
//                                                                           Text(
//                                                                               widget.settleCon.finalwalletsettled[index].Date.toString(),
//                                                                               style: theme.textTheme.bodyText1!.copyWith())
//                                                                         ],
//                                                                       )),
//                                                                     ],
//                                                                   ),
//                                                                 ),

//                                                                 Container(
//                                                                   // color: Colors.deepOrange,
//                                                                   width: Screens
//                                                                           .width(
//                                                                               context) *
//                                                                       0.77,
//                                                                   child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Container(
//                                                                           padding: EdgeInsets.only(
//                                                                               left: Screens.width(context) *
//                                                                                   0.01),
//                                                                           child: Text(
//                                                                               widget.settleCon.finalwalletsettled[index].name.toString(),
//                                                                               style: theme.textTheme.bodyText1!.copyWith())),
//                                                                       Container(
//                                                                           child: Text(
//                                                                               widget.settleCon.finalwalletsettled[index].PhNo.toString(),
//                                                                               style: theme.textTheme.bodyText1!.copyWith())),
//                                                                       Container(
//                                                                           child:
//                                                                               Row(
//                                                                         children: [
//                                                                           Text(
//                                                                               "Pay No:",
//                                                                               style: theme.textTheme.bodyText1!.copyWith()),
//                                                                           Container(
//                                                                               child: Text(widget.settleCon.finalwalletsettled[index].payNo.toString(), style: theme.textTheme.bodyText1!.copyWith())),
//                                                                         ],
//                                                                       )),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ));
//                                               }),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: Screens.padingHeight(context) * 0.01,
//                                 ),
//                                 Container(
//                                   //alignment: Alignment.center,
//                                   // color: Colors.amber,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             widget.settleCon
//                                                 .insertsettledheader("Wallet");
//                                           },
//                                           child: Text("Save")),
//                                       SizedBox(
//                                         width: Screens.width(context) * 0.02,
//                                       ),
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text("Cancel")),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: Screens.padingHeight(context) * 0.01,
//                           bottom: Screens.padingHeight(context) * 0.01,
//                           left: Screens.width(context) * 0.01,
//                           right: Screens.width(context) * 0.01),
//                       child: Form(
//                         key: widget.settleCon.fomkeySet[0],
//                         child: Container(
//                           color: Colors.white,
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 top: Screens.padingHeight(context) * 0.01,
//                                 bottom: Screens.padingHeight(context) * 0.01,
//                                 left: Screens.width(context) * 0.01,
//                                 right: Screens.width(context) * 0.01),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           // Container(
//                                           //     //  color: Colors.amber, // height: Screens.padingHeight(context)*0.20,
//                                           //     // width: Screens.padingHeight(context)*0.20,
//                                           //     child: Text("Coupon Code")),
//                                           Container(
//                                             // color: Colors.blue,
//                                             height:
//                                                 Screens.padingHeight(context) *
//                                                     0.06,
//                                             width:
//                                                 Screens.padingHeight(context) *
//                                                     0.30,
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(4),
//                                                 border: Border.all(
//                                                     color: Colors.grey)),
//                                             child: Center(
//                                               child: DropdownButtonFormField(
//                                                 validator: (value) =>
//                                                     value == null
//                                                         ? 'field required'
//                                                         : null,
//                                                 decoration:
//                                                     InputDecoration.collapsed(
//                                                   hintText: " Coupon Code",
//                                                 ),
//                                                 value: widget.settleCon
//                                                     .Couponvaluechoose,
//                                                 onChanged: (newvalue) {
//                                                   widget.settleCon
//                                                       .coupondropdown(newvalue);
//                                                 },
//                                                 items: widget
//                                                     .settleCon.couponlist
//                                                     .map((valueitem) {
//                                                   return DropdownMenuItem(
//                                                     value: valueitem,
//                                                     child: Padding(
//                                                       padding: EdgeInsets.only(
//                                                           left: Screens.width(
//                                                                   context) *
//                                                               0.01),
//                                                       child: Text(
//                                                         valueitem,
//                                                         style: theme.textTheme
//                                                             .bodyText1,
//                                                       ),
//                                                     ),
//                                                   );
//                                                 }).toList(),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height:
//                                                 Screens.padingHeight(context) *
//                                                     0.06,
//                                             width:
//                                                 Screens.width(context) * 0.20,
//                                             child: ElevatedButton(
//                                                 onPressed: () {
//                                                   setState(() {
//                                                     widget.settleCon
//                                                         .iscouponload = true;
//                                                     widget.settleCon
//                                                         .forcouponlistorder(
//                                                             context,
//                                                             "Coupons",
//                                                             theme);
//                                                     // widget.settleCon
//                                                     //     .oncoupontapisload();
//                                                   });
//                                                 },
//                                                 child: Text("Load")),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: Screens.padingHeight(context) *
//                                             0.01,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text("Total Balance:"),
//                                           Text("Rs.0.00"),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: Screens.padingHeight(context) *
//                                             0.01,
//                                       ),
//                                       Container(
//                                         height: Screens.padingHeight(context) *
//                                             0.50,
//                                         width: double.infinity,
//                                         // color: Colors.amber,
//                                         child: Visibility(
//                                           visible:
//                                               widget.settleCon.iscouponload,
//                                           child: ListView.builder(
//                                               itemCount: widget.settleCon
//                                                   .finalcouponsettled.length,
//                                               itemBuilder: (context, index) {
//                                                 return Card(
//                                                     color: Colors.grey[200],
//                                                     child: CheckboxListTile(
//                                                       contentPadding:
//                                                           EdgeInsets.all(0),
//                                                       activeColor: Colors.green,
//                                                       value: widget
//                                                           .settleCon
//                                                           .finalcouponsettled[
//                                                               index]
//                                                           .checkClr,
//                                                       onChanged: (val) {
//                                                         setState(() {
//                                                           widget.settleCon
//                                                               .couponitemDeSelect(
//                                                                   index);
//                                                         });
//                                                       },
//                                                       title: Container(
//                                                         // color: Colors.blue,
//                                                         // width: Screens.width(context)*0.03,
//                                                         child: Row(
//                                                           //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                           children: [
//                                                             Column(
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .start,
//                                                               children: [
//                                                                 //width: Screens.width(context)*0.80,
//                                                                 //  color: Colors.amber,
//                                                                 Container(
//                                                                   //   color: Colors.amber,
//                                                                   width: Screens
//                                                                           .width(
//                                                                               context) *
//                                                                       0.77,
//                                                                   child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       // Container(child: Text("Approval NO:")),
//                                                                       Container(
//                                                                           padding: EdgeInsets.only(
//                                                                               left: Screens.width(context) *
//                                                                                   0.01),
//                                                                           child: Text(
//                                                                               widget.settleCon.finalcouponsettled[index].couponname.toString(),
//                                                                               style: theme.textTheme.bodyText1!.copyWith())),

//                                                                       // Container(child: Text("Card Ref:")),
//                                                                       Container(
//                                                                           child:
//                                                                               Row(
//                                                                         children: [
//                                                                           //  Text("Amount:"),
//                                                                           Text(
//                                                                             widget.settleCon.finalcouponsettled[index].rupees.toString(),
//                                                                             style:
//                                                                                 theme.textTheme.bodyText1!.copyWith(fontSize: 18),
//                                                                           )
//                                                                         ],
//                                                                       )),
//                                                                       Container(
//                                                                           child:
//                                                                               Row(
//                                                                         children: [
//                                                                           //     Text("Date:"),
//                                                                           Text(
//                                                                               widget.settleCon.finalcouponsettled[index].Date.toString(),
//                                                                               style: theme.textTheme.bodyText1!.copyWith())
//                                                                         ],
//                                                                       )),
//                                                                     ],
//                                                                   ),
//                                                                 ),

//                                                                 Container(
//                                                                   // color: Colors.deepOrange,
//                                                                   width: Screens
//                                                                           .width(
//                                                                               context) *
//                                                                       0.77,
//                                                                   child: Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Container(
//                                                                           padding: EdgeInsets.only(
//                                                                               left: Screens.width(context) *
//                                                                                   0.01),
//                                                                           child: Text(
//                                                                               widget.settleCon.finalcouponsettled[index].name.toString(),
//                                                                               style: theme.textTheme.bodyText1!.copyWith())),
//                                                                       Container(
//                                                                           child: Text(
//                                                                               widget.settleCon.finalcouponsettled[index].PhNo.toString(),
//                                                                               style: theme.textTheme.bodyText1!.copyWith())),
//                                                                       Container(
//                                                                           child:
//                                                                               Row(
//                                                                         children: [
//                                                                           Text(
//                                                                               "Pay No:",
//                                                                               style: theme.textTheme.bodyText1!.copyWith()),
//                                                                           Container(
//                                                                               child: Text(widget.settleCon.finalcouponsettled[index].payNo.toString(), style: theme.textTheme.bodyText1!.copyWith())),
//                                                                         ],
//                                                                       )),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ));
//                                               }),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: Screens.padingHeight(context) * 0.01,
//                                 ),
//                                 Container(
//                                   //alignment: Alignment.center,
//                                   // color: Colors.amber,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             widget.settleCon
//                                                 .insertsettledheader("Coupon");
//                                           },
//                                           child: Text("Save")),
//                                       SizedBox(
//                                         width: Screens.width(context) * 0.02,
//                                       ),
//                                       ElevatedButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text("Cancel")),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
