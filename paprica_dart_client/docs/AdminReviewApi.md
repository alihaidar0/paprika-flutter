# swagger.api.AdminReviewApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppAdminReviewGetAllGet**](AdminReviewApi.md#apiServicesAppAdminReviewGetAllGet) | **GET** /api/services/app/Admin/Review/GetAll | 
[**apiServicesAppAdminReviewUpdateStatusPost**](AdminReviewApi.md#apiServicesAppAdminReviewUpdateStatusPost) | **POST** /api/services/app/Admin/Review/UpdateStatus | 


# **apiServicesAppAdminReviewGetAllGet**
> PagedResultDtoReviewDto apiServicesAppAdminReviewGetAllGet(restaurantId, skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminReviewApi();
var restaurantId = 789; // int | 
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppAdminReviewGetAllGet(restaurantId, skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling AdminReviewApi->apiServicesAppAdminReviewGetAllGet: $e\n");
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

# **apiServicesAppAdminReviewUpdateStatusPost**
> apiServicesAppAdminReviewUpdateStatusPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminReviewApi();
var input = new UpdateReviewStatusDto(); // UpdateReviewStatusDto | 

try { 
    api_instance.apiServicesAppAdminReviewUpdateStatusPost(input);
} catch (e) {
    print("Exception when calling AdminReviewApi->apiServicesAppAdminReviewUpdateStatusPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**UpdateReviewStatusDto**](UpdateReviewStatusDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

