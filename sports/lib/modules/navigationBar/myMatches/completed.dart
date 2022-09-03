import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/GetTeam.dart';
import 'package:fantacySports/Model/Matche.dart';
import 'package:fantacySports/Model/contest.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/modules/matchDetail/matchDetailPage.dart';
import 'package:fantacySports/widget/cardView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fantacySports/constance/constance.dart' as constance;
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Model/match_new.dart';
import '../../../Networking/AccessNetwork.dart';
import '../../../widget/myContestCard.dart';
import '../../Completed/completedMatchDetailPage.dart';

class CompletedPage extends StatefulWidget {
  final Function onTap;

  CompletedPage(this.onTap);

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  int page = 2;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    try {
      access_network()
          .get_competed_match(ConstanceData.prof.id.toString(), 0)
          .then((value) {
        if (mounted) {
          setState(() {
            ConstanceData.setCompMatch(value);
          });
        } else {
          ConstanceData.setCompMatch(value);
        }
      });
    } catch (e) {
      print(e);
    }

    try {
      access_network().getTeam().then((value) {
        if (mounted) {
          setState(() {
            ConstanceData.setMyList(value);
          });

        } else {
          ConstanceData.setMyList(value);
        }
        _refreshController.refreshCompleted();
      });
    } catch (e) {
      print(e);
      _refreshController.refreshFailed();
    }

    // _refreshController.refreshFailed();
  }

  void _onLoading() async {
    print("Loading");
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    access_network()
        .get_competed_match(ConstanceData.prof.id.toString(), page)
        .then((value) {
      if (mounted) {
        setState(() {
          ConstanceData.setCompMatch(value);
        });
      } else {
        ConstanceData.setCompMatch(value);
      }
    });
    if (mounted)
      setState(() {
        page++;
      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return ConstanceData.matchComplist == null ||
            ConstanceData.matchComplist.length <= 0
        ? Expanded(
            child: Container(
              child: Center(
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
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
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
              ),
            ),
          )
        : SizedBox(
      height: MediaQuery.of(context).size.height-230,
          child: Scaffold(
            backgroundColor:Colors.grey.shade200,
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
                  height: MediaQuery.of(context).size.height - 235,
                  child: ListView.builder(
                      itemCount: ConstanceData.matchComplist.length,
                      shrinkWrap: true,
                      itemBuilder: (cont, index) {
                        match_new data = ConstanceData.matchComplist[index];
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
                            MyContestCard(
                              txt1: AppLocalizations.of('${data.title}'),
                              txt2: AppLocalizations.of('${data.teama.name}'),
                              txt3: AppLocalizations.of('${data.teamb.name}'),
                              txt4: "${data.teama.short_name}",
                              setTime: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff0ebd01),
                                    ),
                                    height: 7,
                                    width: 7,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Completed',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff0ebd01),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              txt6: "${data.teamb.short_name}",
                              txt7: AppLocalizations.of(
                                  '${data.total_teams == null ? 0 : data.total_teams} Team'),
                              txt8: AppLocalizations.of(
                                  '${data.total_contest == null ? 0 : data.total_contest} Contests'),
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
                              image3: data.total_winner_amount == 0
                                  ? null
                                  : Text(
                                      'You won ₹${data.total_winner_amount}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Color(0xff0ebd01),
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.6,
                                            fontSize: 10,
                                          ),
                                    ),
                              onTap: () {
                                ConstanceData.matchCompIndex = index;
                                try {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CompletedMatchDetailPage(
                                        ConstanceData.matchComplist,
                                        ConstanceData.matchCompIndex,
                                        constance.CompetitionType.completed,
                                        DateTime(
                                            year, month, day, hour, mint, sec),
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      }),
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
    if (getTotalHours(time) < 9) {
      if (time.min < 9) {
        return '0${getTotalHours(time)}h : 0${time.min}m';
      } else {
        return '0${getTotalHours(time)}h : ${time.min}m';
      }
    } else {
      if (time.min < 9) {
        return '${getTotalHours(time)}h : 0${time.min}m';
      } else {
        return '${getTotalHours(time)}h : ${time.min}m';
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCompleteCompetition();
  }

  void fetchCompleteCompetition() {
    try {
      print('ghsf');
      access_network()
          .get_competed_match(ConstanceData.prof.id.toString(), 0)
          .then((value) {
        if (mounted) {
          setState(() {
            ConstanceData.setCompMatch(value);
          });
        } else {
          ConstanceData.setCompMatch(value);
        }
        access_network().getTeam().then((value) {
          if (mounted) {
            setState(() {
              ConstanceData.setMyList(value);
            });
          } else {
            ConstanceData.setMyList(value);
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }

  List<Contest> filterContest(List<Contest> mylist) {
    List<Contest> list = new List<Contest>();
    for (var i in mylist) {
      if (i.user_id.toString() == ConstanceData.prof.id.toString()) {
        list.add(i);
      } else {}
    }
    return list;
  }

  List<GetTeam> filterContent(List<GetTeam> mylist, match_id) {
    List<GetTeam> list = new List<GetTeam>();
    try {
      for (var i in mylist) {
        if (i.match_id.toString() == match_id.toString()) {
          list.add(i);
          print(i.match_id);
        } else {}
      }
    } catch (e) {
      print(e);
    }
    return list;
  }

  getCount(String string) {
    int j = 0;
    if (ConstanceData.mylist != null && ConstanceData.mylist.length > 0) {
      for (var i in ConstanceData.mylist) {
        if (i.match_id.toString() == string) {
          j++;
        }
      }
    } else {}
    return j;
  }

// getNumber(int match_id) {
//   for(var i in ConstanceData.Mycontests){
//       if(i.id.toString() == match_)
//   }
// }
}
