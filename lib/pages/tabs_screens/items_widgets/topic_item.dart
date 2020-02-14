import 'package:flutter/material.dart';
import 'package:msp/models/event.dart';
import 'package:msp/ui/app_theme.dart';

class TopicItem extends StatelessWidget {
  final int index;
  final Topic topic;

  const TopicItem(this.topic, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyBlue2.withOpacity(0.03),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${index + 1}. " + topic.title,
            style: AppTheme.title,
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              SizedBox(width: 25),
              Text(
                "• " + topic.sName.toUpperCase(),
                style:AppTheme.subtitle,
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            children: <Widget>[
              SizedBox(width: 36),
              Flexible(
                child: Text(
                  topic.sJob,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color:AppTheme.nearlyBlack.withOpacity(0.6)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
