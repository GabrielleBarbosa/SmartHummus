import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/1.png',
    title: 'Bem-vindo(a)!',
    description: 'Ajude o meio ambiente e mais coisas assim pra dar mais linha',
  ),
  Slide(
    imageUrl: 'assets/images/2.png',
    title: 'Controle sua composteira',
    description: 'Ajude o meio ambiente e mais coisas assim pra dar mais linha',
  ),
  Slide(
    imageUrl: 'assets/images/3.png',
    title: 'Venda e compre os compostos orgânicos',
    description: 'Ajude o meio ambiente e mais coisas assim pra dar mais linha',
  ),
  Slide(
    imageUrl: 'assets/images/4.png',
    title: 'Receba notícias sobre sustentabilidade',
    description: 'Ajude o meio ambiente e mais coisas assim pra dar mais linha',
  ),
];
