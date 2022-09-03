import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:flutter/material.dart';

class BaseballPointPage extends StatefulWidget {
  @override
  _BaseballPointPageState createState() => _BaseballPointPageState();
}

class _BaseballPointPageState extends State<BaseballPointPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Card(
            child: ExpansionTile(
              title: Text(
                AppLocalizations.of('Batting'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      letterSpacing: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              children: [
                row(
                  AppLocalizations.of('Single (1B)'),
                  "4",
                  AppLocalizations.of('Batter reaches first base'),
                  Colors.green[300],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Double (2B)'),
                  "6",
                  AppLocalizations.of('Batter reaches second base'),
                  Colors.green[300],
                  Colors.white,
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Triple (3B)'),
                  "10",
                  AppLocalizations.of('Batter reaches second base'),
                  Colors.green[300],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Home Run (HR)'),
                  "12",
                  AppLocalizations.of(
                      'Batter hits it out of the park or reaches\nback to home base'),
                  Colors.green[300],
                  Colors.white,
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Runes Batted In (RBI)'),
                  "3",
                  AppLocalizations.of(
                      'Batter on strike caused one or more\nruns to be scored'),
                  Colors.green[300],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Run Scored(R)'),
                  "3",
                  AppLocalizations.of(
                      'Player crosses home base to score a\nrun.'),
                  Colors.red[100],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Base on Balls (BBH) or Walk'),
                  "4",
                  AppLocalizations.of('Deliver to the same better'),
                  Colors.red[100],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Stolen Base (SB)'),
                  "8",
                  AppLocalizations.of(
                      'Runner advances to next base while\npitcher is pitching'),
                  Colors.red[100],
                  Color(0xffFAFAFA),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Card(
            child: ExpansionTile(
              title: Text(
                AppLocalizations.of('Pitching'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      letterSpacing: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              children: [
                row(
                  AppLocalizations.of('Inning Pitched(IP)'),
                  "3",
                  AppLocalizations.of(
                      'The pitcher gets 3 batters outs.The\npitcher gets 1 point per out.'),
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Strikeout(SO)'),
                  "2",
                  AppLocalizations.of(
                      'The pitcher throws three strikes to get\na batter out'),
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.7),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Earned Run(ER)'),
                  "-3",
                  AppLocalizations.of('Run conceded by the pitcher'),
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Hit Allowed(H)'),
                  "-1",
                  AppLocalizations.of(
                      'When a batter reaches 1st ,2nd or 3rd\nbase'),
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.7),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Base on Balls(BBP) or Walk'),
                  "3",
                  AppLocalizations.of(
                      "A walk occurs when a pitcher throws 4\n'balls' or illegal deliveries to the same\nbatter"),
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          color: Theme.of(context).appBarTheme.color,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of('Other Important Points'),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).textTheme.headline6.color,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                ),
                Expanded(child: SizedBox()),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Theme.of(context).textTheme.headline6.color,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget row(String txt1, String txt2, String txt3, Color color,
      Color containerColor) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: containerColor,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 14, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        txt1,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              letterSpacing: 0.6,
                              fontSize: 14,
                            ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        txt3,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: Colors.black38,
                              letterSpacing: 0.6,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    height: 50,
                    width: 30,
                    color: color,
                    child: Center(
                      child: Text(
                        txt2,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              letterSpacing: 0.6,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
