import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connection {
    static String dbName = "cinema.db";
    static String tableName = "filmes";

    static final String createTbFilmes =
    """
    CREATE TABLE $tableName(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      ano INT,
      tempoMin INT,
      generos TEXT,
      faixa_etaria INT,
      avaliacao INT,
      descricao TEXT,
      imageURL TEXT
    )
    """;

    static Future<Database> getDataBase() async {
        final dbPath = await getDatabasesPath();
        final String path = join(dbPath, dbName);

        return openDatabase(path, onCreate: (db, version) {
            db.execute(createTbFilmes);
        }, 
        //onOpen: (db) => {
        //  db.delete(tableName)
        //},
        version: 1);
    }
}
