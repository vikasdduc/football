import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/GetTeam.dart';
import 'package:fantacySports/Model/Matche.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/constance/themes.dart';
import 'package:fantacySports/modules/matchDetail/matchDetailPage.dart';
import 'package:fantacySports/widget/cardView.dart';
import 'package:flutter/material.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

import '../../../Model/GetTeam_2.dart';

class LivePage extends StatefulWidget {
  final Function onTap;

  LivePage(this.onTap);

  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  List<match> temporaryList = new List<match>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        // temporaryList = new List<match>();
        // temporaryList =
        //     getList(ConstanceData.mylist, ConstanceData.matchLivelist);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstanceData.matchLivelist == null || ConstanceData.matchLivelist.length <= 0
        ? getEmpty()
        : Container(
            height: MediaQuery.of(context).size.height - 250,
            child: ListView.builder(
                itemCount: ConstanceData.matchLivelist.length,
                shrinkWrap: true,
                itemBuilder: (cont, index) {
                  match data = ConstanceData.matchLivelist[index];
                  int year = int.parse(data.date_start
                      .toString()
                      .split(' ')[0]
                      .toString()
                      .split('-')[0]);
                  int month = int.parse(data.date_start
                      .toString()
                      .split(' ')[0]
                      .toString()
                      .split('-')[1]);
                  int day = int.parse(data.date_start
                      .toString()
                      .split(' ')[0]
                      .toString()
                      .split('-')[2]);
                  int hour = int.parse(data.date_start
                      .toString()
                      .split(' ')[1]
                      .toString()
                      .split(':')[0]);
                  int mint = int.parse(data.date_start
                      .toString()
                      .split(' ')[1]
                      .toString()
                      .split(':')[1]);
                  int sec = int.parse(data.date_start
                      .toString()
                      .split(' ')[1]
                      .toString()
                      .split(':')[2]);

                  return Column(
                    children: [
                      CardView(
                        txt1: AppLocalizations.of('${data.Competition.title}'),
                        txt2: AppLocalizations.of('${data.teama.name}'),
                        txt3: AppLocalizations.of('${data.teamb.name}'),
                        txt4: "${data.teama.short_name}",
                        setTime: data.status_str == 'Completed'
                            ? Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff0ebd01),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : CountdownTimer(
                                endTime: DateTime(year, month, day, hour, mint, sec)
                                    .millisecondsSinceEpoch,
                                endWidget: Text(
                                  'Live',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff0ebd01),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                widgetBuilder: (_, CurrentRemainingTime time) {
                                  if (time == null) {
                                    return Text(
                                      'Live',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff0ebd01),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                  return Text(
                                    '${getTime(time)}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        txt6: "${data.teamb.short_name}",
                        txt7: AppLocalizations.of(
                            '${data.total_teams} Team'),
                        txt8:
                        '${data.total_contest} Contests',
                        image1: Image.network(
                          data.teama.logo_url,
                          fit: BoxFit.cover,
                          errorBuilder: (cont, s, d) => Center(
                            child: Icon(
                              Icons.image,
                            ),
                          ),
                        ),
                        image2: Image.network(
                          data.teamb.logo_url,
                          fit: BoxFit.cover,
                          errorBuilder: (cont, s, d) => Center(
                            child: Icon(
                              Icons.image,
                            ),
                          ),
                        ),
                        onTap: () {
                          ConstanceData.matchLiveIndex = index;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchDetailPage(
                                ConstanceData.matchLivelist,
                                ConstanceData.matchLiveIndex,
                                constance.CompetitionType.live,
                                DateTime(
                                    year, month, day, hour, mint, sec),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                }),
          );
  }

  getEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            AppLocalizations.of("You haven't joined a contest yet!"),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.black54,
                  letterSpacing: 0.6,
                  fontSize: 16,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/images/upcoming.png',
            scale: 3.0,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of('What are you waiting for?'),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.black54,
                  letterSpacing: 0.6,
                  fontSize: 14,
                ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: widget.onTap,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of('View Upcoming Matches'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.white,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getTotalHours(CurrentRemainingTime time) {
    if (time.days != null && time.days > 0) {
      return time.hours + (time.days * 24);
    }
    return time.hours == null ? 0 : time.hours;
  }

  getTime(CurrentRemainingTime time) {
    try {
      if (getTotalHours(time) < 9) {
        if (time.min < 9) {
          if (getTotalHours(time) != 0) {
            return '0${getTotalHours(time) % 24}h : 0${time.min}m';
          } else {
            return ' 0${time.min}m : ${time.sec}s';
          }
        } else {
          if (getTotalHours(time) != 0) {
            return '0${getTotalHours(time)}h : ${time.min}m';
          } else {
            return ' ${time.min}m : ${time.sec}s';
          }
        }
      } else {
        if (time.min < 9) {
          return '${getTotalHours(time)}h : 0${time.min}m';
        } else {
          if (getTotalHours(time)>24) {
            return '${double.parse((getTotalHours(time) / 24).toString()).floor()} days';
          } else {
            if (getTotalHours(time)<=9) {
              return '0${getTotalHours(time)}h : ${time.min}m';
            } else {
              return '${getTotalHours(time)}h : ${time.min}m';
            }
          }
        }
      }
    } catch (e) {
      print(e);
      return 'TBA';
    }
  }

  getLiveist(List<match> matchLivelist) {
    List<match> list = new List<match>();
    for (var i in matchLivelist) {
      // print(' ${i.title} ${i.status}');
      if (i.status == 3) {
        list.add(i);
      }
    }
    return list;
  }

  getList(List<GetTeam> mylist, List<match> matchLivelist) {
    var temporaryList = new List<match>();

    for (var j in matchLivelist) {
      for (var i in mylist) {
        if (i.competition_id.toString() == j.cid.toString() &&
            i.match_id.toString() == j.match_id.toString() &&
            j.status.toString() == '3') {
          temporaryList.add(j);
        }
      }
    }
    return temporaryList.toSet().toList();
  }
}
