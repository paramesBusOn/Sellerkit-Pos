// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/main.dart';
import 'package:provider/provider.dart';

import '../../../Controller/DashBoardController/DashboardController.dart';

class Announcement extends StatelessWidget {
  Announcement(
      {super.key,
      required this.theme,
      required this.dbWidth,
      required this.dbHeight,
     });
  double dbHeight;
  double dbWidth;
  
  ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,

        //  color: Colors.grey.withOpacity(0.1),
      ),
      padding: EdgeInsets.all(
        dbHeight * 0.02,
      ),
      width: dbWidth * 1,
      height: dbHeight * 1.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: dbHeight * 0.02),
            child: Text(
              "Announcement",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: dbHeight * 0.02,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: context.watch<DashBoardController>().notify.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      config.showDialogBox(context.watch<DashBoardController>().notify[index].titile!,
                          context.watch<DashBoardController>().notify[index].description, context);
                    },
                    child: Card(
                        child: Container(
                      //  color: Colors.red,
                      width: dbWidth,
                      padding: EdgeInsets.symmetric(
                          vertical: dbHeight * 0.01,
                          horizontal: dbWidth * 0.01),

                      margin: EdgeInsets.symmetric(
                        vertical: dbHeight * 0.005,
                      ),

                      // decoration: BoxDecoration(
                      //   border: Border.all(color:
                      //       prdDBC.getnotify[index].seenTime ==
                      //               '0'
                      //           ? Colors.green.withOpacity(0.2)
                      //           : Colors.red,),
                      //           color:
                      //       prdDBC.getnotify[index].seenTime ==
                      //               '0'
                      //           ? Colors.green.withOpacity(0.1)
                      //           : Colors.red.withOpacity(0.1),
                      // ),

                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: dbHeight * 0.01,
                            horizontal: dbWidth * 0.02),
                        // color:
                        //     prdDBC.getnotify[index].seenTime ==
                        //             '0'
                        //         ? Colors.grey[200]
                        //         : Colors.white,
                        child: Column(children: [
                          SizedBox(
                            width: dbWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: dbWidth * 0.65,
                                  // color: Colors.red,
                                  child: Text(
                                    "${context.watch<DashBoardController>().getnotify[index].titile}",
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: dbWidth * 0.25,
                                  child: Text(
                                    context.read<DashBoardController>().config.alignDate(
                                        "${context.watch<DashBoardController>().getnotify[index].receiveTime}"),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: dbHeight * 0.02,
                          ),
                          SizedBox(
                            width: dbWidth,
                            child: Text(
                              "${context.watch<DashBoardController>().getnotify[index].description}",
                              maxLines: 1,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          context.watch<DashBoardController>().getnotify[index].imgUrl == 'null'
                              ? Container()
                              : SizedBox(
                                  width: dbWidth,
                                  height: dbHeight * 0.2,
                                  child: Center(
                                      child: Image(
                                          image: NetworkImage(
                                              '${context.watch<DashBoardController>().getnotify[index].imgUrl}'),
                                          fit: BoxFit.cover)),
                                ),
                        ]),
                      ),
                    )
                        //      Container(
                        //   padding: EdgeInsets.all(
                        //     dbHeight * 0.02,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.5),
                        //         spreadRadius: 3,
                        //         blurRadius: 7,
                        //         offset: Offset(0, 3), // changes position of shadow
                        //       ),
                        //     ],
                        //   ),
                        //   // height: dbHeight * 0.17,
                        //   width: dbWidth * 0.9,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         "${prdDBC.notify[index].titile}",
                        //         style:
                        //             theme.textTheme.bodyText2?.copyWith(fontSize: 16),
                        //       ),
                        //       Text(
                        //         "${prdDBC.notify[index].description}",
                        //         style:
                        //             theme.textTheme.bodyText2?.copyWith(fontSize: 16),
                        //       ),
                        //     ],
                        //   ),
                        // )
                        ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
