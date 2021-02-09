import 'package:flutter/material.dart';
import 'package:plasticz/Provider/DBProvider.dart';
import 'package:plasticz/Utils/Constantes.dart';
import 'package:plasticz/Utils/Operaciones.dart';

class RegistrarProducto extends StatefulWidget {
  @override
  _RegistrarProductoState createState() => _RegistrarProductoState();
}

class _RegistrarProductoState extends State<RegistrarProducto> {
  bool bolsa = false, bobina = false;
  bool bbaja = false, balta = false, bpp = false;
  bool bobPEBD = false, bobPEAD = false, bobPP = false;

  //Datos Iniciales Producto
  String vproducto = "";
  String vunidad = "";
  String vtipoproducto = "";
  String vancho = "0";
  String vlargo = "0";
  String vespesor = "0";
  String vcantidad = "0";
  String vpkilo = "0";
  String vcolor = "";
  String vcunidad = "0";
  String vaunidadMedida = "";

  double precioRollo = 0;

  final anchoController = TextEditingController();
  final largoController = TextEditingController();
  final espesorController = TextEditingController();
  final cantidadController = TextEditingController();
  final pkiloController = TextEditingController();
  final colorController = TextEditingController();

  Operaciones operacion = new Operaciones();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registro de Producto'),
        ),
        body: ListView(
          padding: margenSimetrico,
          children: [
            //PARTE 1 OPCIONES
            _opciones(),

            //INGRESAR DATOS
            Card(
                child: Container(
                    padding: padingCard, child: _bodyContent(bolsa, bobina))),

            //MOSTRAR RESULTADO
            _resultContent()
          ],
        ));
  }

  Widget _opciones() {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            txtSelectTipoProducto,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Checkbox(
                        value: bolsa,
                        onChanged: (valor) {
                          setState(() {
                            if (valor == true) {
                              vproducto = "BOLSA";
                              vunidad = "BOLSAS";
                              vaunidadMedida = "(Bolsas)";
                              bolsa = valor;
                              bobina = false;
                              anchoController.clear();
                              largoController.clear();
                              espesorController.clear();
                              cantidadController.clear();
                              pkiloController.clear();
                              colorController.clear();
                            }
                          });
                        }),
                    Text('Bolsa')
                  ],
                ),
                Column(
                  children: [
                    Checkbox(
                        value: bobina,
                        onChanged: (valor) {
                          setState(() {
                            if (valor == true) {
                              vproducto = "BOBINA";
                              vunidad = "ROLLOS";
                              vaunidadMedida = "(Metros)";
                              bobina = valor;
                              bolsa = false;
                              anchoController.clear();
                              largoController.clear();
                              espesorController.clear();
                              cantidadController.clear();
                              pkiloController.clear();
                              colorController.clear();
                            }
                          });
                        }),
                    Text('Bobina')
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyContent(bool bolsa, bool bobina) {
    final tipoProducto = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seleccione tipo de ${vproducto.toLowerCase()}:',
          style: szfuente,
        ),
        _tipoProducto(),
        SizedBox(height: 30.0),
        txtIngreseDatos,
        SizedBox(height: 15.0),

        //ANCHO
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ANCHO'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    controller: anchoController,
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vancho = "0";
                        } else {
                          vancho = valor;
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ej. 12.3 ',
                    ))),
          ],
        ),

        //LARGO
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('LARGO'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    controller: largoController,
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vlargo = "0";
                        } else {
                          vlargo = valor;
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ej. 12.3',
                    ))),
          ],
        ),

        // ESPESOR
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ESPESOR'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    controller: espesorController,
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vespesor = "0";
                        } else {
                          vespesor = valor;
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ej. 12.3',
                    ))),
          ],
        ),

        //CANTIDAD
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('CANTIDAD'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    controller: cantidadController,
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vcantidad = "0";
                        } else {
                          vcantidad = valor;
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ej. 12.3',
                    ))),
          ],
        ),

        //PRECIO KILO
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('PRECIO KILO'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    controller: pkiloController,
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vpkilo = "0";
                        } else {
                          vpkilo = valor;
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ej. 12.3',
                    ))),
          ],
        ),

        //COLOR
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('COLOR'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    controller: colorController,
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vcolor = " ";
                        } else {
                          vcolor = valor;
                        }
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Ej. Rojo',
                    ))),
          ],
        ),
      ],
    );

    //De acuerdo a la opcion seleccionada mostrara el contenido
    if (bolsa || bobina)
      return tipoProducto;
    else
      return Center(child: Text('SELECCIONE PRODUCTO'));
  }

  //CheckOption
  Widget checkOption(String name, Widget chOpt) {
    return Column(
      children: [chOpt, Text(name)],
    );
  }

  Widget _resultContent() {
    double vtotalkilo = 0;
    double totalPrecioxUnidad = 0;
    double totalPrecio = 0;

    //TARJETAS DE LOS RESULTADOS DE LAS BOLSAS

    //CONDICION PARA OPERACION DE LAS BOLSAS
    if (bbaja && bolsa) {
      vtotalkilo = double.parse(operacion
          .bolsaBajaKilos(double.parse(vancho), double.parse(vlargo),
              double.parse(vespesor), int.parse(vcantidad))
          .toStringAsFixed(4));
      totalPrecio = double.parse(operacion
          .precioTotal(vtotalkilo, double.parse(vpkilo))
          .toStringAsFixed(3));
      totalPrecioxUnidad = double.parse(operacion
          .precioXUnidad(totalPrecio, double.parse(vcantidad))
          .toStringAsFixed(7));
    } else if (balta && bolsa) {
      vtotalkilo = double.parse(operacion
          .bolsaAKilos(double.parse(vancho), double.parse(vlargo),
              double.parse(vespesor), int.parse(vcantidad))
          .toStringAsFixed(4));
      totalPrecio = double.parse(operacion
          .precioTotal(vtotalkilo, double.parse(vpkilo))
          .toStringAsFixed(3));
      totalPrecioxUnidad = double.parse(operacion
          .precioXUnidad(totalPrecio, double.parse(vcantidad))
          .toStringAsFixed(7));
    } else if (bpp && bolsa) {
      vtotalkilo = double.parse(operacion
          .bolsaPPKilos(double.parse(vancho), double.parse(vlargo),
              double.parse(vespesor), int.parse(vcantidad))
          .toStringAsFixed(4));
      totalPrecio = double.parse(operacion
          .precioTotal(vtotalkilo, double.parse(vpkilo))
          .toStringAsFixed(3));
      totalPrecioxUnidad = double.parse(operacion
          .precioXUnidad(totalPrecio, double.parse(vcantidad))
          .toStringAsFixed(7));
    }

    //CONDICION PARA OPERACION DE LAS BOBINAS
    if (bobPEBD && bobina) {
      vtotalkilo = double.parse(operacion
          .kilosXRolloPEBD(double.parse(vancho), double.parse(vespesor),
              double.parse(vlargo))
          .toStringAsFixed(4));
      precioRollo = double.parse(operacion
          .precioTotal(vtotalkilo, double.parse(vpkilo))
          .toStringAsFixed(3));
      totalPrecioxUnidad = double.parse(operacion
          .precioXUnidad(precioRollo, double.parse(vlargo))
          .toStringAsFixed(7));
      totalPrecio = double.parse(operacion
          .precioTotal(precioRollo, double.parse(vcantidad))
          .toStringAsFixed(3));
    } else if (bobPP && bobina) {
      vtotalkilo = double.parse(operacion
          .kilosXRolloPP(double.parse(vancho), double.parse(vespesor),
              double.parse(vlargo))
          .toStringAsFixed(4));
      precioRollo = double.parse(operacion
          .precioTotal(vtotalkilo, double.parse(vpkilo))
          .toStringAsFixed(3));
      totalPrecioxUnidad = double.parse(operacion
          .precioXUnidad(precioRollo, double.parse(vlargo))
          .toStringAsFixed(7));
      totalPrecio = double.parse(operacion
          .precioTotal(precioRollo, double.parse(vcantidad))
          .toStringAsFixed(3));
    } else if (bobPEAD && bobina) {
      vtotalkilo = double.parse(operacion
          .kilosXRolloPP(double.parse(vancho), double.parse(vespesor),
              double.parse(vlargo))
          .toStringAsFixed(4));
      precioRollo = double.parse(operacion
          .precioTotal(vtotalkilo, double.parse(vpkilo))
          .toStringAsFixed(3));
      totalPrecioxUnidad = double.parse(operacion
          .precioXUnidad(precioRollo, double.parse(vlargo))
          .toStringAsFixed(7));
      totalPrecio = double.parse(operacion
          .precioTotal(precioRollo, double.parse(vcantidad))
          .toStringAsFixed(3));
    }

    if (bobPEAD || bobPEBD || bobPP || bbaja || balta || bpp) {
      return Card(
          child: mostrarResultProducto(
              '$vproducto - $vtipoproducto',
              vtotalkilo.toString(),
              totalPrecio.toString(),
              totalPrecioxUnidad.toString()));
    } else {
      return Text('');
    }
  }

  //WIDGET PARA MOSTRAR TEXTOS DE LOS DATOS DE ENTRADA
  Widget valueItem(String d1, String v1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(d1), Text(v1)],
    );
  }

  //WIDGET PARA MOSTRAR TARJETA FINAL DE LOS DATOS DE LA BOBINA
  Widget mostrarResultProducto(String tipodeproducto, String totalKilos,
      String precioTotal, String precioUnitario) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(tipodeproducto, style: szfuente),
          valueItem('ANCHO (cm)            ', vancho),
          valueItem('ESPESOR (µm)          ', vespesor),
          valueItem('LARGO (cm)            ', vlargo),
          valueItem('CANDIDAD', vcantidad),
          valueItem('PRECIO KILO (Bs)      ', vpkilo),
          Divider(),
          txtTOTAL,
          valueItem('COLOR', vcolor.toUpperCase()),
          valueItem('EQ. APROX (Kg)', totalKilos),
          valueItem('PRECIO UNITARIO $vaunidadMedida', precioUnitario),
          // valueItem('PRECIO ROLLO', ),
          _precioRollo(),
          valueItem('PRECIO TOTAL (Bs)', precioTotal),
          SizedBox(height: 20.0),
          RaisedButton(
              elevation: 0.0,
              color: Colors.blue,
              textColor: Colors.white,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Añadir Item'),
                SizedBox(width: 20.0),
                Icon(Icons.add_shopping_cart_rounded)
              ]),
              onPressed: () async {
                if (bolsa) {
                  if (anchoController.text.isNotEmpty &&
                      largoController.text.isNotEmpty &&
                      espesorController.text.isNotEmpty &&
                      cantidadController.text.isNotEmpty &&
                      pkiloController.text.isNotEmpty &&
                      colorController.text.isNotEmpty) {
                    final productoDB = await DBProvider.db.insertarProducto(
                        ProductModel(
                            producto: vproducto,
                            tipoProducto: vtipoproducto,
                            color: vcolor.toUpperCase(),
                            ancho: double.parse(vancho),
                            largo: double.parse(vlargo),
                            espesor: double.parse(vespesor),
                            cantidad: int.parse(vcantidad),
                            unidad: vunidad,
                            tkilos: double.parse(totalKilos),
                            precioUnitario: double.parse(precioUnitario),
                            precioRollo: 0.0,
                            precioTotal: double.parse(precioTotal)));
                    Navigator.of(context).pop();
                  } else {
                    _showDialog();
                  }
                } else {
                  if (anchoController.text.isNotEmpty &&
                      largoController.text.isNotEmpty &&
                      espesorController.text.isNotEmpty &&
                      cantidadController.text.isNotEmpty &&
                      pkiloController.text.isNotEmpty &&
                      colorController.text.isNotEmpty) {
                    final productoDB = await DBProvider.db.insertarProducto(
                        ProductModel(
                            producto: vproducto,
                            tipoProducto: vtipoproducto,
                            color: vcolor.toUpperCase(),
                            ancho: double.parse(vancho),
                            largo: double.parse(vlargo),
                            espesor: double.parse(vespesor),
                            cantidad: int.parse(vcantidad),
                            unidad: vunidad,
                            tkilos: double.parse(totalKilos),
                            precioUnitario: double.parse(precioUnitario),
                            precioRollo: precioRollo,
                            precioTotal: double.parse(precioTotal)));
                    print(productoDB);
                    Navigator.of(context).pop();
                  } else {
                    _showDialog();
                  }
                }
                // Navigator.pushNamed(context, '/cotizacion');
              })
        ],
      ),
    );
  }

  Widget _tipoProducto() {
    if (bolsa) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          checkOption(
            'Bolsa Baja',
            Checkbox(
                value: bbaja,
                onChanged: (val) {
                  setState(() {
                    if (val) {
                      vtipoproducto = 'BAJA';
                      bbaja = val;
                      balta = false;
                      bpp = false;
                    } else {
                      bbaja = false;
                    }
                  });
                }),
          ),
          checkOption(
            'Bolsa Alta',
            Checkbox(
                value: balta,
                onChanged: (val) {
                  setState(() {
                    if (val) {
                      vtipoproducto = 'ALTA';
                      bbaja = false;
                      balta = val;
                      bpp = false;
                    }
                  });
                }),
          ),
          checkOption(
            'Bolsa PP',
            Checkbox(
                value: bpp,
                onChanged: (val) {
                  setState(() {
                    if (val) {
                      vtipoproducto = 'PP';
                      bbaja = false;
                      balta = false;
                      bpp = val;
                    }
                  });
                }),
          )
        ],
      );
    } else if (bobina) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          checkOption(
              'PEBD',
              Checkbox(
                  value: bobPEBD,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        vtipoproducto = 'PEBD';
                        bobPEBD = value;
                        bobPEAD = false;
                        bobPP = false;
                      } else {
                        bobPEBD = false;
                      }
                    });
                  })),
          checkOption(
              'PEAD',
              Checkbox(
                  value: bobPEAD,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        vtipoproducto = 'PEAD';
                        bobPEAD = value;
                        bobPP = false;
                        bobPEBD = false;
                      } else {
                        bobPEAD = false;
                      }
                    });
                  })),
          checkOption(
              'PP',
              Checkbox(
                  value: bobPP,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        vtipoproducto = 'PP';
                        bobPP = value;
                        bobPEBD = false;
                        bobPEAD = false;
                      } else {
                        bobPP = false;
                      }
                    });
                  })),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _precioRollo() {
    if (bobina)
      return valueItem('PRECIO ROLLO', precioRollo.toString());
    else
      return SizedBox(height: 0);
  }

  _showDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('CAMPOS INCOMPLETOS'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Center(child: Icon(Icons.edit, size: 40)),
                  SizedBox(height: 10.0),
                  Text(
                    'No puedes añadir este item hasta que completes todos los campos.',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('ACEPTAR'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
