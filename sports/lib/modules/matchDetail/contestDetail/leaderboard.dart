import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

import '../../../Model/LeaderBoardItem.dart';
import '../../../Model/Leaderboard_contest.dart';
import '../../../Networking/AccessNetwork.dart';

class LeaderboardPage extends StatefulWidget {
  final match_id, contest_id, isLive;

  LeaderboardPage(this.match_id, this.contest_id, this.isLive);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<leaderBoard> list = new List<leaderBoard>();
  List<leaderBoard_contest> tempList = new List<leaderBoard_contest>();

  @override
  void initState() {
    super.initState();
    fetchIt();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: tempList.length <= 0
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text('The Match has not finished yet'),
              ),
            )
          : Column(
            children: [
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.grey.shade200,
                  child: Row(
                    children: [
                      Container(

                        padding:EdgeInsets.only(left:20),
                        child: Center(
                          child: Text('All teams', style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.headline6.color,
                            letterSpacing: 0.6,
                            fontSize: 14,
                          ),),
                        ),
                      ),
                      // Expanded(
                      //   flex: 2,
                      //   child: Container(
                      //     child: Center(
                      //       child: Text('Points', style: Theme.of(context).textTheme.caption.copyWith(
                      //         color: Theme.of(context).textTheme.headline6.color,
                      //         letterSpacing: 0.6,
                      //         fontSize: 14,
                      //       ),),
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   flex: 2,
                      //   child: Container(
                      //     child: Center(
                      //       child: Text('#Rank', style: Theme.of(context).textTheme.caption.copyWith(
                      //         color: Theme.of(context).textTheme.headline6.color,
                      //         letterSpacing: 0.6,
                      //         fontSize: 14,
                      //       ),),
                      //     ),
                      //   ),
                      // ),
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
                      return Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: container(
                            Theme.of(context).appBarTheme.color,
                            AppLocalizations.of('${data.team.user.name}'),
                            "T${data.team.id}",
                            "${index + 1}",
                            Icons.arrow_left,
                            Colors.green,
                            AssetImage(ConstanceData.defaultPlayer),
                            index + 1,
                            widget.isLive,
                          data.user_id.toString()==ConstanceData.prof.id.toString(),
                        ),
                      );
                    }),
              ),
            ],
          ),
    );
  }

  Widget container(
      Color color,
      String txt1,
      String txt2,
      String txt3,
      IconData icon,
      Color iconColor,
      AssetImage image,
      int index,
      bool isLive,
      bool user) {
    return Container(
      height: AppBar().preferredSize.height,
      color: user?Colors.yellow.shade100:color,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 14),
        child: Row(
          children: [
            user?CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage:ConstanceData.prof==null||ConstanceData.prof.profile_image==null?AssetImage(
                ConstanceData.palyerProfilePic,
              ):NetworkImage(
                'https://theapnateam.com/admin/public/document/user/${ConstanceData.prof.profile_image}',
              ),
            ):CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              backgroundImage: image,
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              // width:50,
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
                          fontSize: 14,
                        ),
                  ),
                  index == 1 && !isLive
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
            // Expanded(
            //     flex:3,
            //     child: SizedBox()),
            // Text(
            //   txt2,
            //   style: Theme.of(context).textTheme.caption.copyWith(
            //     color: Theme.of(context).textTheme.bodyText2.color,
            //     letterSpacing: 0.6,
            //     fontSize: 14,
            //   ),
            // ),
            Expanded(child: SizedBox()),
            // Text(
            //   txt3,
            //   style: Theme.of(context).textTheme.caption.copyWith(
            //         color: Colors.black,
            //         letterSpacing: 0.6,
            //         fontSize: 14,
            //       ),
            // ),
            SizedBox(
              width: 10,
            ),
            // Icon(
            //   icon,
            //   color: iconColor,
            //   size: 22,
            // ),
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
        .get_leaderboard_contest(ConstanceData.prof.id.toString(),
            widget.match_id, widget.contest_id)
        .then((_) {
      setState(() {
        tempList = _;
      });
    });
  }

}
