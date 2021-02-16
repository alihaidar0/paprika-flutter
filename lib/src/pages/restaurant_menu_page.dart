import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paprica/src/models/meal_share.dart';
import 'package:paprica/src/models/menu_state.dart';
import 'package:paprica/src/widgets/rating_bar.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/widgets.dart';
import 'package:share/share.dart';
import 'package:swagger/api.dart';

import '../../screens.dart';
import '../../utils.dart';

class RestaurantMenuPage extends StatefulWidget {
  final RestaurantHomeDto restData;
  final MenuState menuState;
  final parentScrollController;
  final parentScrollDelegate;
  final saveMenuState;
  final MealShare mealShare;

  RestaurantMenuPage(this.restData, this.menuState, this.saveMenuState,
      this.parentScrollController, this.parentScrollDelegate,
      {this.mealShare});

  @override
  _RestaurantMenuPageState createState() => _RestaurantMenuPageState();
}

class _RestaurantMenuPageState extends State<RestaurantMenuPage> {
  ScrollController scrollController;
  CategoryDto selectedCategory;
  Future<List<CategoryDto>> categories;
  Future<List<MealDto>> meals;

  bool _sharedCatOpened = false;

  bool _sharedMealOpened = false;

  @override
  void initState() {
    super.initState();
    _checkMenuState();
    scrollController = ScrollController();
    widget.parentScrollController..addListener(_parentScrollCallback);
  }

  @override
  void dispose() {
    scrollController.dispose();
    widget.parentScrollController.removeListener(_parentScrollCallback);
    super.dispose();
  }

  void _parentScrollCallback() {
    if (false == widget.menuState.isGrid) {
      if (widget.parentScrollController.offset > 105)
        widget.parentScrollDelegate(105.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Color(0xFFF2F2F2), child: _menuContent(context));
  }

  Widget _menuContent(BuildContext context) {
    return AnimatedCrossFade(
        duration: Duration(milliseconds: 700),
        crossFadeState: this.widget.menuState.isGrid
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: FutureBuilder<List<CategoryDto>>(
            future: categories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data.length > 0
                    ? Container(
                        color: Color(0xFFF2F2F2),
                        child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: snapshot.data.map<Widget>((category) {
                            if (widget.mealShare != null &&
                                widget.mealShare.categoryId == category.id &&
                                !_sharedCatOpened) {
                              _openSharedCategory(category);
                            }
                            return _buildMenuGridItem(category);
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
        secondChild: !this.widget.menuState.isGrid
            ? Container(
                color: Color(0xFFF2F2F2),
                child: NestedScrollView(
                  controller: scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: MealListHeaderDelegate(
                            this.widget.menuState.selectedCategory.name,
                            _toggleMenuView),
                      ),
                    ];
                  },
                  body: FutureBuilder<List<MealDto>>(
                    future: meals,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
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
                                      if (widget.mealShare != null &&
                                          snapshot.data[index].id ==
                                              widget.mealShare.mealId &&
                                          !_sharedMealOpened) {
                                        _openSharedMeal(snapshot.data[index]);
                                      }
                                      return _buildMenuListItem(
                                          context, snapshot.data[index]);
                                    },
                                    physics: ClampingScrollPhysics(),
                                  )
                                : Center(
                                    child: Text(S.of(context).menuNoAvailable(
                                        selectedCategory.name))));
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
                  ), // The container is added here to remove meals list permanently when the grid is shown
                ))
            : Container());
  }

  Widget _buildMenuGridItem(CategoryDto category) {
    return Container(
      color: Color(0xFFF2F2F2),
//      height: 160,
//      width: 160,
      child: GestureDetector(
        onTap: () {
          _getCategoryMealAsync(category.id);
          this.widget.parentScrollDelegate(105.0);
          widget.menuState.isGrid = !this.widget.menuState.isGrid;
          widget.menuState.selectedCategory = category;
          widget.menuState.meals = meals;
          this.widget.saveMenuState(widget.menuState);
          setState(() {
            selectedCategory = category;
          });
        },
        child: MenuGridItem(category),
      ),
    );
  }

  Widget _buildMenuListItem(BuildContext context, MealDto meal) {
    return GestureDetector(
      onTap: () {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return MenuItemPopUp(
                  meal,
                  widget.restData?.logoImage,
                  widget.restData.name,
                  widget.restData.id,
                  selectedCategory.id, onRateChanged: (newRate) {
                setState(() {
                  meal.mealRate = newRate;
                });
              });
            });
      },
      child: MenuListItem(meal),
    );
  }

  _toggleMenuView() {
    setState(() {
      this.widget.menuState.isGrid = !this.widget.menuState.isGrid;
    });
  }

  Future _getCategoriesAsync() {
    ApiClient apiClient = PapricaApiClient();
    var apiInstance = new CustomerMenuApi(apiClient);
    setState(() {
      widget.menuState.categories = categories =
          apiInstance.apiServicesAppCustomerMenuGetRestaurantCategoriesGet(
              id: widget.restData.id);
    });
    return categories.then((_) {
      return Future.value();
    }).catchError((err) {
      return Future.value();
    });
  }

  Future _getCategoryMealAsync(int categoryId) {
    ApiClient apiClient = PapricaApiClient();
    var apiInstance = new CustomerMenuApi(apiClient);
    meals = apiInstance.apiServicesAppCustomerMenuGetRestaurantCategoryMealsGet(
        id: categoryId);
    return meals.then((_) {
      return Future.value();
    }).catchError((err) {
      return Future.value();
    });
  }

  void _checkMenuState() {
    if (widget.menuState.categories != null) {
      categories = widget.menuState.categories;
    } else {
      _getCategoriesAsync();
    }
    if (!widget.menuState.isGrid) {
      if (widget.menuState.meals != null) {
        meals = widget.menuState.meals;
      } else {
        _getCategoryMealAsync(selectedCategory.id);
      }
    }
    if (!widget.menuState.isGrid) {
      widget.parentScrollDelegate(105.0);
    }
    selectedCategory = widget.menuState.selectedCategory;
  }

  void _openSharedCategory(CategoryDto category) {
    Future.delayed(Duration(seconds: 1), () {
      _getCategoryMealAsync(widget.mealShare.categoryId);
      this.widget.parentScrollDelegate(105.0);
      widget.menuState.isGrid = !this.widget.menuState.isGrid;
      widget.menuState.selectedCategory = category;
      this.widget.saveMenuState(widget.menuState);
      setState(() {
        selectedCategory = category;
        _sharedCatOpened = true;
      });
    });
  }

  void _openSharedMeal(MealDto meal) {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _sharedMealOpened = true;
      });
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return MenuItemPopUp(
                meal,
                widget.restData?.logoImage,
                widget.restData.name,
                widget.restData.id,
                selectedCategory.id, onRateChanged: (newRate) {
              setState(() {
                meal.mealRate = newRate;
              });
            });
          });
    });
  }
}

class MenuGridItem extends StatelessWidget {
  final CategoryDto category;

  const MenuGridItem(this.category);

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

class MenuListItem extends StatelessWidget {
  final MealDto meal;

  MenuListItem(this.meal);

  @override
  Widget build(BuildContext context) {
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
                          children: <Widget>[
                            Expanded(
                              child: Text(meal.name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlutterRatingBarIndicator(
                              rating: meal.mealRate,
                              itemSize: 12,
                              itemPadding: EdgeInsets.all(0.2),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
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
}

class MenuItemPopUp extends StatefulWidget {
  final MealDto meal;

  final String restaurantLogoUrl;
  final int restaurantId;
  final int categoryId;

  final onRateChanged;

  final String restaurantName;

  MenuItemPopUp(this.meal, this.restaurantLogoUrl, this.restaurantName,
      this.restaurantId, this.categoryId,
      {this.onRateChanged});

  @override
  _MenuItemPopUpState createState() => _MenuItemPopUpState();
}

class _MenuItemPopUpState extends State<MenuItemPopUp> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 8),
          child: ScrollConfiguration(
            behavior: NoGlowScrollBehaviour(),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    PapricaToast.showToast(
                                        S.of(context).errorRateMeal,
                                        ToastType.Error);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return FullscreenPhoto(
                                              provider: NetworkImage(
                                                  widget.meal.image != null
                                                      ? widget.meal.image
                                                      : ""));
                                        });
                                  },
                                  child: Container(
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width - 24,
                                    child: FadeInImage.assetNetwork(
                                      image: widget.meal.image != null
                                          ? widget.meal.image
                                          : "",
                                      placeholder:
                                          "assets/images/placeholder.png",
                                      fit: BoxFit.cover,
//                                    height: 200,
//                                    width: MediaQuery.of(context).size.width-24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Hero(
                                        tag: widget.meal.image != null
                                            ? widget.meal.image
                                            : "",
                                        child: FullscreenPhoto(
                                            provider: NetworkImage(
                                                widget.meal.image != null
                                                    ? widget.meal.image
                                                    : "")),
                                        placeholderBuilder:
                                            (BuildContext context,
                                                Size heroSize, Widget child) {
                                          return Container(
                                            height: 150.0,
                                            width: 150.0,
                                            child: Image.asset(
                                                "assets/images/placeholder.png"),
                                          );
                                        },
                                      );
                                    });
                              },
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.center,
                                          end: Alignment.bottomCenter,
                                          colors: <Color>[
                                            Colors.transparent,
                                            Colors.black26,
                                            Colors.black87
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned.directional(
                              textDirection: Localizations.localeOf(context)
                                          .languageCode ==
                                      "en"
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              bottom: 8,
                              end: 8,
                              child: GestureDetector(
                                onTap: () => _onTapRateMeal(context),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlutterRatingBarIndicator(
                                    rating: widget.meal.mealRate,
                                    itemSize: 16,
                                    itemPadding: EdgeInsets.all(2),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.directional(
                              textDirection: Localizations.localeOf(context)
                                          .languageCode ==
                                      "en"
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              bottom: -20,
                              start: -10,
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        NetworkImage(widget.restaurantLogoUrl),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    child: Text(widget.meal.name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  GestureDetector(
                                    onTap: () => _actionShareMeal(
                                        widget.restaurantId,
                                        widget.categoryId,
                                        widget.meal.id),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Icon(Icons.share,
                                          color: Colors.black87),
                                    ),
                                  )
                                ],
                              ),
                              widget.meal?.ingredients != null &&
                                      widget.meal.ingredients.isNotEmpty
                                  ? Label(S.of(context).ingredients,
                                      fontSize: 16)
                                  : Container(),
                              widget.meal?.ingredients != null &&
                                      widget.meal.ingredients.isNotEmpty
                                  ? Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Paragraph(_parseIngredients(
                                              widget.meal.ingredients)),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              Label(S.of(context).description, fontSize: 16),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Paragraph(widget.meal.description !=
                                                null &&
                                            widget.meal.description.isNotEmpty
                                        ? widget.meal.description
                                        : S.of(context).noDescription),
                                  ),
                                ],
                              ),
                              widget.meal.price == null
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Spacer(),
                                          Text(S.of(context).price + ":",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                              PapricaFormatter.formatNumber(
                                                  widget.meal.price.floor()),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(S.of(context).currency,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  DialogCloseButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTapRateMeal(BuildContext context) {
    if (ApiTypesHelper().isAuthorized)
      _showUserRateDialog(context);
    else {
      showDialog(
          context: context,
          builder: (_context) {
            return PapricaSimpleDialog(
              title:
                  S.of(context).loggingInRequired(S.of(context).actionRateMeal),
              yesButton: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LogInScreen(asAService: true)))
                        .then((loggedIn) {
                      if (loggedIn != null && loggedIn) {
                        _showUserRateDialog(context);
                      } else {
                        PapricaToast.showToast(S
                            .of(context)
                            .loggingInRequired(S.of(context).actionRateMeal));
                      }
                    });
                  },
                  child: Text(S.of(context).logIn)),
            );
          });
    }
  }

  void _showUserRateDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return RateMealDialog(
            widget.meal,
          );
        });
  }

  void _actionShareMeal(int restId, int catId, int mealId) {
    Share.share(S.of(context).shareTextMeal(
        widget.meal.name,
        widget.restaurantName,
        "https://links.paprika-sy.com/meal/" +
            widget.restaurantId.toString() +
            "/" +
            widget.categoryId.toString() +
            "/" +
            widget.meal.id.toString()));
  }
}

class RateMealDialog extends StatefulWidget {
  final MealDto meal;
  final onRateChanged;

  RateMealDialog(this.meal, {this.onRateChanged});

  @override
  _RateMealDialogState createState() => _RateMealDialogState();
}

class _RateMealDialogState extends State<RateMealDialog> {
  double rate;

  @override
  void initState() {
    super.initState();
    rate = null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(S.of(context).yourRate),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlutterRatingBar(
                initialRating: widget.meal.oldUserRate,
                itemCount: 5,
                itemPadding: EdgeInsets.all(4),
                onRatingUpdate: (rating) {
                  setState(() {
                    if (rating != widget.meal.oldUserRate) {
                      rate = rating;
                    } else {
                      rate = null;
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        CustomizedInactiveButton(
          title: S.of(context).cancel,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CustomizedActiveButton(
          title: S.of(context).submit,
          onPressed: rate == null
              ? null
              : () {
                  ProgressDialog dialog = ProgressDialog(context);
                  dialog.setMessage(S.of(context).processing);
                  dialog.show();
                  ApiClient client = PapricaApiClient();
                  var api = CustomerMenuApi(client);
                  api
                      .apiServicesAppCustomerMenuRateMealPost(
                          input: MealRateDto.fromJson(
                              {"id": widget.meal.id, "rate": rate.floor()}))
                      .then((_) {
                    dialog.hide();
                    if (this.widget.onRateChanged != null &&
                        this.widget.onRateChanged is Function) {
                      this.widget.onRateChanged(rate);
                    }
                    widget.meal.oldUserRate = rate;
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => MessageDialog(
                        S.of(context).successRateMeal(widget.meal.name),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }).catchError((error) {
                    dialog.hide();
                    PapricaToast.showToast(
                        S.of(context).errorRateMeal, ToastType.Error);
                  });
                },
        ),
      ],
    );
  }
}

class MealListHeaderDelegate extends SliverPersistentHeaderDelegate {
  var toggleCallback;
  String categoryName;

  MealListHeaderDelegate(this.categoryName, this.toggleCallback);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return GestureDetector(
      onTap: () {
        toggleCallback();
      },
      child: Container(
        color: Color(0xFFF2F2F2),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Localizations.localeOf(context).languageCode == 'en'
                    ? Icons.keyboard_arrow_left
                    : Icons.keyboard_arrow_right,
                size: 36,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  this.categoryName != null ? this.categoryName : "",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(MealListHeaderDelegate oldDelegate) {
    return this.categoryName != oldDelegate.categoryName;
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
