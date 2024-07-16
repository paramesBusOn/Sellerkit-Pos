// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../Constant/Screen.dart';
import '../../../Controller/StockOutwardController/StockOutwardController.dart';

class SearchSearialBatch extends StatefulWidget {
  SearchSearialBatch({
    super.key,
    required this.index,
    required this.list_i,
  });
  int index;
  int list_i;

  @override
  State<SearchSearialBatch> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchSearialBatch> {
  @override
  Widget build(BuildContext context) {
    // StockOutwardDetails? datalist;
    final theme = Theme.of(context);
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Container(
          width: Screens.width(context),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: Screens.width(context) * 0.93,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 240, 235, 235)),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: TextField(
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.text,
                      onEditingComplete: () {},
                      onChanged: (val) {
                        setState(() {
                          context
                              .read<StockOutwardController>()
                              .filterListSearched(val);
                        });
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
                  Container(
                    // alignment: Alignment.topCenter,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        icon: Icon(Icons.close)),
                  )
                ],
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: context
                        .read<StockOutwardController>()
                        .searchError
                        .isNotEmpty
                    ? Text(
                        "   ${context.watch<StockOutwardController>().searchError}")
                    : Text(
                        "",
                        style: TextStyle(color: Colors.red),
                      ),
              ),
              Expanded(
                child: ListView.builder(
                    //  shrinkWrap: true,
                    //  physics: const BouncingScrollPhysics(), // new
                    itemCount: context
                        .read<StockOutwardController>()
                        .getfilterSearchedData
                        .length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<StockOutwardController>().scanmethod(
                              widget.index,
                              context
                                  .read<StockOutwardController>()
                                  .searchcon
                                  .text
                                  .toString(),
                              widget.list_i,
                              context
                                  .read<StockOutwardController>()
                                  .getfilterSearchedData[index]
                                  .itemcode
                                  .toString());
                          // widget.prdsrch. onseletFst(context,
                          // theme,
                          // widget.prdsrch.getfilterSearchedData[index]
                          // );
                          log("dattaa down");
                          Navigator.pop(context);
                        },
                        child: Card(
                          child: Container(
                              width: Screens.bodyheight(context) * 0.8,
                              // height: ProHeight * 0.3,
                              padding: EdgeInsets.only(
                                top: Screens.bodyheight(context) * 0.01,
                                left: Screens.width(context) * 0.01,
                                right: Screens.width(context) * 0.01,
                                bottom: Screens.bodyheight(context) * 0.005,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                          "${context.watch<StockOutwardController>().getfilterSearchedData[index].itemcode}"),
                                    ),
                                    Container(
                                      child: Text(
                                          "${context.watch<StockOutwardController>().getfilterSearchedData[index].itemname}"),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
