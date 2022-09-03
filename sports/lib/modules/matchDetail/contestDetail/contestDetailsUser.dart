import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Language/appLocalizations.dart';
import '../../../constance/constance.dart';
import '../../../widget/matchDetailCardView.dart';
import '../../home/contests/Admin Contests/addToWallet_admin.dart';
import 'addCash.dart';
import 'detail.dart';
import 'leaderboard.dart';
import 'matchDetailsCardUser.dart';

class ContestDetailsUser extends StatefulWidget {
  final time, title, data, list, index;

  ContestDetailsUser(this.time, this.title, this.data, this.list, this.index);

  @override
  State<ContestDetailsUser> createState() => _ContestDetailsUserState();
}

class _ContestDetailsUserState extends State<ContestDetailsUser> {
  bool isleaderboard = false;
  bool isPrizes = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.grey.shade900,
          ),
          Container(
            height: AppBar().preferredSize.height,
            color: Colors.grey.shade900,
            child: appBar(),
          ),
          MatchDetailCardUser(
            txt1: AppLocalizations.of('₹${widget.data.prize}'),
            txt2: "₹${widget.data.entry}",
            txt3: AppLocalizations.of('${widget.data.spots_left} sports left'),
            txt4: AppLocalizations.of('${widget.data.spots} spots'),
            data: widget.data,
            isClickable: false,
          ),
          Container(
            height: 40,
            color: Theme.of(context).appBarTheme.color,
            child: tabBar(),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: isPrizes == true
                  ? DetailPage(
                      cont: widget.data,
                    )
                  : isleaderboard == true
                      ? LeaderboardPage(
                          widget.list[widget.index].match_id.toString(),
                          widget.data.id.toString(),
                          true)
                      : SizedBox(),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: 15,
                bottom: 15,
                right: 10,
                left: 10,
              ),
              child: Row(
                children: [
                  widget.data.contest_code != null &&
                          widget.data.contest_code != ''
                      ? SizedBox(
                          width: 5,
                        )
                      : Container(),
                  widget.data.contest_code != null &&
                          widget.data.contest_code != ''
                      ? Expanded(
                          child: Material(
                            child: InkWell(
                              splashColor: Colors.grey.shade800,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              onTap: () {
                                url('Hi there I am using this awsome fantasy app Apna team. Copy this code and join me in a match. Code: ${widget.data.contest_code}');
                              },
                              child: Container(
                                height: 40,
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    'Share Contest',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget tabBar() {
    return Row(
      children: [
        SizedBox(
          height: 6,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isPrizes = true;
              isleaderboard = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 50),
            child: Text(
              AppLocalizations.of('Winnings'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isPrizes == true
                        ? Theme.of(context).textTheme.headline6.color
                        : Colors.black38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    fontSize: 14,
                  ),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        SizedBox(
          height: 6,
        ),
        InkWell(
          onTap: () {
            setState(() {
              isPrizes = false;
              isleaderboard = true;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 50),
            child: Text(
              AppLocalizations.of('Leaderboard'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isleaderboard == true
                        ? Theme.of(context).textTheme.headline6.color
                        : Colors.black38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    fontSize: 14,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 270,
                  child: Text(
                    AppLocalizations.of('${widget.title}'),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                ),
                CountdownTimer(
                  endTime: widget.time,
                  textStyle: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.white,
                        letterSpacing: 0.6,
                        fontSize: 14,
                      ),
                  endWidget: Text(
                    'Live',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff0ebd01),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Text(
                //   AppLocalizations.of('48m 39s left'),
                //   style: Theme.of(context).textTheme.caption.copyWith(
                //         color: Colors.white,
                //         letterSpacing: 0.6,
                //         fontSize: 14,
                //       ),
                // ),
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                isDismissible: false,
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                AppLocalizations.of('Total Balance'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.black54,
                                      letterSpacing: 0.6,
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                "₹${ConstanceData.prof.balance == null ? 0 : ConstanceData.prof.balance}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                      letterSpacing: 0.6,
                                      fontSize: 14,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddCashPage(),
                                  ),
                                );
                              },
                              child: Center(
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Color(0xff317E2F),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of('Add cash'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Colors.white,
                                            letterSpacing: 0.6,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              indent: 14,
                              endIndent: 14,
                            ),
                            row(AppLocalizations.of('Amount Added'), "₹0"),
                            row(AppLocalizations.of('Winnings'), "₹31"),
                            row(AppLocalizations.of('Cash Bonus'), "₹0"),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black12,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(
              FontAwesomeIcons.wallet,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget row(String txt1, String txt2) {
    return Column(
      children: [
        Container(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
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
                            color: Colors.black45,
                            letterSpacing: 0.6,
                            fontSize: 12,
                          ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      txt2,
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Colors.black87,
                            letterSpacing: 0.6,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Icon(
                  Icons.error_outline,
                  color: Colors.blue,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        Divider(
          indent: 14,
          endIndent: 14,
        ),
      ],
    );
  }

  url(message) async {
    await launch('https://api.whatsapp.com/send?text=' + message,
        forceSafariVC: false);
  }
}
