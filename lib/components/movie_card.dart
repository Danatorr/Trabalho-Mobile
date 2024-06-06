// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:trabalho_mobile/DAO/filmeDAO.dart';
import 'package:trabalho_mobile/screens/add_screen.dart';
import '../model/filme.dart';

class MovieCard extends StatefulWidget {
  final Filme filme;

  const MovieCard({super.key, required this.filme});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  double _rating = 3.0;

  @override
  Widget build(BuildContext context) {
    _rating = widget.filme.avaliacao;

    return Dismissible(
      onDismissed: (direction) {
        FilmeDAO().delete(widget.filme.id);
      },
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(Icons.delete, color: Colors.white),
            )
          ],
        ),
      ),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Image.network(
                widget.filme.imageURL ?? "",
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Image.network(
                    "https://st4.depositphotos.com/14953852/24787/v/380/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg", 
                  );
                }
              ),
              isThreeLine: true,
              title: Text(widget.filme.nome),
              subtitle: Text(widget.filme.descricao ?? "Sem descrição"),
              onTap: () => _mostrarOpcoes(context),
            ),
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
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarOpcoes(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Exibir Dados'),
              onTap: () {
                Navigator.pop(context);
                // Navegar para a tela de exibição de dados
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExibirDadosPage(filme: widget.filme),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Alterar'),
              onTap: () async {
                Navigator.pop(context);

                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddScreen(filme: widget.filme)),
                );

                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}

class ExibirDadosPage extends StatelessWidget {
  final Filme filme;

  ExibirDadosPage({required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Filme'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Text('Título: ${filme.nome}', style: TextStyle(fontSize: 20)),
            Image.network(
              filme.imageURL ?? "",
              fit: BoxFit.contain,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Image.network("https://st4.depositphotos.com/14953852/24787/v/380/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg", fit: BoxFit.cover, width: 150);
              }
            ),
            SizedBox(height: 10),
            Text(filme.generos, style: TextStyle(fontSize: 16)),
            
            SizedBox(height: 10),
            Text('${filme.ano}', style: TextStyle(fontSize: 16)),
            
            SizedBox(height: 10),
            Text('Duração: ${filme.tempoMin}', style: TextStyle(fontSize: 16)),
            
            SizedBox(height: 10),
            Text('Restrição: ${filme.faixa_etaria}', style: TextStyle(fontSize: 16)),
            
            RatingBar.builder(
              initialRating: filme.avaliacao,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),

            SizedBox(height: 10),
            Text('Descrição: ${filme.descricao ?? "Sem descrição"}', style: TextStyle(fontSize: 16)),
            // Adicione outros detalhes do filme aqui
          ],
        ),
      ),
    );
  }
}
