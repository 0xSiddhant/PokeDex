import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:poke_dex_v2/data/pokemon_info_response.dart';
import 'package:poke_dex_v2/data/pokemon_page_response.dart';
import 'package:poke_dex_v2/data/pokemon_species_info.dart';

class PokemonRepository {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<PokemonPageResponse> getPokemonPage(int pageIndx) async {
    //pokemon?limit=100&offset=200

    final queryParameters = {
      'limit': '200',
      'offset': (pageIndx * 200).toString()
    };
    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);
    if (kDebugMode) {
      print(uri.toString());
    }
    final respose = await client.get(uri);
    final json = jsonDecode(respose.body);

    return PokemonPageResponse.fromJSON(json);
  }

  Future<PokemonInfoResponse> getPokemonInfo(String pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon/$pokemonId');
    if (kDebugMode) {
      print(uri.toString());
    }
    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);
      return PokemonInfoResponse.fromJSON(json);
    } catch (e) {
      return PokemonInfoResponse(
          id: 2,
          name: "name",
          imageUrl: "imageUrl",
          types: [],
          height: 1,
          weight: 2);
    }
  }

  Future<PokemonSpeciesInfoResponse?> getPokemonSpeciesInfo(
      String pokemonId) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon-species/$pokemonId');
    if (kDebugMode) {
      print(uri.toString());
    }
    try {
      final response = await client.get(uri);
      final json = jsonDecode(response.body);
      return PokemonSpeciesInfoResponse.fromJSON(json);
    } catch (e) {
      if (kDebugMode) {
        print("Error In ${uri.toString()} =>  ${e.toString()}");
      }
      return null;
    }
  }
}
