part of swagger_inside.api;

class CustomerRestaurantApi {
  final ApiClient apiClient;

  CustomerRestaurantApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future apiAppCustomerRestaurantFeedbackPost(
      {SoftUpPaprikaInsideRestaurantsFeedbackDto body}) async {
    Object postBody = body;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/app/customer-restaurant/feedback".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [
      "application/json",
      "text/json",
      "application/_*+json"
    ];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = ["oauth2"];

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
  Future<SoftUpPaprikaInsideRestaurantsRestaurantDto>
      apiAppCustomerRestaurantRestaurantProfileGet() async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/app/customer-restaurant/restaurant-profile"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = ["oauth2"];

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
              response.body, 'SoftUpPaprikaInsideRestaurantsRestaurantDto')
          as SoftUpPaprikaInsideRestaurantsRestaurantDto;
    } else {
      return null;
    }
  }
}
