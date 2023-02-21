class FoodController {
  List<String> categories = [
    "primeiro",
    "segundo",
    "terceiro"
  ];

  String returnImageCategoryIconUrl(String categoryName) {
    switch (categoryName) {
      case "Dessert":
        return "https://cdn-icons-png.flaticon.com/512/2965/2965574.png";
      case "Beef":
        return "https://cdn-icons-png.flaticon.com/512/2619/2619468.png";
      case "Chicken":
        return "https://cdn-icons-png.flaticon.com/512/9744/9744934.png";
      case "Pasta":
        return "https://cdn-icons-png.flaticon.com/512/701/701980.png";
      case "Pork":
        return "https://cdn-icons-png.flaticon.com/512/4062/4062371.png";
      case "Lamb":
        return "https://cdn-icons-png.flaticon.com/512/9680/9680146.png";  
      case "Seafood":
        return "https://cdn-icons-png.flaticon.com/512/3707/3707695.png";
      case "Vegan":
        return "https://cdn-icons-png.flaticon.com/512/5278/5278701.png";
      case "Vegetarian":
        return "https://cdn-icons-png.flaticon.com/512/4905/4905910.png";
      case "Starter":
        return "https://cdn-icons-png.flaticon.com/512/5371/5371098.png";  
      case "Side":
        return "https://cdn-icons-png.flaticon.com/512/45/45419.png";
          
    }
    return "https://cdn-icons-png.flaticon.com/512/57/57108.png";
  }

  String listFoodCategoriesToFilter(){
      
      if(categories.isNotEmpty){
          for(var i = 0; i < categories.length; i++){
          return categories[i];
        }
      }
      return "Sem categoria definida";
  }
}
