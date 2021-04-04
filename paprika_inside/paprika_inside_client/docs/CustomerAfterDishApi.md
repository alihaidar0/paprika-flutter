# swagger.api.CustomerAfterDishApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost/Inside.Api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAppCustomerAfterDishAfterDishesGet**](CustomerAfterDishApi.md#apiAppCustomerAfterDishAfterDishesGet) | **GET** /api/app/customer-after-dish/after-dishes | 
[**apiAppCustomerAfterDishChooseAfterDishPost**](CustomerAfterDishApi.md#apiAppCustomerAfterDishChooseAfterDishPost) | **POST** /api/app/customer-after-dish/choose-after-dish | 


# **apiAppCustomerAfterDishAfterDishesGet**
> List<SoftUpPaprikaInsideAfterDishesAfterDishDto> apiAppCustomerAfterDishAfterDishesGet()



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerAfterDishApi();

try { 
    var result = api_instance.apiAppCustomerAfterDishAfterDishesGet();
    print(result);
} catch (e) {
    print("Exception when calling CustomerAfterDishApi->apiAppCustomerAfterDishAfterDishesGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<SoftUpPaprikaInsideAfterDishesAfterDishDto>**](SoftUpPaprikaInsideAfterDishesAfterDishDto.md)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAppCustomerAfterDishChooseAfterDishPost**
> apiAppCustomerAfterDishChooseAfterDishPost(body)



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerAfterDishApi();
var body = new SoftUpPaprikaInsideAfterDishesAfterDishRequestDto(); // SoftUpPaprikaInsideAfterDishesAfterDishRequestDto | 

try { 
    api_instance.apiAppCustomerAfterDishChooseAfterDishPost(body);
} catch (e) {
    print("Exception when calling CustomerAfterDishApi->apiAppCustomerAfterDishChooseAfterDishPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**SoftUpPaprikaInsideAfterDishesAfterDishRequestDto**](SoftUpPaprikaInsideAfterDishesAfterDishRequestDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

