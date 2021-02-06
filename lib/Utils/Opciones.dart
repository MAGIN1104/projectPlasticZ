import 'package:flutter/material.dart';

class Opciones {
  List<String> tipodePago = ['Opcion 1', 'Opcion 2', 'Opcion 3'];

  List<String> lugarEntrega = [
    'Lugar 1',
    'Lugar 2',
    'Lugar 3',
    'Lugar 4',
    'Lugar 5',
    'Lugar 6',
  ];

  List<String> diasEntrega = [
    'Dias op1',
    'Dias op2',
    'Dias op3',
    'Dias op4',
    'Dias op5',
  ];

  List<String> tipobancos = [
    'Banco 1',
    'Banco 2',
    'Banco 3',
    'Banco 4',
    'Banco 5',
    'Banco 6',
    'Banco 7',
    'Banco 8',
  ];

  List<String> menuOptions = ["ExportarPDF", "Enviar", "Nueva Cotizacion"];

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
