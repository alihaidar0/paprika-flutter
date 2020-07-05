# swagger.api.CustomerMenuApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppCustomerMenuGetRestaurantCategoriesGet**](CustomerMenuApi.md#apiServicesAppCustomerMenuGetRestaurantCategoriesGet) | **GET** /api/services/app/Customer/Menu/GetRestaurantCategories | 
[**apiServicesAppCustomerMenuGetRestaurantCategoryMealsGet**](CustomerMenuApi.md#apiServicesAppCustomerMenuGetRestaurantCategoryMealsGet) | **GET** /api/services/app/Customer/Menu/GetRestaurantCategoryMeals | 
[**apiServicesAppCustomerMenuRateMealPost**](CustomerMenuApi.md#apiServicesAppCustomerMenuRateMealPost) | **POST** /api/services/app/Customer/Menu/RateMeal | 


# **apiServicesAppCustomerMenuGetRestaurantCategoriesGet**
> List<CategoryDto> apiServicesAppCustomerMenuGetRestaurantCategoriesGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerMenuApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppCustomerMenuGetRestaurantCategoriesGet(id);
    print(result);
} catch (e) {
    print("Exception when calling CustomerMenuApi->apiServicesAppCustomerMenuGetRestaurantCategoriesGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**List<CategoryDto>**](CategoryDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerMenuGetRestaurantCategoryMealsGet**
> List<MealDto> apiServicesAppCustomerMenuGetRestaurantCategoryMealsGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerMenuApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppCustomerMenuGetRestaurantCategoryMealsGet(id);
    print(result);
} catch (e) {
    print("Exception when calling CustomerMenuApi->apiServicesAppCustomerMenuGetRestaurantCategoryMealsGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**List<MealDto>**](MealDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerMenuRateMealPost**
> apiServicesAppCustomerMenuRateMealPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerMenuApi();
var input = new MealRateDto(); // MealRateDto | 

try { 
    api_instance.apiServicesAppCustomerMenuRateMealPost(input);
} catch (e) {
    print("Exception when calling CustomerMenuApi->apiServicesAppCustomerMenuRateMealPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**MealRateDto**](MealRateDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

