# swagger.api.AdminDashboardApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppAdminDashboardGetDashboardGet**](AdminDashboardApi.md#apiServicesAppAdminDashboardGetDashboardGet) | **GET** /api/services/app/Admin/Dashboard/GetDashboard | 


# **apiServicesAppAdminDashboardGetDashboardGet**
> AdminDashboardDto apiServicesAppAdminDashboardGetDashboardGet()



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new AdminDashboardApi();

try { 
    var result = api_instance.apiServicesAppAdminDashboardGetDashboardGet();
    print(result);
} catch (e) {
    print("Exception when calling AdminDashboardApi->apiServicesAppAdminDashboardGetDashboardGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AdminDashboardDto**](AdminDashboardDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

