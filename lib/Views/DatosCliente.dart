import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plasticz/Provider/DBProvider.dart';
import 'package:plasticz/Utils/Constantes.dart';
import 'package:plasticz/Models/PersonModel.dart';

class DatosCliente extends StatefulWidget {
  DatosCliente({Key key}) : super(key: key);

  @override
  _DatosClienteState createState() => _DatosClienteState();
}

class _DatosClienteState extends State<DatosCliente> {
  final String assetName = 'assets/img/user.svg';
  String nombreCliente = '';
  String ciCliente = '';
  String empresaCliente = '';
  String mailCliente = '';
  String celtelCliente = '';
  final nombreController = TextEditingController();
  final ciController = TextEditingController();
  final empresaController = TextEditingController();
  final mailController = TextEditingController();
  final celtelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Datos Cliente'),
        // ),
        body: Center(
      child: SingleChildScrollView(
          child: Container(
        padding: margenSimetrico,
        child: Card(
          child: Container(
            padding: margenSimetrico,
            child: Column(
              children: [
                Center(
                    child: SvgPicture.asset(
                  assetName,
                  width: 100,
                  height: 100,
                )),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'DATOS DEL CLIENTE',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 30.0,
                ),

                //NOMBRE CLIENTE
                TextField(
                  controller: nombreController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre Cliente',
                    hintText: 'Nombre Completo',
                  ),
                  onChanged: (value) {
                    setState(() {
                      nombreCliente = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),

                //CI CLIENTE
                TextField(
                  controller: ciController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Carnet de Identidad',
                    hintText: 'CI',
                  ),
                  onChanged: (value) {
                    setState(() {
                      ciCliente = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                //NOMBRE DE LA EMPRESA
                TextField(
                  controller: empresaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Empresa',
                    hintText: 'Nombre de la Empresa',
                  ),
                  onChanged: (value) {
                    setState(() {
                      empresaCliente = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: mailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'ejemplo@gmail.com',
                  ),
                  onChanged: (value) {
                    setState(() {
                      mailCliente = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: celtelController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Celular/Teléfono',
                    hintText: 'Celular/Teléfono',
                  ),
                  onChanged: (value) {
                    setState(() {
                      celtelCliente = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                    child: Text('Registrar Cliente'),
                    textColor: Colors.white,
                    color: Colors.black,
                    shape: StadiumBorder(),
                    onPressed: () async {
                      if (nombreController.text.isNotEmpty &&
                          ciController.text.isNotEmpty &&
                          empresaController.text.isNotEmpty &&
                          mailController.text.isNotEmpty &&
                          celtelController.text.isNotEmpty) {
                        await _showDialog();

                        setState(() {});
                      } else {
                        final snackBar = SnackBar(
                            content: Text('Complete todos los campos...!'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
              ],
            ),
          ),
        ),
      )),
    ));
  }

  _showDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verificar Datos Cliente'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Center(
                      child: SvgPicture.asset(
                    assetName,
                    width: 50,
                    height: 50,
                  )),
                  SizedBox(height: 10.0),
                  Text('Nombre - ${nombreCliente.toUpperCase()}'),
                  Text('CI - $ciCliente'),
                  Text('Empresa - ${empresaCliente.toUpperCase()}'),
                  Text('Mail - $mailCliente'),
                  Text('Cel/Tel - $celtelCliente'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('VOLVER'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('REGISTRAR'),
                onPressed: () async {
                  await DBProvider.db.insertarCliente(PersonaModel(
                    nombre: nombreCliente.toUpperCase(),
                    ci: ciCliente,
                    empresa: empresaCliente.toUpperCase(),
                    email: mailCliente,
                    cel: celtelCliente,
                  ));
                  await Navigator.popAndPushNamed(context, '/cotizacion');
                },
              )
            ],
          );
        });
  }
}
