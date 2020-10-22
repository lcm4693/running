import 'package:sqflite/sqflite.dart';
import 'package:teste/database/app_database.dart';
import 'package:teste/model/treino.dart';

class TreinoDAO {
  static const String _tableName = 'treinos';
  static const String _id = 'id';
  static const String _time = 'time';
  static const String _data = 'data';

  static const String tableSQL = 'CREATE TABLE $_tableName '
      '($_id INTEGER PRIMARY KEY, '
      '$_time INTEGER,'
      '$_data DATETIME)';

  Future<int> save(Treino treino) async {
    final Database db = await getDatabase();
    Map<String, dynamic> treinoMap = _toMap(treino);
    return db.insert(_tableName, treinoMap);
  }

  Map<String, dynamic> _toMap(Treino treino) {
    final Map<String, dynamic> treinoMap = Map();
    // Já faz o auto incremento
    // contactMap['id'] = contact.id;
    treinoMap['$_time'] = treino.time;
    treinoMap['$_data'] = treino.data;
    return treinoMap;
  }

  Future<List<Treino>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Treino> treinos = _toList(result);
    return treinos;
  }

  List<Treino> _toList(List<Map<String, dynamic>> result) {
    final List<Treino> treinos = List();
    for (Map<String, dynamic> map in result) {
      final Treino treino = Treino(
        map['$_id'],
        map['$_data'],
        map['$_time'],
      );
      treinos.add(treino);
    }
    return treinos;
  }
}
