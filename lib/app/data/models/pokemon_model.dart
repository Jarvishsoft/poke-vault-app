import 'package:poke_vault/app/packages/packages.dart';

class PokemonModel extends Pokemon {
  PokemonModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.types,
    super.abilities,
    super.height,
    super.weight,
    super.stats,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    // basic list endpoint to returns name and urls
    if (!json.containsKey('id') && json.containsKey('url')) {
      final url = json['url'] as String;
      final idStr = url.split('/').reversed.where((e) => e.isNotEmpty).first;
      final id = int.tryParse(idStr) ?? 0;
      return PokemonModel(
        id: id,
        name: json['name'] ?? '',
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
        types: [],
      );
    }

    // detail endpoint to returns full object
    return PokemonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl:
          json['sprites']?['other']?['official-artwork']?['front_default'] ??
          json['sprites']?['front_default'] ??
          '',
      types:
          (json['types'] as List?)
              ?.map((t) => t['type']['name'] as String)
              .toList() ??
          [],
      abilities:
          (json['abilities'] as List?)
              ?.map((a) => a['ability']['name'] as String)
              .toList() ??
          [],
      height: json['height'],
      weight: json['weight'],
      stats:
          (json['stats'] as List?)
              ?.map(
                (s) => PokemonStat(
                  name: s['stat']['name'] as String,
                  baseStat: s['base_stat'] as int,
                ),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'types': types,
      'abilities': abilities,
      'height': height,
      'weight': weight,
    };
  }
}
