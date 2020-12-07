import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paprica/error_handlers.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/src/widgets/offer_card.dart';
import 'package:swagger/api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../utils.dart';
import 'package:paprica/src/widgets/accessories.dart' show LoadingPlaceHolder;

class OffersListScreen extends StatefulWidget {
  const OffersListScreen();

  @override
  _OffersListScreenState createState() => _OffersListScreenState();
}

class _OffersListScreenState extends State<OffersListScreen> {
  Future<PagedResultDtoCustomerOfferDto> offerFuture;
  List<dynamic> offers;
  ScrollController _scrollController;

  bool _requestingData;
  bool _endOfOffers;

  @override
  void initState() {
    super.initState();
    _requestingData = false;
    _endOfOffers = false;
    offers = [];
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.offset &&
          !_requestingData &&
          offers.isNotEmpty &&
          context != null &&
          !_endOfOffers) {
        _getOffers(skipCount: offers.length);
      }
    });
    _getOffers();
  }

  @override
  Widget build(BuildContext context) {
    if (_requestingData) {
      offers.add(SpinKitCircle(color: Colors.grey, size: 32));
    }
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          title: Text(S.of(context).offer4You),
        ),
        body: FutureBuilder(
            future: offerFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return offers.length > 0
                    ? ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: offers.length, //snapshot.data.items.length,
                        itemBuilder: (context, index) {
                          if (offers[index] is CustomerOfferDto) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: OfferCardInList(
                                offer: OfferPapricaItemDto.fromCustomerOfferDto(
                                    offers[
                                        index] /*snapshot.data.items[index]*/),
                              ),
                            );
                          } else {
                            return offers[index];
                          }
                        },
                      )
                    : Center(child: NoOffersLayout());
              }
              return LoadingPlaceHolder(
                icon: SpinKitFadingCube(
                  color: Theme.of(context).primaryColor,
                ),
                line: S.of(context).findingOffers,
              );
            }));
  }

  _getOffers({int skipCount = 0, int maxResult = 4}) {
    setState(() {
      _requestingData = true;
    });
    ApiClient client = PapricaApiClient();
    CustomerOfferApi api = CustomerOfferApi(client);
    offerFuture = api.apiServicesAppCustomerOfferGetAllActiveGet(
        skipCount: skipCount, maxResultCount: maxResult);
    offerFuture.then((data) {
      setState(() {
        if (offers.last is SpinKitCircle) offers.removeLast();
        _requestingData = false;
        if (data.items.isEmpty) {
          _endOfOffers = true;
        } else {
          offers.addAll(data.items);
        }
      });
    });
    offerFuture.catchError((err) {
      setState(() {
        if (offers.last is SpinKitCircle) offers.removeLast();
        _requestingData = false;
      });
      DefaultErrorHandler.handle(context, err);
    });

//    offerFuture.catchError((_) {});
  }
}

class NoOffersLayout extends StatelessWidget {
  const NoOffersLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(S.of(context).noOffers),
        ));
  }
}
