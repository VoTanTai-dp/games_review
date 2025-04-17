import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'ui/home/home_screen.dart';
import '../ui/screens.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1C202C),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF12141C),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GamesManager()),
      ],
      child: MaterialApp(
        title: "Game Reviewer",
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: SafeArea(child: HomeScreen()),
        onGenerateRoute: (settings) {
          if (settings.name == EditAddGameScreen.routeName) {
            final productId = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (ctx) {
                return SafeArea(
                  child: EditAddGameScreen(
                    productId != null
                        ? ctx.read<GamesManager>().findById(productId)
                        : null,
                  ),
                );
              },
            );
          }
          return null;
        },
      ),
    );
  }
}
