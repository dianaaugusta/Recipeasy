class FoodCategoriesModel {
  String? categoryName;
  int? id;

  FoodCategoriesModel({this.categoryName, this.id});

  FoodCategoriesModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['id'] = this.id;
    return data;
  }
}