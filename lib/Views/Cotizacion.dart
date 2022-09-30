import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plasticz/Provider/DBProvider.dart';
import 'package:plasticz/Utils/Constantes.dart';
import 'package:plasticz/Utils/Opciones.dart';
import 'package:plasticz/Utils/Operaciones.dart';

class CotizacionView extends StatefulWidget {
  @override
  _CotizacionViewState createState() => _CotizacionViewState();
}

class _CotizacionViewState extends State<CotizacionView> {
  void bloque() {
    SystemChrome.setPreferredOrientations([
      /**PARA MANTENER VERTICAL */
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  }

  Opciones listaOpciones = new Opciones();
  Operaciones operacion = new Operaciones();
  bool bolsa = false, bobina = false, x;
  String nombre = '';
  double ptotal = 0;

  @override
  Widget build(BuildContext context) {
    bloque();
    final productos = DBProvider.db.getAllProduct();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cotización'),
        leading: IconButton(
          icon: Icon(Icons.delete_sweep_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.playlist_add_check),
            onPressed: () {
              setState(() {});
              if (x) {
                Navigator.pushNamed(context, '/condicion');
              } else {
                final snackBar = SnackBar(
                  content: Text('Debe insertar almenos un producto.!'),
                  duration: Duration(milliseconds: 1000),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          )
        ],
        // actions: [_menuOption()],
      ),
      //TODO: MOSTRAR VALORES REGISTRADOS
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.only(bottom: 6),
            child: _items(),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Icon(
          Icons.add,
        ),
        onPressed: () async {
          await Navigator.pushNamed(context, '/insertarProducto');
          setState(() {});
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        child: Material(
          // child: SizedBox(height: 80),
          child: Container(height: 60.0, child: Center(child: _itemTotal())),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
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

  void _borrarTablas() async {
    await DBProvider.db.borrarTodoProducto();
    await DBProvider.db.borrarTodoCliente();
    await Navigator.popAndPushNamed(context, '/');
  }

  Widget _items() {
    return FutureBuilder(
      future: DBProvider.db.getAllProduct(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final resp = snapshot.data;
          if (resp.isEmpty) {
            x = false;
            return Center(child: Text('Inserte nuevo item....'));
          } else {
            x = true;

            return ListView.builder(
              itemCount: resp.length,
              itemBuilder: (_, i) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direccion) {
                    setState(() {
                      DBProvider.db.borrarProducto(resp[i]);
                    });
                  },
                  child: Column(
                    children: [
                      Card(
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
                                  _detailsItem(
                                      'Cantidad', '${resp[i].cantidad}'),
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
                    ],
                  ),
                );
              },
            );
          }
        } else {
          x = false;
          return Center(
            child: Text('Insterte nuevos items.'),
          );
        }
      },
    );
  }

  Widget _itemTotal() {
    return FutureBuilder(
      future: DBProvider.db.getAllProduct(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final resp = snapshot.data;
          if (resp.isNotEmpty) {
            ptotal = 0;
            for (var item in resp) {
              ptotal += item.precioTotal;
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  '${ptotal.toStringAsFixed(2)} Bs.',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  '0 Bs.',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            );
          }
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total ',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '0 Bs.',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ],
          );
        }
      },
    );
  }
}
