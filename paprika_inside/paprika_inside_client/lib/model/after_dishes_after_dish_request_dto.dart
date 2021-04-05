part of swagger_inside.api;

class AfterDishesAfterDishRequestDto {
  String afterDishId = null;

  String customerTableId = null;

  AfterDishesAfterDishRequestDto();

  @override
  String toString() {
    return 'AfterDishesAfterDishRequestDto[afterDishId=$afterDishId, customerTableId=$customerTableId, ]';
  }

  AfterDishesAfterDishRequestDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    afterDishId = json['afterDishId'];
    customerTableId = json['customerTableId'];
  }

  Map<String, dynamic> toJson() {
    return {'afterDishId': afterDishId, 'customerTableId': customerTableId};
  }

  static List<AfterDishesAfterDishRequestDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AfterDishesAfterDishRequestDto>()
        : json
            .map((value) => new AfterDishesAfterDishRequestDto.fromJson(value))
            .toList();
  }

  static Map<String, AfterDishesAfterDishRequestDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AfterDishesAfterDishRequestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AfterDishesAfterDishRequestDto.fromJson(value));
    }
    return map;
  }
}
