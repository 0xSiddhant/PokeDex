/*

count: 1126,
next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
previous: null,
results: [
{
name: "bulbasaur",
url: "https://pokeapi.co/api/v2/pokemon/1/"
},
{
name: "ivysaur",
url: "https://pokeapi.co/api/v2/pokemon/2/"
},
]
*/

class PokemonListing {
  final String id;
  final String name;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  PokemonListing({required this.id, required this.name});

  factory PokemonListing.fromJSON(Map<String, dynamic> json) {
    final name = json['name'];
    var url = json['url'] as String;
    if (url[url.length - 1] == '/') {
      url = url.replaceRange(url.length - 1, url.length, '');
    }
    final id = url.split('/').last as String;

    return PokemonListing(id: id, name: name);
  }
}

class PokemonPageResponse {
  final List<PokemonListing> pokemonListings;
  final bool canLoadNextPage;

  PokemonPageResponse(
      {required this.pokemonListings, required this.canLoadNextPage});

  factory PokemonPageResponse.fromJSON(Map<String, dynamic> json) {
    final canLoadNextPage = json['next'] != null;
    final pokemonListing = (json['results'] as List)
        .map((pokemon) => PokemonListing.fromJSON(pokemon))
        .toList();

    return PokemonPageResponse(
        pokemonListings: pokemonListing, canLoadNextPage: canLoadNextPage);
  }
}
