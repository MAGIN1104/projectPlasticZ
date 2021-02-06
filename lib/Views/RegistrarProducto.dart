import 'package:flutter/material.dart';
import 'package:plasticz/Utils/Constantes.dart';
import 'package:plasticz/Utils/Operaciones.dart';

class RegistrarProducto extends StatefulWidget {
  @override
  _RegistrarProductoState createState() => _RegistrarProductoState();
}

class _RegistrarProductoState extends State<RegistrarProducto> {
  bool bolsa = false, bobina = false;
  bool bbaja = false, balta = false, bpp = false;
  bool bobPEBD = false, bobPP = false;

  //Datos Iniciales Bolsa
  String vancho = '0';
  String vlargo = '0';
  String vespesor = '0';
  String vcbolsas = '0';
  String vpkilo = '0';

  //Datos iniciales Bobina
  String vanchoBobina = '0';
  String vespesorBobina = '0';
  String vCanMetros = '0';
  String vpkiloBobina = '0';

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
                              bolsa = valor;
                              bobina = false;
                            } else {
                              bolsa = false;
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
                              bobina = valor;
                              bolsa = false;
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
    final tipoBolsa = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        txtSelectTipoBolsa,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            checkOption(
              'Bolsa Baja',
              Checkbox(
                  value: bbaja,
                  onChanged: (val) {
                    setState(() {
                      if (val == true) {
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
                      if (val == true) {
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
                      if (val == true) {
                        bbaja = false;
                        balta = false;
                        bpp = val;
                      }
                    });
                  }),
            )
          ],
        ),
        SizedBox(height: 30.0),
        txtIngreseDatos,
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ANCHO'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vancho = "0";
                        } else {
                          vancho = valor;
                        }
                      });
                      print(vancho);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ej. 55.55 ',
                    ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('LARGO'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
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
                      hintText: 'Ej. 55.55 ',
                    ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ESPESOR'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
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
                      hintText: 'Ej. 45.55 ',
                    ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('CANT. BOLSAS'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vcbolsas = "0";
                        } else {
                          vcbolsas = valor;
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ej. 123 ',
                    ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('PRECIO KILO'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
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
                      hintText: 'Ej. 120.55 ',
                    ))),
          ],
        ),
      ],
    );

    //TODO: REALIZAR CUERPO DE LAS OPCIONES DE LA BOBINA
    final tipoBobina = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        txtSelectTipoBobina,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            checkOption(
                'Bobina - PEBD',
                Checkbox(
                    value: bobPEBD,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          bobPEBD = value;
                          bobPP = false;
                        } else {
                          bobPEBD = false;
                        }
                      });
                    })),
            checkOption(
                'Bobina - PP',
                Checkbox(
                    value: bobPP,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          bobPP = value;
                          bobPEBD = false;
                        } else {
                          bobPP = false;
                        }
                      });
                    })),
          ],
        ),
        SizedBox(height: 30),
        txtIngreseDatos,
        SizedBox(height: 15),

        //ANCHO
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ANCHO (cm)'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vanchoBobina = "0";
                        } else {
                          vanchoBobina = valor;
                        }
                      });
                      print(vanchoBobina);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ej. 55.55 ',
                    ))),
          ],
        ),

        //ESPESOR
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ESPESOR (cm)'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vespesorBobina = "0";
                        } else {
                          vespesorBobina = valor;
                        }
                      });
                      print(vespesorBobina);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ej. 65.55 ',
                    ))),
          ],
        ),

        //CANTIDAD EN METROS
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('CANTIDAD (m)'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vCanMetros = "0";
                        } else {
                          vCanMetros = valor;
                        }
                      });
                      print(vCanMetros);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ej. 100.55 ',
                    ))),
          ],
        ),

        //PRECIO POR KILO
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('PRECIO p/KILO'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: 150.0,
                child: TextFormField(
                    onChanged: (valor) {
                      setState(() {
                        if (valor.isEmpty) {
                          vpkiloBobina = "0";
                        } else {
                          vpkiloBobina = valor;
                        }
                      });
                      print(vpkiloBobina);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Ej. 110.55 ',
                    ))),
          ],
        ),
      ],
    );

    //De acuerdo a la opcion seleccionada mostrara el contenido
    if (bolsa == true) return tipoBolsa;
    if (bobina == true)
      return tipoBobina;
    else
      return Container();
  }

  //CheckOption
  Widget checkOption(String name, Widget chOpt) {
    return Column(
      children: [chOpt, Text(name)],
    );
  }

  Widget _resultContent() {
    //VARIABLES BOLSA
    double totalKiloBBajo = 0.0, totalKiloBAlto = 0.0, totalKiloBPp = 0.0;
    double totalPrecio = 0.0;
    double totalPrecioxBolsa = 0.0;

    //VARIABLES PARA BOBINA
    double totalKilosXRolloPEBD = 0.0;
    double totalKilosXRolloPP = 0.0;
    double totalPrecioBobina = 0.0;
    double totalPrecioPorMetro = 0.0;

    //CONDICION PARA OPERACION DE LAS BOLSAS
    if (bbaja == true && bolsa == true) {
      totalKiloBBajo = double.parse(operacion
          .bolsaBajaKilos(double.parse(vancho), double.parse(vlargo),
              double.parse(vespesor), int.parse(vcbolsas))
          .toStringAsFixed(2));
      totalPrecio = double.parse(operacion
          .precioTotal(totalKiloBBajo, double.parse(vpkilo))
          .toStringAsFixed(2));
      totalPrecioxBolsa = double.parse(operacion
          .precioXbolsa(totalPrecio, double.parse(vcbolsas))
          .toStringAsFixed(7));
    } else if (balta == true && bolsa == true) {
      totalKiloBAlto = double.parse(operacion
          .bolsaAKilos(double.parse(vancho), double.parse(vlargo),
              double.parse(vespesor), int.parse(vcbolsas))
          .toStringAsFixed(2));
      totalPrecio = double.parse(operacion
          .precioTotal(totalKiloBAlto, double.parse(vpkilo))
          .toStringAsFixed(2));
      totalPrecioxBolsa = double.parse(operacion
          .precioXbolsa(totalPrecio, double.parse(vcbolsas))
          .toStringAsFixed(7));
    } else if (bpp == true && bolsa == true) {
      totalKiloBPp = double.parse(operacion
          .bolsaPPKilos(double.parse(vancho), double.parse(vlargo),
              double.parse(vespesor), int.parse(vcbolsas))
          .toStringAsFixed(2));
      totalPrecio = double.parse(operacion
          .precioTotal(totalKiloBPp, double.parse(vpkilo))
          .toStringAsFixed(2));
      totalPrecioxBolsa = double.parse(operacion
          .precioXbolsa(totalPrecio, double.parse(vcbolsas))
          .toStringAsFixed(7));
    } else {
      totalKiloBBajo = 0.0;
      totalKiloBAlto = 0.0;
      totalKiloBPp = 0.0;
      totalPrecio = 0.0;
      totalPrecioxBolsa = 0.0;
    }

    //CONDICION PARA OPERACION DE LAS BOBINAS
    if (bobPEBD == true && bobina == true) {
      totalKilosXRolloPEBD = double.parse(operacion
          .kilosXRolloPEBD(double.parse(vanchoBobina),
              double.parse(vespesorBobina), double.parse(vCanMetros))
          .toStringAsFixed(2));
      totalPrecioBobina = double.parse(operacion
          .precioTotal(totalKilosXRolloPEBD, double.parse(vpkiloBobina))
          .toStringAsFixed(3));
      totalPrecioPorMetro = double.parse(operacion
          .precioXmetro(totalPrecioBobina, double.parse(vCanMetros))
          .toStringAsFixed(7));
    } else if (bobPP == true && bobina == true) {
      totalKilosXRolloPP = double.parse(operacion
          .kilosXRolloPP(double.parse(vanchoBobina),
              double.parse(vespesorBobina), double.parse(vCanMetros))
          .toStringAsFixed(2));
      totalPrecioBobina = double.parse(operacion
          .precioTotal(totalKilosXRolloPP, double.parse(vpkiloBobina))
          .toStringAsFixed(3));
      totalPrecioPorMetro = double.parse(operacion
          .precioXmetro(totalPrecioBobina, double.parse(vCanMetros))
          .toStringAsFixed(7));
    } else {
      totalKilosXRolloPEBD = 0.0;
      totalKilosXRolloPP = 0.0;
      totalPrecioBobina = 0.0;
      totalPrecioPorMetro = 0.0;
    }

    //TARJETAS DE LOS RESULTADOS DE LAS BOLSAS
    final bBaja = Card(
        child: mostrarDataBolsas('BOLSA BAJA', totalKiloBBajo.toString(),
            totalPrecio.toString(), totalPrecioxBolsa.toString()));
    final bAlta = Card(
        child: mostrarDataBolsas('BOLSA ALTA', totalKiloBAlto.toString(),
            totalPrecio.toString(), totalPrecioxBolsa.toString()));
    final bPp = Card(
        child: mostrarDataBolsas('BOLSA PP', totalKiloBPp.toString(),
            totalPrecio.toString(), totalPrecioxBolsa.toString()));

    //TARJETAS DE LOS RESULTADOS DE LAS BOBINAS
    final _boPebd = Card(
      child: mostrarDataBobina('BOBINA - PEBD', totalKilosXRolloPEBD.toString(),
          totalPrecioBobina.toString(), totalPrecioPorMetro.toString()),
    );
    final _boPP = Card(
      child: mostrarDataBobina('BOBINA - PP', totalKilosXRolloPP.toString(),
          totalPrecioBobina.toString(), totalPrecioPorMetro.toString()),
    );

    //CONDICIONES PARA MOSTRAR RESPUESTAS
    //DEPENDIENDO BOLSA O BOBINA
    if (bbaja == true && bolsa == true) {
      return Container(
        child: bBaja,
      );
    } else if (balta == true && bolsa == true) {
      return Container(
        child: bAlta,
      );
    } else if (bpp == true && bolsa == true) {
      return Container(
        child: bPp,
      );
    } else if (bobPEBD == true && bobina == true) {
      return Container(
        child: _boPebd,
      );
    } else if (bobPP == true && bobina == true) {
      return Container(
        child: _boPP,
      );
    } else {
      return Container();
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

  //WIDGET PARA MOSTRAR TARJETA FINAL DE LOS DATOS DE LA BOLSA
  Widget mostrarDataBolsas(String tipoBolsa, String totalKilos,
      String precioTotal, String precioPorBolsa) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(tipoBolsa, style: szfuente),
          valueItem('ANCHO            ', vancho),
          valueItem('LARGO            ', vlargo),
          valueItem('ESPESOR          ', vespesor),
          valueItem('CANDIDAD BOLSAS  ', vcbolsas),
          valueItem('PRECIO KILO      ', vpkilo),
          Divider(),
          txtTOTAL,
          valueItem('KILOS', totalKilos),
          valueItem('PRECIO TOTAL', precioTotal),
          valueItem('PRECIO c/BOLSA.', precioPorBolsa),
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
              onPressed: () {})
        ],
      ),
    );
  }

  //WIDGET PARA MOSTRAR TARJETA FINAL DE LOS DATOS DE LA BOBINA
  Widget mostrarDataBobina(String tipoBobina, String totalKilos,
      String precioTotal, String precioPorMetro) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(tipoBobina, style: szfuente),
          valueItem('ANCHO            ', vanchoBobina),
          valueItem('ESPESOR          ', vespesorBobina),
          valueItem('CANDIDAD (METROS)', vCanMetros),
          valueItem('PRECIO KILO      ', vpkiloBobina),
          Divider(),
          txtTOTAL,
          valueItem('KILOS POR ROLLO', totalKilos),
          valueItem('PRECIO TOTAL', precioTotal),
          valueItem('PRECIO POR METRO.', precioPorMetro),
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
              onPressed: () {})
        ],
      ),
    );
  }
}
