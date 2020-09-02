part of swagger.api;

class AdminDashboardDto {
  int activeReportsCount = null;

  int restaurantsCount = null;

  int featuredRestaurantsCount = null;

  int customersCount = null;

  AdminDashboardDto();

  @override
  String toString() {
    return 'AdminDashboardDto[activeReportsCount=$activeReportsCount, restaurantsCount=$restaurantsCount, featuredRestaurantsCount=$featuredRestaurantsCount, customersCount=$customersCount, ]';
  }

  AdminDashboardDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    activeReportsCount = json['activeReportsCount'];
    restaurantsCount = json['restaurantsCount'];
    featuredRestaurantsCount = json['featuredRestaurantsCount'];
    customersCount = json['customersCount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'activeReportsCount': activeReportsCount,
      'restaurantsCount': restaurantsCount,
      'featuredRestaurantsCount': featuredRestaurantsCount,
      'customersCount': customersCount
    };
  }

  static List<AdminDashboardDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<AdminDashboardDto>()
        : json.map((value) => new AdminDashboardDto.fromJson(value)).toList();
  }

  static Map<String, AdminDashboardDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, AdminDashboardDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AdminDashboardDto.fromJson(value));
    }
    return map;
  }
}
