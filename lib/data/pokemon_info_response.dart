class PokemonInfoResponse {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;

  PokemonInfoResponse(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.types,
      required this.height,
      required this.weight});

  factory PokemonInfoResponse.fromJSON(Map<String, dynamic> json) {
    final types = (json['types'] as List)
        .map((typeJSON) => typeJSON['type']['name'] as String)
        .toList();
    return PokemonInfoResponse(
        id: json['id'],
        name: json['name'],
        imageUrl: json['sprites']['front_default'] ??
            json['sprites']['other']['official-artwork']['front_default'],
        types: types,
        height: json['height'],
        weight: json['weight']);
  }
}
