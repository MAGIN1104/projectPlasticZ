import 'package:flutter/material.dart';
import 'package:plasticz/Utils/Opciones.dart';

class CondicionVentas extends StatefulWidget {
  @override
  _CondicionVentasState createState() => _CondicionVentasState();
}

class _CondicionVentasState extends State<CondicionVentas> {
  Opciones listaOpciones = new Opciones();
  String valorPago, valorLugar, valorDiaEntrega, valorBanco;
  bool forma1 = true,
      forma2 = false,
      forma3 = true,
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
          _tipodePago(),
          Divider(),
          _lugarEntrega(),
          Divider(),
          _tiempoEntrega(),
          Divider(),
          _fomaPago(),
          Divider(),
          _optFinal()
        ],
      ),
    );
  }

  Widget _tipodePago() {
    //DropDown
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tipo de Pago ',
            style: TextStyle(fontSize: 17),
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
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Lugar de Entrega ',
            style: TextStyle(fontSize: 17),
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
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tiempo de Entrega ',
            style: TextStyle(fontSize: 17),
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
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: _opcionFormaDepagos(forma1, forma2, forma3),
        )
      ],
    );
  }

  Widget _opcionFormaDepagos(bool forma1, bool forma2, bool forma3) {
    TextEditingController controller;
    final nombreCheque = TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: 'Nombre al cual va el cheque...'),
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
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'Número de cuenta...'),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Nombre de la Cuenta...'),
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
            title: Text('Incluye precio cliche'),
            onChanged: (value) {
              setState(() {
                optCliche = value;
              });
            }),
        CheckboxListTile(
            value: optImpuesto,
            title: Text('Incluye inpuestos de ley'),
            onChanged: (value) {
              setState(() {
                optImpuesto = value;
              });
            }),
      ],
    );
  }
}
