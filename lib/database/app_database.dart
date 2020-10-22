import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste/database/dao/treinos_dao.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'running.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(TreinoDAO.tableSQL);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete
  );
}
