import 'package:generic_business_app/model/food-model.dart';
import 'package:generic_business_app/resources/api-provider.dart';

class ApiRepository{
  final _provider = ApiProvider();
  
  Future<FoodModel> fetchRandomFood(){
    return _provider.fetchRandomFood();
  }

}

class NetworkError extends Error{}