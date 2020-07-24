import 'package:flutter/material.dart';
import 'package:msp/main.dart';
import 'package:msp/models/committee.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:msp/utils/constants.dart';
import 'package:page_transition/page_transition.dart';

class CommitteeItem extends StatelessWidget {
  final Committee committee;

  const CommitteeItem(this.committee);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, detailedCommitteeRoute,
          arguments: this.committee),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 8.0),
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppTheme.nearlyBlack.withOpacity(0.8),
                  blurRadius: 20.0,
                  // has the effect of softening the shadow
                  spreadRadius: -3.0,
                  // has the effect of extending the shadow
                  offset: Offset(
                    0.0, // horizontal, move right 5
                    7.0, // vertical, move down 5
                  ),
                )
              ],
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Hero(
              tag: "/ImageTag/${committee.id}",
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(16.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: committee.image.isNotEmpty
                      ? Image.asset(
                          committee.image,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: AppTheme.background,
                        ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 30, top: 16, right: 8.0, left: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: new LinearGradient(
                colors: [
                  Colors.transparent,
                  AppTheme.nearlyBlack.withOpacity(0.6),
                ],
                stops: [0.5, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Hero(
                            tag: "/TitleTag/${committee.id}",
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                committee.title + " ",
                                style: TextStyle(
                                  color: AppTheme.nearlyWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: AppTheme.nearlyBlack,
                                      offset: Offset(0.8, 0.8),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
