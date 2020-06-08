import "package:flutter/material.dart";

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 180,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(60), bottomLeft: Radius.circular(60)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(60.0),
            bottomLeft: Radius.circular(60.0),
            ),
            child: Container(
              color: Colors.blue,
            ),
          )
      )
    );
  }
}

