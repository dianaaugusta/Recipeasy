import 'package:dio/dio.dart';
import 'package:generic_business_app/model/food-model.dart';

class ApiProvider {
  final Dio _dio =  Dio();
  final String _url = "https://www.themealdb.com/api/json/v1/1/random.php";

  Future<FoodModel> fetchRandomFood() async{
      Response response = await _dio.get(_url);
      if(response.statusCode != 200){
        print("exception");
      }
      return FoodModel.fromJson(response.data);
  }
}
  

