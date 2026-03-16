class CreateDeliveryMealModel {
  final int mealId;
  final int quantity;
  final String notes;

  CreateDeliveryMealModel(this.mealId, this.quantity, this.notes);

  Map<String, dynamic> toJson() {
    return {
      'mealId': mealId,
      'quantity': quantity,
      'notes': notes,
    };
  }
}
