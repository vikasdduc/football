import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/Profile.dart';
import 'package:fantacySports/Model/Transaction.dart';
import 'package:fantacySports/Networking/AccessNetwork.dart';
import 'package:fantacySports/constance/Fragments.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fragment_navigate/navigate-control.dart';
import 'package:new_version/new_version.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../Model/Date_transaction.dart';
import '../../main.dart';
import '../matchDetail/contestDetail/addCash.dart';
import 'drawer/drawer.dart';
import 'drawer/profile/notification.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  HomeScreen createState() => HomeScreen();
}

class HomeScreen extends State<Home> {

  FragNavigate _fragNav;
  final IsSelect objIsSelect = new IsSelect();
  int pageNumber = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController _textFieldController =
      new TextEditingController();
  final TextEditingController _textFieldController1 =
      new TextEditingController();
  final TextEditingController _textFieldController2 =
      new TextEditingController();
  AlertDialog alert;
  bool data = false;
  final newVersion = NewVersion();

  @override
  void dispose() {
    // _unbindBackgroundIsolate();
    _textFieldController.dispose();
    _textFieldController1.dispose();
    _textFieldController2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // FlutterDownloader.registerCallback((st,stats,int){
    //   print('');
    // }, step: 1);
    super.initState();
    // _bindBackgroundIsolate();



    // _loading = true;
    // _permissionReady = false;
    //
    // _prepare();
    _fragNav = FragNavigate(
      firstKey: 'Home',
      drawerContext: null,
      screens: Fragments.screens,
    );

    new Future.delayed(Duration.zero, () {
      checkVersion();
      _fragNav.setDrawerContext = context;
      Fragments.fragNav = _fragNav;

      if (ConstanceData.prof == null) {
        access_network().kyc_get().then((value) => {
              value['message'] == 'Token is Expired'
                  ? logout()
                  : print('valid'),
              ConstanceData.setProfile(Profile.fromJson(value['Get_Kyc_data'])),
              // access_network()
              //     .TransactionHistory(value['Get_Kyc_data']['id'].toString())
              //     .then((value) => {
              //           if (value != null && value.length > 0)
              //             {
              //               if (mounted)
              //                 {
              //                   setState(() {
              //                     ConstanceData.setTransactions(value);
              //                   })
              //                 }
              //               else
              //                 {ConstanceData.setTransactions(value)}
              //             }
              //           else
              //             {
              //               if (mounted)
              //                 {
              //                   setState(() {
              //                     ConstanceData.setTransactions(
              //                         new List<date_transaction>());
              //                     fetchMatches();
              //                   })
              //                 }
              //               else
              //                 {
              //                   ConstanceData.setTransactions(
              //                   new List<date_transaction>()),
              //                   fetchMatches()
              //                 }
              //             }
              //         })
            });
      } else {
        // access_network()
        //     .TransactionHistory(ConstanceData.prof.id.toString())
        //     .then((value) => {
        //           if (value != null && value.length > 0)
        //             {
        //               if (mounted)
        //                 {
        //                   setState(() {
        //                     ConstanceData.setTransactions(
        //                         new List<date_transaction>());
        //                     fetchMatches();
        //                   })
        //                 }
        //               else
        //                 {
        //                   ConstanceData.setTransactions(
        //                   new List<date_transaction>()),
        //                   fetchMatches()
        //                 }
        //             }
        //         });
      }
      try {
        fetchuser_play_history();
      } catch (e) {
        print(e);
      }
      // print(ConstanceData.prof.name);
    });
  }

  void fetchMatches() {
    try {
      // access_network().getTeam().then((value) => {
      //       print(' cqqd ${value}'),
      //       setValues(value),
      //     });
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
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_fragNav.stack.length > 1) {
          _fragNav.jumpBack();
          return Future.value(false);
        }
        show();
      },
      child: StreamBuilder<FullPosit>(
          stream: _fragNav.outStreamFragment,
          builder: (con, s) {
            if (s.data != null) {
              return Scaffold(
                key: _fragNav.drawerKey,
                appBar: AppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  leading: Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        InkWell(
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            // backgroundImage: auth.currentUser != null &&
                            //         auth.currentUser.photoURL != null
                            //     ? NetworkImage(auth.currentUser.photoURL)
                            //     : AssetImage(
                            //         ConstanceData.palyerProfilePic,
                            //       ),
                            backgroundImage: ConstanceData.prof == null ||
                                    ConstanceData.prof.profile_image == null
                                ? AssetImage(
                                    ConstanceData.palyerProfilePic,
                                  )
                                : NetworkImage(
                                    'https://theapnateam.com/admin/public/document/user/${ConstanceData.prof.profile_image}',
                                  ),
                          ),
                          onTap: () {
                            setState(() {
                              // xOffset = 230;
                              // yOffset = 150;
                              // scaleFactor = 0.6;
                              // isDrawerOpen = true;
                              Fragments.fragNav.drawerKey.currentState
                                  .openDrawer();
                            });
                          },
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              // xOffset = 230;
                              // yOffset = 150;
                              // scaleFactor = 0.6;
                              // isDrawerOpen = true;
                              Fragments.fragNav.drawerKey.currentState
                                  .openDrawer();
                            });
                          },
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.sort,
                              size: 15,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  centerTitle: s.data.title == 'Apna Team' ? true : false,
                  title: Text(
                    s.data.title,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.white,
                          fontWeight: s.data.title == 'Apna Team'
                              ? FontWeight.bold
                              : FontWeight.normal,
                          letterSpacing: 0.6,
                          fontFamily: 'verdana',
                          fontSize: s.data.title == 'Apna Team' ? 22 : 18,
                        ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationPage(),
                            ),
                          );
                        },
                        child: ConstanceData.notifications == null ||
                                ConstanceData.notifications.length == 0
                            ? Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                                size: 18,
                              )
                            : Badge(
                                badgeColor: Colors.yellow,
                                badgeContent: Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 6,
                                  ),
                                ),
                                position: BadgePosition(
                                  bottom: 30,
                                  start: 12,
                                ),
                                child: Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isDismissible: false,
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            AppLocalizations.of(
                                                'Total Balance'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                  color: Colors.black54,
                                                  letterSpacing: 0.6,
                                                  fontSize: 14,
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            "₹${ConstanceData.prof.balance == null ? 0 : ConstanceData.prof.balance}",
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
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddCashPage(),
                                              ),
                                            );
                                          },
                                          child: Center(
                                            child: Container(
                                              height: 30,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                color: Color(0xff317E2F),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  AppLocalizations.of(
                                                      'Add cash'),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption
                                                      .copyWith(
                                                        color: Colors.white,
                                                        letterSpacing: 0.6,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          indent: 14,
                                          endIndent: 14,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Center(
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black12,
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.wallet,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                drawer: DrawerScreen(),
                body: DefaultTabController(
                  length: s.data.bottom.length,
                  child: ScreenNavigate(
                    child: s.data.fragment,
                    control: _fragNav,
                  ),
                ),
                floatingActionButton: SizedBox(
                  // height: 55.0,
                  // width: 55.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: null,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset(
                          'assets/images/logo-red.webp',
                          scale: 3,
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.miniCenterDocked,
                bottomNavigationBar: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  notchMargin: 10,
                  child: Container(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          BottomAppBarWidget(
                            icon: Icon(
                              FontAwesomeIcons.home,
                              size: 18,
                              color: pageNumber == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade500,
                            ),
                            text: AppLocalizations.of('Home'),
                            ontap: () {
                              setState(() {
                                pageNumber = 0;
                              });
                              _fragNav.putPosit(key: "Home");
                            },
                            color: pageNumber == 0
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade500,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: BottomAppBarWidget(
                              icon: Icon(
                                FontAwesomeIcons.basketballBall,
                                size: 18,
                                color: pageNumber == 1
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey.shade500,
                              ),
                              text: AppLocalizations.of('My Matches'),
                              ontap: () {
                                setState(() {
                                  pageNumber = 1;
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => MyMatchesPage(),
                                //   ),
                                // );
                                _fragNav.putPosit(key: "Matches");
                              },
                              color: pageNumber == 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade500,
                            ),
                          ),
                          BottomAppBarWidget(
                            icon: Icon(
                              FontAwesomeIcons.award,
                              size: 20,
                              color: pageNumber == 2
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade500,
                            ),
                            text: AppLocalizations.of('Winners'),
                            ontap: () {
                              setState(() {
                                pageNumber = 2;
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => WinnerPage(),
                              //   ),
                              // );
                              _fragNav.putPosit(key: "Winners");
                            },
                            color: pageNumber == 2
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade500,
                          ),
                          // BottomAppBarWidget(
                          //   icon: Icon(
                          //     FontAwesomeIcons.layerGroup,
                          //     size: 22,
                          //     color: objIsSelect.group ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                          //   ),
                          //   text: AppLocalizations.of('Groups'),
                          //   ontap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => GroupPage(),
                          //       ),
                          //     );
                          //   },
                          //   color: objIsSelect.group ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                          // ),
                          BottomAppBarWidget(
                            icon: Icon(
                              FontAwesomeIcons.sms,
                              size: 18,
                              color: pageNumber == 3
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade500,
                            ),
                            text: AppLocalizations.of('Contact Us'),
                            ontap: () {
                              setState(() {
                                pageNumber = 3;
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => FeedPage(),
                              //   ),
                              // );
                              _fragNav.putPosit(key: "Chat");
                            },
                            color: pageNumber == 3
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          }),
    );
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
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
            Icon(icon, color: Theme.of(context).textTheme.headline6.color),
            SizedBox(
              width: 20,
            ),
            Text(
              txt,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Theme.of(context).textTheme.headline6.color,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  show() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: new Text('No'),
            ),
            new FlatButton(
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: new Text('Yes'),
            ),
          ],
        );
      },
    ).whenComplete(() => Future.value(false));
    return Future.delayed(Duration(seconds: 3), () {
      return Future.value(false);
    });
  }

  dont() {}

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

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  void resetPass() {
    AuthCredential credential = EmailAuthProvider.credential(
        email: _textFieldController.text, password: _textFieldController1.text);
    auth.currentUser
        .reauthenticateWithCredential(credential)
        .then((value) => {
              auth.currentUser
                  .updatePassword(_textFieldController2.text)
                  .then((value) => {updatePassword()})
                  .onError((error, stackTrace) {
                Navigator.pop(context);
                print('1 $error');
                Fluttertoast.showToast(
                    msg: "1 $error",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              })
            })
        .onError((error, stackTrace) {
      Navigator.pop(context);
      print('2 $error');
      Fluttertoast.showToast(
          msg:
              "There is no user record corresponding to this identifier. The user may have been deleted.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushReplacementNamed(context, Routes.HOST);
    });
  }

  updatePassword() async {
    // access_network()
    //     .resetPassword(PasswordFormat(ConstanceData.id.toString(),
    //         _textFieldController1.text, _textFieldController2.text))
    //     .then((value) => {Navigator.pop(context), Navigator.pop(context)});
  }

  void fetchuser_play_history() {
    access_network()
        .user_play_history(ConstanceData.prof.id.toString())
        .then((value) => {
              ConstanceData.setLeader(value),
            });
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

  void checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    access_network().check_app_version(packageInfo.version).then((_) {
      if (_.status) {
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text('There is a new version available'),
              content: new Text('Please upgrade to the latest version'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    // _launchURL('https://theapnateam.com/');
                    // downloadBook(_.link,'ApnaTime');
                    requestDownload(_.link,'ApnaTime');
                  },
                  child: new Text('Download'),
                ),
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: new Text('Close'),
                ),
              ],
            );
          },
        ).whenComplete(() => Future.value(false));
      }
    });
  }

  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch ${url}';
  }
  Future<void> requestDownload(String _url, String _name) async {
    final dir =
    await getApplicationDocumentsDirectory();
//From path_provider package
    var _localPath = dir.path + _name;
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      try {
        String _taskid = await FlutterDownloader.enqueue(
                url: _url,
                fileName: _name,
                savedDir: _localPath,
                showNotification: true,
                openFileFromNotification: true,
                saveInPublicStorage: true,
              );
        print(_taskid);

      } catch (e) {
        print(e);
      }
    });
  }
  downloadBook(String downloadLink, String title) async {
    //
    // final taskId = await FlutterDownloader.enqueue(
    //   url: downloadLink,
    //   savedDir: filePath,
    //   showNotification: true, // show download progress in status bar (for Android)
    //   openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    // );
    // FlutterDownloader.open(taskId: taskId);
    showLoaderDialog(context);
    var dio;
    final downloadPath = '/storage/emulated/0/Download';
    var filePath = downloadPath + '/$title.apk';

    dio = Dio();
    print('DONW ${downloadLink}');
    try {
      Response response = await dio.download(downloadLink, filePath);
      if(response.statusCode==200||response.statusCode==201){
        print('Download Successful}');
        Fluttertoast.showToast(
            msg: "Download Successful", timeInSecForIosWeb: 1);
        Navigator.pop(context);
      }else{
        print('Download Failed ${response.statusCode}');
        Fluttertoast.showToast(
            msg: "Download failed", timeInSecForIosWeb: 1);
        // Navigation.instance.goBack();
        Navigator.pop(context);
      }
    } on DioError catch (e) {
      print('Download failed ${e.response}');
      Fluttertoast.showToast(
          msg: "Download failed", timeInSecForIosWeb: 1);
      // Navigation.instance.goBack();
      Navigator.pop(context);
    }
  }
}

class IsSelect {
  bool home;
  bool match;
  bool win;
  bool group;
  bool feed;

  IsSelect({
    this.home = true,
    this.match = false,
    this.win = false,
    this.group = false,
    this.feed = false,
  });
}

class BottomAppBarWidget extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback ontap;
  final Color color;

  const BottomAppBarWidget(
      {Key key, this.icon, this.text, this.ontap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
