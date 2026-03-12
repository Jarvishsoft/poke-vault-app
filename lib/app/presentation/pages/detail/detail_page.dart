import 'package:poke_vault/app/packages/packages.dart';

class DetailPage extends GetView<DetailController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final pokemon = controller.pokemon.value;
      // bg color pokemon type
      final bgColor = pokemon != null && pokemon.types.isNotEmpty
          ? controller.getTypeColor(pokemon.types.first)
          : white;

      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Text(
            pokemon?.name.capitalizeFirst ?? '',
            style: detailAppBarStyle,
          ),
          foregroundColor: white,
          backgroundColor: transparent,
          iconTheme: const IconThemeData(color: white),
        ),
        body: _buildBody(pokemon),
      );
    });
  }

  Widget _buildBody(Pokemon? pokemon) {
    if (controller.isLoading.value) {
      return DetailShimmer();
    }

    // error handling
    if (controller.error.value.isNotEmpty) {
      return Center(
        child: Text(
          'Error Data: \n${controller.error.value}',
          style: const TextStyle(color: white),
        ),
      );
    }

    // no pokemon data
    if (pokemon == null) {
      return const Center(
        child: Text('No Pokemon\'s Data Bruhh!', style: subtitleStyle),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: Center(
            child: Hero(
              tag: pokemon.name,
              child: CachedNetworkImage(
                imageUrl: pokemon.imageUrl,
                height: 250,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 80, color: red),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    pokemon.name.capitalizeFirst ?? pokemon.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: pokemon.types
                        .map(
                          (type) => Chip(
                            label: Text(
                              type.capitalizeFirst ?? type,
                              style: const TextStyle(color: white),
                            ),
                            backgroundColor: controller.getTypeColor(type),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AttributeColumn(
                          label: 'Weight',
                          value:
                              '${((pokemon.weight ?? 0) / 10).toStringAsFixed(1)} kg',
                        ),
                        AttributeColumn(
                          label: 'Height',
                          value:
                              '${((pokemon.height ?? 0) / 10).toStringAsFixed(1)} m',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // abilities
                  if (pokemon.abilities != null &&
                      pokemon.abilities!.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Abilities',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: pokemon.abilities!
                              .map(
                                (ability) => Chip(
                                  label: Text(
                                    ability.capitalizeFirst ?? ability,
                                    style: detailTitleStyle,
                                  ),
                                  backgroundColor: greyAccent200,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // base stats
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Base Stats',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (pokemon.stats != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: pokemon.stats!
                            .map(
                              (stat) => StatRow(
                                name: stat.name,
                                value: stat.baseStat,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
