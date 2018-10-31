import 'package:flutter/material.dart';
import 'dart:async';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  bool genre = true;
  String ageLibelleDate = 'Entrez votre age';
  double val = 100.0;
  double poids;
  bool ok = true;
  int selection;
  Map mapActivite = {0:"faible", 1:"modérée", 2:"forte"};
  int calories;
  int age;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector( //prise en compte IOS pour sortir du pave numérique
      onTap:(()=> FocusScope.of(context).requestFocus(new FocusNode()
      )) ,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: _setColor(),
          title: new Text(widget.title),
        ),
        body: new SingleChildScrollView(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  padding(),
              new Text(
                'Remplissez tous les champs pour obtenir votre besoin journalier en calories',
                textAlign: TextAlign.center,
                textScaleFactor: 1.10,
              ),
              new Card(
                  margin: EdgeInsets.all(30.0),
                  elevation: 10.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      padding(),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text("Femme",
                              style: new TextStyle(color: Colors.pinkAccent)),
                          new Switch(
                            inactiveThumbColor: Colors.pinkAccent,
                            inactiveTrackColor: Colors.pink[100],
                            value: genre,
                            onChanged: (bool b) {
                              setState(() {
                                genre = b;
                              });
                            },
                          ),
                          new Text("Homme"),
                        ],
                      ),
                      padding(),
                      new FlatButton(
                        padding: EdgeInsets.all(5.0),
                        color: _setColor(),
                        child: new Text(
                          '$ageLibelleDate',
                          style: new TextStyle(color: Colors.white),
                        ),
                        onPressed: choixDate,
                      ),
                      new Text('votre taille : ${val.toInt()} cms',
                          textAlign: TextAlign.center),
                      padding(),
                      new Slider(
                        divisions: 100,
                        activeColor: _setColor(),
                        min: 100.0,
                        max: 200.0,
                        value: val,
                        onChanged: (double b) {
                          setState(() {
                            val = b;
                          });
                        },
                      ),
                      padding(),
                      new Padding(
                        padding: EdgeInsets.all(20.0),

                      child:                        
                      new TextField(
                        //scrollPadding: EdgeInsets.all(20.0),
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          labelText: 'Entrez votre poids en kg',
                        ),
                        onChanged: (String string) { //prise en compte IOS: pas de soumission 
                          
                            setState(() {
                              poids = double.tryParse(string);
                            });
                          
                        },
                      )
                      ),
                      padding(),
                      new Text("Votre activite"),
                      padding(),
                      ligneRadios(),
                      padding(),
                     
                    ],
                  )
                  ),
                   new OutlineButton(
                        textTheme: ButtonTextTheme.primary,
                          color: _setColor(),
                          child: new Text("calcul",
                              style: new TextStyle(color: _setColor())),
                          onPressed: () => calculer(),
                          borderSide: BorderSide(color: _setColor()),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                      padding(),

            ]
            
            )
            
            )
            
            )
    );
    
  }

  Future choixDate() async {
    DateTime choix = await showDatePicker(
        context: context,
        firstDate: new DateTime(1970),
        initialDate: new DateTime.now(),
        lastDate: new DateTime(2050),
        locale: const Locale('fr'));
       

    if (choix != null) {
      var difference = new DateTime.now().difference(choix);
      var jours = difference.inDays;
      var annee = (jours ~/ 365).toInt();

      setState(() {
        ageLibelleDate = 'votre age est de : $annee ans';
        age = annee;
      });
    }
  }

  Color _setColor() {
    if (genre) {
      return Colors.blue;
    } else {
      return Colors.pink;
    }
  }

  Padding padding() {
    return new Padding(
      padding: EdgeInsets.all(10.0),
    );
  }

  Row ligneRadios() {
    List<Widget> l = [];
    mapActivite.forEach((cle, valeur) {
      Column colonne = new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Radio(
            activeColor: _setColor(),
            groupValue: selection,
            value: cle,
            onChanged: (Object g) {
              setState(() {
                selection = g;
              });
            },
          ),
          new Text(valeur)
        ],
      );
      l.add(colonne);
    });
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: l,
    );
  }

/*Calculs du nombre de calories:
Pour un homme: 66.4730 + (13.7516 * poids) + (5.0033 * taille) - (6.7550 * age)
Pour une femme: 655.0955 + (9.5634 * poids) + (1.8496 * taille) - (4.6756 * age)

Multiplication selon activité:

Faible: 1.2, Modéré: 1.5, Forte: 1.8.
*/
  void calculer(){
    if (poids != null && selection != null && age != null ){

      if (genre) {
       
       setState(() {
               calories = ( 66.4730 + (13.7516*poids) + (5.0033 * selection) + (6.7550 * age)).toInt();
              });
              dialogue();

      }else{
        setState(() {
               calories = ( 655.0955 + (9.5634 * poids) + (1.8496 * selection) - (4.6756 * age)).toInt();
              });
              dialogue();
      }

    

  }else{

    alert();

  }
  }

  calculerCalories(){

  }
  Future<Null> dialogue() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {       
        return AlertDialog(
          title:  new Text('Résultat'),
            content: new Text('Votre calcul est $calories',
                style: new TextStyle(color:  _setColor())
                ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {Navigator.pop(context);},
                child: new Text('OK'),
              )
            ],

                );
        }        
    );
  }

  Future<Null> alert() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {       
        return AlertDialog(
          title:  new Text('Erreur'),
            content: new Text('Les champs ne sont pas tous remplis',
                style: new TextStyle(color:  _setColor())
                ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {Navigator.pop(context);},
                child: new Text('OK'),
              )
            ],

                );
        }        
    );
  }
}




