# swagger.api.CustomerPlaylistApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost/Inside.Api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAppCustomerPlaylistPlaylistTracksPlaylistIdGet**](CustomerPlaylistApi.md#apiAppCustomerPlaylistPlaylistTracksPlaylistIdGet) | **GET** /api/app/customer-playlist/playlist-tracks/{playlistId} | 
[**apiAppCustomerPlaylistPlaylistsGet**](CustomerPlaylistApi.md#apiAppCustomerPlaylistPlaylistsGet) | **GET** /api/app/customer-playlist/playlists | 
[**apiAppCustomerPlaylistRequestTrackPost**](CustomerPlaylistApi.md#apiAppCustomerPlaylistRequestTrackPost) | **POST** /api/app/customer-playlist/request-track | 


# **apiAppCustomerPlaylistPlaylistTracksPlaylistIdGet**
> List<SoftUpPaprikaInsidePlaylistsTrackDto> apiAppCustomerPlaylistPlaylistTracksPlaylistIdGet(playlistId)



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerPlaylistApi();
var playlistId = ; // String | 

try { 
    var result = api_instance.apiAppCustomerPlaylistPlaylistTracksPlaylistIdGet(playlistId);
    print(result);
} catch (e) {
    print("Exception when calling CustomerPlaylistApi->apiAppCustomerPlaylistPlaylistTracksPlaylistIdGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **playlistId** | [**String**](.md)|  | 

### Return type

[**List<SoftUpPaprikaInsidePlaylistsTrackDto>**](SoftUpPaprikaInsidePlaylistsTrackDto.md)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAppCustomerPlaylistPlaylistsGet**
> List<SoftUpPaprikaInsidePlaylistsPlaylistDto> apiAppCustomerPlaylistPlaylistsGet()



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerPlaylistApi();

try { 
    var result = api_instance.apiAppCustomerPlaylistPlaylistsGet();
    print(result);
} catch (e) {
    print("Exception when calling CustomerPlaylistApi->apiAppCustomerPlaylistPlaylistsGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<SoftUpPaprikaInsidePlaylistsPlaylistDto>**](SoftUpPaprikaInsidePlaylistsPlaylistDto.md)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAppCustomerPlaylistRequestTrackPost**
> apiAppCustomerPlaylistRequestTrackPost(body)



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerPlaylistApi();
var body = new SoftUpPaprikaInsidePlaylistsTrackRequestDto(); // SoftUpPaprikaInsidePlaylistsTrackRequestDto | 

try { 
    api_instance.apiAppCustomerPlaylistRequestTrackPost(body);
} catch (e) {
    print("Exception when calling CustomerPlaylistApi->apiAppCustomerPlaylistRequestTrackPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**SoftUpPaprikaInsidePlaylistsTrackRequestDto**](SoftUpPaprikaInsidePlaylistsTrackRequestDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

