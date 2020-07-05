# swagger.api.TenantApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppTenantCreatePost**](TenantApi.md#apiServicesAppTenantCreatePost) | **POST** /api/services/app/Tenant/Create | 
[**apiServicesAppTenantDeleteDelete**](TenantApi.md#apiServicesAppTenantDeleteDelete) | **DELETE** /api/services/app/Tenant/Delete | 
[**apiServicesAppTenantGetAllGet**](TenantApi.md#apiServicesAppTenantGetAllGet) | **GET** /api/services/app/Tenant/GetAll | 
[**apiServicesAppTenantGetGet**](TenantApi.md#apiServicesAppTenantGetGet) | **GET** /api/services/app/Tenant/Get | 
[**apiServicesAppTenantUpdatePut**](TenantApi.md#apiServicesAppTenantUpdatePut) | **PUT** /api/services/app/Tenant/Update | 


# **apiServicesAppTenantCreatePost**
> TenantDto apiServicesAppTenantCreatePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new TenantApi();
var input = new CreateTenantDto(); // CreateTenantDto | 

try { 
    var result = api_instance.apiServicesAppTenantCreatePost(input);
    print(result);
} catch (e) {
    print("Exception when calling TenantApi->apiServicesAppTenantCreatePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**CreateTenantDto**](CreateTenantDto.md)|  | [optional] 

### Return type

[**TenantDto**](TenantDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppTenantDeleteDelete**
> apiServicesAppTenantDeleteDelete(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new TenantApi();
var id = 56; // int | 

try { 
    api_instance.apiServicesAppTenantDeleteDelete(id);
} catch (e) {
    print("Exception when calling TenantApi->apiServicesAppTenantDeleteDelete: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppTenantGetAllGet**
> PagedResultDtoTenantDto apiServicesAppTenantGetAllGet(keyword, isActive, skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new TenantApi();
var keyword = keyword_example; // String | 
var isActive = true; // bool | 
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppTenantGetAllGet(keyword, isActive, skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling TenantApi->apiServicesAppTenantGetAllGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**|  | [optional] 
 **isActive** | **bool**|  | [optional] 
 **skipCount** | **int**|  | [optional] 
 **maxResultCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoTenantDto**](PagedResultDtoTenantDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppTenantGetGet**
> TenantDto apiServicesAppTenantGetGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new TenantApi();
var id = 56; // int | 

try { 
    var result = api_instance.apiServicesAppTenantGetGet(id);
    print(result);
} catch (e) {
    print("Exception when calling TenantApi->apiServicesAppTenantGetGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**TenantDto**](TenantDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppTenantUpdatePut**
> TenantDto apiServicesAppTenantUpdatePut(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new TenantApi();
var input = new TenantDto(); // TenantDto | 

try { 
    var result = api_instance.apiServicesAppTenantUpdatePut(input);
    print(result);
} catch (e) {
    print("Exception when calling TenantApi->apiServicesAppTenantUpdatePut: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**TenantDto**](TenantDto.md)|  | [optional] 

### Return type

[**TenantDto**](TenantDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

