import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_business_app/model/food-model.dart';
import 'package:generic_business_app/resources/api-repository.dart';
import 'package:equatable/equatable.dart';
import 'package:generic_business_app/model/food-model.dart';

part 'food-api-event.dart';
part 'food-api-state.dart';

class FoodApiBloc extends Bloc<FoodApiEvent, FoodApiState>{
  final ApiRepository _apiRepository = ApiRepository();
  FoodApiBloc() : super(FoodApiInitial()){
    on<GetFoodList> (((event, emit) async{
      try{
        emit(FoodApiLoading());
        final foodList = await _apiRepository.fetchRandomFood();
        emit(FoodApiLoaded(foodList));
      }
      on NetworkError{
        emit(FoodApiError("Connection Failed"));
      }
    }));

    on<FoodListRequested> (((event, emit) async{
      try{
        emit(FoodApiLoading());
        final foodList = await _apiRepository.searchCertainRecipe(event.recipeName);
        emit(FoodApiLoaded(foodList));
      }
      on NetworkError{
        emit(FoodApiError("Connection Failed"));
      }
    }));
  }
}