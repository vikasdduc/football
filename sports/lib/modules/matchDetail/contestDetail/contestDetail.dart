import 'dart:io';

import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/modules/home/contests/Join/Select_Team.dart';
import 'package:fantacySports/modules/matchDetail/contestDetail/addCash.dart';
import 'package:fantacySports/modules/matchDetail/contestDetail/detail.dart';
import 'package:fantacySports/modules/matchDetail/contestDetail/leaderboard.dart';
import 'package:fantacySports/widget/customButton.dart';
import 'package:fantacySports/widget/matchDetailCardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Model/ContestJoined.dart';
import '../../../Networking/AccessNetwork.dart';
import '../../home/contests/Admin Contests/addPlayers_admin.dart';
import '../../home/contests/Admin Contests/addToWallet_admin.dart';

class ContestDetailPage extends StatefulWidget {
  final time,
      title,
      data,
      list,
      index,
      isLive,
      teams,
      percent,
      isMega,
      first_price;

  ContestDetailPage(
      {Key key,
      this.time,
      this.title,
      this.data,
      this.list,
      this.index,
      this.isLive,
      this.teams,
      this.percent,
      this.isMega,
      this.first_price})
      : super(key: key);

  @override
  _ContestDetailPageState createState() => _ContestDetailPageState();
}

class _ContestDetailPageState extends State<ContestDetailPage> {
  bool isleaderboard = false;
  bool isContest = true;
  var couponName = '';

  @override
  void initState() {
    super.initState();
    print('QWERT ${widget.list[widget.index].match_id}');
  }

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
          !isAlreadyJoined()
              ? MatchDetailCardView(
                  txt1: AppLocalizations.of(
                      '₹${getPrizeName(widget.data.prize.toString())}'),
                  txt2: "₹${widget.data.entry}",
                  txt3: AppLocalizations.of('${widget.data.spots_left}'),
                  txt4: AppLocalizations.of('${widget.data.spots}'),
                  data: widget.data,
                  isClickable: false,
                  isLive: widget.isLive,
                  percent: widget.percent,
                  isMega: widget.isMega,
                  first_price: widget.first_price,
                )
              : Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 5),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of('Prize Pool'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      letterSpacing: 0.6,
                                      fontSize: 10,
                                    ),
                              ),
                              Expanded(child: SizedBox()),
                              Text(
                                AppLocalizations.of(''),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      letterSpacing: 0.6,
                                      fontSize: 10,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(
                                    '₹${getPrizeName(widget.data.prize.toString())}'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                      letterSpacing: 0.6,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        LinearPercentIndicator(
                          percent: int.parse(AppLocalizations.of(
                                  '${widget.data.spots_left}')) /
                              int.parse(
                                  AppLocalizations.of('${widget.data.spots}')) /
                              100,
                          progressColor: Color(0xffff6061),
                          backgroundColor: Colors.grey.shade400,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${AppLocalizations.of('${widget.data.spots_left}')}  sports left',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Color(0xffD30001),
                                      letterSpacing: 0.6,
                                      fontSize: 10,
                                    ),
                              ),
                              Expanded(child: SizedBox()),
                              Text(
                                '${AppLocalizations.of('${widget.data.spots}')}   spots',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.black54,
                                      letterSpacing: 0.6,
                                      fontSize: 10,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .disabledColor
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(''),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 10,
                                      ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  "${calculate().floor()}%",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 10,
                                      ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  AppLocalizations.of(
                                      '${widget.data.content_type}'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                        letterSpacing: 0.6,
                                        fontSize: 10,
                                      ),
                                ),
                                Expanded(child: SizedBox()),
                                Icon(
                                  Icons.check_circle_outline,
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          Container(
            height: 40,
            color: Theme.of(context).appBarTheme.color,
            child: tabBar(),
          ),
          Expanded(
            child: Container(
              color: Colors.black,
              child: isContest == true
                  ? DetailPage(
                      isLive: widget.isLive,
                      cont: widget.data,
                    )
                  : isleaderboard == true
                      ? LeaderboardPage(
                          widget.list[widget.index].match_id.toString(),
                          widget.data.id.toString(),
                          widget.isLive)
                      : SizedBox(),
            ),
          ),
          !isAlreadyJoined()
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                            Expanded(
                              child: Material(
                                child: InkWell(
                                  splashColor: Colors.grey.shade800,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  onTap: () {
                                    _displayTextInputDialog(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    color: Colors.green,
                                    child: Center(
                                      child: Text(
                                        'Apply Coupon',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
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
                            Expanded(
                              child: Material(
                                child: InkWell(
                                  splashColor: Colors.grey.shade800,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  onTap: () {
                                    ConstanceData.contest_joined_bill =
                                        contest_joined(
                                            widget.data.entry.toString(),
                                            '-${widget.data.entry.toString()}',
                                            '0');
                                    if (widget.teams == null ||
                                        widget.teams.length <= 0) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddPlayersAdmin(
                                                    widget.list,
                                                    widget.index,
                                                    widget.data.id,
                                                    widget.time,
                                                    widget.list[widget.index]
                                                        .Competition.cid,
                                                    widget.teams,
                                                    widget.list[widget.index]
                                                        .match_id,
                                                    couponName,
                                                    widget.data),
                                          ));
                                    } else {
                                      ConstanceData.contest_joined_bill =
                                          contest_joined(
                                              widget.data.entry.toString(),
                                              '-${widget.data.entry.toString()}',
                                              '0');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => select_team(
                                              widget.list[widget.index],
                                              widget.teams,
                                              widget.data.id,
                                              couponName,
                                              widget.data,
                                              widget.index,
                                              widget.time,
                                              widget.list[widget.index]
                                                  .Competition.cid,
                                              widget.list[widget.index]
                                                  .match_id,
                                            ),
                                          ));
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    color: Colors.green,
                                    child: Center(
                                      child: Text(
                                        'Join Contest',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
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
                    ),
                  ],
                )
              : widget.data.contest_code != null &&
                      widget.data.contest_code != ''
                  ? SizedBox(
                      width: 5,
                    )
                  : Container(),
          widget.data.contest_code != null && widget.data.contest_code != ''
              ? Container(
                  height: 40,
                  child: Expanded(
                    child: Material(
                      child: InkWell(
                        splashColor: Colors.grey.shade800,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        onTap: () {
                          print(widget.data.contest_code);
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
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          var _couponcontroller = TextEditingController();
          var coupon = '';
          return AlertDialog(
            title: Text('Enter the coupon code'),
            content: Container(
              height: 200,
              color: Colors.white,
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of('Have a Coupon Code?'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.headline6.color,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 40,
                    width: 350,
                    child: Center(
                      child: TextField(
                        onChanged: (txt) {
                          setState(() {
                            coupon = txt == null ? '' : txt;
                          });
                        },
                        controller: _couponcontroller,
                        cursorColor: Colors.black,
                        decoration: new InputDecoration(
                          hintText: 'Enter Coupon Code',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(
                                color:
                                    Theme.of(context).textTheme.bodyText2.color,
                                letterSpacing: 0.6,
                                fontSize: 16,
                              ),
                          enabledBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                            color: Theme.of(context).textTheme.bodyText2.color,
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)),
                        ),
                        keyboardType: TextInputType.name,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Material(
                    child: InkWell(
                      onTap: () {
                        if (_couponcontroller.text.length > 0) {
                          var txt = _couponcontroller.text;
                          access_network()
                              .apply_coupon(
                                  _couponcontroller.text,
                                  widget.data.entry.toString(),
                                  ConstanceData.prof.id.toString())
                              .then((_) {
                            if (_['message'] == 'Final Amount') {
                              Fluttertoast.showToast(
                                  msg: "Cupon applied successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context, txt);
                            } else {
                              _couponcontroller.text = '';
                              Fluttertoast.showToast(
                                  msg: "${_['message']}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          });
                        } else {}
                      },
                      child: Container(
                        height: 40,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'APPLY CODE',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.grey.shade900,
                                  letterSpacing: 0.6,
                                  fontSize: 14,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).then((value) {
      print(value);
      couponName = value == null ? '' : value;
    });
  }

  double calculate() {
    return widget.data.spots_left /
        int.parse(widget.data.spots.toString()) *
        100;
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
              isContest = true;
              isleaderboard = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 50),
            child: Text(
              AppLocalizations.of('Winnings'),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: isContest == true
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
              isContest = false;
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

  getFee() {
    var amount = int.parse(widget.data.entry.toString()) -
        int.parse(ConstanceData.prof.balance.toString());
    if (amount >= 0) {
      return amount;
    } else {
      return int.parse(widget.data.entry.toString()).toString();
    }
  }

  isAlreadyJoined() {
    for (var i in ConstanceData.specific_contests) {
      if (i.id == widget.data.id) {
        return true;
      }
    }
    return false;
  }

  getPrizeName(prize) {
    if (int.parse(prize.toString()) >= 100000 &&
        int.parse(prize.toString()) < 10000000) {
      String txt = prize.toString().split('')[0].toString();
      txt = txt + ' Lakh';
      return txt;
    } else if (int.parse(prize.toString()) > 10000000) {
      String txt = prize.toString().split('')[0].toString();
      txt = txt + ' Crore';
      return txt;
    } else {
      return '${prize}';
    }
  }
}
