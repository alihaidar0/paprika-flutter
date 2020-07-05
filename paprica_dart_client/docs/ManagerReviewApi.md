# swagger.api.ManagerReviewApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppManagerReviewGetAllGet**](ManagerReviewApi.md#apiServicesAppManagerReviewGetAllGet) | **GET** /api/services/app/Manager/Review/GetAll | 


# **apiServicesAppManagerReviewGetAllGet**
> PagedResultDtoReviewDto apiServicesAppManagerReviewGetAllGet(restaurantId, skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerReviewApi();
var restaurantId = 789; // int | 
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppManagerReviewGetAllGet(restaurantId, skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling ManagerReviewApi->apiServicesAppManagerReviewGetAllGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **restaurantId** | **int**|  | [optional] 
 **skipCount** | **int**|  | [optional] 
 **maxResultCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoReviewDto**](PagedResultDtoReviewDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

