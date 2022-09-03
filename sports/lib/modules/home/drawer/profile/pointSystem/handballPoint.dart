import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:flutter/material.dart';

class HandballPointPage extends StatefulWidget {
  @override
  _HandballPointPageState createState() => _HandballPointPageState();
}

class _HandballPointPageState extends State<HandballPointPage> {
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
                AppLocalizations.of('Attack'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      letterSpacing: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              children: [
                row(
                  AppLocalizations.of('Goal'),
                  "6",
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
                  AppLocalizations.of('Save (GK only)'),
                  "2",
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Penalty Saved (GK only)'),
                  "3",
                  Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.7),
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
                AppLocalizations.of('Cards And Other Penalties'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      letterSpacing: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              children: [
                row(
                  AppLocalizations.of('Yellow card'),
                  "-1",
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Ejections'),
                  "-2",
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.7),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Red Card'),
                  "-3",
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                ),
                SizedBox(
                  height: 1,
                ),
                row(
                  AppLocalizations.of('Penalty Miss'),
                  "-2",
                  Colors.red[100],
                  Theme.of(context).appBarTheme.color.withOpacity(0.7),
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
