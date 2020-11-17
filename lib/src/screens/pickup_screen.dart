import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:intl/intl.dart';
import 'package:paprica/src/models/create_pickup_meal_model.dart';
import 'package:paprica/src/models/pickup_list_meal_model.dart';
import 'package:paprica/src/models/pickup_model.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';
import '../../translations.dart';
import '../../utils.dart';
import '../../widgets.dart';
import 'pickups_screen.dart';

class PickupScreen extends StatefulWidget {
  final int restaurantId;
  final String restaurantName;
  final PickupModel oldPickup;

  const PickupScreen(
      {Key key, this.restaurantId, this.restaurantName, this.oldPickup})
      : super(key: key);

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  Future<List<CategoryDto>> futureCategories;
  Future<List<MealDto>> futureMeals;

  List<CategoryDto> categories;
  CategoryDto selectedCategory;
  bool _categoriesOpen = true;

  PickupListMealModel _selectedMeal;
  List<PickupListMealModel> _selectedMeals = [];

  CreatePickupMealModel _createSelectedMeal;
  List<CreatePickupMealModel> _createSelectedMeals = [];

  TextEditingController _additionalValueController;
  String _notes;
  int _quantity;

  @override
  void initState() {
    _getCategoriesAsync();
    _selectedMeal = null;
    _selectedMeals.clear();
    _createSelectedMeal = null;
    _createSelectedMeals.clear();
    _notes = '';
    _quantity = 1;
    if (widget.oldPickup != null) {
      if (widget.oldPickup.upcomingPickupMeals != null)
        for (var i in widget.oldPickup.upcomingPickupMeals) {
          _selectedMeal = PickupListMealModel(
              i.mealId, i.mealName, i.mealPrice, i.quantity, i.notes);
          _selectedMeals.add(_selectedMeal);
          _createSelectedMeal =
              CreatePickupMealModel(i.mealId, i.quantity, i.notes);
          _createSelectedMeals.add(_createSelectedMeal);
        }
      if (widget.oldPickup.updatePickupMealsRequest != null)
        for (var i in widget.oldPickup.updatePickupMealsRequest) {
          _selectedMeal = PickupListMealModel(
              i.mealId, i.mealName, i.mealPrice, i.quantity, i.notes);
          _selectedMeals.add(_selectedMeal);
          _createSelectedMeal =
              CreatePickupMealModel(i.mealId, i.quantity, i.notes);
          _createSelectedMeals.add(_createSelectedMeal);
        }
    }
    super.initState();
  }

  @override
  void dispose() {
    _selectedMeal = null;
    _selectedMeals.clear();
    _createSelectedMeal = null;
    _createSelectedMeals.clear();
    _notes = '';
    _quantity = 1;
    super.dispose();
  }

  Future _getCategoriesAsync() {
    ApiClient apiClient = PapricaApiClient();
    var apiInstance = new CustomerMenuApi(apiClient);
    setState(() {
      futureCategories =
          apiInstance.apiServicesAppCustomerMenuGetRestaurantCategoriesGet(
              id: widget.restaurantId);
    });
    return futureCategories.then((_) {
      return Future.value();
    }).catchError((err) {
      return Future.value();
    });
  }

  Future _getCategoryMealAsync(int categoryId) {
    ApiClient apiClient = PapricaApiClient();
    var apiInstance = new CustomerMenuApi(apiClient);
    futureMeals =
        apiInstance.apiServicesAppCustomerMenuGetRestaurantCategoryMealsGet(
            id: categoryId);
    return futureMeals.then((_) {
      return Future.value();
    }).catchError((err) {
      return Future.value();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.restaurantId == null || widget.restaurantId <= 0) {
      Navigator.of(context).pop();
    }
    return WillPopScope(
      onWillPop: () {
        if (!_categoriesOpen)
          setState(() {
            _categoriesOpen = true;
          });
        else {
          Navigator.of(context).pop();
        }
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).pickupFrom + " " + widget.restaurantName),
        ),
        body: Container(color: Color(0xFFF2F2F2), child: _menuContent(context)),
      ),
    );
  }

  Widget _menuContent(BuildContext context) {
    return Stack(
      children: [
        AnimatedCrossFade(
          duration: Duration(milliseconds: 700),
          crossFadeState: _categoriesOpen
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: FutureBuilder<List<CategoryDto>>(
              future: futureCategories,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  categories = snapshot.data;
                  return snapshot.data.length > 0
                      ? Container(
                          height: MediaQuery.of(context).size.height * 3,
                          color: Color(0xFFF2F2F2),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            children: snapshot.data.map<Widget>((category) {
                              return _buildCategoryCardInCategories(category);
                            }).toList(),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                        )
                      : Center(child: Text(S.of(context).catsNotAvailable));
                } else if (snapshot.hasError) {
                  return RequestRetry(
                    message: S.of(context).errorUnknown,
                    retryCallback: _getCategoriesAsync,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          secondChild: FutureBuilder<List<MealDto>>(
            future: futureMeals,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height * 50,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        height: 60,
                        child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 10,
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return _buildCategoryCardInMeals(categories[index]);
                          },
                          physics: ClampingScrollPhysics(),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                      Container(
                        child: Text(
                          selectedCategory.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: snapshot.data.length > 0
                            ? ListView.builder(
                                itemExtent: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? 124
                                    : 127.4,
                                itemCount: snapshot.data.length,
                                padding: EdgeInsets.only(bottom: 60),
                                itemBuilder: (context, index) {
                                  return _mealCard(
                                      context, snapshot.data[index]);
                                },
                                physics: ClampingScrollPhysics(),
                              )
                            : Center(
                                child: Text(
                                  S
                                      .of(context)
                                      .menuNoAvailable(selectedCategory.name),
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return RequestRetry(
                    message: S.of(context).errorUnknown,
                    retryCallback: () =>
                        _getCategoryMealAsync(selectedCategory.id));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        DraggableScrollableSheet(
          maxChildSize: 0.95,
          minChildSize: 0.09,
          initialChildSize: 0.09,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                      ),
                      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 40.0,
                              ),
                              Container(
                                child: Text(
                                  S.of(context).pickupList,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomizedActiveButton(
                                onPressed: () {
                                  _createSelectedMeals.length > 0
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              widget.oldPickup != null
                                                  ? PickupDialog(
                                                      restaurantId:
                                                          widget.restaurantId,
                                                      restaurantName:
                                                          widget.restaurantName,
                                                      meals:
                                                          _createSelectedMeals,
                                                      oldPickup:
                                                          widget.oldPickup,
                                                    )
                                                  : PickupDialog(
                                                      restaurantId:
                                                          widget.restaurantId,
                                                      restaurantName:
                                                          widget.restaurantName,
                                                      meals:
                                                          _createSelectedMeals,
                                                    ),
                                        ).then((ok) {
                                          if (ok != null) {
                                            setState(() {
                                              _categoriesOpen = true;
                                              _selectedMeal = null;
                                              _createSelectedMeal = null;
                                              _selectedMeals.clear();
                                              _createSelectedMeals.clear();
                                              _notes = '';
                                              _quantity = 1;
                                            });
                                            widget.oldPickup == null
                                                ? showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        MessageDialog(
                                                      S
                                                          .of(context)
                                                          .successPickup,
                                                      duration:
                                                          Duration(seconds: 1),
                                                      footer: GestureDetector(
                                                        behavior:
                                                            HitTestBehavior
                                                                .translucent,
                                                        onTap: () {
                                                          _viewMyPickups(
                                                              context);
                                                        },
                                                        child: Text(
                                                            S
                                                                .of(context)
                                                                .viewPickups,
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
                                                      ),
                                                    ),
                                                  )
                                                : showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        MessageDialog(
                                                      S
                                                          .of(context)
                                                          .successPickup,
                                                      duration:
                                                          Duration(seconds: 1),
                                                      footer: GestureDetector(
                                                        behavior:
                                                            HitTestBehavior
                                                                .translucent,
                                                        onTap: () {
                                                          _onOkPressed(
                                                              context);
                                                        },
                                                        child: Text(
                                                            S.of(context).ok,
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor)),
                                                      ),
                                                    ),
                                                  );
                                          }
                                        })
                                      : showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _alertDialog(context),
                                        );
                                },
                                title: S.of(context).next,
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Icon(Icons.keyboard_arrow_up,
                                  size: 50,
                                  color: Theme.of(context).primaryColor),
                              SizedBox(
                                width: 8.0,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    _selectedMeals.length > 0
                        ? Column(
                            children: List.generate(
                                _selectedMeals.length,
                                (index) => _mealCardInDragg(
                                    context, _selectedMeals[index])))
                        : Center(
                            child: Text(
                              S.of(context).thereAreNoMeals,
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _alertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).error,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      content: Text(
        S.of(context).thereAreNoMealsInPickupList,
      ),
      actions: <Widget>[
        CustomizedInactiveButton(
          title: S.of(context).cancel,
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }

  Widget _buildCategoryCardInCategories(CategoryDto category) {
    return Container(
      color: Color(0xFFF2F2F2),
      child: GestureDetector(
        onTap: () {
          _getCategoryMealAsync(category.id);
          _categoriesOpen = false;
          setState(() {
            selectedCategory = category;
          });
        },
        child: _CategoryCardInCategories(category),
      ),
    );
  }

  Widget _buildCategoryCardInMeals(CategoryDto category) {
    return Container(
      color: Color(0xFFF2F2F2),
      child: GestureDetector(
        onTap: () {
          _getCategoryMealAsync(category.id);
          setState(() {
            selectedCategory = category;
          });
        },
        child: _CategoryCardInMeals(category, category == selectedCategory),
      ),
    );
  }

  Widget _mealCard(BuildContext context, MealDto meal) {
    bool isLtr = Localizations.localeOf(context).languageCode == 'en';
    Radius radiusTopRight = isLtr ? Radius.circular(15) : Radius.zero;
    Radius radiusBottomRight = isLtr ? Radius.circular(15) : Radius.zero;
    Radius radiusTopLeft = isLtr ? Radius.zero : Radius.circular(15);
    Radius radiusBottomLeft = isLtr ? Radius.zero : Radius.circular(15);

    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: radiusTopRight,
              topLeft: radiusTopLeft,
              bottomRight: radiusBottomRight,
              bottomLeft: radiusBottomLeft),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 120,
              width: 110,
              child: CachedNetworkImage(
                imageUrl: meal.thumbnailImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image(
                  image: AssetImage("assets/images/placeholder.png"),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(meal.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlutterRatingBarIndicator(
                              rating: meal.mealRate,
                              itemSize: 12,
                              itemPadding: EdgeInsets.all(0.2),
                            ),
                            GestureDetector(
                              onTap: () {
                                _onOrderPickupPressed(context, meal);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.only(
                                  left: 10,
                                  top: 2,
                                  right: 10,
                                ),
                                child: Text(
                                  S.of(context).orderNow,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                meal.ingredients.length == 0
                                    ? meal.description ?? ""
                                    : _parseIngredients(meal.ingredients),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    meal.price != null && meal.price > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Spacer(),
                              Text(S.of(context).price + ":",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                  PapricaFormatter.formatNumber(
                                      meal.price.floor()),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor)),
                              SizedBox(
                                width: 4,
                              ),
                              Text(S.of(context).currency,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor)),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _mealCardInDragg(BuildContext context, PickupListMealModel meal) {
    bool isLtr = Localizations.localeOf(context).languageCode == 'en';
    Radius radiusTopRight = isLtr ? Radius.circular(15) : Radius.zero;
    Radius radiusBottomRight = isLtr ? Radius.circular(15) : Radius.zero;
    Radius radiusTopLeft = isLtr ? Radius.zero : Radius.circular(15);
    Radius radiusBottomLeft = isLtr ? Radius.zero : Radius.circular(15);

    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: radiusTopRight,
              topLeft: radiusTopLeft,
              bottomRight: radiusBottomRight,
              bottomLeft: radiusBottomLeft),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 8.0),
                        Text(meal.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          SizedBox(
                            width: 16.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              meal.price != null && meal.price > 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(S.of(context).price + ":",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                            PapricaFormatter.formatNumber(
                                                meal.price.floor()),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(S.of(context).currency,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ],
                                    )
                                  : Container(),
                              SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(S.of(context).quantity + ":",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("${meal.quantity}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Theme.of(context).primaryColor)),
                                ],
                              ),
                            ],
                          ),
                        ]),
                        CustomizedActiveButton(
                          onPressed: () {
                            setState(() {
                              _selectedMeals.removeWhere(
                                  (element) => element.id == meal.id);
                              _createSelectedMeals.removeWhere(
                                  (element) => element.mealId == meal.id);
                            });
                          },
                          title: S.of(context).remove,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 16.0),
                        Text(S.of(context).notes + ":",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                            meal.notes != ""
                                ? "${meal.notes}"
                                : S.of(context).none,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onOrderPickupPressed(BuildContext context, MealDto meal) {
    if (ApiTypesHelper().isAuthorized) {
      _showPickupDialog(meal);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return PapricaSimpleDialog(
            title: S.of(context).pleaseLoginInOrderToOrderDelivery,
            yesButton: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LogInScreen(asAService: true))).then((loggedIn) {
                    if (loggedIn != null && loggedIn) {
                      _showPickupDialog(meal);
                    } else {
                      PapricaToast.showToast(S
                          .of(context)
                          .loggingInRequired(S.of(context).actionDelivery));
                    }
                  });
                },
                child: Text(S.of(context).logIn)),
          );
        },
      );
    }
  }

  void _showPickupDialog(MealDto meal) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Center(
                      child: Column(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        S.of(context).quantity,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      RawMaterialButton(
                                        onPressed: () {
                                          _showQuantityPicker(context);
                                        },
                                        splashColor: Colors.transparent,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xFF707070)),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Text(
                                                  _quantity.toString(),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF707070),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFF707070)),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          Localizations.localeOf(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 0
                                                              : 6),
                                                      bottomLeft: Radius.circular(
                                                          Localizations.localeOf(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 0
                                                              : 6),
                                                      topRight: Radius.circular(
                                                          Localizations.localeOf(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 6
                                                              : 0),
                                                      bottomRight: Radius.circular(
                                                          Localizations.localeOf(
                                                                          context)
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 6
                                                              : 0),
                                                    )),
                                                child: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.white70),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 24),
                                        child: SizedBox(
                                          width: 32,
                                          height: 32,
                                          child: Image.asset(
                                              "assets/icons/comment.png"),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              S.of(context).notes,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            TextFormField(
                                              onChanged: (text) {
                                                setState(() {
                                                  _notes = text;
                                                });
                                              },
                                              controller:
                                                  _additionalValueController,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              textInputAction:
                                                  TextInputAction.done,
                                              maxLines: 2,
                                              style: TextStyle(fontSize: 14),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xFFF2F2F2),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 12),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFaa757f)),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          const Radius.circular(
                                                              3.0)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Spacer(),
                                      CustomizedActiveButton(
                                        onPressed: () {
                                          setState(() {
                                            _selectedMeal = PickupListMealModel(
                                              meal.id,
                                              meal.name,
                                              meal.price,
                                              _quantity,
                                              _notes,
                                            );
                                            _selectedMeals.add(_selectedMeal);
                                            _createSelectedMeal =
                                                CreatePickupMealModel(
                                                    meal.id, _quantity, _notes);
                                            _createSelectedMeals
                                                .add(_createSelectedMeal);
                                            _quantity = 1;
                                            _notes = '';
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        title: S.of(context).addToDeliveryList,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: DialogCloseButton(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _showQuantityPicker(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 1, end: 100, initValue: 1),
        ]),
        looping: true,
        hideHeader: true,
        itemExtent: 50,
        title: Text(S.of(context).quantity),
        cancelText: S.of(context).cancelOrder.toUpperCase(),
        confirmText: S.of(context).okay.toUpperCase(),
        onConfirm: (Picker picker, List value) {
          setState(() {
            _quantity = picker.getSelectedValues()[0];
          });
          // Dismiss keyboard
          FocusScope.of(context).requestFocus(FocusNode());
        }).showDialog(context);
  }

  void _viewMyPickups(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PickupsScreen();
    }));
  }

  void _onOkPressed(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PickupsScreen();
    }));
  }
}

class _CategoryCardInCategories extends StatelessWidget {
  final CategoryDto category;

  const _CategoryCardInCategories(this.category);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.45, //160
              width: MediaQuery.of(context).size.width * 0.45, //160
              child: CachedNetworkImage(
                placeholder: (context, url) => Image(
                  image: AssetImage("assets/images/placeholder.png"),
                ),
                imageUrl: category.thumbnailImage,
                fit: BoxFit.cover,
              ),
            )),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        Center(
          child: Text(
            category.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 8.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _CategoryCardInMeals extends StatelessWidget {
  final CategoryDto category;
  final bool selected;

  const _CategoryCardInMeals(this.category, this.selected);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: selected ? Theme.of(context).primaryColor : Colors.black,
          width: selected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
      child: Text(
        category.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 23,
          color: Colors.white,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(2, 2),
              blurRadius: 8.0,
              color: Color.fromARGB(255, 0, 0, 0),
            )
          ],
        ),
      ),
    );
  }
}

String _parseIngredients(List<IngredientDto> ingredients) {
  String ings = "";
  for (int i = 0; i <= ingredients.length - 1; i++) {
    ings += ingredients[i].name;
    if (i != ingredients.length - 1) ings += ', ';
  }
  return ings;
}
