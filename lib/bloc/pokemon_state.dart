import 'package:poke_dex_v2/data/pokemon_page_response.dart';

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoadInProgress extends PokemonState {}

class PokemonPaginationLoadInProgress extends PokemonState {}

class PokemonPageLoadSuccess extends PokemonState {
  final List<PokemonListing> pokemonListing;
  final bool canLoadNextPage;

  PokemonPageLoadSuccess(
      {required this.pokemonListing, required this.canLoadNextPage});
}

class PokemonPageLoadFailed extends PokemonState {
  String? _message;

  PokemonPageLoadFailed(this._message);

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }
}
