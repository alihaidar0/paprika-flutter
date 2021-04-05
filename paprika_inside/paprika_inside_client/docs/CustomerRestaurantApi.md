# swagger.api.CustomerRestaurantApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost/Inside.Api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAppCustomerRestaurantFeedbackPost**](CustomerRestaurantApi.md#apiAppCustomerRestaurantFeedbackPost) | **POST** /api/app/customer-restaurant/feedback | 
[**apiAppCustomerRestaurantRestaurantProfileGet**](CustomerRestaurantApi.md#apiAppCustomerRestaurantRestaurantProfileGet) | **GET** /api/app/customer-restaurant/restaurant-profile | 


# **apiAppCustomerRestaurantFeedbackPost**
> apiAppCustomerRestaurantFeedbackPost(body)



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerRestaurantApi();
var body = new RestaurantsFeedbackDto(); // RestaurantsFeedbackDto | 

try { 
    api_instance.apiAppCustomerRestaurantFeedbackPost(body);
} catch (e) {
    print("Exception when calling CustomerRestaurantApi->apiAppCustomerRestaurantFeedbackPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**RestaurantsFeedbackDto**](RestaurantsFeedbackDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAppCustomerRestaurantRestaurantProfileGet**
> RestaurantsRestaurantDto apiAppCustomerRestaurantRestaurantProfileGet()



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerRestaurantApi();

try { 
    var result = api_instance.apiAppCustomerRestaurantRestaurantProfileGet();
    print(result);
} catch (e) {
    print("Exception when calling CustomerRestaurantApi->apiAppCustomerRestaurantRestaurantProfileGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**RestaurantsRestaurantDto**](RestaurantsRestaurantDto.md)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

