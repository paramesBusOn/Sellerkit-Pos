import 'package:flutter/material.dart';
import '../../../../../Constant/Screen.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import '../../../../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';

ScanAlertbox(
    BuildContext context, StockInwrdController stinCon,
    StockInwardDetails? datalist, int? ind, int? index) async {
  return StatefulBuilder(builder: (context, st) {
     final theme = Theme.of(context);
    double stinHeight = Screens.bodyheight(context) * 0.5;
    double stinWidth = Screens.width(context);
    return Container(
      padding: EdgeInsets.only(
          top: stinHeight * 0.01,
          left: stinHeight * 0.01,
          right: stinHeight * 0.01,
          bottom: stinHeight * 0.008),
      child: SingleChildScrollView(
        //  shrinkWrap: true,
        physics: const BouncingScrollPhysics(), // new
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: stinWidth * 0.95,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 190, 183, 183)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                controller: stinCon.StInController[0],
                cursorColor: Colors.grey,
                onChanged: (v) {
                  if (v.isNotEmpty) {
                    st(() {
                      stinCon.msg = "";
                    });
                  }
                },
                onEditingComplete: () {
                  st(() {
                    // stinCon.scanmethod(index!, datalist!.serialBatch!, ind!);

                    // StIn_Con.scanmethod(index, StIn_Con.StInController[0].text, list_i);
                    // StIn_Con.msg="";
                    // StIn_Con.Scan(TransQty, Stock_i, StList_i);
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Scan here..',
                  hintStyle:
                      theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                  filled: false,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    // vertical: 12,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "${stinCon.msg}",
                  style: theme.textTheme.bodySmall!.copyWith(color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: stinHeight * 0.001),
            Container(
                height: stinHeight * 0.9,
                width: stinWidth * 1.1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                child:datalist!.serialbatchList == null
                    ? const Center(
                        child: Text("Scan Item.."),
                      )
                    :  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(), // new

                    itemCount: datalist.serialbatchList!.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.all(stinHeight * 0.005),
                        child: Container(
                          width: stinHeight * 0.95,
                          // height: ProHeight * 0.3,

                          decoration: BoxDecoration(
                              color: 
                              // datalist.serialbatchList![i].scanbool == true
                              //     ? Color(0xFFebfaef)
                              //     : Colors.white,
                              // border: Border.all(
                              //     color:
                              //         datalist.serialbatchList![i].scanbool == true
                              //             ? Colors.green.withOpacity(0.3)
                              //             : 
                                          Colors.white,
                                          // ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: ListTile(
                            onTap: () {},
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.38,
                                      // color: Colors.amber,
                                      child: Text(
                                        datalist.serialbatchList![i].itemcode!,
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.38,
                                      // color: Colors.amber,
                                      child: Text(
                                        datalist.serialbatchList![i].serialbatch!,
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  });
}
