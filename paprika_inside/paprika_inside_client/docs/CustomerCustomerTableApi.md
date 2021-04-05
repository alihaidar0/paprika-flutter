# swagger.api.CustomerCustomerTableApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost/Inside.Api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiAppCustomerCustomerTableAskForInvoiceCustomerTableIdPost**](CustomerCustomerTableApi.md#apiAppCustomerCustomerTableAskForInvoiceCustomerTableIdPost) | **POST** /api/app/customer-customer-table/ask-for-invoice/{customerTableId} | 
[**apiAppCustomerCustomerTableCloseCustomerTableCustomerTableIdPost**](CustomerCustomerTableApi.md#apiAppCustomerCustomerTableCloseCustomerTableCustomerTableIdPost) | **POST** /api/app/customer-customer-table/close-customer-table/{customerTableId} | 
[**apiAppCustomerCustomerTableCustomerTablePost**](CustomerCustomerTableApi.md#apiAppCustomerCustomerTableCustomerTablePost) | **POST** /api/app/customer-customer-table/customer-table | 
[**apiAppCustomerCustomerTableOrderMealsPut**](CustomerCustomerTableApi.md#apiAppCustomerCustomerTableOrderMealsPut) | **PUT** /api/app/customer-customer-table/order-meals | 
[**apiAppCustomerCustomerTableOrderPost**](CustomerCustomerTableApi.md#apiAppCustomerCustomerTableOrderPost) | **POST** /api/app/customer-customer-table/order | 
[**apiAppCustomerCustomerTableOrdersCustomerTableIdGet**](CustomerCustomerTableApi.md#apiAppCustomerCustomerTableOrdersCustomerTableIdGet) | **GET** /api/app/customer-customer-table/orders/{customerTableId} | 


# **apiAppCustomerCustomerTableAskForInvoiceCustomerTableIdPost**
> InvoicesInvoiceDto apiAppCustomerCustomerTableAskForInvoiceCustomerTableIdPost(customerTableId)



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerCustomerTableApi();
var customerTableId = ; // String | 

try { 
    var result = api_instance.apiAppCustomerCustomerTableAskForInvoiceCustomerTableIdPost(customerTableId);
    print(result);
} catch (e) {
    print("Exception when calling CustomerCustomerTableApi->apiAppCustomerCustomerTableAskForInvoiceCustomerTableIdPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **customerTableId** | [**String**](.md)|  | 

### Return type

[**InvoicesInvoiceDto**](InvoicesInvoiceDto.md)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAppCustomerCustomerTableCloseCustomerTableCustomerTableIdPost**
> apiAppCustomerCustomerTableCloseCustomerTableCustomerTableIdPost(customerTableId)



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerCustomerTableApi();
var customerTableId = ; // String | 

try { 
    api_instance.apiAppCustomerCustomerTableCloseCustomerTableCustomerTableIdPost(customerTableId);
} catch (e) {
    print("Exception when calling CustomerCustomerTableApi->apiAppCustomerCustomerTableCloseCustomerTableCustomerTableIdPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **customerTableId** | [**String**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAppCustomerCustomerTableCustomerTablePost**
> String apiAppCustomerCustomerTableCustomerTablePost(body)



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerCustomerTableApi();
var body = new CustomerTablesCreateCustomerTableDto(); // CustomerTablesCreateCustomerTableDto | 

try { 
    var result = api_instance.apiAppCustomerCustomerTableCustomerTablePost(body);
    print(result);
} catch (e) {
    print("Exception when calling CustomerCustomerTableApi->apiAppCustomerCustomerTableCustomerTablePost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CustomerTablesCreateCustomerTableDto**](CustomerTablesCreateCustomerTableDto.md)|  | [optional] 

### Return type

**String**

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/_*+json
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAppCustomerCustomerTableOrderMealsPut**
> apiAppCustomerCustomerTableOrderMealsPut(body)



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerCustomerTableApi();
var body = new CustomerTablesUpdateOrderDto(); // CustomerTablesUpdateOrderDto | 

try { 
    api_instance.apiAppCustomerCustomerTableOrderMealsPut(body);
} catch (e) {
    print("Exception when calling CustomerCustomerTableApi->apiAppCustomerCustomerTableOrderMealsPut: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CustomerTablesUpdateOrderDto**](CustomerTablesUpdateOrderDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAppCustomerCustomerTableOrderPost**
> apiAppCustomerCustomerTableOrderPost(body)



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerCustomerTableApi();
var body = new CustomerTablesCreateOrderDto(); // CustomerTablesCreateOrderDto | 

try { 
    api_instance.apiAppCustomerCustomerTableOrderPost(body);
} catch (e) {
    print("Exception when calling CustomerCustomerTableApi->apiAppCustomerCustomerTableOrderPost: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | [**CustomerTablesCreateOrderDto**](CustomerTablesCreateOrderDto.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: application/json, text/json, application/_*+json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiAppCustomerCustomerTableOrdersCustomerTableIdGet**
> List<CustomerTablesOrderDto> apiAppCustomerCustomerTableOrdersCustomerTableIdGet(customerTableId)



### Example 
```dart
import 'package:swagger/api.dart';
// TODO Configure OAuth2 access token for authorization: oauth2
//swagger.api.Configuration.accessToken = 'YOUR_ACCESS_TOKEN';

var api_instance = new CustomerCustomerTableApi();
var customerTableId = ; // String | 

try { 
    var result = api_instance.apiAppCustomerCustomerTableOrdersCustomerTableIdGet(customerTableId);
    print(result);
} catch (e) {
    print("Exception when calling CustomerCustomerTableApi->apiAppCustomerCustomerTableOrdersCustomerTableIdGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **customerTableId** | [**String**](.md)|  | 

### Return type

[**List<CustomerTablesOrderDto>**](CustomerTablesOrderDto.md)

### Authorization

[oauth2](../README.md#oauth2)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

