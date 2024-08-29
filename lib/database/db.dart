import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class Db {
  Database? db;

  Future<void> open() async {
    try {
      sqfliteFfiInit();
      var databasePath = await databaseFactoryFfi.getDatabasesPath();
      String path = join(databasePath, 'drinksDB.db');
      DatabaseFactory databaseFactory = databaseFactoryFfi;

      db = await databaseFactory.openDatabase(path, options: OpenDatabaseOptions(
          version: 1,
          onCreate: (Database db, int index) async {
            await db.execute(
                '''
            CREATE TABLE drinks (
              id integer primary key autoIncrement,
              name varchar(255) not null,
              image varchar(255) not null,
              volume varchar(255) not null,
              price double not null
            )
            '''
            );
          }
      ));
      print("Database opened successfully!");
    } catch (e) {
      print("Error opening database: $e");
    }
  }
}
