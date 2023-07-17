import 'package:flutter/material.dart';
import 'package:generic_business_app/pages/food-main.dart';
import 'package:generic_business_app/resources/food-controller.dart';

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
          fontFamily: 'Roboto'
      ),
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
              "Your app for cooking inspiration",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
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
                              heroTag: "button$index",
                              onPressed: () {
                                  if(index == 0){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const FoodMainPage()),
                                    );
                                  }
                              },
                              label: Text(
                                _controller.listFoodCategoriesToFilter(),
                                style: const TextStyle(color: Colors.black),
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
