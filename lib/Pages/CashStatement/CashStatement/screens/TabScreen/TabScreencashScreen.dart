// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/CashStatementController/CashSatementCont.dart';

class TabCashSattement extends StatelessWidget {
  const TabCashSattement({
    Key? key,
    required this.theme,
    // required this.stRegCon,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.95,
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Screens.width(context),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: TextField(
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
                keyboardType: TextInputType.text,
                onChanged: (val) {
                  //  setState(() {
                  context.read<CashStateCon>().filterListSearched(val);
                  //  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  hintText: "Inventories",
                  hintStyle: theme.textTheme.bodyMedium!.copyWith(),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
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
              height: Screens.bodyheight(context) * 0.01,
            ),
            createTable(theme, context)
          ],
        ),
      ),
    );
  }

  Widget createTable(ThemeData theme, BuildContext context) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Document No",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Branch-Terminal",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "DocType",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Customer",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Rc Amount",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Expense",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Date",
          style: theme.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]));
    for (int i = 0;
        i < context.watch<CashStateCon>().getfiltersalesReg.length;
        ++i) {
      rows.add(TableRow(children: [
        InkWell(
          onTap: () {
            log(context.read<CashStateCon>().getfiltersalesReg[i].docno!);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Text(
              '${context.watch<CashStateCon>().getfiltersalesReg[i].docno}',
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyLarge?.copyWith(
                  //color: theme.primaryColor,
                  ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<CashStateCon>().getfiltersalesReg[i].branch}\n${context.watch<CashStateCon>().getfiltersalesReg[i].terminal}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
                // color: theme.primaryColor,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<CashStateCon>().getfiltersalesReg[i].doctype}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
                //  color: theme.primaryColor,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<CashStateCon>().getfiltersalesReg[i].cardcode}\n${context.watch<CashStateCon>().getfiltersalesReg[i].cardname}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
                // color: theme.primaryColor,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<CashStateCon>().getfiltersalesReg[i].amount}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
                //  color: theme.primaryColor,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<CashStateCon>().getfiltersalesReg[i].expense}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
                //color: theme.primaryColor,
                ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<CashStateCon>().getfiltersalesReg[i].date}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
                //color: theme.primaryColor,
                ),
          ),
        ),
      ]));
    }
    return Table(columnWidths: const {
      0: FlexColumnWidth(0.8),
      1: FlexColumnWidth(0.6),
      2: FlexColumnWidth(0.5),
      3: FlexColumnWidth(0.8),
      5: FlexColumnWidth(0.4),
    }, children: rows);
  }
}
