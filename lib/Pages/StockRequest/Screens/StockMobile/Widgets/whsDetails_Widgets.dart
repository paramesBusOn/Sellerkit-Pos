// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:posproject/Widgets/AlertBox.dart';

import '../../../../../Constant/Screen.dart';

class WhsListDetails extends StatelessWidget {
  WhsListDetails({
    Key? key,
    required this.theme,
    required this.sr_Con,
  }) : super(key: key);

  final ThemeData theme;
  StockReqController sr_Con;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(
        //   height: Screens.bodyheight(context) * 0.008,
        // ),
        Container(
          // margin: EdgeInsets.only(top: Screens.bodyheight(context) * 0.01),
          width: Screens.width(context) * 0.95,
          padding: EdgeInsets.all(Screens.bodyheight(context) * 0.005),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                // margin:
                //     EdgeInsets.only(top: Screens.bodyheight(context) * 0.008),
                //  alignment: Alignment.center,
                height: Screens.bodyheight(context) * 0.068,
                width: Screens.width(context) * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3), //color of shadow
                      spreadRadius: 3, //spread radius
                      blurRadius: 2, // blur radius
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: TextField(
                  readOnly: true,
                  // autofocus: false,
                  // readOnly: visibleField ? true : false,
                  controller: sr_Con.mycontroller[1],
                  style:
                      theme.textTheme.bodySmall!.copyWith(color: Colors.black),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  onEditingComplete: () {
                    // prdCD.scannBAtch(context, theme);
                  },
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                              contentPadding: EdgeInsets.all(0),
                              // backgroundColor: Colors.transparent,
                              insetPadding: EdgeInsets.all(
                                  Screens.bodyheight(context) * 0.02),
                              content: AlertBox(
                                payMent: 'WareHouse',
                                widget: ForWhsList(context, sr_Con),
                                buttonName: null,
                              ));
                        });
                  },
                  onChanged: (val) {
                    // SR_Con.filterList(val);
                  },
                  // Only numbers can be eentered
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Screens.width(context) * 0.026),
                    hintText: "Locations",
                    hintStyle: theme.textTheme.bodyLarge!.copyWith(),
                    suffixIcon:
                     IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    contentPadding: EdgeInsets.all(0),
                                    // backgroundColor: Colors.transparent,
                                    insetPadding: EdgeInsets.all(
                                        Screens.bodyheight(context) * 0.02),
                                    content: AlertBox(
                                      payMent: 'WareHouse',
                                      widget: ForWhsList(context, sr_Con),
                                      buttonName: null,
                                    ));
                              });
                        },
                        icon: Icon(
                          Icons.search,
                          size: 20,
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
              sr_Con.get_WhsselectedList == null
                  ? Container()
                  : Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.008,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Screens.width(context) * 0.75,
                                  // color: Colors.amber,
                                  child: Text(
                                    "${sr_Con.get_WhsselectedList!.whsName}",
                                    style:
                                        theme.textTheme.titleMedium!.copyWith(),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(0.0),
                                  // width: Screens.width(context) * 0.2,
                                  // color: Colors.amber,
                                  child: IconButton(
                                      constraints: BoxConstraints.tight(
                                          Size.fromWidth(30)),
                                      padding: const EdgeInsets.all(0.0),
                                      iconSize:
                                          Screens.bodyheight(context) * 0.03,
                                      onPressed: () {
                                        sr_Con.clearData();
                                      },
                                      icon: Icon(Icons.close)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.008,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Screens.width(context) * 0.3,
                                  // color: Colors.amber,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.call,
                                          size: Screens.bodyheight(context) *
                                              0.025,
                                          color: Colors.grey),
                                      Text(
                                        "${sr_Con.get_WhsselectedList!.whsPhoNo}",
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  " | ",
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(color: Colors.grey),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.55,
                                  // color: Colors.amber,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.mail_outline,
                                          size: Screens.bodyheight(context) *
                                              0.025,
                                          color: Colors.grey),
                                      SizedBox(
                                        width: Screens.width(context) * 0.49,
                                        // color: Colors.blue,
                                        child: Text(
                                          "${sr_Con.get_WhsselectedList!.whsmailID}",
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.008,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Screens.width(context) * 0.2,
                                  // color: Colors.amber,
                                  child: Text(
                                    "GST#",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.45,
                                  // color: Colors.amber,
                                  child: Text(
                                    "${sr_Con.get_WhsselectedList!.whsGst}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.008,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Screens.width(context) * 0.2,
                                  // color: Colors.amber,
                                  child: Text(
                                    "Code#",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.45,
                                  // color: Colors.amber,
                                  child: Text(
                                    "${sr_Con.get_WhsselectedList!.whsCode}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.008,
                          ),
                          Container(
                            child: Column(
                              children: [
                                // Container(
                                //   width: Screens.width(context)*0.9,
                                //   // color: Colors.amber,
                                //   child:  Text(
                                //     "Ship Address",
                                //     style: theme.textTheme.bodyText1!
                                //         .copyWith(color: Colors.grey),
                                //   ),
                                // ),
                                SizedBox(
                                  width: Screens.width(context) * 0.9,
                                  // color: Colors.amber,
                                  child: Text(
                                    "${sr_Con.get_WhsselectedList!.whsAddress}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.9,
                                  // color: Colors.amber,
                                  child: Text(
                                    "${sr_Con.get_WhsselectedList!.whsCity}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.9,
                                  // color: Colors.amber,
                                  child: Text(
                                    "${sr_Con.get_WhsselectedList!.pinCode}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                                SizedBox(
                                  width: Screens.width(context) * 0.9,
                                  // color: Colors.amber,
                                  child: Text(
                                    "${sr_Con.get_WhsselectedList!.whsState}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.008,
              ),
            ],
          ),
        ),
        SizedBox(
          height: Screens.bodyheight(context) * 0.01,
        ),

        InkWell(
          onTap: () {},
          child: Container(
            width: Screens.width(context) * 0.95,
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              // borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  width: Screens.width(context) * 0.9,
                  // color: Colors.amber,
                  child: Text(
                    "Delivery Address",
                    style: theme.textTheme.bodyLarge!.copyWith(),
                  ),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.9,
                  // color: Colors.amber,
                  child: Text(
                    // SR_Con.ShipSelectedList == null
                    //     ?
                    "Insignia,kk Nagar,coimbatore",
                    // : "${SR_Con.ShipSelectedList!.billAddress}",
                    style:
                        theme.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.9,
                  // color: Colors.amber,
                  child: Text(
                    // SR_Con.ShipSelectedList == null
                    //     ?
                    "Coimbatore",
                    // : "${SR_Con.ShipSelectedList!.billCity}",
                    style:
                        theme.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.9,
                  // color: Colors.amber,
                  child: Text(
                    // SR_Con.ShipSelectedList == null
                    //     ?
                    "630087",
                    // : "${SR_Con.ShipSelectedList!.billPincode}",
                    style:
                        theme.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.9,
                  // color: Colors.amber,
                  child: Text(
                    // SR_Con.ShipSelectedList == null
                    //     ?
                    "Tamil Nadu",
                    // : "${SR_Con.ShipSelectedList!.billstate}",
                    style:
                        theme.textTheme.bodyMedium!.copyWith(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

ForWhsList(BuildContext context, StockReqController srCon) {
  final theme = Theme.of(context);
  return StatefulBuilder(builder: (context, st) {
    return Container(
      padding: EdgeInsets.only(
          top: Screens.bodyheight(context) * 0.008,
          left: Screens.width(context) * 0.008,
          right: Screens.width(context) * 0.008,
          bottom: Screens.bodyheight(context) * 0.008),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Screens.width(context) * 1.1,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
              borderRadius: BorderRadius.circular(3),
              // color: Colors.grey.withOpacity(0.01),
            ),
            child: TextFormField(
              controller: srCon.mycontroller[2],
              cursorColor: Colors.grey,
              onChanged: (v) {
                st(() {
                  srCon.filterList(v);
                });
              },
              decoration: InputDecoration(
                hintText: 'Search WareHouse..!!',
                hintStyle:
                    theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                filled: false,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5,
                ),
              ),
            ),
          ),
          SizedBox(height: Screens.bodyheight(context) * 0.008),
          SizedBox(
              height: Screens.bodyheight(context) * 0.5,
              width: Screens.width(context) * 1.1,
              // color: Colors.blue,
              child: ListView.builder(
                  itemCount: srCon.filsterwhsList.length,
                  //  SR_Con.getfiltercustList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        // padding: EdgeInsets.only(
                        //     top: Screens.bodyheight(context) * 0.008,
                        //     left: Screens.bodyheight(context) * 0.008,
                        //     right: Screens.bodyheight(context) * 0.008,
                        //     bottom: Screens.bodyheight(context) * 0.008),
                        // height: Screens.bodyheight(context) * 0.2,
                        child: ListTile(
                          onTap: () {
                            srCon.WhsSelected(
                                srCon.filsterwhsList[index], context);
                            Navigator.pop(context);
                          },
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
                                      // "A0001",
                                      srCon.filsterwhsList[index].whsCode!,
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.38,
                                    // color: Colors.amber,
                                    child: Text(
                                        // "2000.00",
                                        srCon.filsterwhsList[index].whsPhoNo!,
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.black)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Screens.width(context) * 0.38,
                                    // color: Colors.amber,
                                    child: Text(
                                        // "Jco Retails",
                                        srCon.filsterwhsList[index].whsName!,
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.black)),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.38,
                                    // color: Colors.amber,
                                    child: Text(
                                        // "1234567890",
                                        srCon.filsterwhsList[index].whsmailID!,
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(color: Colors.black)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  });
}

ForbranchList(BuildContext context, StockReqController srCon) {
  final theme = Theme.of(context);
  return StatefulBuilder(builder: (context, st) {
    return Container(
      padding: EdgeInsets.only(
          top: Screens.bodyheight(context) * 0.008,
          left: Screens.width(context) * 0.008,
          right: Screens.width(context) * 0.008,
          bottom: Screens.bodyheight(context) * 0.008),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Screens.width(context) * 1.1,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(color: Color.fromARGB(255, 240, 235, 235)),
              borderRadius: BorderRadius.circular(3),
              // color: Colors.grey.withOpacity(0.01),
            ),
            child: TextFormField(
              // controller: SR_Con.mycontroller[2],
              cursorColor: Colors.grey,
              onChanged: (v) {
                st(() {
                  srCon.filterbranchList(v);
                });
              },
              decoration: InputDecoration(
                hintText: 'Search WareHouse..!!',
                hintStyle:
                    theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                filled: false,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5,
                ),
              ),
            ),
          ),
          SizedBox(height: Screens.bodyheight(context) * 0.008),
          SizedBox(
              height: Screens.bodyheight(context) * 0.5,
              width: Screens.width(context) * 1.1,
              // color: Colors.blue,
              child: ListView.builder(
                  itemCount: srCon.filterShipAddressList.length,
                  //  SR_Con.getfiltercustList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        st(() {
                          print("object");
                          srCon.branchSelected(
                              srCon.filterShipAddressList[index], context);
                        });

                        Navigator.pop(context);
                      },
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(
                              top: Screens.bodyheight(context) * 0.008,
                              left: Screens.bodyheight(context) * 0.008,
                              right: Screens.bodyheight(context) * 0.008,
                              bottom: Screens.bodyheight(context) * 0.008),
                          // height: Screens.bodyheight(context) * 0.2,
                          child: Column(
                            children: [
                              SizedBox(
                                width: Screens.width(context),
                                // color: Colors.amber,
                                child: Text(
                                  // "A0001",
                                  "${srCon.filterShipAddressList[index].billAddress}",
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: Screens.width(context),
                                // color: Colors.amber,
                                child: Text(
                                    // "2000.00",
                                    "${srCon.filterShipAddressList[index].billCity}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.black)),
                              ),
                              SizedBox(
                                width: Screens.width(context),
                                // color: Colors.amber,
                                child: Text(
                                    // "Jco Retails",
                                    "${srCon.filterShipAddressList[index].billstate}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.black)),
                              ),
                              SizedBox(
                                width: Screens.width(context),
                                // color: Colors.amber,
                                child: Text(
                                    // "1234567890",
                                    "${srCon.filterShipAddressList[index].billCountry}",
                                    style: theme.textTheme.bodyMedium!
                                        .copyWith(color: Colors.black)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
    );
  });
}
