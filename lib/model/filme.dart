class Filme {
	late int? id;
	late String nome;
	late int? ano;
	late int tempoMin;
	late String generos;
	late int faixa_etaria;
	late double avaliacao;
	late String? descricao;
	late String? imageURL;

	Filme(this.nome, this.tempoMin, this.generos, {
		this.id, this.ano, this.faixa_etaria = 0, this.avaliacao = 0, this.descricao, this.imageURL});

	Filme.fromMap(Map<String, Object?> ct) {
		id = ct["id"] as int?;
		nome = ct["nome"] as String;
		ano = ct["ano"] as int?;
		tempoMin = ct["tempoMin"] as int;
		generos = ct["generos"] as String;
		faixa_etaria = ct["faixa_etaria"] != null ? ct["faixa_etaria"] as int : 0;
		avaliacao = ct["avaliacao"] != null ? ct["avaliacao"] as double : 0;
		descricao = ct["descricao"] as String?;
		imageURL = ct["imageURL"] as String?;
	}

	Map<String, Object?> getMap() => {
		"id": id,
		"nome": nome,
		"ano": ano,
		"tempoMin": tempoMin,
		"generos": generos,
		"faixa_etaria": faixa_etaria,
		"avaliacao": avaliacao,
		"descricao": descricao,
		"imageURL": imageURL
	};

	int? get getId => id;
	String get getNome => nome;
	int? get getAno => ano;
	int get getTempoMin => tempoMin;
	String get getGeneros => generos;
	int get getFaixaEtaria => faixa_etaria;
	double get getAvaliacao => avaliacao;
	String? get getDescricao => descricao;
	String? get getImageURL => imageURL;
}
