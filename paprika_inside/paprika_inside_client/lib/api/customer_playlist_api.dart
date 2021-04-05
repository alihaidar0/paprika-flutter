part of swagger_inside.api;

class CustomerPlaylistApi {
  final ApiClient apiClient;

  CustomerPlaylistApi([ApiClient apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  ///
  ///
  ///
  Future<List<PlaylistsTrackDto>>
      apiAppCustomerPlaylistPlaylistTracksPlaylistIdGet(
          String playlistId) async {
    Object postBody = null;

    // verify required params are set
    if (playlistId == null) {
      throw new ApiException(400, "Missing required param: playlistId");
    }

    // create path and map variables
    String path = "/api/app/customer-playlist/playlist-tracks/{playlistId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "playlistId" + "}", playlistId.toString());

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
      return (apiClient.deserialize(response.body, 'List<PlaylistsTrackDto>')
              as List)
          .map((item) => item as PlaylistsTrackDto)
          .toList();
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future<List<PlaylistsPlaylistDto>>
      apiAppCustomerPlaylistPlaylistsGet() async {
    Object postBody = null;

    // verify required params are set

    // create path and map variables
    String path =
        "/api/app/customer-playlist/playlists".replaceAll("{format}", "json");

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
      return (apiClient.deserialize(response.body, 'List<PlaylistsPlaylistDto>')
              as List)
          .map((item) => item as PlaylistsPlaylistDto)
          .toList();
    } else {
      return null;
    }
  }

  ///
  ///
  ///
  Future apiAppCustomerPlaylistRequestTrackPost(
      {PlaylistsTrackRequestDto body}) async {
    Object postBody = body;

    // verify required params are set

    // create path and map variables
    String path = "/api/app/customer-playlist/request-track"
        .replaceAll("{format}", "json");

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
}
