import 'dart:async';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paprika/src/models/paprika_filter_model.dart';
import 'package:paprika/src/widgets/rating_bar.dart';
import 'package:paprika/translations.dart';
import 'package:paprika/utils.dart';
import 'package:paprika/widgets.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';

class RestaurantsListScreen extends StatefulWidget {
  final String title;

  final List<RestaurantSummaryDto> restaurants;

  final PaprikaFilterModel filterModel;

  const RestaurantsListScreen({this.title, this.restaurants, this.filterModel});

  @override
  _RestaurantsListScreenState createState() => _RestaurantsListScreenState();
}

class _RestaurantsListScreenState extends State<RestaurantsListScreen> {
  PaprikaFilterModel filterData;
  List<dynamic> restaurants;

  ScrollController _scrollController;

  bool _requestingData;

  BuildContext context;

  bool _endOfRestaurants;

  @override
  void initState() {
    super.initState();
    _requestingData = false;
    _endOfRestaurants = false;
    filterData = widget.filterModel ?? PaprikaFilterModel();
    restaurants = []..addAll(widget.restaurants);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset &&
          !_requestingData &&
          restaurants.isNotEmpty &&
          context != null &&
          !_endOfRestaurants) {
        _requestData(context, filterData, skipCount: restaurants.length);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    if (_requestingData) {
      restaurants.add(SpinKitCircle(color: Colors.grey, size: 32));
    } else {
      if (restaurants != null &&
          restaurants.length > 0 &&
          restaurants.last is SpinKitCircle) {
        restaurants.removeLast();
      }
    }
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          title: Text(S
              .of(context)
              .discover /*widget.title ?? S.of(context).restaurantsForYou*/),
          actions: <Widget>[
            Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _openFilterSheet(context),
                  child: Icon(Icons.filter_alt),
                );
              },
            ),
            IconButton(
              tooltip: S.of(context).viewOnMap,
              icon: Icon(Icons.map),
              onPressed: () {
                if (restaurants != null && restaurants.isNotEmpty) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return RestaurantsMapScreen(
                        restaurants: _extract(restaurants));
                  }));
                } else {
                  PaprikaToast.showToast(
                      S.of(context).noRestaurantsToViewMap, ToastType.Normal);
                }
              },
            ),
          ],
        ),
        body: OnlineStatus(
          child: Stack(
            children: <Widget>[
              CustomScrollView(
                controller: _scrollController,
                physics: restaurants == null || restaurants.isEmpty
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _CustomFilterParamsSliverDelegate(
                        minHeight: filterData.isFilterNotEmpty ? 48.0 : 0,
                        maxHeight: filterData.isFilterNotEmpty ? 130 : 0,
                        filterModel: PaprikaFilterModel.deepCopy(filterData),
                        editFilterCallback: (filterData) =>
                            _editFilterCallback(context, filterData)),
                  ),
                  restaurants != null && restaurants.isNotEmpty
                      ? SliverList(
                          delegate: SliverChildListDelegate(
                            restaurants.map<Widget>((item) {
                                  if (item is RestaurantSummaryDto)
                                    return _RestaurantItem(item);
                                  else
                                    return item;
                                })?.toList() ??
                                [],
                          ),
                        )
                      : SliverFillRemaining(
                          child: Center(
                              child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 2,
                              child: Image.asset(
                                  "assets/images/no_restaurants.png"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                S.of(context).filterNoRestaurants,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _openFilterSheet(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  S.of(context).filterTrySomethingElse,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ))),
                ],
              ),
              _requestingData && false
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.white.withOpacity(.4),
                            Colors.white.withOpacity(.4)
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ));
  }

  void _editFilterCallback(
      BuildContext context, PaprikaFilterModel filterModel) {
    _requestData(context, filterModel);
  }

  void _requestData(BuildContext context, PaprikaFilterModel filter,
      {int skipCount, int maxResult = 5}) {
    if (_requestingData) return;
    setState(() {
      _requestingData = true;
    });
    ApiTypesHelper helper = ApiTypesHelper();
    ApiClient client = PapricaApiClient();
    PlacesApi api = PlacesApi(client);
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).findingRestaurants);
    if (skipCount == null || skipCount == 0) dialog.show();
    api
        .apiServicesAppPlacesGetAllGet(
      skipCount: skipCount ?? 0,
      maxResultCount: maxResult,
      restaurantTypes:
          helper.calculateTypeValue(filter.placesSelections, Type.places),
      cuisineTypes:
          helper.calculateTypeValue(filter.cuisinesSelections, Type.cuisines),
      ambianceType:
          helper.calculateTypeValue(filter.ambianceSelections, Type.ambiance),
      amenityTypes:
          helper.calculateTypeValue(filter.amenitiesSelections, Type.amenities),
      musicType:
          helper.calculateTypeValue(filter.musicTypesSelections, Type.music),
      parkingType: helper.calculateTypeValue(
          filter.parkingTypesSelections, Type.parking),
      hasOutdoor: filter.outdoor,
      isSmokeFree: filter.smokeFree,
      isAlcoholFree: filter.alcoholFree,
      is24Hour: filter.twentyFourHour,
    )
        .then((restaurantsDto) {
      dialog.hide();
      setState(() {
        _requestingData = false;
        // Load More
        if (skipCount != null && skipCount > 0) {
          // Just remove the loader
          if (restaurants.isNotEmpty) {
            restaurants.removeLast();
          }
          if (restaurantsDto.items.isNotEmpty) {
            restaurants.addAll(restaurantsDto.items);
          } else {
            _endOfRestaurants = true;
          }
        }
        // Load Fresh
        else {
          restaurants = []..addAll(restaurantsDto.items);
          filterData = filter;
          _scrollController.animateTo(0,
              duration: Duration(milliseconds: 300), curve: ElasticInCurve());
        }
      });
    }).catchError((err) {
      dialog.hide();
      setState(() {
        _requestingData = false;
      });
    });
  }

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: .5,
            minChildSize: .45,
            maxChildSize: .95,
            builder: (context, scrollController) {
              return QuickFilter(
                  filterModel: PaprikaFilterModel.deepCopy(filterData),
                  scrollController: scrollController);
            },
          );
        }).then((newFilter) {
      if (newFilter != null && filterData != newFilter) {
        _requestData(context, newFilter);
      }
    });
  }

  List<RestaurantSummaryDto> _extract(List restaurants) {
    List<RestaurantSummaryDto> extracted = [];
    restaurants.forEach((rest) {
      if (rest is RestaurantSummaryDto) {
        RestaurantSummaryDto restaurant = rest;
        extracted.add(restaurant);
      }
    });
    return extracted;
  }
}

class _CustomFilterParamsSliverDelegate extends SliverPersistentHeaderDelegate {
  Function editFilterCallback;

  _CustomFilterParamsSliverDelegate(
      {@required this.minHeight,
      @required this.maxHeight,
      @required this.filterModel,
      this.editFilterCallback});

  final PaprikaFilterModel filterModel;
  final double minHeight;
  final double maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
        child: Container(
            color: Colors.grey[100],
            child: Scrollbar(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Wrap(
                          spacing: 8,
                          runSpacing: -8,
                          children: _extractFilterParams(context))
                    ],
                  ),
                ),
              ),
            )));
  }

  List<Widget> _extractFilterParams(BuildContext context) {
    List<Widget> params = [];
    if (filterModel == null) return params;
    if (filterModel.isFeatured != null) {
      params.add(InputChip(
        label: Text(S.of(context).featured),
        onDeleted: () {
          filterModel.isFeatured = null;
          if (editFilterCallback is Function && editFilterCallback != null) {
            editFilterCallback(filterModel);
          }
        },
      ));
    }
    if (filterModel.locationData != null) {
      params.add(InputChip(
        label: Text(S.of(context).nearby),
        onDeleted: () {
          filterModel.locationData = null;
          if (editFilterCallback is Function && editFilterCallback != null) {
            editFilterCallback(filterModel);
          }
        },
      ));
    }
    params.addAll(filterModel.placesSelections?.map<Widget>((value) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: InputChip(
              label: Text(S.of(context).places + ": " + value),
              onDeleted: () {
                filterModel.placesSelections.remove(value);
                if (editFilterCallback is Function &&
                    editFilterCallback != null) {
                  editFilterCallback(filterModel);
                }
              },
            ),
          );
        }) ??
        []);
    params.addAll(filterModel.cuisinesSelections?.map<Widget>((value) {
          return InputChip(
            label: Text(S.of(context).cuisines + ": " + value),
            onDeleted: () {
              filterModel.cuisinesSelections.remove(value);
              if (editFilterCallback is Function &&
                  editFilterCallback != null) {
                editFilterCallback(filterModel);
              }
            },
          );
        }) ??
        []);
    params.addAll(filterModel.ambianceSelections?.map<Widget>((value) {
          return InputChip(
            label: Text(S.of(context).ambiance + ": " + value),
            onDeleted: () {
              filterModel.ambianceSelections.remove(value);
              if (editFilterCallback is Function &&
                  editFilterCallback != null) {
                editFilterCallback(filterModel);
              }
            },
          );
        }) ??
        []);
    params.addAll(filterModel.amenitiesSelections?.map<Widget>((value) {
          return InputChip(
            label: Text(S.of(context).amenities + ": " + value),
            onDeleted: () {
              filterModel.amenitiesSelections.remove(value);
              if (editFilterCallback is Function &&
                  editFilterCallback != null) {
                editFilterCallback(filterModel);
              }
            },
          );
        }) ??
        []);
    params.addAll(filterModel.musicTypesSelections?.map<Widget>((value) {
          return InputChip(
            label: Text(S.of(context).music + ": " + value),
            onDeleted: () {
              filterModel.musicTypesSelections.remove(value);
              if (editFilterCallback is Function &&
                  editFilterCallback != null) {
                editFilterCallback(filterModel);
              }
            },
          );
        }) ??
        []);

    params.addAll(filterModel.parkingTypesSelections?.map<Widget>((value) {
          return InputChip(
            label: Text(S.of(context).parking + ": " + value),
            onDeleted: () {
              filterModel.parkingTypesSelections.remove(value);
              if (editFilterCallback is Function &&
                  editFilterCallback != null) {
                editFilterCallback(filterModel);
              }
            },
          );
        }) ??
        []);

    if (filterModel.smokeFree != null) {
      params.add(InputChip(
        label: Text(filterModel.smokeValue),
        onDeleted: () {
          filterModel.smokeValue = null;
          if (editFilterCallback is Function && editFilterCallback != null) {
            editFilterCallback(filterModel);
          }
        },
      ));
    }
    if (filterModel.alcoholFree != null) {
      params.add(InputChip(
        label: Text(filterModel.alcoholValue),
        onDeleted: () {
          filterModel.alcoholValue = null;
          if (editFilterCallback is Function && editFilterCallback != null) {
            editFilterCallback(filterModel);
          }
        },
      ));
    }
    if (filterModel.outdoor != null) {
      params.add(InputChip(
        label: Text(filterModel.hasOutdoorValue),
        onDeleted: () {
          filterModel.hasOutdoorValue = null;
          if (editFilterCallback is Function && editFilterCallback != null) {
            editFilterCallback(filterModel);
          }
        },
      ));
    }
    if (filterModel.twentyFourHour != null) {
      params.add(InputChip(
        label: Text(filterModel.twentyFourValue),
        onDeleted: () {
          filterModel.twentyFourValue = null;
          if (editFilterCallback is Function && editFilterCallback != null) {
            editFilterCallback(filterModel);
          }
        },
      ));
    }
    return params;
  }

  @override
  bool shouldRebuild(_CustomFilterParamsSliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        filterModel != oldDelegate.filterModel;
  }
}

class QuickFilter extends StatefulWidget {
  final PaprikaFilterModel filterModel;

  final ScrollController scrollController;

  const QuickFilter({this.filterModel, this.scrollController});

  @override
  _QuickFilterState createState() => _QuickFilterState();
}

class _QuickFilterState extends State<QuickFilter> {
  PaprikaFilterModel filterModel;
  List<String> places;
  List<String> cuisines;
  List<String> amenities;
  List<String> ambiance;
  List<String> musicTypes;
  List<String> parkingTypes;

  StreamController<bool> clearStreamController;

  @override
  void initState() {
    super.initState();
    clearStreamController = StreamController<bool>.broadcast();

    filterModel ??= widget.filterModel ?? PaprikaFilterModel();

    ApiTypesHelper helper = ApiTypesHelper();
    places = helper.getTypeNames(Type.places);
    cuisines = helper.getTypeNames(Type.cuisines);
    amenities = helper.getTypeNames(Type.amenities);
    ambiance = helper.getTypeNames(Type.ambiance);
    musicTypes = helper.getTypeNames(Type.music);
    parkingTypes = helper.getTypeNames(Type.parking);
  }

  @override
  void dispose() {
    clearStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          leading: Center(
            child: Text(
              S.of(context).filter,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            GestureDetector(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          Localizations.localeOf(context).languageCode == 'en'
                              ? 20
                              : 12.0),
                  child: Text(
                    S.of(context).clearAll,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                onTap: () {
                  if (filterModel.isFilterNotEmpty) {
                    PaprikaToast.showToast(
                        S.of(context).filterCleared, ToastType.Normal);
                  }
                  clearStreamController.add(true);
                  setState(() {
                    filterModel = PaprikaFilterModel();
                  });
                }),
            GestureDetector(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          Localizations.localeOf(context).languageCode == 'en'
                              ? 20
                              : 12.0,
                      horizontal: 16),
                  child: Text(
                    S.of(context).apply,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop(filterModel);
                }),
          ],
        ),
        body: SingleChildScrollView(
          controller: widget.scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      QuickFilterQueryParameter(
                        title: S.of(context).places,
                        values: places,
                        selections: filterModel.placesSelections,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.placesSelections = selections;
                        },
                      ),
                      SizedBox(height: 10),
                      QuickFilterQueryParameter(
                        title: S.of(context).cuisines,
                        values: cuisines,
                        selections: filterModel.cuisinesSelections,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.cuisinesSelections = selections;
                        },
                      ),
                      SizedBox(height: 10),
                      QuickFilterQueryParameter(
                        title: S.of(context).amenities,
                        values: amenities,
                        selections: filterModel.amenitiesSelections,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.amenitiesSelections = selections;
                        },
                      ),
                      SizedBox(height: 10),
                      QuickFilterQueryParameter(
                        title: S.of(context).ambiance,
                        values: ambiance,
                        selections: filterModel.ambianceSelections,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.ambianceSelections = selections;
                        },
                      ),
                      SizedBox(height: 10),
                      QuickFilterQueryParameter(
                        title: S.of(context).music,
                        values: musicTypes,
                        selections: filterModel.musicTypesSelections,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.musicTypesSelections = selections;
                        },
                      ),
                      SizedBox(height: 10),
                      QuickFilterQueryParameter(
                        title: S.of(context).parking,
                        values: parkingTypes,
                        selections: filterModel.parkingTypesSelections,
                        clearParamsStream: clearStreamController.stream,
                        selectionCallback: (selections) {
                          filterModel.parkingTypesSelections = selections;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Label(
                              S.of(context).otherWord,
                              fontSize: 18,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }
}

typedef QuickFilterQueryParameterSelectionCallback(List<String> selections);

class QuickFilterQueryParameter extends StatefulWidget {
  final List<String> values;
  final List<String> selections;
  final String title;
  final Stream<bool> clearParamsStream;
  final QuickFilterQueryParameterSelectionCallback selectionCallback;

  const QuickFilterQueryParameter(
      {@required this.title,
      @required this.values,
      this.selectionCallback,
      this.selections,
      this.clearParamsStream});

  @override
  _QuickFilterQueryParameterState createState() =>
      _QuickFilterQueryParameterState();
}

class _QuickFilterQueryParameterState extends State<QuickFilterQueryParameter> {
  Map<String, String> selections;

  @override
  void initState() {
    super.initState();
    selections = <String, String>{};
    if (widget.selections != null) {
      for (String value in widget.selections) {
        selections[value] = value;
      }
    }

    widget.clearParamsStream.listen((clear) {
      if (clear) {
        selections = <String, String>{};
        if (widget.selectionCallback != null)
          widget.selectionCallback(selections.values.toList());
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
        Card(
          elevation: 0,
          margin: EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.title),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Card(
                elevation: 0,
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
                                  duration: Duration(milliseconds: 1),
                                  radioValue: selections[value],
                                  onRadioTab: (_value) {
                                    setState(() {
                                      if (selections[value] == null) {
                                        selections[value] = _value;
                                      } else {
                                        selections.removeWhere((key, _) =>
                                            selections[key] == value);
                                      }
                                    });
                                    if (widget.selectionCallback != null)
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
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class _RestaurantItem extends StatelessWidget {
  final RestaurantSummaryDto restaurant;

  _RestaurantItem(this.restaurant);

  CachedNetworkImageProvider _widgetLogoImage;

  @override
  Widget build(BuildContext context) {
    _widgetLogoImage ??= CachedNetworkImageProvider(this.restaurant.logoImage);

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return RestaurantHome(restaurantId: this.restaurant.id);
        }));
      },
      child: SizedBox(
        child: Card(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.width * 0.25,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.25 * 0.5),
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          image: DecorationImage(
                              image: _widgetLogoImage, fit: BoxFit.scaleDown)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    (this.restaurant.phoneNumber != null
                                        ? 0.55
                                        : 0.6),
                                child: Text(
                                  this.restaurant.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: this.restaurant.phoneNumber != null
                                  ? GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return CallRestaurantDialog(
                                              phoneNumber:
                                                  this.restaurant.phoneNumber,
                                              restaurantName:
                                                  this.restaurant.name,
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.phone,
                                        size: 24,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  : Container(),
                            )
                          ],
                        ),
                        FlutterRatingBarIndicator(
                          rating: this.restaurant.restaurantRate,
                          itemSize: 12,
                          itemPadding: EdgeInsets.all(2),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              this.restaurant.isOpen
                                  ? S.of(context).opened
                                  : S.of(context).closed,
                              style: TextStyle(
                                fontSize: 11,
                                color: this.restaurant.isOpen
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.60,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              this.restaurant.address,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Divider(
                            color: Colors.grey,
                            height: 10,
                          ),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      S.of(context).food,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      this.restaurant.foodRate.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: PaprikaVerticalDivider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      S.of(context).service,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      this.restaurant.serviceRate.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              restaurant.hasShisha != null && restaurant.hasShisha == true?
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                    child: PaprikaVerticalDivider(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          S.of(context).shisha,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          this.restaurant.shishaRate.toString(),
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ):
                              Container(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: PaprikaVerticalDivider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      S.of(context).ambiance,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      this.restaurant.ambianceRate.toString(),
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: PaprikaVerticalDivider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).noiseLevel,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      ApiHelper.toStringNoiseLevel(
                                          context, this.restaurant.noiseLevel),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                          /// This ready for restaurant tags (Calm, Antique, ...) extracted from reviews
//                    Wrap(
//                      spacing: 8,
//                      runSpacing: -8,
//                      children:
//                          this.restaurant.tags.
//                          .map<Widget>((tag) => Chip(
//                                label: Text(
//                                  tag,
//                                  style: TextStyle(fontSize: 12, color: Colors.white),
//                                ),
//                                padding: EdgeInsets.all(0),
//                                backgroundColor: Colors.red[200],
//                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
//                              ))
//                          .toList(),
//                    )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
