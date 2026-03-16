part of swagger.api;

class CustomerRestaurantApi {
  final ApiClient apiClient;

  CustomerRestaurantApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future apiServicesAppCustomerRestaurantAddFavoriteRestaurantPost(
      {AddFavoriteRestaurantDto input}) async {
    Object postBody = input;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Restaurant/AddFavoriteRestaurant"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [
      "application/json-patch+json",
      "application/json",
      "text/json",
      "application/_*+json"
    ];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return;
    } else {
      return;
    }
  }

  ///
  ///
  ///
  Future<PagedResultDtoRestaurantSummaryDto>
      apiServicesAppCustomerRestaurantGetAllGet(
          {int skipCount, int maxResultCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Restaurant/GetAll"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
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
  Future<PagedResultDtoRestaurantDto>
      apiServicesAppCustomerRestaurantGetFavoriteRestaurantsGet(
          {int skipCount, int maxResultCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Restaurant/GetFavoriteRestaurants"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
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
      return apiClient.deserialize(response.body, 'PagedResultDtoRestaurantDto')
          as PagedResultDtoRestaurantDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<RestaurantHomeDto> apiServicesAppCustomerRestaurantGetGet(
      {int id}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Restaurant/Get"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "Id", id));
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
      return apiClient.deserialize(response.body, 'RestaurantHomeDto')
          as RestaurantHomeDto;
    } else {
      return null;
    }
  }


  ///
  ///
  ///
  Future<DeliveryRegionsDto> apiServicesAppCustomerRestaurantGetRestaurantDeliveryRegionsGet(
      {int id}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Restaurant/GetRestaurantDeliveryRegions"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (id != null) {
      queryParams.addAll(_convertParametersForCollectionFormat("", "Id", id));
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
      return apiClient.deserialize(response.body, 'DeliveryRegionsDto')
      as DeliveryRegionsDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future apiServicesAppCustomerRestaurantRemoveFavoriteRestaurantPost(
      {AddFavoriteRestaurantDto input}) async {
    Object postBody = input;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/services/app/Customer/Restaurant/RemoveFavoriteRestaurant"
            .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [
      "application/json-patch+json",
      "application/json",
      "text/json",
      "application/_*+json"
    ];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return;
    } else {
      return;
    }
  }


  ///
  ///
  ///
  Future apiServicesAppCustomerRestaurantChangeRestaurantNotificationsPost(
      {ChangeRestaurantNotificationsDto input}) async {
    Object postBody = input;

    // verify required params are set

    // create path and map variables
    String path =
    "/api/services/app/Customer/Restaurant/ChangeRestaurantNotifications"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [
      "application/json-patch+json",
      "application/json",
      "text/json",
      "application/_*+json"
    ];

    String contentType =
    contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return;
    } else {
      return;
    }
  }
}
