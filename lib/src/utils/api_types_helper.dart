import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paprika/src/models/countries_model.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../utils.dart';

enum Type { places, cuisines, amenities, ambiance, music, parking }

typedef TypesCallback(TypesDto typesDto);

class ApiTypesHelper {
  TypesDto types;
  int notificationsCount;
  bool isAuthorized;
  String customerName;
  String phoneNumber;
  bool isPhoneNumberConfirmed;
  String profileImage;

  List<TypesCallback> _languageChangingListeners = [];

  static final ApiTypesHelper _apiTypesHelper = ApiTypesHelper._internal();

  factory ApiTypesHelper() {
    return _apiTypesHelper;
  }

  ApiTypesHelper._internal();

  void addListener(TypesCallback fn) {
    _languageChangingListeners.add(fn);
  }

  void removeListener(TypesCallback fn) {
    _languageChangingListeners.remove(fn);
  }

  List<String> getTypeNames(Type type) {
    List<String> _values = [];
    List<EnumValue> typeValues;
    switch (type) {
      case Type.places:
        typeValues = types.restaurantTypes;
        break;
      case Type.cuisines:
        typeValues = types.cuisineTypes;
        break;
      case Type.amenities:
        typeValues = types.amenityTypes;
        break;
      case Type.ambiance:
        typeValues = types.ambianceTypes;
        break;
      case Type.music:
        typeValues = types.musicTypes;
        break;
      case Type.parking:
        typeValues = types.parkingTypes;
        break;
    }

    typeValues.forEach((enumValue) {
      _values.add(enumValue.name);
    });

    return _values;
  }

  List<EnumValue> getType(Type type) {
    switch (type) {
      case Type.places:
        return types.restaurantTypes;
      case Type.cuisines:
        return types.cuisineTypes;
      case Type.amenities:
        return types.amenityTypes;
      case Type.ambiance:
        return types.ambianceTypes;
      case Type.music:
        return types.musicTypes;
      case Type.parking:
        return types.parkingTypes;
    }

    return null;
  }

  void setTypes(TypesDto types) {
    this.types = types;
  }

  Future<InitializationDto> init(BuildContext context) async {
    return _checkInitialConfig(context);
  }

  Future<bool> changeLanguage(BuildContext context) async {
    InitializationDto data = await _checkInitialConfig(context, true);
    if (data != null) {
      this.types = data.types;
      _languageChangingListeners.forEach((fn) {
        fn(data.types);
      });
      return true;
    }
    return false;
  }

  /// Fetches the initial config (types) from the backend server if they're not stored in the shared preferences
  /// The optional parameter [fetchFresh] is used to force fetch fresh types from the server regardless of shared preference status
  /// [fetchFresh] means hash should be null in order for the API to send fresh values
  Future<InitializationDto> _checkInitialConfig(BuildContext context,
      [bool fetchFresh]) async {
    String token = await SharedPreference.loadTokenFromSharedPref();
    if (token != null) PapricaApiClient().setToken(token);
    PapricaApiClient client = PapricaApiClient();
    // Check the types hash with the backend first
    CustomerConfigurationApi api = CustomerConfigurationApi(client);

    int typesHash, countriesHash, citiesHash, regionsHash;

    if (fetchFresh == null || fetchFresh == false) {
      typesHash =
          await SharedPreference.loadHashFromSharedPref(SharedPreference.types);
      countriesHash = await SharedPreference.loadHashFromSharedPref(
          SharedPreference.countries);
      citiesHash = await SharedPreference.loadHashFromSharedPref(
          SharedPreference.cities);
      regionsHash = await SharedPreference.loadHashFromSharedPref(
          SharedPreference.regions);
    }
    InitializationDto config = await api
        .apiServicesAppCustomerConfigurationGetInitialConfigurationsGet(
            typesHash: typesHash,
            countriesHash: countriesHash,
            citiesHash: citiesHash,
            regionsHash: regionsHash);

    List<bool> results = await Future.wait([
      _validateTypes(context, config),
      _validateCountries(context, config),
      _validateCities(context, config),
      _validateRegions(context, config),
    ]);
    for (bool ok in results) {
      if (!ok) {
        // Load fresh values from the API
        return _checkInitialConfig(context, true);
      }
    }
    return config;
  }

  Future<bool> _validateTypes(
      BuildContext context, InitializationDto config) async {
    this.isAuthorized = config.isAuthorized;
    this.isPhoneNumberConfirmed = config.customerInfo?.isPhoneNumberConfirmed;
    this.notificationsCount = config.unreadNotificationsCount;
    this.customerName = config.customerInfo?.name;
    this.phoneNumber = config.customerInfo?.phoneNumber;

    // Note: Code generated from for API client always initializes objects even if the value from the server is null
    // So check for one empty array in the configuration to know if the object holding this array was originally set to null
    if (config != null && config.types.restaurantTypes.isNotEmpty) {
      bool saved = await Future.wait([
        SharedPreference.saveHashToSharedPref(
            SharedPreference.types, config.typesHash),
        SharedPreference.saveStringToSharedPref(
            SharedPreference.types, json.encode(config.types)),
      ]).then((results) {
        return results.reduce((cumulative, value) => cumulative && value);
      }).catchError((err) {
        DefaultErrorHandler.handle(context, err);
        return false;
      });
      if (!saved) {
        return false;
      }

      this.setTypes(config.types);
      return true;
    } else {
      // Load type from the shared preferences
      String typesStr = await SharedPreference.loadStringFromSharedPref(
          SharedPreference.types);

      TypesDto types;
      try {
        // parse
        types = TypesDto.fromJson(json.decode(typesStr));
        if (types != null) {
          // save
          this.setTypes(types);

          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    }
  }

  Future<bool> _validateCountries(
      BuildContext context, InitializationDto config) async {
    // Note: Code generated from for API client always initializes objects even if the value from the server is null
    // So check for one empty array in the configuration to know if the object holding this array was originally set to null
    if (config != null && config.countries.items.isNotEmpty) {
      bool saved = await Future.wait([
        SharedPreference.saveHashToSharedPref(
            SharedPreference.countries, config.countriesHash),
        SharedPreference.saveStringToSharedPref(
            SharedPreference.countries, json.encode(config.countries)),
      ]).then((results) {
        return results.reduce((cumulative, value) => cumulative && value);
      }).catchError((err) {
        return false;
      });
      if (!saved) {
        return false;
      }
      return true;
    } else {
      // Load type from the shared preferences
      String countriesStr = await SharedPreference.loadStringFromSharedPref(
          SharedPreference.countries);

      PagedResultDtoConfigurationCountryDto countries;
      try {
        // parse
        countries = PagedResultDtoConfigurationCountryDto.fromJson(
            json.decode(countriesStr));
        if (countries != null) {
          // save
          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    }
  }

  Future<bool> _validateCities(
      BuildContext context, InitializationDto config) async {
    // Note: Code generated from for API client always initializes objects even if the value from the server is null
    // So check for one empty array in the configuration to know if the object holding this array was originally set to null
    if (config != null && config.cities.items.isNotEmpty) {
      bool saved = await Future.wait([
        SharedPreference.saveHashToSharedPref(
            SharedPreference.cities, config.citiesHash),
        SharedPreference.saveStringToSharedPref(
            SharedPreference.cities, json.encode(config.cities)),
      ]).then((results) {
        return results.reduce((cumulative, value) => cumulative && value);
      }).catchError((err) {
        return false;
      });
      if (!saved) {
        return false;
      }

      return true;
    } else {
      // Load type from the shared preferences
      String citiesStr = await SharedPreference.loadStringFromSharedPref(
          SharedPreference.cities);

      PagedResultDtoConfigurationCityDto cities;
      try {
        // parse
        cities =
            PagedResultDtoConfigurationCityDto.fromJson(json.decode(citiesStr));
        if (cities != null) {
          // save
          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    }
  }

  Future<bool> _validateRegions(
      BuildContext context, InitializationDto config) async {
    // Note: Code generated from for API client always initializes objects even if the value from the server is null
    // So check for one empty array in the configuration to know if the object holding this array was originally set to null
    if (config != null && config.regions.items.isNotEmpty) {
      bool saved = await Future.wait([
        SharedPreference.saveHashToSharedPref(
            SharedPreference.regions, config.regionsHash),
        SharedPreference.saveStringToSharedPref(
            SharedPreference.regions, json.encode(config.regions)),
      ]).then((results) {
        return results.reduce((cumulative, value) => cumulative && value);
      }).catchError((err) {
        DefaultErrorHandler.handle(context, err);
        return false;
      });
      if (!saved) {
        return false;
      }

      return true;
    } else {
      // Load regions from the shared preferences
      String regionsStr = await SharedPreference.loadStringFromSharedPref(
          SharedPreference.regions);

      PagedResultDtoConfigurationRegionDto regions;
      try {
        // parse
        regions = PagedResultDtoConfigurationRegionDto.fromJson(
            json.decode(regionsStr));
        if (regions != null) {
          // save
          return true;
        } else {
          return false;
        }
      } catch (err) {
        return false;
      }
    }
  }

  String getPlaceName(int value) {
    return types.restaurantTypes
        .firstWhere((restaurant) => restaurant.value == value)
        ?.name;
  }

  int calculateTypeValue(List<String> values, Type type) {
    int value;
    switch (type) {
      case Type.places:
        value = _calculateOrValueForList(this.types.restaurantTypes, values);
        break;
      case Type.cuisines:
        value = _calculateOrValueForList(this.types.cuisineTypes, values);
        break;
      case Type.amenities:
        value = _calculateOrValueForList(this.types.amenityTypes, values);
        break;
      case Type.ambiance:
        value = _calculateOrValueForList(this.types.ambianceTypes, values);
        break;
      case Type.music:
        value = _calculateOrValueForList(this.types.musicTypes, values);
        break;
      case Type.parking:
        value = _calculateOrValueForList(this.types.parkingTypes, values);
        break;
    }
    return value;
  }

  /// Calculates the or value of integers starting from a list of their corresponding names
  int _calculateOrValueForList(
      List<EnumValue> lookupList, List<String> values) {
    if (values == null || values.isEmpty) return null;
    // Generate a list of integers
    return values.map<int>((value) {
      return _getValue(lookupList, value);
    })
        // Calculate the "or" value of the integers
        .reduce((result, value) {
      return result | value;
    });
  }

  List<String> getTypeNamesListByValue(int value, Type type) {
    var typeEnumValues = getType(type);
    var result = List<String>();
    int index = 0;
    while (index < typeEnumValues.length) {
      var bitWindow = 1 << index;
      var enumValue = value & bitWindow;
      if (typeEnumValues.any((element) => element.value == enumValue)) {
        var currentEnum =
            typeEnumValues.firstWhere((element) => element.value == enumValue);
        result.add(currentEnum.name);
      }
      index++;
    }

    return result;
  }

  String getCommaSeparatedTypeNamesByValue(int value, Type type,
      {int maxNumber = 1, String separator = ' '}) {
    var namesList = getTypeNamesListByValue(value, type);
    var result = '';
    for (var index = 0; index < min(maxNumber, namesList.length); index++) {
      if (result != '') result += separator;
      result += namesList[index];
    }
    return result;
  }

  /// Looks up a string value inside the a list of types
  /// Returns the correspondent value of a type, or `0` in case the value is not presented
  int _getValue(List<EnumValue> lookupList, String name) {
    if (name == null) return 0;
    EnumValue lookup =
        lookupList.where((enumValue) => enumValue.name == name).first;
    if (lookup != null) return lookup.value;
    return 0;
  }

  Future<CountriesTreeModel> getCountries() async {
    PagedResultDtoConfigurationCountryDto countries;
    PagedResultDtoConfigurationCityDto cities;
    PagedResultDtoConfigurationRegionDto regions;
    try {
      countries = PagedResultDtoConfigurationCountryDto.fromJson(json.decode(
          await SharedPreference.loadStringFromSharedPref(
              SharedPreference.countries)));

      cities = PagedResultDtoConfigurationCityDto.fromJson(json.decode(
          await SharedPreference.loadStringFromSharedPref(
              SharedPreference.cities)));

      regions = PagedResultDtoConfigurationRegionDto.fromJson(json.decode(
          await SharedPreference.loadStringFromSharedPref(
              SharedPreference.regions)));
    } catch (e) {
      return null;
    }

    if (countries == null || cities == null || regions == null) return null;

    CountriesTreeModel tree = CountriesTreeModel();
    for (int countriesIterator = 0;
        countriesIterator < countries.items.length;
        countriesIterator++) {
      ConfigurationCountryDto countryDto = countries.items[countriesIterator];
      CountryModel country = CountryModel(countryDto.id, countryDto.name);

      for (int citiesIterator = 0;
          citiesIterator < cities.items.length;
          citiesIterator++) {
        if (cities.items[citiesIterator].countryId == country.id) {
          ConfigurationCityDto cityDto = cities.items[citiesIterator];
          CityModel city = CityModel(cityDto.id, cityDto.name);

          for (int regionsIterator = 0;
              regionsIterator < regions.items.length;
              regionsIterator++) {
            if (regions.items[regionsIterator].cityId == city.id) {
              ConfigurationRegionDto regionDto = regions.items[regionsIterator];
              RegionModel region = RegionModel(regionDto.id, regionDto.name);

              city.regions.add(region);
            }
          }

          country.cities.add(city);
        }
      }

      tree.countries.add(country);
    }
    return tree;
  }

  Future<Map<String, dynamic>> getCountriesMap() async {
    PagedResultDtoConfigurationCountryDto countries;
    PagedResultDtoConfigurationCityDto cities;
    PagedResultDtoConfigurationRegionDto regions;
    try {
      countries = PagedResultDtoConfigurationCountryDto.fromJson(json.decode(
          await SharedPreference.loadStringFromSharedPref(
              SharedPreference.countries)));

      cities = PagedResultDtoConfigurationCityDto.fromJson(json.decode(
          await SharedPreference.loadStringFromSharedPref(
              SharedPreference.cities)));

      regions = PagedResultDtoConfigurationRegionDto.fromJson(json.decode(
          await SharedPreference.loadStringFromSharedPref(
              SharedPreference.regions)));
    } catch (e) {
      return null;
    }

    if (countries == null || cities == null || regions == null) return null;

    Map<String, dynamic> tree = {};
    for (int countriesIterator = 0;
        countriesIterator < countries.items.length;
        countriesIterator++) {
      ConfigurationCountryDto countryDto = countries.items[countriesIterator];
      tree[countryDto.name] = {"id": countryDto.id, "cities": {}};

      for (int citiesIterator = 0;
          citiesIterator < cities.items.length;
          citiesIterator++) {
        if (cities.items[citiesIterator].countryId ==
            countries.items[countriesIterator].id) {
          ConfigurationCityDto cityDto = cities.items[citiesIterator];
          tree[countryDto.name]["cities"]
              [cityDto.name] = {"id": cityDto.id, "regions": {}};

          for (int regionsIterator = 0;
              regionsIterator < regions.items.length;
              regionsIterator++) {
            if (regions.items[regionsIterator].cityId ==
                cities.items[citiesIterator].countryId) {
              ConfigurationRegionDto regionDto = regions.items[regionsIterator];
              tree[countryDto.name]["cities"][cityDto.name]["regions"]
                  [regionDto.name] = {"id": regionDto.id};
            }
          }
        }
      }
    }
    return tree;
  }

  void setAuthorized(bool isAuthorized) {
    this.isAuthorized = isAuthorized;
  }

  void setIsPhoneNumberConfirmed(bool isPhoneNumberConfirmed) {
    this.isPhoneNumberConfirmed = isPhoneNumberConfirmed;
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  void setProfileImage(String imageUrl) {
    this.profileImage = imageUrl;
  }

  void initProfile(
      {bool isAuthorized,
      String customerName,
      String phoneNumber,
      bool isPhoneNumberConfirmed}) {
    this.isAuthorized = isAuthorized;
    this.customerName = customerName;
    this.phoneNumber = phoneNumber;
    this.isPhoneNumberConfirmed = isPhoneNumberConfirmed;
  }
}
