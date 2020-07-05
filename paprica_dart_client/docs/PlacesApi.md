# swagger.api.PlacesApi

## Load the API package
```dart
import 'package:swagger/api.dart';
```

All URIs are relative to *https://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiServicesAppPlacesGetAllGet**](PlacesApi.md#apiServicesAppPlacesGetAllGet) | **GET** /api/services/app/Places/GetAll | 


# **apiServicesAppPlacesGetAllGet**
> PagedResultDtoRestaurantSummaryDto apiServicesAppPlacesGetAllGet(parkingType, ambianceType, musicType, isSmokeFree, isAlcoholFree, cusineTypes, amenityTypes, hasOutdoor, is24Hour, skipCount, maxResultCount)



### Example 
```dart
import 'package:swagger/api.dart';

var api_instance = new PlacesApi();
var parkingType = 56; // int | 
var ambianceType = 56; // int | 
var musicType = 56; // int | 
var isSmokeFree = true; // bool | 
var isAlcoholFree = true; // bool | 
var cusineTypes = 56; // int | 
var amenityTypes = 56; // int | 
var hasOutdoor = true; // bool | 
var is24Hour = true; // bool | 
var skipCount = 56; // int | 
var maxResultCount = 56; // int | 

try { 
    var result = api_instance.apiServicesAppPlacesGetAllGet(parkingType, ambianceType, musicType, isSmokeFree, isAlcoholFree, cusineTypes, amenityTypes, hasOutdoor, is24Hour, skipCount, maxResultCount);
    print(result);
} catch (e) {
    print("Exception when calling PlacesApi->apiServicesAppPlacesGetAllGet: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **parkingType** | **int**|  | [optional] 
 **ambianceType** | **int**|  | [optional] 
 **musicType** | **int**|  | [optional] 
 **isSmokeFree** | **bool**|  | [optional] 
 **isAlcoholFree** | **bool**|  | [optional] 
 **cusineTypes** | **int**|  | [optional] 
 **amenityTypes** | **int**|  | [optional] 
 **hasOutdoor** | **bool**|  | [optional] 
 **is24Hour** | **bool**|  | [optional] 
 **skipCount** | **int**|  | [optional] 
 **maxResultCount** | **int**|  | [optional] 

### Return type

[**PagedResultDtoRestaurantSummaryDto**](PagedResultDtoRestaurantSummaryDto.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json, text/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

