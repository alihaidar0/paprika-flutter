part of swagger.api;

class SoftUpPaprikaInsideMealsMealVariantDto {
  int id = null;

  String name = null;

  double margin = null;

  bool isActive = null;

  SoftUpPaprikaInsideMealsMealVariantDto();

  @override
  String toString() {
    return 'SoftUpPaprikaInsideMealsMealVariantDto[id=$id, name=$name, margin=$margin, isActive=$isActive, ]';
  }

  SoftUpPaprikaInsideMealsMealVariantDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    margin = json['margin'] == null ? null : json['margin'].toDouble();
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'margin': margin, 'isActive': isActive};
  }

  static List<SoftUpPaprikaInsideMealsMealVariantDto> listFromJson(
      List<dynamic> json) {
    return json == null
        ? new List<SoftUpPaprikaInsideMealsMealVariantDto>()
        : json
            .map((value) =>
                new SoftUpPaprikaInsideMealsMealVariantDto.fromJson(value))
            .toList();
  }

  static Map<String, SoftUpPaprikaInsideMealsMealVariantDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, SoftUpPaprikaInsideMealsMealVariantDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] =
          new SoftUpPaprikaInsideMealsMealVariantDto.fromJson(value));
    }
    return map;
  }
}
