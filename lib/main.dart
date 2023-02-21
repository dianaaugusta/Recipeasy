import 'package:flutter/material.dart';
import 'package:generic_business_app/pages/food-main.dart';
import 'package:generic_business_app/resources/food-controller.dart';
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
          fontFamily: GoogleFonts.abel().fontFamily),
      home: FoodFilterChoice(),
    );
  }
}

class FoodFilterChoice extends StatelessWidget {
  final FoodController _controller = FoodController();
  FoodFilterChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Recipeasy",
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
              ),
            ),
            const Text(
              "Seu app de inspiração culinária",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 100.0,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            width: 200,
                            color: Colors.deepOrange,
                            child: FloatingActionButton.extended(
                              onPressed: () {},
                              label: Text(
                                _controller.listFoodCategoriesToFilter(),
                                style: TextStyle(color: Colors.black),
                              ),
                              backgroundColor: Colors.white,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: _controller.categories.length),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
