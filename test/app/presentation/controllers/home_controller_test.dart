import 'package:flutter_test/flutter_test.dart';
import 'package:poke_vault/app/packages/packages.dart';

class MockGetPokemonsUseCase implements GetPokemonsUseCase {
  @override
  Future<List<Pokemon>> execute({int offset = 0, int limit = 20}) async {
    return [
      Pokemon(id: 1, name: 'bulbasaur', imageUrl: 'url1', types: ['grass']),
      Pokemon(id: 2, name: 'ivysaur', imageUrl: 'url2', types: ['grass']),
      Pokemon(id: 4, name: 'charmander', imageUrl: 'url3', types: ['fire']),
    ];
  }

  @override
  PokemonRepository get repository => throw UnimplementedError();
}

void main() {
  late HomeController controller;
  late MockGetPokemonsUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetPokemonsUseCase();
    controller = HomeController(getPokemonsUseCase: mockUseCase);
  });

  test('fetchPokemons updates state correctly', () async {
    expect(controller.isLoading.value, true);

    await controller.fetchPokemons();

    expect(controller.isLoading.value, false);
    expect(controller.pokemons.length, 3);
  });

  test('search filter works correctly', () async {
    await controller.fetchPokemons();
    expect(controller.filteredPokemons.length, 3);

    controller.updateSearchQuery('char');
    expect(controller.filteredPokemons.length, 1);
    expect(controller.filteredPokemons.first.name, 'charmander');

    controller.updateSearchQuery('saur');
    expect(controller.filteredPokemons.length, 2);
  });
}
