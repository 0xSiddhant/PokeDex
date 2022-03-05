abstract class PokemonEvent {}

class PokemonPageRequest extends PokemonEvent {
  final int page;

  PokemonPageRequest({required this.page});
}
