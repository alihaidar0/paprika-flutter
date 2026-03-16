import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paprika/generated/i18n.dart';
import 'package:paprika/src/models/reviews_state.dart';
import 'package:paprika/widgets.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../utils.dart';

class RestaurantReviewsPage extends StatefulWidget {
  final ScrollController scrollController;
  final RestaurantHomeDto restaurantData;

  final ReviewsState reviewsState;

  final storeReviewsState;

  RestaurantReviewsPage(this.reviewsState, this.storeReviewsState,
      this.restaurantData, this.scrollController);

  @override
  _RestaurantReviewsPageState createState() => _RestaurantReviewsPageState();
}

class _RestaurantReviewsPageState extends State<RestaurantReviewsPage> {
  Future<RestaurantReviewsSummaryDto> reviewsSummary;
  Future<PagedResultDtoReviewDto> allCommentsFuture;
  int skipCount, maxCount;
  List<ReviewSummaryDto> reviewsCommentsList = [];
  bool isLoading = false;
  bool endOfReviewReached = false;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    skipCount = 0;
    maxCount = 3;
    scrollController = new ScrollController();
    widget.scrollController.addListener(_scrollListener);
    _checkReviewState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.maxScrollExtent - scrollController.offset <=
            0 &&
        false == isLoading &&
        false == endOfReviewReached) {
      _getAllComments(
        mSkipCount: reviewsCommentsList.length,
        mMaxCount: 3,
      );
    }
  }

  initCommentsSection() {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xFFF2F2F2),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background_grey.png'),
                      fit: BoxFit.cover)),
              child: Column(
                children: <Widget>[
                  ReviewResult(
                      restaurantRate: widget.restaurantData.restaurantRate,
                      restaurantRaters: widget.restaurantData.restaurantRaters),
                  ServiceReviewsLine(
                    foodRate: widget.restaurantData.foodRate,
                    serviceRate: widget.restaurantData.serviceRate,
                    shishaRate: widget.restaurantData.shishaRate,
                    ambianceRate: widget.restaurantData.ambianceRate,
                    noiseLevel: ApiHelper.toStringNoiseLevel(
                        context, widget.restaurantData?.noiseLevel),
                  ),
                  FutureBuilder(
                    future: reviewsSummary,
                    builder: (context,
                        AsyncSnapshot<RestaurantReviewsSummaryDto> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            ReviewForm(
                              restaurantId: widget.restaurantData.id,
                              restaurantName: widget.restaurantData.name,
                              customerProfileImage:
                                  ApiTypesHelper().profileImage,
                              oldReview:
                                  widget.reviewsState.customerReview != null
                                      ? widget.reviewsState.customerReview
                                      : snapshot.data?.customerReview,
                              hasShisha: widget.restaurantData.hasShisha,
                              onSubmit: (jsonData) => widget.storeReviewsState(
                                  ReviewsState(
                                      summary: reviewsSummary,
                                      customerReview:
                                          ReviewDto.fromJson(jsonData))),
                            ),
                            Container(
                                color: Color(0xFFF2F2F2),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 24.0),
                                  child: reviewsCommentsList != null &&
                                          reviewsCommentsList.length > 0
                                      ? ListView.builder(
                                          controller: scrollController,
                                          shrinkWrap: true,
                                          itemCount: reviewsCommentsList.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.all(0),
                                          itemBuilder: (context, index) {
                                            return ReviewCommentsListItem(
                                                reviewsCommentsList[index]);
                                          })
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 24),
                                          child: Center(
                                              child: Text(S
                                                  .of(context)
                                                  .noReviews(widget
                                                      .restaurantData.name))),
                                        ),
                                )),
                            _renderEndOfReview(),
                            SizedBox(
                              height: 60,
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RequestRetry(
                              message: S.of(context).errorUnknown,
                              retryCallback: _getReviewsAsync),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _checkReviewState() {
    if (widget.reviewsState != null && widget.reviewsState.summary != null) {
      reviewsSummary = widget.reviewsState.summary;
    } else {
      _getReviewsAsync();
    }
    setState(() {
      reviewsSummary.then((onValue) {
        reviewsCommentsList.addAll(onValue.reviews);
      });
    });

    return reviewsSummary.then((_) {
      return Future.value();
    }).catchError((err) {
      DefaultErrorHandler.handle(context, err);
      return Future.value();
    });
  }

  Future _getReviewsAsync() {
    ApiClient apiClient =
        ApiTypesHelper().isAuthorized ? PapricaApiClient() : ApiClient();
    var apiInstance = new CustomerReviewApi(apiClient);
    setState(() {
      widget.reviewsState.summary = reviewsSummary = apiInstance
          .apiServicesAppCustomerReviewGetRestaurantReviewsSummaryGet(
              id: widget.restaurantData.id);
      reviewsSummary.then((data) {
        ApiTypesHelper().setProfileImage(data.customerProfileImage);
        widget.storeReviewsState(ReviewsState(summary: reviewsSummary));
      });
    });
    reviewsSummary.then((_) {}).catchError((err) {});
    return Future.value();
  }

  Future _getAllComments({int mSkipCount, int mMaxCount}) {
    ApiClient client = PapricaApiClient();
    CustomerReviewApi api = CustomerReviewApi(client);
    setState(() {
      isLoading = true;
      allCommentsFuture = allCommentsFuture =
          api.apiServicesAppCustomerReviewGetOldGet(
              restaurantId: widget.restaurantData.id,
              skipCount: mSkipCount ?? 0,
              maxResultCount: mMaxCount ?? 3);
    });
    return allCommentsFuture.then((onValue) {
      setState(() {
        isLoading = false;
        if (onValue.items.length == 0)
          endOfReviewReached = true;
        else
          reviewsCommentsList.addAll(onValue.items);
      });
      return Future.value();
    }).catchError((err) {
      return Future.value();
    });
  }

  Widget _renderEndOfReview() {
    if (reviewsCommentsList.isEmpty) return EmptyWidget();
    if (isLoading)
      return SpinKitCircle(color: Colors.grey, size: 32);
    else {
      if (endOfReviewReached) {
        return Container();
      } else {
        return Container();
      }
    }
  }
}
