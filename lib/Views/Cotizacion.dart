import 'package:flutter/material.dart';
import 'package:plasticz/Provider/DBProvider.dart';
import 'package:plasticz/Utils/Constantes.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cotización'),
          actions: [_menuOption()],
        ),
        //TODO: MOSTRAR VALORES REGISTRADOS
        body: FutureBuilder(
          future: DBProvider.db.getBolsa(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ModeloBolsa>> snapshot) {
            final resp = snapshot.data;
            print('Cantidad de bolsas - ${resp.length}');
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: resp.length,
                itemBuilder: (_, i) {
                  return Card(
                    child: Container(
                      padding: padingCard,
                      child: ListTile(
                        title: Text('${resp[i].producto}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${resp[i].tipoProducto}'),
                            Divider(),
                            Text('Ancho: ${resp[i].ancho}'),
                            Text('Largo: ${resp[i].largo}'),
                            Text('Espesor: ${resp[i].espesor}'),
                            Text('Cantidad: ${resp[i].cantidad}'),
                            Text('Precio por Bolsa: ${resp[i].precioPorBolsa}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text('No hay data...!!');
            }
          },
        ),
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
