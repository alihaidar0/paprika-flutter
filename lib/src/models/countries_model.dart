class CountriesTreeModel {
  List<CountryModel> countries = [];
}

class CountryModel {
  int id;
  String name;
  List<CityModel> cities = [];

  CountryModel(this.id, this.name);
}

class CityModel {
  int id;
  String name;
  List<RegionModel> regions = [];

  CityModel(this.id, this.name);
}

class RegionModel {
  int id;
  String name;

  RegionModel(this.id, this.name);
}
