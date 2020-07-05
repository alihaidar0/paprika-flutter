# swagger.api.AdminCustomerApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppAdminCustomerGetAllGet**](AdminCustomerApi.md#apiServicesAppAdminCustomerGetAllGet) | **GET** /api/services/app/Admin/Customer/GetAll | 
[**apiServicesAppAdminCustomerGetByIdGet**](AdminCustomerApi.md#apiServicesAppAdminCustomerGetByIdGet) | **GET** /api/services/app/Admin/Customer/GetById | 
[**apiServicesAppAdminCustomerUpdateActivationStatusPost**](AdminCustomerApi.md#apiServicesAppAdminCustomerUpdateActivationStatusPost) | **POST** /api/services/app/Admin/Customer/UpdateActivationStatus | 


# **apiServicesAppAdminCustomerGetAllGet**
> PagedResultDtoCustomerDto apiServicesAppAdminCustomerGetAllGet(sorting, skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminCustomerApi();
var sorting = sorting_example; // String | 
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppAdminCustomerGetAllGet(sorting, skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling AdminCustomerApi->apiServicesAppAdminCustomerGetAllGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sorting** | **String**|  | [optional] 
 **skipCount** | **int**|  | [optional] 
 **maxResultCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoCustomerDto**](PagedResultDtoCustomerDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppAdminCustomerGetByIdGet**
> CustomerDto apiServicesAppAdminCustomerGetByIdGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminCustomerApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppAdminCustomerGetByIdGet(id);
    print(result);
} catch (e) {
    print("Exception when calling AdminCustomerApi->apiServicesAppAdminCustomerGetByIdGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**CustomerDto**](CustomerDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppAdminCustomerUpdateActivationStatusPost**
> apiServicesAppAdminCustomerUpdateActivationStatusPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminCustomerApi();
var input = new UpdateActivationStatusDto(); // UpdateActivationStatusDto | 

try { 
    api_instance.apiServicesAppAdminCustomerUpdateActivationStatusPost(input);
} catch (e) {
    print("Exception when calling AdminCustomerApi->apiServicesAppAdminCustomerUpdateActivationStatusPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**UpdateActivationStatusDto**](UpdateActivationStatusDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

