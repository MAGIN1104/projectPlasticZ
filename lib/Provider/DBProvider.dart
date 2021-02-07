import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:plasticz/Models/ModeloBobina.dart';
export 'package:plasticz/Models/ModeloBobina.dart';
import 'package:plasticz/Models/ModeloBolsa.dart';
export 'package:plasticz/Models/ModeloBolsa.dart';
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
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Bobinas('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'producto TEXT,'
          'tipoProducto TEXT,'
          'ancho DOUBLE(10000,8),'
          'espesor DOUBLE(10000,8),'
          'cantidad INTEGER,'
          'precio DOUBLE(10000,8),'
          'tkilosPorRollo DOUBLE(10000,8),'
          'precioTotal DOUBLE(10000,8),'
          'precioPorMetro DOUBLE(10000,8)'
          ')');
      await db.execute('CREATE TABLE Bolsas('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'producto TEXT,'
          'tipoProducto TEXT,'
          'ancho DOUBLE(10000,8),'
          'largo DOUBLE(10000,8),'
          'espesor DOUBLE(10000,8),'
          'cantidad INTEGER,'
          'precio DOUBLE(10000,8),'
          'tkilos DOUBLE(10000,8),'
          'precioTotal DOUBLE(10000,8),'
          'precioPorBolsa DOUBLE(10000,8)'
          ')');
    });
  }

  //Insertar Bolsa
  Future<int> insertBolsa(ModeloBolsa bolsa) async {
    final db = await dbProducto;
    final resp = await db.insert('Bolsas', bolsa.toJson());
    return resp;
  }

  //Insertar Bolsa
  Future<int> insertBobina(ModeloBobina bobina) async {
    final db = await dbProducto;
    final resp = await db.insert('Bobinas', bobina.toJson());
    return resp;
  }

  //Obtener Producto Bolsa
  Future<List<ModeloBolsa>> getBolsa() async {
    final db = await dbProducto;
    final resp = await db.query('Bolsas');
    if (resp.isEmpty)
      return [];
    else
      return resp.map((json) => ModeloBolsa.fromJson(json)).toList();
  }

  //Obtener Producto Bobina
  Future<List<ModeloBobina>> getBobina() async {
    final db = await dbProducto;
    final resp = await db.query('Bobinas');
    if (resp.isEmpty)
      return [];
    else
      return resp.map((json) => ModeloBobina.fromJson(json)).toList();
  }
}
