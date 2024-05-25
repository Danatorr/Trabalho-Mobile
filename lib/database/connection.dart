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
				tempoMin INT,
				generos TEXT,
				avaliacao INT,
				imageURL TEXT
			)
		""";

    static Future<Database> getDataBase() async {
        final dbPath = await getDatabasesPath();
        final String path = join(dbPath, dbName);

        return openDatabase(path, onCreate: (db, version) {
            db.execute(createTbFilmes);
        }, version: 1
        // RESET
        //, onOpen: (db) {
        //  db.execute("drop table ${tableName}");
        //  db.execute(createTbFilmes);
        //}
        );
    }

}