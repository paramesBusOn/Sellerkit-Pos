// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/PendingOrderController/PendingOrderController.dart';

class PendingListItem extends StatefulWidget {
  PendingListItem(
      {Key? key,
      required this.theme,
      required this.btnWidth,
      required this.btnheight,
      // required this.posController
      })
      : super(key: key);

  final ThemeData theme;
  double btnheight;
  double btnWidth;
  // final PendingOrderController posController;

  @override
  State<PendingListItem> createState() => _PendingListItemState();
}

class _PendingListItemState extends State<PendingListItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Pending Order Items'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: widget.theme.primaryColor,
      ),
      body: SafeArea(
        child: Container(
          // color: Colors.red,
          padding: EdgeInsets.all(
            widget.btnheight * 0.02,
          ),
          // height: widget.btnheight * 2.3,
          // width: widget.btnWidth * 1,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: widget.btnWidth * 1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3), //color of shadow
                        spreadRadius: 3, //spread radius
                        blurRadius: 2, // blur radius
                        offset: const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller:context.read<PendingOrderController>().searchcontroller[1],
                    style: widget.theme.textTheme.bodyMedium!
                        .copyWith(color: Colors.black),
          
                    onChanged: (val) {
                      setState(() {
                       context.read<PendingOrderController>().filterListItem(val);
                      });
                    },
                    onEditingComplete: () {},
                    // Only numbers can be entered
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(8),
                      hintText: "Search here..!!",
                      hintStyle: widget.theme.textTheme.bodyMedium!
                          .copyWith(color: const Color(0xFF757575)),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.btnheight * 0.05,
                ),
            context.read<PendingOrderController>().getsoData.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                              height: widget.btnheight * 0.19,
                              padding: EdgeInsets.only(
                                left: widget.btnWidth * 0.02,
                                right: widget.btnWidth * 0.02,
                              ),
                              color: widget.theme.primaryColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.btnWidth * 0.15,
                                    child: Text("Item Code",
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: Colors.white,
                                        )),
                                  ),
                                  Container(
                                    // color: Colors.yellow,
                                    alignment: Alignment.center,
                                    width: widget.btnWidth * 0.9,
          
                                    child: Text("Item Name",
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: Colors.white,
                                        )),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: widget.btnWidth * 0.17,
                                    // color: Colors.red,
                                    child: Text("Serial Batch",
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: Colors.white,
                                        )),
                                  ),
                                  Container(
                                    width: widget.btnWidth * 0.15,
                                    alignment: Alignment.center,
                                    child: Text("S.O Qty",
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: Colors.white,
                                        )),
                                  ),
                                  SizedBox(
                                    width: widget.btnWidth * 0.15,
                                    child: Text(" Balance Qty",
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              )),
                          SizedBox(
                            // color: Colors.amber,
                            height: widget.btnheight * 3,
          
                            // width: widget.btnWidth * 1.5,
                            child: ListView.builder(
                                itemCount:
                                   context.watch<PendingOrderController>().filteritems.length,
                                itemBuilder: (context, index) {
                                  print(
                                      "  widget.posController.filteritems.length::${context.watch<PendingOrderController>().filteritems.length}");
                                  return Card(
                                      // color: Colors.red,
                                      child: Container(
                                    padding: const EdgeInsets.all(6),
                                    width: widget.btnWidth * 11,
                                    height: widget.btnheight * 0.25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: widget.btnWidth * 0.18,
                                            // color: Colors.green,
                                            child: Text(
                                            context.watch<PendingOrderController>()
                                                  .filteritems[index].ItemCode
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(),
                                            )),
                                        Container(
                                            alignment: Alignment.center,
          
                                            // color: Colors.green,
                                            width: widget.btnWidth * 0.9,
                                            child: Text(
                                             context.watch<PendingOrderController>()
                                                  .filteritems[index].ItemName
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(),
                                            )),
                                        Container(
                                            alignment: Alignment.center,
                                            // color: Colors.pink,
                                            width: widget.btnWidth * 0.25,
                                            child: Text(
                                            context.watch<PendingOrderController>()
                                                  .filteritems[index].SerialBatch
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(),
                                            )),
                                        Container(
                                            alignment: Alignment.center,
                                            // color: Colors.green,
                                            width: widget.btnWidth * 0.15,
                                            child: Text(
                                             context.watch<PendingOrderController>()
                                                  .filteritems[index].Qty
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(),
                                            )),
          
                                        Container(
                                            alignment: Alignment.center,
                                            // color: Colors.green,
                                            width: widget.btnWidth * 0.15,
                                            child: Text(
                                             context.watch<PendingOrderController>()
                                                  .filteritems[index].OpenQty
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyLarge!
                                                  .copyWith(),
                                            )),
                                        // Container(
                                        //     width: widget.btnWidth * 0.08,
                                        //     // height: widget.btnheight * 0.16,
                                        //     // color: Colors.blue,
                                        //     alignment: Alignment.center,
                                        //     child: TextFormField(
                                        //       // readOnly: true,
                                        //       style: widget.theme.textTheme.bodyText2,
                                        //       onChanged: (v) {},
                                        //       cursorColor: Colors.grey,
                                        //       textDirection: TextDirection.rtl,
                                        //       keyboardType: TextInputType.number,
                                        //       onEditingComplete: () {
                                        //         // prdCD.itemIncrement11(
                                        //         //     index, context, theme);
                                        //       },
                                        //       controller: widget.posController
                                        //           .soqtycontroller[index],
                                        //       decoration: InputDecoration(
                                        //         enabledBorder: OutlineInputBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(5),
                                        //           borderSide: BorderSide(
                                        //               color: Colors.grey),
                                        //         ),
                                        //         focusedBorder: OutlineInputBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(5),
                                        //           borderSide: BorderSide(
                                        //               color: Colors.grey),
                                        //         ),
                                        //         contentPadding:
                                        //             const EdgeInsets.symmetric(
                                        //           vertical: 5,
                                        //           horizontal: 5,
                                        //         ),
                                        //       ),
                                        //     )),
                                      ],
                                    ),
                                  ));
                                }),
                          ),
                        ],
                      )
                    : Container(),
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: GestureDetector(
                // onTap: () {
                //   Navigator.pop(context);
                //   widget.posController.cpyfrmso = "CopyfromSo";
                //   widget.posController.mapsodata(
                //     context,
                //     theme,
                //   );
                // },
                //       child: Container(
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5),
                //           color: theme.primaryColor,
                //         ),
                //         height: widget.btnheight * 0.2,
                //         width: widget.btnWidth * 0.25,
                //         child: Text("OK",
                //             style: theme.textTheme.bodyMedium?.copyWith(
                //               fontWeight: FontWeight.w500,
                //               color: Colors.white,
                //             )),
                //       )),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
