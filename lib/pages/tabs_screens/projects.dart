import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:msp/models/project.dart';
import 'package:msp/pages/tabs_screens/items_widgets/project_item.dart';
import 'package:msp/services/api_services.dart';
import 'package:msp/ui/app_theme.dart';

String _url = "https://msp-app-dashboard.herokuapp.com/api/projects/";

class ProjectsScreen extends StatefulWidget {
  final AnimationController animationController;

  const ProjectsScreen({Key key, this.animationController}) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with TickerProviderStateMixin {
  String category = "mobile";

  Future<List<Project>> projects;

  final StreamController<double> _topBarStreamController =
      StreamController<double>();
  final StreamController<Widget> _listStreamController =
      new StreamController<Widget>();

  Animation<double> topBarAnimation;
  Animation<double> animation;

  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  CategoryType categoryType = CategoryType.mobile;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    projects = API?.getProjects(_url, category);

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    super.initState();
  }

  @override
  void dispose() {
    _topBarStreamController.close();
    _listStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    widget.animationController.forward();

    return ListView(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: widget.animationController,
                    curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn)));

            return FadeTransition(
              opacity: animation,
              child: new Transform(
                transform: new Matrix4.translationValues(
                    0.0, 30 * (1.0 - animation.value), 0.0),
                child: Container(
                  height: 40,
                  width: 200,
                  child: ListView(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      getButtonUI(CategoryType.mobile,
                          categoryType == CategoryType.mobile),
                      const SizedBox(
                        width: 16,
                      ),
                      getButtonUI(
                          CategoryType.web, categoryType == CategoryType.web),
                      const SizedBox(
                        width: 16,
                      ),
                      getButtonUI(CategoryType.media,
                          categoryType == CategoryType.media),
                      const SizedBox(
                        width: 16,
                      ),
                      getButtonUI(
                          CategoryType.it, categoryType == CategoryType.it),
                      const SizedBox(
                        width: 16,
                      ),
                      getButtonUI(CategoryType.autonomous,
                          categoryType == CategoryType.autonomous),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Container(
          height: MediaQuery.of(context).size.height - 228,
          child: FutureBuilder<List<Project>>(
              future: projects,
              builder: (context, snapshot) {
                List<Project> projects = snapshot.data;

                if (snapshot.connectionState != ConnectionState.done) {
                  return new Center(
                    child: SpinKitPulse(
                      size: 100,
                      duration: Duration(seconds: 2),
                      color: AppTheme.tab3Secondary.withOpacity(0.5),
                    ),
                  );
                } else {
                  if (!snapshot.hasError && projects.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("assets/images/EmptyState.png",
                              height: 150, width: 250),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Text(
                              "No Projects Yet".toUpperCase(),
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: AppTheme.nearlyBlack.withOpacity(0.8)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "Stay connected, we may have \nsome projects soon!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: AppTheme.nearlyBlack.withOpacity(0.6)),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  if (!snapshot.hasData)
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("assets/images/NoInternetState.png",
                              height: 150, width: 250),
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Text(
                              "No internet connection\nPlease check your internet\nconnection",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: AppTheme.nearlyBlack.withOpacity(0.6)),
                            ),
                          )
                        ],
                      ),
                    );
                  else
                    return FadeTransition(
                      opacity: topBarAnimation,
                      child: DraggableScrollableActuator(
                        child: GridView(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 32, left: 16, right: 16),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: List<Widget>.generate(
                            projects.length,
                            (int index) {
                              animation = Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.animationController,
                                      curve: Interval(0.5, 1.0,
                                          curve: Curves.fastOutSlowIn)));

                              widget.animationController.forward();
                              return ProjectItem(
                                projects[index],
                                animation,
                                widget.animationController,
                              );
                            },
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 32.0,
                            crossAxisSpacing: 32.0,
                            childAspectRatio: 0.8,
                          ),
                        ),
                      ),
                    );
                }
              }),
        )
      ],
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (categoryTypeData == CategoryType.mobile) {
      txt = 'Mobile';
    } else if (categoryTypeData == CategoryType.web) {
      txt = 'Web';
    } else if (categoryTypeData == CategoryType.media) {
      txt = 'Media';
    } else if (categoryTypeData == CategoryType.it) {
      txt = 'IT';
    } else if (categoryTypeData == CategoryType.autonomous) {
      txt = 'Independent';
    }
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? AppTheme.tab3Secondary : AppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          border: Border.all(color: AppTheme.tab3Secondary)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white24,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          onTap: () {
            setState(() {
              categoryType = categoryTypeData;

              if (categoryType == CategoryType.mobile) {
                setState(() {
                  category = 'mobile';

                  projects = API.getProjects(_url, category);
                });
              } else if (categoryType == CategoryType.web) {
                setState(() {
                  category = 'web';

                  projects = API.getProjects(_url, category);
                });
              } else if (categoryType == CategoryType.media) {
                setState(() {
                  category = 'media';

                  projects = API.getProjects(_url, category);
                });
              } else if (categoryType == CategoryType.it) {
                setState(() {
                  category = 'it';

                  projects = API.getProjects(_url, category);
                });
              } else if (categoryType == CategoryType.autonomous) {
                setState(() {
                  category = 'autonomous';

                  projects = API.getProjects(_url, category);
                });
              }
            });
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 18, right: 18),
            child: Center(
              child: Text(
                txt.toUpperCase(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.27,
                  color: isSelected
                      ? AppTheme.nearlyWhite
                      : AppTheme.tab3Secondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return StreamBuilder<double>(
      stream: _topBarStreamController.stream,
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
                        0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
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
                                'Projects',
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
            )
          ],
        );
      },
    );
  }
}

enum CategoryType { mobile, web, media, it, autonomous }
