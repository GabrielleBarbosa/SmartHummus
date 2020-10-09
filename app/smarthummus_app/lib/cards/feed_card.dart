import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedCard extends StatefulWidget {
  final String title, headline, urlToImage, content;

  FeedCard(this.title, this.headline, this.urlToImage, this.content);

  @override
  _FeedCardState createState() => _FeedCardState(this.title, this.headline, this.urlToImage, this.content);
}

class _FeedCardState extends State<FeedCard> {
  String title, headline, urlToImage, content;
  _FeedCardState(this.title, this.headline, this.urlToImage, this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0, bottom: 15.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(40, 40, 40, 100.0),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  child: Container(
                    color: Color.fromRGBO(226, 233, 235, 100.0),

                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        child: Column(
                          children: [
                            urlToImage != null ? Image.network(urlToImage):Container(height: 200,),
                            content != null ? Padding(padding: EdgeInsets.all(20),child:Text(content, textAlign: TextAlign.justify,)):Container()
                          ],
                        )
                    )),
                  )),
            )
          ],
        ));
  }
}
