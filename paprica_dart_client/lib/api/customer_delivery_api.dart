part of swagger.api;

class CustomerDeliveryApi {
  final ApiClient apiClient;

  CustomerDeliveryApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future<CustomerUpcomingDeliveriesDto>
  apiServicesAppCustomerDeliveryGetAllUpcomingGet(
      {int skipCount, int maxResultCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Delivery/GetAllUpcoming"
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

    var response = await apiClient.invokeAPI(
        path,
        'GET',
        queryParams,
        postBody,
        headerParams,
        formParams,
        contentType,
        authNames);
    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(
          response.body, 'CustomerUpcomingDeliveriesDto')
      as CustomerUpcomingDeliveriesDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<CustomerOldDeliveriesDto>
  apiServicesAppCustomerDeliveryGetAllOldGet(
      {int skipCount, int maxResultCount}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Delivery/GetAllOld"
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
      return apiClient.deserialize(response.body, 'CustomerOldDeliveriesDto')
      as CustomerOldDeliveriesDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future apiServicesAppCustomerDeliveryDeleteOldPost(
      {EntityDtoInt64 input}) async {
    Object postBody = input;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Delivery/DeleteOld"
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
      return true;
    } else {
      return false;
    }
  }

  ///
  ///
  ///
  Future<MassageDto> apiServicesAppCustomerDeliveryCancelDeliveryPost(
      {CancelDeliveryDto delivery}) async {
    Object postBody = delivery;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Delivery/CancelDelivery"
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
      return apiClient.deserialize(response.body, 'MassageDto') as MassageDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<MassageDto> apiServicesAppCustomerDeliveryCreateDeliveryPost(
      {CreateDeliveryDto input}) async {
    Object postBody = input;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Delivery/CreateDelivery"
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
      return apiClient.deserialize(response.body, 'MassageDto') as MassageDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<MassageDto> apiServicesAppCustomerDeliveryUpdateDeliveryPost(
      {UpdateDeliveryDto input}) async {
    Object postBody = input;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Delivery/UpdateDelivery"
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
      return apiClient.deserialize(response.body, 'MassageDto') as MassageDto;
    } else {
      return null;
    }
  }


  ///
  ///
  ///
  Future<MassageDto>
  apiServicesAppCustomerDeliveryCancelDeliveryUpdateRequestPost(
      {EntityDtoInt64 input}) async {
    Object postBody = input;

    // verify required params are set

    // create path and map variables
    String path =
    "/api/services/app/Customer/Delivery/CancelDeliveryUpdateRequest"
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
      return apiClient.deserialize(response.body, 'MassageDto') as MassageDto;
    } else {
      return null;
    }
  }

}