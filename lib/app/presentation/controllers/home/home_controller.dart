import 'package:poke_vault/app/packages/packages.dart';

class HomeController extends GetxController {
  final GetPokemonsUseCase getPokemonsUseCase;

  HomeController({required this.getPokemonsUseCase});

  final RxList<Pokemon> pokemons = <Pokemon>[].obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxBool showFab = false.obs;
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  int _offset = 0;
  final int _limit = 20;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(scrollListener);
    fetchPokemons();
  }

  @override
  void onClose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  // searching pokemons
  List<Pokemon> get filteredPokemons {
    if (searchQuery.value.isEmpty) {
      return pokemons;
    }
    return pokemons
        .where(
          (pokemon) => pokemon.name.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ),
        )
        .toList();
  }

  Future<void> refreshPokemons() async {
    _offset = 0;
    pokemons.clear();
    await fetchPokemons();
  }

  Future<void> fetchPokemons() async {
    if (isLoading.value && pokemons.isNotEmpty) return;

    try {
      isLoading.value = true;
      error.value = '';

      final newPokemons = await getPokemonsUseCase.execute(
        offset: _offset,
        limit: _limit,
      );
      pokemons.addAll(newPokemons);
      _offset += _limit;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  void scrollListener() {
    if (scrollController.offset >= 100) {
      if (!showFab.value) showFab.value = true;
    } else {
      if (showFab.value) showFab.value = false;
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
