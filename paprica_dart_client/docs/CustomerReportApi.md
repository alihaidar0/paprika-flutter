# swagger.api.CustomerReportApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppCustomerReportCreateRestaurantReportPost**](CustomerReportApi.md#apiServicesAppCustomerReportCreateRestaurantReportPost) | **POST** /api/services/app/Customer/Report/CreateRestaurantReport | 


# **apiServicesAppCustomerReportCreateRestaurantReportPost**
> ReportDto apiServicesAppCustomerReportCreateRestaurantReportPost(input)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerReportApi();
var input = new CreateRestaurantReportDto(); // CreateRestaurantReportDto | 

try { 
    var result = api_instance.apiServicesAppCustomerReportCreateRestaurantReportPost(input);
    print(result);
} catch (e) {
    print("Exception when calling CustomerReportApi->apiServicesAppCustomerReportCreateRestaurantReportPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **input** | [**CreateRestaurantReportDto**](CreateRestaurantReportDto.md)|  | [optional] 

### Return type

[**ReportDto**](ReportDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json-patch+json, application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

