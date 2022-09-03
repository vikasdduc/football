import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/main.dart';
import 'package:fantacySports/modules/home/drawer/inviteFriend.dart/inviteFriend.dart';
import 'package:fantacySports/modules/home/drawer/more/helpdesk.dart';
import 'package:fantacySports/modules/home/drawer/mybalance/myBalance.dart';
import 'package:fantacySports/modules/home/drawer/offer.dart';
import 'package:fantacySports/modules/home/drawer/profile/pointSystem/pointSystem.dart';
import 'package:fantacySports/modules/home/drawer/profile/tournamentLeaderboard.dart';
import 'package:fantacySports/modules/home/drawer/setting.dart';
import 'package:fantacySports/modules/navigationBar/feed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Networking/AccessNetwork.dart';
import '../../navigationBar/group.dart';
import 'more/ContactUs.dart';
import 'more/more.dart';
import 'profile/profile.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  PackageInfo packageInfo;
  AlertDialog alert;

  @override
  void initState() {
    super.initState();
    setPackage();
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 1.2,
        color: Theme.of(context).appBarTheme.color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: Theme.of(context).primaryColor,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
              child: Container(
                height: 80,
                color: Theme.of(context).appBarTheme.color.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            // backgroundImage: auth.currentUser !=
                            //     null &&
                            //     auth.currentUser.photoURL != null
                            //     ? NetworkImage(
                            //     auth.currentUser.photoURL)
                            //     : AssetImage(
                            //   ConstanceData.palyerProfilePic,
                            // ),
                            backgroundImage:ConstanceData.prof==null||ConstanceData.prof.profile_image==null?AssetImage(
                              ConstanceData.palyerProfilePic,
                            ):NetworkImage(
                              'https://theapnateam.com/admin/public/document/user/${ConstanceData.prof.profile_image}',
                            ),
                          ),
                          InkWell(
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor:
                                  Theme.of(context).appBarTheme.color,
                              child: Icon(
                                Icons.camera_alt,
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                                size: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(
                                '${ConstanceData.prof == null ? ConstanceData.id.toString() : ConstanceData.prof.name}'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6,
                                      fontSize: 12,
                                    ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            AppLocalizations.of('${ConstanceData.prof.user_level==null?'Level 0':ConstanceData.prof.user_level}'),
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                      letterSpacing: 0.6,
                                      fontSize: 12,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).appBarTheme.color.withOpacity(0.7),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        customRow(
                          AppLocalizations.of('My Balance'),
                          Icons.wallet_giftcard,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyBalancePage(),
                              ),
                            );
                          },
                        ),
                        // SizedBox(
                        //   height: 25,
                        // ),
                        // customRow(
                        //   AppLocalizations.of('Invite Friends'),
                        //   Icons.inbox,
                        //   () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => InviteFriendPage(),
                        //       ),
                        //     );
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 25,
                        // ),
                        // customRow(
                        //   AppLocalizations.of('Find People'),
                        //   Icons.search,
                        //   () {},
                        // ),
                        SizedBox(
                          height: 40,
                        ),
                        customRow(
                          AppLocalizations.of('Feed'),
                          FontAwesomeIcons.images,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedPage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        customRow(
                          AppLocalizations.of('My Coupons'),
                          Icons.wallet_giftcard,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OfferScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        customRow(
                          AppLocalizations.of('Fantancy Points System'),
                          Icons.gamepad,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PointSystemPage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        customRow(
                          AppLocalizations.of('Series Leaderboard'),
                          Icons.wallet_giftcard,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TournamentLeaderBoardPage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        customRow(
                          AppLocalizations.of('My Info & Settings'),
                          Icons.settings,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingPage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        customRow(
                          AppLocalizations.of('More'),
                          Icons.more,
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => more(),
                                  ),
                                );
                          },
                        ),
                        // SizedBox(
                        //   height: 40,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20, right: 20),
                        //   child: InkWell(
                        //     onTap: (){
                        //       showLoaderDialog(context);
                        //       access_network().check_app_version(packageInfo.version).then(
                        //           (_){
                        //             if(_){
                        //               Navigator.pop(context);
                        //               showDialog(
                        //                 context: context,
                        //                 builder: (BuildContext context) {
                        //                   return new AlertDialog(
                        //                     title: new Text('No newer version available'),
                        //                     content: new Text('Latest version is already installed'),
                        //                     actions: <Widget>[
                        //                       new FlatButton(
                        //                         onPressed: () {
                        //                           Navigator.of(context).pop(false);
                        //                         },
                        //                         child: new Text('Close'),
                        //                       ),
                        //                     ],
                        //                   );
                        //                 },
                        //               ).whenComplete(() => Future.value(false));
                        //             }else{
                        //               Navigator.pop(context);
                        //               showDialog(
                        //                 context: context,
                        //                 builder: (BuildContext context) {
                        //                   return new AlertDialog(
                        //                     title: new Text('There is a new version available'),
                        //                     content: new Text('Please upgrade to the latest version'),
                        //                     actions: <Widget>[
                        //                       new FlatButton(
                        //                         onPressed: () {
                        //                           Navigator.of(context).pop(false);
                        //                           _launchURL('https://apnateam.co.in');
                        //                         },
                        //                         child: new Text('Download'),
                        //                       ),
                        //                       new FlatButton(
                        //                         onPressed: () {
                        //                           Navigator.of(context).pop(false);
                        //                         },
                        //                         child: new Text('Close'),
                        //                       ),
                        //                     ],
                        //                   );
                        //                 },
                        //               ).whenComplete(() => Future.value(false));
                        //             }
                        //           }
                        //       );
                        //     },
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Icon(
                        //           Icons.update,
                        //           color: Colors.red,
                        //         ),
                        //         SizedBox(
                        //           width: 20,
                        //         ),
                        //         Text(
                        //           'Update',
                        //           style: Theme.of(context).textTheme.bodyText2.copyWith(
                        //             color: Colors.red,
                        //             fontWeight: FontWeight.bold,
                        //             letterSpacing: 0.6,
                        //             fontSize: 13,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: InkWell(
                            onTap: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              try {
                                await preferences.clear().then((value) => {
                                                                    ConstanceData.transactions.clear(),
                                                                    Navigator.pushReplacementNamed(
                                                                        context, Routes.HOST)
                                                                  });
                              } catch (e) {
                                print(e);
                                ConstanceData.transactions.clear();
                              Navigator.pushReplacementNamed(
                              context, Routes.HOST);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/logout.png',
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .color),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Logout',
                                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.6,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),

                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        customRow(
                          AppLocalizations.of('Contact Us'),
                          Icons.wallet_giftcard,
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactUs(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customRow(String txt, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.grey.shade700,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              txt,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    fontSize: 13,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  openShowPopupLanguage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                AppLocalizations.of(
                    AppLocalizations.of('Select  your Language')),
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline6.color,
                      fontSize: 18,
                    ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('en');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of('English'),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('fr');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of('French'),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('ar');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of('Arabic'),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
                SizedBox(
                  height: 8,
                ),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectLanguage('ja');
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of('Japanese'),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  selectLanguage(String languageCode) {
    constance.locale = languageCode;
    MyApp.setCustomeLanguage(context, languageCode);
  }

  int light = 1;
  int dark = 2;
  bool selectFirstColor = false;
  bool selectSecondColor = false;
  bool selectThirdColor = false;
  bool selectFourthColor = false;
  bool selectFifthColor = false;
  bool selectSixthColor = false;

  changeColor(BuildContext context, int color) {
    if (color == light) {
      MyApp.setCustomeTheme(context, 6);
    } else {
      MyApp.setCustomeTheme(context, 7);
    }
  }

  openShowPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Select theme mode',
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline6.color,
                      fontSize: 18,
                    ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        changeColor(context, light);
                      },
                      child: CircleAvatar(
                        radius: 34,
                        backgroundColor:
                            Theme.of(context).textTheme.headline6.color,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 32,
                          child: Text(
                            AppLocalizations.of('Light'),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        changeColor(context, dark);
                      },
                      child: CircleAvatar(
                        radius: 34,
                        backgroundColor:
                            Theme.of(context).textTheme.headline6.color,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 32,
                          child: Text(
                            AppLocalizations.of('Dark'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectfirstColor(context);
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFFEB1165),
                        child: !selectFirstColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor:
                                    Theme.of(context).appBarTheme.color,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectsecondColor(context);
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFF32a852),
                        child: selectSecondColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor:
                                    Theme.of(context).appBarTheme.color,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectthirdColor(context);
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFFe6230e),
                        child: selectThirdColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor:
                                    Theme.of(context).appBarTheme.color,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectfourthColor(context);
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFF760ee6),
                        child: selectFourthColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor:
                                    Theme.of(context).appBarTheme.color,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectfifthColor(context);
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFF008080),
                        child: selectFifthColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor:
                                    Theme.of(context).appBarTheme.color,
                              )
                            : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        selectsixthColor(context);
                      },
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Color(0xFF4FBE9F),
                        child: selectSixthColor
                            ? CircleAvatar(
                                radius: 6,
                                backgroundColor:
                                    Theme.of(context).appBarTheme.color,
                              )
                            : SizedBox(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  selectfirstColor(BuildContext context) {
    if (selectFirstColor) {
      selectFirstColor = false;
      selectSecondColor = false;
      selectThirdColor = false;
      selectFourthColor = false;
      selectFifthColor = false;
      selectSixthColor = false;

      MyApp.setCustomeTheme(context, 0);
    }
  }

  selectsecondColor(BuildContext context) {
    if (!selectSecondColor) {
      selectFirstColor = true;
      selectSecondColor = true;
      selectThirdColor = false;
      selectFourthColor = false;
      selectFifthColor = false;
      selectSixthColor = false;

      MyApp.setCustomeTheme(context, 1);
    }
  }

  selectthirdColor(BuildContext context) {
    if (!selectThirdColor) {
      selectFirstColor = true;
      selectSecondColor = false;
      selectThirdColor = true;
      selectFourthColor = false;
      selectFifthColor = false;
      selectSixthColor = false;
    }
    MyApp.setCustomeTheme(context, 2);
  }

  selectfourthColor(BuildContext context) {
    if (!selectFourthColor) {
      selectFirstColor = true;
      selectSecondColor = false;
      selectThirdColor = false;
      selectFourthColor = true;
      selectFifthColor = false;
      selectSixthColor = false;
    }
    MyApp.setCustomeTheme(context, 3);
  }

  selectfifthColor(BuildContext context) {
    if (!selectFifthColor) {
      selectFirstColor = true;
      selectSecondColor = false;
      selectThirdColor = false;
      selectFourthColor = false;
      selectFifthColor = true;
      selectSixthColor = false;
    }
    MyApp.setCustomeTheme(context, 4);
  }

  selectsixthColor(BuildContext context) {
    if (!selectSixthColor) {
      selectFirstColor = true;
      selectSecondColor = false;
      selectThirdColor = false;
      selectFourthColor = false;
      selectFifthColor = false;
      selectSixthColor = true;
    }
    MyApp.setCustomeTheme(context, 5);
  }

  void _launchURL(url) async {
    if (!await launch(url))
      throw 'Could not launch ${url}';
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

  void setPackage() async{
    packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo.version);
  }
}
