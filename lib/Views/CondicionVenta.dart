import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plasticz/Models/CondicionPagoModel.dart';
import 'package:plasticz/Models/CondicionVentaModel.dart';
import 'package:plasticz/Provider/DBProvider.dart';
import 'package:plasticz/Utils/Constantes.dart';
import 'package:plasticz/Utils/Opciones.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plasticz/Utils/PDFGenerate.dart';

class CondicionVentas extends StatefulWidget {
  @override
  _CondicionVentasState createState() => _CondicionVentasState();
}

class _CondicionVentasState extends State<CondicionVentas> {
  Opciones listaOpciones = new Opciones();
  String valorPago,
      valorLugar,
      valorDiaEntrega,
      valorBanco,
      valorFormaPago = "";
  String valorCuenta = "";
  String valorNombre = "";
  String valorDescripcion = "";
  String valorBancoSeleccionado = "";
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
    GenerarPDF generaPDF = new GenerarPDF(context: context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Condición Ventas'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {
              generaPDF.verificarPermisos();
            },
          )
        ],
      ),
      body: ListView(
        children: [
          _tarjeta(
            Column(
              children: [
                SizedBox(height: 10.0),
                _tipodePago(),
                _lugarEntrega(),
                _tiempoEntrega(),
                SizedBox(height: 10.0),
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TIPO DE PAGO',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DropdownButton(
                value: valorPago,
                items: listaOpciones.getOpcionPago(),
                onChanged: (opt) {
                  setState(() {
                    valorPago = opt;
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget _lugarEntrega() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'LUGAR DE ENTREGA',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DropdownButton(
                value: valorLugar,
                items: listaOpciones.getOpcionLugar(),
                onChanged: (opt) {
                  setState(() {
                    valorLugar = opt;
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget _tiempoEntrega() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TIEMPO DE ENTREGA ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DropdownButton(
                value: valorDiaEntrega,
                items: listaOpciones.getOpcionDiasEntrega(),
                onChanged: (opt) {
                  setState(() {
                    valorDiaEntrega = opt;
                  });
                }),
          ),
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
                //METODO POR CHEQUE
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
                // METODO EN EFECTIVO
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
                // METODO BANCO
                Checkbox(
                  value: forma3,
                  onChanged: (opt) {
                    setState(() {
                      if (opt == true) {
                        forma1 = false;
                        forma2 = false;
                        forma3 = opt;
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

    final banco = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SELECCIONE UN BANCO',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            value: valorBanco,
            items: listaOpciones.getOpcionBanco(),
            onChanged: (opt) {
              setState(
                () {
                  valorBanco = opt;
                },
              );
            },
          ),
        ],
      ),
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
                  Text('Guardar Datos',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 10.0),
                  // Icon(Icons.navigate_next_rounded)
                  Icon(Icons.save)
                ],
              ),
              onPressed: () async {
                if (valorPago != null &&
                    valorLugar != null &&
                    valorDiaEntrega != null) {
                  if (forma1) {
                    //TODO:Validar Campos para el cheque
                    valorFormaPago = "CHEQUE";
                    valorBancoSeleccionado = "";
                    valorCuenta = "";
                    valorNombre = "INDUSTRIA PLASTIC Z SRL.";
                    valorDescripcion = "";
                  } else if (forma2) {
                    //TODO: Validar capos para el efectivo
                    valorFormaPago = "EFECTIVO";
                    valorBancoSeleccionado = "";
                    valorCuenta = "";
                    valorNombre = "";
                    valorDescripcion = "";
                  } else if (forma3) {
                    //TODO: Validar campos para banco
                    valorFormaPago = "BANCO";
                    valorBancoSeleccionado = valorBanco;
                    valorDescripcion = "";
                    switch (valorBanco) {
                      case 'BCP':
                        valorCuenta = '201-5081923-3-86 M/N';
                        valorNombre = 'INDUSTRIA PLASTIC Z SRL NIT: 365262023';
                        break;
                      case 'MERCANTIL SANTA CRUZ':
                        valorCuenta = '4068283963 M/N';
                        valorNombre = 'INDUSTRIA PLASTIC Z SRL NIT: 365262023';
                        break;
                      case 'BANCO NACIONAL DE BOLIVIA':
                        valorCuenta = '1501638710';
                        valorNombre =
                            'JHANYR NARDY ZUÑAGUA HUANCA CI:6888256 LP';
                        break;
                      case 'BANCO SOL':
                        valorCuenta = '1857835000001 M/N';
                        valorNombre =
                            'JHANYR NARDY ZUÑAGUA HUANCA CI:6888256 LP';
                        break;
                      case 'BANCO FIE':
                        valorCuenta = '40011491148';
                        valorNombre =
                            'JHANYR NARDY ZUÑAGUA HUANCA CI:6888256 LP';
                        break;
                      case 'BANCO UNION':
                        valorCuenta = '10000001492614 M/N';
                        valorNombre =
                            'JHANYR NARDY ZUÑAGUA HUANCA CI:6888256 LP';
                        break;
                      default:
                        valorCuenta = '';
                        valorNombre = '';
                        break;
                    }
                  } else {
                    return Fluttertoast.showToast(
                        msg: "Datos incompletos.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        // timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        // textColor: Colors.white,
                        fontSize: 16.0);
                  }
                  _showDialog();
                  setState(() {});
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
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _tarjeta(Widget hijos) {
    return Card(
      child: hijos,
    );
  }

  _showDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Text(
                  'Verificar Datos Cliente',
                  textAlign: TextAlign.center,
                ),
                SvgPicture.asset(
                  'assets/img/confirm.svg',
                  width: 80,
                  height: 80,
                ),
              ],
            ),
            content: Text(
              'Esta seguro de que los datos regitrados estan correctos?',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                child: Text('No, Volver'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Si, Registrar'),
                onPressed: () async {
                  await DBProvider.db.insertarCVenta(CondicionVentaModel(
                    formaPago: valorPago,
                    lugarEntrega: valorLugar,
                    tiempoEntrega: valorDiaEntrega,
                  ));
                  await DBProvider.db.insertarCPago(CondicionPagoModel(
                    tipoPago: valorFormaPago,
                    banco: valorBancoSeleccionado,
                    numCuenta: valorCuenta,
                    nombre: valorNombre,
                    descripcion: valorDescripcion,
                  ));
                  //await pdfDocument.generarPdfAndView(context);
                  Navigator.of(context).pop();
                  // Navigator.pushNamed(context, '/cotizacion');
                },
              )
            ],
          );
        });
  }
}
