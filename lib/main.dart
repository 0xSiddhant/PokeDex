import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_dex_v2/widgets/app_navigator.dart';
import 'bloc/nav_cubit.dart';
import 'bloc/pokemon_bloc.dart';
import 'bloc/pokemon_details_cubit.dart';
import 'bloc/pokemon_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final pokemonDetailsCubit = PokemonDetailsCubit();
    return MaterialApp(
        title: 'Poki Dex',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.red, accentColor: Colors.redAccent)),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    PokemonBloc()..add(PokemonPageRequest(page: 0))),
            BlocProvider(
                create: (context) =>
                    NavCubit(pokemonDetailsCubit: pokemonDetailsCubit)),
            BlocProvider(create: ((context) => pokemonDetailsCubit))
          ],
          child: const AppNavigator(),
        ));
  }
}
