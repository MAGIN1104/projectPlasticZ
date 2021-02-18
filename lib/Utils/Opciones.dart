import 'package:flutter/material.dart';

class Opciones {
  List<String> tipodePago = [
    '50% al confirmar el pedido y 50% al entregar todo el pedido',
    '15 Dias despues de la entrega del producto',
    'Contraentrega'
  ];

  List<String> lugarEntrega = [
    'Instalaciones del cliente La Paz y El Alto',
    'Instalaciones de Plastic Z SRL. (Almacenes)',
    'Envio al interior pagado (Trasportadora)',
    'Envio al interior por pagar',
    'Envio al exterior pagado',
    'EXW',
  ];

  List<String> diasEntrega = [
    '10 Días habiles despues de la confirmacion',
    '15 Días habiles despues de la confirmacion',
    '25 Días habiles despues de la confirmacion',
    '30 Días habiles despues de la confirmacion',
    'Inmediato',
  ];

  List<String> tipobancos = [
    'BCP',
    'MERCANTIL SANTA CRUZ',
    'BANCO NACIONAL DE BOLIVIA',
    'BANCO SOL',
    'BANCO FIE',
    'BANCO UNION',
  ];

  List<String> menuOptions = ["ExportarPDF", "Nueva Cotizacion"];

  List<DropdownMenuItem<String>> getOpcionPago() {
    List<DropdownMenuItem<String>> lista = [];
    tipodePago.forEach((opcion) {
      lista.add(DropdownMenuItem(
        value: opcion,
        child: Text(opcion),
      ));
    });
    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionLugar() {
    List<DropdownMenuItem<String>> lista = [];
    lugarEntrega.forEach((opcion) {
      lista.add(DropdownMenuItem(
        value: opcion,
        child: Text(opcion),
      ));
    });
    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionDiasEntrega() {
    List<DropdownMenuItem<String>> lista = [];
    diasEntrega.forEach((opcion) {
      lista.add(DropdownMenuItem(
        value: opcion,
        child: Text(opcion),
      ));
    });
    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionBanco() {
    List<DropdownMenuItem<String>> lista = [];
    tipobancos.forEach((opcion) {
      lista.add(DropdownMenuItem(
        value: opcion,
        child: Text(opcion),
      ));
    });
    return lista;
  }
}
