import 'package:poke_vault/app/packages/packages.dart';

class DetailController extends GetxController {
  final GetPokemonDetailUseCase getPokemonDetailUseCase;

  DetailController({required this.getPokemonDetailUseCase});

  final Rx<Pokemon?> pokemon = Rx<Pokemon?>(null);
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();

    final nameOrId = Get.arguments as String?;
    if (nameOrId != null) {
      fetchPokemonDetail(nameOrId);
    } else {
      error.value = 'Pokémon ID or Name is required';
      isLoading.value = false;
    }
  }

  Future<void> fetchPokemonDetail(String nameOrId) async {
    try {
      isLoading.value = true;
      error.value = '';

      final result = await getPokemonDetailUseCase.execute(nameOrId);
      pokemon.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Color getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return red;
      case 'water':
        return blue;
      case 'grass':
        return green;
      case 'electric':
        return amber;
      case 'psychic':
        return pink;
      case 'ice':
        return cyan;
      case 'dragon':
        return indigo;
      case 'dark':
        return blueGrey;
      case 'fairy':
        return pinkAccent;
      case 'normal':
        return grey;
      case 'fighting':
        return orange;
      case 'flying':
        return lightBlue;
      case 'poison':
        return purple;
      case 'ground':
        return brown;
      case 'rock':
        return brown700;
      case 'bug':
        return lightGreen;
      case 'ghost':
        return deepPurple;
      case 'steel':
        return blueGrey300;
      default:
        return grey;
    }
  }
}
