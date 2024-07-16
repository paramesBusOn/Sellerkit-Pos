// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/StockRequestController/StockRequestController.dart';


class SearchItems extends StatefulWidget {
  const SearchItems({
    super.key,
  });
// final List<StockSnapTModelDB>? searchedData;
  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  // List<StockSnapTModelDB> getsearchedData = [];

  @override
  void initState() {
    super.initState();
    // getsearchedData = widget.searchedData!;
  }
  //   filterList(String v) {
  //     setState(() {
  //           if (v.isNotEmpty) {
  //     getsearchedData =  widget.searchedData!
  //         .where((e) =>
  //             e.itemcode!.toLowerCase().contains(v.toLowerCase()) ||
  //             e.itemname!.toLowerCase().contains(v.toLowerCase()))
  //         .toList();
  //   } else if (v.isEmpty) {
  //     getsearchedData =  widget.searchedData!;
  //   }
  //     });

  // }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                              .read<StockReqController>()
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
              Expanded(
                child: context
                        .read<StockReqController>()
                        .getfilterSearchedData
                        .isEmpty
                    ? Center(
                        child:Text("No data Found..!!")
                      )
                    : ListView.builder(
                        //  shrinkWrap: true,
                        //  physics: const BouncingScrollPhysics(), // new
                        itemCount: context
                            .watch<StockReqController>()
                            .getfilterSearchedData
                            .length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              setState(() {
                                
                                  context.read<StockReqController>().onseletFst(
                                      context,
                                      theme,
                                      context
                                          .read<StockReqController>()
                                          .getfilterSearchedData[index]);
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<StockReqController>()
                                      .disableKeyBoard(context);
                                  log("dattaa down");
                                  Navigator.pop(context);
                                
                              });
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
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.5),
                                    //     spreadRadius: 3,
                                    //     blurRadius: 7,
                                    //     offset: Offset(
                                    //         0, 3), // changes position of shadow
                                    //   ),
                                    // ],
                                  ),
                                  child: IntrinsicHeight(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                              "${context.watch<StockReqController>().getfilterSearchedData[index].itemcode}"),
                                        ),
                                        Container(
                                          child: Text(
                                              "${context.watch<StockReqController>().getfilterSearchedData[index].itemnameshort}"),
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
