part of swagger.api;

class CustomerEventApi {
  final ApiClient apiClient;

  CustomerEventApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future<PagedResultDtoCustomerEventDto> apiServicesAppCustomerEventGetAllGet(
      {int restaurantId,
      String name,
      bool isActive,
      DateTime time,
      int skipCount,
      int maxResultCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Event/GetAll"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (restaurantId != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "RestaurantId", restaurantId));
    }
    if (name != null) {
      queryParams
          .addAll(_convertParametersForCollectionFormat("", "Name", name));
    }
    if (isActive != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "IsActive", isActive));
    }
    if (time != null) {
      queryParams
          .addAll(_convertParametersForCollectionFormat("", "Time", time));
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
              response.body, 'PagedResultDtoCustomerEventDto')
          as PagedResultDtoCustomerEventDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<CustomerEventDto> apiServicesAppCustomerEventGetGet({int id}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/services/app/Customer/Event/Get".replaceAll("{format}", "json");

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
      return apiClient.deserialize(response.body, 'CustomerEventDto')
          as CustomerEventDto;
    } else {
      return null;
    }
  }
}
