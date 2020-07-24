import 'package:url_launcher/url_launcher.dart';

void openURL(String url) async {
  String mUrl = url;
  if (await canLaunch(mUrl)) {
    await launch(mUrl);
  } else {
    throw 'Could not launch $mUrl';
  }
}