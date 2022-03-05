import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_dex_v2/bloc/pokemon_bloc.dart';
import 'package:poke_dex_v2/bloc/pokemon_event.dart';
import 'package:poke_dex_v2/bloc/pokemon_state.dart';
import '../bloc/nav_cubit.dart';

class PokemonDexView extends StatefulWidget {
  @override
  _PokemonDexViewState createState() => _PokemonDexViewState();
}

class _PokemonDexViewState extends State<PokemonDexView> {
  int _pageCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(builder: ((context, state) {
        if (state is PokemonLoadInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PokemonPageLoadFailed) {
          return Center(
            child: Text(state.message ?? ""),
          );
        } else if (state is PokemonPageLoadSuccess) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.maxScrollExtent) {
                _pageCount += 1;
                BlocProvider.of<PokemonBloc>(context)
                  ..add(PokemonPageRequest(page: _pageCount));
              }
              return true;
            },
            child: GridView.builder(
                dragStartBehavior: DragStartBehavior.down,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: state.pokemonListing.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => BlocProvider.of<NavCubit>(context)
                        .showPokemonDetails(state.pokemonListing[index].id),
                    child: Card(
                      child: GridTile(
                          child: Column(
                        children: [
                          Image.network(state.pokemonListing[index].imageUrl,
                              fit: BoxFit.cover),
                          Expanded(
                              child: Text(
                            state.pokemonListing[index].name,
                            textAlign: TextAlign.center,
                          )),
                        ],
                      )),
                    ),
                  );
                }),
          );
        } else {
          return Container();
        }
      })),
    );
  }
}
