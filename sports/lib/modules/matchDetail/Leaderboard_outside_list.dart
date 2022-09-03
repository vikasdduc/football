import 'package:fantacySports/Model/Matche.dart';
import 'package:flutter/material.dart';

import '../../Language/appLocalizations.dart';
import '../../Model/Players.dart';
import '../../Model/leaderboard_outside.dart';
import '../../Networking/AccessNetwork.dart';
import '../../constance/constance.dart';
import '../Live/Team_points_preview.dart';
import '../createTeam/teamPreview.dart';

class Leaderboard_Outside_List extends StatefulWidget {
  final match_id, match, isLive, cid;

  Leaderboard_Outside_List(
    this.match_id,
    this.match,
    this.isLive,
    this.cid,
  );

  @override
  State<Leaderboard_Outside_List> createState() =>
      _Leaderboard_Outside_ListState();
}

class _Leaderboard_Outside_ListState extends State<Leaderboard_Outside_List> {
  List<leaderboard_outside> tempList = new List<leaderboard_outside>();

  double totalpoint = 0;

  @override
  void initState() {
    super.initState();
    print('asdfnafn q39wru0');
    fetchIt();
  }

  @override
  Widget build(BuildContext context) {
    return tempList.length <= 0
        ? Expanded(
            child: Container(
              child: Center(
                child: Text('The Match has not finished yet'),
              ),
            ),
          )
        : Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: Colors.grey.shade200,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Center(
                              child: Text(
                                'All teams',
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
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Center(
                              child: Text(
                                'Points',
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
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Center(
                              child: Text(
                                '#Rank',
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.all(0.0),
                      itemCount: tempList.length,
                      itemBuilder: (cont, index) {
                        var data = tempList[index];
                        return GestureDetector(
                          onTap: () {
                            try {
                              if (widget.isLive) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => team_points_preview(
                                        getTeamB(index)[0].pid,
                                        getTeamB(index)[1].pid,
                                        getTeamA(index),
                                        getTotalPoint(index),
                                        widget.match.teama.short_name,
                                        widget.match.teamb.short_name,
                                        data.name,
                                        data.team_id),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TeamPreViewPage(
                                        getTeamA(index),
                                        getTeamB(index)[0].pid,
                                        getTeamB(index)[1].pid,
                                        widget.match.teama.short_name,
                                        widget.match.teamb.short_name),
                                  ),
                                );
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: container(
                              Theme.of(context).appBarTheme.color,
                              AppLocalizations.of('${data.name}'),
                              "${data.points}",
                              "${data.rank}",
                              Icons.arrow_left,
                              Colors.green,
                              AssetImage(ConstanceData.defaultPlayer),
                              data.rank,
                              data.user_id.toString() ==
                                  ConstanceData.prof.id.toString(),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
  }

  List<players> getTeamA(count) {
    print('${tempList[count].team_a}');
    List<players> list = new List<players>();
    for (var i in tempList[count].team_a.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString()) {
          list.add(j);
        }
      }
    }
    return list;
  }

  List<players> getTeamB(int count) {
    print('${tempList[count].name}');
    List<players> list = new List<players>();
    for (var i in tempList[count].team_b.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString()) {
          list.add(j);
        }
      }
    }
    return list;
  }

  Widget container(Color color, String txt1, String txt2, String txt3,
      IconData icon, Color iconColor, AssetImage image, int index, bool user) {
    return Container(
      height: AppBar().preferredSize.height,
      color: user ? Color(0xfffbfbe1) : color,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 14),
        child: Row(
          children: [
            user
                ? CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    backgroundImage: ConstanceData.prof == null ||
                            ConstanceData.prof.profile_image == null
                        ? AssetImage(
                            ConstanceData.palyerProfilePic,
                          )
                        : NetworkImage(
                            'https://theapnateam.com/admin/public/document/user/${ConstanceData.prof.profile_image}',
                          ),
                  )
                : CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    backgroundImage: image,
                  ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txt1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.headline6.color,
                          letterSpacing: 0.6,
                          fontSize: 12,
                        ),
                  ),
                  index == 1
                      ? SizedBox(
                          height: 2,
                        )
                      : Container(),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              txt2,
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Theme.of(context).textTheme.bodyText2.color,
                    letterSpacing: 0.6,
                    fontSize: 12,
                  ),
            ),
            Expanded(child: SizedBox()),
            Text(
              txt3,
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.black,
                    letterSpacing: 0.6,
                    fontSize: 14,
                  ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget row(String txt1, AssetImage image) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: image,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            txt1,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.black87,
                  letterSpacing: 0.6,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }

  void fetchIt() async {
    access_network()
        .getleaderboard_outside(
            ConstanceData.prof.id.toString(), widget.match_id, widget.cid, 0)
        .then((_) {
      setState(() {
        print('bcvxzbvx');
        tempList = _;
      });
    });
  }

  getTotalPoint(count) {
    totalpoint = 0;
    for (var i in tempList[count].team_a.toString().split(',')) {
      for (var j in ConstanceData.teamCombine_points) {
        if (i == j.pid.toString()) {
          if (i == tempList[count].team_b.toString().split(',')[0]) {
            totalpoint += (double.parse(j.point.toString()) * 2);
          } else if (i == tempList[count].team_b.toString().split(',')[1]) {
            totalpoint += (double.parse(j.point.toString()) * 1.5);
          } else {
            totalpoint += double.parse(j.point.toString());
          }
        }
      }
    }
    return totalpoint;
  }
}
