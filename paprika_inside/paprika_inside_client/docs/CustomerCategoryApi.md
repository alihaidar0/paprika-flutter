# swagger.api.CustomerCategoryApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost/Inside.Api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAppCustomerCategoryRestaurantCategoriesGet**](CustomerCategoryApi.md#apiAppCustomerCategoryRestaurantCategoriesGet) | **GET** /api/app/customer-category/restaurant-categories | 


# **apiAppCustomerCategoryRestaurantCategoriesGet**
> List<SoftUpPaprikaInsideCategoriesCategoryDto> apiAppCustomerCategoryRestaurantCategoriesGet()



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerCategoryApi();

try { 
    var result = api_instance.apiAppCustomerCategoryRestaurantCategoriesGet();
    print(result);
} catch (e) {
    print("Exception when calling CustomerCategoryApi->apiAppCustomerCategoryRestaurantCategoriesGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<SoftUpPaprikaInsideCategoriesCategoryDto>**](SoftUpPaprikaInsideCategoriesCategoryDto.md)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

