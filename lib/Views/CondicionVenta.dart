import 'package:flutter/material.dart';
import 'package:plasticz/Utils/Constantes.dart';
import 'package:plasticz/Utils/Opciones.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CondicionVentas extends StatefulWidget {
  @override
  _CondicionVentasState createState() => _CondicionVentasState();
}

class _CondicionVentasState extends State<CondicionVentas> {
  Opciones listaOpciones = new Opciones();
  String valorPago, valorLugar, valorDiaEntrega, valorBanco;
  final numeroCuentaController = TextEditingController();
  final nombreCuentaController = TextEditingController();
  final numChequeController = TextEditingController();
  final detalleEfectivoController = TextEditingController();

  bool forma1 = false,
      forma2 = false,
      forma3 = false,
      optCliche = false,
      optImpuesto = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Condición Ventas'),
      ),
      body: ListView(
        children: [
          _tarjeta(
            Column(
              children: [
                _tipodePago(),
                _lugarEntrega(),
                _tiempoEntrega(),
              ],
            ),
          ),
          SizedBox(height: 10),
          _tarjeta(_fomaPago()),
          SizedBox(height: 10),
          _tarjeta(_optFinal()),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _tipodePago() {
    //DropDown
    return Padding(
      padding: margenSimetrico2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tipo de Pago ',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          DropdownButton(
              value: valorPago,
              items: listaOpciones.getOpcionPago(),
              onChanged: (opt) {
                setState(() {
                  valorPago = opt;
                });
              }),
        ],
      ),
    );
  }

  Widget _lugarEntrega() {
    return Padding(
      padding: margenSimetrico2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Lugar de Entrega',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          DropdownButton(
              value: valorLugar,
              items: listaOpciones.getOpcionLugar(),
              onChanged: (opt) {
                setState(() {
                  valorLugar = opt;
                });
              }),
        ],
      ),
    );
  }

  Widget _tiempoEntrega() {
    return Padding(
      padding: margenSimetrico2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tiempo de Entrega ',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          DropdownButton(
              value: valorDiaEntrega,
              items: listaOpciones.getOpcionDiasEntrega(),
              onChanged: (opt) {
                setState(() {
                  valorDiaEntrega = opt;
                });
              }),
        ],
      ),
    );
  }

  Widget _fomaPago() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Checkbox(
                  value: forma1,
                  onChanged: (opt) {
                    setState(() {
                      if (opt == true) {
                        forma1 = opt;
                        forma2 = false;
                        forma3 = false;
                      } else {
                        forma1 = false;
                      }
                    });
                  },
                ),
                Text('Cheque')
              ],
            ),
            Column(
              children: [
                Checkbox(
                  value: forma2,
                  onChanged: (opt) {
                    setState(() {
                      if (opt == true) {
                        forma1 = false;
                        forma2 = opt;
                        forma3 = false;
                      }
                    });
                  },
                ),
                Text('Efectivo')
              ],
            ),
            Column(
              children: [
                Checkbox(
                  value: forma3,
                  onChanged: (opt) {
                    setState(() {
                      if (opt == true) {
                        forma1 = false;
                        forma2 = false;
                        forma3 = true;
                      }
                    });
                  },
                ),
                Text('Banco')
              ],
            ),
          ],
        ),
        Padding(
          padding: margenSimetrico,
          child: _opcionFormaDepagos(),
        )
      ],
    );
  }

  Widget _opcionFormaDepagos() {
    TextEditingController controller;
    final nombreCheque = TextFormField(
      controller: controller,
      decoration: txtNombreCheque,
    );

    final banco = Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Seleccione un Banco'),
          DropdownButton(
              value: valorBanco,
              items: listaOpciones.getOpcionBanco(),
              onChanged: (opt) {
                setState(() {
                  valorBanco = opt;
                });
              }),
        ]),
        TextField(
          controller: numeroCuentaController,
          keyboardType: TextInputType.number,
          decoration: txtNumCuenta,
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: txtNombreCuenta,
        )
      ],
    );
    if (forma1 == true) return nombreCheque;
    if (forma3 == true)
      return banco;
    else
      return Container();
  }

  Widget _optFinal() {
    return Column(
      children: [
        CheckboxListTile(
            value: optCliche,
            title: txtcliche,
            onChanged: (value) {
              setState(() {
                optCliche = value;
              });
            }),
        CheckboxListTile(
            value: optImpuesto,
            title: txtimpuestos,
            onChanged: (value) {
              setState(() {
                optImpuesto = value;
              });
            }),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Siguiente',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 10.0),
                  Icon(Icons.navigate_next_rounded)
                ],
              ),
              onPressed: () {
                if (valorPago != null &&
                    valorLugar != null &&
                    valorDiaEntrega != null) {
                  if (forma1) {
                    //TODO:Validar Campos para el cheque
                  } else if (forma2) {
                    //TODO: Validar capos para el efectivo
                  } else if (forma3) {
                    //TODO: Validar campos para banco
                  } else
                    return;
                  Navigator.pushNamed(context, '/cotizacion');
                } else {
                  Fluttertoast.showToast(
                      msg: "Datos incompletos.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      // timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      // textColor: Colors.white,
                      fontSize: 16.0);
                }
                // Navigator.pushNamed(context, '/cotizacion');
              }),
        )
      ],
    );
  }

  Widget _tarjeta(Widget hijos) {
    return Card(
      child: hijos,
    );
  }
}
