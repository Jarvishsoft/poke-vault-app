class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String>? abilities;
  final int? height;
  final int? weight;
  final List<PokemonStat>? stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    this.abilities,
    this.height,
    this.weight,
    this.stats,
  });
}

class PokemonStat {
  final String name;
  final int baseStat;

  PokemonStat({required this.name, required this.baseStat});
}
