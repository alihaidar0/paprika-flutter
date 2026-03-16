class MealShare {
  int restaurantId;
  int categoryId;
  int mealId;

  MealShare(this.restaurantId, this.categoryId, this.mealId);

  @override
  String toString() {
    return "MealShare [restaurantId: $restaurantId, categoryId: $categoryId, mealId: $mealId";
  }
}
