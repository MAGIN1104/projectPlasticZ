import 'package:flutter/material.dart';
import 'package:plasticz/Views/CondicionVenta.dart';
import 'package:plasticz/Views/Cotizacion.dart';
import 'package:plasticz/Views/DatosCliente.dart';
import 'package:plasticz/Views/HomePage.dart';
import 'package:plasticz/Views/RegistrarProducto.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/cliente': (context) => DatosCliente(),
          '/condicion': (context) => CondicionVentas(),
          '/cotizacion': (context) => CotizacionView(),
          '/insertarProducto': (context) => RegistrarProducto(),
        });
  }
}
