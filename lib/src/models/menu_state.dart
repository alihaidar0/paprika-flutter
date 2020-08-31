import 'package:swagger/api.dart';

class MenuState {
  bool isGrid = true;
  CategoryDto selectedCategory;
  Future<List<MealDto>> meals;
  Future<List<CategoryDto>> categories;

  MenuState({this.isGrid, this.selectedCategory, this.meals});
}
