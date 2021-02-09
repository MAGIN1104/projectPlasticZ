import 'package:flutter/material.dart';
import 'package:plasticz/Provider/ListProduct.dart';
import 'package:plasticz/Views/CondicionVenta.dart';
import 'package:plasticz/Views/Cotizacion.dart';
import 'package:plasticz/Views/RegistrarProducto.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => new ListProduct())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/cotizacion',
          routes: {
            '/': (context) => CondicionVentas(),
            '/cotizacion': (context) => CotizacionView(),
            '/insertarProducto': (context) => RegistrarProducto(),
          }),
    );
  }
}
