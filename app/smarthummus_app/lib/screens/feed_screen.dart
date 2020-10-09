import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:smarthummusapp/cards/feed_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/news/news_article.dart';
import 'package:smarthummusapp/news/web_service.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

  List<NewsArticle> _newsArticles = List<NewsArticle>();
  int _page = 0;
  bool _disabled = false;
  Future<void> _launched;

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  void _populateNewsArticles() {

    Webservice().load(NewsArticle.all).then((newsArticles) => {
      setState(() => {
        _newsArticles = newsArticles
      })
    });
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  GestureDetector _buildItemsForListView(BuildContext context, int index){
    return
      GestureDetector(
        onTap: () => setState(() {
          _launched = _launchInBrowser(_newsArticles[index].url);
        }),
        child: FeedCard(_newsArticles[index].title, _newsArticles[index].description, _newsArticles[index].urlToImage, _newsArticles[index].content.split('[')[0]),
      );
  }

  /*void _decreasePage(){
    setState(() {
      _page--;
      _disabled = false;
    });
  }

  void _increasePage(){
    if(_newsArticles.length>=(_page+1)*10+10){
      if(_newsArticles.length>=(_page+2)*10+9){
        setState(() {
          _page++;
        });
      }
      else{
        setState(() {
          setState(() {
            _page++;
            _disabled = true;
          });
        });
      }
    }
    else{
      _disabled = true;
    }
  }
*/

  Widget _cabecalho(){
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          height: 180,
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(55.0),
                bottomLeft: Radius.circular(55.0),
              ),
              child: Container(
                color: Color.fromRGBO(17, 204, 199, 83.0),
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.only(top: 70.0, left: 35.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "OLÁ,",
                                  style: GoogleFonts.raleway(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "USUARIO",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          ])),
                  Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Image(
                    image: AssetImage('assets/images/folhas.png'),
                    fit: BoxFit.cover,
                    width: 230,)
                ]),
              ),
            ),
          ),
        ),
        /*Row(
          children: [
            RaisedButton(
              child: Text("Anterior"),
              onPressed: _page>0?_decreasePage: null,
            ),
            RaisedButton(
              child: Text("Próxima"),
              onPressed: _disabled?null:_increasePage,
            ),
          ],
        ),*/

        Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: Text(
              "FEED",
              style: GoogleFonts.raleway(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(55, 55, 55, 100.0)
              ),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            itemCount: _newsArticles.length+1,
            itemBuilder: (context, index){
              if(index == 0)
                return _cabecalho();
              return _buildItemsForListView(context, index-1);
            },
    );

  }
}

