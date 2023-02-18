import 'package:generic_business_app/model/food-model.dart';
import 'package:generic_business_app/resources/api-provider.dart';

class ApiRepository{
  final _provider = ApiProvider();
  
  Future<FoodModel> fetchRandomFood(){
    return _provider.fetchRandomFood();
  }

  Future<FoodModel> searchCertainRecipe(String recipeName){
    return _provider.searchCertainRecipe(recipeName);
  }

}

class NetworkError extends Error{}