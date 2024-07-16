// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

import '../../../../../Controller/CustomerController/CustomerController.dart';

class MobSearch_Widget extends StatefulWidget {
  MobSearch_Widget(
      {super.key,
      required this.stChCon,
      required this.searchHeight,
      required this.searchWidth});
  CustomerController stChCon;
  double searchHeight;
  double searchWidth;

  @override
  State<MobSearch_Widget> createState() => _MobSearch_WidgetState();
}

class _MobSearch_WidgetState extends State<MobSearch_Widget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: widget.searchHeight,
      width: widget.searchWidth,
      padding: EdgeInsets.only(
          top: widget.searchHeight * 0.01,
          left: widget.searchHeight * 0.01,
          right: widget.searchHeight * 0.01,
          bottom: widget.searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              alignment: Alignment.center,
              width: widget.searchWidth * 1,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                style: theme.textTheme.bodyMedium,
                onChanged: (v) {
                  widget.stChCon.filterListSearched(v);
                },
                cursorColor: Colors.grey,
                controller: widget.stChCon.mycontroller[0],
                onEditingComplete: () {
                 widget.stChCon. morecusdetail();
                },
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Search Here..',
                  hintStyle:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.grey
                          //   fontWeight: FontWeight.normal
                          ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      // size: searchHeight * 0.05,
                      color: Colors.grey,
                    ),
                    onPressed: () async {},
                    color: theme.primaryColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                ),
              )),
          SizedBox(
            height: widget.searchHeight * 0.01,
          ),
          Expanded(
            child:
                widget.stChCon.listbool == true && widget.stChCon.filtercustomerList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : widget.stChCon.listbool == false &&
                            widget.stChCon.filtercustomerList.isEmpty
                        ? const Text("Does Not Have data..!!")
                        : ListView.builder(
                            itemCount: widget.stChCon.filtercustomerList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                              
                                  onTap: (){
                                  setState(() {
                                     widget.stChCon.  DetailsMetod(widget.stChCon.filtercustomerList[index].customerCode!); 
                                   widget.stChCon.tappage.animateToPage(
                                       ++widget.stChCon.tappageIndex,
                                        duration: const Duration(milliseconds: 400),
                                        curve: Curves.linearToEaseOut);
                                        
                                      widget.stChCon.  ListPasss(widget.stChCon.filtercustomerList[index]); 
                                      
                                  }); 
                                   
                                 
                                },
                                child: Card(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: widget.searchHeight * 0.01,
                                      left: widget.searchHeight * 0.01,
                                      right: widget.searchHeight * 0.01,
                                      bottom: widget.searchHeight * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: Colors.grey.withOpacity(0.05),
                                    ),
                                    child: Row(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                          
                                      mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                // color: Colors.red,
                                                // alignment: Alignment.center,
                                                // width: searchWidth * 0.17,
                                                child: Text(
                                                  "${widget.stChCon.filtercustomerList[index].customerCode}",
                                                  style: theme.textTheme.bodyMedium
                                                      ?.copyWith(fontWeight: FontWeight.w400),
                                                )),
                                                SizedBox(
                                                  
                                            height: widget.searchHeight * 0.01 ,
                                                ),
                                                SizedBox(
                                                // color: Colors.green,
                                                // alignment: Alignment.center,
                                                width: widget.searchWidth * 0.4,
                                                child: Text(
                                                  "${widget.stChCon.filtercustomerList[index].customername}",
                                                  style: theme.textTheme.bodyMedium
                                                      ?.copyWith(color: Colors.grey),
                                                )),
                                          ],
                                        ),
                                     Container(
                                       child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                         children: [
                                           Container(
                                                      // color: Colors.amber,
                                                      // alignment: Alignment.center,
                                                      // width: searchWidth * 0.17,
                                                      child: Text(
                                                        "${widget.stChCon.filtercustomerList[index].phoneno1}",
                                                        style: theme.textTheme.bodyMedium
                                                            ?.copyWith(color: Colors.grey),
                                                      )),
                                                       SizedBox(
                                                  
                                            height: widget.searchHeight * 0.01 ,
                                                ),
                                       Container(
                                                // color: Colors.orange,
                                                alignment: Alignment.centerRight,
                                                // width: searchWidth * 0.5,
                                                child: Text(
                                                  "${widget.stChCon.filtercustomerList[index].emalid}",
                                                  style: theme.textTheme.bodyMedium
                                                      ?.copyWith(color: Colors.grey),
                                                )),
                                         ],
                                       ),
                                     ),
                                                
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
          )
        ],
      ),
    );
  }
}
