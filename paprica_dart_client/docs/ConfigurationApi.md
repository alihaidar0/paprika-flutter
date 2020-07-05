# swagger.api.ConfigurationApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppConfigurationChangeRestaurantSettingsPost**](ConfigurationApi.md#apiServicesAppConfigurationChangeRestaurantSettingsPost) | **POST** /api/services/app/Configuration/ChangeRestaurantSettings | 
[**apiServicesAppConfigurationChangeUiThemePost**](ConfigurationApi.md#apiServicesAppConfigurationChangeUiThemePost) | **POST** /api/services/app/Configuration/ChangeUiTheme | 
[**apiServicesAppConfigurationGetRestaurantSettingsGet**](ConfigurationApi.md#apiServicesAppConfigurationGetRestaurantSettingsGet) | **GET** /api/services/app/Configuration/GetRestaurantSettings | 


# **apiServicesAppConfigurationChangeRestaurantSettingsPost**
> apiServicesAppConfigurationChangeRestaurantSettingsPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ConfigurationApi();
var input = new ChangeRestaurantSettingsDto(); // ChangeRestaurantSettingsDto | 

try { 
    api_instance.apiServicesAppConfigurationChangeRestaurantSettingsPost(input);
} catch (e) {
    print("Exception when calling ConfigurationApi->apiServicesAppConfigurationChangeRestaurantSettingsPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**ChangeRestaurantSettingsDto**](ChangeRestaurantSettingsDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppConfigurationChangeUiThemePost**
> apiServicesAppConfigurationChangeUiThemePost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ConfigurationApi();
var input = new ChangeUiThemeInput(); // ChangeUiThemeInput | 

try { 
    api_instance.apiServicesAppConfigurationChangeUiThemePost(input);
} catch (e) {
    print("Exception when calling ConfigurationApi->apiServicesAppConfigurationChangeUiThemePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**ChangeUiThemeInput**](ChangeUiThemeInput.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppConfigurationGetRestaurantSettingsGet**
> List<ISettingValue> apiServicesAppConfigurationGetRestaurantSettingsGet()



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ConfigurationApi();

try { 
    var result = api_instance.apiServicesAppConfigurationGetRestaurantSettingsGet();
    print(result);
} catch (e) {
    print("Exception when calling ConfigurationApi->apiServicesAppConfigurationGetRestaurantSettingsGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<ISettingValue>**](ISettingValue.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

