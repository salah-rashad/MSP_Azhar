import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:msp/models/playlist.dart';
import 'package:msp/models/session.dart';
import 'package:msp/services/api_services.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailedSessionScreen extends StatefulWidget {
  final Session session;

  const DetailedSessionScreen(this.session);

  @override
  _DetailedSessionScreenState createState() => _DetailedSessionScreenState();
}

class _DetailedSessionScreenState extends State<DetailedSessionScreen> {
  Future<PlayList> playlist;
  YoutubePlayerController _controller;

  final StreamController<String> _streamController = StreamController<String>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    playlist = API
        ?.fetchPlaylist(widget.session, scaffoldKey)
        ?.catchError((e) => print(e));

    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape) {
        SystemChrome.setPreferredOrientations(<DeviceOrientation>[
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ]);
      }
      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppTheme.tab2Primary,
          title: Text(widget.session.name),
          elevation: 10,
        ),
        body: FutureBuilder(
          future: playlist,
          builder: (context, snapshot) {
            PlayList playlist = snapshot.data;
            if (!snapshot.hasData) {
              return SpinKitPulse(
                size: 100,
                duration: Duration(seconds: 2),
                color: AppTheme.tab2Secondary.withOpacity(0.5),
              );
            } else {
              String currentVideoID = playlist.items[0].id;
              _controller = YoutubePlayerController(
                initialVideoId: currentVideoID,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              );

              return Column(
                children: <Widget>[
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    controlsTimeOut: Duration(seconds: 3),
                    bottomActions: <Widget>[
                      CurrentPosition(),
                      ProgressBar(isExpanded: true),
                      RemainingDuration()
                    ],
                    topActions: <Widget>[
                      FullScreenButton(),
                    ],
                  ),
                  Expanded(
                    child: StreamBuilder<String>(
                      stream: _streamController.stream,
                      initialData: currentVideoID,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return ListView.separated(
                            padding: EdgeInsets.all(0.0),
                            itemBuilder: (context, i) {
                              Video video = playlist.items[i];
                              return Container(
                                height: 80,
                                color: snapshot.data == video.id
                                    ? AppTheme.tab2Secondary.withOpacity(0.2)
                                    : Colors.transparent,
                                child: ListTile(
                                  onTap: snapshot.data == video.id
                                      ? null
                                      : () {
                                          _controller.load(video.id);
                                          _streamController.sink.add(video.id);
                                        },
                                  title: Text(
                                    video.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.darkerText),
                                  ),
                                  subtitle: Text(
                                    video.desc,
                                    style: TextStyle(
                                        color:
                                            AppTheme.darkText.withOpacity(0.6)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          width: 80,
                                          height: 60,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Image.network(
                                              video.imageDefault,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, i) {
                              return Divider(
                                indent: 100,
                                height: 0,
                                thickness: 1,
                              );
                            },
                            itemCount: playlist.items.length);
                      },
                    ),
                  )
                ],
              );
            }
          },
        ),
      );
    });
  }
}
