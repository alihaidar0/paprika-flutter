part of swagger.api;

class SoftUpPaprikaInsideAfterDishesAfterDishRequestDto {
  String afterDishId = null;

  String customerTableId = null;

  SoftUpPaprikaInsideAfterDishesAfterDishRequestDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideAfterDishesAfterDishRequestDto[afterDishId=$afterDishId, customerTableId=$customerTableId, ]';
  }

  SoftUpPaprikaInsideAfterDishesAfterDishRequestDto.fromJson(
      Map<String, dynamic> json) {
    if (json == null) return;
    afterDishId = json['afterDishId'];
    customerTableId = json['customerTableId'];
  }

  Map<String, dynamic> toJson() {
    return {'afterDishId': afterDishId, 'customerTableId': customerTableId};
  }

  static List<SoftUpPaprikaInsideAfterDishesAfterDishRequestDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideAfterDishesAfterDishRequestDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideAfterDishesAfterDishRequestDto.fromJson(
                    value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideAfterDishesAfterDishRequestDto>
      mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map =
        new Map<String, SoftUpPaprikaInsideAfterDishesAfterDishRequestDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideAfterDishesAfterDishRequestDto.fromJson(
              value));
    }
    return map;
  }
}
