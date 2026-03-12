import 'package:poke_vault/app/packages/packages.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    // assuming [PokemonRepositoryImpl}  already registered generically or we fall back to it
    if (!Get.isRegistered<PokemonRepositoryImpl>()) {
      Get.lazyPut(() => PokemonRepositoryImpl());
    }

    Get.lazyPut(
      () => GetPokemonDetailUseCase(Get.find<PokemonRepositoryImpl>()),
    );
    Get.lazyPut(() => DetailController(getPokemonDetailUseCase: Get.find()));
  }
}
