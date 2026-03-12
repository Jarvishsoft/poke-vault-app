import 'package:poke_vault/app/packages/packages.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // provide generic [PokemonRepository] via [Implementation]
    Get.lazyPut(() => PokemonRepositoryImpl(), fenix: true);

    // provide [Usecase] depends on [Repository]
    Get.lazyPut(() => GetPokemonsUseCase(Get.find<PokemonRepositoryImpl>()));

    // provide [Controller] depends on [Usecase]
    Get.lazyPut(() => HomeController(getPokemonsUseCase: Get.find()));
  }
}
