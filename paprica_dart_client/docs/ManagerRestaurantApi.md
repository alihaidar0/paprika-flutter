# swagger.api.ManagerRestaurantApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppManagerRestaurantAddRegularCustomerPost**](ManagerRestaurantApi.md#apiServicesAppManagerRestaurantAddRegularCustomerPost) | **POST** /api/services/app/Manager/Restaurant/AddRegularCustomer | 
[**apiServicesAppManagerRestaurantChangeFreeSpaceIndicatorPost**](ManagerRestaurantApi.md#apiServicesAppManagerRestaurantChangeFreeSpaceIndicatorPost) | **POST** /api/services/app/Manager/Restaurant/ChangeFreeSpaceIndicator | 
[**apiServicesAppManagerRestaurantGetOpeningTimesGet**](ManagerRestaurantApi.md#apiServicesAppManagerRestaurantGetOpeningTimesGet) | **GET** /api/services/app/Manager/Restaurant/GetOpeningTimes | 
[**apiServicesAppManagerRestaurantGetRegularCustomersGet**](ManagerRestaurantApi.md#apiServicesAppManagerRestaurantGetRegularCustomersGet) | **GET** /api/services/app/Manager/Restaurant/GetRegularCustomers | 
[**apiServicesAppManagerRestaurantRemoveRegularCustomerPost**](ManagerRestaurantApi.md#apiServicesAppManagerRestaurantRemoveRegularCustomerPost) | **POST** /api/services/app/Manager/Restaurant/RemoveRegularCustomer | 
[**apiServicesAppManagerRestaurantUpdateAudioTrackNamePost**](ManagerRestaurantApi.md#apiServicesAppManagerRestaurantUpdateAudioTrackNamePost) | **POST** /api/services/app/Manager/Restaurant/UpdateAudioTrackName | 
[**apiServicesAppManagerRestaurantUpdateCoverImageNamePost**](ManagerRestaurantApi.md#apiServicesAppManagerRestaurantUpdateCoverImageNamePost) | **POST** /api/services/app/Manager/Restaurant/UpdateCoverImageName | 
[**apiServicesAppManagerRestaurantUpdateImageNamePost**](ManagerRestaurantApi.md#apiServicesAppManagerRestaurantUpdateImageNamePost) | **POST** /api/services/app/Manager/Restaurant/UpdateImageName | 
[**apiServicesAppManagerRestaurantUpdateOpeningTimesPost**](ManagerRestaurantApi.md#apiServicesAppManagerRestaurantUpdateOpeningTimesPost) | **POST** /api/services/app/Manager/Restaurant/UpdateOpeningTimes | 
[**apiServicesAppManagerRestaurantUpdateProfilePost**](ManagerRestaurantApi.md#apiServicesAppManagerRestaurantUpdateProfilePost) | **POST** /api/services/app/Manager/Restaurant/UpdateProfile | 


# **apiServicesAppManagerRestaurantAddRegularCustomerPost**
> apiServicesAppManagerRestaurantAddRegularCustomerPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerRestaurantApi();
var input = new AddRegularCustomerDto(); // AddRegularCustomerDto | 

try { 
    api_instance.apiServicesAppManagerRestaurantAddRegularCustomerPost(input);
} catch (e) {
    print("Exception when calling ManagerRestaurantApi->apiServicesAppManagerRestaurantAddRegularCustomerPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**AddRegularCustomerDto**](AddRegularCustomerDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerRestaurantChangeFreeSpaceIndicatorPost**
> apiServicesAppManagerRestaurantChangeFreeSpaceIndicatorPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerRestaurantApi();
var input = new ChangeFreeSpaceIndicator(); // ChangeFreeSpaceIndicator | 

try { 
    api_instance.apiServicesAppManagerRestaurantChangeFreeSpaceIndicatorPost(input);
} catch (e) {
    print("Exception when calling ManagerRestaurantApi->apiServicesAppManagerRestaurantChangeFreeSpaceIndicatorPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**ChangeFreeSpaceIndicator**](ChangeFreeSpaceIndicator.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerRestaurantGetOpeningTimesGet**
> List<OpeningTimeDto> apiServicesAppManagerRestaurantGetOpeningTimesGet()



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerRestaurantApi();

try { 
    var result = api_instance.apiServicesAppManagerRestaurantGetOpeningTimesGet();
    print(result);
} catch (e) {
    print("Exception when calling ManagerRestaurantApi->apiServicesAppManagerRestaurantGetOpeningTimesGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<OpeningTimeDto>**](OpeningTimeDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerRestaurantGetRegularCustomersGet**
> PagedResultDtoCustomerDto apiServicesAppManagerRestaurantGetRegularCustomersGet(maxResultCount, skipCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerRestaurantApi();
var maxResultCount = 56; // int | 
var skipCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppManagerRestaurantGetRegularCustomersGet(maxResultCount, skipCount);
    print(result);
} catch (e) {
    print("Exception when calling ManagerRestaurantApi->apiServicesAppManagerRestaurantGetRegularCustomersGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **maxResultCount** | **int**|  | [optional] 
 **skipCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoCustomerDto**](PagedResultDtoCustomerDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerRestaurantRemoveRegularCustomerPost**
> apiServicesAppManagerRestaurantRemoveRegularCustomerPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerRestaurantApi();
var input = new AddRegularCustomerDto(); // AddRegularCustomerDto | 

try { 
    api_instance.apiServicesAppManagerRestaurantRemoveRegularCustomerPost(input);
} catch (e) {
    print("Exception when calling ManagerRestaurantApi->apiServicesAppManagerRestaurantRemoveRegularCustomerPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**AddRegularCustomerDto**](AddRegularCustomerDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerRestaurantUpdateAudioTrackNamePost**
> apiServicesAppManagerRestaurantUpdateAudioTrackNamePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerRestaurantApi();
var input = new MediaDto(); // MediaDto | 

try { 
    api_instance.apiServicesAppManagerRestaurantUpdateAudioTrackNamePost(input);
} catch (e) {
    print("Exception when calling ManagerRestaurantApi->apiServicesAppManagerRestaurantUpdateAudioTrackNamePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**MediaDto**](MediaDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerRestaurantUpdateCoverImageNamePost**
> apiServicesAppManagerRestaurantUpdateCoverImageNamePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerRestaurantApi();
var input = new MediaDto(); // MediaDto | 

try { 
    api_instance.apiServicesAppManagerRestaurantUpdateCoverImageNamePost(input);
} catch (e) {
    print("Exception when calling ManagerRestaurantApi->apiServicesAppManagerRestaurantUpdateCoverImageNamePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**MediaDto**](MediaDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerRestaurantUpdateImageNamePost**
> apiServicesAppManagerRestaurantUpdateImageNamePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerRestaurantApi();
var input = new MediaDto(); // MediaDto | 

try { 
    api_instance.apiServicesAppManagerRestaurantUpdateImageNamePost(input);
} catch (e) {
    print("Exception when calling ManagerRestaurantApi->apiServicesAppManagerRestaurantUpdateImageNamePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**MediaDto**](MediaDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerRestaurantUpdateOpeningTimesPost**
> apiServicesAppManagerRestaurantUpdateOpeningTimesPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerRestaurantApi();
var input = new UpdateOpeningTimesDto(); // UpdateOpeningTimesDto | 

try { 
    api_instance.apiServicesAppManagerRestaurantUpdateOpeningTimesPost(input);
} catch (e) {
    print("Exception when calling ManagerRestaurantApi->apiServicesAppManagerRestaurantUpdateOpeningTimesPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**UpdateOpeningTimesDto**](UpdateOpeningTimesDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerRestaurantUpdateProfilePost**
> apiServicesAppManagerRestaurantUpdateProfilePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerRestaurantApi();
var input = new RestaurantProfileDto(); // RestaurantProfileDto | 

try { 
    api_instance.apiServicesAppManagerRestaurantUpdateProfilePost(input);
} catch (e) {
    print("Exception when calling ManagerRestaurantApi->apiServicesAppManagerRestaurantUpdateProfilePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**RestaurantProfileDto**](RestaurantProfileDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

