import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smarthummusapp/page_slider/slide.dart';
import 'package:smarthummusapp/page_slider/slide_dots.dart';
import 'package:smarthummusapp/page_slider/slide_item.dart';
import 'package:smarthummusapp/screens/sign_in_screen.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    /*Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });*/
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (ctx, i) => SlideItem(_currentPage),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              if (_currentPage > 0)
                                RaisedButton(
                                    elevation: 0.0,
                                    highlightElevation: 0.0,
                                    highlightColor: Colors.transparent,
                                    splashColor:
                                        Color.fromRGBO(198, 226, 235, 1.0),
                                    color: Colors.white,
                                    onPressed: () {
                                      _currentPage--;
                                      _pageController.animateToPage(
                                        _currentPage,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                      );
                                    },
                                    child: Container(
                                      width: 60.0,
                                      child: Text("Anterior",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromRGBO(
                                                  55, 55, 55, 0.5))),
                                    ))
                              else
                                SizedBox(
                                  width: 92.0,
                                ),
                              for (int i = 0; i < slideList.length; i++)
                                if (i == _currentPage)
                                  SlideDots(true)
                                else
                                  SlideDots(false),
                              if (_currentPage < 3)
                                RaisedButton(
                                    elevation: 0.0,
                                    highlightElevation: 0.0,
                                    highlightColor: Colors.transparent,
                                    splashColor:
                                        Color.fromRGBO(198, 226, 235, 1.0),
                                    color: Colors.white,
                                    onPressed: () {
                                      _currentPage++;
                                      _pageController.animateToPage(
                                        _currentPage,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                      );
                                    },
                                    child: Container(
                                      width: 60.0,
                                      child: Text("Próximo",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.raleway(
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromRGBO(
                                                  55, 55, 55, 0.5))),
                                    ))
                              else
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      color: Color.fromRGBO(124, 219, 0, 1.0),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignInScreen()),
                                        );
                                      }, child: Text("Vamos lá!",
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                  )
                                )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
