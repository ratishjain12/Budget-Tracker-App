import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  String name;
  final Icon ic;
  // Function()? onTap;
  TileWidget({
    Key? key,
    required this.name,
    required this.ic, //required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: screenHeight * 0.07,
        width: screenWidth * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ic,
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}
