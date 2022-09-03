import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Testing/KYC.dart';
import 'package:fantacySports/modules/home/drawer/profile/tournamentLeaderboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../Model/GetTeam.dart';
import '../../../../Model/Players.dart';
import '../../../../Model/Profile.dart';
import '../../../../Model/Recently_Played.dart';
import '../../../../Networking/AccessNetwork.dart';
import '../../../../Testing/Preview.dart';
import '../../../../constance/constance.dart';
import '../../../../main.dart';
import '../../../Live/Team_points_preview.dart';
import '../setting.dart';

class ProfilePage extends StatefulWidget {
  bool kyc = false;
  var img;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  List<recently_played> list = List<recently_played>();
  AlertDialog alert;
  final ImagePicker _picker = ImagePicker();
  XFile image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              automaticallyImplyLeading: false,
              expandedHeight: 194.0,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    SizedBox(
                      height: AppBar().preferredSize.height,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            Expanded(child: SizedBox()),
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Colors.white,
                                      backgroundImage: ConstanceData.prof ==
                                                  null ||
                                              ConstanceData
                                                      .prof.profile_image ==
                                                  null
                                          ? AssetImage(
                                              ConstanceData.palyerProfilePic,
                                            )
                                          : NetworkImage(
                                              'https://theapnateam.com/admin/public/document/user/${ConstanceData.prof.profile_image}',
                                            ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        try {
                                          image = await _picker.pickImage(
                                            source: ImageSource.gallery,
                                            imageQuality: 50,
                                          );
                                        } catch (e) {
                                          print(e);
                                        }
                                        if (image != null) {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PreviewPage(image),
                                            ),
                                          );
                                          print(result);
                                          if (result == 'Yes') {
                                            setState(() {
                                              access_network()
                                                  .send_user_image(image.path)
                                                  .then((value) => {
                                                        setState(() {
                                                          widget.img = null;
                                                          access_network()
                                                              .kyc_get()
                                                              .then((value) => {
                                                                    value['message'] ==
                                                                            'Token is Expired'
                                                                        ? logout()
                                                                        : print(
                                                                            'valid'),
                                                                    ConstanceData
                                                                        .setProfile(
                                                                            Profile.fromJson(value['Get_Kyc_data'])),
                                                                    Navigator.pop(
                                                                        context),
                                                                    Navigator.pop(
                                                                        context),
                                                                  });
                                                        })
                                                      });
                                            });
                                          } else {
                                            setState(() {
                                              widget.img = null;
                                              image = null;
                                            });
                                          }
                                        }
                                      },
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor:
                                            Theme.of(context).appBarTheme.color,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.black,
                                          size: 23,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      ConstanceData.prof.name == null
                                          ? AppLocalizations.of(
                                              'user${ConstanceData.id}')
                                          : AppLocalizations.of(
                                              '${ConstanceData.prof.name}'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Colors.white,
                                            letterSpacing: 0.6,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),
                                    // Icon(
                                    //   Icons.edit,
                                    //   color: Colors.white,
                                    //   size: 14,
                                    // )
                                  ],
                                ),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            // Icon(
                            //   Icons.share,
                            //   color: Colors.white,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of('Level'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      letterSpacing: 0.6,
                                      fontSize: 10,
                                    ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${ConstanceData.prof.user_level == null ? 0 : ConstanceData.prof.user_level.toString().split(' ')[1]}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      letterSpacing: 0.6,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                          Expanded(child: SizedBox()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of('level'),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      letterSpacing: 0.6,
                                      fontSize: 10,
                                    ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${ConstanceData.prof.user_level == null ? '1' : int.parse(ConstanceData.prof.user_level.toString().split(' ')[1]) + 1}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Colors.white,
                                      letterSpacing: 0.6,
                                      fontSize: 12,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: LinearPercentIndicator(
                        percent: 0.5,
                        progressColor: Colors.yellow,
                        backgroundColor: Theme.of(context).disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          AppLocalizations.of('Total Points'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                letterSpacing: 0.6,
                                fontSize: 12,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          AppLocalizations.of(
                              '${ConstanceData.prof.total_point}'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff317E2F),
                                letterSpacing: 0.6,
                                fontSize: 18,
                              ),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Column(
                      //       children: [
                      //         Text(
                      //           AppLocalizations.of('Play for'),
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .caption
                      //               .copyWith(
                      //                 color: Theme.of(context)
                      //                     .textTheme
                      //                     .bodyText2
                      //                     .color,
                      //                 letterSpacing: 0.6,
                      //                 fontSize: 12,
                      //               ),
                      //         ),
                      //         SizedBox(
                      //           height: 3,
                      //         ),
                      //         Text(
                      //           "₹6",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .caption
                      //               .copyWith(
                      //                 color: Theme.of(context)
                      //                     .textTheme
                      //                     .headline6
                      //                     .color,
                      //                 letterSpacing: 0.6,
                      //                 fontSize: 14,
                      //               ),
                      //         ),
                      //         SizedBox(
                      //           height: 3,
                      //         ),
                      //         Text(
                      //           AppLocalizations.of('more'),
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .caption
                      //               .copyWith(
                      //                 color: Theme.of(context)
                      //                     .textTheme
                      //                     .bodyText2
                      //                     .color,
                      //                 letterSpacing: 0.6,
                      //                 fontSize: 12,
                      //               ),
                      //         ),
                      //       ],
                      //     ),
                      //     Text(
                      //       AppLocalizations.of('OR'),
                      //       style:
                      //           Theme.of(context).textTheme.caption.copyWith(
                      //                 color: Theme.of(context)
                      //                     .textTheme
                      //                     .bodyText2
                      //                     .color,
                      //                 letterSpacing: 0.6,
                      //                 fontSize: 12,
                      //               ),
                      //     ),
                      //     Column(
                      //       children: [
                      //         Text(
                      //           AppLocalizations.of('Play for'),
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .caption
                      //               .copyWith(
                      //                 color: Theme.of(context)
                      //                     .textTheme
                      //                     .bodyText2
                      //                     .color,
                      //                 fontSize: 12,
                      //               ),
                      //         ),
                      //         SizedBox(
                      //           height: 3,
                      //         ),
                      //         Text(
                      //           "₹6",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .caption
                      //               .copyWith(
                      //                 color: Theme.of(context)
                      //                     .textTheme
                      //                     .headline6
                      //                     .color,
                      //                 letterSpacing: 0.6,
                      //                 fontSize: 14,
                      //               ),
                      //         ),
                      //         SizedBox(
                      //           height: 3,
                      //         ),
                      //         Text(
                      //           AppLocalizations.of('more'),
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .caption
                      //               .copyWith(
                      //                 color: Theme.of(context)
                      //                     .textTheme
                      //                     .bodyText2
                      //                     .color,
                      //                 letterSpacing: 0.6,
                      //                 fontSize: 12,
                      //               ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Card(
                      //   elevation: 5,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(top: 8),
                      //     child: Column(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 25),
                      //           child: Row(
                      //             children: [
                      //               Icon(
                      //                 FontAwesomeIcons.trophy,
                      //                 size: 60,
                      //                 color: Theme.of(context).primaryColor,
                      //               ),
                      //               SizedBox(
                      //                 width: 30,
                      //               ),
                      //               Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     "₹15",
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .caption
                      //                         .copyWith(
                      //                           color: Theme.of(context)
                      //                               .textTheme
                      //                               .headline6
                      //                               .color,
                      //                           letterSpacing: 0.6,
                      //                           fontSize: 22,
                      //                         ),
                      //                   ),
                      //                   Text(
                      //                     AppLocalizations.of('Cash Bonus'),
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .caption
                      //                         .copyWith(
                      //                           color: Theme.of(context)
                      //                               .textTheme
                      //                               .headline6
                      //                               .color,
                      //                           letterSpacing: 0.6,
                      //                           fontSize: 12,
                      //                         ),
                      //                   ),
                      //                   SizedBox(
                      //                     height: 2,
                      //                   ),
                      //                   Text(
                      //                     AppLocalizations.of(
                      //                         'Use this cash bonus to join paid contests\nand win.'),
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .caption
                      //                         .copyWith(
                      //                           color: Theme.of(context)
                      //                               .textTheme
                      //                               .bodyText2
                      //                               .color,
                      //                           letterSpacing: 0.6,
                      //                           fontSize: 10,
                      //                         ),
                      //                   ),
                      //                 ],
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: 30,
                      //         ),
                      //         Row(
                      //           children: [
                      //             Expanded(
                      //               flex: 1,
                      //               child: Container(
                      //                 height: 40,
                      //                 color: Color(0xffFAFAFA),
                      //                 child: Center(
                      //                   child: Text(
                      //                     AppLocalizations.of(
                      //                         'Offer Details'),
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .caption
                      //                         .copyWith(
                      //                           color: Theme.of(context)
                      //                               .primaryColor,
                      //                           letterSpacing: 0.6,
                      //                           fontSize: 12,
                      //                         ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Expanded(
                      //               flex: 3,
                      //               child: Container(
                      //                 height: 40,
                      //                 color: Color(0xffFAEDE3),
                      //                 child: Center(
                      //                   child: Row(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.center,
                      //                     children: [
                      //                       Icon(
                      //                         Icons.lock,
                      //                         color: Colors.orange,
                      //                         size: 14,
                      //                       ),
                      //                       SizedBox(
                      //                         width: 5,
                      //                       ),
                      //                       Text(
                      //                         AppLocalizations.of(
                      //                             'Unlocks at level 20'),
                      //                         style: Theme.of(context)
                      //                             .textTheme
                      //                             .caption
                      //                             .copyWith(
                      //                               color: Colors.orange,
                      //                               fontWeight:
                      //                                   FontWeight.bold,
                      //                               letterSpacing: 0.6,
                      //                               fontSize: 12,
                      //                             ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color(0xff333E91),
                        ),
                        height: 90,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Image.asset('assets/images/quality.webp'),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Earn your first award!',
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 0.6,
                                            fontSize: 16,
                                          ),
                                    ),
                                    Text(
                                      'Keep playing and earn more medals and trophies',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Colors.white,
                                            letterSpacing: 0.6,
                                            fontSize: 13,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/star.webp',
                          scale: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(12.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         Column(
                //           children: [
                //             Text(
                //               "0",
                //               style:
                //                   Theme.of(context).textTheme.caption.copyWith(
                //                         color: Colors.blue,
                //                         letterSpacing: 0.6,
                //                         fontSize: 14,
                //                       ),
                //             ),
                //             SizedBox(
                //               height: 3,
                //             ),
                //             Text(
                //               AppLocalizations.of('Followers'),
                //               style:
                //                   Theme.of(context).textTheme.caption.copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 12,
                //                       ),
                //             ),
                //           ],
                //         ),
                //         Container(
                //           height: 25,
                //           width: 1,
                //           color: Theme.of(context).disabledColor,
                //         ),
                //         Column(
                //           children: [
                //             Text(
                //               "1",
                //               style:
                //                   Theme.of(context).textTheme.caption.copyWith(
                //                         color: Colors.blue,
                //                         letterSpacing: 0.6,
                //                         fontSize: 14,
                //                       ),
                //             ),
                //             SizedBox(
                //               height: 3,
                //             ),
                //             Text(
                //               AppLocalizations.of('Following'),
                //               style:
                //                   Theme.of(context).textTheme.caption.copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 12,
                //                       ),
                //             ),
                //           ],
                //         ),
                //         Container(
                //           height: 25,
                //           width: 1,
                //           color: Theme.of(context).disabledColor,
                //         ),
                //         Column(
                //           children: [
                //             Text(
                //               "0",
                //               style:
                //                   Theme.of(context).textTheme.caption.copyWith(
                //                         color: Colors.blue,
                //                         letterSpacing: 0.6,
                //                         fontSize: 14,
                //                       ),
                //             ),
                //             SizedBox(
                //               height: 3,
                //             ),
                //             Text(
                //               AppLocalizations.of('Posts'),
                //               style:
                //                   Theme.of(context).textTheme.caption.copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 12,
                //                       ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      child: Text(
                        AppLocalizations.of('Playing History'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                              letterSpacing: 0.6,
                              fontSize: 14,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        column(
                          Icons.dock_outlined,
                          Colors.orange,
                          "${ConstanceData.leader == null ? '' : ConstanceData.leader.no_of_contests}",
                          AppLocalizations.of('Contests'),
                        ),
                        column(
                          Icons.backup_sharp,
                          Colors.blue,
                          "${ConstanceData.leader == null ? '' : ConstanceData.leader.no_of_match}",
                          AppLocalizations.of('Matches'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        column(
                          Icons.badge,
                          Colors.green,
                          "${ConstanceData.leader == null ? '' : ConstanceData.leader.no_of_series}",
                          AppLocalizations.of('Series'),
                        ),
                        column(
                          FontAwesomeIcons.trophy,
                          Colors.orange,
                          "${ConstanceData.leader == null ? '' : ConstanceData.leader.no_of_wins}",
                          AppLocalizations.of('Wins'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // Card(
                //   elevation: 2,
                //   margin: EdgeInsets.zero,
                //   child: Container(
                //     height: 50,
                //     // color: Theme.of(context).appBarTheme.color,
                //     child: Padding(
                //       padding: const EdgeInsets.only(left: 20, right: 20),
                //       child: InkWell(
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => TournamentLeaderBoardPage(),
                //             ),
                //           );
                //         },
                //         child: Row(
                //           children: [
                //             Text(
                //               AppLocalizations.of('Series Leaderboard'),
                //               style:
                //                   Theme.of(context).textTheme.caption.copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 16,
                //                       ),
                //             ),
                //             Expanded(child: SizedBox()),
                //             Icon(
                //               Icons.arrow_forward_ios,
                //               color:
                //                   Theme.of(context).textTheme.headline6.color,
                //               size: 20,
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                list.length > 0
                    ? Container(
                        padding: EdgeInsets.all(5),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Recently played matches'),
                            SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: list.reversed
                                    .toList(growable: false)
                                    .length,
                                itemBuilder: (cont, index) {
                                  var data = list.reversed
                                      .toList(growable: false)[index];

                                  return GestureDetector(
                                    onTap: () {
                                      showLoaderDialog(context);
                                      fetchRoosters(
                                          data.competition_id[0].toString(),
                                          data.match_id.toString(),
                                          data.teama_id,
                                          data.teamb_id,
                                          data,index);
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            // color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        height: 90,
                                        width: 300,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  // color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 4,
                                                            child: Container(
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      child: Image
                                                                          .network(
                                                                              data.teama_logo),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          data.teama_name,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .caption
                                                                              .copyWith(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 14,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'vs',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .caption
                                                                              .copyWith(
                                                                                color: Colors.grey.shade600,
                                                                                fontSize: 13,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          data.teamb_name,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .caption
                                                                              .copyWith(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 14,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      child: Image
                                                                          .network(
                                                                              data.teamb_logo),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              child: Center(
                                                                child: Text(
                                                                  data.status_note,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .caption
                                                                      .copyWith(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              child: Center(
                                                                child: Text(
                                                                  data.date_start,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .caption
                                                                      .copyWith(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // color: Colors.green,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              child: Center(
                                                                child: Text(
                                                                  'Highest Points',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .caption
                                                                      .copyWith(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                                // color: Colors.blue,
                                                                ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              child: Center(
                                                                child: Text(
                                                                  '${data.total_point}',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .caption
                                                                      .copyWith(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                                // color: Colors.blue,
                                                                ),
                                                          )
                                                        ],
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
                                  );
                                },
                              ),
                            )
                          ],
                        ))
                    : Container(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget column(IconData icon, Color iconColor, txt1, txt2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 30,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          txt1,
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Theme.of(context).textTheme.headline6.color,
                letterSpacing: 0.6,
                fontSize: 14,
              ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          txt2,
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Theme.of(context).textTheme.bodyText2.color,
                letterSpacing: 0.6,
                fontSize: 12,
              ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      fetchuser_play_history();
      fetchrecently_played();
    });
  }

  void fetchRoosters(
      competition_id, match_id, teama_id, teamb_id, data, index) {
    try {
      access_network().fetchFantasyPoint(match_id.toString()).then((value) => {
            setPoints(value),
            access_network()
                .fetchFantasyRoster(
                  competition_id.toString(),
                  match_id.toString(),
                  teama_id.toString(),
                  teamb_id.toString(),
                )
                .then((value) => {

                      setData(value, data, index),
                    }),
          });
    } catch (e) {
      print(e);
      try {
        // Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }
  }

  setData(value, data, index) {
    ConstanceData.addTeamA(value['a']);
    ConstanceData.addTeamB(value['b']);
    ConstanceData.setTeam(value['a'], value['b']);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => team_points_preview(
            data.teamB[0].toString().split(",")[0],
            data.teamB[0].toString().split(",")[1],
            getTeamA(index, data.teamA[0]),
            data.total_point,
            data.teama_name,
            data.teamb_name,"",data.team_id),
      ),
    );
  }

  setPoints(value) {
    ConstanceData.addTeamA_point(value['a']);
    ConstanceData.addTeamB_point(value['b']);
    ConstanceData.setTeam_point(value['a'], value['b']);
  }

  void fetchuser_play_history() {
    showLoaderDialog(context);
    try {
      access_network()
          .user_play_history(ConstanceData.prof.id.toString())
          .then((value) => {
                if (mounted)
                  {
                    setState(() {
                      ConstanceData.setLeader(value);
                    })
                  }
                else
                  {
                    setState(() {
                      ConstanceData.setLeader(value);
                    })
                  }
              });
    } catch (e) {
      print(e);
      Navigator.pop(context);
    }
  }

  void fetchrecently_played() {
    // showLoaderDialog(context);
    try {
      access_network()
          .recently_played(ConstanceData.prof.id.toString())
          .then((value) => {
                if (mounted)
                  {
                    setState(() {
                      ConstanceData.setRecently_played_list(value);
                      list = ConstanceData.recently_played_list;
                      Navigator.pop(context);
                    })
                  }
                else
                  {
                    ConstanceData.setRecently_played_list(value),
                    list = ConstanceData.recently_played_list,
                    Navigator.pop(context),
                  }
              });
    } catch (e) {
      print(e);
      // Navigator.pop(context);
    }
  }

  List<GetTeam> filterContent(List<GetTeam> mylist, competition_id, match_id) {
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

  logout() {
    ConstanceData.clear();
    try {
      ConstanceData.transactions.clear();
    } catch (e) {
      print(e);
    }
    Navigator.pushReplacementNamed(context, Routes.HOST);
  }

  List<players> getTeamA(count, data) {
    List<players> list = new List<players>();
    for (var i in data.toString().split(',')) {
      for (var j in ConstanceData.teamCombine) {
        if (i == j.pid.toString()) {
          list.add(j);
        }
      }
    }
    return list;
  }
}
