import 'package:poke_vault/app/packages/packages.dart';

abstract class AppPages {
  static const initial = Routes.splash;

  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.detail,
      page: () => const DetailPage(),
      binding: DetailBinding(),
    ),
  ];
}
