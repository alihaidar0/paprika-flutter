part of swagger.api;



class TokenAuthApi {
  final ApiClient apiClient;

  TokenAuthApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// 
  ///
  /// 
  Future<AuthenticateResultModel> apiTokenAuthAuthenticatePost({ AuthenticateModel model }) async {
    Object postBody = model;

    // verify required params are set

    // create path and map variables
    String path = "/api/TokenAuth/Authenticate".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    
    List<String> contentTypes = ["application/json-patch+json","application/json","text/json","application/_*+json"];

    String contentType = contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);
      
      if(hasFields)
        postBody = mp;
    }
    else {
          }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);

    if(response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if(response.body != null) {
      return 
          apiClient.deserialize(response.body, 'AuthenticateResultModel') as AuthenticateResultModel ;
    } else {
      return null;
    }
  }
  /// 
  ///
  /// 
  Future<ExternalAuthenticateResultModel> apiTokenAuthExternalAuthenticatePost({ ExternalAuthenticateModel model }) async {
    Object postBody = model;

    // verify required params are set

    // create path and map variables
    String path = "/api/TokenAuth/ExternalAuthenticate".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    
    List<String> contentTypes = ["application/json-patch+json","application/json","text/json","application/_*+json"];

    String contentType = contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);
      
      if(hasFields)
        postBody = mp;
    }
    else {
          }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);

    if(response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if(response.body != null) {
      return 
          apiClient.deserialize(response.body, 'ExternalAuthenticateResultModel') as ExternalAuthenticateResultModel ;
    } else {
      return null;
    }
  }
  /// 
  ///
  /// 
  Future<List<ExternalLoginProviderInfoModel>> apiTokenAuthGetExternalAuthenticationProvidersGet() async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path = "/api/TokenAuth/GetExternalAuthenticationProviders".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
    
    List<String> contentTypes = [];

    String contentType = contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);
      
      if(hasFields)
        postBody = mp;
    }
    else {
          }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);

    if(response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if(response.body != null) {
      return 
        (apiClient.deserialize(response.body, 'List<ExternalLoginProviderInfoModel>') as List).map((item) => item as ExternalLoginProviderInfoModel).toList();
    } else {
      return null;
    }
  }
}
