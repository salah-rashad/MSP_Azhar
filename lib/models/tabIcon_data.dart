import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/nav_icons/events.png',
      selectedImagePath: 'assets/nav_icons/events_s.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/nav_icons/sessions.png',
      selectedImagePath: 'assets/nav_icons/sessions_s.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/nav_icons/portfolio.png',
      selectedImagePath: 'assets/nav_icons/portfolio_s.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/nav_icons/about.png',
      selectedImagePath: 'assets/nav_icons/about_s.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
