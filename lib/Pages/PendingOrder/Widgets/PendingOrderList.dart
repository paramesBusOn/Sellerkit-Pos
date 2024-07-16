// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/PendingOrderController/PendingOrderController.dart';
import 'PendingListItem.dart';

class PendingorderTab extends StatefulWidget {
  PendingorderTab({
    Key? key,
    required this.theme,
    required this.btnWidth,
    required this.btnheight,
    // required this.posController
  }) : super(key: key);

  final ThemeData theme;
  double btnheight;
  double btnWidth;

  @override
  State<PendingorderTab> createState() => _PendingorderTabState();
}

class _PendingorderTabState extends State<PendingorderTab> {
  // final PendingOrderController posController;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: context.watch<PendingOrderController>().soSalesmodl.isEmpty
            ? Container(
                alignment: Alignment.center,
                child: const Text("No Pending Order Here..!!"),
              )
            : Container(
                // color: Colors.red,
                height: widget.btnheight * 3.5,
                padding: EdgeInsets.all(widget.btnheight * 0.02),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(widget.btnheight * 0.06),
                      height: widget.btnWidth * 0.07,
                      color: widget.theme.primaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widget.btnWidth * 0.4,
                            // color: Colors.green,
                            child: Text("S.O Number",
                                style: widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            // color: Colors.green,
                            width: widget.btnWidth * 0.6,

                            alignment: Alignment.center,
                            child: Text("Customer Name",
                                style: widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.2,
                            // color: Colors.green,
                            child: Text("Date",
                                style: widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: widget.btnWidth * 0.25,
                            // color: Colors.red,
                            child: Text("Total",
                                style: widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(widget.btnheight * 0.02),
                      height: widget.btnheight * 3.2,
                      width: double.infinity,
                      // color: Colors.amber,
                      child: ListView.builder(
                          itemCount: context.watch<PendingOrderController>().soSalesmodl.length,
                          itemBuilder: (context, index) {
                            return Card(
                                margin: EdgeInsets.all(0.5),
                                // color: Colors.grey[200],
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  onTap: () {
                                    context.read<PendingOrderController>().soOrderdata(context.read<PendingOrderController>().soSalesmodl[index].docentry.toString(), index);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PendingListItem(
                                                  theme: widget.theme,
                                                  btnWidth: widget.btnWidth,
                                                  btnheight: widget.btnheight,
                                                )));
                                  },
                                  title: Container(
                                    padding: EdgeInsets.only(left: widget.btnWidth * 0.01, right: widget.btnWidth * 0.01),
                                    //   color: Colors.amber,
                                    width: widget.btnWidth * 0.77,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            // color: Colors.red,
                                            width: widget.btnWidth * 0.4,
                                            child: Text(
                                              "Order / ${context.watch<PendingOrderController>().soSalesmodl[index].invoiceNum.toString()}",
                                              style: widget.theme.textTheme.bodyLarge!.copyWith(),
                                            )),
                                        Container(
                                            alignment: Alignment.center,
                                            // color: Colors.red,
                                            width: widget.btnWidth * 0.6,
                                            child: Text(
                                              context.watch<PendingOrderController>().soSalesmodl[index].custName.toString(),
                                              style: widget.theme.textTheme.bodyLarge!.copyWith(),
                                            )),
                                        Container(
                                            width: widget.btnWidth * 0.2,
                                            alignment: Alignment.center,
                                            // color: Colors.pink,
                                            child: Text(
                                              context.watch<PendingOrderController>().soSalesmodl[index].invoceDate.toString(),
                                              style: widget.theme.textTheme.bodyLarge!.copyWith(),
                                            )),
                                        Container(
                                            alignment: Alignment.centerRight,
                                            width: widget.btnWidth * 0.25,
                                            // color: Colors.pink,

                                            child: Text(context.watch<PendingOrderController>().soSalesmodl[index].invoceAmount!.toStringAsFixed(2))),
                                      ],
                                    ),
                                  ),
                                ));
                          }),
                    ),
                  ],
                ),
              ));
  }
}
