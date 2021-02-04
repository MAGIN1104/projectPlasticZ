import 'package:flutter/material.dart';
import 'package:plasticz/Views/CondicionVenta.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => CondicionVentas(),
          // '/login':(_)=> Login(),
          // '/newUser':(_)=> NewUser()
        });
  }
}
