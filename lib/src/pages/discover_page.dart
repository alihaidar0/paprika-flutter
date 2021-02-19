import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:paprica/src/models/countries_model.dart';
import 'package:paprica/src/models/paprica_filter_model.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/widgets.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';
import '../../utils.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage();

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  PapricaFilterModel filterModel;

  StreamController<bool> clearStreamController;
  StreamController<bool> refreshPlacesStreamController;

  List<String> places;
  List<String> cuisines;
  List<String> amenities;
  List<String> ambiance;
  List<String> musicTypes;
  List<String> parkingTypes;

  LocationData locationData;
  bool isNearby;
  int countryId;
  int cityId;
  int regionId;

  LocationData currentLocation;
  String lang;

  @override
  void initState() {
    super.initState();
    filterModel = PapricaFilterModel();
    clearStreamController = StreamController<bool>.broadcast();
    refreshPlacesStreamController = StreamController<bool>.broadcast();
  }

  @override
  void dispose() {
    clearStreamController.close();
    refreshPlacesStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _loadTypes(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).discover,
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 100,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        "assets/images/background.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.transparent,
                            Colors.black45,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8),
                    child: Text(
                      S.of(context).filterCoverSentence,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  preferredSize: Size(MediaQuery.of(context).size.width, 40)),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ByLocationFilter(
                        refreshPlacesController:
                            refreshPlacesStreamController.stream,
                        clearParamsStream: clearStreamController.stream,
                        onChanged: (locationData, isNearby, countryId, cityId,
                            regionId) {
                          this.locationData = locationData;
                          this.isNearby = isNearby;
                          this.countryId = countryId;
                          this.cityId = cityId;
                          this.regionId = regionId;
                        },
                      ),
                      SizedBox(height: 10),
                      FilterQueryParameter(
                        title: S.of(context).byPlaces,
                        values: places,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.placesSelections = selections;
                        },
                      ),
                      SizedBox(height: 10),
                      FilterQueryParameter(
                        title: S.of(context).byCuisines,
                        values: cuisines,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.cuisinesSelections = selections;
                        },
                      ),
                      SizedBox(height: 10),
                      FilterQueryParameter(
                        title: S.of(context).byAmenities,
                        values: amenities,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.amenitiesSelections = selections;
                        },
                      ),
                      SizedBox(height: 10),
                      FilterQueryParameter(
                        title: S.of(context).byAmbiance,
                        values: ambiance,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.ambianceSelections = selections;
                        },
                      ),
                      SizedBox(height: 10),
                      FilterQueryParameter(
                        title: S.of(context).byMusic,
                        values: musicTypes,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.musicTypesSelections = selections;
                        },
                      ),
                      SizedBox(height: 10),
                      FilterQueryParameter(
                        title: S.of(context).byParking,
                        values: parkingTypes,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.parkingTypesSelections = selections;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              S.of(context).otherWord,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              StringRadioButton(
                                S.of(context).outdoor,
                                duration: Duration(milliseconds: 1),
                                radioValue: filterModel.hasOutdoorValue,
                                onRadioTab: (value) {
                                  setState(() {
                                    if (filterModel.hasOutdoorValue == null ||
                                        filterModel.hasOutdoorValue.isEmpty)
                                      filterModel.hasOutdoorValue = value;
                                    else
                                      filterModel.hasOutdoorValue = null;
                                  });
                                },
                              ),
                              StringRadioButton(
                                S.of(context).smokeFree,
                                duration: Duration(milliseconds: 1),
                                radioValue: filterModel.smokeValue,
                                onRadioTab: (value) {
                                  setState(() {
                                    if (filterModel.smokeValue == null ||
                                        filterModel.smokeValue.isEmpty)
                                      filterModel.smokeValue = value;
                                    else
                                      filterModel.smokeValue = null;
                                  });
                                },
                              ),
                              StringRadioButton(
                                S.of(context).alcoholFree,
                                duration: Duration(milliseconds: 1),
                                radioValue: filterModel.alcoholValue,
                                onRadioTab: (value) {
                                  setState(() {
                                    if (filterModel.alcoholValue == null ||
                                        filterModel.alcoholValue.isEmpty)
                                      filterModel.alcoholValue = value;
                                    else
                                      filterModel.alcoholValue = null;
                                  });
                                },
                              ),
                              StringRadioButton(
                                S.of(context).twentyFourSeven,
                                duration: Duration(milliseconds: 1),
                                radioValue: filterModel.twentyFourValue,
                                onRadioTab: (value) {
                                  setState(() {
                                    if (filterModel.twentyFourValue == null ||
                                        filterModel.twentyFourValue.isEmpty)
                                      filterModel.twentyFourValue = value;
                                    else
                                      filterModel.twentyFourValue = null;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 70),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
                  child: Text("X",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                )),
            onTap: () {
              if (filterModel.isFilterNotEmpty) {
                PapricaToast.showToast(
                    S.of(context).filterCleared, ToastType.Normal);
              }
              clearStreamController.add(true);

              setState(() {
                filterModel.hasOutdoorValue = null;
                filterModel.smokeValue = null;
                filterModel.alcoholValue = null;
                filterModel.twentyFourValue = null;
              });
            },
          ),
          SizedBox(width: 4),
          CustomizedActiveButton(
            onPressed: () {
              _onFindPressed(context);
            },
            title: S.of(context).find,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _onFindPressed(BuildContext context) async {
    ApiTypesHelper helper = ApiTypesHelper();
    ApiClient client = PapricaApiClient();
    PlacesApi api = PlacesApi(client);
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).findingRestaurants);

    //todo: use isNearby in PapricaFilterModel
//    if (isNearby != null && isNearby) {
//      currentLocation = await LocationProvider.getLocation().catchError((err) {
//        debugPrint(err.toString());
//      });
//    }

    dialog.show();
    api
        .apiServicesAppPlacesGetAllGet(
      restaurantTypes:
          helper.calculateTypeValue(filterModel.placesSelections, Type.places),
      cuisineTypes: helper.calculateTypeValue(
          filterModel.cuisinesSelections, Type.cuisines),
      ambianceType: helper.calculateTypeValue(
          filterModel.ambianceSelections, Type.ambiance),
      amenityTypes: helper.calculateTypeValue(
          filterModel.amenitiesSelections, Type.amenities),
      musicType: helper.calculateTypeValue(
          filterModel.musicTypesSelections, Type.music),
      parkingType: helper.calculateTypeValue(
          filterModel.parkingTypesSelections, Type.parking),
      hasOutdoor: filterModel.outdoor,
      isSmokeFree: filterModel.smokeFree,
      isAlcoholFree: filterModel.alcoholFree,
      is24Hour: filterModel.twentyFourHour,
      longitude: currentLocation != null ? currentLocation.longitude : null,
      latitude: currentLocation != null ? currentLocation.latitude : null,
    )
        .then((restaurantsDto) {
      dialog.hide();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return RestaurantsListScreen(
          restaurants: restaurantsDto?.items,
          title: S.of(context).discover,
          filterModel: PapricaFilterModel.deepCopy(filterModel),
        );
      }));
    }).catchError((err) {
      dialog.hide();
    });
  }

  void _loadTypes(context) {
    if (lang == null || lang != Localizations.localeOf(context).languageCode) {
      setState(() {
        lang = Localizations.localeOf(context).languageCode;
        ApiTypesHelper helper = ApiTypesHelper();
        places = helper.getTypeNames(Type.places);
        cuisines = helper.getTypeNames(Type.cuisines);
        amenities = helper.getTypeNames(Type.amenities);
        ambiance = helper.getTypeNames(Type.ambiance);
        musicTypes = helper.getTypeNames(Type.music);
        parkingTypes = helper.getTypeNames(Type.parking);
      });
      refreshPlacesStreamController.add(true);
    }
  }
}

typedef FilterQueryParameterSelectionCallback(List<String> selections);

class FilterQueryParameter extends StatefulWidget {
  final List<String> values;
  final String title;
  final FilterQueryParameterSelectionCallback selectionCallback;
  final Stream<bool> clearParamsStream;

  const FilterQueryParameter(
      {@required this.title,
      @required this.values,
      this.selectionCallback,
      this.clearParamsStream});

  @override
  _FilterQueryParameterState createState() => _FilterQueryParameterState();
}

class _FilterQueryParameterState extends State<FilterQueryParameter> {
  bool _isShown;
  Map<String, String> selections;

  @override
  void initState() {
    super.initState();
    _isShown = false;
    selections = <String, String>{};
    widget.clearParamsStream?.listen((clear) {
      if (clear) {
        selections = <String, String>{};
        if (widget.selectionCallback != null)
          widget.selectionCallback(selections.values.toList());
        _isShown = false;
      }
    });
  }

  bool get isThereSelections {
    return selections.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _isShown = !_isShown;
            });
          },
          child: Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3), topRight: Radius.circular(3))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.title),
                  _isShown
                      ? Icon(Icons.keyboard_arrow_up)
                      : Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ),
        _isShown
            ? AnimatedContainer(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        color: Color(0xFFF2F2F2),
                        margin: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(3),
                                bottomRight: Radius.circular(3))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Wrap(
                                children: widget.values
                                    .map<Widget>((value) => StringRadioButton(
                                          value,
                                          radioValue: selections[value],
                                          duration: Duration(milliseconds: 1),
                                          onRadioTab: (_value) {
                                            setState(() {
                                              if (selections[value] == null) {
                                                selections[value] = _value;
                                              } else {
                                                selections.removeWhere((key,
                                                        _) =>
                                                    selections[key] == value);
                                              }
                                            });
                                            if (widget.selectionCallback !=
                                                null)
                                              widget.selectionCallback(
                                                  selections.values.toList());
                                          },
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                curve: Curves.easeInOut,
                duration: const Duration(seconds: 1),
              )

            /// Show What User Has Selected
            : Container(
                color: Colors.transparent,
                alignment: AlignmentDirectional.centerStart,
                child: isThereSelections
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(S.of(context).selectionPrefix),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .62,
                                  child: Text(
                                    _selectionsAsString(context),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      )

                    /// Nothing to show
                    : Container(child: SizedBox(height: 10)),
              ),
      ],
    );
  }

  String _selectionsAsString(BuildContext context) {
    String result = "";
    List values = selections.values.toList();
    for (int i = 0; i < values.length; i++) {
      result += values[i];
      if (i < values.length - 1) result += " - ";
    }
    return result;
  }
}

typedef FilterByLocationChangedCallback(
  LocationData locationData,
  bool isNearby,
  int countryId,
  int cityId,
  int regionId,
);

class ByLocationFilter extends StatefulWidget {
  final FilterByLocationChangedCallback onChanged;
  final Stream<bool> clearParamsStream;

  final Stream<bool> refreshPlacesController;

  const ByLocationFilter(
      {@required this.onChanged,
      this.clearParamsStream,
      this.refreshPlacesController});

  @override
  _ByLocationFilterState createState() => _ByLocationFilterState();
}

class _ByLocationFilterState extends State<ByLocationFilter> {
  String selectedCountry;
  String selectedCity;
  String selectedRegion;

  bool _isShown;
  Map<int, String> countries;
  Map<int, String> cities;
  Map<int, String> regions;

  LocationData locationData;

  /// Indicated whether should show selection string or not
  get isThereSelections {
    // This condition indicates that the user selected one of two radio buttons
    return regionSelection != null &&
        // Either nearby, or the user at least selected a country
        ((regionSelection && selectedCountry != null) || !regionSelection);
  }

  bool shouldBuildCountryTree;
  bool shouldBuildCityTree;

  // false ->  nearby , true -> user selection
  bool regionSelection;

  Future<CountriesTreeModel> futureCountriesTreeModel;

  String get userSelectionToString {
    if (selectedCountry == null) return null;
    String str = selectedCountry;
    if (selectedCity != null) str += " - " + selectedCity;
    if (selectedRegion != null) str += " - " + selectedRegion;
    return str;
  }

  int _getCountryId(String selectedCountry) {
    if (selectedCountry == null || countries == null) return null;
    return countries.keys
        .firstWhere((key) => countries[key] == selectedCountry);
  }

  int _getCityId(String selectedCity) {
    if (selectedCity == null || cities == null) return null;
    return cities.keys.firstWhere((key) => cities[key] == selectedCity);
  }

  int _getRegionId(String selectedRegion) {
    if (selectedRegion == null || regions == null) return null;
    return regions.keys.firstWhere((key) => regions[key] == selectedRegion);
  }

  @override
  void initState() {
    super.initState();
    _isShown = false;
    countries = Map();
    shouldBuildCountryTree = true;
    shouldBuildCityTree = true;
    futureCountriesTreeModel = ApiTypesHelper().getCountries();
    widget.clearParamsStream?.listen((clear) {
      if (clear) {
        if (widget.onChanged != null &&
            widget.onChanged is FilterByLocationChangedCallback) {
          widget.onChanged(null, null, null, null, null);
        }
        setState(() {
          regionSelection = null;
        });
      }
    });
    widget.refreshPlacesController?.listen((refresh) {
      if (refresh) {
        _loadFreshPlaces();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _isShown = !_isShown;
            });
          },
          child: Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3), topRight: Radius.circular(3))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(S.of(context).byLocation),
                  _isShown
                      ? Icon(Icons.keyboard_arrow_up)
                      : Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ),
        _isShown
            ? AnimatedContainer(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        color: Color(0xFFF2F2F2),
                        margin: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(3),
                                bottomRight: Radius.circular(3))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: FutureBuilder(
                                    future: futureCountriesTreeModel,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if ((countries == null &&
                                                cities == null &&
                                                regions == null) ||
                                            (shouldBuildCountryTree ||
                                                shouldBuildCityTree)) {
                                          _invalidateCountries(snapshot.data);
                                        }
                                        return Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Radio<bool>(
                                                  groupValue: regionSelection,
                                                  onChanged: (bool _value) {
                                                    if (widget.onChanged !=
                                                            null &&
                                                        widget.onChanged
                                                            is FilterByLocationChangedCallback) {
                                                      widget.onChanged(
                                                          null,
                                                          null,
                                                          null,
                                                          null,
                                                          null);
                                                    }
                                                    setState(() {
                                                      regionSelection = _value;
                                                    });
                                                  },
                                                  value: null,
                                                ),
                                                Text(S.of(context).none)
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Radio<bool>(
                                                  groupValue: regionSelection,
                                                  onChanged:
                                                      (bool _value) async {
                                                    locationData =
                                                        await LocationProvider
                                                            .getLocation();
                                                    if (locationData != null) {
                                                      if (widget.onChanged !=
                                                              null &&
                                                          widget.onChanged
                                                              is FilterByLocationChangedCallback) {
                                                        widget.onChanged(
                                                            locationData,
                                                            true,
                                                            null,
                                                            null,
                                                            null);
                                                      }
                                                      setState(() {
                                                        regionSelection =
                                                            _value;
                                                      });
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return PaprikaErrorDialog(
                                                              title: S
                                                                  .of(context)
                                                                  .errorPermissionLocation,
                                                              content: S
                                                                  .of(context)
                                                                  .messageLocationPermission,
                                                              extraButton:
                                                                  FlatButton(
                                                                onPressed: () {
//                                                                  AppSettings.openAppSettings();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(S
                                                                    .of(context)
                                                                    .settings),
                                                              ),
                                                            );
                                                          });
                                                    }
                                                  },
                                                  value: false,
                                                ),
                                                Text(S.of(context).nearby)
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Radio<bool>(
                                                  groupValue: regionSelection,
                                                  onChanged: (bool _value) {
                                                    if (widget.onChanged !=
                                                            null &&
                                                        widget.onChanged
                                                            is FilterByLocationChangedCallback) {
                                                      widget.onChanged(
                                                          null,
                                                          false,
                                                          null,
                                                          null,
                                                          null);
                                                    }
                                                    setState(() {
                                                      regionSelection = _value;
                                                    });
                                                  },
                                                  value: true,
                                                ),
                                                Text(S.of(context).byRegion)
                                              ],
                                            ),
                                            regionSelection != null &&
                                                    regionSelection
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        S.of(context).country,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF747373),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      GestureDetector(
                                                        onTap: () {
                                                          _showCountryPicker(
                                                              context);
                                                        },
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          12),
                                                                  child: Text(
                                                                      selectedCountry ??
                                                                          "-- " +
                                                                              S.of(context).selectCountry),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xFF707070),
                                                                    borderRadius: Localizations.localeOf(context).languageCode ==
                                                                            'en'
                                                                        ? BorderRadius.only(
                                                                            topRight: Radius.circular(
                                                                                3),
                                                                            bottomRight: Radius.circular(
                                                                                3))
                                                                        : BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(3),
                                                                            bottomLeft: Radius.circular(3))),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          6),
                                                                  child: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        S.of(context).city,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF747373),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      GestureDetector(
                                                        onTap: cities != null &&
                                                                cities.length >
                                                                    0
                                                            ? () {
                                                                _showCityPicker(
                                                                    context);
                                                              }
                                                            : null,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: cities !=
                                                                              null &&
                                                                          cities.length >
                                                                              0
                                                                      ? Colors
                                                                          .white
                                                                      : Colors.grey[
                                                                          100],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          12),
                                                                  child: Text(
                                                                    selectedCity ??
                                                                        "-- " +
                                                                            S.of(context).selectCity,
                                                                    style: TextStyle(
                                                                        color: cities != null &&
                                                                                cities.length > 0
                                                                            ? Colors.black
                                                                            : Colors.black12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                                decoration: BoxDecoration(
                                                                    color: cities !=
                                                                                null &&
                                                                            cities.length >
                                                                                0
                                                                        ? Color(
                                                                            0xFF707070)
                                                                        : Colors
                                                                            .black12,
                                                                    borderRadius: Localizations.localeOf(context).languageCode ==
                                                                            'en'
                                                                        ? BorderRadius.only(
                                                                            topRight: Radius.circular(
                                                                                3),
                                                                            bottomRight: Radius.circular(
                                                                                3))
                                                                        : BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(3),
                                                                            bottomLeft: Radius.circular(3))),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          6),
                                                                  child: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        S.of(context).region,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF747373),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3),
                                                      GestureDetector(
                                                        onTap: regions !=
                                                                    null &&
                                                                regions.length >
                                                                    0
                                                            ? () {
                                                                _showRegionPicker(
                                                                    context);
                                                              }
                                                            : null,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: regions !=
                                                                              null &&
                                                                          regions.length >
                                                                              0
                                                                      ? Colors
                                                                          .white
                                                                      : Colors.grey[
                                                                          100],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          12),
                                                                  child: Text(
                                                                    selectedRegion ??
                                                                        "-- " +
                                                                            S.of(context).selectRegion,
                                                                    style: TextStyle(
                                                                        color: regions != null &&
                                                                                regions.length > 0
                                                                            ? Colors.black
                                                                            : Colors.black12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                                decoration: BoxDecoration(
                                                                    color: regions !=
                                                                                null &&
                                                                            regions.length >
                                                                                0
                                                                        ? Color(
                                                                            0xFF707070)
                                                                        : Colors
                                                                            .black12,
                                                                    borderRadius: Localizations.localeOf(context).languageCode ==
                                                                            'en'
                                                                        ? BorderRadius.only(
                                                                            topRight: Radius.circular(
                                                                                3),
                                                                            bottomRight: Radius.circular(
                                                                                3))
                                                                        : BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(3),
                                                                            bottomLeft: Radius.circular(3))),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          6),
                                                                  child: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container(),
                                          ],
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(S.of(context).errorUnknown);
                                      }
                                      return SpinKitThreeBounce(
                                        color: Theme.of(context).primaryColor,
                                        size: 24,
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                curve: Curves.easeInOut,
                duration: const Duration(seconds: 1),
              )

            /// Show What User Has Selected
            : Container(
                color: Colors.transparent,
                alignment: AlignmentDirectional.centerStart,
                child: isThereSelections
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(S.of(context).selectionPrefix),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .62,
                                  child: Text(
                                    _selectionsAsString(context),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      )

                    /// Nothing to show
                    : Container(child: SizedBox(height: 10)),
              ),
      ],
    );
  }

  String _selectionsAsString(BuildContext context) {
    return regionSelection ? userSelectionToString : S.of(context).nearby;
  }

  void _invalidateCountries(CountriesTreeModel countriesTree) {
    countriesTree.countries?.forEach((country) {
      countries[country.id] = country.name;
    });
    if (selectedCountry != null && shouldBuildCountryTree) {
      cities = Map();
      countriesTree.countries
          .where((country) => country.name == selectedCountry)
          .first
          .cities
          .forEach((city) {
        cities[city.id] = city.name;
      });
    }
    if (selectedCity != null && shouldBuildCityTree) {
      regions = Map();
      countriesTree.countries
          .where((country) => country.name == selectedCountry)
          .first
          .cities
          .where((city) => city.name == selectedCity)
          .first
          .regions
          .forEach((region) {
        regions[region.id] = region.name;
      });
    }
  }

  void _showCountryPicker(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter(pickerdata: countries.values.toList()),
        hideHeader: true,
        looping: countries.values.length > 10,
        itemExtent: 50,
        title: Text(S.of(context).selectCountry),
        cancelText: S.of(context).cancel,
        confirmText: S.of(context).ok,
        onSelect: (Picker picker, int i, List<int> list) {},
        onConfirm: (Picker picker, List value) {
          setState(() {
            selectedCountry = picker.getSelectedValues()[0];
            shouldBuildCountryTree = true;
            if (widget.onChanged != null &&
                widget.onChanged is FilterByLocationChangedCallback) {
              widget.onChanged(null, false, _getCountryId(selectedCountry),
                  _getCityId(selectedCity), _getRegionId(selectedRegion));
            }
          });
        }).showDialog(context);
  }

  void _showCityPicker(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter(pickerdata: cities.values.toList()),
        hideHeader: true,
        looping: cities.values.length > 10,
        itemExtent: 50,
        title: Text(S.of(context).selectCity),
        cancelText: S.of(context).cancel,
        confirmText: S.of(context).ok,
        onSelect: (Picker picker, int i, List<int> list) {},
        onConfirm: (Picker picker, List value) {
          if (widget.onChanged != null &&
              widget.onChanged is FilterByLocationChangedCallback) {
            widget.onChanged(null, false, _getCountryId(selectedCountry),
                _getCityId(selectedCity), _getRegionId(selectedRegion));
          }
          setState(() {
            selectedCity = picker.getSelectedValues()[0];
            shouldBuildCityTree = true;
          });
        }).showDialog(context);
  }

  void _showRegionPicker(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter(pickerdata: regions.values.toList()),
        hideHeader: true,
        looping: regions.values.length > 10,
        itemExtent: 50,
        title: Text(S.of(context).selectRegion),
        cancelText: S.of(context).cancel,
        confirmText: S.of(context).ok,
        onSelect: (Picker picker, int i, List<int> list) {},
        onConfirm: (Picker picker, List value) {
          if (widget.onChanged != null &&
              widget.onChanged is FilterByLocationChangedCallback) {
            widget.onChanged(null, false, _getCountryId(selectedCountry),
                _getCityId(selectedCity), _getRegionId(selectedRegion));
          }
          setState(() {
            selectedRegion = picker.getSelectedValues()[0];
          });
        }).showDialog(context);
  }

  void _loadFreshPlaces() {
    setState(() {
      futureCountriesTreeModel = ApiTypesHelper().getCountries();
    });
  }
}
