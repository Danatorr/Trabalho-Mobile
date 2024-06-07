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
      avaliacao DOUBLE,
      descricao TEXT,
      imageURL TEXT
    )
    """;

    static Future<Database> getDataBase() async {
        final dbPath = await getDatabasesPath();
        final String path = join(dbPath, dbName);

        return openDatabase(path, onCreate: (db, version) {
            db.execute(createTbFilmes);
            db.insert(tableName, {
                "id": 1,
                "nome": "Dragon Ball Super: Broly",
                "ano": 2018,
                "tempoMin": 100,
                "generos": "Fantasia, Aventura, Anime",
                "faixa_etaria": 10,
                "avaliacao": 4.0,
                "descricao": "Luta de Gogeta vs Broly",
                "imageURL": "https://upload.wikimedia.org/wikipedia/pt/thumb/a/a1/Doragon_b%C3%B4ru_ch%C3%B4_Buror%C3%AE.jpg/243px-Doragon_b%C3%B4ru_ch%C3%B4_Buror%C3%AE.jpg",
            });
        },
        //onOpen: (db) => {
        //  db.delete(tableName)
        //},
        version: 1);
    }
}
