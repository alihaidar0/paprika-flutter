# swagger.api.RoleApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppRoleCreatePost**](RoleApi.md#apiServicesAppRoleCreatePost) | **POST** /api/services/app/Role/Create | 
[**apiServicesAppRoleDeleteDelete**](RoleApi.md#apiServicesAppRoleDeleteDelete) | **DELETE** /api/services/app/Role/Delete | 
[**apiServicesAppRoleGetAllGet**](RoleApi.md#apiServicesAppRoleGetAllGet) | **GET** /api/services/app/Role/GetAll | 
[**apiServicesAppRoleGetAllPermissionsGet**](RoleApi.md#apiServicesAppRoleGetAllPermissionsGet) | **GET** /api/services/app/Role/GetAllPermissions | 
[**apiServicesAppRoleGetGet**](RoleApi.md#apiServicesAppRoleGetGet) | **GET** /api/services/app/Role/Get | 
[**apiServicesAppRoleGetRoleForEditGet**](RoleApi.md#apiServicesAppRoleGetRoleForEditGet) | **GET** /api/services/app/Role/GetRoleForEdit | 
[**apiServicesAppRoleGetRolesAsyncGet**](RoleApi.md#apiServicesAppRoleGetRolesAsyncGet) | **GET** /api/services/app/Role/GetRolesAsync | 
[**apiServicesAppRoleUpdatePut**](RoleApi.md#apiServicesAppRoleUpdatePut) | **PUT** /api/services/app/Role/Update | 


# **apiServicesAppRoleCreatePost**
> RoleDto apiServicesAppRoleCreatePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new RoleApi();
var input = new CreateRoleDto(); // CreateRoleDto | 

try { 
    var result = api_instance.apiServicesAppRoleCreatePost(input);
    print(result);
} catch (e) {
    print("Exception when calling RoleApi->apiServicesAppRoleCreatePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**CreateRoleDto**](CreateRoleDto.md)|  | [optional] 

### Return type

[**RoleDto**](RoleDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppRoleDeleteDelete**
> apiServicesAppRoleDeleteDelete(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new RoleApi();
var id = 56; // int | 

try { 
    api_instance.apiServicesAppRoleDeleteDelete(id);
} catch (e) {
    print("Exception when calling RoleApi->apiServicesAppRoleDeleteDelete: $e\n");
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

# **apiServicesAppRoleGetAllGet**
> PagedResultDtoRoleDto apiServicesAppRoleGetAllGet(keyword, skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new RoleApi();
var keyword = keyword_example; // String | 
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppRoleGetAllGet(keyword, skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling RoleApi->apiServicesAppRoleGetAllGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyword** | **String**|  | [optional] 
 **skipCount** | **int**|  | [optional] 
 **maxResultCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoRoleDto**](PagedResultDtoRoleDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppRoleGetAllPermissionsGet**
> ListResultDtoPermissionDto apiServicesAppRoleGetAllPermissionsGet()



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new RoleApi();

try { 
    var result = api_instance.apiServicesAppRoleGetAllPermissionsGet();
    print(result);
} catch (e) {
    print("Exception when calling RoleApi->apiServicesAppRoleGetAllPermissionsGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ListResultDtoPermissionDto**](ListResultDtoPermissionDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppRoleGetGet**
> RoleDto apiServicesAppRoleGetGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new RoleApi();
var id = 56; // int | 

try { 
    var result = api_instance.apiServicesAppRoleGetGet(id);
    print(result);
} catch (e) {
    print("Exception when calling RoleApi->apiServicesAppRoleGetGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**RoleDto**](RoleDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppRoleGetRoleForEditGet**
> GetRoleForEditOutput apiServicesAppRoleGetRoleForEditGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new RoleApi();
var id = 56; // int | 

try { 
    var result = api_instance.apiServicesAppRoleGetRoleForEditGet(id);
    print(result);
} catch (e) {
    print("Exception when calling RoleApi->apiServicesAppRoleGetRoleForEditGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**GetRoleForEditOutput**](GetRoleForEditOutput.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppRoleGetRolesAsyncGet**
> ListResultDtoRoleListDto apiServicesAppRoleGetRolesAsyncGet(permission)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new RoleApi();
var permission = permission_example; // String | 

try { 
    var result = api_instance.apiServicesAppRoleGetRolesAsyncGet(permission);
    print(result);
} catch (e) {
    print("Exception when calling RoleApi->apiServicesAppRoleGetRolesAsyncGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **permission** | **String**|  | [optional] 

### Return type

[**ListResultDtoRoleListDto**](ListResultDtoRoleListDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppRoleUpdatePut**
> RoleDto apiServicesAppRoleUpdatePut(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new RoleApi();
var input = new RoleDto(); // RoleDto | 

try { 
    var result = api_instance.apiServicesAppRoleUpdatePut(input);
    print(result);
} catch (e) {
    print("Exception when calling RoleApi->apiServicesAppRoleUpdatePut: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**RoleDto**](RoleDto.md)|  | [optional] 

### Return type

[**RoleDto**](RoleDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

