import 'package:poke_vault/app/packages/packages.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Poké-Váult',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        foregroundColor: white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Obx(
              () => TextField(
                controller: controller.searchController,
                onChanged: controller.updateSearchQuery,
                decoration: InputDecoration(
                  hintText: 'Search Pokémon...',
                  filled: true,
                  fillColor: white,
                  prefixIcon: const Icon(Icons.search, color: black45),
                  suffixIcon: controller.searchQuery.value.isNotEmpty
                      ? IconButton(
                          onPressed: controller.clearSearch,
                          icon: Icon(Icons.close, color: black45, size: 26),
                        )
                      : const SizedBox.shrink(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsGeometry.only(right: 20),
            child: Icon(Icons.catching_pokemon_outlined, size: 30),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.pokemons.isEmpty) {
          return Center(child: ItemShimmer());
        }

        if (controller.error.value.isNotEmpty && controller.pokemons.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error to Load Data: \n${controller.error.value}',
                  textAlign: TextAlign.center,
                  style: errorStyle,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchPokemons,
                  child: const Text('Retry', style: detailTitleStyle),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshPokemons,
          // pagination scroll
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                controller.fetchPokemons();
                return true;
              }
              return false;
            },
            child: GridView.builder(
              controller: controller.scrollController,
              padding: const EdgeInsets.all(12),
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount:
                  controller.filteredPokemons.length +
                  (controller.isLoading.value ? 2 : 0),
              itemBuilder: (context, index) {
                if (index >= controller.filteredPokemons.length) {
                  return ItemShimmer();
                }

                final pokemon = controller.filteredPokemons[index];
                return GestureDetector(
                  onTap: () =>
                      Get.toNamed(Routes.detail, arguments: pokemon.name),
                  child: Card(
                    elevation: 2.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            // handle cache image
                            child: CachedNetworkImage(
                              imageUrl: pokemon.imageUrl,
                              placeholder: (context, url) => ImageShimmer(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            children: [
                              Text(
                                pokemon.name.capitalizeFirst ?? pokemon.name,
                                textAlign: TextAlign.center,
                                style: titleStyle,
                              ),
                              Text(
                                'ID: ${pokemon.id}',
                                textAlign: TextAlign.center,
                                style: titleStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
      floatingActionButton: Obx(
        () => controller.showFab.value
            ? FloatingActionButton(
                onPressed: controller.scrollToTop,
                backgroundColor: primaryColor,
                child: const Icon(Icons.arrow_upward, color: white),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
