# swagger.api.CustomerMealApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost/Inside.Api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAppCustomerMealCategoryMealsCategoryIdGet**](CustomerMealApi.md#apiAppCustomerMealCategoryMealsCategoryIdGet) | **GET** /api/app/customer-meal/category-meals/{categoryId} | 


# **apiAppCustomerMealCategoryMealsCategoryIdGet**
> List<MealsMealDto> apiAppCustomerMealCategoryMealsCategoryIdGet(categoryId)



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerMealApi();
var categoryId = ; // String | 

try { 
    var result = api_instance.apiAppCustomerMealCategoryMealsCategoryIdGet(categoryId);
    print(result);
} catch (e) {
    print("Exception when calling CustomerMealApi->apiAppCustomerMealCategoryMealsCategoryIdGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | [**String**](.md)|  | 

### Return type

[**List<MealsMealDto>**](MealsMealDto.md)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

