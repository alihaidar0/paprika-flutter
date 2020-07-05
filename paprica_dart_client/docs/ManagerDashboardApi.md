# swagger.api.ManagerDashboardApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppManagerDashboardGetDashboardGet**](ManagerDashboardApi.md#apiServicesAppManagerDashboardGetDashboardGet) | **GET** /api/services/app/Manager/Dashboard/GetDashboard | 


# **apiServicesAppManagerDashboardGetDashboardGet**
> RestaurantReservationDashboardDto apiServicesAppManagerDashboardGetDashboardGet()



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new ManagerDashboardApi();

try { 
    var result = api_instance.apiServicesAppManagerDashboardGetDashboardGet();
    print(result);
} catch (e) {
    print("Exception when calling ManagerDashboardApi->apiServicesAppManagerDashboardGetDashboardGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**RestaurantReservationDashboardDto**](RestaurantReservationDashboardDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

