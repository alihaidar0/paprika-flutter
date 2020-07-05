# swagger.api.ManagerMenuApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppManagerMenuCreateCategoryPost**](ManagerMenuApi.md#apiServicesAppManagerMenuCreateCategoryPost) | **POST** /api/services/app/Manager/Menu/CreateCategory | 
[**apiServicesAppManagerMenuCreateMealPost**](ManagerMenuApi.md#apiServicesAppManagerMenuCreateMealPost) | **POST** /api/services/app/Manager/Menu/CreateMeal | 
[**apiServicesAppManagerMenuDeleteCategoryDelete**](ManagerMenuApi.md#apiServicesAppManagerMenuDeleteCategoryDelete) | **DELETE** /api/services/app/Manager/Menu/DeleteCategory | 
[**apiServicesAppManagerMenuDeleteMealPost**](ManagerMenuApi.md#apiServicesAppManagerMenuDeleteMealPost) | **POST** /api/services/app/Manager/Menu/DeleteMeal | 
[**apiServicesAppManagerMenuGetCategoriesByRestaurantGet**](ManagerMenuApi.md#apiServicesAppManagerMenuGetCategoriesByRestaurantGet) | **GET** /api/services/app/Manager/Menu/GetCategoriesByRestaurant | 
[**apiServicesAppManagerMenuGetCategoriesGet**](ManagerMenuApi.md#apiServicesAppManagerMenuGetCategoriesGet) | **GET** /api/services/app/Manager/Menu/GetCategories | 
[**apiServicesAppManagerMenuGetCategoryMealsGet**](ManagerMenuApi.md#apiServicesAppManagerMenuGetCategoryMealsGet) | **GET** /api/services/app/Manager/Menu/GetCategoryMeals | 
[**apiServicesAppManagerMenuUpdateCategoryPost**](ManagerMenuApi.md#apiServicesAppManagerMenuUpdateCategoryPost) | **POST** /api/services/app/Manager/Menu/UpdateCategory | 
[**apiServicesAppManagerMenuUpdateCategoryStatusPost**](ManagerMenuApi.md#apiServicesAppManagerMenuUpdateCategoryStatusPost) | **POST** /api/services/app/Manager/Menu/UpdateCategoryStatus | 
[**apiServicesAppManagerMenuUpdateMealPost**](ManagerMenuApi.md#apiServicesAppManagerMenuUpdateMealPost) | **POST** /api/services/app/Manager/Menu/UpdateMeal | 
[**apiServicesAppManagerMenuUpdateMealStatusPost**](ManagerMenuApi.md#apiServicesAppManagerMenuUpdateMealStatusPost) | **POST** /api/services/app/Manager/Menu/UpdateMealStatus | 


# **apiServicesAppManagerMenuCreateCategoryPost**
> apiServicesAppManagerMenuCreateCategoryPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerMenuApi();
var input = new CreateCategoryDto(); // CreateCategoryDto | 

try { 
    api_instance.apiServicesAppManagerMenuCreateCategoryPost(input);
} catch (e) {
    print("Exception when calling ManagerMenuApi->apiServicesAppManagerMenuCreateCategoryPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**CreateCategoryDto**](CreateCategoryDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerMenuCreateMealPost**
> apiServicesAppManagerMenuCreateMealPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerMenuApi();
var input = new CreateMealDto(); // CreateMealDto | 

try { 
    api_instance.apiServicesAppManagerMenuCreateMealPost(input);
} catch (e) {
    print("Exception when calling ManagerMenuApi->apiServicesAppManagerMenuCreateMealPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**CreateMealDto**](CreateMealDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerMenuDeleteCategoryDelete**
> apiServicesAppManagerMenuDeleteCategoryDelete(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerMenuApi();
var id = 789; // int | 

try { 
    api_instance.apiServicesAppManagerMenuDeleteCategoryDelete(id);
} catch (e) {
    print("Exception when calling ManagerMenuApi->apiServicesAppManagerMenuDeleteCategoryDelete: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerMenuDeleteMealPost**
> apiServicesAppManagerMenuDeleteMealPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerMenuApi();
var input = new EntityDtoInt64(); // EntityDtoInt64 |

try { 
    api_instance.apiServicesAppManagerMenuDeleteMealPost(input);
} catch (e) {
    print("Exception when calling ManagerMenuApi->apiServicesAppManagerMenuDeleteMealPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**EntityDtoInt64**](EntityDtoInt64.md)|  | [optional]

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerMenuGetCategoriesByRestaurantGet**
> List<CategoryDto> apiServicesAppManagerMenuGetCategoriesByRestaurantGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerMenuApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppManagerMenuGetCategoriesByRestaurantGet(id);
    print(result);
} catch (e) {
    print("Exception when calling ManagerMenuApi->apiServicesAppManagerMenuGetCategoriesByRestaurantGet: $e\n");
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

# **apiServicesAppManagerMenuGetCategoriesGet**
> List<CategoryDto> apiServicesAppManagerMenuGetCategoriesGet()



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerMenuApi();

try { 
    var result = api_instance.apiServicesAppManagerMenuGetCategoriesGet();
    print(result);
} catch (e) {
    print("Exception when calling ManagerMenuApi->apiServicesAppManagerMenuGetCategoriesGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<CategoryDto>**](CategoryDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerMenuGetCategoryMealsGet**
> List<MealDto> apiServicesAppManagerMenuGetCategoryMealsGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerMenuApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppManagerMenuGetCategoryMealsGet(id);
    print(result);
} catch (e) {
    print("Exception when calling ManagerMenuApi->apiServicesAppManagerMenuGetCategoryMealsGet: $e\n");
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

# **apiServicesAppManagerMenuUpdateCategoryPost**
> apiServicesAppManagerMenuUpdateCategoryPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerMenuApi();
var input = new UpdateCategoryDto(); // UpdateCategoryDto | 

try { 
    api_instance.apiServicesAppManagerMenuUpdateCategoryPost(input);
} catch (e) {
    print("Exception when calling ManagerMenuApi->apiServicesAppManagerMenuUpdateCategoryPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**UpdateCategoryDto**](UpdateCategoryDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerMenuUpdateCategoryStatusPost**
> apiServicesAppManagerMenuUpdateCategoryStatusPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerMenuApi();
var input = new UpdateStatusDto(); // UpdateStatusDto | 

try { 
    api_instance.apiServicesAppManagerMenuUpdateCategoryStatusPost(input);
} catch (e) {
    print("Exception when calling ManagerMenuApi->apiServicesAppManagerMenuUpdateCategoryStatusPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**UpdateStatusDto**](UpdateStatusDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerMenuUpdateMealPost**
> apiServicesAppManagerMenuUpdateMealPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerMenuApi();
var input = new UpdateMealDto(); // UpdateMealDto | 

try { 
    api_instance.apiServicesAppManagerMenuUpdateMealPost(input);
} catch (e) {
    print("Exception when calling ManagerMenuApi->apiServicesAppManagerMenuUpdateMealPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**UpdateMealDto**](UpdateMealDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppManagerMenuUpdateMealStatusPost**
> apiServicesAppManagerMenuUpdateMealStatusPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerMenuApi();
var input = new UpdateStatusDto(); // UpdateStatusDto | 

try { 
    api_instance.apiServicesAppManagerMenuUpdateMealStatusPost(input);
} catch (e) {
    print("Exception when calling ManagerMenuApi->apiServicesAppManagerMenuUpdateMealStatusPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**UpdateStatusDto**](UpdateStatusDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

