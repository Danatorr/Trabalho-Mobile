import 'package:flutter/material.dart';
import 'package:trabalho_mobile/components/movie_card.dart';
import 'package:trabalho_mobile/screens/add_screen.dart';

import '../DAO/filmeDAO.dart';
import '../model/filme.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final FilmeDAO dao = FilmeDAO();
  List<Widget> movieCards = []; // Initialize an empty list to hold movie cards

  @override
  void initState() {
    super.initState();
    _fetchMovies(); // Fetch movies on initialization
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchMovies(); // Fetch movies on dependency change
  }

  Future<List<Filme>> _fetchMovies() async {
    try {
      List<Filme> db_filmes = await dao.findAll(); // Fetch movies from DAO

      for (Filme filme in db_filmes) {
        debugPrint("  - Title: ${filme.nome}"); // Access and print filme properties
        debugPrint("  - min: ${filme.getTempoMin}");
        debugPrint("  - ... (other properties)"); // Print other relevant properties
      }
      return db_filmes; // Return the fetched movies
    } catch (error) {
      // Handle errors during movie fetching
      print("Error fetching movies: $error");
      // You can display an error message to the user here
      return []; // Return an empty list on error (optional)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Filmes",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text("Equipe"),
                        content: const Text(
                            "Daniel de Araújo Torres\n José Gabriel Gouveia \n Kildere Maravilha \n Rafael Leão \n Vinícius Sobral de Lima"),
                        actions: [
                          ElevatedButton(
                            child: Text("Ok"),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          ),
                        ],
                      ));
            },
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            ),
            child: Icon(
              Icons.info_rounded,
              color: Colors.white,
            ),
          )
        ],
      ),
        body: FutureBuilder(
          future: _fetchMovies(), // Call _fetchMovies directly in the future
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Filme> filmes = snapshot.data as List<Filme>; // Cast data to List<Filme>
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: filmes.map((filme) => MovieCard(filme: filme)).toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("Error fetching movies: ${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        tooltip: 'Increment',
        shape: CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
