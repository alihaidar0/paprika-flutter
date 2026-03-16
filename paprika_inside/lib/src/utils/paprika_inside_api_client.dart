import 'package:swagger_inside/api.dart';

class PaprikaInsideApiClient extends ApiClient {
  static final PaprikaInsideApiClient _paprikaInsideApiClient =
      PaprikaInsideApiClient._internal();

  factory PaprikaInsideApiClient() {
    return _paprikaInsideApiClient;
  }

  PaprikaInsideApiClient._internal();

  void setToken(String token) {
    if (token != null)
      this.addDefaultHeader("Authorization", "bearer " + token);
  }

  void setLang(String lang) {
    if (lang != null) this.addDefaultHeader("Accept-Language", lang);
  }

  void setTenant(String tenant) {
    if (tenant != null) this.addDefaultHeader("__tenant", tenant);
  }
}
