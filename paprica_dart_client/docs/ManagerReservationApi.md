# swagger.api.ManagerReservationApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppManagerReservationApproveReservationPost**](ManagerReservationApi.md#apiServicesAppManagerReservationApproveReservationPost) | **POST** /api/services/app/Manager/Reservation/ApproveReservation | 
[**apiServicesAppManagerReservationGetAllGet**](ManagerReservationApi.md#apiServicesAppManagerReservationGetAllGet) | **GET** /api/services/app/Manager/Reservation/GetAll | 
[**apiServicesAppManagerReservationGetGet**](ManagerReservationApi.md#apiServicesAppManagerReservationGetGet) | **GET** /api/services/app/Manager/Reservation/Get | 


# **apiServicesAppManagerReservationApproveReservationPost**
> apiServicesAppManagerReservationApproveReservationPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerReservationApi();
var input = new EntityDtoInt64(); // EntityDtoInt64 |

try { 
    api_instance.apiServicesAppManagerReservationApproveReservationPost(input);
} catch (e) {
    print("Exception when calling ManagerReservationApi->apiServicesAppManagerReservationApproveReservationPost: $e\n");
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

# **apiServicesAppManagerReservationGetAllGet**
> PagedResultDtoReservationDto apiServicesAppManagerReservationGetAllGet(skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerReservationApi();
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppManagerReservationGetAllGet(skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling ManagerReservationApi->apiServicesAppManagerReservationGetAllGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **skipCount** | **int**|  | [optional] 
 **maxResultCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoReservationDto**](PagedResultDtoReservationDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerReservationGetGet**
> ReservationDto apiServicesAppManagerReservationGetGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerReservationApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppManagerReservationGetGet(id);
    print(result);
} catch (e) {
    print("Exception when calling ManagerReservationApi->apiServicesAppManagerReservationGetGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**ReservationDto**](ReservationDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

