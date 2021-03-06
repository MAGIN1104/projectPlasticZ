import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:plasticz/Models/CondicionPagoModel.dart';
import 'package:plasticz/Models/CondicionVentaModel.dart';
import 'package:plasticz/Models/PersonModel.dart';
import 'package:plasticz/Models/ProductModel.dart';
export 'package:plasticz/Models/ProductModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get dbProducto async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ProductoDB.db');
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Producto('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'producto TEXT,'
          'tipoProducto TEXT,'
          'color TEXT,'
          'ancho DOUBLE(10000,8),'
          'largo DOUBLE(10000,8),'
          'espesor DOUBLE(10000,8),'
          'cantidad INTEGER,'
          'unidad DOUBLE(10000,8),'
          'tkilos DOUBLE(10000,8),'
          'precioUnitario DOUBLE(10000,8),'
          'precioRollo DOUBLE(10000,8),'
          'precioTotal DOUBLE(10000,8)'
          ')');
      await db.execute('CREATE TABLE Cliente('
          'nombre TEXT,'
          'ci TEXT,'
          'empresa TEXT,'
          'email TEXT,'
          'cel TEXT'
          ')');
      await db.execute('CREATE TABLE CPago('
          'tipoPago TEXT,'
          'banco TEXT,'
          'numCuenta TEXT,'
          'nombre TEXT,'
          'descripcion TEXT'
          ')');
      await db.execute('CREATE TABLE CVenta('
          'formaPago TEXT,'
          'lugarEntrega TEXT,'
          'tiempoEntrega TEXT'
          ')');
    });
  }

//Insertar CONDICION VENTA
  Future<int> insertarCVenta(CondicionVentaModel cventa) async {
    final db = await dbProducto;
    final resp = await db.insert('CVenta', cventa.toJson());
    return resp;
  }

  //Borrar CONDICION VENTA
  Future<int> borrarTodoCVenta() async {
    final db = await dbProducto;
    final resp = db.delete('CVenta');
    return resp;
  }

  //Insertar CONDICION PAGO
  Future<int> insertarCPago(CondicionPagoModel cpago) async {
    final db = await dbProducto;
    final resp = await db.insert('CPago', cpago.toJson());
    return resp;
  }

  //Borrar CONDICION PAGO
  Future<int> borrarTodoCPago() async {
    final db = await dbProducto;
    final resp = db.delete('CPago');
    return resp;
  }

  //Insertar Cliente
  Future<int> insertarCliente(PersonaModel cliente) async {
    final db = await dbProducto;
    final resp = await db.insert('Cliente', cliente.toJson());
    return resp;
  }

  //Borrar Clientes
  Future<int> borrarTodoCliente() async {
    final db = await dbProducto;
    final resp = db.delete('Cliente');
    return resp;
  }

  //Insertar Producto
  Future<int> insertarProducto(ProductModel productItem) async {
    final db = await dbProducto;
    final resp = await db.insert('Producto', productItem.toJson());
    return resp;
  }

  //Borrar Producto
  Future<int> borrarProducto(ProductModel producto) async {
    final db = await dbProducto;
    final resp =
        await db.delete('Producto', where: 'id=?', whereArgs: [producto.id]);
    return resp;
  }

  //Borrar Tabla
  Future<int> borrarTodoProducto() async {
    final db = await dbProducto;
    final resp = db.delete('Producto');
    return resp;
  }

  //Obtener todos los Productos
  Future<List<ProductModel>> getAllProduct() async {
    final db = await dbProducto;
    final resp = await db.query('Producto');
    if (resp.isEmpty)
      return [];
    else
      return resp.map((json) => ProductModel.fromJson(json)).toList();
  }

  //Obtener cliente
  Future<List<PersonaModel>> getCliente() async {
    final db = await dbProducto;
    final resp = await db.query('Cliente');
    if (resp.isEmpty)
      return [];
    else
      return resp.map((json) => PersonaModel.fromJson(json)).toList();
  }

  //Obtener CVentas
  Future<List<CondicionVentaModel>> getCVentas() async {
    final db = await dbProducto;
    final resp = await db.query('CVenta');
    if (resp.isEmpty)
      return [];
    else
      return resp.map((json) => CondicionVentaModel.fromJson(json)).toList();
  }

  //Obtener CVentas
  Future<List<CondicionPagoModel>> getCPago() async {
    final db = await dbProducto;
    final resp = await db.query('CPago');
    if (resp.isEmpty)
      return [];
    else
      return resp.map((json) => CondicionPagoModel.fromJson(json)).toList();
  }
}
