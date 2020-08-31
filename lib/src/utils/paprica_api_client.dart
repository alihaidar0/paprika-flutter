import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

class PapricaApiClient extends ApiClient {
  static final PapricaApiClient _papricaApiClient =
      PapricaApiClient._internal();

  factory PapricaApiClient() {
    return _papricaApiClient;
  }

  PapricaApiClient._internal();

  void setToken(String token) {
    if (token != null)
      this.addDefaultHeader("Authorization", "bearer " + token);
  }

  void setLang(String lang) {
    if (lang != null) this.addDefaultHeader("Paprica-Culture", lang);
  }
}
