# swagger.api.AdminRestaurantApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppAdminRestaurantChangeStatusPost**](AdminRestaurantApi.md#apiServicesAppAdminRestaurantChangeStatusPost) | **POST** /api/services/app/Admin/Restaurant/ChangeStatus | 
[**apiServicesAppAdminRestaurantCreatePost**](AdminRestaurantApi.md#apiServicesAppAdminRestaurantCreatePost) | **POST** /api/services/app/Admin/Restaurant/Create | 
[**apiServicesAppAdminRestaurantGetAllGet**](AdminRestaurantApi.md#apiServicesAppAdminRestaurantGetAllGet) | **GET** /api/services/app/Admin/Restaurant/GetAll | 
[**apiServicesAppAdminRestaurantGetByIdGet**](AdminRestaurantApi.md#apiServicesAppAdminRestaurantGetByIdGet) | **GET** /api/services/app/Admin/Restaurant/GetById | 
[**apiServicesAppAdminRestaurantUpdateIsFeaturedPost**](AdminRestaurantApi.md#apiServicesAppAdminRestaurantUpdateIsFeaturedPost) | **POST** /api/services/app/Admin/Restaurant/UpdateIsFeatured | 


# **apiServicesAppAdminRestaurantChangeStatusPost**
> apiServicesAppAdminRestaurantChangeStatusPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminRestaurantApi();
var input = new ChangeStatusDto(); // ChangeStatusDto | 

try { 
    api_instance.apiServicesAppAdminRestaurantChangeStatusPost(input);
} catch (e) {
    print("Exception when calling AdminRestaurantApi->apiServicesAppAdminRestaurantChangeStatusPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**ChangeStatusDto**](ChangeStatusDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppAdminRestaurantCreatePost**
> apiServicesAppAdminRestaurantCreatePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminRestaurantApi();
var input = new CreateRestaurantDto(); // CreateRestaurantDto | 

try { 
    api_instance.apiServicesAppAdminRestaurantCreatePost(input);
} catch (e) {
    print("Exception when calling AdminRestaurantApi->apiServicesAppAdminRestaurantCreatePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**CreateRestaurantDto**](CreateRestaurantDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppAdminRestaurantGetAllGet**
> PagedResultDtoRestaurantDto apiServicesAppAdminRestaurantGetAllGet(maxResultCount, skipCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminRestaurantApi();
var maxResultCount = 56; // int | 
var skipCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppAdminRestaurantGetAllGet(maxResultCount, skipCount);
    print(result);
} catch (e) {
    print("Exception when calling AdminRestaurantApi->apiServicesAppAdminRestaurantGetAllGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **maxResultCount** | **int**|  | [optional] 
 **skipCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoRestaurantDto**](PagedResultDtoRestaurantDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppAdminRestaurantGetByIdGet**
> RestaurantDto apiServicesAppAdminRestaurantGetByIdGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminRestaurantApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppAdminRestaurantGetByIdGet(id);
    print(result);
} catch (e) {
    print("Exception when calling AdminRestaurantApi->apiServicesAppAdminRestaurantGetByIdGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**RestaurantDto**](RestaurantDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppAdminRestaurantUpdateIsFeaturedPost**
> apiServicesAppAdminRestaurantUpdateIsFeaturedPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminRestaurantApi();
var input = new UpdateIsFeaturedDto(); // UpdateIsFeaturedDto | 

try { 
    api_instance.apiServicesAppAdminRestaurantUpdateIsFeaturedPost(input);
} catch (e) {
    print("Exception when calling AdminRestaurantApi->apiServicesAppAdminRestaurantUpdateIsFeaturedPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**UpdateIsFeaturedDto**](UpdateIsFeaturedDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

