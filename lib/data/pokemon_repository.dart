import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poke_dex_v2/data/pokemon_page_response.dart';

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

    final respose = await client.get(uri);
    final json = jsonDecode(respose.body);

    return PokemonPageResponse.fromJSON(json);
  }
}
