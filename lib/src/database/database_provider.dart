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

    final path = join(documentsDirectory.path, 'taytaPostV1.db');

    Future _onConfigure(Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }

    return await openDatabase(path, version: 1, onOpen: (db) {}, onConfigure: _onConfigure, onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Tienda ('
          ' idTienda TEXT  PRIMARY KEY,'
          ' tienda TEXT'
          ')');

      await db.execute('CREATE TABLE Locacion ('
          ' idLocacion TEXT  PRIMARY KEY,'
          ' nombre TEXT ,'
          ' idTienda TEXT'
          ')');
      await db.execute('CREATE TABLE Mesas ('
          ' idMesa TEXT  PRIMARY KEY,'
          ' idComanda TEXT ,'
          ' cantidadPersonas TEXT ,'
          ' horaIngreso TEXT ,'
          ' mesa TEXT ,'
          ' total TEXT ,'
          ' estado TEXT ,'
          ' paraLlevar TEXT ,'
          ' idUsuario TEXT ,'
          ' codigoUsuario TEXT ,'
          ' nombreCompleto TEXT ,'
          ' locacionId TEXT'
          ')');

      await db.execute('CREATE TABLE Familias ('
          ' idFamiliaLocal TEXT  PRIMARY KEY,'
          ' idFamilia TEXT ,'
          ' nombre TEXT ,'
          ' idLocacion TEXT ,'
          ' color TEXT'
          ')');
      await db.execute('CREATE TABLE Productos ('
          ' idProductoLocal TEXT  PRIMARY KEY,'
          ' idProducto TEXT ,'
          ' nombreProducto TEXT ,'
          ' precioVenta TEXT ,'
          ' precioLlevar TEXT ,' 
          ' idFamilia TEXT ,'
          ' idLocacion TEXT ,'
          ' saldo TEXT'
          ')');

           await db.execute('CREATE TABLE CarritoMesa ('
          ' idCarrito INTEGER PRIMARY KEY AUTOINCREMENT,'
          ' idComandaDetalle TEXT ,'
          ' idProducto TEXT ,'
          ' nombreProducto TEXT ,'
          ' precioVenta TEXT ,'
          ' cantidad TEXT ,'
          ' observacion TEXT ,'
          ' paraLLevar TEXT ,' //1 = si es true x 0 = si es false
          ' nroCuenta TEXT ,'
          ' idMesa TEXT ,'
          ' nombreMesa TEXT ,'
          ' idLocacion TEXT ,'
          ' estado TEXT ,'//1 = si ya esta en la comando <> 2 = si solo esta en bd interna
          ' productoDisgregacion TEXT' //1 = si es disgregacion <> 0 = si es nuevo
          ')');


           await db.execute('CREATE TABLE PedidoUser ('
          ' idPedido TEXT  PRIMARY KEY,'
          ' mesaId TEXT ,'
          ' cantidadPersonas TEXT ,'
          ' horaIngreso TEXT ,'
          ' dia TEXT ,'
          ' mesa TEXT ,'
          ' total TEXT ,'
          ' estado TEXT ,'
          ' paraLlevar TEXT ,'
          ' idUsuario TEXT ,'
          ' codigoUsuario TEXT'
          ')');
    });
  }
}
