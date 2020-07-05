# swagger.api.UserApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppUserChangeLanguagePost**](UserApi.md#apiServicesAppUserChangeLanguagePost) | **POST** /api/services/app/User/ChangeLanguage | 
[**apiServicesAppUserChangePasswordPost**](UserApi.md#apiServicesAppUserChangePasswordPost) | **POST** /api/services/app/User/ChangePassword | 
[**apiServicesAppUserCreatePost**](UserApi.md#apiServicesAppUserCreatePost) | **POST** /api/services/app/User/Create | 
[**apiServicesAppUserDeleteDelete**](UserApi.md#apiServicesAppUserDeleteDelete) | **DELETE** /api/services/app/User/Delete | 
[**apiServicesAppUserGetAllGet**](UserApi.md#apiServicesAppUserGetAllGet) | **GET** /api/services/app/User/GetAll | 
[**apiServicesAppUserGetGet**](UserApi.md#apiServicesAppUserGetGet) | **GET** /api/services/app/User/Get | 
[**apiServicesAppUserGetRolesGet**](UserApi.md#apiServicesAppUserGetRolesGet) | **GET** /api/services/app/User/GetRoles | 
[**apiServicesAppUserResetPasswordPost**](UserApi.md#apiServicesAppUserResetPasswordPost) | **POST** /api/services/app/User/ResetPassword | 
[**apiServicesAppUserUpdatePut**](UserApi.md#apiServicesAppUserUpdatePut) | **PUT** /api/services/app/User/Update | 


# **apiServicesAppUserChangeLanguagePost**
> apiServicesAppUserChangeLanguagePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var input = new ChangeUserLanguageDto(); // ChangeUserLanguageDto | 

try { 
    api_instance.apiServicesAppUserChangeLanguagePost(input);
} catch (e) {
    print("Exception when calling UserApi->apiServicesAppUserChangeLanguagePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**ChangeUserLanguageDto**](ChangeUserLanguageDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppUserChangePasswordPost**
> bool apiServicesAppUserChangePasswordPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var input = new ChangePasswordDto(); // ChangePasswordDto | 

try { 
    var result = api_instance.apiServicesAppUserChangePasswordPost(input);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->apiServicesAppUserChangePasswordPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**ChangePasswordDto**](ChangePasswordDto.md)|  | [optional] 

### Return type

**bool**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppUserCreatePost**
> UserDto apiServicesAppUserCreatePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var input = new CreateUserDto(); // CreateUserDto | 

try { 
    var result = api_instance.apiServicesAppUserCreatePost(input);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->apiServicesAppUserCreatePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**CreateUserDto**](CreateUserDto.md)|  | [optional] 

### Return type

[**UserDto**](UserDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppUserDeleteDelete**
> apiServicesAppUserDeleteDelete(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var id = 789; // int | 

try { 
    api_instance.apiServicesAppUserDeleteDelete(id);
} catch (e) {
    print("Exception when calling UserApi->apiServicesAppUserDeleteDelete: $e\n");
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

# **apiServicesAppUserGetAllGet**
> PagedResultDtoUserDto apiServicesAppUserGetAllGet(keyword, isActive, skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var keyword = keyword_example; // String | 
var isActive = true; // bool | 
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppUserGetAllGet(keyword, isActive, skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->apiServicesAppUserGetAllGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**|  | [optional] 
 **isActive** | **bool**|  | [optional] 
 **skipCount** | **int**|  | [optional] 
 **maxResultCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoUserDto**](PagedResultDtoUserDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppUserGetGet**
> UserDto apiServicesAppUserGetGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppUserGetGet(id);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->apiServicesAppUserGetGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**UserDto**](UserDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppUserGetRolesGet**
> ListResultDtoRoleDto apiServicesAppUserGetRolesGet()



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();

try { 
    var result = api_instance.apiServicesAppUserGetRolesGet();
    print(result);
} catch (e) {
    print("Exception when calling UserApi->apiServicesAppUserGetRolesGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ListResultDtoRoleDto**](ListResultDtoRoleDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppUserResetPasswordPost**
> bool apiServicesAppUserResetPasswordPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var input = new ResetPasswordDto(); // ResetPasswordDto | 

try { 
    var result = api_instance.apiServicesAppUserResetPasswordPost(input);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->apiServicesAppUserResetPasswordPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**ResetPasswordDto**](ResetPasswordDto.md)|  | [optional] 

### Return type

**bool**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppUserUpdatePut**
> UserDto apiServicesAppUserUpdatePut(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new UserApi();
var input = new UserDto(); // UserDto | 

try { 
    var result = api_instance.apiServicesAppUserUpdatePut(input);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->apiServicesAppUserUpdatePut: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**UserDto**](UserDto.md)|  | [optional] 

### Return type

[**UserDto**](UserDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

