# swagger.api.UploadApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppUploadAntdUploadImagePost**](UploadApi.md#apiServicesAppUploadAntdUploadImagePost) | **POST** /api/services/app/Upload/AntdUploadImage | 
[**apiServicesAppUploadUploadImageWithThumbnailPost**](UploadApi.md#apiServicesAppUploadUploadImageWithThumbnailPost) | **POST** /api/services/app/Upload/UploadImageWithThumbnail | 
[**apiServicesAppUploadUploadPost**](UploadApi.md#apiServicesAppUploadUploadPost) | **POST** /api/services/app/Upload/Upload | 


# **apiServicesAppUploadAntdUploadImagePost**
> AntdImageDto apiServicesAppUploadAntdUploadImagePost(file)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UploadApi();
var file = /path/to/file.txt; // MultipartFile | A file to upload

try { 
    var result = api_instance.apiServicesAppUploadAntdUploadImagePost(file);
    print(result);
} catch (e) {
    print("Exception when calling UploadApi->apiServicesAppUploadAntdUploadImagePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**| A file to upload | 

### Return type

[**AntdImageDto**](AntdImageDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppUploadUploadImageWithThumbnailPost**
> FileDto apiServicesAppUploadUploadImageWithThumbnailPost(file)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UploadApi();
var file = /path/to/file.txt; // MultipartFile | A file to upload

try { 
    var result = api_instance.apiServicesAppUploadUploadImageWithThumbnailPost(file);
    print(result);
} catch (e) {
    print("Exception when calling UploadApi->apiServicesAppUploadUploadImageWithThumbnailPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**| A file to upload | 

### Return type

[**FileDto**](FileDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppUploadUploadPost**
> FileDto apiServicesAppUploadUploadPost(file)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UploadApi();
var file = /path/to/file.txt; // MultipartFile | A file to upload

try { 
    var result = api_instance.apiServicesAppUploadUploadPost(file);
    print(result);
} catch (e) {
    print("Exception when calling UploadApi->apiServicesAppUploadUploadPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**| A file to upload | 

### Return type

[**FileDto**](FileDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

