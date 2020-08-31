part of swagger.api;

class UploadApi {
  final ApiClient apiClient;

  UploadApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future<AntdImageDto> apiServicesAppUploadAntdUploadImagePost(
      MultipartFile file) async {
    Object postBody = null;

    // verify required params are set
    if (file == null) {
      throw new ApiException(400, "Missing required param: file");
    }

    // create path and map variables
    String path = "/api/services/app/Upload/AntdUploadImage"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["multipart/form-data"];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (file != null) {
        hasFields = true;
        mp.fields['file'] = file.field;
        mp.files.add(file);
      }

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'AntdImageDto')
          as AntdImageDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<FileDto> apiServicesAppUploadUploadAudioPost(
      MultipartFile file) async {
    Object postBody = null;
    // verify required params are set
    if (file == null) {
      throw new ApiException(400, "Missing required param: file");
    }

    // create path and map variables
    String path =
        "/api/services/app/Upload/UploadAudio".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["multipart/form-data"];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (file != null) {
        hasFields = true;
        mp.fields['file'] = file.field;
        mp.files.add(file);
      }

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'FileDto') as FileDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<FileDto> apiServicesAppUploadUploadImagePost(
      MultipartFile file) async {
    Object postBody = null;

    // verify required params are set
    if (file == null) {
      throw new ApiException(400, "Missing required param: file");
    }

    // create path and map variables
    String path =
        "/api/services/app/Upload/UploadImage".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["multipart/form-data"];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (file != null) {
        hasFields = true;
        mp.fields['file'] = file.field;
        mp.files.add(file);
      }

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'FileDto') as FileDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<FileDto> apiServicesAppUploadUploadImageWithThumbnailPost(
      MultipartFile file) async {
    Object postBody = null;

    // verify required params are set
    if (file == null) {
      throw new ApiException(400, "Missing required param: file");
    }

    // create path and map variables
    String path = "/api/services/app/Upload/UploadImageWithThumbnail"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["multipart/form-data"];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (file != null) {
        hasFields = true;
        mp.fields['file'] = file.field;
        mp.files.add(file);
      }

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'FileDto') as FileDto;
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<FileDto> apiServicesAppUploadUploadRestaurantFilePost(
      MultipartFile file) async {
    Object postBody = null;

    // verify required params are set
    if (file == null) {
      throw new ApiException(400, "Missing required param: file");
    }

    // create path and map variables
    String path = "/api/services/app/Upload/UploadRestaurantFile"
        .replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["multipart/form-data"];

    String contentType =
        contentTypes.length > 0 ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = new MultipartRequest(null, null);

      if (file != null) {
        hasFields = true;
        mp.fields['file'] = file.field;
        mp.files.add(file);
      }

      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);

    if (response.statusCode >= 400) {
      throw new ApiException(response.statusCode, response.body);
    } else if (response.body != null) {
      return apiClient.deserialize(response.body, 'FileDto') as FileDto;
    } else {
      return null;
    }
  }
}
