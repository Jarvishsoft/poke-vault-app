import 'package:poke_vault/app/packages/packages.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons({int offset = 0, int limit = 20});
  Future<Pokemon> getPokemonDetail(String nameOrId);
}
