import 'package:flutter/material.dart';
import 'dart:async';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  bool interrupteur = true;
  String ageLibelleDate = 'Entrez votre age';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text(
                'Remplissez tous les champs pour obtenir votre besoin jounralier en calories',
                textAlign: TextAlign.center,
                textScaleFactor: 1.50,
              ),
              new Card(
                  margin: EdgeInsets.all(30.0),
                  elevation: 10.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text("Femme",
                              style: new TextStyle(color: Colors.pinkAccent)),
                          new Switch(
                            inactiveThumbColor: Colors.pinkAccent,
                            inactiveTrackColor: Colors.pink[100],
                            value: interrupteur,
                            onChanged: (bool b) {
                              setState(() {
                                interrupteur = b;
                              });
                            },
                          ),
                          new Text("Homme"),
                        ],
                      ),
                      new FlatButton(
                        child: new Text('$ageLibelleDate'),
                        onPressed: choixDate,
                      )
                    ],
                  ))
            ]));
  }

  Future choixDate() async {
    DateTime choix = await showDatePicker(
        context: context,
        firstDate: new DateTime(1970),
        initialDate: new DateTime.now(),
        lastDate: new DateTime(2050));
    if (choix != null) {
      var difference = new DateTime.now().difference(choix);
      var jours = difference.inDays;
      var annee = (jours ~/ 365).toInt();

      setState(() {
        ageLibelleDate = 'votre age est de : $annee ans';
      });
    }
  }
}
