# swagger.api.CustomerReservationApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppCustomerReservationCancelReservationGet**](CustomerReservationApi.md#apiServicesAppCustomerReservationCancelReservationGet) | **GET** /api/services/app/Customer/Reservation/CancelReservation | 
[**apiServicesAppCustomerReservationCreateReservationGet**](CustomerReservationApi.md#apiServicesAppCustomerReservationCreateReservationGet) | **GET** /api/services/app/Customer/Reservation/CreateReservation | 
[**apiServicesAppCustomerReservationGetAllGet**](CustomerReservationApi.md#apiServicesAppCustomerReservationGetAllGet) | **GET** /api/services/app/Customer/Reservation/GetAll | 
[**apiServicesAppCustomerReservationGetAllOldGet**](CustomerReservationApi.md#apiServicesAppCustomerReservationGetAllOldGet) | **GET** /api/services/app/Customer/Reservation/GetAllOld | 
[**apiServicesAppCustomerReservationGetAllUpcomingGet**](CustomerReservationApi.md#apiServicesAppCustomerReservationGetAllUpcomingGet) | **GET** /api/services/app/Customer/Reservation/GetAllUpcoming | 
[**apiServicesAppCustomerReservationGetGet**](CustomerReservationApi.md#apiServicesAppCustomerReservationGetGet) | **GET** /api/services/app/Customer/Reservation/Get | 
[**apiServicesAppCustomerReservationUpdateReservationGet**](CustomerReservationApi.md#apiServicesAppCustomerReservationUpdateReservationGet) | **GET** /api/services/app/Customer/Reservation/UpdateReservation | 


# **apiServicesAppCustomerReservationCancelReservationGet**
> MassageDto apiServicesAppCustomerReservationCancelReservationGet(id, cancelReason)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerReservationApi();
var id = 789; // int | 
var cancelReason = cancelReason_example; // String | 

try { 
    var result = api_instance.apiServicesAppCustomerReservationCancelReservationGet(id, cancelReason);
    print(result);
} catch (e) {
    print("Exception when calling CustomerReservationApi->apiServicesAppCustomerReservationCancelReservationGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 
 **cancelReason** | **String**|  | [optional] 

### Return type

[**MassageDto**](MassageDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerReservationCreateReservationGet**
> MassageDto apiServicesAppCustomerReservationCreateReservationGet(customerId, status, restaurantId, numberOfPeople, time, date, customerAdditionalInfo, phoneNumber, occasionType, personName)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerReservationApi();
var customerId = 789; // int | 
var status = 56; // int | 
var restaurantId = 789; // int | 
var numberOfPeople = 56; // int | 
var time = 2013-10-20T19:20:30+01:00; // DateTime | 
var date = 2013-10-20T19:20:30+01:00; // DateTime | 
var customerAdditionalInfo = customerAdditionalInfo_example; // String | 
var phoneNumber = phoneNumber_example; // String | 
var occasionType = 56; // int | 
var personName = personName_example; // String | 

try { 
    var result = api_instance.apiServicesAppCustomerReservationCreateReservationGet(customerId, status, restaurantId, numberOfPeople, time, date, customerAdditionalInfo, phoneNumber, occasionType, personName);
    print(result);
} catch (e) {
    print("Exception when calling CustomerReservationApi->apiServicesAppCustomerReservationCreateReservationGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **customerId** | **int**|  | [optional] 
 **status** | **int**|  | [optional] 
 **restaurantId** | **int**|  | [optional] 
 **numberOfPeople** | **int**|  | [optional] 
 **time** | **DateTime**|  | [optional] 
 **date** | **DateTime**|  | [optional] 
 **customerAdditionalInfo** | **String**|  | [optional] 
 **phoneNumber** | **String**|  | [optional] 
 **occasionType** | **int**|  | [optional] 
 **personName** | **String**|  | [optional] 

### Return type

[**MassageDto**](MassageDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerReservationGetAllGet**
> PagedResultDtoReservationDto apiServicesAppCustomerReservationGetAllGet(skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerReservationApi();
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppCustomerReservationGetAllGet(skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling CustomerReservationApi->apiServicesAppCustomerReservationGetAllGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **skipCount** | **int**|  | [optional] 
 **maxResultCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoReservationDto**](PagedResultDtoReservationDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerReservationGetAllOldGet**
> CustomerOldReservationsDto apiServicesAppCustomerReservationGetAllOldGet()



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerReservationApi();

try { 
    var result = api_instance.apiServicesAppCustomerReservationGetAllOldGet();
    print(result);
} catch (e) {
    print("Exception when calling CustomerReservationApi->apiServicesAppCustomerReservationGetAllOldGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**CustomerOldReservationsDto**](CustomerOldReservationsDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerReservationGetAllUpcomingGet**
> CustomerUpcomingReservationsDto apiServicesAppCustomerReservationGetAllUpcomingGet()



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerReservationApi();

try { 
    var result = api_instance.apiServicesAppCustomerReservationGetAllUpcomingGet();
    print(result);
} catch (e) {
    print("Exception when calling CustomerReservationApi->apiServicesAppCustomerReservationGetAllUpcomingGet: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**CustomerUpcomingReservationsDto**](CustomerUpcomingReservationsDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerReservationGetGet**
> ReservationDto apiServicesAppCustomerReservationGetGet(id)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerReservationApi();
var id = 789; // int | 

try { 
    var result = api_instance.apiServicesAppCustomerReservationGetGet(id);
    print(result);
} catch (e) {
    print("Exception when calling CustomerReservationApi->apiServicesAppCustomerReservationGetGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 

### Return type

[**ReservationDto**](ReservationDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiServicesAppCustomerReservationUpdateReservationGet**
> MassageDto apiServicesAppCustomerReservationUpdateReservationGet(id, customerId, status, restaurantId, numberOfPeople, time, date, customerAdditionalInfo, phoneNumber, occasionType, personName)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new CustomerReservationApi();
var id = 789; // int | 
var customerId = 789; // int | 
var status = 56; // int | 
var restaurantId = 789; // int | 
var numberOfPeople = 56; // int | 
var time = 2013-10-20T19:20:30+01:00; // DateTime | 
var date = 2013-10-20T19:20:30+01:00; // DateTime | 
var customerAdditionalInfo = customerAdditionalInfo_example; // String | 
var phoneNumber = phoneNumber_example; // String | 
var occasionType = 56; // int | 
var personName = personName_example; // String | 

try { 
    var result = api_instance.apiServicesAppCustomerReservationUpdateReservationGet(id, customerId, status, restaurantId, numberOfPeople, time, date, customerAdditionalInfo, phoneNumber, occasionType, personName);
    print(result);
} catch (e) {
    print("Exception when calling CustomerReservationApi->apiServicesAppCustomerReservationUpdateReservationGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | [optional] 
 **customerId** | **int**|  | [optional] 
 **status** | **int**|  | [optional] 
 **restaurantId** | **int**|  | [optional] 
 **numberOfPeople** | **int**|  | [optional] 
 **time** | **DateTime**|  | [optional] 
 **date** | **DateTime**|  | [optional] 
 **customerAdditionalInfo** | **String**|  | [optional] 
 **phoneNumber** | **String**|  | [optional] 
 **occasionType** | **int**|  | [optional] 
 **personName** | **String**|  | [optional] 

### Return type

[**MassageDto**](MassageDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

