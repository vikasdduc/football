import 'package:carousel_pro/carousel_pro.dart';
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/modules/home/soccer/soccer_match_details.dart';
import 'package:fantacySports/widget/cardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../Model/Soccer/soccer_competition.dart';
import '../../Model/Soccer/soccer_match.dart';
import '../../constance/constance.dart';
import '../createTeam/createTeam.dart';
import 'package:fantacySports/modules/sports/cricket_sub_widgets/BannerSlider.dart';

class FootballPage extends StatefulWidget {
  @override
  _FootballPageState createState() => _FootballPageState();
}

class _FootballPageState extends State<FootballPage> {
  List<SoccerCompetition> competition = [];
  List<SoccerMatch> matches = [];

  @override
  void initState() {
    super.initState();
    fetchCompetition();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: matches.isEmpty
          ? Center(
              child: Container(
                child: Image.asset(
                  'assets/images/football.webp',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 180,
                      child: Swiper(
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) =>
                            Carousel(
                          boxFit: BoxFit.cover,
                          images: [
                            Image.asset(
                              ConstanceData.fslider1,
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              ConstanceData.fslider2,
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              ConstanceData.fslider3,
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              ConstanceData.fslider4,
                              fit: BoxFit.cover,
                            ),
                          ],
                          dotSize: 4.0,
                          dotSpacing: 15.0,
                          indicatorBgPadding: 5.0,
                          dotBgColor: Colors.transparent,
                          borderRadius: true,
                        ),
                        autoplay: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: BannerSlider(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 15),
                      child: Text(
                        AppLocalizations.of('Upcoming Matches'),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.6,
                              fontSize: 18,
                            ),
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: matches.length,
                        itemBuilder: (cont, count) {
                          var data = matches[count];
                          int year = int.parse(data.datestart
                              .toString()
                              .split(' ')[0]
                              .toString()
                              .split('-')[0]);
                          int month = int.parse(data.datestart
                              .toString()
                              .split(' ')[0]
                              .toString()
                              .split('-')[1]);
                          int day = int.parse(data.datestart
                              .toString()
                              .split(' ')[0]
                              .toString()
                              .split('-')[2]);
                          int hour = int.parse(data.datestart
                              .toString()
                              .split(' ')[1]
                              .toString()
                              .split(':')[0]);
                          int mint = int.parse(data.datestart
                              .toString()
                              .split(' ')[1]
                              .toString()
                              .split(':')[1]);
                          int sec = int.parse(data.datestart
                              .toString()
                              .split(' ')[1]
                              .toString()
                              .split(':')[2]);
                          return CardView(
                            txt1: AppLocalizations.of(data.competition.cname),
                            txt2:
                                AppLocalizations.of(data.teams.home.fullname),
                            txt3: data.teams.away.fullname,
                            txt4: data.teams.home.abbr,
                            setTime: CountdownTimer(
                              endTime:
                                  DateTime(year, month, day, hour, mint, sec)
                                      .millisecondsSinceEpoch,
                              endWidget: Text(
                                '00m:00s',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff0ebd01),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              widgetBuilder: (_, CurrentRemainingTime time) {
                                // print(time);
                                if (time == null) {
                                  return Text(
                                    'Completed',
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
                            txt6: data.teams.away.abbr,
                            txt7: AppLocalizations.of('₹51 Lakhs'),
                            image1: Image.network(
                              data.teams.home.logo,
                              fit: BoxFit.cover,
                            ),
                            image2: Image.network(
                              data.teams.away.logo,
                              fit: BoxFit.cover,
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return SoccerMatchDetails(
                                          data,
                                          DateTime(
                                              year, month, day, hour, mint, sec),
                                          matches,
                                          count);
                                    }),
                              );
                            },

                          );
                        }),
                  ],
                )
              ],
            ),
    );
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
          if (getTotalHours(time) > 24) {
            return '${double.parse((getTotalHours(time) / 24).toString()).floor()} days';
          } else {
            if (getTotalHours(time) <= 9) {
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

  fetchCompetition() async {
    final response = await access_network().getSoccerCompetitions();
    if (response.status) {
      if (mounted) {
        setState(() {
          {
            competition = response.competition;
          }
        });
      } else {
        competition = response.competition;
      }
      for (var i in competition) {
        fetchMatches(i.cid);
      }
    }
  }

  fetchMatches(cid) async {
    print(cid);
    final response = await access_network().getSoccerMatch(cid);
    if (response.status) {
      if (mounted) {
        setState(() {
          {
            matches.addAll(response.matches);
          }
        });
      } else {
        matches.addAll(response.matches);
      }
    }
  }
}
