// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/StockCheckController/StockCheckController.dart';

class Search_Widget extends StatelessWidget {
  Search_Widget(
      {Key? key, required this.searchHeight, required this.searchWidth})
      : super(key: key);

  double searchHeight;
  double searchWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: searchHeight,
      width: searchWidth,
      padding: EdgeInsets.only(
          top: searchHeight * 0.01,
          left: searchHeight * 0.01,
          right: searchHeight * 0.01,
          bottom: searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              alignment: Alignment.center,
              width: searchWidth * 1,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                style: theme.textTheme.bodyMedium,
                onChanged: (v) {
                  context.read<StockCheckController>().filterListSearched(v);
                },
                cursorColor: Colors.grey,
                // controller: stChCon.mycontroller[99],
                onEditingComplete: () {},
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Search Here..',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      //  color: Colors.grey
                      //   fontWeight: FontWeight.normal
                      ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  // suffixIcon: IconButton(
                  //   icon: Icon(
                  //     Icons.search,
                  //     // size: searchHeight * 0.05,
                  //     color: Colors.grey,
                  //   ),
                  //   onPressed: () async {},
                  //   color: theme.primaryColor,
                  // ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                ),
              )),
          SizedBox(
            height: searchHeight * 0.01,
          ),
          Container(
            padding: EdgeInsets.only(
              top: searchHeight * 0.01,
              left: searchHeight * 0.01,
              right: searchHeight * 0.01,
              bottom: searchHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            //  height: searchHeight * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    //  color: Colors.red,
                    alignment: Alignment.center,
                    width: searchWidth * 0.05,
                    child: Text(
                      "S.No",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )),
                Container(
                    //  color: Colors.red,
                    alignment: Alignment.center,
                    width: searchWidth * 0.29,
                    child: Text(
                      "Item Name",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )),
                Container(
                    // color: Colors.red,
                    alignment: Alignment.center,
                    width: searchWidth * 0.12,
                    child: Text(
                      "Item Code",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )),
                Container(
                    // color: Colors.red,
                    alignment: Alignment.center,
                    width: searchWidth * 0.10,
                    child: Text(
                      "Serialbatch",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    )),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      width: searchWidth * 0.08,
                      child: Text(
                        "Qty",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      )),
                ),
                 GestureDetector(
                  onTap: () {},
                  child: Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      width: searchWidth * 0.08,
                      child: Text(
                        "Price",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      )),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      width: searchWidth * 0.08,
                      child: Text(
                        "Branch",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
              child: context.watch<StockCheckController>().listbool == true &&
                      context
                          .watch<StockCheckController>()
                          .filterStockSnapList
                          .isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : context.watch<StockCheckController>().listbool == false &&
                          context
                              .watch<StockCheckController>()
                              .filterStockSnapList
                              .isEmpty
                      ? Center(child: Text("Does Not Have data..!!"))
                      : ListView.builder(
                          itemCount: context
                              .watch<StockCheckController>()
                              .filterStockSnapList
                              .length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: searchHeight * 0.01,
                                    left: searchHeight * 0.01,
                                    right: searchHeight * 0.01,
                                    bottom: searchHeight * 0.02,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey.withOpacity(0.04),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: searchWidth * 0.05,
                                          child: Text(
                                            "${index + 1}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: searchWidth * 0.29,
                                          child: Text(
                                            "${context.watch<StockCheckController>().filterStockSnapList[index].itemname}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: searchWidth * 0.12,
                                          child: Text(
                                            "${context.watch<StockCheckController>().filterStockSnapList[index].itemCode}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: searchWidth * 0.10,
                                          child: Text(
                                            "${context.watch<StockCheckController>().filterStockSnapList[index].serialbatch}",
                                            // textAlign: TextAlign.left,
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: searchWidth * 0.08,
                                          child: Text(
                                            "${context.watch<StockCheckController>().filterStockSnapList[index].qty}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                             Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: searchWidth * 0.08,
                                          child: Text(
                                            "${context.watch<StockCheckController>().filterStockSnapList[index].price}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                      Container(
                                          // color: Colors.red,
                                          alignment: Alignment.center,
                                          width: searchWidth * 0.08,
                                          child: Text(
                                            "${context.watch<StockCheckController>().filterStockSnapList[index].branch}",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
        ],
      ),
    );
  }
}
