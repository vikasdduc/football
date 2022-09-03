import 'package:flutter/material.dart';

import '../../Language/appLocalizations.dart';
import '../../Model/GetTeam.dart';
import '../../Model/Players.dart';
import '../../Model/leaderboard_outside.dart';
import '../../Networking/AccessNetwork.dart';
import '../../constance/constance.dart';
import '../Live/Team_points_preview.dart';

class leaderboard_completed_list extends StatefulWidget {
  final match_id, match, cid;
  List<GetTeam> dataTeams = new List<GetTeam>();

  leaderboard_completed_list(
      this.match_id, this.dataTeams, this.match, this.cid);

  @override
  State<leaderboard_completed_list> createState() =>
      _leaderboard_completed_listState();
}

class _leaderboard_completed_listState
    extends State<leaderboard_completed_list> {
  List<leaderboard_outside> tempList = new List<leaderboard_outside>();
  var totalpoint = 0.0;
  var countA = 0, countB = 0;

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
                child: Text(
                  'Please Wait',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).textTheme.bodyText2.color,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                ),
              ),
            ),
          )
        : Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: tempList.length,
                itemBuilder: (cont, index) {
                  var data = tempList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: GestureDetector(
                      onTap: () {
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
                      },
                      child: container(
                        Theme.of(context).appBarTheme.color,
                        AppLocalizations.of('${data.name}'),
                        "${data.points} Points",
                        "#${data.rank}",
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
          );
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
    print('Iam');
    access_network()
        .getleaderboard_outside(ConstanceData.prof.id.toString(),
            widget.match_id, widget.cid.toString(), 0)
        .then((_) {
      setState(() {
        print('bcvxzbvx');
        tempList = _;
      });
    });
  }

  List<players> getTeamA(count) {
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

  List<players> getTeamB(int count) {
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
}
