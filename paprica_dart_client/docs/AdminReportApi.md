# swagger.api.AdminReportApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppAdminReportGetAllCustomerReportGet**](AdminReportApi.md#apiServicesAppAdminReportGetAllCustomerReportGet) | **GET** /api/services/app/Admin/Report/GetAllCustomerReport | 
[**apiServicesAppAdminReportGetAllRestaurantReportGet**](AdminReportApi.md#apiServicesAppAdminReportGetAllRestaurantReportGet) | **GET** /api/services/app/Admin/Report/GetAllRestaurantReport | 
[**apiServicesAppAdminReportGetCustomerReportGet**](AdminReportApi.md#apiServicesAppAdminReportGetCustomerReportGet) | **GET** /api/services/app/Admin/Report/GetCustomerReport | 
[**apiServicesAppAdminReportGetRestaurantReportGet**](AdminReportApi.md#apiServicesAppAdminReportGetRestaurantReportGet) | **GET** /api/services/app/Admin/Report/GetRestaurantReport | 


# **apiServicesAppAdminReportGetAllCustomerReportGet**
> PagedResultDtoReportDto apiServicesAppAdminReportGetAllCustomerReportGet(sorting, skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminReportApi();
var sorting = sorting_example; // String | 
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppAdminReportGetAllCustomerReportGet(sorting, skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling AdminReportApi->apiServicesAppAdminReportGetAllCustomerReportGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sorting** | **String**|  | [optional] 
 **skipCount** | **int**|  | [optional] 
 **maxResultCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoReportDto**](PagedResultDtoReportDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppAdminReportGetAllRestaurantReportGet**
> PagedResultDtoReportDto apiServicesAppAdminReportGetAllRestaurantReportGet(sorting, skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminReportApi();
var sorting = sorting_example; // String | 
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppAdminReportGetAllRestaurantReportGet(sorting, skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling AdminReportApi->apiServicesAppAdminReportGetAllRestaurantReportGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sorting** | **String**|  | [optional] 
 **skipCount** | **int**|  | [optional] 
 **maxResultCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoReportDto**](PagedResultDtoReportDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppAdminReportGetCustomerReportGet**
> ReportDto apiServicesAppAdminReportGetCustomerReportGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminReportApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppAdminReportGetCustomerReportGet(id);
    print(result);
} catch (e) {
    print("Exception when calling AdminReportApi->apiServicesAppAdminReportGetCustomerReportGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**ReportDto**](ReportDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppAdminReportGetRestaurantReportGet**
> ReportDto apiServicesAppAdminReportGetRestaurantReportGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminReportApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppAdminReportGetRestaurantReportGet(id);
    print(result);
} catch (e) {
    print("Exception when calling AdminReportApi->apiServicesAppAdminReportGetRestaurantReportGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**ReportDto**](ReportDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

