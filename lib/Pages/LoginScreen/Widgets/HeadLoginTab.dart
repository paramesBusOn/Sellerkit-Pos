
import 'package:flutter/material.dart';
import '../../../Constant/Screen.dart';

class HeaderLoginTab extends StatelessWidget {
  const HeaderLoginTab({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.25,
      width: width * 1.0,
      //color: Colors.amber,
      child: const Column(
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