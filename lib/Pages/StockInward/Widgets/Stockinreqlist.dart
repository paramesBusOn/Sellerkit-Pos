// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/StockInwardController/StockInwardContler.dart';

class StockInReqList extends StatelessWidget {
  StockInReqList({Key? key, required this.theme, required this.searchHeight, required this.searchWidth}) : super(key: key);

  final ThemeData theme;
  double searchHeight;
  double searchWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: searchHeight * 0.02,
          left: searchHeight * 0.01,
          right: searchHeight * 0.01,
          bottom: searchHeight * 0.01,
        ),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
        width: searchWidth * 1,
        //  height:searchHeight*0.9 ,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(" Pending Inwards", style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    IconButton(
                        onPressed: () {
                          context.read<StockInwrdController>().init();
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              SizedBox(
                height: searchHeight * 0.01,
              ),

              SizedBox(
                height: searchHeight,
                // color: Colors.green,
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(5)
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 3,
                //     blurRadius: 7,
                //     offset: Offset(0, 3), // changes position of shadow
                //   ),
                // ],
                // ),
                child: context.read<StockInwrdController>().StockInward2.isNotEmpty
                    ? ListView.builder(
                        itemCount: context.read<StockInwrdController>().StockInward2.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // if (prdsrch
                              //     .StockInward[index].data.isNotEmpty) {
                              //   prdsrch.Selectindex(index);
                              //   prdsrch.passINDEX(index);
                              //   prdsrch.passList(
                              //       prdsrch.StockInward[index].data);
                              // } else if (prdsrch
                              //     .StockInward[index].data.isEmpty) {
                              //   showDialog(
                              //       context: context,
                              //       barrierDismissible: true,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //             contentPadding: EdgeInsets.all(0),
                              //             content: AlertBox(
                              //                 payMent: 'Alert',
                              //                 errormsg: true,
                              //                 widget: Center(
                              //                     child: ContentContainer(
                              //                   content:
                              //                       'This Item Saved in DraftBill..!!',
                              //                   theme: theme,
                              //                 )),
                              //                 buttonName: null));
                              //       });
                              // }
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.only(top: searchHeight * 0.01, left: searchHeight * 0.01, right: searchHeight * 0.01, bottom: searchHeight * 0.01),
                                decoration: BoxDecoration(color: Colors.grey[300]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Inventory Transfer From ${context.watch<StockInwrdController>().StockInward2[index].reqtoWhs}", style: theme.textTheme.bodyLarge),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("# ${context.watch<StockInwrdController>().config.alignDate(context.watch<StockInwrdController>().StockInward2[index].reqtransdate.toString())}", style: theme.textTheme.bodyLarge),
                                        Text('${context.watch<StockInwrdController>().StockInward2[index].branch}', style: theme.textTheme.bodyLarge)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : context.read<StockInwrdController>().StockInward.isEmpty && context.read<StockInwrdController>().dbDataTrue == true && context.read<StockInwrdController>().savedraftBill.isEmpty
                        ? Center(
                            child: Text(
                              "No data From Stock Request..!!",
                              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black),
                            ),
                          )
                        : context.watch<StockInwrdController>().StockInward.isEmpty && context.read<StockInwrdController>().savedraftBill.isNotEmpty
                            ? Center(
                                child: Text(
                                  "Data Save as Draft Bill..!!",
                                  style: theme.textTheme.bodyMedium!.copyWith(color: Colors.black),
                                ),
                              )
                            : context.watch<StockInwrdController>().StockInward.isEmpty && context.read<StockInwrdController>().dbDataTrue == false
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    itemCount: context.read<StockInwrdController>().StockInward.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          //       context
                                          // .read<StockInwrdController>()
                                          // .StInController[50].text=context ̰
                                          // .read<StockInwrdController>()
                                          // .StockInward[index].remarks!;
                                          context.read<StockInwrdController>().passData(theme, context, index);
                                          context.read<StockInwrdController>().setstatemethod();
                                          // print("asdas"+context.read<StockInwrdController>().StockInward[index].data.length.toString());
                                          // if (context.read<StockInwrdController>().StockInward[index].data
                                          //     .isNotEmpty) {
                                          //   context.read<StockInwrdController>().Selectindex(index);
                                          //   context.read<StockInwrdController>().passINDEX(index);
                                          //   context.read<StockInwrdController>().passList(context.read<StockInwrdController>()
                                          //       .StockInward[index].data);
                                          // } else if (context.read<StockInwrdController>().StockInward[index]
                                          //     .data.isEmpty) {
                                          //   showDialog(
                                          //       context: context,
                                          //       barrierDismissible: true,
                                          //       builder:
                                          //           (BuildContext context) {
                                          //         return AlertDialog(
                                          //             contentPadding:
                                          //                 EdgeInsets.all(0),
                                          //             content: AlertBox(
                                          //                 payMent: 'Alert',
                                          //                 errormsg: true,
                                          //                 widget: Center(
                                          //                     child:
                                          //                         ContentContainer(
                                          //                   content:
                                          //                       'This Item Saved in DraftBills..!!',
                                          //                   theme: theme,
                                          //                 )),
                                          //                 buttonName: null));
                                          //       });
                                          // }
                                        },
                                        child: Card(
                                          child: Container(
                                            padding: EdgeInsets.only(top: searchHeight * 0.01, left: searchHeight * 0.01, right: searchHeight * 0.01, bottom: searchHeight * 0.01),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),

                                                // color: (prdsrch.totalqty(index) !=
                                                //             prdsrch.totalscannedqty(
                                                //                 index) &&
                                                //         prdsrch.totalValdationqty(
                                                //                 index) !=
                                                //             0)
                                                //     ?
                                                //     // Colors.red
                                                //     Color(0xFFfcedee)
                                                //     // Color(0xFFebfaef)
                                                //     : (prdsrch.totalqty(index) ==
                                                //                 prdsrch.totalscannedqty(
                                                //                     index) &&
                                                //             prdsrch.totalValdationqty(
                                                //                     index) !=
                                                //                 0)
                                                //         ?
                                                //         // Colors.green
                                                //         Color(0xFFebfaef)
                                                //         : (prdsrch.totalqty(index) ==
                                                //                     prdsrch.totalscannedqty(
                                                //                         index) &&
                                                //                 prdsrch.totalValdationqty(index) == 0)
                                                //             ? Colors.grey.withOpacity(0.04)
                                                //             : Colors.grey.withOpacity(0.04),
                                                // borderRadius: BorderRadius.circular(5),
                                                // boxShadow: [
                                                //   BoxShadow(
                                                //     color: Colors.grey.withOpacity(0.5),
                                                //     spreadRadius: 3,
                                                //     blurRadius: 7,
                                                //     offset: Offset(0,
                                                //         3), // changes position of shadow
                                                //   ),
                                                // ],
                                                border: Border.all(color: context.watch<StockInwrdController>().selectIndex == index ? Colors.green : Colors.white)
                                                // border: Border.all(
                                                //    color: prdsrch.StockInward[index].scanToatal !=
                                                //         prdsrch.StockInward[index].transTotal
                                                //     ? Colors.red.withOpacity(0.3)
                                                //     // Color(0xFFfcedee)
                                                //     : (prdsrch.StockInward[index].scanToatal ==
                                                //                 prdsrch.StockInward[index]
                                                //                     .transTotal) &&
                                                //             (prdsrch.StockInward[index]
                                                //                         .scanToatal !=
                                                //                     0 &&
                                                //                 prdsrch.StockInward[index]
                                                //                         .transTotal !=
                                                //                     0)
                                                //         ? Colors.green.withOpacity(0.3)
                                                //         // Color(0xFFebfaef)
                                                //         : prdsrch.mainScannedTotal == 0 &&
                                                //                 prdsrch.mainTranTotal == 0
                                                //             ? Colors.white
                                                //             : Colors.white,),
                                                ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                
                                                Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  children: [
                                                    Text("Inventory Transfer From ${context.watch<StockInwrdController>().StockInward[index].reqtoWhs}", style: theme.textTheme.bodyLarge),
                                                
                                                
                                                    Text("OutWard  Num: ${context.watch<StockInwrdController>().StockInward[index].documentno}", style: theme.textTheme.bodyLarge),
                                                 
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("# ${context.watch<StockInwrdController>().config.alignDate(context.watch<StockInwrdController>().StockInward[index].reqtransdate.toString())}", style: theme.textTheme.bodyLarge),
                                                    Text('Req Num: ${context.watch<StockInwrdController>().StockInward[index].reqdocumentno}', style: theme.textTheme.bodyLarge)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
              )

// Container(),
            ],
          ),
        ));
  }
}
