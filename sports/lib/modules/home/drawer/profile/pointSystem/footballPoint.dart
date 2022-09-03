import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:flutter/material.dart';

class FootballPointPage extends StatefulWidget {
  @override
  _FootballPointPageState createState() => _FootballPointPageState();
}

class _FootballPointPageState extends State<FootballPointPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
        child: Center(
          child: Container(
            child:  Image.asset(
              'assets/images/football.webp',
              fit: BoxFit.cover,
            ),
          ),
        ),
    );
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.only(left: 14, right: 14),
    //       child: Card(
    //         child: ExpansionTile(
    //           title: Text(
    //             AppLocalizations.of('Attack'),
    //             style: Theme.of(context).textTheme.caption.copyWith(
    //                   color: Theme.of(context).textTheme.headline6.color,
    //                   letterSpacing: 0.6,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //           ),
    //           children: [
    //             row(
    //               AppLocalizations.of('Goal'),
    //               "+30",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Assist'),
    //               "+15",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.7),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Shot on target (Includes Goals)'),
    //               "+10",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Chance Created'),
    //               "+6",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.7),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('5 Passes Completed'),
    //               "+1",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 14, right: 14),
    //       child: Card(
    //         child: ExpansionTile(
    //           title: Text(
    //             AppLocalizations.of('Defense'),
    //             style: Theme.of(context).textTheme.caption.copyWith(
    //                   color: Theme.of(context).textTheme.headline6.color,
    //                   letterSpacing: 0.6,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //           ),
    //           children: [
    //             row(
    //               AppLocalizations.of('Tackle Won'),
    //               "+4",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Interception Won'),
    //               "+4",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.7),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Blocked Shot'),
    //               "+4",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Clearance'),
    //               "+2",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.7),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Saves'),
    //               "+8",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Penalty Saved'),
    //               "+30",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.7),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Clean Sheet'),
    //               "+20",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 14, right: 14),
    //       child: Card(
    //         child: ExpansionTile(
    //           title: Text(
    //             AppLocalizations.of('Other Points'),
    //             style: Theme.of(context).textTheme.caption.copyWith(
    //                   color: Theme.of(context).textTheme.headline6.color,
    //                   letterSpacing: 0.6,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //           ),
    //           children: [
    //             row(
    //               AppLocalizations.of('Captain'),
    //               "2x",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Vice-Captain'),
    //               "1.5x",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.7),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('In Starting'),
    //               "+4",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Coming on as a Substitute'),
    //               "+2",
    //               Colors.green[300],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.7),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(left: 14, right: 14),
    //       child: Card(
    //         child: ExpansionTile(
    //           title: Text(
    //             AppLocalizations.of('Cards And Other Penalties'),
    //             style: Theme.of(context).textTheme.caption.copyWith(
    //                   color: Theme.of(context).textTheme.headline6.color,
    //                   letterSpacing: 0.6,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //           ),
    //           children: [
    //             row(
    //               AppLocalizations.of('Yellow card'),
    //               "-2",
    //               Colors.red[100],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Red card'),
    //               "-6",
    //               Colors.red[100],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.7),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Own goal'),
    //               "-6",
    //               Colors.red[100],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Goals conceded'),
    //               "-4",
    //               Colors.red[100],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.7),
    //             ),
    //             SizedBox(
    //               height: 1,
    //             ),
    //             row(
    //               AppLocalizations.of('Penalty missed'),
    //               "-8",
    //               Colors.red[100],
    //               Theme.of(context).appBarTheme.color.withOpacity(0.2),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Container(
    //       height: 40,
    //       color: Theme.of(context).appBarTheme.color,
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 20, right: 20),
    //         child: Row(
    //           children: [
    //             Text(
    //               AppLocalizations.of('Other Important Points'),
    //               style: Theme.of(context).textTheme.caption.copyWith(
    //                     color: Theme.of(context).textTheme.headline6.color,
    //                     letterSpacing: 0.6,
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 14,
    //                   ),
    //             ),
    //             Expanded(child: SizedBox()),
    //             Icon(
    //               Icons.keyboard_arrow_down,
    //               color: Theme.of(context).textTheme.headline6.color,
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     SizedBox(
    //       height: 20,
    //     ),
    //   ],
    // );
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
