import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_dex_v2/bloc/pokemon_event.dart';
import 'package:poke_dex_v2/bloc/pokemon_state.dart';
import 'package:poke_dex_v2/data/pokemon_repository.dart';

import '../data/pokemon_page_response.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRepository = PokemonRepository();
  List<PokemonListing> _pokemonListings = [];
  PokemonBloc() : super(PokemonInitial()) {
    on(mapEventToState);
  }

  void mapEventToState(
      PokemonEvent event, Emitter<PokemonState> emitter) async {
    if (event is PokemonPageRequest) {
      if (_pokemonListings.isEmpty) {
        emit(PokemonLoadInProgress());
      }
      try {
        final pokemonResponse =
            await _pokemonRepository.getPokemonPage(event.page);
        _pokemonListings += pokemonResponse.pokemonListings;
        emit(PokemonPageLoadSuccess(
            pokemonListing: _pokemonListings,
            canLoadNextPage: pokemonResponse.canLoadNextPage));
      } catch (e) {
        emit(PokemonPageLoadFailed(e.toString()));
      }
    }
  }
}
