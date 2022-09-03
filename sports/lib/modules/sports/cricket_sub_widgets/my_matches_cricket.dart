import 'package:fantacySports/Model/GetTeam.dart';
import 'package:fantacySports/Model/contest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import '../../../Language/appLocalizations.dart';
import '../../../Model/Matche.dart';
import '../../../constance/constance.dart';
import '../../../widget/myContestCard.dart';
import '../../createTeam/createTeam.dart';
import '../../matchDetail/matchDetailPage.dart';

class MyMatchesCricket extends StatefulWidget {
  List<match> myLiveMatchList;

  MyMatchesCricket(this.myLiveMatchList);

  @override
  State<MyMatchesCricket> createState() => _MyMatchesCricketState();
}

class _MyMatchesCricketState extends State<MyMatchesCricket> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: [
            Container(
              height: 150,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ConstanceData.messyPic,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of('My Matches'),
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                            fontSize: 18,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding:
              const EdgeInsets.only(top: 30, left: 5, right: 5),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.myLiveMatchList.length,
                itemBuilder: (cont, index) {
                  match data = widget.myLiveMatchList[index];
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
                  return SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 10,
                    child: MyContestCard(
                      txt1: AppLocalizations.of(
                          '${data.Competition.title}'),
                      txt2:
                      AppLocalizations.of('${data.teama.name}'),
                      txt3:
                      AppLocalizations.of('${data.teamb.name}'),
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
                        endTime: DateTime(year, month, day,
                            hour, mint, sec)
                            .millisecondsSinceEpoch,
                        endWidget: Text(
                          'Live',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff0ebd01),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        widgetBuilder:
                            (_, CurrentRemainingTime time) {
                          // print(time);
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
                        errorBuilder: (cont, s, d) =>
                            Center(
                              child: Icon(
                                Icons.image,
                              ),
                            ),
                      ),
                      image2: Image.network(
                        data.teamb.logo_url,
                        fit: BoxFit.cover,
                        errorBuilder: (cont, s, d) =>
                            Center(
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
                            builder: (context) =>
                                MatchDetailPage(
                                  widget.myLiveMatchList,
                                  ConstanceData.matchLiveIndex,
                                  constance.CompetitionType.upcoming,
                                  DateTime(year, month, day, hour,
                                      mint, sec),
                                ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        )
    );
  }

  List<GetTeam> filterContent(List<GetTeam> mylist, competition_id, match_id) {
    print('s ${mylist.length} ${match_id}');
    List<GetTeam> list = new List<GetTeam>();
    for (var i in mylist) {
      if (i.competition_id.toString() == competition_id.toString() &&
          i.match_id.toString() == match_id.toString()) {
        list.add(i);
        print(i.match_id);
      } else {}
    }
    return list;
  }

  List<Contest> filterContest(List<Contest> mylist) {
    List<Contest> list = new List<Contest>();
    try {
      for (var i in mylist) {
        if (i.user_id.toString() == ConstanceData.prof.id.toString()) {
          list.add(i);
        } else {}
      }
    } catch (e) {
      print(e);
    }
    return list;
  }
}
