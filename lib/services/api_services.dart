import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:msp/models/event.dart';
import 'package:msp/models/playlist.dart';
import 'package:msp/models/project.dart';
import 'package:msp/models/session.dart';
import 'package:msp/ui/app_theme.dart';

String _YOUTUBE_API_KEY = "AIzaSyBKnPJ-IxA__CXleozkk2uM-NqKdL4LVjU";

class API {
  // Get data from api url
  static Future<http.Response> getData(String url) {
    return http.get(url);
  }

  // Get events list (sort NEWER first)
  static Future<List<Event>> getEvents(String url) async {
    return await getData(url).then((response) {
      Iterable list = json.decode(response.body);
      List<Event> list2 = list.map((model) => Event.fromJson(model)).toList();
      list2.sort((a, b) {
        var aDate = DateTime.parse(a.date);
        var bDate = DateTime.parse(b.date);
        return bDate.compareTo(aDate);
      });
      return list2;
    });
  }

  // Get sessions list
  static Future<List<Session>> getSessions(String url) async {
    return await API.getData(url).then((response) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Session.fromJson(model)).toList();
    });
  }

  // Get projects list
  static Future<List<Project>> getProjects(String url, String category) async {
    return await API.getData(url + category).then((response) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Project.fromJson(model)).toList();
    });
  }

  // Fetch session playlist using YouTube API v3
  static Future<PlayList> fetchPlaylist(
      Session session, GlobalKey<ScaffoldState> scaffoldKey) async {
    // Getting playlist id from playlist link.
    String playlistID = session.courseLink.split("list=")[1];
    // Unique API key of YouTube Data API.

    // Youtube playlist snippet response.
    final response = await http.get(
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=${playlistID}&fields=items%2Fsnippet&key=${_YOUTUBE_API_KEY}');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return PlayList.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      print('Failed to load playlist');
      return null;
    }
  }
}
