import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:msp/models/tabIcon_data.dart';
import 'package:msp/pages/tabs_screens/about.dart';
import 'package:msp/pages/tabs_screens/events.dart';
import 'package:msp/pages/tabs_screens/projects.dart';
import 'package:msp/pages/tabs_screens/sessions.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:msp/widgets/bottom_bar_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    tabBody = EventsScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: AppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    tabBody,
                    bottomBar(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      EventsScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = SessionsScreen(
                    animationController: animationController,
                    scaffoldKey: scaffoldKey,
                  );
                });
              });
            } else if (index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      ProjectsScreen(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      AboutScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}

Future<bool> getData() async {
  await Future<dynamic>.delayed(const Duration(milliseconds: 200));
  return true;
}

Uint8List getImageFromAPI(String image) {
  var img = image
      .replaceAll("data:image/jpeg;base64,", "")
      .replaceAll("data:image/png;base64,", "");
  return base64.decode(img);
}