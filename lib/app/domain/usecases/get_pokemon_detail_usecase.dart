import 'package:poke_vault/app/packages/packages.dart';

class GetPokemonDetailUseCase {
  final PokemonRepository repository;

  GetPokemonDetailUseCase(this.repository);

  Future<Pokemon> execute(String nameOrId) {
    return repository.getPokemonDetail(nameOrId);
  }
}
