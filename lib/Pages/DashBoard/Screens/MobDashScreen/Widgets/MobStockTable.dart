// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../Controller/DashBoardController/DashboardController.dart';

class MobStockTable extends StatelessWidget {
  MobStockTable(
      {super.key,
      required this.theme,
      required this.dbWidth,
      required this.dbHeight,
      required this.prdDBC});
  double dbHeight;
  double dbWidth;
  DashBoardController prdDBC;
  ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey.withOpacity(0.1),

        width: dbWidth,
        // height: dbHeight * 1.11,
      padding: EdgeInsets.only(
        left: dbWidth * 0.015,
        right: dbWidth * 0.015,
        top: dbHeight * 0.01,
        bottom: dbHeight * 0.01,
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: dbWidth * 0.015,
                right: dbWidth * 0.02,
              ),
              child: Text(
                "Out Of Stock Item",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: dbHeight * 0.01),
            Container(
              color: theme.primaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: theme.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                      "S.No",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    // alignment: Alignment.center,
                    color: theme.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                    child: Text(
                      "Item",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    color: theme.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    child: Text(
                      "Quantity",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                      child: Container(
                         decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(
                      dbHeight * 0.01,
                    ),
                    // height: dbHeight * 0.17,
                    width: dbWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: dbWidth * 0.09,
                          child: Text('1',
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(fontSize: 16)),
                        ),
                        SizedBox(
                          width: dbWidth * 0.7,
                          child: Text(
                            "Unilet / Extended Warranty / 1 Year /Directcool >12000 1Yr",
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: dbWidth * 0.09,
                          child: Text(
                            '3',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ));
                }),
            // Container(
            //     color: Colors.grey.withOpacity(0.1),
            //     child: createTable(theme, prdDBC))
          ],
        ),
      ),
    );
  }

  // TargetTabController prdFUP
  // Widget createTable(ThemeData theme, DashBoardController prdearn) {
  //   List<TableRow> rows = [];
  //   rows.add(TableRow(children: [
  //     Container(
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //       child: Text(
  //         "S.No",
  //         style: theme.textTheme.bodyLarge?.copyWith(
  //           fontWeight: FontWeight.normal,
  //           fontSize: 16,
  //           color: Colors.white,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //     Container(
  //       // alignment: Alignment.center,
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //       child: Text(
  //         "Item",
  //         style: theme.textTheme.bodyLarge?.copyWith(
  //           fontWeight: FontWeight.normal,
  //           fontSize: 16,
  //           color: Colors.white,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //     Container(
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
  //       child: Text(
  //         "Quantity",
  //         style: theme.textTheme.bodyLarge?.copyWith(
  //           fontWeight: FontWeight.normal,
  //           color: Colors.white,
  //           fontSize: 16,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   ]));
  //   print("Above Row");
  //   for (int i = 0; i < 15; ++i) {
  //     // print("in Row");
  //     rows.add(TableRow(children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //         child: Container(
  //           height: dbHeight * 0.05,
  //           alignment: Alignment.center,
  //           child: Text(
  //             "1",
  //             textAlign: TextAlign.left,
  //             style: theme.textTheme.bodyText1?.copyWith(
  //               fontSize: 16,
  //               // color: theme.primaryColor,
  //             ),
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //         child: Text(
  //           "Unilet / Extended Warranty / 1 Year /Directcool >12000 1Yr",
  //           textAlign: TextAlign.left,
  //           style: theme.textTheme.bodyText2?.copyWith(
  //             fontSize: 16,
  //             // color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
  //         child: Container(
  //           alignment: Alignment.center,
  //           child: Text(
  //             "3",
  //             //  earnKeyss[i].amount!.toStringAsFixed(2),
  //             textAlign: TextAlign.left,
  //             style: theme.textTheme.bodyText2?.copyWith(
  //               fontSize: 16,
  //               // color: theme.primaryColor,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ]));
  //   }
  //   return Table(
  //       border: TableBorder(
  //           horizontalInside: BorderSide(
  //               width: 1, color: Colors.grey, style: BorderStyle.solid)),
  //       columnWidths: {
  //         0: FlexColumnWidth(1.2), //date
  //         1: FlexColumnWidth(4.2), //trans
  //         2: FlexColumnWidth(1.5), //amnnt
  //       },
  //       children: rows);
  // }
}
