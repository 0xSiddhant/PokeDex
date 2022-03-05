class PokemonSpeciesInfoResponse {
  final String description;

  PokemonSpeciesInfoResponse({required this.description});

  factory PokemonSpeciesInfoResponse.fromJSON(Map<String, dynamic> json) {
    return PokemonSpeciesInfoResponse(
        description: json['flavor_text_entries'][0]['flavor_text']);
  }
}
