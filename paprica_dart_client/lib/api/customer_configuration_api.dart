part of swagger.api;

class CustomerConfigurationApi {
  final ApiClient apiClient;

  CustomerConfigurationApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future apiServicesAppCustomerConfigurationChangeLanguagePost(
      {String language}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/services/app/Customer/Configuration/ChangeLanguage"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (language != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "language", language));
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
  Future<InitializationDto>
      apiServicesAppCustomerConfigurationGetInitialConfigurationsGet(
          {int typesHash,
          int citiesHash,
          int countriesHash,
          int regionsHash}) async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/services/app/Customer/Configuration/GetInitialConfigurations"
            .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    if (typesHash != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "TypesHash", typesHash));
    }
    if (citiesHash != null) {
      queryParams.addAll(
          _convertParametersForCollectionFormat("", "CitiesHash", citiesHash));
    }
    if (countriesHash != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "CountriesHash", countriesHash));
    }
    if (regionsHash != null) {
      queryParams.addAll(_convertParametersForCollectionFormat(
          "", "RegionsHash", regionsHash));
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
      return apiClient.deserialize(response.body, 'InitializationDto')
          as InitializationDto;
    } else {
      return null;
    }
  }
}
