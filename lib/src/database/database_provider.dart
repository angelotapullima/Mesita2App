import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static Database _database;
  static final DatabaseProvider db = DatabaseProvider._();

  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'messitasv3.db');
    Future _onConfigure(Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }

    return await openDatabase(path, version: 1, onOpen: (db) {}, onConfigure: _onConfigure, onCreate: (Database db, int version) async {
      await db.execute(' CREATE TABLE Mesas('
          ' idMesa TEXT PRIMARY KEY,'
          ' idNegocio TEXT,'
          ' mesaNombre TEXT,'
          ' mesaCapacidad TEXT,'
          ' mesaEstado TEXT'
          ')');

      await db.execute(' CREATE TABLE Categorias('
          ' idCategoria TEXT PRIMARY KEY,'
          ' categoriaNombre TEXT,'
          ' categoriaEstado TEXT'
          ')');

      await db.execute(' CREATE TABLE Lineas('
          ' idLinea TEXT PRIMARY KEY,'
          ' idNegocio TEXT,'
          ' lineaNombre TEXT,'
          ' lineaEstado TEXT'
          ')');

      await db.execute(' CREATE TABLE ProductosLinea('
          ' idProducto TEXT PRIMARY KEY,'
          ' idLinea TEXT,'
          ' productoNombre TEXT,'
          ' productoDescripcion TEXT,'
          ' productoFoto TEXT,'
          ' productoPrecio TEXT,'
          ' productoEstado TEXT'
          ')');
    });
  }
}
