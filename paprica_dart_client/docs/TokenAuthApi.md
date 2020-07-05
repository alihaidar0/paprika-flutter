# swagger.api.TokenAuthApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiTokenAuthAuthenticatePost**](TokenAuthApi.md#apiTokenAuthAuthenticatePost) | **POST** /api/TokenAuth/Authenticate | 
[**apiTokenAuthExternalAuthenticatePost**](TokenAuthApi.md#apiTokenAuthExternalAuthenticatePost) | **POST** /api/TokenAuth/ExternalAuthenticate | 
[**apiTokenAuthGetExternalAuthenticationProvidersGet**](TokenAuthApi.md#apiTokenAuthGetExternalAuthenticationProvidersGet) | **GET** /api/TokenAuth/GetExternalAuthenticationProviders | 


# **apiTokenAuthAuthenticatePost**
> AuthenticateResultModel apiTokenAuthAuthenticatePost(model)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new TokenAuthApi();
var model = new AuthenticateModel(); // AuthenticateModel | 

try { 
    var result = api_instance.apiTokenAuthAuthenticatePost(model);
    print(result);
} catch (e) {
    print("Exception when calling TokenAuthApi->apiTokenAuthAuthenticatePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **model** | [**AuthenticateModel**](AuthenticateModel.md)|  | [optional] 

### Return type

[**AuthenticateResultModel**](AuthenticateResultModel.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTokenAuthExternalAuthenticatePost**
> ExternalAuthenticateResultModel apiTokenAuthExternalAuthenticatePost(model)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new TokenAuthApi();
var model = new ExternalAuthenticateModel(); // ExternalAuthenticateModel | 

try { 
    var result = api_instance.apiTokenAuthExternalAuthenticatePost(model);
    print(result);
} catch (e) {
    print("Exception when calling TokenAuthApi->apiTokenAuthExternalAuthenticatePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **model** | [**ExternalAuthenticateModel**](ExternalAuthenticateModel.md)|  | [optional] 

### Return type

[**ExternalAuthenticateResultModel**](ExternalAuthenticateResultModel.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiTokenAuthGetExternalAuthenticationProvidersGet**
> List<ExternalLoginProviderInfoModel> apiTokenAuthGetExternalAuthenticationProvidersGet()



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new TokenAuthApi();

try { 
    var result = api_instance.apiTokenAuthGetExternalAuthenticationProvidersGet();
    print(result);
} catch (e) {
    print("Exception when calling TokenAuthApi->apiTokenAuthGetExternalAuthenticationProvidersGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<ExternalLoginProviderInfoModel>**](ExternalLoginProviderInfoModel.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

