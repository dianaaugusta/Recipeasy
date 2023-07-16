
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_business_app/bloc/food-api-bloc.dart';
import 'package:generic_business_app/model/food-model.dart';
import 'package:generic_business_app/resources/food-controller.dart';

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
                return const Center(child: CircularProgressIndicator());
              } else if (state is FoodApiLoaded) {
                return BuildCard(model: state.foodModel);
              }
              return const Text("404");
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
  final recipeInputController = TextEditingController();
  final FoodController controller = FoodController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    recipeInputController.dispose();
    super.dispose();
  }

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
                  controller: recipeInputController,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.food_bank,
                      color: Colors.deepOrange,
                    ),
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.all(10),
                    errorMaxLines: 1,
                    hintText: 'Search recipe by name...',
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
                    BlocProvider.of<FoodApiBloc>(context).add(FoodListRequested(
                        //"Arrabiata"
                        recipeInputController.text));
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
  final FoodController controller = FoodController();
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const BuildForm(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.model.meals?.length ?? 1,
                itemBuilder: ((context, index) {
                  return Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.50,
                        width: MediaQuery.of(context).size.width,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(
                              "${widget.model.meals?[index].strMealThumb}",
                              ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.25),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        widget.model.meals?[index].strMeal ??
                                            "No meal found",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.network(
                                            controller
                                                .returnImageCategoryIconUrl(
                                              widget.model.meals?[index]
                                                      .strCategory ??
                                                  "Miscellaneous",
                                            ),
                                          ),
                                        ),
                                        Text(
                                          widget.model.meals?[index]
                                                  .strCategory ??
                                              "Not categorized",
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => hideShowRecipe(),
                                        child: Text(
                                          isShow
                                              ? 'Show Recipe'
                                              : 'Hide Recipe',
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Expanded(
                                          child: Text(
                                            "${widget.model.meals?[index].strSource ?? "No source found"}",
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis ,
                                            style: const TextStyle(fontSize: 10),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: isShow,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.model.meals?[index]
                                              .strInstructions ??
                                          "Unavailable recipe :(",
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                })),
          ),
        ],
      ),
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
