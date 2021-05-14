import 'package:mongo_dart/mongo_dart.dart';

import '../constants/database.dart' as dc;

class DB {
  static Db _db;

  static Future<void> open() async {
    _db ??= Db(dc.DB_PATH);
    await _db.open();
    print('open database');
  }

  static Future<void> close() async {
    await _db.close();
    _db = null;
  }

/// ALL DB Collections
  static Future<DbCollection> get todoCollection async {
    //await DB.open();
    return _db.collection('todo');
  }

}