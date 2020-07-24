import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:msp/models/committee.dart';
import 'package:msp/pages/tabs_screens/items_widgets/committee_item.dart';
import 'package:msp/services/open_url.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  final AnimationController animationController;

  const AboutScreen({Key key, this.animationController}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  final StreamController<double> _streamController = StreamController<double>();

  Animation<double> topBarAnimation;
  Animation<double> animation;

  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  List<Committee> committeesList = List.generate(cTitle.length, (i) {
    return Committee(
      id: i,
      title: cTitle[i],
      image: cImage[i],
      description: cDescription[i],
      color: cColor[i],
    );
  });
  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          _streamController.sink.add(1.0);
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          _streamController.sink.add(scrollController.offset / 24);
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          _streamController.sink.add(0.0);
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            AnimatedBuilder(
                animation: widget.animationController,
                builder: (BuildContext context, Widget child) {
                  animation = Tween<double>(begin: 0.5, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.animationController,
                          reverseCurve:
                              Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
                          curve:
                              Interval(0.2, 1.0, curve: Curves.fastOutSlowIn)));

                  return FadeTransition(
                      opacity: animation,
                      child: new Transform(
                        transform: new Matrix4.translationValues(
                            0.0, -200 * (1.0 - animation.value), 0.0),
                        child: CustomPaint(
                          size: Size(size.width, 100),
                          painter: Painter(),
                        ),
                      ));
                }),
            AnimatedBuilder(
                animation: widget.animationController,
                builder: (BuildContext context, Widget child) {
                  animation = Tween<double>(begin: 0.2, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.animationController,
                          reverseCurve:
                              Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
                          curve:
                              Interval(0.2, 1.0, curve: Curves.fastOutSlowIn)));

                  return FadeTransition(
                      opacity: animation,
                      child: new Transform(
                        transform: new Matrix4.translationValues(
                            0.0, -250 * (1.0 - animation.value), 0.0),
                        child: CustomPaint(
                          size: Size(size.width, 150),
                          painter: Painter(opacity: 0.75),
                        ),
                      ));
                }),
            AnimatedBuilder(
                animation: widget.animationController,
                builder: (BuildContext context, Widget child) {
                  animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.animationController,
                          reverseCurve:
                              Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
                          curve:
                              Interval(0.2, 1.0, curve: Curves.fastOutSlowIn)));

                  return FadeTransition(
                      opacity: animation,
                      child: new Transform(
                        transform: new Matrix4.translationValues(
                            0.0, -300 * (1.0 - animation.value), 0.0),
                        child: CustomPaint(
                          size: Size(size.width, 200),
                          painter: Painter(opacity: 0.5),
                        ),
                      ));
                }),
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    widget.animationController.forward();

    return Padding(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(children: <Widget>[
        Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: AnimatedBuilder(
                animation: widget.animationController,
                builder: (BuildContext context, Widget child) {
                  animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: widget.animationController,
                          curve: Interval(0.25, 1.0,
                              curve: Curves.fastOutSlowIn)));

                  return FadeTransition(
                      opacity: animation,
                      child: new Transform(
                        transform: new Matrix4.translationValues(
                            0.0, 50 * (1.0 - animation.value), 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipOval(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFbb0000),
                                      Color(0xFFFF6161)
                                    ],
                                    stops: [0.0, 0.75],
                                  ),
                                ),
                                child: IconButton(
                                  tooltip: "YouTube",
                                  padding: EdgeInsets.only(right: 2),
                                  color: AppTheme.nearlyWhite,
                                  iconSize: 18,
                                  icon: Icon(FontAwesomeIcons.youtube),
                                  onPressed: () => openURL(
                                      "https://www.youtube.com/channel/UCnrCvhZJDpijR61BNo0rk9Q"),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            ClipOval(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF3b5998),
                                      Color(0xFF75A1FF)
                                    ],
                                    stops: [0.0, 0.75],
                                  ),
                                ),
                                child: IconButton(
                                  tooltip: "Facebook",
                                  padding: EdgeInsets.all(0),
                                  color: AppTheme.nearlyWhite,
                                  iconSize: 18,
                                  icon: Icon(FontAwesomeIcons.facebookF),
                                  onPressed: () async {
                                    String fbProtocolUrl =
                                        "https://m.fb.com/AlAzharTC/";
                                    String fallbackUrl =
                                        "https://www.facebook.com/AlAzharTC/";
                                    try {
                                      bool launched = await launch(
                                          fbProtocolUrl,
                                          forceSafariVC: false);

                                      if (!launched) {
                                        await launch(fallbackUrl,
                                            forceSafariVC: false);
                                      }
                                    } catch (e) {
                                      await launch(fallbackUrl,
                                          forceSafariVC: false);
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            ClipOval(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFbc2a8d),
                                      Color(0xFFFF6BD0)
                                    ],
                                    stops: [0.0, 0.75],
                                  ),
                                ),
                                child: IconButton(
                                  tooltip: "Instagram",
                                  padding: EdgeInsets.all(0),
                                  color: AppTheme.nearlyWhite,
                                  iconSize: 20,
                                  icon: Icon(FontAwesomeIcons.instagram),
                                  onPressed: () => openURL(
                                      "https://www.instagram.com/mspalazhar/"),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            ClipOval(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF007bb6),
                                      Color(0xFF4FC7FF)
                                    ],
                                    stops: [0.0, 0.75],
                                  ),
                                ),
                                child: IconButton(
                                  tooltip: "Linkedin",
                                  padding: EdgeInsets.all(0),
                                  color: AppTheme.nearlyWhite,
                                  iconSize: 18,
                                  icon: Icon(FontAwesomeIcons.linkedinIn),
                                  onPressed: () => openURL(
                                      "https://www.linkedin.com/company/msp-tech-club-al-azhar-university/"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
                }),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: AnimatedBuilder(
                      animation: widget.animationController,
                      builder: (BuildContext context, Widget child) {
                        animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: widget.animationController,
                                curve: Interval(0.375, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                        return FadeTransition(
                          opacity: animation,
                          child: new Transform(
                            transform: new Matrix4.translationValues(
                                0.0, 50 * (1.0 - animation.value), 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'MSP Tech Club - Al Azhar University',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: AppTheme.darkText,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "We are a student community program that promotes advanced technology through education, practice, and innovation. It also provides students with both technical and non-technical sessions needed which is packing their lives with high level of skills and supporting their careers with opportunities.",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      letterSpacing: 0.2,
                                      color: AppTheme.nearlyBlack
                                          .withOpacity(0.6)),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: AnimatedBuilder(
                      animation: widget.animationController,
                      builder: (BuildContext context, Widget child) {
                        animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: widget.animationController,
                                curve: Interval(0.5, 1.0,
                                    curve: Curves.fastOutSlowIn)));

                        return FadeTransition(
                          opacity: animation,
                          child: new Transform(
                            transform: new Matrix4.translationValues(
                                0.0, 50 * (1.0 - animation.value), 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Our Mission'.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.8,
                                    fontSize: 14,
                                    color: AppTheme.darkText,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "We have a clear mission is to help the students in the campus and to be there for any kind of support needed whether it’s technical or non-technical and to help them find their most suitable career.",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      letterSpacing: 0.2,
                                      color: AppTheme.nearlyBlack
                                          .withOpacity(0.6)),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: AnimatedBuilder(
                      animation: widget.animationController,
                      builder: (BuildContext context, Widget child) {
                        animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: widget.animationController,
                                curve: Interval(0.625, 1.0,
                                    curve: Curves.fastOutSlowIn)));

                        return FadeTransition(
                          opacity: animation,
                          child: new Transform(
                            transform: new Matrix4.translationValues(
                                0.0, 50 * (1.0 - animation.value), 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Products'.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.8,
                                    fontSize: 14,
                                    color: AppTheme.darkText,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "Technical Sessions, Soft Skills, Workshops, Courses and Competitions.",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      letterSpacing: 0.2,
                                      color: AppTheme.nearlyBlack
                                          .withOpacity(0.6)),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 32.0,
                ),
                AnimatedBuilder(
                    animation: widget.animationController,
                    builder: (BuildContext context, Widget child) {
                      animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: widget.animationController,
                              curve: Interval(0.75, 1.0,
                                  curve: Curves.fastOutSlowIn)));

                      return FadeTransition(
                        opacity: animation,
                        child: new Transform(
                          transform: new Matrix4.translationValues(
                              0.0, 50 * (1.0 - animation.value), 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 22),
                                child: Text(
                                  'Our Community'.toUpperCase(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.8,
                                    fontSize: 14,
                                    color: AppTheme.darkText,
                                  ),
                                ),
                              ),
                              Container(
                                height: 250,
                                child: Swiper(
                                  viewportFraction: 0.8,
                                  scale: 0.9,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: committeesList.length,
                                  itemBuilder: (context, i) {
                                    return CommitteeItem(committeesList[i]);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget getAppBarUI() {
    return StreamBuilder<double>(
      stream: _streamController.stream,
      initialData: topBarOpacity,
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            AnimatedBuilder(
              animation: widget.animationController,
              builder: (BuildContext context, Widget child) {
                return FadeTransition(
                  opacity: topBarAnimation,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 50 * (1.0 - topBarAnimation.value), 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.white.withOpacity(snapshot.data),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey
                                  .withOpacity(0.4 * snapshot.data),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).padding.top,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16 - 8.0 * snapshot.data,
                                bottom: 12 - 8.0 * snapshot.data),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'About',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22 + 6 - 6 * snapshot.data,
                                  letterSpacing: 1.2,
                                  color: AppTheme.darkerText,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class Painter extends CustomPainter {
  final double opacity;

  Painter({this.opacity = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.lineTo(size.width / 3, 0);
    path.quadraticBezierTo(
      size.width * 0.40,
      size.height * 0.05,
      size.width * 0.42,
      size.height * 0.20,
    );

    path.quadraticBezierTo(
      size.width * 0.45,
      size.height * 0.42,
      size.width * 0.55,
      size.height * 0.45,
    );
    path.quadraticBezierTo(
      size.width * 0.70,
      size.height * 0.50,
      size.width * 0.75,
      size.height * 0.65,
    );
    path.quadraticBezierTo(
      size.width * 0.80,
      size.height * 0.80,
      size.width * 0.90,
      size.height * 0.85,
    );
    path.quadraticBezierTo(
      size.width * 0.99,
      size.height * 0.90,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();

    paint.color = AppTheme.tab4Secondary.withOpacity(opacity);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(Painter oldDelegate) {
    return true;
  }
}


