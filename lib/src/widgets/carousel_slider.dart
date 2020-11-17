import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paprica/generated/i18n.dart';
import 'package:paprica/src/widgets/slider.dart';
import 'package:paprica/widgets.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

final Widget placeholder = Container(color: Colors.grey);

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  final int mInitialPage;

  final List<String> urls;

  final bool isLocal;

  final Stream<bool> fullscreenControlStream;

  CarouselWithIndicator(
      {@required this.urls,
      this.mInitialPage = 0,
      this.isLocal = false,
      this.fullscreenControlStream});

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _initialPage = 0;
  int _current = 0;

  PageController pageController;

  bool listeningFullscreen;

  List<Widget> images;

  @override
  void initState() {
    super.initState();
    _initialPage = widget.mInitialPage;
    _current = _initialPage;
    pageController =
        PageController(viewportFraction: 0.8, initialPage: _initialPage);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    images ??= _getWidgetsForGallery(context);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).gallery,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 35,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  widget.urls != null
                      ? GestureDetector(
                          onTap: () => _openFullscreen(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.fullscreen,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              CarouselSlider(
                items: images,
                height: 260,
                enableInfiniteScroll: images.length > 1,
                viewportFraction: 0.70,
                initialPage: _initialPage,
                autoPlay: false,
                onPageChanged: (index) {
                  setState(() {
                    _current = (index + _initialPage) % images.length;
                  });
                },
                enlargeCenterPage: true,
                autoPlayCurve: Curves.bounceInOut,
                mPageController: pageController,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(
                    images,
                    (index, url) {
                      return Container(
                        width: _current == index ? 8.0 : 6.0,
                        height: _current == index ? 8.0 : 6.0,
                        margin: EdgeInsets.fromLTRB(2, 0, 2, 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Theme.of(context).primaryColor
                                : Colors.white70),
                      );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: DialogCloseButton(),
              ),
            ]),
      ),
    );
  }

  void _openFullscreen(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Icon(
                    Icons.fullscreen_exit,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            body: Center(
                child: PhotoViewGallery.builder(
              pageController: PageController(initialPage: _current),
              itemCount: widget.urls.length,
              loadingBuilder: (context, progress) =>
                  SpinKitCubeGrid(color: Theme.of(context).primaryColor),
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  imageProvider: widget.isLocal
                      ? AssetImage(widget.urls[index])
                      : NetworkImage(widget.urls[index]),
                  initialScale: PhotoViewComputedScale.contained,
                  heroAttributes: PhotoViewHeroAttributes(tag: widget.urls[index]),
                  // heroTag: widget.urls[index],
                );
              },
            )),
          );
        }).then((close) {
      if (close != null && close) {
        Navigator.of(context).pop();
      }
    });
  }

  List<Widget> _getWidgetsForGallery(BuildContext context) {
    return map<Widget>(this.widget.urls, (index, image) {
      return GestureDetector(
        onDoubleTap: () {
          _openFullscreen(context);
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(fit: StackFit.expand, children: <Widget>[
              FadeInImage.memoryNetwork(
                image: image,
                placeholder: kTransparentImage,
                fit: BoxFit.cover,
              ),
            ]),
          ),
        ),
      );
    }).toList();
  }
}
