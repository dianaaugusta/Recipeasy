
part of 'food-api-bloc.dart';

abstract class FoodApiEvent extends Equatable{
  const FoodApiEvent();
  List<Object> get props => [];

}

class GetFoodList extends FoodApiEvent{}

class FoodListRequested extends FoodApiEvent{

  final String recipeName
;

  FoodListRequested(this.recipeName);
}