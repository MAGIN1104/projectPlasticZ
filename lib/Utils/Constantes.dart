import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//MARGENES
final EdgeInsetsGeometry margenSimetrico =
    EdgeInsets.symmetric(horizontal: 25, vertical: 15);
const EdgeInsetsGeometry padingCard =
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 20);

//COLORES

//TEXTOS
const szfuente = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
const txtcliche = Text('Incluye precio cliche');
const txtimpuestos = Text('Incluye inpuestos de ley');
const InputDecoration txtNombreCuenta =
    InputDecoration(hintText: 'Nombre de la Cuenta...');
const InputDecoration txtNumCuenta =
    InputDecoration(hintText: 'Número de cuenta...');
const InputDecoration txtNombreCheque =
    InputDecoration(hintText: 'Nombre al cual va el cheque...');
const txtSelectTipoProducto = Text(
  'Seleccione tipo de Producto:',
  style: szfuente,
);

const txtSelectTipoBobina = Text(
  'Seleccione tipo de Bobina:',
  style: szfuente,
);
const txtTOTAL = Text(
  'TOTAL',
  style: TextStyle(fontWeight: FontWeight.bold),
);

const txtIngreseDatos = Text(
  'Ingrese datos:',
  style: TextStyle(fontSize: 15.0),
);

//TEXTURA CARDS
const estiloTitulo = TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);
const descripcionItemStyle = TextStyle(fontWeight: FontWeight.bold);
