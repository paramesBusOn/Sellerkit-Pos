// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Pages/Expenses/widgets/BillingOptions.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/ExpenseController/ExpenseController.dart';
import '../../Sales Screen/Widgets/QuickOptions.dart';

class PosExpenseScreen extends StatefulWidget {
  PosExpenseScreen({
    Key? key,required this.ExpenseCon
  }) : super(key: key);

  ExpenseController ExpenseCon;
  @override
  State<PosExpenseScreen> createState() => _PosExpenseScreenState();
}

class _PosExpenseScreenState extends State<PosExpenseScreen> {
  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // color: Colors.grey,
      child: Container(
        child: Row(
          children: [
            SizedBox(
              width: Screens.width(context) * 0.90,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: Screens.padingHeight(context) * 0.05,
                        left: Screens.width(context) * 0.04,
                        right: Screens.width(context) * 0.04,
                        bottom: Screens.padingHeight(context) * 0.05),
                    child: Container(
                      color: Colors.white,
                      height: Screens.padingHeight(context) * 0.90,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Screens.padingHeight(context) * 0.05,
                            left: Screens.width(context) * 0.04,
                            right: Screens.width(context) * 0.04,
                            bottom: Screens.padingHeight(context) * 0.03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              //                           color: Colors.deepOrange,

                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Text(
                                        'Expense Code:',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      )),
                                      Container(
                                        // height: Screens.padingHeight(context) *
                                        //     0.07,
                                        width: Screens.width(context) * 0.50,
                                        decoration: BoxDecoration(

                                            //color: Colors.amber,

                                        ),
                                        child: DropdownButtonFormField<String>(
                                           validator: (value) => value == null ? 'field required' : null,
       

                                            //           hint: Text('Expense code'),

                                            decoration: InputDecoration(
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
              borderSide: BorderSide(color:theme.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color:theme.primaryColor),
                ),
                                                
                                                ),
                                            icon: Icon(Icons.arrow_drop_down),
                                            value: widget.ExpenseCon.codeValue,
                                            items: <String>[
                                              'item1',
                                              'item2',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              );
                                            }).toList(),
                                            hint: Text(
                                              "",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            onChanged: (String? value) {
                                              setState(() {
                                                widget.ExpenseCon.codeValue = value!;
                                              });
                                            }),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          //      width: Screens.width(context) * 0.30,
                                          child: Text(
                                        'Reference:',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      )),
                                      SizedBox(
                                        width: Screens.width(context) * 0.50,
                                        // height: Screens.padingHeight(context) *
                                        //     0.06,
                                        child: TextFormField(
                                           controller: widget.ExpenseCon.mycontroller[0],
                validator: (data) {
                              if (data!.isEmpty) {
                                return "Required*";
                              }
                              return null;
                            },
                                          decoration: InputDecoration(
                                            labelText: '',
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
              borderSide: BorderSide(color:theme.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color:theme.primaryColor),
                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(

                                          // color: Colors.amber,

                                          //      width: Screens.width(context) * 0.30,
                                          child: Text(
                                        'Expense Amount:',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      )),
                                      SizedBox(
                                        //   color: Colors.amber,

                                        width: Screens.width(context) * 0.50,

                                        // height: Screens.padingHeight(context) *
                                        //     0.06,

                                        child: TextFormField(
                                          controller: widget.ExpenseCon.mycontroller[1],
                validator: (data) {
                              if (data!.isEmpty) {
                                return "Required*";
                              }
                              return null;
                            },
                                          decoration: InputDecoration(
                                            labelText: '',
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
              borderSide: BorderSide(color:theme.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color:theme.primaryColor),
                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          //    width: Screens.width(context) * 0.30,

                                          //color: Colors.amber,

                                          child: Text(
                                        'Paid To:',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      )),
                                      SizedBox(
                                        width: Screens.width(context) * 0.50,
                                        // height: Screens.padingHeight(context) *
                                        //     0.06,
                                        child: TextFormField(
                                           controller: widget.ExpenseCon.mycontroller[2],
                validator: (data) {
                              if (data!.isEmpty) {
                                return "Required*";
                              }
                              return null;
                            },
                                          decoration: InputDecoration(
                                            labelText: '',
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
              borderSide: BorderSide(color:theme.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color:theme.primaryColor),
                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(

                                          //   color: Colors.amber,

                                          //     width: Screens.width(context) * 0.30,
                                          child: Text('Paid From:',
                                              style: theme.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold))),
                                      Container(
                                        // height: Screens.padingHeight(context) *
                                        //     0.07,

                                        width: Screens.width(context) * 0.50,

                                        //   padding: EdgeInsets.only(

                                        //     //top:Screens.padingHeight(context)*0.03,

                                        //  //   left:Screens.width(context)*0.03 ,

                                        //              //   right:Screens.width(context)*0.03

                                        //   ),

                                        decoration: BoxDecoration(

                                            //color: Colors.amber,

                                    ),

                                        child: DropdownButtonFormField<String>(
                                           validator: (value) => value == null ? 'field required' : null,
       

                                            //           hint: Text('Expense code'),

                                            decoration: InputDecoration(
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
              borderSide: BorderSide(color:theme.primaryColor),
                ),
                focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color:theme.primaryColor),
                ),
                                            ),
                                            icon: Icon(Icons.arrow_drop_down),
                                            value:widget.ExpenseCon.chosenValue,
                                            items: <String>[
                                              'item1',
                                              'item2',
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              );
                                            }).toList(),
                                            hint: Text(
                                              "",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            onChanged: (String? value) {
                                              setState(() {
                                               widget.ExpenseCon.chosenValue = value!;
                                              });
                                            }),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height:
                                  //       Screens.padingHeight(context) * 0.07,
                                  // ),
                                  // Row(
                                  //   //  mainAxisAlignment: MainAxisAlignment.center,

                                  //   children: [
                                  //     Text(
                                  //       'Rs.35000',
                                  //       style: theme.textTheme.bodyText1
                                  //           ?.copyWith(
                                  //               fontWeight: FontWeight.bold),
                                  //     ),
                                  //     SizedBox(
                                  //       width: Screens.width(context) * 0.03,
                                  //     ),
                                  //     Text('Main Cash',
                                  //         style: theme.textTheme.bodyText1
                                  //             ?.copyWith(
                                  //                 fontWeight: FontWeight.bold)),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: () {
                                         widget.ExpenseCon.insertExpenseTable(
                            "suspend", context, theme);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(150, 50),
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          )),
                                      child: Text('Suspend'),
                                    ),
                                  ),
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: () {
                                         widget.ExpenseCon.insertExpenseTable(
                            "hold", context, theme);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(150, 50),
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          )),
                                      child: Text('Hold'),
                                    ),
                                  ),
                                  Container(
                                    child: ElevatedButton(
                                      onPressed: () {
                                         widget.ExpenseCon.insertExpenseTable(
                            "submit", context, theme);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(150, 50),
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          )),
                                      child: Text('Submit'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SingleChildScrollView(child: Container(child: Column(
            children: [
              BillingOptions(theme: theme,),
              QuickOptions(),
            ],
          )))
          ],
        ),
      ),
    );
  }
}
