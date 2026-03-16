part of swagger_inside.api;

const _delimiters = const {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};

// port from Java version
Iterable<QueryParam> _convertParametersForCollectionFormat(
    String collectionFormat, String name, dynamic value) {
  var params = <QueryParam>[];

  // preconditions
  if (name == null || name.isEmpty || value == null) return params;

  if (value is! List) {
    params.add(new QueryParam(name, parameterToString(value)));
    return params;
  }

  List values = value as List;

  // get the collection format
  collectionFormat = (collectionFormat == null || collectionFormat.isEmpty)
      ? "csv"
      : collectionFormat; // default: csv

  if (collectionFormat == "multi") {
    return values.map((v) => new QueryParam(name, parameterToString(v)));
  }

  String delimiter = _delimiters[collectionFormat] ?? ",";

  params.add(new QueryParam(
      name, values.map((v) => parameterToString(v)).join(delimiter)));
  return params;
}

/// Format the given parameter object into string.
String parameterToString(dynamic value) {
  if (value == null) {
    return '';
  } else if (value is DateTime) {
    return value.toUtc().toIso8601String();
  } else if (value is TypesInvoiceStatus) {
    return TypesInvoiceStatus.encode(value).toString();
  } else if (value is TypesOrderStatus) {
    return TypesOrderStatus.encode(value).toString();
  } else if (value is TypesPagerType) {
    return TypesPagerType.encode(value).toString();
  } else if (value is TypesRestaurantStatus) {
    return TypesRestaurantStatus.encode(value).toString();
  } else if (value is TypesTableStatus) {
    return TypesTableStatus.encode(value).toString();
  } else if (value is TypesTaxType) {
    return TypesTaxType.encode(value).toString();
  } else {
    return value.toString();
  }
}
