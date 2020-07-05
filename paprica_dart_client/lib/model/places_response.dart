part of swagger.api;

PlacesResponse placesResponseFromJson(String str) =>
    PlacesResponse.fromJson(json.decode(str));

String placesResponseToJson(PlacesResponse data) => json.encode(data.toJson());

class PlacesResponse {
  List<Result> result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  PlacesResponse({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        targetUrl: json["targetUrl"],
        success: json["success"],
        error: json["error"],
        unAuthorizedRequest: json["unAuthorizedRequest"],
        abp: json["__abp"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "targetUrl": targetUrl,
        "success": success,
        "error": error,
        "unAuthorizedRequest": unAuthorizedRequest,
        "__abp": abp,
      };
}

class Result {
  String title;
  List<PlacesListItem> items;
  ApiFilterModel filter;

  Result({
    this.title,
    this.items,
    this.filter,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        items: List<PlacesListItem>.from(json["items"].map((x) => PlacesListItem.fromJson(x))),
        filter: ApiFilterModel.fromJson(json["filter"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "filter": filter.toJson(),
      };
}



//class Filter {
//  bool isFeatured;
//  int maxResultCount;
//  int musicType;
//  int restaurantTypes;
//
//  Filter({
//    this.isFeatured,
//    this.maxResultCount,
//    this.musicType,
//    this.restaurantTypes,
//  });
//
//  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
//        isFeatured: json["isFeatured"] == null ? null : json["isFeatured"],
//        maxResultCount: json["maxResultCount"],
//        musicType: json["musicType"] == null ? null : json["musicType"],
//        restaurantTypes:
//            json["restaurantTypes"] == null ? null : json["restaurantTypes"],
//      );
//
//  Map<String, dynamic> toJson() => {
//        "isFeatured": isFeatured == null ? null : isFeatured,
//        "maxResultCount": maxResultCount,
//        "musicType": musicType == null ? null : musicType,
//        "restaurantTypes": restaurantTypes == null ? null : restaurantTypes,
//      };
//}

class PlacesListItem {
  String name;
  String logoImage;
  double restaurantRate;
  bool isOpen;
  int id;

  PlacesListItem({
    this.name,
    this.logoImage,
    this.restaurantRate,
    this.isOpen,
    this.id,
  });

  factory PlacesListItem.fromJson(Map<String, dynamic> json) => PlacesListItem(
        name: json["name"],
        logoImage: json["logoImage"],
        restaurantRate: json["restaurantRate"],
        isOpen: json["isOpen"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "logoImage": logoImage,
        "restaurantRate": restaurantRate,
        "isOpen": isOpen,
        "id": id,
      };
}
