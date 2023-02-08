import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  String name;
  // Function()? onTap;
  TileWidget({
    Key? key,
    required this.name, //required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.grey,
        height: screenHeight * 0.07,
        width: screenWidth * 0.25,
        child: Center(child: Text(name)),
      ),
    );
  }
}
