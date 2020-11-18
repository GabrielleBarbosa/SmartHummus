import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/icons/smart_hummus_icons_icons.dart';

class CommentCard extends StatefulWidget {
  final String name, comment, image;
  final int stars;

  CommentCard(this.name, this.comment, this.image, this.stars);

  @override
  _CommentCardState createState() =>
      _CommentCardState(this.name, this.comment, this.image, this.stars);
}

class _CommentCardState extends State<CommentCard> {
  final String name, comment, image;
  final int stars;

  _CommentCardState(this.name, this.comment, this.image, this.stars);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        margin: EdgeInsets.only(top: 5, bottom: 5),
        width: MediaQuery.of(context).size.width / 1.25,
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image(
                image: AssetImage("assets/images/perfil.png"),
                fit: BoxFit.cover,
                width: 60),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(name,
                      style: GoogleFonts.raleway(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(105, 105, 105, 1))),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(SmartHummusIcons.star,
                      size: 15,
                      color: stars > 0
                          ? Color.fromRGBO(255, 223, 0, 1.0)
                          : Color.fromRGBO(195, 214, 220, 100.0)),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(SmartHummusIcons.star,
                      size: 15,
                      color: stars > 1
                          ? Color.fromRGBO(255, 223, 0, 1.0)
                          : Color.fromRGBO(195, 214, 220, 100.0)),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(SmartHummusIcons.star,
                      size: 15,
                      color: stars > 2
                          ? Color.fromRGBO(255, 223, 0, 1.0)
                          : Color.fromRGBO(195, 214, 220, 100.0)),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(SmartHummusIcons.star,
                      size: 15,
                      color: stars > 3
                          ? Color.fromRGBO(255, 223, 0, 1.0)
                          : Color.fromRGBO(195, 214, 220, 100.0)),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(SmartHummusIcons.star,
                      size: 15,
                      color: stars > 4
                          ? Color.fromRGBO(255, 223, 0, 1.0)
                          : Color.fromRGBO(195, 214, 220, 100.0)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 1.75,
                  child: Expanded(
                    child: Text(comment, textAlign: TextAlign.justify,),
                  ))
            ],
          )
        ]));
  }
}
