import 'dart:async';
import 'dart:collection';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/GetTeam.dart';
import 'package:fantacySports/Model/Matche.dart';
import 'package:fantacySports/modules/matchDetail/matchDetailPage.dart';
import 'package:fantacySports/modules/sports/cricket_sub_widgets/BannerSlider.dart';
import 'package:fantacySports/modules/sports/cricket_sub_widgets/my_matches_cricket.dart';
import 'package:fantacySports/widget/cardView.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../Networking/AccessNetwork.dart';
import '../../constance/constance.dart';

class CricketPage extends StatefulWidget {
  final bool data;

  CricketPage(this.data);

  @override
  _CricketPageState createState() => _CricketPageState();
}

class _CricketPageState extends State<CricketPage> {
  // List<match> myLiveMatchList = new List<match>();
  // List<match> LiveMatchList = new List<match>();
  int page =2;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          try {
            fetchMatches();
          } catch (e) {
            print(e);
          }
          // try {
          //   myLiveMatchList =
          //       getList(ConstanceData.mylist, ConstanceData.matchLivelist);
          //   LiveMatchList = getLiveist(ConstanceData.matchLivelist);
          // } catch (e) {
          //   print(e);
          // }
        });
      } else {
        fetchMatches();
        // try {
        //   myLiveMatchList =
        //       getList(ConstanceData.mylist, ConstanceData.matchLivelist);
        //   LiveMatchList = getLiveist(ConstanceData.matchLivelist);
        // } catch (e) {
        //   print(e);
        // }
      }
    });
  }

  void fetchMatches() {
    try {
      access_network().getTeam().then((value) => {
            setValues(value),
          });
    } catch (e) {
      print(e);
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Oops something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  setValues(value) {
    if (value != null && value.length != 0) {
      setState(() {
        ConstanceData.setMyList(value);
        // myLiveMatchList =
        //     getList(ConstanceData.mylist, ConstanceData.matchLivelist);
      });
    } else {}
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    try {
      access_network().getTeam().then((value) {
            if (value != null && value.length != 0) {
              setState(() {
                ConstanceData.setMyList(value);
              });

            } else {

            }
          });
    } catch (e) {
      print(e);

    }
    try {
      fetchJoinedMatches(await ConstanceData.getId());
    } catch (e) {
      print(e);
    }
    try {
      access_network().fetchUpcomingMatches(0).then((_) {
            if (mounted) {
              setState(() {
                page=2;
                ConstanceData.setSchedMatch(_);
              });
            } else {
              ConstanceData.setSchedMatch(_);
            }
            _refreshController.refreshCompleted();
          });
    } catch (e) {
      print(e);
      _refreshController.refreshFailed();
    }


  }

  void _onLoading() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    access_network().fetchUpcomingMatches(page).then((_) {
      if (mounted) {
        setState(() {
          ConstanceData.addSchedMatch(_);
        });
      } else {
        ConstanceData.addSchedMatch(_);
      }
      _refreshController.refreshCompleted();
    });
    if (mounted) setState(() {
page++;
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          // header: ,
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: Container(
            color: Colors.grey.shade100,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstanceData.matchJoined != null &&
                          ConstanceData.matchJoined.length >= 1
                      ? MyMatchesCricket(ConstanceData.matchJoined)
                      : Container(),
                  Center(
                    child: BannerSlider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 8),
                    child: Text(
                      AppLocalizations.of('Upcoming Matches'),
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Theme.of(context).textTheme.headline6.color,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                            fontSize: 16,
                          ),
                    ),
                  ),
                  !widget.data || ConstanceData.matchSchedlist == null
                      ? getWidget()
                      : ListView.builder(
                          itemCount:ConstanceData.matchSchedlist.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (cont, index) {
                            match data =ConstanceData.matchSchedlist[index];
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
                                            '00m:00s',
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
                                                '00m:00s',
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
                                  txt7: AppLocalizations.of('MEGA'),
                                  txt8: '${data.mega_price}',
                                  // txt8:'${ConstanceData.contests.length}',
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
                                    ConstanceData.matchSchedIndex = index;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MatchDetailPage(
                                          getLiveist(
                                              ConstanceData.matchSchedlist),
                                          ConstanceData.matchSchedIndex,
                                          constance.CompetitionType.upcoming,
                                          DateTime(year, month, day, hour, mint,
                                              sec),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                              ],
                            );
                          })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        child: Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: Colors.red,
            size: 50,
          ),
        ),
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

  getList(List<GetTeam> mylist, List<match> matchLivelist) {
    var temporaryList = new List<match>();
    for (var i in mylist) {
      for (var j in matchLivelist) {
        if (i.competition_id.toString() == j.cid.toString() &&
            i.match_id.toString() == j.match_id.toString()) {
          temporaryList.add(j);
        }
      }
    }
    return LinkedHashSet<match>.from(temporaryList).toList(growable: false);
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

  getLiveist(List<match> matchLivelist) {
    List<match> list = new List<match>();
    for (var i in matchLivelist) {
      // print(' ${i.title} ${i.status}');
      if (i.status.toString() == '1') {
        list.add(i);
      }
    }
    return list;
  }

  void fetchJoinedMatches(id) async {
    access_network().fetchJoinedMatches(id).then((_) {
      if (mounted) {
        setState(() {
          ConstanceData.setJoinedMatch(_);
        });
      } else {
        ConstanceData.setJoinedMatch(_);
      }
    });
  }
}
