import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokedex/Pokemon.dart';
import 'package:pokedex/pokemonDetails.dart';

void main() =>
    runApp(MaterialApp(
      title: "Poke Dex",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    // print(res.bodyBytes);
    // print(res.body);
    var decodeJSON = jsonDecode(res.body);
    // print(decodeJSON);
    pokeHub = PokeHub.fromJson(decodeJSON);
    setState(() {
      // call when you need to perform some data changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
        backgroundColor: Colors.cyan,
      ),
      body: pokeHub == null
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GridView.count(
        crossAxisCount: 2,
        children: pokeHub.pokemon
            .map((poke) =>
            Padding(
                padding: EdgeInsets.all(2),
                child: InkWell(
                  // provide splash effect or ink effect
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) =>
                        PokeDetail(
                          pokemon: poke,
                        )));
                  },
                  child: Hero(
                    tag: poke.img,
                    child: Card(
                      elevation: 3.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(poke.img))),
                          ),
                          Text(
                            poke.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          )
                        ],
                      ),
                    ),
                  ),
                )))
            .toList(),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyanAccent,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
