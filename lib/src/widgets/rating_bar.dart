import 'package:flutter/material.dart';

typedef RatingCallback(double rating);

class FlutterRatingBarIndicator extends StatelessWidget {
  ///[rating] takes the rating value for indicator. if [rating]==null value defaults to 0.0
  final double rating;

  ///[itemCount] is the count of rating bar items.
  final int itemCount;

  /// [itemSize] of each rating item in the bar.
  final double itemSize;

  /// [itemPadding] gives padding to each rating item.
  final EdgeInsets itemPadding;

  /// [fillColor] fills the rating indicator on rated part.
  final Color fillColor;

  /// [physics] controls the scrolling behaviour of rating bar. Default is [NeverScrollableScrollPhysics].
  final ScrollPhysics physics;

  /// [emptyColor] fills the rating indicator on unrated part.
  final Color emptyColor;

  /// [pathClipper] takes CustomClipper to generate custom-shapes for rating items.
  final CustomClipper<Path> pathClipper;

  FlutterRatingBarIndicator({
    this.rating = 0.0,
    this.itemCount = 5,
    this.itemSize = 30.0,
    this.itemPadding = const EdgeInsets.all(4.0),
    this.fillColor = Colors.amber,
    this.emptyColor = Colors.white,
    this.physics = const NeverScrollableScrollPhysics(),
    this.pathClipper,
  });

  Widget _buildStar(BuildContext context, double size, int mIndex,
      int mRatingNumber, double mRatingFraction) {
    if (mIndex < mRatingNumber) {
      return Image(
        image: AssetImage('assets/icons/rating_star_100.png'),
        width: size,
        height: size,
      );
    } else if (mIndex > mRatingNumber) {
      return Image(
        image: AssetImage('assets/icons/rating_star_0.png'),
        width: size,
        height: size,
      );
    } else if (mRatingFraction <= 10 && mIndex == mRatingNumber) {
      return Image(
        image: AssetImage('assets/icons/rating_star_0.png'),
        width: size,
        height: size,
      );
    } else if (mRatingFraction <= 25 && mIndex == mRatingNumber) {
      return Image(
        image: Localizations.localeOf(context).languageCode == 'en'
            ? AssetImage('assets/icons/rating_star_25.png')
            : AssetImage('assets/icons/rating_star_25_ar.png'),
        width: size,
        height: size,
      );
    } else if (mRatingFraction <= 50 && mIndex == mRatingNumber) {
      return Image(
        image: Localizations.localeOf(context).languageCode == 'en'
            ? AssetImage('assets/icons/rating_star_50.png')
            : AssetImage('assets/icons/rating_star_50_ar.png'),
        width: size,
        height: size,
      );
    } else if (mRatingFraction <= 100 && mIndex == mRatingNumber) {
      return Image(
        image: Localizations.localeOf(context).languageCode == 'en'
            ? AssetImage('assets/icons/rating_star_75.png')
            : AssetImage('assets/icons/rating_star_75_ar.png'),
        width: size,
        height: size,
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    double _ratingFraction = 0.0;
    int _ratingNumber = 0;

    _ratingNumber = rating.truncate();
    _ratingFraction = (rating - _ratingNumber + 1) * 100;
    _ratingNumber = rating.truncate();
    _ratingFraction = (rating - _ratingNumber) * 100;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: physics,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          itemCount,
          (index) {
            return Padding(
              padding: itemPadding,
              child: Container(
                child: Container(
                  child: _buildStar(
                      context, itemSize, index, _ratingNumber, _ratingFraction),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FlutterRatingBar extends StatefulWidget {
  ///[itemCount] is the count of rating bar items.
  final int itemCount;

  ///[initialRating] is initial rating to be set to the rating bar.
  final double initialRating;

  ///[onRatingUpdate] is a callback which return current rating.
  final RatingCallback onRatingUpdate;

  ///[fillColor] colors [halfRatingWidget] and [fullRatingWidget].
  final Color fillColor;

  /// [borderColor] colors the [noRatingWidget].
  final Color borderColor;

  /// [itemSize] of each rating item in the bar.
  final double itemSize;

  ///Default [allowHalfRating] = false. Setting true enables half rating support.
  final bool allowHalfRating;

  ///[fullRatingWidget] denotes the full rating status. Default is Icon(Icons.star).
  final Widget fullRatingWidget;

  ///[halfRatingWidget] denotes the half rating status. Default is Icon(Icons.star_half).
  final Widget halfRatingWidget;

  ///[noRatingWidget] denotes the full rating status. Default is Icon(Icons.star_border).
  final Widget noRatingWidget;

  /// [itemPadding] gives padding to each rating item.
  final EdgeInsets itemPadding;

  /// [ignoreGestures]=false, if set to true will disable any gestures over the rating bar.
  final bool ignoreGestures;

  /// [tapOnlyMode]=false, if set to true will disable drag to rate feature. Note: Enabling this mode will disable half rating capability.
  final bool tapOnlyMode;

  FlutterRatingBar({
    this.itemCount = 5,
    this.initialRating = 0.0,
    @required this.onRatingUpdate,
    this.fillColor = Colors.amber,
    this.borderColor,
    this.itemSize,
    this.allowHalfRating = false,
    this.fullRatingWidget,
    this.halfRatingWidget,
    this.noRatingWidget,
    this.itemPadding = const EdgeInsets.all(0.0),
    this.ignoreGestures = false,
    this.tapOnlyMode = false,
  });

  @override
  _FlutterRatingBarState createState() => _FlutterRatingBarState();
}

class _FlutterRatingBarState extends State<FlutterRatingBar> {
  double _rating = 0.0;
  double _ratingHistory = 0.0;
  double iconRating = 0.0;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
    _ratingHistory = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    if (_ratingHistory != widget.initialRating) {
      _rating = widget.initialRating;
      _ratingHistory = widget.initialRating;
    }
    iconRating = 0.0;
    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: List.generate(
          widget.itemCount,
          (index) {
            return _buildRating(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildRating(BuildContext context, int index) {
    Widget ratingWidget;
    if (index >= _rating) {
      ratingWidget = widget.noRatingWidget ??
          Image(
            image: AssetImage('assets/icons/rating_star_0.png'),
            width: widget.itemSize ?? 25.0,
            height: widget.itemSize ?? 25.0,
            filterQuality: FilterQuality.high,
          );
    } else if (index > _rating - (widget.allowHalfRating ? 0.5 : 1.0) &&
        index < _rating) {
      ratingWidget = widget.halfRatingWidget ??
          Image(
            image: AssetImage('assets/icons/rating_star_0.png'),
            width: widget.itemSize ?? 25.0,
            height: widget.itemSize ?? 25.0,
            filterQuality: FilterQuality.high,
          );

      iconRating += 0.5;
    } else {
      ratingWidget = widget.fullRatingWidget ??
          Image(
            image: AssetImage('assets/icons/rating_star_100.png'),
            width: widget.itemSize ?? 25.0,
            height: widget.itemSize ?? 25.0,
            filterQuality: FilterQuality.high,
          );
      iconRating += 1.0;
    }

    return IgnorePointer(
      ignoring: widget.ignoreGestures,
      child: GestureDetector(
        onTap: () {
          if (widget.onRatingUpdate != null) {
            widget.onRatingUpdate(index + 1.0);
            setState(() {
              _rating = index + 1.0;
            });
          }
        },
        onHorizontalDragEnd: (_) {
          widget.onRatingUpdate(iconRating);
          iconRating = 0.0;
        },
        onHorizontalDragUpdate: (dragDetails) {
          if (!widget.tapOnlyMode) {
            RenderBox box = context.findRenderObject();
            var _pos = box.globalToLocal(dragDetails.globalPosition);
            var i = _pos.dx / widget.itemSize;
            var currentRating;
            if (Localizations.localeOf(context).languageCode == 'en') {
              currentRating = widget.allowHalfRating ? i : i.round().toDouble();
            } else {
              currentRating = widget.allowHalfRating
                  ? widget.itemCount - i
                  : widget.itemCount - i.round().toDouble();
            }
            if (currentRating > widget.itemCount) {
              currentRating = widget.itemCount.toDouble();
            }
            if (currentRating < 0) {
              currentRating = 0.0;
            }
            if (widget.onRatingUpdate != null) {
              setState(() {
                _rating = currentRating;
              });
            }
          }
        },
        child: Padding(
          padding: widget.itemPadding,
          child: ratingWidget,
        ),
      ),
    );
  }
}
