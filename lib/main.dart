import 'package:flutter/material.dart';
import 'package:calories/widget/class.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Calories',
      localizationsDelegates: [
       GlobalMaterialLocalizations.delegate,      
      ],
    
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Home(title: 'Flutter Calories'),
    );
  }
}
