import 'package:poke_vault/app/packages/packages.dart';

class GetPokemonsUseCase {
  final PokemonRepository repository;

  GetPokemonsUseCase(this.repository);

  Future<List<Pokemon>> execute({int offset = 0, int limit = 20}) {
    return repository.getPokemons(offset: offset, limit: limit);
  }
}
