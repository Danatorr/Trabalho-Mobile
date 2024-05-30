import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Padding(
            padding: EdgeInsets.all(20.0),
            child: Icon(Icons.delete, color: Colors.white,),
          )],
        ),
      ),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Image.network(
                  "https://i.scdn.co/image/ab67616d0000b273787dd8343545025252cf3f22"),
              isThreeLine: true,
              title: Text(widget.filme.nome),
              subtitle: Text("teste descricao"),
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
}
