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
    description: 'Ajude o meio ambiente de forma simples e prática com o aplicativo SmartHummus!',
  ),
  Slide(
    imageUrl: 'assets/images/2.png',
    title: 'Controle sua composteira',
    description: 'Seu aplicativo mostrará os dados dos sensores para você sempre saber como está seu minhocário, além de dar dicas e instruções para deixá-lo perfeito!',
  ),
  Slide(
    imageUrl: 'assets/images/3.png',
    title: 'Venda e compre os compostos orgânicos',
    description: 'Não se preocupe se não conseguir usar todo o seu composto, você pode vendê-lo. E, se faltar, também não é problema, é possível comprar pelo app!',
  ),
  Slide(
    imageUrl: 'assets/images/4.png',
    title: 'Receba notícias sobre sustentabilidade',
    description: 'Fique por dentro do que está acontecendo no mundo todo e como ajudar cada vez mais!',
  ),
];
