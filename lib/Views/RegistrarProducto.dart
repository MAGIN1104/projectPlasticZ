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
  String vancho = '0';
  String vlargo = '0';
  String vespesor = '0';
  String vcbolsas = '0';
  String vpkilo = '0';

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
            _opciones(),
            Card(
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                    child: _bodyContent(bolsa, bobina))),
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
        Text(
          'Ingrese datos:',
          style: TextStyle(fontSize: 15.0),
        ),
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
    final tipoBobina = Container(
      color: Colors.blue,
      child: Text('Bobina'),
    );

    //De acuerdo a la opcion seleccionada mostrara el contenido
    if (bolsa == true) return tipoBolsa;
    if (bobina == true)
      return tipoBobina;
    else
      return Container();
  }

  //CheckOption
  Widget checkOption(String name, chOpt) {
    return Column(
      children: [chOpt, Text(name)],
    );
  }

  Widget _resultContent() {
    double totalKiloBBajo = 0.0, totalKiloBAlto = 0.0, totalKiloBPp = 0.0;
    double totalPrecio = 0.0;
    double totalPrecioxBolsa = 0.0;
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
      print('TOTAL PRECIO >>' + totalPrecioxBolsa.toString());
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
    }

    final bBaja = Card(
        child: mostrarDataBolsas('BOLSA BAJA', totalKiloBBajo.toString(),
            totalPrecio.toString(), totalPrecioxBolsa.toString()));
    final bAlta = Card(
        child: mostrarDataBolsas('BOLSA ALTA', totalKiloBAlto.toString(),
            totalPrecio.toString(), totalPrecioxBolsa.toString()));
    final bPp = Card(
        child: mostrarDataBolsas('BOLSA PP', totalKiloBPp.toString(),
            totalPrecio.toString(), totalPrecioxBolsa.toString()));

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
    } else {
      return Container();
    }
  }

  Widget valueItem(String d1, String v1) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(d1), Text(v1)],
    );
  }

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
}
