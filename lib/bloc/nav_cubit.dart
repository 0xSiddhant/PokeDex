import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_dex_v2/bloc/pokemon_details_cubit.dart';

class NavCubit extends Cubit<String?> {
  PokemonDetailsCubit pokemonDetailsCubit;
  NavCubit({required this.pokemonDetailsCubit}) : super(null);

  void showPokemonDetails(String pokemonId) {
    pokemonDetailsCubit.getPokemonDetails(pokemonId);
    emit(pokemonId);
  }

  void popToPokedex() {
    emit(null);
    pokemonDetailsCubit.clearPokemonDetails();
  }
}
