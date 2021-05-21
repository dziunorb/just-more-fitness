import 'package:flutter/material.dart';

class EatProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width*0.9,
          child: Text('''
Перший прийом їжі: 

Вівсяна каша, склянка кави з шматочком чорного шоколаду, груша. 
Гречана каша, склянка молока, яблуко. 
Омлет з яєчних білків з чорним хлібом, чай з медом, банан. 


Другий прийом їжі: 

Творог нежирний з медом або з малиновим варенням, чорний чай. 
Горіхи або сухофрукти з чаєм – курага, родзинки, чорнослив, тощо, яблуко. 
Склянка кефіру, бутерброд з сиром. 


Третій прийом їжі: 

Порція якогось супу, гречка з відвареним курячим філе, овочевий салат, компот із сухофруктів. 
Порція бульйону, відварний рис з рибою, чай з медом, фрукти – апельсин, яблуко, виноград. 
Рис або картопля з м’ясом, яєчня, сік, фрукти. 


Четвертий прийом їжі: 

Два банани, чай з шматочком чорного шоколаду. 
Вівсяна каша, склянка молока. 
Творог нежирний з медом або з малиновим варенням, чорний чай. 


П’ятий прийом їжі: 

Гречка, відварене філе риби, апельсин або яблуко, зелений чай. 
Творог нежирний з малиновим варенням, банан, чорний чай. 
Овочевий салат, яєчні білки 5 штук (без жовтків), морс з ягід.
'''),
        ),
      ),
    );
  }
}
