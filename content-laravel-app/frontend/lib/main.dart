import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/key_screen.dart';
import 'package:frontend/screens/treemap_screen.dart';
import 'package:frontend/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treemap DiawanID',
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 16.0,
            color: Color.fromARGB(255, 169, 169, 169),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, 
            backgroundColor: Colors.blue,
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12.0),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 248, 252, 255),
            backgroundColor: const Color.fromARGB(255, 0, 60, 95),
            textStyle: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12.0),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[800], // Background color of the TextField
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Color of the border
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Color of the border when enabled
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Color of the border when focused
          ),
          labelStyle: const TextStyle(color: Colors.white), // Color of the label text
          hintStyle: const TextStyle(color: Colors.white70), // Color of the placeholder text
          errorStyle: const TextStyle(color: Colors.red), // Color of the error text
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red), // Color of the border when error occurs
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red), // Color of the border when error occurs and focused
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/key': (context) => const KeyScreen(),
        '/login': (context) => const LoginScreen(),
        '/treemap': (context) => const TreemapScreen(title: 'Talent TreeMap'),
      },
      // home: const AuthWrapper(),
    );
  }
}
