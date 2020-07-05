# swagger.api.CustomerReviewApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppCustomerReviewCreateOrUpdatePost**](CustomerReviewApi.md#apiServicesAppCustomerReviewCreateOrUpdatePost) | **POST** /api/services/app/Customer/Review/CreateOrUpdate | 
[**apiServicesAppCustomerReviewGetOldGet**](CustomerReviewApi.md#apiServicesAppCustomerReviewGetOldGet) | **GET** /api/services/app/Customer/Review/GetOld | 
[**apiServicesAppCustomerReviewGetRestaurantReviewsSummaryGet**](CustomerReviewApi.md#apiServicesAppCustomerReviewGetRestaurantReviewsSummaryGet) | **GET** /api/services/app/Customer/Review/GetRestaurantReviewsSummary | 


# **apiServicesAppCustomerReviewCreateOrUpdatePost**
> apiServicesAppCustomerReviewCreateOrUpdatePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerReviewApi();
var input = new CreateOrUpdateReviewDto(); // CreateOrUpdateReviewDto | 

try { 
    api_instance.apiServicesAppCustomerReviewCreateOrUpdatePost(input);
} catch (e) {
    print("Exception when calling CustomerReviewApi->apiServicesAppCustomerReviewCreateOrUpdatePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**CreateOrUpdateReviewDto**](CreateOrUpdateReviewDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerReviewGetOldGet**
> PagedResultDtoReviewDto apiServicesAppCustomerReviewGetOldGet(restaurantId, skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerReviewApi();
var restaurantId = 789; // int | 
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppCustomerReviewGetOldGet(restaurantId, skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling CustomerReviewApi->apiServicesAppCustomerReviewGetOldGet: $e\n");
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

# **apiServicesAppCustomerReviewGetRestaurantReviewsSummaryGet**
> RestaurantReviewsSummaryDto apiServicesAppCustomerReviewGetRestaurantReviewsSummaryGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerReviewApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppCustomerReviewGetRestaurantReviewsSummaryGet(id);
    print(result);
} catch (e) {
    print("Exception when calling CustomerReviewApi->apiServicesAppCustomerReviewGetRestaurantReviewsSummaryGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**RestaurantReviewsSummaryDto**](RestaurantReviewsSummaryDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

