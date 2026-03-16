part of swagger.api;

class PlacesApi {
  final ApiClient apiClient;

  PlacesApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future<PagedResultDtoRestaurantSummaryDto> apiServicesAppPlacesGetAllGet(
      {int parkingType,
      int ambianceType,
      int musicType,
      bool isSmokeFree,
      bool isAlcoholFree,
      int cuisineTypes,
      int amenityTypes,
      bool hasOutdoor,
      bool is24Hour,
      int restaurantTypes,
      double longitude,
      double latitude,
      bool isFeatured,
      int skipCount,
      int maxResultCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/services/app/Places/GetAll".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (parkingType != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "ParkingType", parkingType));
    }
    if (ambianceType != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "AmbianceType", ambianceType));
    }
    if (musicType != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "MusicType", musicType));
    }
    if (isSmokeFree != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "IsSmokeFree", isSmokeFree));
    }
    if (isAlcoholFree != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "IsAlcoholFree", isAlcoholFree));
    }
    if (cuisineTypes != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "CuisineTypes", cuisineTypes));
    }
    if (amenityTypes != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "AmenityTypes", amenityTypes));
    }
    if (hasOutdoor != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "HasOutdoor", hasOutdoor));
    }
    if (is24Hour != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "Is24Hour", is24Hour));
    }
    if (restaurantTypes != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "RestaurantTypes", restaurantTypes));
    }
    if (longitude != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "Longitude", longitude));
    }
    if (latitude != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "Latitude", latitude));
    }
    if (isFeatured != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "IsFeatured", isFeatured));
    }
    if (skipCount != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "SkipCount", skipCount));
    }
    if (maxResultCount != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "MaxResultCount", maxResultCount));
    }

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(
              response.body, 'PagedResultDtoRestaurantSummaryDto')
          as PagedResultDtoRestaurantSummaryDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<PagedResultDtoRestaurantLiteDto> apiServicesAppPlacesGetAllLiteGet(
      {int parkingType,
      int ambianceType,
      int musicType,
      bool isSmokeFree,
      bool isAlcoholFree,
      int cuisineTypes,
      int amenityTypes,
      bool hasOutdoor,
      bool is24Hour,
      int restaurantTypes,
      double longitude,
      double latitude,
      bool isFeatured,
      int skipCount,
      int maxResultCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/services/app/Places/GetAllLite".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (parkingType != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "ParkingType", parkingType));
    }
    if (ambianceType != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "AmbianceType", ambianceType));
    }
    if (musicType != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "MusicType", musicType));
    }
    if (isSmokeFree != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "IsSmokeFree", isSmokeFree));
    }
    if (isAlcoholFree != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "IsAlcoholFree", isAlcoholFree));
    }
    if (cuisineTypes != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "CuisineTypes", cuisineTypes));
    }
    if (amenityTypes != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "AmenityTypes", amenityTypes));
    }
    if (hasOutdoor != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "HasOutdoor", hasOutdoor));
    }
    if (is24Hour != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "Is24Hour", is24Hour));
    }
    if (restaurantTypes != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "RestaurantTypes", restaurantTypes));
    }
    if (longitude != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "Longitude", longitude));
    }
    if (latitude != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "Latitude", latitude));
    }
    if (isFeatured != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "IsFeatured", isFeatured));
    }
    if (skipCount != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "SkipCount", skipCount));
    }
    if (maxResultCount != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "MaxResultCount", maxResultCount));
    }

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(
              response.body, 'PagedResultDtoRestaurantLiteDto')
          as PagedResultDtoRestaurantLiteDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<FeaturedAndNearbyRestaurantDto>
      apiServicesAppPlacesGetFeaturedAndNearbyGet(
          {int parkingType,
          int ambianceType,
          int musicType,
          bool isSmokeFree,
          bool isAlcoholFree,
          int cuisineTypes,
          int amenityTypes,
          bool hasOutdoor,
          bool is24Hour,
          int restaurantTypes,
          double longitude,
          double latitude,
          bool isFeatured,
          int skipCount,
          int maxResultCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Places/GetFeaturedAndNearby"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (parkingType != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "ParkingType", parkingType));
    }
    if (ambianceType != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "AmbianceType", ambianceType));
    }
    if (musicType != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "MusicType", musicType));
    }
    if (isSmokeFree != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "IsSmokeFree", isSmokeFree));
    }
    if (isAlcoholFree != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "IsAlcoholFree", isAlcoholFree));
    }
    if (cuisineTypes != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "CuisineTypes", cuisineTypes));
    }
    if (amenityTypes != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "AmenityTypes", amenityTypes));
    }
    if (hasOutdoor != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "HasOutdoor", hasOutdoor));
    }
    if (is24Hour != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "Is24Hour", is24Hour));
    }
    if (restaurantTypes != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "RestaurantTypes", restaurantTypes));
    }
    if (longitude != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "Longitude", longitude));
    }
    if (latitude != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "Latitude", latitude));
    }
    if (isFeatured != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "IsFeatured", isFeatured));
    }
    if (skipCount != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "SkipCount", skipCount));
    }
    if (maxResultCount != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "MaxResultCount", maxResultCount));
    }

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(
              response.body, 'FeaturedAndNearbyRestaurantDto')
          as FeaturedAndNearbyRestaurantDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<PlacesResponse> getPlacesPage(
      {double longitude, double latitude}) async {
    Object postBody = null;
    String path = "/api/services/app/Places/GetLitePlacesLists";

    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (longitude != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "Longitude", longitude));
    }
    if (latitude != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "Latitude", latitude));
    }
    /// not used
    // List<String> contentTypes = [];

    String contentType = "application/json";
    List<String> authNames = [];

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'PlacesResponse')
          as PlacesResponse;
    } else {
      return null;
    }
  }
}
