part of swagger.api;

class QueryParam {
  String name;
  String value;

  QueryParam(this.name, this.value);
}

class ApiClient {
  String basePath;
  var client = new BrowserClient();

  Map<String, String> _defaultHeaderMap = {};
  Map<String, Authentication> _authentications = {};

  final _RegList = new RegExp(r'^List<(.*)>$');
  final _RegMap = new RegExp(r'^Map<String,(.*)>$');

  ApiClient({this.basePath: "https://localhost/Inside.Api"}) {
    // Setup authentications (key: authentication name, value: authentication).
    _authentications['oauth2'] = new OAuth();
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
        case 'SoftUpPaprikaInsideAfterDishesAfterDishDto':
          return new SoftUpPaprikaInsideAfterDishesAfterDishDto.fromJson(value);
        case 'SoftUpPaprikaInsideAfterDishesAfterDishRequestDto':
          return new SoftUpPaprikaInsideAfterDishesAfterDishRequestDto.fromJson(
              value);
        case 'SoftUpPaprikaInsideCategoriesCategoryDto':
          return new SoftUpPaprikaInsideCategoriesCategoryDto.fromJson(value);
        case 'SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto':
          return new SoftUpPaprikaInsideCustomerTablesCreateCustomerTableDto
              .fromJson(value);
        case 'SoftUpPaprikaInsideCustomerTablesCreateOrderDto':
          return new SoftUpPaprikaInsideCustomerTablesCreateOrderDto.fromJson(
              value);
        case 'SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto':
          return new SoftUpPaprikaInsideCustomerTablesCreateOrderMealDto
              .fromJson(value);
        case 'SoftUpPaprikaInsideCustomerTablesOrderDto':
          return new SoftUpPaprikaInsideCustomerTablesOrderDto.fromJson(value);
        case 'SoftUpPaprikaInsideCustomerTablesOrderMealDto':
          return new SoftUpPaprikaInsideCustomerTablesOrderMealDto.fromJson(
              value);
        case 'SoftUpPaprikaInsideCustomerTablesUpdateOrderDto':
          return new SoftUpPaprikaInsideCustomerTablesUpdateOrderDto.fromJson(
              value);
        case 'SoftUpPaprikaInsideInvoicesInvoiceDto':
          return new SoftUpPaprikaInsideInvoicesInvoiceDto.fromJson(value);
        case 'SoftUpPaprikaInsideInvoicesInvoiceTaxDto':
          return new SoftUpPaprikaInsideInvoicesInvoiceTaxDto.fromJson(value);
        case 'SoftUpPaprikaInsideMealsMealDto':
          return new SoftUpPaprikaInsideMealsMealDto.fromJson(value);
        case 'SoftUpPaprikaInsideMealsMealIngredientDto':
          return new SoftUpPaprikaInsideMealsMealIngredientDto.fromJson(value);
        case 'SoftUpPaprikaInsideMealsMealVariantDto':
          return new SoftUpPaprikaInsideMealsMealVariantDto.fromJson(value);
        case 'SoftUpPaprikaInsidePlaylistsPlaylistDto':
          return new SoftUpPaprikaInsidePlaylistsPlaylistDto.fromJson(value);
        case 'SoftUpPaprikaInsidePlaylistsTrackDto':
          return new SoftUpPaprikaInsidePlaylistsTrackDto.fromJson(value);
        case 'SoftUpPaprikaInsidePlaylistsTrackRequestDto':
          return new SoftUpPaprikaInsidePlaylistsTrackRequestDto.fromJson(
              value);
        case 'SoftUpPaprikaInsideRestaurantsFeedbackDto':
          return new SoftUpPaprikaInsideRestaurantsFeedbackDto.fromJson(value);
        case 'SoftUpPaprikaInsideRestaurantsRestaurantDto':
          return new SoftUpPaprikaInsideRestaurantsRestaurantDto.fromJson(
              value);
        case 'SoftUpPaprikaInsideTypesInvoiceStatus':
          return new SoftUpPaprikaInsideTypesInvoiceStatus.fromJson(value);
        case 'SoftUpPaprikaInsideTypesOrderStatus':
          return new SoftUpPaprikaInsideTypesOrderStatus.fromJson(value);
        case 'SoftUpPaprikaInsideTypesPagerType':
          return new SoftUpPaprikaInsideTypesPagerType.fromJson(value);
        case 'SoftUpPaprikaInsideTypesRestaurantStatus':
          return new SoftUpPaprikaInsideTypesRestaurantStatus.fromJson(value);
        case 'SoftUpPaprikaInsideTypesTableStatus':
          return new SoftUpPaprikaInsideTypesTableStatus.fromJson(value);
        case 'SoftUpPaprikaInsideTypesTaxType':
          return new SoftUpPaprikaInsideTypesTaxType.fromJson(value);
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
    return _deserialize(decodedJson, targetType);
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
}
