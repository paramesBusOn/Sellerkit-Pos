// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:posproject/Controller/DepositController/DepositsController.dart';
import 'package:posproject/Pages/Settlement/Widgets/TabsetledSecondScreen.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../Screens/MobSettleScreen/Mobwidgets/MobsettledCon.dart';

class SettleFirstscreen extends StatefulWidget {
  SettleFirstscreen(
      {super.key,
      required this.custHeight,
      required this.custWidth});
  double custHeight;
  double custWidth;

  @override
  State<SettleFirstscreen> createState() => _SettleFirstscreenState();
}

class _SettleFirstscreenState extends State<SettleFirstscreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
     // color: Colors.amber,
       padding: EdgeInsets.only(
            top: widget.custHeight * 0.03,
            left: widget.custWidth * 0.02,
            right: widget.custWidth * 0.02,
            bottom: widget.custHeight * 0.02),
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
                top: widget.custHeight * 0.05,
                left: widget.custWidth * 0.02,
                right: widget.custWidth * 0.02,
                bottom: widget.custHeight * 0.02),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.,
            children: [
              Container(
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            // alignment: Alignment.center,
                            // color: Colors.blue,
                            width: widget.custWidth * 0.15,
                            child: Text("Date"),
                          ),
                          Container(
                            height: widget.custHeight * 0.07,
                            width: widget.custWidth * 0.20,
                            decoration: BoxDecoration(
                              // color: Colors.amber,
                            ),
                            child:
                                TextField(
                              readOnly: true,
                              controller: context.read<DepositsController>().mycontroller[0],
                              onTap: () {
                                // context.read<DepositsController>().getDate(context, '');
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 5.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(4)),
                                  //   labelText: "Date",
                                  hintText:"",
                                  hintStyle: theme.textTheme.bodyLarge!
                                      .copyWith(color: Colors.black),
                                  suffixIcon: Icon(Icons.calendar_today)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: widget.custHeight * 0.07,
                      child: ElevatedButton(
                          onPressed: () {
                           context.read<DepositsController>().mycontroller[4].text="";
                            context.read<DepositsController>().forcashlistorder(context, "Cash", theme);
                            Get.to(()=> TabsetledSecondScreen(
                                         
                                          custHeight: Screens.padingHeight(
                                                  context) *
                                              0.90,
                                          custWidth:
                                              Screens.width(context) * 0.90,
                                        ));
                            // Navigator.push(
                            //     context,
                                // MaterialPageRoute(
                                //     builder: (context) =>
                                        // TabsetledSecondScreen(
                                         
                                        //   custHeight: Screens.padingHeight(
                                        //           context) *
                                        //       0.90,
                                        //   custWidth:
                                        //       Screens.width(context) * 0.90,
                                        // )));
                          //  context.read<DepositsController>().currentDatepopUp(theme);

                          },
                          child: Text("New Settlement")),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: widget.custHeight * 0.03,
              ),
              Container(
                //   color: Colors.amber,
                child: Column(
                  children: [
                    SizedBox(
                      height: widget.custHeight * 0.01,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                          context.read<DepositsController>().  deleteDeposittb();
                          },
                          child: SizedBox(
                            width: widget.custWidth * 0.15,
                            child: Text("Net Collection"),
                          ),
                        ),
                        Container(
                          height: widget.custHeight * 0.07,
                          width: widget.custWidth * 0.40,

                          decoration: BoxDecoration(
                              // color: Colors.amber,
                              //   borderRadius: BorderRadius.circular(4),
                              //  border: Border.all(),
                              ),

                          child: TextField(
                            keyboardType: TextInputType.number,
                           readOnly: true,
                           controller: context.watch<DepositsController>().mycontroller[1],
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                //   labelText: "Date",
                                hintText: "",
                                hintStyle: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.black)),
                          ),
                          //Center(child: Text("2000"))
                        ),
                      ],
                    ),
                    SizedBox(
                      height: widget.custHeight * 0.02,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: widget.custWidth * 0.15,
                          child: Text("Net Settled"),
                        ),
                        Container(
                          height: widget.custHeight * 0.07,
                          width: widget.custWidth * 0.40,

                          decoration: BoxDecoration(
                              //color: Colors.amber,
                              //   borderRadius: BorderRadius.circular(4),
                              //  border: Border.all(),
                              ),

                          child: TextField(
                            keyboardType: TextInputType.number,
                             readOnly: true,
                             controller: context.watch<DepositsController>().mycontroller[2],
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                //    labelText: "Date",
                                hintText: "",
                                hintStyle: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.black)),
                          ),
                          //Center(child: Text("202"))
                        ),
                      ],
                    ),
                    SizedBox(
                      height: widget.custHeight * 0.02,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: widget.custWidth * 0.15,
                          child: Text("Unsettled Amount"),
                        ),
                        Container(
                          height: widget.custHeight * 0.07,
                          width: widget.custWidth * 0.40,

                          decoration: BoxDecoration(
                              //color: Colors.amber,
                              //   borderRadius: BorderRadius.circular(4),
                              //  border: Border.all(),
                              ),

                          child: TextField(
                            keyboardType: TextInputType.number,
                             readOnly: true,
                             controller: context.watch<DepositsController>().mycontroller[3],
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                // labelText: "Date",
                                hintText: "",
                                hintStyle: theme.textTheme.bodyLarge!
                                    .copyWith(color: Colors.black)),
                          ),
                          //Center(child: Text("2000"))
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: widget.custHeight * 0.03,
              ),
              NewWidget(),
            ],
          )),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    super.key,
  });

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(child: createTable(context,));
  }
}

