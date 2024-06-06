import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../DAO/filmeDAO.dart';
import '../model/filme.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController generoController = TextEditingController();
  final TextEditingController duracaoController = TextEditingController();
  final TextEditingController anoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  double _rating = 3.0;
  String dropdownValue = 'Livre';

  final FilmeDAO dao = FilmeDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Cadastrar Filmes",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              TextFormField(
                controller: urlController,
                decoration: InputDecoration(
                  hintText: "Url da Imagem",
                ),
              ),
              TextFormField(
                controller: tituloController,
                decoration: InputDecoration(
                  hintText: "Título",
                ),
              ),
              TextFormField(
                controller: generoController,
                decoration: InputDecoration(
                  hintText: "Gênero",
                ),
              ),
              Row(
                children: [
                  Text(
                    "Faixa Etária: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Livre', '10', '12', '14', '16', '18']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              TextFormField(
                controller: duracaoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Duração (Minutos)",
                ),
              ),
              Row(
                children: [
                  Text("Nota:"),
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  )
                ],
              ),
              TextFormField(
                controller: anoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Ano",
                ),
              ),
              TextFormField(
                controller: descricaoController,
                decoration: InputDecoration(
                  hintText: "Descrição",
                ),
                maxLines: 5,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
            if (_validateInputs()) {
              Filme filme_atual = Filme(
                tituloController.text,
                int.parse(duracaoController.text),
                generoController.text,
                ano: int.tryParse(anoController.text),
                faixa_etaria: _ConverterFaixaEtaria(dropdownValue),
                avaliacao: _rating,
                descricao: descricaoController.text,
                imageURL: urlController.text,
              );
              
              await dao.save(filme_atual);

              Navigator.pop(context);
            }
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        tooltip: 'Salvar',
        shape: CircleBorder(),
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (tituloController.text.isEmpty ||
        generoController.text.isEmpty ||
        duracaoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos obrigatórios')),
      );
      return false;
    }
    return true;
  }

  int _ConverterFaixaEtaria(String value) {
    switch (value) {
      case '10':
        return 10;
      case '12':
        return 12;
      case '14':
        return 14;
      case '16':
        return 16;
      case '18':
        return 18;
      default:
        return 0;
    }
  }
}
