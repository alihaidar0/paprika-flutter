part of swagger.api;

class CustomerOfferApi {
  final ApiClient apiClient;

  CustomerOfferApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future<PagedResultDtoCustomerOfferDto>
      apiServicesAppCustomerOfferGetAllActiveGet(
          {int maxResultCount, int skipCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Offer/GetAllActive"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (maxResultCount != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "MaxResultCount", maxResultCount));
    }
    if (skipCount != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "SkipCount", skipCount));
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
              response.body, 'PagedResultDtoCustomerOfferDto')
          as PagedResultDtoCustomerOfferDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<PagedResultDtoCustomerOfferDto>
      apiServicesAppCustomerOfferGetAllByRestaurantIdGet(
          {int restaurantId,
          bool isActive,
          int skipCount,
          int maxResultCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Offer/GetAllByRestaurantId"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (restaurantId != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "RestaurantId", restaurantId));
    }
    if (isActive != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "IsActive", isActive));
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
              response.body, 'PagedResultDto[CustomerOfferDto]')
          as PagedResultDtoCustomerOfferDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<CustomerOfferDto> apiServicesAppCustomerOfferGetGet({int id}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/services/app/Customer/Offer/Get".replaceAll("{format}", "json");

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
      return apiClient.deserialize(response.body, 'CustomerOfferDto')
          as CustomerOfferDto;
    } else {
      return null;
    }
  }
}
