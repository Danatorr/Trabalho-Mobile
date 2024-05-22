import 'package:flutter/material.dart';
import 'package:trabalho_mobile/components/movie_card.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MovieCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Theme.of(context).colorScheme.primary,
        tooltip: 'Increment',
        shape: CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
    ;
  }
}
