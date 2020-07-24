import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:msp/main.dart';
import 'package:msp/models/project.dart';
import 'package:msp/pages/home.dart';
import 'package:msp/ui/app_theme.dart';

class StaffItem extends StatelessWidget {
  final Staff staff;

  const StaffItem(this.staff);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(16.0),
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppTheme.tab3Secondary.withOpacity(0.6),
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
          child: Container(
            height: 200,
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: staff.img.isNotEmpty ?Image.memory(
                getImageFromAPI(staff.img),
                fit: BoxFit.cover,
              ): Container(color: AppTheme.background,),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          width: 120,
          margin: EdgeInsets.only(bottom: 24, top: 16, right: 16, left: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: new LinearGradient(
              colors: [
                AppTheme.nearlyBlack.withOpacity(0.0),
                AppTheme.nearlyBlack.withOpacity(0.8),
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
                      AutoDirection(
                        text: staff.name,
                        child: Flexible(
                          child: Text(
                            staff.name.replaceFirst(" ", "\n"),
                            style: TextStyle(
                              color:AppTheme.nearlyWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color:AppTheme.nearlyBlack,
                                  offset: Offset(0.8, 0.8),
                                )
                              ],
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
    );
  }
}
