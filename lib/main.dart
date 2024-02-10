import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mymeals/screens/tabs.dart';

final kColorSchemeLight = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 11, 22, 233),
);

final kColorSchemeDark = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 0, 0, 0),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const ProviderScope(child: MyApp())));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals-App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: kColorSchemeLight,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorSchemeLight.onPrimaryContainer,
          foregroundColor: kColorSchemeLight.onPrimary,
        ),
        cardTheme: const CardTheme().copyWith(
            color: kColorSchemeLight.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorSchemeLight.primaryContainer),
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorSchemeLight.onSecondaryContainer,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorSchemeLight.onSecondaryContainer,
            fontSize: 16,
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorSchemeLight.onSecondaryContainer,
            fontSize: 16,
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorSchemeLight.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kColorSchemeDark,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorSchemeDark.background,
          foregroundColor: kColorSchemeDark.onPrimaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
            color: kColorSchemeDark.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorSchemeDark.primaryContainer),
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorSchemeDark.onSecondaryContainer,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.normal,
            color: kColorSchemeDark.onSecondaryContainer,
            fontSize: 16,
          ),
        ),
      ),
      home: const TabsScreen(),
      routes: const {},
    );
  }
}
