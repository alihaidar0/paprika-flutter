# swagger.api.ManagerReportApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppManagerReportCreateCustomerReportPost**](ManagerReportApi.md#apiServicesAppManagerReportCreateCustomerReportPost) | **POST** /api/services/app/Manager/Report/CreateCustomerReport | 


# **apiServicesAppManagerReportCreateCustomerReportPost**
> ReportDto apiServicesAppManagerReportCreateCustomerReportPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerReportApi();
var input = new CreateCustomerReportDto(); // CreateCustomerReportDto | 

try { 
    var result = api_instance.apiServicesAppManagerReportCreateCustomerReportPost(input);
    print(result);
} catch (e) {
    print("Exception when calling ManagerReportApi->apiServicesAppManagerReportCreateCustomerReportPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**CreateCustomerReportDto**](CreateCustomerReportDto.md)|  | [optional] 

### Return type

[**ReportDto**](ReportDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

