// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/DashBoardController/DashboardController.dart';

class Transaction extends StatefulWidget {
  Transaction({
    super.key,
    required this.theme,
    required this.dbWidth,
    required this.dbHeight,
  });
  double dbHeight;
  double dbWidth;

  ThemeData theme;

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: widget.dbHeight * 0.02, top: widget.dbHeight * 0.02),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white
          // color: Colors.grey.withOpacity(0.1),
          ),
      width: widget.dbWidth,
      height: widget.dbHeight * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Transaction Sync',
            style: widget.theme.textTheme.bodyMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: context.watch<DashBoardController>().syncData1.isEmpty && context.watch<DashBoardController>().syncdataBool == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : context.watch<DashBoardController>().syncData1.isEmpty && context.watch<DashBoardController>().syncdataBool == false
                    ? Center(
                        child: Text("No data..!!"),
                      )
                    : ListView.builder(
                        itemCount: context.watch<DashBoardController>().syncData1.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color:
                                      // context.watch<DashBoardController>().syncData1[index].sapNo == 0 &&
                                      context.watch<DashBoardController>().syncData1[index].qStatus != "C" ? Colors.redAccent : Colors.green),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(
                              widget.dbHeight * 0.02,
                            ),
                            // height: dbHeight * 0.18,
                            width: widget.dbWidth * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // width: dbWidth * 0.7,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: widget.dbWidth * 0.1,
                                        // color: Colors.grey,
                                        child: Text(
                                          "Doc No",
                                          style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: widget.dbWidth * 0.24,
                                        // color: Colors.amber,
                                        child: Text(
                                          "${context.watch<DashBoardController>().syncData1[index].DocNo}",
                                          style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: widget.dbWidth * 0.32,
                                        child: Text(
                                          "${context.watch<DashBoardController>().syncData1[index].doctype}",
                                          style: widget.theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: widget.dbWidth * 0.12,
                                        child: Text(
                                          "Doc Date",
                                          style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: widget.dbWidth * 0.15,
                                        child: Text(
                                          context.read<DashBoardController>().config.alignDate(context.watch<DashBoardController>().syncData1[index].Docdate.toString()),
                                          style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  // width: dbWidth * 0.7,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: widget.dbWidth * 0.1,
                                        // color: Colors.grey,
                                        child: Text(
                                          "Sap No",
                                          style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,

                                        width: widget.dbWidth * 0.24,
                                        // color: Colors.grey,
                                        child: Text(
                                          "${context.watch<DashBoardController>().syncData1[index].sapNo}",
                                          style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: widget.dbWidth * 0.32,
                                        // color: Colors.amber,
                                        child: Text(
                                          "${context.watch<DashBoardController>().syncData1[index].customername}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: widget.theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: widget.dbWidth * 0.12,
                                        // color: Colors.amber,
                                        child: Text(
                                          "Sap Date",
                                          style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: widget.dbWidth * 0.15,
                                        // color: Colors.amber,
                                        child: Text(
                                          context.read<DashBoardController>().config.alignDate(context.watch<DashBoardController>().syncData1[index].sapDate.toString()),
                                          style: widget.theme.textTheme.bodyMedium?.copyWith(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // Text('DC-ABV12K-1YR'),
                              ],
                            ),
                          ));
                        }),
          ),
          // SizedBox(height: dbHeight * 0.02),
          // Container(
          //   alignment: Alignment.centerRight,
          //   child: FloatingActionButton(
          //     onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => PosMainScreens(
          //               theme: theme,
          //             )));
          //     },
          //     child:  Image.asset('assets/cart.png'),
          //     // Icon(Icons.add),
          //   ),
          // )
        ],
      ),
    );
  }
}
