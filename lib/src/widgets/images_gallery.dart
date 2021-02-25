import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paprika/generated/i18n.dart';
import 'package:paprika/src/widgets/carousel_slider.dart';

class ImagesGallery extends StatefulWidget {
  final List<String> thumbnails;

  final List<String> urls;
  final bool isLocale;

  ImagesGallery({this.thumbnails, this.urls, this.isLocale = false});

  @override
  _ImagesGalleryState createState() => _ImagesGalleryState();
}

class _ImagesGalleryState extends State<ImagesGallery> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    final List<Widget> imagesWidget = _getWidgetsForGallery(context);
    return widget.thumbnails.length > 0
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: GestureDetector(
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(8.0),
//                    child: FadeInImage.memoryNetwork(
//                      width: MediaQuery.of(context).size.width * 0.44,
//                      height: MediaQuery.of(context).size.width * 0.44,
//                      placeholder: kTransparentImage,
//                      fit: BoxFit.cover,
//                      image: widget.thumbnails[0],
//                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.thumbnails[0],
//                      fadeInDuration: Duration(milliseconds: 2500),

                      width: MediaQuery.of(context).size.width * 0.44,
                      height: MediaQuery.of(context).size.width * 0.44,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image(
                        image: AssetImage("assets/images/placeholder.png"),
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: MediaQuery.of(context).size.width * 0.44,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) =>
                            CarouselWithIndicator(
                              mInitialPage: 0,
                              urls: this.widget.urls,
                              isLocal: this.widget.isLocale,
                            ));
                  },
                ),
              ),
              widget.thumbnails.length > 1
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                              child: GestureDetector(
                                child: ClipRRect(
                                  borderRadius: new BorderRadius.circular(8.0),
//                                  child: FadeInImage.memoryNetwork(
//                                    fit: BoxFit.cover,
//                                    width: MediaQuery.of(context).size.width * 0.211,
//                                    height: MediaQuery.of(context).size.width * 0.211,
//                                    image: widget.thumbnails[1],
//                                    placeholder: kTransparentImage,
//                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.thumbnails[1],
                                    width: MediaQuery.of(context).size.width *
                                        0.211,
                                    height: MediaQuery.of(context).size.width *
                                        0.211,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Image(
                                      image: AssetImage(
                                          "assets/images/placeholder.png"),
                                      width: MediaQuery.of(context).size.width *
                                          0.211,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.211,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CarouselWithIndicator(
                                            mInitialPage: 1,
                                            urls: this.widget.urls,
                                            isLocal: this.widget.isLocale,
                                          ));
                                },
                              ),
                            ),
                            widget.thumbnails.length > 2
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                    child: GestureDetector(
                                      child: ClipRRect(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
//                                        child: FadeInImage.memoryNetwork(
//                                          fit: BoxFit.cover,
//                                          width: MediaQuery.of(context).size.width * 0.211,
//                                          height: MediaQuery.of(context).size.width * 0.211,
//                                          image: widget.thumbnails[2],
//                                          placeholder: kTransparentImage,
//                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: widget.thumbnails[2],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.211,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.211,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Image(
                                            image: AssetImage(
                                                "assets/images/placeholder.png"),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.211,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.211,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CarouselWithIndicator(
                                                  mInitialPage: 2,
                                                  urls: this.widget.urls,
                                                  isLocal: this.widget.isLocale,
                                                ));
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        widget.thumbnails.length > 3
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                    child: GestureDetector(
                                      child: ClipRRect(
                                        borderRadius:
                                            new BorderRadius.circular(8.0),
//                                        child: FadeInImage.memoryNetwork(
//                                          fit: BoxFit.cover,
//                                          width: MediaQuery.of(context).size.width * 0.211,
//                                          height: MediaQuery.of(context).size.width * 0.211,
//                                          image: widget.thumbnails[3],
//                                          placeholder: kTransparentImage,
//                                        ),

                                        child: CachedNetworkImage(
                                          imageUrl: widget.thumbnails[3],
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.211,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.211,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Image(
                                            image: AssetImage(
                                                "assets/images/placeholder.png"),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.211,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.211,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CarouselWithIndicator(
                                                  mInitialPage: 3,
                                                  urls: this.widget.urls,
                                                  isLocal: this.widget.isLocale,
                                                ));
                                      },
                                    ),
                                  ),
                                  widget.thumbnails.length > 4
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              4, 4, 4, 4),
                                          child: GestureDetector(
                                            child: widget.thumbnails.length > 5
                                                ? Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.211,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.211,
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: <Widget>[
                                                        ClipRRect(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  8.0),
//                                                          child: FadeInImage.memoryNetwork(
//                                                            fit: BoxFit.cover,
//                                                            image: widget.thumbnails[4],
//                                                            placeholder: kTransparentImage,
//                                                          ),

                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: widget
                                                                .thumbnails[4],
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.211,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.211,
                                                            fit: BoxFit.cover,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Image(
                                                              image: AssetImage(
                                                                  "assets/images/placeholder.png"),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.211,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.211,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8)),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Text(
                                                            S
                                                                .of(context)
                                                                .viewGallery,
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: true,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.white,
                                                              shadows: <Shadow>[
                                                                Shadow(
                                                                  offset:
                                                                      Offset(
                                                                          2, 2),
                                                                  blurRadius:
                                                                      8.0,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.211,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.211,
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: <Widget>[
                                                        ClipRRect(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  8.0),
//                                                          child: FadeInImage.memoryNetwork(
//                                                            fit: BoxFit.cover,
//                                                            image: widget.thumbnails[4],
//                                                            placeholder: kTransparentImage,
//                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: widget
                                                                .thumbnails[4],
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.211,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.211,
                                                            fit: BoxFit.cover,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Image(
                                                              image: AssetImage(
                                                                  "assets/images/placeholder.png"),
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.211,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.211,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          CarouselWithIndicator(
                                                            mInitialPage: 4,
                                                            urls: this
                                                                .widget
                                                                .urls,
                                                            isLocal: this
                                                                .widget
                                                                .isLocale,
                                                          ));
                                            },
                                          ),
                                        )
                                      : Container(),
                                ],
                              )
                            : Container(),
                      ],
                    )
                  : Container(),
            ],
          )
        : Container();
  }
}
