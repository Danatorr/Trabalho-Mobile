import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({super.key});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  // Initial rating
  double _rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Image.network(
                "https://i.scdn.co/image/ab67616d0000b273787dd8343545025252cf3f22"),
            isThreeLine: true,
            title: Text("Teste Nome Filme"),
            subtitle: Text("Teste Descrição Filme"),
          ),
          // Add the RatingBar here
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
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
    );
  }
}
