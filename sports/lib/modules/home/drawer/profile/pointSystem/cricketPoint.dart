import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:flutter/material.dart';

import '../../../../../constance/constance.dart';

class CricketPointPage extends StatefulWidget {
  @override
  _CricketPointPageState createState() => _CricketPointPageState();
}

class _CricketPointPageState extends State<CricketPointPage> {
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
                AppLocalizations.of('Basic Points'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      letterSpacing: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              children: [
                for(int i=0;i<ConstanceData.listOne.length;i++)
                  row(
                    AppLocalizations.of('${ConstanceData.listOne[i].action}'),
                    "${ConstanceData.listOne[i].t10}",
                    ConstanceData.listOne[i].t10.toString().contains('-')? Colors.red[100]:Colors.green[300],
                    Theme.of(context).appBarTheme.color.withOpacity(0.2),
                  )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Card(
            child: ExpansionTile(
              title: Text(
                AppLocalizations.of('Bonus Points'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      letterSpacing: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              children: [
                for(int i=0;i<ConstanceData.listBonus.length;i++)
                  row(
                    AppLocalizations.of('${ConstanceData.listBonus[i].action}'),
                    "${ConstanceData.listBonus[i].t10}",
                    ConstanceData.listBonus[i].t10.toString().contains('-')? Colors.red[100]:Colors.green[300],
                    Theme.of(context).appBarTheme.color.withOpacity(0.2),
                  )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Card(
            child: ExpansionTile(
              title: Text(
                AppLocalizations.of('Economy Points'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      letterSpacing: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              children: [
                for(int i=0;i<ConstanceData.listEconomy.length;i++)
                row(
                  AppLocalizations.of('${ConstanceData.listEconomy[i].action}'),
                  "${ConstanceData.listEconomy[i].t10}",
                  ConstanceData.listEconomy[i].t10.toString().contains('-')? Colors.red[100]:Colors.green[300],
                  Theme.of(context).appBarTheme.color.withOpacity(0.2),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Card(
            child: ExpansionTile(
              title: Text(
                AppLocalizations.of('Strike Points'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      letterSpacing: 0.6,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              children: [
                for(int i=0;i<ConstanceData.listStrike.length;i++)
                  row(
                    AppLocalizations.of('${ConstanceData.listStrike[i].action}'),
                    "${ConstanceData.listStrike[i].t10}",
                    ConstanceData.listStrike[i].t10.toString().contains('-')? Colors.red[100]:Colors.green[300],
                    Theme.of(context).appBarTheme.color.withOpacity(0.2),
                  )
              ],
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 14, right: 14),
        //   child: Card(
        //     child: ExpansionTile(
        //       title: Text(
        //         AppLocalizations.of('Economy Rate Points'),
        //         style: Theme.of(context).textTheme.caption.copyWith(
        //               color: Theme.of(context).textTheme.headline6.color,
        //               letterSpacing: 0.6,
        //               fontSize: 16,
        //               fontWeight: FontWeight.bold,
        //             ),
        //       ),
        //       subtitle: Text(
        //         AppLocalizations.of('Min 2 Overs To Be Bowled'),
        //         style: Theme.of(context).textTheme.caption.copyWith(
        //               color: Theme.of(context).textTheme.bodyText2.color,
        //               letterSpacing: 0.6,
        //               fontSize: 12,
        //             ),
        //       ),
        //       children: [
        //         row(
        //           AppLocalizations.of('Below 4 runs per over'),
        //           "+6",
        //           Colors.green[300],
        //           Theme.of(context).appBarTheme.color.withOpacity(0.2),
        //         ),
        //         SizedBox(
        //           height: 1,
        //         ),
        //         row(
        //           AppLocalizations.of('Between 4-4.99 runs per over'),
        //           "+4",
        //           Colors.green[300],
        //           Theme.of(context).appBarTheme.color.withOpacity(0.7),
        //         ),
        //         SizedBox(
        //           height: 1,
        //         ),
        //         row(
        //           AppLocalizations.of('Between 5-6 runs per over'),
        //           "+2",
        //           Colors.green[300],
        //           Theme.of(context).appBarTheme.color.withOpacity(0.2),
        //         ),
        //         SizedBox(
        //           height: 1,
        //         ),
        //         row(
        //           AppLocalizations.of('Between 9-10 runs per over'),
        //           "-2",
        //           Colors.red[100],
        //           Theme.of(context).appBarTheme.color.withOpacity(0.7),
        //         ),
        //         SizedBox(
        //           height: 1,
        //         ),
        //         row(
        //           AppLocalizations.of('Between 10.01-11 runs per over'),
        //           "-4",
        //           Colors.red[100],
        //           Theme.of(context).appBarTheme.color.withOpacity(0.2),
        //         ),
        //         SizedBox(
        //           height: 1,
        //         ),
        //         row(
        //           AppLocalizations.of('Above 11 runs per over'),
        //           "-6",
        //           Colors.red[100],
        //           Theme.of(context).appBarTheme.color.withOpacity(0.7),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 14, right: 14),
        //   child: Card(
        //     child: ExpansionTile(
        //       title: Text(
        //         AppLocalizations.of('Strike Rate (Except Bowler) Points'),
        //         style: Theme.of(context).textTheme.caption.copyWith(
        //               color: Theme.of(context).textTheme.headline6.color,
        //               letterSpacing: 0.6,
        //               fontSize: 16,
        //               fontWeight: FontWeight.bold,
        //             ),
        //       ),
        //       subtitle: Text(
        //         AppLocalizations.of('Min 10 Balls To Be Played'),
        //         style: Theme.of(context).textTheme.caption.copyWith(
        //               color: Theme.of(context).textTheme.bodyText2.color,
        //               letterSpacing: 0.6,
        //               fontSize: 12,
        //             ),
        //       ),
        //       children: [
        //         row(
        //           AppLocalizations.of('Between 60-70 runs per 100 balls'),
        //           "-2",
        //           Colors.red[100],
        //           Theme.of(context).appBarTheme.color.withOpacity(0.2),
        //         ),
        //         SizedBox(
        //           height: 1,
        //         ),
        //         row(
        //           AppLocalizations.of('Between 50-59.99 runs per 100 balls'),
        //           "-4",
        //           Colors.red[100],
        //           Theme.of(context).appBarTheme.color.withOpacity(0.7),
        //         ),
        //         SizedBox(
        //           height: 1,
        //         ),
        //         row(
        //           AppLocalizations.of('Below 50 runs per 100 balls'),
        //           "-6",
        //           Colors.red[100],
        //           Theme.of(context).appBarTheme.color.withOpacity(0.2),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Container(
        //   height: 40,
        //   color: Theme.of(context).appBarTheme.color,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 20, right: 20),
        //     child: Row(
        //       children: [
        //         Text(
        //           AppLocalizations.of('Other Important Points'),
        //           style: Theme.of(context).textTheme.caption.copyWith(
        //                 color: Theme.of(context).textTheme.headline6.color,
        //                 letterSpacing: 0.6,
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 14,
        //               ),
        //         ),
        //         Expanded(child: SizedBox()),
        //         Icon(
        //           Icons.keyboard_arrow_down,
        //           color: Theme.of(context).textTheme.headline6.color,
        //         )
        //       ],
        //     ),
        //   ),
        // ),
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
            SizedBox(
              width: 200,
              child: Text(
                txt1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      letterSpacing: 0.6,
                      fontSize: 14,
                    ),
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
