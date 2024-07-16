// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/ExpenseController/ExpenseController.dart';
import 'package:posproject/Models/ExpenseModel/expensecode.dart';
import 'package:provider/provider.dart';

import '../../../Models/ExpenseModel/paidfrom.dart';

class MobScreen extends StatefulWidget {
  const MobScreen({
    Key? key,
    // required this.ExpenseCon,
  }) : super(key: key);

  @override
  // ExpenseController ExpenseCon;
  State<MobScreen> createState() => _MobScreenState();
}

class _MobScreenState extends State<MobScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      // height: Screens.fullHeight(context),
      // width: Screens.fullHeight(context),
      //    color: Colors.red,
      child: Column(
        children: [
         
          Padding(
            padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.03,
                left: Screens.width(context) * 0.03,
                right: Screens.width(context) * 0.03,
                bottom: Screens.padingHeight(context) * 0.03),
            child: Container(
              padding: EdgeInsets.only(
                  top: Screens.padingHeight(context) * 0.00,
                  left: Screens.width(context) * 0.03,
                  right: Screens.width(context) * 0.03),
              height: Screens.padingHeight(context) * 1,
              color: Colors.white,
              child: Form(
                key: context.watch<ExpenseController>().formkey[0],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    
                    Container(
                      // color: Colors.amber,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //width: Screens.width(context)*0.80,
                            // padding: EdgeInsets.only(
                            //     left: Screens.width(context) * 0.03,
                            //     right: Screens.width(context) * 0.03),
                            
                            decoration: BoxDecoration(
                            // color: Colors.amber,
                                // border: Border.all(
                                //     color: theme.primaryColor, width: 1)
                                 ),
                            child: DropdownButtonFormField(
                              
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
    
                                    
                                    
                                           
                                            hintText: " Expense codeeee",
                                            hintStyle:
                                                theme.textTheme.bodyLarge),
                                        value: context.watch<ExpenseController>().codeValue,
                                        onChanged: ( valueitem) {
                                setState(() {
                                   context.watch<ExpenseController>().codeValue == valueitem!;
                                });
                                         
                                        },
                                        items: context.watch<ExpenseController>().expCode
                                            .map(( codeforexpense valueitem) {
                                          return DropdownMenuItem(
                                            value: valueitem,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                      Screens.width(context) *
                                                          0.01),
                                              child: Text(
                                                valueitem.expensecode,
                                                style:
                                                    theme.textTheme.bodyLarge,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.03,
                          ),
              
                          SizedBox(
                            width: Screens.width(context),
                            child: TextFormField(
                              controller: context.watch<ExpenseController>().mycontroller[0],
                              validator: (data) {
                                              if (data!.isEmpty) {
                                                return "Required*";
                                              }
                                              return null;
                                            },
                              decoration: InputDecoration(
                                labelText: 'Reference',
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
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.03,
                          ),
                          Container(
    
                            child: TextFormField(
                              controller: context.watch<ExpenseController>().mycontroller[1],
                              validator: (data) {
                                            if (data!.isEmpty) {
                                              return "Required*";
                                            }
                                            return null;
                                          },
                              decoration: InputDecoration(
                                labelText: 'Expense Amount',
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
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.03,
                          ),
                          Container(
                            child: TextFormField(
                              controller: context.watch<ExpenseController>().mycontroller[2],
                              validator: (data) {
                                            if (data!.isEmpty) {
                                              return "Required*";
                                            }
                                            return null;
                                          },
                              decoration: InputDecoration(
                                //     fillColor: Colors.grey[100],
                                //   filled: true,
                                labelText: 'Paid to',
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
                          ), //TextField
              
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.03,
                          ),
                          Container(
              //width: Screens.width(context)*0.80,
                            // padding: EdgeInsets.only(
                            //     left: Screens.width(context) * 0.03,
                            //     right: Screens.width(context) * 0.03),
                            // color: Colors.amber,
                            decoration: BoxDecoration(
                                
                                ),
              
                            child: DropdownButtonFormField<String>(
                                //           hint: Text('Expense code'),
                                validator: (value) => value == null ? 'field required' : null,
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
                                value: context.watch<ExpenseController>().chosenValue,
                                items:context.watch<ExpenseController>().paidFromData .map<DropdownMenuItem<String>>((PaidFrom value) {
                                  return DropdownMenuItem<String>(
                                    value: value.accountname,
                                    child: Text(
                                      value.accountname!,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Paid From",
                                ),
                                onChanged: (String? value) {
                                 
                                  setState(() {
                                    context.read<ExpenseController>().chosenValue = value!;
                                  
                                  });
                                }),
                          ),
                          SizedBox(
                            height: Screens.padingHeight(context) * 0.03,
                          ), //dropdown
              
                          //       Row(
                          //         //mainAxisAlignment: MainAxisAlignment.center,
              
                          //         children: [
                          //           Text(
                          //             'Rs.35000',
                          //             style: theme.textTheme.bodyText1
                          //                 ?.copyWith(fontWeight: FontWeight.bold),
                          //           ),
                          //           SizedBox(
                          //             width: Screens.width(context) * 0.03,
                          //           ),
                          //           Text('Main Cash',
                          //               style: theme.textTheme.bodyText1
                          //                   ?.copyWith(fontWeight: FontWeight.bold)),
                          //         ],
                          //       ),
                        ],
                      ),
                    ), //dropdown
              
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.05,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<ExpenseController>().insertExpenseTable(
                                    "suspend", context, theme);
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(100, 50),
                                  backgroundColor: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  )),
                              child: Text('Suspend'),
                            ),
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                               context.read<ExpenseController>().insertExpenseTable(
                                    "hold", context, theme);
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(100, 50),
                                  backgroundColor: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  )),
                              child: Text('Hold'),
                            ),
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                               context.read<ExpenseController>().insertExpenseTable(
                                    "submit", context, theme);
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(100, 50),
                                  backgroundColor: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
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
          )
        ],
      ),
    );
  }
}
