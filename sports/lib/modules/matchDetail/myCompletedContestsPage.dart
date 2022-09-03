import 'package:fantacySports/Model/leaderboard_outside.dart';
import 'package:flutter/material.dart';

import '../../Language/appLocalizations.dart';
import '../../Model/GetTeam.dart';
import '../../Model/GetTeam_2.dart';
import '../../Model/Players.dart';
import '../../Model/contest_joined.dart';
import '../../Networking/AccessNetwork.dart';
import '../../constance/constance.dart';
import '../Live/Team_points_preview.dart';
import '../createTeam/teamPreview.dart';
import 'contestDetail/contestDetail.dart';
import 'contestDetail/non_live_contest_details.dart';
import 'non_live_page.dart';

class MyCompletedContestPage extends StatefulWidget {
  final time, title, list, index, isLive, match;
  final Function onTap, onDone, changeToLeaderBoard;
  final List<GetTeam> dataTeams;

  MyCompletedContestPage(
      this.time,
      this.title,
      this.onTap,
      this.list,
      this.index,
      this.onDone,
      this.isLive,
      this.dataTeams,
      this.match,
      this.changeToLeaderBoard);

  @override
  State<MyCompletedContestPage> createState() => _MyCompletedContestPageState();
}

class _MyCompletedContestPageState extends State<MyCompletedContestPage> {
  List<ContestJoined> filtered = new List<ContestJoined>();
  var totalpoint = 0.0;
  var countA = 0, countB = 0;
  AlertDialog alert;

  @override
  void initState() {
    super.initState();
    if (ConstanceData.specific_contests != null ||
        ConstanceData.specific_contests.length > 0) {
      filtered = getList();
    }
    Future.delayed(Duration(seconds: 1), () {
      fetchUserContest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstanceData.specific_contests == null ||
            ConstanceData.specific_contests.length == 0
        ? Center(
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
                  'assets/images/empty.png',
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
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of('Join A Contest'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.white,
                                letterSpacing: 0.6,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Expanded(
            // child: Container(
            //   padding: EdgeInsets.all(10.0),
            //   child: ListView.builder(
            //     padding: EdgeInsets.all(0.0),
            //     itemCount: ConstanceData.specific_contests.length,
            //     shrinkWrap: true,
            //     itemBuilder: (cont, index) {
            //       var data = ConstanceData.specific_contests[index];
            //       return Container(
            //         margin: EdgeInsets.only(bottom: 5.0),
            //         height: 145,
            //         color: Colors.white,
            //         width: MediaQuery.of(context).size.width,
            //         child: Column(
            //           children: [
            //             Expanded(
            //               child: Card(
            //                 elevation: 3,
            //                 child: Container(
            //                   // height: 145,
            //                   width: MediaQuery.of(context).size.width,
            //                   child: Column(
            //                     children: [
            //                       Expanded(
            //                         child: Container(
            //                           color: Colors.white,
            //                           child: GestureDetector(
            //                             onTap: () {
            //                               // Navigator.push(
            //                               //   context,
            //                               //   MaterialPageRoute(
            //                               //     builder: (context) =>
            //                               //         ContestDetailPage(time: widget.time.millisecondsSinceEpoch, title: widget.title, data: data,list: widget.list,index: index,
            //                               //           isLive: widget.isLive,),
            //                               //   ),
            //                               // );
            //                             },
            //                             child: Row(
            //                               children: [
            //                                 Expanded(
            //                                   flex: 1,
            //                                   child: Row(
            //                                     children: [
            //                                       Expanded(
            //                                         flex: 2,
            //                                         child: Container(
            //                                           child: Center(
            //                                             child: Text(
            //                                               // 'Contest Id:',
            //                                               '',
            //                                               style: TextStyle(
            //                                                 fontSize: 14,
            //                                                 color: Colors
            //                                                     .grey.shade700,
            //                                                 // fontWeight:
            //                                                 //     FontWeight.bold,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                       Expanded(
            //                                         flex: 1,
            //                                         child: Container(
            //                                           child: Center(
            //                                             child: Text(
            //                                               // '${data.id}',
            //                                               '',
            //                                               style: TextStyle(
            //                                                 fontSize: 15,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                       Expanded(
            //                                         child: Container(),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ),
            //                                 Expanded(
            //                                   flex: 1,
            //                                   child: Row(
            //                                     children: [
            //                                       Expanded(
            //                                         flex: 1,
            //                                         child: Container(),
            //                                       ),
            //                                       Expanded(
            //                                         flex: 1,
            //                                         child: GestureDetector(
            //                                           onTap: () {
            //                                             widget.changeToLeaderBoard();
            //                                           },
            //                                           child: Container(
            //                                             child: Center(
            //                                               child: Text(
            //                                                 '${data.spots}',
            //                                                 style: TextStyle(
            //                                                   fontSize: 14,
            //                                                 ),
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                       Expanded(
            //                                         flex: 1,
            //                                         child: Container(
            //                                           child: Center(
            //                                             child: Text(
            //                                               'spots',
            //                                               style: TextStyle(
            //                                                 fontSize: 13,
            //                                                 color: Colors
            //                                                     .grey.shade700,
            //                                                 fontWeight:
            //                                                     FontWeight.bold,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       )
            //                                     ],
            //                                   ),
            //                                 )
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       Expanded(
            //                         child: Container(
            //                           color: Colors.yellow.shade100,
            //                           child: GestureDetector(
            //                             onTap: () {
            //                             widget.changeToLeaderBoard();
            //                               // Navigator.push(
            //                               //   context,
            //                               //   MaterialPageRoute(
            //                               //     builder: (context) =>
            //                               //         ContestDetailPage(time: widget.time.millisecondsSinceEpoch, title: widget.title, data: data,list: widget.list,index: index,
            //                               //           isLive: widget.isLive,),
            //                               //   ),
            //                               // );
            //                             },
            //                             child: Row(
            //                               children: [
            //                                 Expanded(
            //                                   flex: 2,
            //                                   child: Container(
            //                                     child: Row(
            //                                       children: [
            //                                         Expanded(
            //                                           flex: 2,
            //                                           child: Container(
            //                                             child: Center(
            //                                               child: Text(
            //                                                 'Prize Money:',
            //                                                 style: TextStyle(
            //                                                   fontSize: 13,
            //                                                   color: Colors.grey
            //                                                       .shade700,
            //                                                   // fontWeight:
            //                                                   //     FontWeight.bold,
            //                                                 ),
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                         Expanded(
            //                                           flex: 2,
            //                                           child: Container(
            //                                             child: Text(
            //                                               '₹${getPrizeName(data.prize)}',
            //                                               style: TextStyle(
            //                                                 fontSize: 14,
            //                                                 color: Colors.black,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                         // Expanded(
            //                                         //   flex: 1,
            //                                         //   child: Container(),
            //                                         // ),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 Expanded(
            //                                   flex: 1,
            //                                   child: Container(),
            //                                 ),
            //                                 Expanded(
            //                                   flex: 1,
            //                                   child: Container(
            //                                     child: Center(
            //                                       child: Text(
            //                                         '${data.name == null ? 'NA' : data.name}',
            //                                         style: TextStyle(
            //                                           fontSize: 15,
            //                                           color: Colors.black,
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       Expanded(
            //                         child: Container(
            //                           child: GestureDetector(
            //                             onTap: () {
            //                               Navigator.push(
            //                                 context,
            //                                 MaterialPageRoute(
            //                                   builder: (context) =>
            //                                       team_points_preview(
            //                                           getTeamB(index)[0].pid,
            //                                           getTeamB(index)[1].pid,
            //                                           getTeamA(index),
            //                                           getTotalPoint(index),
            //                                           widget.match.teama
            //                                               .short_name,
            //                                           widget.match.teamb
            //                                               .short_name,""),
            //                                 ),
            //                               );
            //                               // Navigator.push(
            //                               //   context,
            //                               //   MaterialPageRoute(
            //                               //     builder: (context) =>
            //                               //         TeamPreViewPage(
            //                               //             getTeamA(data),
            //                               //             getTeamB(data)[0]
            //                               //                 .pid,
            //                               //             getTeamB(data)[1]
            //                               //                 .pid,
            //                               //             widget.list[widget.index].teama.short_name,
            //                               //             widget.list[widget.index].teamb.short_name
            //                               //         ),
            //                               //   ),
            //                               // );
            //                             },
            //                             child: Row(
            //                               children: [
            //                                 Expanded(
            //                                   flex: 1,
            //                                   child: Row(
            //                                     children: [
            //                                       Expanded(
            //                                         flex: 1,
            //                                         child: Container(
            //                                           child: Center(
            //                                             child: SizedBox(
            //                                               width: 50,
            //                                               child: Text(
            //                                                 '${data.team.user.team_name == null || data.team.user.team_name == '' ? data.team.user.name : data.team.user.team_name}',
            //                                                 overflow:
            //                                                     TextOverflow
            //                                                         .ellipsis,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                       Expanded(
            //                                         flex: 1,
            //                                         child: Container(
            //                                           child: Center(
            //                                             child: Text(
            //                                               'T${findIndex(data.team.id)}',
            //                                               style: TextStyle(
            //                                                 fontSize: 13,
            //                                                 color: Colors.black,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                       Expanded(
            //                                         child: Container(),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ),
            //                                 Expanded(
            //                                   flex: 1,
            //                                   child: Row(
            //                                     children: [
            //                                       Expanded(
            //                                         flex: 2,
            //                                         child: Container(),
            //                                       ),
            //                                       Expanded(
            //                                         flex: 3,
            //                                         child: Container(
            //                                           child: Center(
            //                                             child: Text(
            //                                               'No. Winners:',
            //                                               style: TextStyle(
            //                                                 fontSize: 13,
            //                                                 color: Colors
            //                                                     .grey.shade700,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                       Expanded(
            //                                         flex: 1,
            //                                         child: Container(
            //                                           child: Center(
            //                                             child: Text(
            //                                               '${data.number_of_winners == null ? 'NA' : data.number_of_winners}',
            //                                               style: TextStyle(
            //                                                 fontSize: 15,
            //                                                 color: Colors.black,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       )
            //                                     ],
            //                                   ),
            //                                 )
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       // Expanded(
            //                       //   child: Container(
            //                       //     child: Row(
            //                       //       children: [
            //                       //         SizedBox(
            //                       //             width:11
            //                       //         ),
            //                       //         Container(
            //                       //           padding: EdgeInsets.all(
            //                       //             7,
            //                       //           ),
            //                       //           decoration:BoxDecoration(
            //                       //             shape: BoxShape.circle,
            //                       //             color:Theme.of(context).textTheme.headline6.color,
            //                       //
            //                       //             border: Border.all(
            //                       //               color:Theme.of(context).appBarTheme.color,
            //                       //             ),
            //                       //           ),
            //                       //           child: Text(
            //                       //             'C',
            //                       //             style: TextStyle(
            //                       //               fontSize:10,
            //                       //               color: Theme.of(context).appBarTheme.color,
            //                       //               fontWeight: FontWeight.bold,
            //                       //             ),
            //                       //           ),
            //                       //         ),
            //                       //         SizedBox(
            //                       //             width:5
            //                       //         ),
            //                       //         Text(
            //                       //           // '${getCap(data.team.id.toString())==''?'':getCap(data.team.id.toString()).title}',
            //                       //           '',
            //                       //           style: TextStyle(
            //                       //             fontSize: 13,
            //                       //             color: Colors.black,
            //                       //           ),
            //                       //         ),
            //                       //         SizedBox(
            //                       //             width:11
            //                       //         ),
            //                       //         Container(
            //                       //           padding: EdgeInsets.all(
            //                       //             4,
            //                       //           ),
            //                       //           decoration:BoxDecoration(
            //                       //             shape: BoxShape.circle,
            //                       //             color:Theme.of(context).textTheme.headline6.color,
            //                       //
            //                       //             border: Border.all(
            //                       //               color:Theme.of(context).appBarTheme.color,
            //                       //             ),
            //                       //           ),
            //                       //           child: Text(
            //                       //             'VC',
            //                       //             style: TextStyle(
            //                       //               fontSize:10,
            //                       //               color: Theme.of(context).appBarTheme.color,
            //                       //               fontWeight: FontWeight.bold,
            //                       //             ),
            //                       //           ),
            //                       //         ),
            //                       //         SizedBox(
            //                       //             width:5
            //                       //         ),
            //                       //         Text(
            //                       //           // '${getVice(data.team.id.toString())==''?'':getVice(data.team.id.toString()).title}',
            //                       //           '',
            //                       //           style: TextStyle(
            //                       //             fontSize: 13,
            //                       //             color: Colors.black,
            //                       //
            //                       //           ),
            //                       //         ),
            //                       //       ],
            //                       //     ),
            //                       //   ),
            //                       // ),
            //                       SizedBox(
            //                         height: 3,
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               height: 10,
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
            child: Container(
              color: Colors.grey.shade100,
              padding: EdgeInsets.all(10.0),
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: ConstanceData.specific_contests.length,
                shrinkWrap: true,
                itemBuilder: (cont, index) {
                  ContestJoined data = ConstanceData.specific_contests[index];
                  return Card(
                    child: Container(
                      // margin: EdgeInsets.all(3),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Prize Pool',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      Text(
                                        '₹${getPrizeName(data.prize)}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Spots',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      Text(
                                        '${data.spots}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Entry',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                      Text(
                                        '${data.entry}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (widget.isLive) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NonLiveLeaderboard(
                                      widget.time.millisecondsSinceEpoch,
                                      widget.list[widget.index].match_id
                                          .toString(),
                                      widget.list[widget.index],
                                      widget.isLive,
                                      widget.list[widget.index].cid.toString(),
                                      data.id,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NonLiveContestDetails(
                                      time: widget.time.millisecondsSinceEpoch,
                                      title: widget.title,
                                      data: data,
                                      list: widget.list,
                                      index: index,
                                      isLive: widget.isLive,
                                      teams: widget.dataTeams,
                                      percent: data.percent,
                                      isMega: data.isMega,
                                      first_price: data.first_price,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(3),
                              color: Colors.grey.shade200,
                              // color: Color(0xffF5F5F5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 110,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              // color: Colors.green.withOpacity(0.25), // border color
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.grey.shade900),
                                            ),
                                            child: Center(
                                              child: Text(
                                                  '${data.contest_type.toString().trim() == 'Multi Entry' ? 'M' : 'S'}',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey.shade900,
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${data.contest_type}',
                                            style: TextStyle(
                                              fontSize: 11,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Center(
                                      child: Text(
                                        '${getCategoryName(data.category_id)}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 11,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 110,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.black,
                                            size: 11,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Guaranteed',
                                            style: TextStyle(
                                              fontSize: 11,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTileTheme(
                            dense: true,
                            child: ExpansionTile(
                              iconColor: Colors.black,
                              collapsedIconColor: Colors.black,
                              title: Row(
                                children: [
                                  Text(
                                    '${data.team == null || data.team[0].user.team_name == null || data.team[0].user.team_name == '' ? data.team[0].user.name : data.team[0].user.team_name}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade900,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('${team_names(data.team)}',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  ConstanceData.leaderboardoutside.length >=
                                              1 &&
                                          widget.isLive
                                      ? SizedBox(
                                          width: 5,
                                        )
                                      : Container(),
                                  ConstanceData.leaderboardoutside.length >=
                                              1 &&
                                          widget.isLive
                                      ? Text(
                                          '${checkUserWinning(ConstanceData.leaderboardoutside, data)}',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold))
                                      : Container(),
                                ],
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap:true,
                                    itemCount: data.team.length,
                                    itemBuilder: (cont, ind) {
                                      var current = data.team[ind];
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 15),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          'Joined with a team',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 15),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              child: Container(
                                                color: Color(0xffF5F5F5),
                                                width: 20,
                                                height: 20,
                                                child: Center(
                                                  child: Text(
                                                    '${team_names(data.team)}',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SizedBox(),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: Color(0xffFEF5E4),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  child: Container(
                                                    // width: 80,
                                                    height: 20,
                                                    child: Center(
                                                      child: Text(
                                                        'Team ${current.user.team_name}',
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SizedBox(),
                                                ),
                                                // GestureDetector(
                                                //   onTap: (){
                                                //
                                                //   },
                                                //   child: SizedBox(
                                                //     child: Container(
                                                //       color: Color(0xffF5F5F5),
                                                //       width: 20,
                                                //       height: 20,
                                                //       child: Center(
                                                //         child: Icon(
                                                //           Icons.edit,
                                                //           color: Colors.black,
                                                //           size: 18,
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //     builder: (context) =>
                                                    //         TeamPreViewPage(
                                                    //             getTeamA(data),
                                                    //             getTeamB(data)[0].pid,
                                                    //             getTeamB(data)[1].pid,
                                                    //             widget
                                                    //                 .list[widget.index]
                                                    //                 .teama
                                                    //                 .short_name,
                                                    //             widget
                                                    //                 .list[widget.index]
                                                    //                 .teamb
                                                    //                 .short_name),
                                                    //   ),
                                                    // );
                                                  },
                                                  child: SizedBox(
                                                    child: Container(
                                                      color: Color(0xffF5F5F5),
                                                      width: 20,
                                                      height: 20,
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.folder,
                                                          color: Colors.black,
                                                          size: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Captain',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors
                                                              .grey.shade900,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${getCap(current.id.toString()) == '' ? '' : short_the_name(getCap(current.id.toString()).title)}',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 100,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Vice Captain',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors
                                                              .grey.shade900,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${getVice(current.id.toString()) == '' ? '' : short_the_name(getVice(current.id.toString()).title)}',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                })
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  // return Container(
                  //   margin: EdgeInsets.only(bottom: 5.0),
                  //   height: 145,
                  //   color: Colors.white,
                  //   width: MediaQuery.of(context).size.width,
                  //   child: Column(
                  //     children: [
                  //       Expanded(
                  //         child: Card(
                  //           elevation: 3,
                  //           child: Container(
                  //             // height: 145,
                  //             width: MediaQuery.of(context).size.width,
                  //             child: Column(
                  //               children: [
                  //                 Expanded(
                  //                   child: Container(
                  //                     color: Colors.white,
                  //                     child: GestureDetector(
                  //                       onTap: () {
                  //                         Navigator.push(
                  //                           context,
                  //                           MaterialPageRoute(
                  //                             builder: (context) =>
                  //                                 ContestDetailPage(time: widget.time.millisecondsSinceEpoch, title: widget.title, data: data,list: widget.list,index: index,
                  //                                 isLive: widget.isLive,),
                  //                           ),
                  //                         );
                  //                       },
                  //                       child: Row(
                  //                         children: [
                  //                           Expanded(
                  //                             flex: 1,
                  //                             child: Row(
                  //                               children: [
                  //                                 Expanded(
                  //                                   flex: 2,
                  //                                   child: Container(
                  //                                     child: Center(
                  //                                       child: Text(
                  //                                         // 'Contest Id:',
                  //                                         '',
                  //                                         style: TextStyle(
                  //                                           fontSize: 14,
                  //                                           color: Colors
                  //                                               .grey.shade700,
                  //                                           // fontWeight:
                  //                                           //     FontWeight.bold,
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                                 Expanded(
                  //                                   flex: 1,
                  //                                   child: Container(
                  //                                     child: Center(
                  //                                       child: Text(
                  //                                         // '${data.id}',
                  //                                         '',
                  //                                         style: TextStyle(
                  //                                           fontSize: 15,
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ),   Expanded(
                  //                                   child: Container(),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                           Expanded(
                  //                             flex: 1,
                  //                             child: Row(
                  //                               children: [
                  //                                 Expanded(
                  //                                   flex: 1,
                  //                                   child: Container(),
                  //                                 ),
                  //                                 Expanded(   flex: 1,
                  //                                   child: Container(
                  //                                     child: Center(
                  //                                       child: Text(
                  //                                         '${data.spots}',
                  //                                         style: TextStyle(
                  //                                           fontSize: 14,
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                                 Expanded(   flex: 1,
                  //                                   child: Container(
                  //                                     child: Center(
                  //                                       child: Text(
                  //                                         'spots',
                  //                                         style: TextStyle(
                  //                                           fontSize: 13,
                  //                                           color: Colors
                  //                                               .grey.shade700,
                  //                                           fontWeight:
                  //                                               FontWeight.bold,
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 )
                  //                               ],
                  //                             ),
                  //                           )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //
                  //                     child: GestureDetector(
                  //                       onTap: () {
                  //                         print('asd ${widget.time}');
                  //                         Navigator.push(
                  //                           context,
                  //                           MaterialPageRoute(
                  //                             builder: (context) =>
                  //                                 ContestDetailPage(time: widget.time.millisecondsSinceEpoch, title: widget.title, data: data,list: widget.list,index: index,
                  //                                   isLive: widget.isLive,),
                  //                           ),
                  //                         );
                  //                       },
                  //                       child: Row(
                  //                         children: [
                  //                           Expanded(
                  //                             flex: 2,
                  //                             child: Container(
                  //                               child: Row(
                  //                                 children: [
                  //                                   Expanded(
                  //                                     flex: 2,
                  //                                     child: Container(
                  //                                       child: Center(
                  //                                         child: Text(
                  //                                       'Prize Money:',
                  //                                           style: TextStyle(
                  //                                             fontSize: 13,
                  //                                             color: Colors
                  //                                                 .grey.shade700,
                  //                                             // fontWeight:
                  //                                             //     FontWeight.bold,
                  //                                           ),
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                   Expanded(
                  //                                     flex: 2,
                  //                                     child: Container(
                  //                                       child: Text(
                  //                                         '₹${getPrizeName(data.prize)}',
                  //                                         style: TextStyle(
                  //                                           fontSize: 14,
                  //                                           color: Colors.black,
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                   // Expanded(
                  //                                   //   flex: 1,
                  //                                   //   child: Container(),
                  //                                   // ),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           Expanded(
                  //                             flex: 1,
                  //                             child: Container(),
                  //                           ),
                  //                           Expanded(
                  //                             flex: 1,
                  //                             child: Container(
                  //                               child: Center(
                  //                                 child: Text(
                  //                                   '${data.name==null?'NA':data.name}',
                  //                                   style: TextStyle(
                  //                                     fontSize: 10,
                  //                                     color: Colors.black,
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                     color: Colors.yellow.shade100,
                  //                     child: GestureDetector(
                  //                       onTap: (){
                  //                         Navigator.push(
                  //                           context,
                  //                           MaterialPageRoute(
                  //                             builder: (context) =>
                  //                                 TeamPreViewPage(
                  //                                     getTeamA(data),
                  //                                     getTeamB(data)[0]
                  //                                         .pid,
                  //                                     getTeamB(data)[1]
                  //                                         .pid,
                  //                                     widget.list[widget.index].teama.short_name,
                  //                                     widget.list[widget.index].teamb.short_name
                  //                                 ),
                  //                           ),
                  //                         );
                  //                       },
                  //                       child: Row(
                  //                         children: [
                  //                           Expanded(
                  //                             flex: 1,
                  //                             child: Row(
                  //                               children: [
                  //                                 Expanded(
                  //                                   flex: 1,
                  //                                   child: Container(
                  //                                     child: Center(
                  //                                       child:
                  //                                           SizedBox(
                  //                                             width: 50,
                  //                                             child: Text('${data.team.user.team_name==null||
                  //                                                 data.team.user.team_name==''?data.team.user.name:data.team.user.team_name}',overflow: TextOverflow.ellipsis,
                  //                                             style: TextStyle(
                  //                                               fontSize: 10
                  //                                             ),),
                  //                                           ),
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                                 Expanded(
                  //                                   flex: 1,
                  //                                   child: Container(
                  //                                     child: Center(
                  //                                       child: Text(
                  //                                         'T${findIndex(data.team.id)}',
                  //                                         style: TextStyle(
                  //                                           fontSize: 13,
                  //                                           color: Colors.black,
                  //
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                                 Expanded(
                  //                                   child: Container(),
                  //                                 ),
                  //                               ],
                  //                             ),
                  //                           ),
                  //                           Expanded(
                  //                             flex: 1,
                  //                             child: Row(
                  //                               children: [
                  //                                 Expanded(
                  //                                   flex: 2,
                  //                                   child: Container(),
                  //                                 ),
                  //                                 Expanded(
                  //                                   flex:3,
                  //                                   child: Container(
                  //                                     child: Center(
                  //                                       child: Text(
                  //                                         'No. Winners:',
                  //                                         style: TextStyle(
                  //                                           fontSize: 13,
                  //                                           color: Colors
                  //                                               .grey.shade700,
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                                 Expanded(
                  //                                   flex: 1,
                  //                                   child: Container(
                  //                                     child: Center(
                  //                                       child: Text(
                  //                                         '${data.number_of_winners==null?'NA':data.number_of_winners}',
                  //                                         style: TextStyle(
                  //                                           fontSize: 15,
                  //                                           color: Colors.black,
                  //
                  //                                         ),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                 )
                  //                               ],
                  //                             ),
                  //                           )
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                     child: Row(
                  //                       children: [
                  //                         SizedBox(
                  //                           width:11
                  //                         ),
                  //                         Container(
                  //                           padding: EdgeInsets.all(
                  //                            7,
                  //                           ),
                  //                           decoration:BoxDecoration(
                  //                             shape: BoxShape.circle,
                  //                             color:Theme.of(context).textTheme.headline6.color,
                  //
                  //                             border: Border.all(
                  //                               color:Theme.of(context).appBarTheme.color,
                  //                             ),
                  //                           ),
                  //                           child: Text(
                  //                             'C',
                  //                             style: TextStyle(
                  //                               fontSize:10,
                  //                               color: Theme.of(context).appBarTheme.color,
                  //                               fontWeight: FontWeight.bold,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         SizedBox(
                  //                             width:5
                  //                         ),
                  //                         Text(
                  //                           '${getCap(data.team.id.toString())==''?'':getCap(data.team.id.toString()).title}',
                  //                           style: TextStyle(
                  //                             fontSize: 13,
                  //                             color: Colors.black,
                  //                           ),
                  //                         ),
                  //                         SizedBox(
                  //                             width:11
                  //                         ),
                  //                         Container(
                  //                           padding: EdgeInsets.all(
                  //                             4,
                  //                           ),
                  //                           decoration:BoxDecoration(
                  //                             shape: BoxShape.circle,
                  //                             color:Theme.of(context).textTheme.headline6.color,
                  //
                  //                             border: Border.all(
                  //                               color:Theme.of(context).appBarTheme.color,
                  //                             ),
                  //                           ),
                  //                           child: Text(
                  //                             'VC',
                  //                             style: TextStyle(
                  //                               fontSize:10,
                  //                               color: Theme.of(context).appBarTheme.color,
                  //                               fontWeight: FontWeight.bold,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         SizedBox(
                  //                             width:5
                  //                         ),
                  //                         Text(
                  //                           '${getVice(data.team.id.toString())==''?'':getVice(data.team.id.toString()).title}',
                  //                           style: TextStyle(
                  //                             fontSize: 13,
                  //                             color: Colors.black,
                  //
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: 3,
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
              ),
            ),
          );
  }

  List<ContestJoined> getList() {
    List<ContestJoined> list = new List<ContestJoined>();
    for (var i in ConstanceData.specific_contests) {
      if (i.user_id != null) {
        if (i.user_id.toString() == ConstanceData.prof.id.toString()) {
          list.add(i);
        }
      }
    }
    return list;
  }

  void fetchUserContest() {
    // showLoaderDialog(context);
    access_network()
        .user_contest_list(ConstanceData.prof.id.toString())
        .then((value) {
      try {
        setState(() {
          ConstanceData.setMyContests(value);
        });
      } catch (e) {
        print(e);
      }
      // Navigator.pop(context);
    });
    access_network()
        .user_contest_by_list(ConstanceData.prof.id.toString(),
            widget.list[widget.index].match_id.toString())
        .then((value) {
      ConstanceData.setSpecific_contests(value);
    });
  }

  // List<players> getTeamA(ContestJoined data) {
  //   List<players> list = new List<players>();
  //   for (var i in data.team.team_A.toString().split(',')) {
  //     for (var j in ConstanceData.teamCombine) {
  //       if (i == j.pid.toString()) {
  //         list.add(j);
  //       }
  //     }
  //   }
  //   return list;
  // }
  //
  // List<players> getTeamB(ContestJoined data) {
  //   List<players> list = new List<players>();
  //   for (var i in data.team.team_B.toString().split(',')) {
  //     for (var j in ConstanceData.teamCombine) {
  //       if (i.trim() == j.pid.toString()) {
  //         list.add(j);
  //       }
  //     }
  //   }
  //   print('lebntg ${data.team.match_id} ${data.team.match_id} ${data.team.team_B.toString()} ${list.length}');
  //   return list;
  // }
  showLoaderDialog(BuildContext context) {
    alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // getCap(teamId) {
  //   try {
  //     int count=0;
  //     for(int i =0;i<widget.dataTeams.length; i++){
  //       if(widget.dataTeams[i].id.toString()==teamId){
  //         count = i;
  //       }
  //     }
  //     var current = widget.dataTeams[count];
  //     var capId = current.team_B.toString().split(',')[0];
  //
  //     for (var p in ConstanceData.teamCombine) {
  //       if (capId.toString() == p.pid.toString()) {
  //
  //         return p;
  //       }
  //     }
  //   } catch (e) {
  //
  //     print(e);
  //     return '';
  //   }
  // }
  // getVice(teamId) {
  //   try {
  //     int count=0;
  //     for(int i =0;i<widget.dataTeams.length; i++){
  //       if(widget.dataTeams[i].id.toString()==teamId){
  //         count = i;
  //       }
  //     }
  //     var current =widget.dataTeams[count];
  //     var viceId = current.team_B.toString().split(',')[1];
  //     for (var p in ConstanceData.teamCombine) {
  //       if (viceId.toString() == p.pid.toString()) {
  //         return p;
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //     return '';
  //   }
  // }
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

  List<players> getTeamA(count) {
    List<players> list = new List<players>();
    for (var i in widget.dataTeams[count].team_A.toString().split(',')) {
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
    for (var i in widget.dataTeams[count].team_A.toString().split(',')) {
      for (var j in ConstanceData.teamCombine_points) {
        if (i == j.pid.toString()) {
          if (i == widget.dataTeams[count].team_B.toString().split(',')[0]) {
            totalpoint += (double.parse(j.point.toString()) * 2);
          } else if (i ==
              widget.dataTeams[count].team_B.toString().split(',')[1]) {
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
    for (var i in widget.dataTeams[count].team_B.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString()) {
          list.add(j);
        }
      }
    }
    return list;
  }
  team_names(List<GetTeam_2> id) {
    var list= '';
    for(int j = 0 ; j < id.length ; j++){
      for (int i = 0; i < widget.dataTeams.length; i++) {
        if (id[j].id == widget.dataTeams[i].id) {
          if(j==0){
            list = 'T${i + 1},';
          }else{
            list = list + 'T${i + 1},';
          }
        }
      }
    }
    try {
      return list.substring(list.length-1)==','?list.substring(0,list.length-1):list;
    } catch (e) {
      print(e);
      return 'T0';
    }
  }
  findIndex(String id) {
    for (int i = 0; i < widget.dataTeams.length; i++) {
      if (id == widget.dataTeams[i].id) {
        return i + 1;
      }
    }
    return 0;
  }

  getCategoryName(category_id) {
    switch (category_id) {
      case 0:
        return 'Discounted';
      case 1:
        return 'MEGA';
      case 2:
        return 'Head to Head';
      case 3:
        return 'Beginners';
      case 4:
        return 'Low Entry';
      default:
        return 'High Reward';
    }
  }

  short_the_name(title) {
    try {
      var txt = title.toString().split(' ');
      return '${txt[0].substring(0, 1)}. ${txt[1]}';
    } catch (e) {
      print(e);
      return title;
    }
  }

  checkUserWinning(
      List<leaderboard_outside> leaderboardoutside, ContestJoined data) {
    for (var i in leaderboardoutside) {
      if (i.user_id == ConstanceData.prof.id.toString()) {
        if (int.parse(i.rank.toString()) <= data.number_of_winners) {
          return "Winning zone";
        }
      }
    }
    return "";
  }

  getVice(teamId) {
    try {
      int count = 0;
      for (int i = 0; i < widget.dataTeams.length; i++) {
        if (widget.dataTeams[i].id.toString() == teamId) {
          count = i;
        }
      }
      var current = widget.dataTeams[count];
      var viceId = current.team_B.toString().split(',')[1];
      for (var p in ConstanceData.teamCombine) {
        if (viceId.toString() == p.pid.toString()) {
          return p;
        }
      }
    } catch (e) {
      print(e);
      return '';
    }
  }

  getCap(teamId) {
    try {
      int count = 0;
      for (int i = 0; i < widget.dataTeams.length; i++) {
        if (widget.dataTeams[i].id.toString() == teamId) {
          count = i;
        }
      }
      var current = widget.dataTeams[count];
      var capId = current.team_B.toString().split(',')[0];

      for (var p in ConstanceData.teamCombine) {
        if (capId.toString() == p.pid.toString()) {
          return p;
        }
      }
    } catch (e) {
      print(e);
      return '';
    }
  }
}
