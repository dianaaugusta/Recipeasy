


part of 'food-api-bloc.dart';

abstract class FoodApiState extends Equatable{
  const FoodApiState();

  List<Object> get props => [];
}

class FoodApiInitial extends FoodApiState{}

class FoodApiLoading extends FoodApiState{}

class FoodApiLoaded extends FoodApiState{
   final FoodModel foodModel;
  const FoodApiLoaded(this.foodModel);
}

class FoodApiError extends FoodApiState{
  final String message;
  const FoodApiError(this.message);
}