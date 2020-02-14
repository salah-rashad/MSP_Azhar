import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:msp/main.dart';
import 'package:msp/models/project.dart';
import 'package:msp/pages/home.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:msp/utils/constants.dart';

class ProjectItem extends StatelessWidget {
  final Project project;
  final Animation animation;
  final AnimationController animationController;

  const ProjectItem(this.project, this.animation, this.animationController);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, detailedProjectRoute, arguments: this.project),
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.tab3Secondary,
                                    blurRadius: 20.0,
                                    // has the effect of softening the shadow
                                    spreadRadius: 0.0,
                                    // has the effect of extending the shadow
                                    offset: Offset(
                                      0.0, // horizontal, move right 5
                                      7.0, // vertical, move down 5
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(16.0),
                                gradient: new LinearGradient(
                                  colors: [
                                    AppTheme.tab3Primary,
                                    AppTheme.tab3Secondary
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16, left: 16, right: 16),
                                          child: AutoDirection(
                                            text: project.title,
                                            child: Text(
                                              project.title,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color:
                                                    AppTheme.nearlyWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8,
                                              left: 16,
                                              right: 16,
                                              bottom: 8),
                                          child: AutoDirection(
                                            text: project.description,
                                            child: Text(
                                              project.description,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                fontSize: 12,
                                                letterSpacing: 0.27,
                                                color: AppTheme
                                                    .nearlyWhite
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 24, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: AppTheme.grey.withOpacity(0.2),
                                  offset: const Offset(
                                    0.0,
                                    5.0,
                                  ),
                                  spreadRadius: 5.0,
                                  blurRadius: 15.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                              aspectRatio: 1.28,
                              child: project.image.trim().isNotEmpty
                                  ? Image.memory(
                                      getImageFromAPI(project.image),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    )
                                  : Container(color: AppTheme.background),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
