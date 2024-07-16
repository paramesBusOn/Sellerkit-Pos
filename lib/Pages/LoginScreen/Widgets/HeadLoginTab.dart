// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../Constant/Screen.dart';

class HeaderLoginTab extends StatelessWidget {
  const HeaderLoginTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Screens.bodyheight(context) * 0.25,
      width: Screens.width(context) * 1.0,
      //color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Welcome to Login',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),

          // Text('Hello Again!',
          //     style: TextStyle(
          //         color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20)),
        ],
      ),
    );
  }
}