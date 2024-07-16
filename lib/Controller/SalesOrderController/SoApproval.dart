// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unnecessary_string_interpolations, must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../Controller/SalesOrderController/SalesOrderController.dart';
// import '../../../../ServiceLayerAPIss/OrderAPI/approvals_details_api.dart';

// class SoApprovals extends StatefulWidget {
//   SoApprovals({
//     Key? key,
//     required this.theme,
//     required this.searchHeight,
//     required this.searchWidth,
//   }) : super(key: key);

//   final ThemeData theme;
//   double searchHeight;
//   double searchWidth;

//   @override
//   State<SoApprovals> createState() => SearhBoxState();
// }

// class SearhBoxState extends State<SoApprovals> {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//         insetPadding: EdgeInsets.all(10),
//         contentPadding: EdgeInsets.all(0),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//         content: SizedBox(
//             width: widget.searchWidth * 2,
//             //  height:searchHeight*0.9 ,
//             child: SingleChildScrollView(
//               child: Column(
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                       alignment: Alignment.centerLeft,
//                       width: widget.searchWidth,
//                       padding: EdgeInsets.all(widget.searchHeight * 0.01),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 child: Form(
//                                   key: context.read<SOCon>().formkey[20],
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         alignment: Alignment.center,
//                                         // color: Colors.blue,
//                                         width: widget.searchWidth * 0.08,
//                                         child: Text("From Date"),
//                                       ),
//                                       Container(
//                                         height: widget.searchHeight * 0.07,
//                                         width: widget.searchWidth * 0.15,
//                                         decoration: BoxDecoration(
//                                             // //color: Colors.amber,
//                                             //   borderRadius: BorderRadius.circular(4),
//                                             //  border: Border.all(),
//                                             ),
//                                         child:
//                                             // Center(child: Text("2023-03-03"))
//                                             TextFormField(
//                                           controller: context
//                                               .read<SOCon>()
//                                               .mycontroller[102],
//                                           readOnly: true,
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "Required";
//                                             }
//                                             null;
//                                             return null;
//                                           },
//                                           onTap: () {
//                                             context
//                                                 .read<SOCon>()
//                                                 .getAprvlDate2(context, 'From');
//                                           },
//                                           decoration: InputDecoration(
//                                               contentPadding:
//                                                   EdgeInsets.symmetric(
//                                                       vertical: 5.0,
//                                                       horizontal: 5.0),
//                                               border: OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(4)),
//                                               //   labelText: "Date",
//                                               hintText: "",
//                                               hintStyle: widget
//                                                   .theme.textTheme.bodyLarge!
//                                                   .copyWith(
//                                                       color: Colors.black),
//                                               suffixIcon:
//                                                   Icon(Icons.calendar_today)),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       alignment: Alignment.center,
//                                       // color: Colors.blue,
//                                       width: widget.searchWidth * 0.08,
//                                       child: Text("To Date"),
//                                     ),
//                                     Container(
//                                       height: widget.searchHeight * 0.07,
//                                       width: widget.searchWidth * 0.15,
//                                       decoration: BoxDecoration(
//                                           // //color: Colors.amber,
//                                           //   borderRadius: BorderRadius.circular(4),
//                                           //  border: Border.all(),
//                                           ),
//                                       child:
//                                           // Center(child: Text("2023-03-03"))
//                                           TextFormField(
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Required";
//                                           }
//                                           null;
//                                           return null;
//                                         },
//                                         readOnly: true,
//                                         controller: context
//                                             .read<SOCon>()
//                                             .mycontroller[103],
//                                         onTap: () {
//                                           context
//                                               .read<SOCon>()
//                                               .getAprvlDate2(context, 'To');
//                                         },
//                                         decoration: InputDecoration(
//                                             contentPadding:
//                                                 EdgeInsets.symmetric(
//                                                     vertical: 5.0,
//                                                     horizontal: 5.0),
//                                             border: OutlineInputBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(4)),
//                                             //   labelText: "Date",
//                                             hintText: "",
//                                             hintStyle: widget
//                                                 .theme.textTheme.bodyLarge!
//                                                 .copyWith(color: Colors.black),
//                                             suffixIcon:
//                                                 Icon(Icons.calendar_today)),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     if (context
//                                         .read<SOCon>()
//                                         .formkey[20]
//                                         .currentState!
//                                         .validate()) {
//                                       context
//                                           .read<SOCon>()
//                                           .callAprvllDataDatewise(
//                                           context
//                                                   .read<SOCon>()
//                                                   .config.alignDate2   (  context
//                                                   .read<SOCon>()
//                                                   .mycontroller[102]
//                                                   .text
//                                                   .toString()),
//                                              context
//                                                   .read<SOCon>()
//                                                   .config.alignDate2 (  context
//                                                   .read<SOCon>()
//                                                   .mycontroller[103]
//                                                   .text
//                                                   .toString()));
//                                     }
//                                   });
//                                 },
//                                 child: Container(
//                                   height: widget.searchHeight * 0.07,
//                                   width: widget.searchWidth * 0.08,
//                                   decoration: BoxDecoration(
//                                       color: widget.theme.primaryColor,
//                                       borderRadius: BorderRadius.circular(5)),
//                                   child: Icon(
//                                     Icons.search,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     height: widget.searchHeight * 0.07,
//                                     width: widget.searchWidth * 0.3,

//                                     decoration: BoxDecoration(
//                                         // //color: Colors.amber,
//                                         //   borderRadius: BorderRadius.circular(4),
//                                         //  border: Border.all(),
//                                         ),

//                                     child: TextFormField(
//                                       // keyboardType: TextInputType.number,
//                                       onChanged: (value) {
//                                         setState(() {
//                                           context
//                                               .read<SOCon>()
//                                               .filterAprvlBoxList(value.trim());
//                                         });
//                                       },

//                                       // readOnly: true,
//                                       //  controller: settleCon.mycontroller[1],
//                                       decoration: InputDecoration(
//                                           hintText: "Search...",
//                                           contentPadding: EdgeInsets.symmetric(
//                                               vertical: 10.0, horizontal: 10.0),
//                                           border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(4)),
//                                           //   labelText: "Date",
//                                           hintStyle: widget
//                                               .theme.textTheme.bodyLarge!
//                                               .copyWith(color: Colors.black)),
//                                     ),
//                                     //Center(child: Text("2000"))
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: widget.searchHeight * 0.01,
//                           ),
//                         ],
//                       )),
//                   Container(
//                     padding: EdgeInsets.only(
//                         right: widget.searchWidth * 0.01,
//                         left: widget.searchWidth * 0.01),
//                     decoration: BoxDecoration(
//                         color: widget.theme.primaryColor,
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(color: Colors.white)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           width: widget.searchWidth * 0.12,
//                           //color: Colors.amber,
//                           child: Text(
//                             "Customer Code",
//                             style: widget.theme.textTheme.bodyLarge!
//                                 .copyWith(color: Colors.white),
//                           ),
//                         ),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           width: widget.searchWidth * 0.12,
//                           //color: Colors.amber,
//                           child: Text(
//                             "Draft Docentry",
//                             style: widget.theme.textTheme.bodyLarge!
//                                 .copyWith(color: Colors.white),
//                           ),
//                         ),
//                         Container(
//                           alignment: Alignment.center,
//                           width: widget.searchWidth * 0.08,
//                           //color: Colors.amber,
//                           child: Text(
//                             "Doc Date",
//                             style: widget.theme.textTheme.bodyLarge!
//                                 .copyWith(color: Colors.white),
//                           ),
//                         ),
//                         Container(
//                           alignment: Alignment.center,
//                           width: widget.searchWidth * 0.08,
//                           //color: Colors.amber,
//                           child: Text(
//                             "UserName",
//                             style: widget.theme.textTheme.bodyLarge!
//                                 .copyWith(color: Colors.white),
//                           ),
//                         ),
//                         // Container(
//                         //   alignment: Alignment.center,
//                         //   width: widget.searchWidth * 0.1,
//                         //   //color: Colors.amber,
//                         //   child: Text(
//                         //     "Terminal",
//                         //     style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
//                         //   ),
//                         // ),
//                         Container(
//                           alignment: Alignment.center,
//                           width: widget.searchWidth * 0.08,
//                           //color: Colors.amber,
//                           child: Text(
//                             "SAP DocNo",
//                             style: widget.theme.textTheme.bodyLarge!
//                                 .copyWith(color: Colors.white),
//                           ),
//                         ),
//                         // Container(
//                         //   alignment: Alignment.center,
//                         //   width: widget.searchWidth * 0.12,
//                         //   //color: Colors.amber,
//                         //   child: Text(
//                         //     "Status",
//                         //     style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
//                         //   ),
//                         // ),
//                         Container(
//                           alignment: Alignment.center,
//                           width: widget.searchWidth * 0.15,
//                           //color: Colors.amber,
//                           child: Text(
//                             "Customer Name",
//                             style: widget.theme.textTheme.bodyLarge!
//                                 .copyWith(color: Colors.white),
//                           ),
//                         ),
//                         // Container(
//                         //   alignment: Alignment.centerRight,
//                         //   width: widget.searchWidth * 0.12,
//                         //   //color: Colors.amber,
//                         //   child: Text(
//                         //     "Doc Total ",
//                         //     style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
//                         //   ),
//                         // ),
//                         // Container(
//                         //   alignment: Alignment.center,
//                         //   width: widget.searchWidth * 0.1,
//                         //   //color: Colors.amber,
//                         //   child: Text(
//                         //     "Type",
//                         //     style: widget.theme.textTheme.bodyText1!
//                         //         .copyWith(color: Colors.white),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),

//                   Container(
//                     height: widget.searchHeight * 0.87,
//                     // color: Colors.green,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(5)),
//                     child: context.watch<SOCon>().filterAprvlData.isEmpty
//                         ? Center(
//                             child: Text("No Data Here..!!"),
//                           )
//                         : ListView.builder(
//                             itemCount:
//                                 context.read<SOCon>().filterAprvlData.length,
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     context.read<SOCon>().isApprove = true;
//                                     Navigator.pop(context);
//                                     ApprovalsDetailsAPi.draftEntry = context
//                                         .read<SOCon>()
//                                         .filterAprvlData[index]
//                                         .docEntry
//                                         .toString();
//                                     context
//                                         .read<SOCon>()
//                                         .getdraftDocEntry(context);
//                                   });
//                                 },
//                                 child: Container(
//                                   padding: EdgeInsets.only(
//                                       top: widget.searchHeight * 0.03,
//                                       // left: widget.searchHeight * 0.02,
//                                       // right: widget.searchHeight * 0.02,
//                                       bottom: widget.searchHeight * 0.03),
//                                   decoration: BoxDecoration(
//                                       color: Colors.grey.withOpacity(0.05),
//                                       borderRadius: BorderRadius.circular(5),
//                                       border:
//                                           Border.all(color: Colors.grey[300]!)),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         alignment: Alignment.center,
//                                         width: widget.searchWidth * 0.13,
//                                         //color: Colors.amber,
//                                         child: Text(
//                                           "${context.watch<SOCon>().filterAprvlData[index].cardCode}",
//                                           style: widget
//                                               .theme.textTheme.bodyLarge!
//                                               .copyWith(color: Colors.black),
//                                         ),
//                                       ),
//                                       Container(
//                                         alignment: Alignment.center,
//                                         width: widget.searchWidth * 0.13,
//                                         //color: Colors.amber,
//                                         child: Text(
//                                           "${context.watch<SOCon>().filterAprvlData[index].docEntry}",
//                                           style: widget
//                                               .theme.textTheme.bodyLarge!
//                                               .copyWith(color: Colors.black),
//                                         ),
//                                       ),
//                                       Container(
//                                         alignment: Alignment.center,
//                                         width: widget.searchWidth * 0.08,
//                                         //color: Colors.amber,
//                                         child: Text(
//                                           "${context.watch<SOCon>().config.alignDate(context.read<SOCon>().filterAprvlData[index].DocDate!)}",
//                                           style: widget
//                                               .theme.textTheme.bodyLarge!
//                                               .copyWith(color: Colors.black),
//                                         ),
//                                       ),
//                                       Container(
//                                         alignment: Alignment.center,
//                                         width: widget.searchWidth * 0.08,
//                                         //color: Colors.amber,
//                                         child: Text(
//                                           "${context.watch<SOCon>().filterAprvlData[index].FromUser}",
//                                           style: widget
//                                               .theme.textTheme.bodyLarge!
//                                               .copyWith(color: Colors.black),
//                                         ),
//                                       ),
//                                       // Container(
//                                       //   alignment: Alignment.center,
//                                       //   width: widget.searchWidth * 0.1,
//                                       //   //color: Colors.amber,
//                                       //   child: Text(
//                                       //     "${context.watch<SOCon>().filterAprvlData[index].terminal}",
//                                       //     style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
//                                       //   ),
//                                       // ),
//                                       Container(
//                                         alignment: Alignment.centerRight,
//                                         width: widget.searchWidth * 0.08,
//                                         //color: Colors.amber,
//                                         child: Text(
//                                           "${context.watch<SOCon>().filterAprvlData[index].DocNum}",
//                                           style: widget
//                                               .theme.textTheme.bodyText1!
//                                               .copyWith(color: Colors.black),
//                                         ),
//                                       ),
//                                       // Container(
//                                       //   alignment: Alignment.center,
//                                       //   width: widget.searchWidth * 0.14,
//                                       //   //color: Colors.amber,
//                                       //   child: Text(
//                                       //     "${context.watch<SOCon>().filterAprvlData[index].qStatus}",
//                                       //     style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
//                                       //   ),
//                                       // ),
//                                       Container(
//                                         alignment: Alignment.center,
//                                         width: widget.searchWidth * 0.15,
//                                         //color: Colors.amber,
//                                         child: Text(
//                                           "${context.watch<SOCon>().filterAprvlData[index].cardName}",
//                                           style: widget
//                                               .theme.textTheme.bodyLarge!
//                                               .copyWith(color: Colors.black),
//                                         ),
//                                       ),
//                                       // Container(
//                                       //   padding: EdgeInsets.only(right: widget.searchWidth * 0.01),
//                                       //   alignment: Alignment.centerRight,
//                                       //   width: widget.searchWidth * 0.12,
//                                       //   //color: Colors.amber,
//                                       //   child: Text(
//                                       //     "${context.watch<SOCon>().config.splitValues(context.watch<SOCon>().filterAprvlData[index].doctotal.toString())}",
//                                       //     style: widget.theme.textTheme.bodyLarge!.copyWith(color: Colors.black),
//                                       //   ),
//                                       // ),
//                                       // Container(
//                                       //   alignment: Alignment.center,
//                                       //   width: widget.searchWidth * 0.1,
//                                       //   //color: Colors.amber,
//                                       //   child: Text(
//                                       //     "${widget.SalesCon.filterAprvlData[index].type}",
//                                       //     style: widget
//                                       //         .theme.textTheme.bodyText1!
//                                       //         .copyWith(color: Colors.black),
//                                       //   ),
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }),
//                   )

// // Container(),
//                 ],
//               ),
//             )));
//   }
// }
