import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Color.fromRGBO(136, 240, 0, 1.0) : Color.fromRGBO(55,55,55, 0.25),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}