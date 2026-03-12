import 'package:poke_vault/app/packages/packages.dart';
import 'package:dio/dio.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final Dio dio;
  final String baseUrl = 'https://pokeapi.co/api/v2';
  static const String _pokeBox = 'pokemons_box';
  static const String _detailBox = 'pokemon_details_box';

  PokemonRepositoryImpl({Dio? dioClient}) : dio = dioClient ?? Dio();

  // get pokemons list
  @override
  Future<List<Pokemon>> getPokemons({int offset = 0, int limit = 20}) async {
    try {
      final response = await dio.get(
        '$baseUrl/pokemon',
        queryParameters: {'offset': offset, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final List results = response.data['results'];
        final pokemons = results
            .map((json) => PokemonModel.fromJson(json))
            .toList();

        // cache data offline (hive)
        final box = await Hive.openBox(_pokeBox);
        await box.put('offset_$offset', results);

        return pokemons;
      } else {
        throw Exception('Failed to load pokemons from servers');
      }
    } catch (e) {
      // try to load from cache
      try {
        final box = await Hive.openBox(_pokeBox);
        final cachedData = box.get('offset_$offset');
        if (cachedData != null) {
          final List results = List<dynamic>.from(cachedData as List);
          return results
              .map(
                (json) => PokemonModel.fromJson(
                  Map<String, dynamic>.from(json as Map),
                ),
              )
              .toList();
        }
      } catch (cacheError) {
        debugPrint(cacheError.toString());
      }
      throw Exception('Error Fetching Pokemons Data: $e');
    }
  }

  // get details pokemons
  @override
  Future<Pokemon> getPokemonDetail(String nameOrId) async {
    try {
      final response = await dio.get('$baseUrl/pokemon/$nameOrId');

      if (response.statusCode == 200) {
        final pokemon = PokemonModel.fromJson(response.data);

        // cache data
        final box = await Hive.openBox(_detailBox);
        await box.put(nameOrId, pokemon.toJson());

        return pokemon;
      } else {
        throw Exception('Failed to load pokemon detail from servers');
      }
    } catch (e) {
      try {
        final box = await Hive.openBox(_detailBox);
        final cachedData = box.get(nameOrId);
        if (cachedData != null) {
          return PokemonModel.fromJson(
            Map<String, dynamic>.from(cachedData as Map),
          );
        }
      } catch (cacheError) {
        debugPrint(cacheError.toString());
      }
      throw Exception('Error Fetching Pokemon Detail\'s Data: $e');
    }
  }
}
