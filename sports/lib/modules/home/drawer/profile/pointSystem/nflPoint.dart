import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:flutter/material.dart';

class NFLPointPage extends StatefulWidget {
  @override
  _NFLPointPageState createState() => _NFLPointPageState();
}

class _NFLPointPageState extends State<NFLPointPage> {
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
                AppLocalizations.of('Offense'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      letterSpacing: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              children: [
                row(
                  AppLocalizations.of('Rushing TD'),
                  "8",
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Receiving TD'),
                  "6",
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.7),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Passing TD'),
                  "4",
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('10 Rushing Yards'),
                  "1",
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.7),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('10 Receiving Yards'),
                  "1",
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('25 Passing Yards'),
                  "1",
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.7),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('100+ Rushing Yards Bonus'),
                  "3",
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('100+ Receiving Yards Bonus'),
                  "3",
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.7),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('300+ Passing Yards Bonus'),
                  "3",
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Reception'),
                  "1",
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.7),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Fumble Lost'),
                  "-1",
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Interception'),
                  "-1",
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.7),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('2 Pt Conversion'),
                  "2",
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
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
                AppLocalizations.of('Defense'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      letterSpacing: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              children: [
                row(
                  AppLocalizations.of('Tackle'),
                  "1",
                  Colors.green[300],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Assisted Tackle'),
                  "1",
                  Colors.green[300],
                  Colors.white,
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('5+ Tackle Bonus'),
                  "3",
                  Colors.green[300],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Pass Defended'),
                  "2",
                  Colors.green[300],
                  Colors.white,
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Sack'),
                  "6",
                  Colors.green[300],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Forced Fumble'),
                  "3",
                  Colors.green[300],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Forced Recovery'),
                  "6",
                  Colors.green[300],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Interception'),
                  "6",
                  Colors.green[300],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Safety'),
                  "6",
                  Colors.green[300],
                  Color(0xffFAFAFA),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Return TD'),
                  "6",
                  Colors.green[300],
                  Color(0xffFAFAFA),
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

  Widget row(String txt1, String txt2, Color color, Color containerColor) {
    return Container(
      color: containerColor,
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: Row(
          children: [
            Text(
              txt1,
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Theme.of(context).textTheme.headline6.color,
                    letterSpacing: 0.6,
                    fontSize: 14,
                  ),
            ),
            Expanded(child: SizedBox()),
            Container(
              height: 30,
              width: 30,
              color: color,
              child: Center(
                child: Text(
                  txt2,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).textTheme.headline6.color,
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
    );
  }
}
