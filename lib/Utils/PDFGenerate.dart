import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plasticz/Models/CondicionPagoModel.dart';
import 'package:plasticz/Models/CondicionVentaModel.dart';
import 'package:plasticz/Provider/DBProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:plasticz/Models/PersonModel.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:plasticz/Views/PDFPage.dart';

class GenerarPDF {
  GenerarPDF({this.context});
  BuildContext context;
  double ptotal = 0;
  void verificarPermisos() async {
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      generarPdfAndView(context);
    } else {
      openAppSettings();
    }
  }

  generarPdfAndView(context) async {
    String path;
    List<ProductModel> data = await DBProvider.db.getAllProduct();
    List<PersonaModel> clientdata = await DBProvider.db.getCliente();
    List<CondicionVentaModel> cvdata = await DBProvider.db.getCVentas();
    List<CondicionPagoModel> cpdata = await DBProvider.db.getCPago();
    var totalBS = await itemTotal();
    final logoBolivia = pw.MemoryImage(
      (await rootBundle.load('assets/img/bolivia.png')).buffer.asUint8List(),
    );

    final pw.Document pdf = pw.Document(deflate: zlib.encode);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        build: (context) => [
          pw.Container(
            alignment: pw.Alignment.centerRight,
            width: double.infinity,
            child: pw.Text(
              'Fecha de Registro: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
              style: pw.TextStyle(fontSize: 10),
            ),
          ),

          //DATOS CLIENTE
          pw.Container(
            width: double.infinity,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black),
            ),
            padding: pw.EdgeInsets.only(
                left: 5.0, top: 10.0, bottom: 10.0, right: 5.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    'DATOS DEL CLIENTE',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Divider(),
                pw.SizedBox(height: 10.0),
                pw.Row(children: [
                  pw.Container(
                    width: 180,
                    child:
                        pw.Text('CLIENTE', style: pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Text(' ${clientdata.last.nombre}',
                      style: pw.TextStyle(fontSize: 10))
                ]),
                pw.Row(children: [
                  pw.Container(
                    width: 180,
                    child: pw.Text('CI/NIT', style: pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Text(' ${clientdata.last.ci}',
                      style: pw.TextStyle(fontSize: 10))
                ]),
                pw.Row(children: [
                  pw.Container(
                    width: 180,
                    child:
                        pw.Text('CELULAR', style: pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Text(' ${clientdata.last.cel}',
                      style: pw.TextStyle(fontSize: 10))
                ]),
                pw.Row(children: [
                  pw.Container(
                    width: 180,
                    child: pw.Text('CORREO ELECTRONICO',
                        style: pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Text(' ${clientdata.last.email}',
                      style: pw.TextStyle(fontSize: 10))
                ]),
                pw.Row(children: [
                  pw.Container(
                    width: 180,
                    child:
                        pw.Text('EMPRESA', style: pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Text(' ${clientdata.last.empresa}',
                      style: pw.TextStyle(fontSize: 10))
                ]),
                pw.Row(children: [
                  pw.Container(
                    width: 180,
                    child: pw.Text('REFERENCIA',
                        style: pw.TextStyle(fontSize: 10)),
                  ),
                  pw.Text('SOLICITUD DE COTIZACIÓN',
                      style: pw.TextStyle(fontSize: 10))
                ]),
              ],
            ),
          ),
          pw.SizedBox(height: 20.0),

          //TABLA DE PRODUCTOS REGISTRADOS
          pw.Table.fromTextArray(
            cellPadding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            context: context,
            cellStyle: pw.TextStyle(fontSize: 8),
            headerStyle:
                pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
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
              ...data.map(
                (e) => [
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
                ],
              ),
            ],
          ),

          pw.SizedBox(height: 10.0),

          //TOTAL A PAGAR
          pw.Container(
            alignment: pw.Alignment.centerRight,
            // margin: const pw.EdgeInsets.symmetric(horizontal: 20),
            height: 10,
            child: pw.FittedBox(
              child: pw.Text(
                'Total:        $totalBS Bs.-',
                style: pw.TextStyle(
                    fontSize: 25,
                    color: PdfColors.green,
                    fontWeight: pw.FontWeight.bold),
              ),
            ),
          ),

          //CONDICION VENTA
          pw.SizedBox(height: 20.0),
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black),
              color: PdfColors.blue,
            ),
            width: double.infinity,
            child: pw.Center(
              child: pw.Text('CONDICION VENTA',
                  style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white)),
            ),
          ),
          pw.Table.fromTextArray(
            headerAlignment: pw.Alignment.centerLeft,
            cellStyle: pw.TextStyle(fontSize: 10),
            headerStyle: pw.TextStyle(fontSize: 10),
            data: <List<String>>[
              <String>[
                'Forma de Pago:',
                cvdata.last.formaPago,
              ],
              <String>[
                'Lugar de Entrega:',
                cvdata.last.lugarEntrega,
              ],
              <String>[
                'Tiempo de Entrega:',
                cvdata.last.tiempoEntrega,
              ],
            ],
          ),

          //OBSERVACIONES
          pw.SizedBox(height: 10),
          pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                  color: PdfColors.grey100),
              width: double.infinity,
              child: pw.Column(children: [
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    'OBSERVACIONES',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                        'Estructura.- Producto con tolerancia +/- 10, material reciclado con UV'),
                    pw.SizedBox(width: 20),
                    pw.Container(
                      width: 40,
                      height: 40,
                      child: pw.Image(logoBolivia),
                    )
                  ],
                ),
                pw.SizedBox(height: 10)
              ])),

          //CONDICION PAGO
          pw.SizedBox(height: 20.0),
          pw.Container(
            decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black),
                color: PdfColors.amber),
            width: double.infinity,
            child: pw.Center(
              child: pw.Text(
                'PAGO',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
          ),
          pw.Table.fromTextArray(
            headerAlignment: pw.Alignment.centerLeft,
            cellStyle: pw.TextStyle(fontSize: 10),
            headerStyle: pw.TextStyle(fontSize: 10),
            data: <List<String>>[
              <String>['1', 'EFECTIVO', cpdata.last.descripcion],
              <String>['2', 'CHEQUE', 'PLASTIC Z SRL.'],
              <String>[
                '3',
                'DEPOSITO EN EFECTIVO',
                'BANCO: ${cpdata.last.banco}\nNOMBRE: ${cpdata.last.nombre}\nN° CUENA: ${cpdata.last.numCuenta}'
              ],
            ],
          ),
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black),
            ),
            width: double.infinity,
            child: pw.Container(
              padding: pw.EdgeInsets.only(left: 5.0, top: 10.0, bottom: 10.0),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // pw.Row(
                  //   children: [
                  //     pw.Container(
                  //       width: 18,
                  //       child: pw.Text('3'),
                  //     ),
                  //     pw.Text(
                  //       'DEPOSITO EN EFECTIVO',
                  //       style: pw.TextStyle(fontSize: 12),
                  //     ),
                  //   ],
                  // ),
                  // pw.SizedBox(height: 10.0),
                  // pw.Text('BANCO - ${cpdata.last.banco}',
                  //     style: pw.TextStyle(fontSize: 12)),
                  // pw.Text('NOMBRE - ${cpdata.last.nombre}',
                  //     style: pw.TextStyle(fontSize: 12)),
                  // pw.Text('N° CUENA - ${cpdata.last.numCuenta}',
                  //     style: pw.TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // final String dir = await ExtStorage.getExternalStoragePublicDirectory('DocumentsplasticZ');
    Directory directorio;
    if (Platform.isAndroid) {
      directorio = await getExternalStorageDirectory();
      print(directorio.path);

      String newpath = "";
      List<String> folders = directorio.path.split("/");
      for (int x = 1; x < folders.length; x++) {
        String folder = folders[x];
        if (folder != "Android") {
          newpath += "/" + folder;
        } else {
          break;
        }
      }
      newpath = newpath + "/PlasticZ_PDFS";
      directorio = Directory(newpath);
      final String dir = directorio.path;
      path =
          '$dir/${clientdata.first.nombre.trim()}-${clientdata.first.ci}.pdf';
      print('Directorio nuevo === > ${directorio.path}');
    } else {
      return false;
    }
    if (!await directorio.exists()) {
      await directorio.create(recursive: true);
    }
    if (await directorio.exists()) {
      final File file = File(path);
      file.writeAsBytesSync(await pdf.save());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => PDFViewerPage(path: path)));
    }
  }

  Future<double> itemTotal() async {
    final resp = await DBProvider.db.getAllProduct();
    if (resp.isNotEmpty) {
      ptotal = 0;
      for (var item in resp) {
        ptotal += item.precioTotal;
      }
      print('=========> TOTAL:$ptotal');
      return ptotal;
    } else {
      // ptotal = 0.0;
      return 0.0;
    }
  }
}
