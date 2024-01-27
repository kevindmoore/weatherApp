import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  putLumberdashToWork(withClients: [
    ColorizeLumberdash(),
  ]);
  // To load the .env file contents into dotenv.
  // NOTE: fileName defaults to .env and can be omitted in this case.
  // Ensure that the filename corresponds to the path in step 1 and 2.
  await dotenv.load(fileName: '.env');
  globalSharedPreferences = await SharedPreferences.getInstance();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  var initialized = false;

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routeProvider);
    return MaterialApp.router(
      routerConfig: router.config(),
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
