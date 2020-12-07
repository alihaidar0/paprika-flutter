class CreatePickupMealModel {
  final int mealId;
  final int quantity;
  final String notes;

  CreatePickupMealModel(this.mealId, this.quantity, this.notes);

  Map<String, dynamic> toJson() {
    return {
      'mealId': mealId,
      'quantity': quantity,
      'notes': notes,
    };
  }
}
