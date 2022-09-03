import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/modules/navigationBar/myMatches/completed.dart';
import 'package:fantacySports/modules/navigationBar/myMatches/live.dart';
import 'package:fantacySports/modules/navigationBar/myMatches/upcoming.dart';
import 'package:flutter/material.dart';

class Matches extends StatefulWidget {
  const Matches({Key key}) : super(key: key);

  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  bool isUpcoming = true;
  bool isLive = false;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).appBarTheme.color,
          height: AppBar().preferredSize.height,
          child: tabBar(),
        ),
        isUpcoming
            ? UpComingPage()
            : isLive
                ? LivePage(() {
          if (mounted) {
            setState(() {
                        isUpcoming = true;
                        isLive = false;
                        isCompleted = false;
                      });
          } else {
            isUpcoming = true;
            isLive = false;
            isCompleted = false;
          }
        })
                : isCompleted
                    ? CompletedPage(() {
          if (mounted) {
            setState(() {
              isUpcoming = true;
              isLive = false;
              isCompleted = false;
            });
          } else {
            isUpcoming = true;
            isLive = false;
            isCompleted = false;
          }
        })
                    : SizedBox(),
      ],
    );
  }

  Widget tabBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isUpcoming = true;
                isLive = false;
                isCompleted = false;
              });
            },
            child: Text(
              AppLocalizations.of('Upcoming'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isUpcoming == true
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    letterSpacing: 0.6,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(child: SizedBox()),
          InkWell(
            onTap: () {
              setState(() {
                isUpcoming = false;
                isLive = true;
                isCompleted = false;
              });
            },
            child: Text(
              AppLocalizations.of('Live'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isLive == true
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    letterSpacing: 0.6,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(child: SizedBox()),
          InkWell(
            onTap: () {
              setState(() {
                isUpcoming = false;
                isLive = false;
                isCompleted = true;
              });
            },
            child: Text(
              AppLocalizations.of('Completed'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isCompleted == true
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                    letterSpacing: 0.6,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
