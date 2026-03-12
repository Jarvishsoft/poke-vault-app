import 'package:poke_vault/app/packages/packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init hive
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // orientation setup device
        if (MediaQuery.of(context).size.width > 600) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        } else {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Poke Váult',
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: greyAccent200,
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          initialRoute: AppPages.initial,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
