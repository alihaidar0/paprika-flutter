part of swagger.api;

class QueryParam {
  String name;
  String value;

  QueryParam(this.name, this.value);
}

class ApiClient {
  String basePath;
  var client = new Client();

  Map<String, String> _defaultHeaderMap = {};
  Map<String, Authentication> _authentications = {};

  final _RegList = new RegExp(r'^List<(.*)>$');
  final _RegMap = new RegExp(r'^Map<String,(.*)>$');

  ApiClient({this.basePath: "http://devapi.popina.sy"}) {
    // Setup authentications (key: authentication name, value: authentication).
    _authentications['bearerAuth'] = new ApiKeyAuth("header", "Authorization");

    // Set Api Key
    setApiKey(
        1, "n6MLscZekBJYpr0hhF2RE6uw1xQqap3ol33GpxlB6YKngeTPT4iFCDMKx8w0u2hg");
  }

  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  dynamic _deserialize(dynamic value, String targetType) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          return value is bool ? value : '$value'.toLowerCase() == 'true';
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'AddFavoriteRestaurantDto':
          return new AddFavoriteRestaurantDto.fromJson(value);
        case 'AddRegularCustomerDto':
          return new AddRegularCustomerDto.fromJson(value);
        case 'AdminDashboardDto':
          return new AdminDashboardDto.fromJson(value);
        case 'AlterRestaurantServiceDto':
          return new AlterRestaurantServiceDto.fromJson(value);
        case 'AntdImageDto':
          return new AntdImageDto.fromJson(value);
        case 'ApplicationInfoDto':
          return new ApplicationInfoDto.fromJson(value);
        case 'AuthenticateModel':
          return new AuthenticateModel.fromJson(value);
        case 'AuthenticateResultModel':
          return new AuthenticateResultModel.fromJson(value);
        case 'CancelReservationDto':
          return new CancelReservationDto.fromJson(value);
        case 'CancelPickupDto':
          return new CancelPickupDto.fromJson(value);
        case 'CancelDeliveryDto':
          return new CancelDeliveryDto.fromJson(value);
        case 'CategoryDto':
          return new CategoryDto.fromJson(value);
        case 'ChangeEventStatusDto':
          return new ChangeEventStatusDto.fromJson(value);
        case 'ChangeFreeSpaceIndicator':
          return new ChangeFreeSpaceIndicator.fromJson(value);
        case 'ChangeOfferStatusDto':
          return new ChangeOfferStatusDto.fromJson(value);
        case 'ChangePasswordDto':
          return new ChangePasswordDto.fromJson(value);
        case 'ChangeRestaurantSettingsDto':
          return new ChangeRestaurantSettingsDto.fromJson(value);
        case 'ChangeSettingDto':
          return new ChangeSettingDto.fromJson(value);
        case 'ChangeStatusDto':
          return new ChangeStatusDto.fromJson(value);
        case 'ChangeUiThemeInput':
          return new ChangeUiThemeInput.fromJson(value);
        case 'ChangeUserLanguageDto':
          return new ChangeUserLanguageDto.fromJson(value);
        case 'CityDto':
          return new CityDto.fromJson(value);
        case 'ConfigurationCityDto':
          return new ConfigurationCityDto.fromJson(value);
        case 'ConfigurationCountryDto':
          return new ConfigurationCountryDto.fromJson(value);
        case 'ConfigurationRegionDto':
          return new ConfigurationRegionDto.fromJson(value);
        case 'CountryDto':
          return new CountryDto.fromJson(value);
        case 'CreateCategoryDto':
          return new CreateCategoryDto.fromJson(value);
        case 'CreateCustomerDto':
          return new CreateCustomerDto.fromJson(value);
        case 'CreateCustomerReportDto':
          return new CreateCustomerReportDto.fromJson(value);
        case 'CreateEventDto':
          return new CreateEventDto.fromJson(value);
        case 'CreateGalleryItemDto':
          return new CreateGalleryItemDto.fromJson(value);
        case 'CreateMealDto':
          return new CreateMealDto.fromJson(value);
        case 'CreateOfferDto':
          return new CreateOfferDto.fromJson(value);
        case 'CreateOrUpdateReviewDto':
          return new CreateOrUpdateReviewDto.fromJson(value);
        case 'CreatePickupMealDto':
          return new CreatePickupMealDto.fromJson(value);
        case 'CreateDeliveryMealDto':
          return new CreateDeliveryMealDto.fromJson(value);
        case 'CreatePickupDto':
          return new CreatePickupDto.fromJson(value);
        case 'CreateDeliveryDto':
          return new CreateDeliveryDto.fromJson(value);
        case 'CreateReservationDto':
          return new CreateReservationDto.fromJson(value);
        case 'CreateRestaurantDto':
          return new CreateRestaurantDto.fromJson(value);
        case 'CreateRestaurantReportDto':
          return new CreateRestaurantReportDto.fromJson(value);
        case 'CreateRoleDto':
          return new CreateRoleDto.fromJson(value);
        case 'CreateServiceDto':
          return new CreateServiceDto.fromJson(value);
        case 'CreateTenantDto':
          return new CreateTenantDto.fromJson(value);
        case 'CreateUserDto':
          return new CreateUserDto.fromJson(value);
        case 'CreateVisitorContactInfoDto':
          return new CreateVisitorContactInfoDto.fromJson(value);
        case 'CustomerDto':
          return new CustomerDto.fromJson(value);
        case 'CustomerEventDto':
          return new CustomerEventDto.fromJson(value);
        case 'CustomerNearestPickupDto':
          return new CustomerNearestPickupDto.fromJson(value);
        case 'CustomerNearestReservationDto':
          return new CustomerNearestReservationDto.fromJson(value);
        case 'CustomerNearestDeliveryDto':
          return new CustomerNearestDeliveryDto.fromJson(value);
        case 'CustomerUpcomingServiceDto':
          return new CustomerUpcomingServiceDto.fromJson(value);
        case 'CustomerUpcomingPickupMealDto':
          return new CustomerUpcomingPickupMealDto.fromJson(value);
        case 'CustomerUpcomingDeliveryMealDto':
          return new CustomerUpcomingDeliveryMealDto.fromJson(value);
        case 'CustomerUpcomingPickupDto':
          return new CustomerUpcomingPickupDto.fromJson(value);
        case 'CustomerUpcomingDeliveryDto':
          return new CustomerUpcomingDeliveryDto.fromJson(value);
        case 'CustomerUpcomingDeliveriesDto':
          return new CustomerUpcomingDeliveriesDto.fromJson(value);
        case 'CustomerUpcomingPickupsDto':
          return new CustomerUpcomingPickupsDto.fromJson(value);
        case 'CustomerOfferDto':
          return new CustomerOfferDto.fromJson(value);
        case 'CustomerOldPickupDto':
          return new CustomerOldPickupDto.fromJson(value);
        case 'CustomerOldPickupsDto':
          return new CustomerOldPickupsDto.fromJson(value);
        case 'CustomerOldDeliveryDto':
          return new CustomerOldDeliveryDto.fromJson(value);
        case 'CustomerOldDeliveriesDto':
          return new CustomerOldDeliveriesDto.fromJson(value);
        case 'CustomerOldReservationDto':
          return new CustomerOldReservationDto.fromJson(value);
        case 'CustomerOldReservationsDto':
          return new CustomerOldReservationsDto.fromJson(value);
        case 'CustomerProfileDto':
          return new CustomerProfileDto.fromJson(value);
        case 'CustomerReportDto':
          return new CustomerReportDto.fromJson(value);
        case 'CustomerUpcomingReservationDto':
          return new CustomerUpcomingReservationDto.fromJson(value);
        case 'CustomerUpcomingReservationsDto':
          return new CustomerUpcomingReservationsDto.fromJson(value);
        case 'EntityDtoInt64':
          return new EntityDtoInt64.fromJson(value);
        case 'EnumValue':
          return new EnumValue.fromJson(value);
        case 'ExternalAuthenticateModel':
          return new ExternalAuthenticateModel.fromJson(value);
        case 'ExternalAuthenticateResultModel':
          return new ExternalAuthenticateResultModel.fromJson(value);
        case 'ExternalLoginProviderInfoModel':
          return new ExternalLoginProviderInfoModel.fromJson(value);
        case 'FeaturedAndNearbyRestaurantDto':
          return new FeaturedAndNearbyRestaurantDto.fromJson(value);
        case 'FileDto':
          return new FileDto.fromJson(value);
        case 'FileURLDto':
          return new FileURLDto.fromJson(value);
        case 'FlatPermissionDto':
          return new FlatPermissionDto.fromJson(value);
        case 'GalleryDto':
          return new GalleryDto.fromJson(value);
        case 'GalleryItemDto':
          return new GalleryItemDto.fromJson(value);
        case 'GetCurrentLoginInformationsOutput':
          return new GetCurrentLoginInformationsOutput.fromJson(value);
        case 'GetRoleForEditOutput':
          return new GetRoleForEditOutput.fromJson(value);
        case 'IPapricaItemModelDto':
          return new IPapricaItemModelDto.fromJson(value);
        case 'ISettingValue':
          return new ISettingValue.fromJson(value);
        case 'IngredientDto':
          return new IngredientDto.fromJson(value);
        case 'InitializationDto':
          return new InitializationDto.fromJson(value);
        case 'IsTenantAvailableInput':
          return new IsTenantAvailableInput.fromJson(value);
        case 'IsTenantAvailableOutput':
          return new IsTenantAvailableOutput.fromJson(value);
        case 'ListResultDtoPermissionDto':
          return new ListResultDtoPermissionDto.fromJson(value);
        case 'ListResultDtoRoleDto':
          return new ListResultDtoRoleDto.fromJson(value);
        case 'ListResultDtoRoleListDto':
          return new ListResultDtoRoleListDto.fromJson(value);
        case 'ManagerEventDto':
          return new ManagerEventDto.fromJson(value);
        case 'ManagerOfferDto':
          return new ManagerOfferDto.fromJson(value);
        case 'MassageDto':
          return new MassageDto.fromJson(value);
        case 'MealDto':
          return new MealDto.fromJson(value);
        case 'MealRateDto':
          return new MealRateDto.fromJson(value);
        case 'MediaDto':
          return new MediaDto.fromJson(value);
        case 'NotificationInfoDto':
          return new NotificationInfoDto.fromJson(value);
        case 'NotificationsInfoDto':
          return new NotificationsInfoDto.fromJson(value);
        case 'OpeningTimeDto':
          return new OpeningTimeDto.fromJson(value);
        case 'PagedResultDtoConfigurationCityDto':
          return new PagedResultDtoConfigurationCityDto.fromJson(value);
        case 'PagedResultDtoConfigurationCountryDto':
          return new PagedResultDtoConfigurationCountryDto.fromJson(value);
        case 'PagedResultDtoConfigurationRegionDto':
          return new PagedResultDtoConfigurationRegionDto.fromJson(value);
        case 'PagedResultDtoCustomerDto':
          return new PagedResultDtoCustomerDto.fromJson(value);
        case 'PagedResultDtoCustomerEventDto':
          return new PagedResultDtoCustomerEventDto.fromJson(value);
        case 'PagedResultDtoCustomerOfferDto':
          return new PagedResultDtoCustomerOfferDto.fromJson(value);
        case 'PagedResultDtoGalleryItemDto':
          return new PagedResultDtoGalleryItemDto.fromJson(value);
        case 'PagedResultDtoManagerEventDto':
          return new PagedResultDtoManagerEventDto.fromJson(value);
        case 'PagedResultDtoManagerOfferDto':
          return new PagedResultDtoManagerOfferDto.fromJson(value);
        case 'PagedResultDtoReportDto':
          return new PagedResultDtoReportDto.fromJson(value);
        case 'PagedResultDtoReservationDto':
          return new PagedResultDtoReservationDto.fromJson(value);
        case 'PagedResultDtoRestaurantDto':
          return new PagedResultDtoRestaurantDto.fromJson(value);
        case 'PagedResultDtoRestaurantLiteDto':
          return new PagedResultDtoRestaurantLiteDto.fromJson(value);
        case 'PagedResultDtoRestaurantSummaryDto':
          return new PagedResultDtoRestaurantSummaryDto.fromJson(value);
        case 'PagedResultDtoReviewDto':
          return new PagedResultDtoReviewDto.fromJson(value);
        case 'PagedResultDtoRoleDto':
          return new PagedResultDtoRoleDto.fromJson(value);
        case 'PagedResultDtoServiceDto':
          return new PagedResultDtoServiceDto.fromJson(value);
        case 'PagedResultDtoTenantDto':
          return new PagedResultDtoTenantDto.fromJson(value);
        case 'PagedResultDtoUserDto':
          return new PagedResultDtoUserDto.fromJson(value);
        case 'PagedResultDtoVisitorContactInfoDto':
          return new PagedResultDtoVisitorContactInfoDto.fromJson(value);
        case 'PermissionDto':
          return new PermissionDto.fromJson(value);
        case 'PapricaItemDto':
          return new PapricaItemDto.fromJson(value);
        case 'PapricaItemQueryDto':
          return new PapricaItemQueryDto.fromJson(value);
        case 'PapricaItemStampDto':
          return new PapricaItemStampDto.fromJson(value);
        case 'PapricaItemsDto':
          return new PapricaItemsDto.fromJson(value);
        case 'RegionDto':
          return new RegionDto.fromJson(value);
        case 'RegisterInput':
          return new RegisterInput.fromJson(value);
        case 'RegisterOutput':
          return new RegisterOutput.fromJson(value);
        case 'ReportDto':
          return new ReportDto.fromJson(value);
        case 'ReservationDto':
          return new ReservationDto.fromJson(value);
        case 'ResetPasswordDto':
          return new ResetPasswordDto.fromJson(value);
        case 'RestaurantDto':
          return new RestaurantDto.fromJson(value);
        case 'RestaurantEventDto':
          return new RestaurantEventDto.fromJson(value);
        case 'RestaurantHomeDto':
          return new RestaurantHomeDto.fromJson(value);
        case 'RestaurantLiteDto':
          return new RestaurantLiteDto.fromJson(value);
        case 'RestaurantOldReservationDto':
          return new RestaurantOldReservationDto.fromJson(value);
        case 'RestaurantOldReservationsDto':
          return new RestaurantOldReservationsDto.fromJson(value);
        case 'RestaurantProfileDto':
          return new RestaurantProfileDto.fromJson(value);
        case 'RestaurantRatersDto':
          return new RestaurantRatersDto.fromJson(value);
        case 'RestaurantReportDto':
          return new RestaurantReportDto.fromJson(value);
        case 'RestaurantReservationDashboardDto':
          return new RestaurantReservationDashboardDto.fromJson(value);
        case 'RestaurantReviewsSummaryDto':
          return new RestaurantReviewsSummaryDto.fromJson(value);
        case 'RestaurantSettingsDto':
          return new RestaurantSettingsDto.fromJson(value);
        case 'RestaurantSummaryDto':
          return new RestaurantSummaryDto.fromJson(value);
        case 'RestaurantUpcomingReservationDto':
          return new RestaurantUpcomingReservationDto.fromJson(value);
        case 'RestaurantUpcomingReservationsDto':
          return new RestaurantUpcomingReservationsDto.fromJson(value);
        case 'ReviewDto':
          return new ReviewDto.fromJson(value);
        case 'ReviewSummaryDto':
          return new ReviewSummaryDto.fromJson(value);
        case 'RoleDto':
          return new RoleDto.fromJson(value);
        case 'RoleEditDto':
          return new RoleEditDto.fromJson(value);
        case 'RoleListDto':
          return new RoleListDto.fromJson(value);
        case 'SearchResultDto':
          return new SearchResultDto.fromJson(value);
        case 'ServiceDto':
        return new ServiceDto.fromJson(value);
        case 'DeliveryRegionDto':
          return new DeliveryRegionDto.fromJson(value);
        case 'DeliveryRegionsDto':
          return new DeliveryRegionsDto.fromJson(value);
        case 'TenantDto':
          return new TenantDto.fromJson(value);
        case 'TenantLoginInfoDto':
          return new TenantLoginInfoDto.fromJson(value);
        case 'TenantNotificationInfo':
          return new TenantNotificationInfo.fromJson(value);
        case 'TypesDto':
          return new TypesDto.fromJson(value);
        case 'UpdateActivationStatusDto':
          return new UpdateActivationStatusDto.fromJson(value);
        case 'UpdateCategoryDto':
          return new UpdateCategoryDto.fromJson(value);
        case 'UpdateCustomerProfileDto':
          return new UpdateCustomerProfileDto.fromJson(value);
        case 'UpdateEventDto':
          return new UpdateEventDto.fromJson(value);
        case 'UpdatePickupMealDto':
          return new UpdatePickupMealDto.fromJson(value);
        case 'UpdateDeliveryMealDto':
          return new UpdateDeliveryMealDto.fromJson(value);
        case 'UpdatePickupMealRequestDto':
          return new UpdatePickupMealRequestDto.fromJson(value);
        case 'UpdateDeliveryMealRequestDto':
          return new UpdateDeliveryMealRequestDto.fromJson(value);
        case 'UpdatePickupDto':
          return new UpdatePickupDto.fromJson(value);
        case 'UpdateDeliveryDto':
          return new UpdateDeliveryDto.fromJson(value);
        case 'UpdatePickupRequestDto':
          return new UpdatePickupRequestDto.fromJson(value);
        case 'UpdateDeliveryRequestDto':
          return new UpdateDeliveryRequestDto.fromJson(value);
        case 'UpdateGalleryItemDto':
          return new UpdateGalleryItemDto.fromJson(value);
        case 'UpdateIsFeaturedDto':
          return new UpdateIsFeaturedDto.fromJson(value);
        case 'UpdateMealDto':
          return new UpdateMealDto.fromJson(value);
        case 'UpdateOfferDto':
          return new UpdateOfferDto.fromJson(value);
        case 'UpdateOpeningTimeDto':
          return new UpdateOpeningTimeDto.fromJson(value);
        case 'UpdateReservationDto':
          return new UpdateReservationDto.fromJson(value);
        case 'UpdateReservationRequestDto':
          return new UpdateReservationRequestDto.fromJson(value);
        case 'UpdateRestaurantProfileDto':
          return new UpdateRestaurantProfileDto.fromJson(value);
        case 'UpdateReviewStatusDto':
          return new UpdateReviewStatusDto.fromJson(value);
        case 'UpdateServiceDto':
          return new UpdateServiceDto.fromJson(value);
        case 'UpdateStatusDto':
          return new UpdateStatusDto.fromJson(value);
        case 'UserDto':
          return new UserDto.fromJson(value);
        case 'UserLoginInfoDto':
          return new UserLoginInfoDto.fromJson(value);
        case 'UserNotificationInfo':
          return new UserNotificationInfo.fromJson(value);
        case 'UserNotificationInfoWithNotificationInfo':
          return new UserNotificationInfoWithNotificationInfo.fromJson(value);
        case 'VisitorContactInfoDto':
          return new VisitorContactInfoDto.fromJson(value);
        case 'PlacesResponse':
          return new PlacesResponse.fromJson(value);
        case 'PublishedPollInPapricaItem':
          return new PublishedPollInPapricaItem.fromJson(value);
        case 'PublishedPollItem':
          return new PublishedPollItem.fromJson(value);
        case 'OpenPollInPapricaItem':
          return new OpenPollInPapricaItem.fromJson(value);
        case 'OpenPollItem':
          return new OpenPollItem.fromJson(value);
        case 'RestaurantPollInPapricaItem':
          return new RestaurantPollInPapricaItem.fromJson(value);
        case 'MealInPublishedPollInPapricaItem':
          return new MealInPublishedPollInPapricaItem.fromJson(value);
        default:
          {
            Match match;
            if (value is List &&
                (match = _RegList.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return value.map((v) => _deserialize(v, newTargetType)).toList();
            } else if (value is Map &&
                (match = _RegMap.firstMatch(targetType)) != null) {
              var newTargetType = match[1];
              return new Map.fromIterables(value.keys,
                  value.values.map((v) => _deserialize(v, newTargetType)));
            }
          }
      }
    } catch (e, stack) {
      throw new ApiException.withInner(
          500, 'Exception during deserialization.', e, stack);
    }
    throw new ApiException(
        500, 'Could not find a suitable class for deserialization');
  }

  dynamic deserialize(String jsonVal, String targetType) {
    // Remove all spaces.  Necessary for reg expressions as well.
    targetType = targetType.replaceAll(' ', '');

    if (targetType == 'String') return jsonVal;

    var decodedJson = json.decode(jsonVal);
    if (targetType == "PlacesResponse")
      return _deserialize(decodedJson, targetType);
    else
      return _deserialize(decodedJson["result"], targetType);
  }

  String serialize(Object obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi' a key might appear multiple times.
  Future<Response> invokeAPI(
      String path,
      String method,
      Iterable<QueryParam> queryParams,
      Object body,
      Map<String, String> headerParams,
      Map<String, String> formParams,
      String contentType,
      List<String> authNames) async {
    _updateParamsForAuth(authNames, queryParams, headerParams);

    var ps = queryParams
        .where((p) => p.value != null)
        .map((p) => '${p.name}=${p.value}');
    String queryString = ps.isNotEmpty ? '?' + ps.join('&') : '';

    String url = basePath + path + queryString;

    headerParams.addAll(_defaultHeaderMap);
    headerParams['Content-Type'] = contentType;

    if (body is MultipartRequest) {
      var request = new MultipartRequest(method, Uri.parse(url));
      request.fields.addAll(body.fields);
      request.files.addAll(body.files);
      request.headers.addAll(body.headers);
      request.headers.addAll(headerParams);
      var response = await client.send(request);
      return Response.fromStream(response);
    } else {
      var msgBody = contentType == "application/x-www-form-urlencoded"
          ? formParams
          : serialize(body);
      switch (method) {
        case "POST":
          return client.post(url, headers: headerParams, body: msgBody);
        case "PUT":
          return client.put(url, headers: headerParams, body: msgBody);
        case "DELETE":
          return client.delete(url, headers: headerParams);
        case "PATCH":
          return client.patch(url, headers: headerParams, body: msgBody);
        default:
          return client.get(url, headers: headerParams);
      }
    }
  }

  /// Update query and header parameters based on authentication settings.
  /// @param authNames The authentications to apply
  void _updateParamsForAuth(List<String> authNames,
      List<QueryParam> queryParams, Map<String, String> headerParams) {
    authNames.forEach((authName) {
      Authentication auth = _authentications[authName];
      if (auth == null)
        throw new ArgumentError("Authentication undefined: " + authName);
      auth.applyToParams(queryParams, headerParams);
    });
  }

  void setAccessToken(String accessToken) {
    _authentications.forEach((key, auth) {
      if (auth is OAuth) {
        auth.setAccessToken(accessToken);
      }
    });
  }

  void setApiKey(int scope, String key) {
    if (scope != null) this.addDefaultHeader("X-Api-Scope", scope.toString());
    if (key != null) this.addDefaultHeader("X-Api-Key", key);
  }
}
