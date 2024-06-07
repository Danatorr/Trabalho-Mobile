import 'package:sqflite/sqflite.dart';
import 'package:trabalho_mobile/database/connection.dart';
import 'package:trabalho_mobile/model/filme.dart';

class FilmeDAO {
  Future<Filme?> find(int? id) async {
    if (id == null || id < 1) return null;

    Filme? filme;
    Database con = await Connection.getDataBase();

    await con.query(
      Connection.tableName,
      where: "id = ?",
      whereArgs: [id],
    ).then((queryList) => filme = queryList.isNotEmpty ? Filme.fromMap(queryList[0]) : null);

    return filme;
  }

  Future<List<Filme>> findAll() async {
    Database con = await Connection.getDataBase();
    List<Filme> filmes = [];

    await con.query(Connection.tableName).then((queryList) => queryList.forEach((filme) => filmes.add(Filme.fromMap(filme))));

    return filmes;
  }

  Future<int?> save(Filme filme) async {
    if (filme.nome.isEmpty || filme.generos.isEmpty || filme.tempoMin == 0) return null;

    Database con = await Connection.getDataBase();
    Map<String, dynamic> filmeMap = filme.getMap();

    if (await find(filme.id) == null) {
      return await con.insert(Connection.tableName, filmeMap);
    } else {
      return await con.update(Connection.tableName, filmeMap, where: "id = ?", whereArgs: [filme.id]);
    }
  }

  Future<void> delete(int? id) async {
    if (id == null) return;

    Database con = await Connection.getDataBase();
    await con.delete(
      Connection.tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
