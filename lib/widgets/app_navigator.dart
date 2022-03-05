import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_dex_v2/bloc/nav_cubit.dart';
import 'package:poke_dex_v2/widgets/pokedex_view.dart';
import 'package:poke_dex_v2/widgets/pokemon_detail_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, String?>(builder: (context, pokemonId) {
      return Navigator(
        pages: [
          MaterialPage(child: PokemonDexView()),
          if (pokemonId != null) MaterialPage(child: PokemonDetailsView())
        ],
        onPopPage: (route, result) {
          BlocProvider.of<NavCubit>(context).popToPokedex();
          return route.didPop(result);
        },
      );
    });
  }
}
