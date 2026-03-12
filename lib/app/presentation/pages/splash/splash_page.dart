import 'package:poke_vault/app/packages/packages.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.catching_pokemon,
                size: 80,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Poké Váult',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 35),
            const CircularProgressIndicator(color: white),
            const SizedBox(height: 300),
            Obx(
              () => Text(
                controller.appVersion.value,
                style: const TextStyle(
                  fontSize: 13,
                  color: white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
