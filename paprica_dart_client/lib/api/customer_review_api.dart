part of swagger.api;

class CustomerReviewApi {
  final ApiClient apiClient;

  CustomerReviewApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future apiServicesAppCustomerReviewCreateOrUpdatePost(
      {CreateOrUpdateReviewDto input}) async {
    Object postBody = input;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Review/CreateOrUpdate"
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
  Future<PagedResultDtoReviewDto> apiServicesAppCustomerReviewGetOldGet(
      {int restaurantId, int skipCount, int maxResultCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Review/GetAllRestaurantReviews"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (restaurantId != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "RestaurantId", restaurantId));
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
      return apiClient.deserialize(response.body, 'PagedResultDtoReviewDto')
          as PagedResultDtoReviewDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<RestaurantReviewsSummaryDto>
      apiServicesAppCustomerReviewGetRestaurantReviewsSummaryGet(
          {int id}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/services/app/Customer/Review/GetRestaurantReviewsSummary"
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
      return apiClient.deserialize(response.body, 'RestaurantReviewsSummaryDto')
          as RestaurantReviewsSummaryDto;
    } else {
      return null;
    }
  }
}
