import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:plasticz/Provider/DBProvider.dart';
import 'package:plasticz/Utils/Constantes.dart';
import 'package:plasticz/Utils/Opciones.dart';
import 'package:plasticz/Utils/Operaciones.dart';
import 'package:pdf/widgets.dart' as pw;
import 'PDFPage.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class CotizacionView extends StatefulWidget {
  @override
  _CotizacionViewState createState() => _CotizacionViewState();
}

class _CotizacionViewState extends State<CotizacionView> {
  Opciones listaOpciones = new Opciones();
  Operaciones operacion = new Operaciones();
  bool bolsa = false, bobina = false;
  String nombre = '';

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
                    onDismissed: (DismissDirection direccion) {
                      //TODO: IMPLEMENTAR METODO BORRAR
                      setState(() {
                        DBProvider.db.borrarProducto(resp[i]);
                      });
                    },
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
                                _detailsItem('Precio Unitario',
                                    '${resp[i].precioUnitario}'),
                                _precioRollo('${resp[i].producto}',
                                    '${resp[i].precioRollo}'),
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
        onPressed: () async {
          await Navigator.pushNamed(context, '/insertarProducto');
          setState(() {});
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
      _verificarPermisos();
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

  Widget _precioRollo(String vtipo, String valor) {
    if (vtipo == 'BOBINA') {
      return _detailsItem('Precio Rollo', valor);
    } else {
      return SizedBox(height: 0);
    }
  }

  _generarPdfAndView(contex) async {
    List<ProductModel> data = await DBProvider.db.getAllProduct();
    final pw.Document pdf = pw.Document(deflate: zlib.encode);
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        build: (context) => [
              pw.Row(children: [
                pw.Text('CLIENTE'),
                pw.SizedBox(width: 20),
                pw.Text('PEPITO'),
                pw.SizedBox(width: 5),
                pw.Text('PEREZ'),
                pw.SizedBox(width: 5),
                pw.Text('PEREZ'),
              ]),
              pw.Table.fromTextArray(
                  cellPadding:
                      pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Producto',
                      'Detalle',
                      'Ancho\n(cm)',
                      'Largo\n(cm)',
                      'Espesor\nmicrones',
                      'Cantidad',
                      'Unidad',
                      'Eq.\nAprox(Kg)',
                      'Rollos',
                      'TOTAL\n(Bs)'
                    ],
                    ...data.map((e) => [
                          e.producto,
                          e.tipoProducto,
                          e.ancho.toString(),
                          e.largo.toString(),
                          e.espesor.toString(),
                          e.cantidad.toString(),
                          e.unidad,
                          e.tkilos.toString(),
                          e.precioRollo.toString(),
                          e.precioTotal.toString()
                        ])
                  ]),
            ]));
    final String dir = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
    final String path = '$dir/pruebaFlutter.pdf';
    final File file = File(path);
    file.writeAsBytesSync(await pdf.save());
    print(path);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => PDFViewerPage(path: path)));
  }

  void _verificarPermisos() async {
    final status = await Permission.storage.request();
    switch (status) {
      case PermissionStatus.granted:
        _generarPdfAndView(context);
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
    // if (status == PermissionStatus.granted) {
    //   _generarPdfAndView(context);
    // } else {
    //   print('No se pudo guardar');
    // }
  }
}
