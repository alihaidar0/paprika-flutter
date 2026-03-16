part of swagger.api;

class ManagerEventApi {
  final ApiClient apiClient;

  ManagerEventApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future apiServicesAppManagerEventChangeStatusPost(
      {ChangeEventStatusDto input}) async {
    Object postBody = input;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Manager/Event/ChangeStatus"
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
  Future apiServicesAppManagerEventCreatePost({CreateEventDto input}) async {
    Object postBody = input;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/services/app/Manager/Event/Create".replaceAll("{format}", "json");

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
  Future<PagedResultDtoManagerEventDto> apiServicesAppManagerEventGetAllGet(
      {int skipCount, int maxResultCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/services/app/Manager/Event/GetAll".replaceAll("{format}", "json");

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
              response.body, 'PagedResultDtoManagerEventDto')
          as PagedResultDtoManagerEventDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future apiServicesAppManagerEventUpdatePost({UpdateEventDto input}) async {
    Object postBody = input;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/services/app/Manager/Event/Update".replaceAll("{format}", "json");

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
