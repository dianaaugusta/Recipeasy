import 'package:flutter/material.dart';
import 'package:generic_business_app/pages/food-main.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: GoogleFonts.abel().fontFamily
      ),
      home: const FoodFilterChoice(),
    );
  }
}

class FoodFilterChoice extends StatelessWidget {
  const FoodFilterChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          children: [
            Text("Recipeasy"),
            FloatingActionButton.large(
              onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => const FoodMainPage()),
                )
              )
          ]
          ),
      ),
    );
  }
}
  