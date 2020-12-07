part of swagger.api;

class InitializationDto {
  bool isAuthorized = null;

  PagedResultDtoConfigurationCityDto cities = null;

  PagedResultDtoConfigurationCountryDto countries = null;

  PagedResultDtoConfigurationRegionDto regions = null;

  CustomerInfoDto customerInfo = null;

  TypesDto types = null;

  int typesHash = null;

  int regionsHash = null;

  int countriesHash = null;

  int citiesHash = null;

  int unreadNotificationsCount = null;

  InitializationDto();

  @override
  String toString() {
    return 'InitializationDto[isAuthorized=$isAuthorized, cities=$cities, countries=$countries, regions=$regions, types=$types, typesHash=$typesHash, regionsHash=$regionsHash, countriesHash=$countriesHash, citiesHash=$citiesHash, unreadNotificationsCount=$unreadNotificationsCount]';
  }

  InitializationDto.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    isAuthorized = json['isAuthorized'];
    cities = new PagedResultDtoConfigurationCityDto.fromJson(json['cities']);
    countries =
        new PagedResultDtoConfigurationCountryDto.fromJson(json['countries']);
    regions =
        new PagedResultDtoConfigurationRegionDto.fromJson(json['regions']);
    customerInfo = new CustomerInfoDto.fromJson(json['customerInfo']);
    types = new TypesDto.fromJson(json['types']);
    typesHash = json['typesHash'];
    regionsHash = json['regionsHash'];
    countriesHash = json['countriesHash'];
    countriesHash = json['countriesHash'];
    citiesHash = json['citiesHash'];
    unreadNotificationsCount = json['unreadNotificationsCount'];
  }

  Map<String, dynamic> toJson() {
    return {
      'isAuthorized': isAuthorized,
      'cities': cities,
      'countries': countries,
      'regions': regions,
      'types': types,
      'typesHash': typesHash,
      'regionsHash': regionsHash,
      'countriesHash': countriesHash,
      'customerInfo': customerInfo,
      'citiesHash': citiesHash,
      'unreadNotificationsCount': unreadNotificationsCount
    };
  }

  static List<InitializationDto> listFromJson(List<dynamic> json) {
    return json == null
        ? new List<InitializationDto>()
        : json.map((value) => new InitializationDto.fromJson(value)).toList();
  }

  static Map<String, InitializationDto> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, InitializationDto>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new InitializationDto.fromJson(value));
    }
    return map;
  }
}
