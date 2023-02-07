import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_business_app/bloc/food-api-bloc.dart';
import 'package:generic_business_app/model/food-model.dart';

class FoodMainPage extends StatefulWidget {
  const FoodMainPage({super.key});

  @override
  State<FoodMainPage> createState() => _FoodMainPageState();
}

class _FoodMainPageState extends State<FoodMainPage> {
  final FoodApiBloc _foodApiBloc = FoodApiBloc();

  @override
  void initState() {
    _foodApiBloc.add(GetFoodList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Recipeasy")),
        body: BuildTopNewsList(bloc: _foodApiBloc));
  }
}

class BuildTopNewsList extends StatelessWidget {
  final FoodApiBloc bloc;

  const BuildTopNewsList({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: BlocProvider(
        create: (_) => bloc,
        child: BlocListener<FoodApiBloc, FoodApiState>(
          listener: (context, state) {
            if (state is FoodApiError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          child: BlocBuilder<FoodApiBloc, FoodApiState>(
            builder: (context, state) {
              if (state is FoodApiLoading) {
                return CircularProgressIndicator();
              } else if (state is FoodApiLoaded) {
                return BuildCard(model: state.foodModel);
              }
              return Text("404");
            },
          ),
        ),
      ),
    );
  }
}

class BuildForm extends StatefulWidget {
  const BuildForm({super.key});

  @override
  State<BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<BuildForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.food_bank,
                      color: Colors.blueAccent,
                    ),
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.all(10),
                    errorMaxLines: 1,
                    hintText: 'Pesquise receita por...',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    // Process data.
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BuildCard extends StatefulWidget {
  final FoodModel model;
  const BuildCard({super.key, required this.model});

  @override
  State<BuildCard> createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildForm(),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.model.meals?.length ?? 1,
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                              "${widget.model.meals?[index].strMealThumb}"),
                        ),
                        Text(
                          widget.model.meals?[index].strMeal ?? "nomeal",
                          style: const TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            widget.model.meals?[index].strCategory ??
                                "Sem Categoria",
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            widget.model.meals?[index].strSource ?? "Sem fonte",
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => hideShowRecipe(),
                          child: Text(
                            isShow ? 'Esconder Receita' : 'Mostrar Receita',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isShow,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.model.meals?[index].strInstructions ??
                              "Receita indisponível :(",
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })),
      ],
    );
  }

  void hideShowRecipe() {
    setState(
      () {
        isShow = !isShow;
        print(isShow);
      },
    );
  }
}
