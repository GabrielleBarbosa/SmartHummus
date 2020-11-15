import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/widgets/page_slider/slide.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 15.0),
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(slideList[index].imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          slideList[index].title.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(141, 149, 152, 1.0),
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            slideList[index].description,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.blueGrey,
            ),
          ),
        )

      ],
    );
  }
}
