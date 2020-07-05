# swagger.api.AccountApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppAccountIsTenantAvailablePost**](AccountApi.md#apiServicesAppAccountIsTenantAvailablePost) | **POST** /api/services/app/Account/IsTenantAvailable | 
[**apiServicesAppAccountRegisterPost**](AccountApi.md#apiServicesAppAccountRegisterPost) | **POST** /api/services/app/Account/Register | 


# **apiServicesAppAccountIsTenantAvailablePost**
> IsTenantAvailableOutput apiServicesAppAccountIsTenantAvailablePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AccountApi();
var input = new IsTenantAvailableInput(); // IsTenantAvailableInput | 

try { 
    var result = api_instance.apiServicesAppAccountIsTenantAvailablePost(input);
    print(result);
} catch (e) {
    print("Exception when calling AccountApi->apiServicesAppAccountIsTenantAvailablePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**IsTenantAvailableInput**](IsTenantAvailableInput.md)|  | [optional] 

### Return type

[**IsTenantAvailableOutput**](IsTenantAvailableOutput.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppAccountRegisterPost**
> RegisterOutput apiServicesAppAccountRegisterPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AccountApi();
var input = new RegisterInput(); // RegisterInput | 

try { 
    var result = api_instance.apiServicesAppAccountRegisterPost(input);
    print(result);
} catch (e) {
    print("Exception when calling AccountApi->apiServicesAppAccountRegisterPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**RegisterInput**](RegisterInput.md)|  | [optional] 

### Return type

[**RegisterOutput**](RegisterOutput.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

