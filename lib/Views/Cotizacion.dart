import 'package:flutter/material.dart';
import 'package:plasticz/Provider/DBProvider.dart';
import 'package:plasticz/Utils/Opciones.dart';
import 'package:plasticz/Utils/Operaciones.dart';
import 'package:sqflite/sqflite.dart';

class CotizacionView extends StatefulWidget {
  @override
  _CotizacionViewState createState() => _CotizacionViewState();
}

class _CotizacionViewState extends State<CotizacionView> {
  Opciones listaOpciones = new Opciones();
  Operaciones operacion = new Operaciones();
  bool bolsa = false, bobina = false;
  List<ModeloBolsa> itemBolsa = [];

  @override
  Widget build(BuildContext context) {
    // final bolsaValue = DBProvider.db.getBolsa();
    // print(bolsaValue);

    return Scaffold(
        appBar: AppBar(
          title: Text('Cotización'),
          actions: [_menuOption()],
        ),
        body: Text('DATOS...'),

        //TODO: MOSTRAR VALORES REGISTRADOS

        // Text('Data..!!!'),
        // FutureBuilder(
        //   future: bolsaValue,
        //   builder: (context, AsyncSnapshot<List<ModeloBolsa>> snapshot) {
        //     if (snapshot.hasData) {
        //       return Text('DATA...!!!!');
        //     } else {
        //       return Text('NO HAY DATA...!!!');
        //     }
        //   },
        // ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/insertarProducto');
          },
        ));
  }

  //POPUP DE ALERTA
  _showDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Seleccione Producto'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Checkbox(
                              value: bolsa,
                              onChanged: (val) {
                                setState(() {
                                  if (val == true) {
                                    bolsa = val;
                                    bobina = false;
                                  }
                                });
                              }),
                          Text('BOLSA')
                        ],
                      ),
                      Column(
                        children: [
                          Checkbox(
                              value: bobina,
                              onChanged: (val) {
                                setState(() {
                                  if (val == true) {
                                    bobina = val;
                                    bolsa = false;
                                  }
                                });
                              }),
                          Text('BOBINA')
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Ok!!!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget _menuOption() {
    return PopupMenuButton(
      onSelected: optAccion,
      itemBuilder: (BuildContext context) {
        return listaOpciones.menuOptions
            .map((dato) => PopupMenuItem(value: dato, child: Text(dato)))
            .toList();
      },
    );
  }

  void optAccion(String opcion) {
    if (opcion == 'ExportarPDF') {
      print('ExportarPDF');
    } else if (opcion == 'Enviar') {
      print('Enviar');
    } else {
      print('Nueva Cotización');
    }
  }
}
