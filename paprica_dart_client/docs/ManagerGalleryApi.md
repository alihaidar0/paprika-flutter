# swagger.api.ManagerGalleryApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppManagerGalleryCreatePost**](ManagerGalleryApi.md#apiServicesAppManagerGalleryCreatePost) | **POST** /api/services/app/Manager/Gallery/Create | 
[**apiServicesAppManagerGalleryDeleteGalleryItemPost**](ManagerGalleryApi.md#apiServicesAppManagerGalleryDeleteGalleryItemPost) | **POST** /api/services/app/Manager/Gallery/DeleteGalleryItem | 
[**apiServicesAppManagerGalleryGetAllGalleryItemsGet**](ManagerGalleryApi.md#apiServicesAppManagerGalleryGetAllGalleryItemsGet) | **GET** /api/services/app/Manager/Gallery/GetAllGalleryItems | 
[**apiServicesAppManagerGalleryUpdateGalleryItemPost**](ManagerGalleryApi.md#apiServicesAppManagerGalleryUpdateGalleryItemPost) | **POST** /api/services/app/Manager/Gallery/UpdateGalleryItem | 


# **apiServicesAppManagerGalleryCreatePost**
> GalleryDto apiServicesAppManagerGalleryCreatePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerGalleryApi();
var input = new CreateGalleryDto(); // CreateGalleryDto | 

try { 
    var result = api_instance.apiServicesAppManagerGalleryCreatePost(input);
    print(result);
} catch (e) {
    print("Exception when calling ManagerGalleryApi->apiServicesAppManagerGalleryCreatePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**CreateGalleryDto**](CreateGalleryDto.md)|  | [optional] 

### Return type

[**GalleryDto**](GalleryDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerGalleryDeleteGalleryItemPost**
> apiServicesAppManagerGalleryDeleteGalleryItemPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerGalleryApi();
var input = new EntityDtoInt64(); // EntityDtoInt64 |

try { 
    api_instance.apiServicesAppManagerGalleryDeleteGalleryItemPost(input);
} catch (e) {
    print("Exception when calling ManagerGalleryApi->apiServicesAppManagerGalleryDeleteGalleryItemPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**EntityDtoInt64**](EntityDtoInt64.md)|  | [optional]

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerGalleryGetAllGalleryItemsGet**
> PagedResultDtoGalleryItemDto apiServicesAppManagerGalleryGetAllGalleryItemsGet(maxResultCount, skipCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerGalleryApi();
var maxResultCount = 56; // int | 
var skipCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppManagerGalleryGetAllGalleryItemsGet(maxResultCount, skipCount);
    print(result);
} catch (e) {
    print("Exception when calling ManagerGalleryApi->apiServicesAppManagerGalleryGetAllGalleryItemsGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **maxResultCount** | **int**|  | [optional] 
 **skipCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoGalleryItemDto**](PagedResultDtoGalleryItemDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerGalleryUpdateGalleryItemPost**
> GalleryItemDto apiServicesAppManagerGalleryUpdateGalleryItemPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerGalleryApi();
var input = new GalleryItemDto(); // GalleryItemDto | 

try { 
    var result = api_instance.apiServicesAppManagerGalleryUpdateGalleryItemPost(input);
    print(result);
} catch (e) {
    print("Exception when calling ManagerGalleryApi->apiServicesAppManagerGalleryUpdateGalleryItemPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**GalleryItemDto**](GalleryItemDto.md)|  | [optional] 

### Return type

[**GalleryItemDto**](GalleryItemDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

