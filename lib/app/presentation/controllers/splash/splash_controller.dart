import 'package:poke_vault/app/packages/packages.dart';

class SplashController extends GetxController {
  final RxString appVersion = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadVersionAndNavigate();
  }

  // version app
  void _loadVersionAndNavigate() async {
    final info = await PackageInfo.fromPlatform();
    appVersion.value = 'v${info.version}';

    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed(Routes.home);
  }
}
