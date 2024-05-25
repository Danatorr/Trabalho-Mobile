// ignore_for_file: empty_constructor_bodies, non_constant_identifier_names

class Filme {
	
	late int? id;
	late String nome;
	late int tempoMin;
	late String generos;
	late int avaliacao;
	late String? imageURL;

	Filme(this.nome, this.tempoMin, this.generos, {this.id, this.avaliacao = 0, this.imageURL});

	Filme.fromMap(Map<String, Object?> ct) {
		id = ct["id"] as int?;
		nome = ct["nome"] as String;
		tempoMin = ct["tempoMin"] as int;
		generos = ct["generos"] as String;
		avaliacao = ct["avaliacao"] as int;
		imageURL = ct["imageURL"] as String?;
	}

  Map<String, Object?> getMap() => {
    "id": id,
    "nome": nome,
    "tempoMin": tempoMin,
    "generos": generos,
    "avaliacao": avaliacao,
    "imageURL": imageURL
  };

}