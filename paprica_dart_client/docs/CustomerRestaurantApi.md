# swagger.api.CustomerRestaurantApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppCustomerRestaurantAddFavoriteRestaurantPost**](CustomerRestaurantApi.md#apiServicesAppCustomerRestaurantAddFavoriteRestaurantPost) | **POST** /api/services/app/Customer/Restaurant/AddFavoriteRestaurant | 
[**apiServicesAppCustomerRestaurantGetAllGet**](CustomerRestaurantApi.md#apiServicesAppCustomerRestaurantGetAllGet) | **GET** /api/services/app/Customer/Restaurant/GetAll | 
[**apiServicesAppCustomerRestaurantGetFavoriteRestaurantsGet**](CustomerRestaurantApi.md#apiServicesAppCustomerRestaurantGetFavoriteRestaurantsGet) | **GET** /api/services/app/Customer/Restaurant/GetFavoriteRestaurants | 
[**apiServicesAppCustomerRestaurantGetGet**](CustomerRestaurantApi.md#apiServicesAppCustomerRestaurantGetGet) | **GET** /api/services/app/Customer/Restaurant/Get | 
[**apiServicesAppCustomerRestaurantRemoveFavoriteRestaurantPost**](CustomerRestaurantApi.md#apiServicesAppCustomerRestaurantRemoveFavoriteRestaurantPost) | **POST** /api/services/app/Customer/Restaurant/RemoveFavoriteRestaurant | 


# **apiServicesAppCustomerRestaurantAddFavoriteRestaurantPost**
> apiServicesAppCustomerRestaurantAddFavoriteRestaurantPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerRestaurantApi();
var input = new AddFavoriteRestaurantDto(); // AddFavoriteRestaurantDto | 

try { 
    api_instance.apiServicesAppCustomerRestaurantAddFavoriteRestaurantPost(input);
} catch (e) {
    print("Exception when calling CustomerRestaurantApi->apiServicesAppCustomerRestaurantAddFavoriteRestaurantPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**AddFavoriteRestaurantDto**](AddFavoriteRestaurantDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerRestaurantGetAllGet**
> PagedResultDtoRestaurantSummaryDto apiServicesAppCustomerRestaurantGetAllGet(skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerRestaurantApi();
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppCustomerRestaurantGetAllGet(skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling CustomerRestaurantApi->apiServicesAppCustomerRestaurantGetAllGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **skipCount** | **int**|  | [optional] 
 **maxResultCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoRestaurantSummaryDto**](PagedResultDtoRestaurantSummaryDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerRestaurantGetFavoriteRestaurantsGet**
> PagedResultDtoRestaurantDto apiServicesAppCustomerRestaurantGetFavoriteRestaurantsGet(maxResultCount, skipCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerRestaurantApi();
var maxResultCount = 56; // int | 
var skipCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppCustomerRestaurantGetFavoriteRestaurantsGet(maxResultCount, skipCount);
    print(result);
} catch (e) {
    print("Exception when calling CustomerRestaurantApi->apiServicesAppCustomerRestaurantGetFavoriteRestaurantsGet: $e\n");
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

# **apiServicesAppCustomerRestaurantGetGet**
> RestaurantHomeDto apiServicesAppCustomerRestaurantGetGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerRestaurantApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppCustomerRestaurantGetGet(id);
    print(result);
} catch (e) {
    print("Exception when calling CustomerRestaurantApi->apiServicesAppCustomerRestaurantGetGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**RestaurantHomeDto**](RestaurantHomeDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerRestaurantRemoveFavoriteRestaurantPost**
> apiServicesAppCustomerRestaurantRemoveFavoriteRestaurantPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerRestaurantApi();
var input = new AddFavoriteRestaurantDto(); // AddFavoriteRestaurantDto | 

try { 
    api_instance.apiServicesAppCustomerRestaurantRemoveFavoriteRestaurantPost(input);
} catch (e) {
    print("Exception when calling CustomerRestaurantApi->apiServicesAppCustomerRestaurantRemoveFavoriteRestaurantPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**AddFavoriteRestaurantDto**](AddFavoriteRestaurantDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

