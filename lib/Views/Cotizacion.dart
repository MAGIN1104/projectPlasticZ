import 'package:flutter/material.dart';
import 'package:plasticz/Provider/DBProvider.dart';
import 'package:plasticz/Utils/Constantes.dart';
import 'package:plasticz/Utils/Opciones.dart';
import 'package:plasticz/Utils/Operaciones.dart';

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
    final productos = DBProvider.db.getAllProduct();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotización'),
        actions: [_menuOption()],
      ),
      //TODO: MOSTRAR VALORES REGISTRADOS
      body: FutureBuilder(
        future: productos,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final resp = snapshot.data;
            if (resp.isEmpty) {
              return Center(child: Text('Inserte nuevo item....'));
            } else {
              return ListView.builder(
                itemCount: resp.length,
                itemBuilder: (_, i) {
                  return Dismissible(
                    key: UniqueKey(),
                    // onDismissed: (DismissDirection direccion) {
                    //   //TODO: IMPLEMENTAR METODO BORRAR
                    // },
                    child: Card(
                      child: ExpansionTile(
                        title: Text(
                          '${resp[i].producto}',
                          style: estiloTitulo,
                        ),
                        subtitle: Text('${resp[i].tipoProducto}'),
                        children: [
                          Container(
                            padding: margenSimetrico,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _detailsItem('Ancho', '${resp[i].ancho}'),
                                _detailsItem('Largo', '${resp[i].largo}'),
                                _detailsItem('Espesor', '${resp[i].espesor}'),
                                _detailsItem('Cantidad', '${resp[i].cantidad}'),
                                Divider(),
                                Text('TOTAL', style: descripcionItemStyle),
                                _detailsItem('Kilos', '${resp[i].tkilos}'),
                                _detailsItem('Precio c/Bolsa',
                                    '${resp[i].precioUnitario}'),
                                _detailsItem(
                                    'Precio Total', '${resp[i].precioTotal}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: Text('Insterte nuevos items.'),
            );
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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

  Widget _detailsItem(String detalle, String valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(detalle, style: descripcionItemStyle),
        Text(valor),
      ],
    );
  }
}
