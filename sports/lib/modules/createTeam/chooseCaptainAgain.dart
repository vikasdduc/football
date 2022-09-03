import 'package:fantacySports/modules/createTeam/teamPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Language/appLocalizations.dart';
import '../../Model/CreateTeam.dart';
import '../../Model/Players.dart';
import '../../Model/player_point.dart';
import '../../Networking/AccessNetwork.dart';
import '../../constance/constance.dart';

class ChooseCaptainAgainPage extends StatefulWidget {
  final List<players> list;
  final time,teama,teamb,match_id,cid;

  var id;

  ChooseCaptainAgainPage(this.list, this.time, this.id,this.teama,this.teamb, this.match_id,this.cid);

  @override
  _ChooseCaptainPageState createState() => _ChooseCaptainPageState();
}

class _ChooseCaptainPageState extends State<ChooseCaptainAgainPage> {
  int cap, vc;
  List<player_point> Pointlist = new List<player_point>();
  AlertDialog alert;
  @override
  void initState() {
    super.initState();
    fetchPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).padding.top,
                color: Theme.of(context).primaryColor,
              ),
              Container(
                height: AppBar().preferredSize.height,
                color: Theme.of(context).primaryColor,
                child: appBar(),
              ),
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).disabledColor.withOpacity(0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(
                          'Choose your Captain and Vice Captain'),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Theme.of(context).textTheme.headline6.color,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.6,
                            fontSize: 14,
                          ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalizations.of(
                          'C gets 2x points, VC gets 1.5x points'),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Theme.of(context).textTheme.bodyText2.color,
                            letterSpacing: 0.6,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                color: Theme.of(context).disabledColor.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of('Type'),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText2.color,
                              letterSpacing: 0.6,
                              fontSize: 12,
                            ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        AppLocalizations.of('Points'),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText2.color,
                              letterSpacing: 0.6,
                              fontSize: 12,
                            ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        AppLocalizations.of('% C By'),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText2.color,
                              letterSpacing: 0.6,
                              fontSize: 12,
                            ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        AppLocalizations.of('% VC By'),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText2.color,
                              letterSpacing: 0.6,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: widget.list.length <= 0
                    ? getDef()
                    : ListView.builder(
                  padding: EdgeInsets.all(0.0),
                        itemCount: widget.list.length,
                        shrinkWrap: true,
                        itemBuilder: (cont, index) {
                          var data = widget.list[index];
                          return cardView(
                            AppLocalizations.of('${whichTeam(data.pid)=='a'?widget.teama:widget.teamb}'),
                            "${data.playing_role}",
                            AppLocalizations.of('${data.title}'),
                            "${getPoint(data.pid)}",
                            "C",
                            "${getCap(data.pid)}%",
                            "VC",
                            "${getVcCap(data.pid)}%",
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Image.asset(
                                'assets/images/${data.title.toString().trim().toLowerCase()}.webp',
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context, Object exception,
                                    StackTrace stackTrace) {
                                  return Image.asset(ConstanceData.defaultPlayer);
                                },
                              ),
                            ),
                            index,
                            data.pid
                          );
                        }),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeamPreViewPage(widget.list,
                          widget.list[cap].pid, widget.list[vc].pid,widget.teamb,widget.teamb),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of('Team Preview'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Color(0xffcf0100),
                                letterSpacing: 0.6,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (cap != null && vc != null) {
                    saveTeam();
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please select one captain and one vice captain'",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of('Save Team'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Theme.of(context).disabledColor,
                                letterSpacing: 0.6,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String whichTeam(pid) {
    for (var a in ConstanceData.teamA) {
      if (a.pid.toString() == pid.toString()) {
        print('a ${a.title}');
        return 'a';
      }
    }
    for (var b in ConstanceData.teamB) {
      if (b.pid.toString() == pid.toString()) {
        print('b ${b.title}');
        return 'b';
      }
    }
  }
  Widget cardView(
      String txt1,
      String txt2,
      String txt3,
      String txt4,
      String txt5,
      String txt6,
      String txt7,
      String txt8,
      Widget image1,
      int index,int pid) {
    String point = calculatePoint(txt4, index).toString();
    return Card(
      margin: EdgeInsets.all(0.25),
      child: Container(
        color: cap==index||vc==index?Color(0xffFFF4DE):Theme.of(context).disabledColor.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 20,
            top: 10,
            bottom: 10,
          ),
          child: Row(
            children: [
              SizedBox(
                height: 10,
              ),
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                    ),
                    child: image1,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color:whichTeam(pid) == 'a'
                              ? Colors.black
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2),
                            bottomLeft: Radius.circular(2),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            txt1,
                            style:
                            Theme.of(context).textTheme.bodyText2.copyWith(
                              color:whichTeam(pid) == 'a'
                                  ? Colors.white
                                  : Colors.black,
                              letterSpacing: 0.6,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffD0C1AB),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(2),
                            bottomRight: Radius.circular(2),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            txt2,
                            style:
                            Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .color,
                              letterSpacing: 0.6,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      short_the_name(txt3),
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Theme.of(context).textTheme.headline6.color,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      point,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Theme.of(context).textTheme.bodyText2.color,
                        letterSpacing: 0.6,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
               SizedBox(
                 width: 55,
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (vc == null || vc != index) {
                          setState(() {
                            cap = index;
                            // point = calculatePoint(txt4, index).toString();
                            // print(
                            //     'point ${calculatePoint(txt4, index).toString()}');
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Same player can't be both'",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: cap != null && cap == index
                              ? Colors.black
                              : Theme.of(context).disabledColor.withOpacity(0.1),
                          border: Border.all(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .color
                                .withOpacity(0.1),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            cap != null && cap == index?'x2':txt5,
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: cap != null && cap == index
                                  ? Colors.white
                                  : Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .color,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      txt6,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Theme.of(context).textTheme.bodyText2.color,
                        letterSpacing: 0.6,
                        fontSize: 12,
                      ),
                    ),
                  ],
              ),
               ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (cap == null || cap != index) {
                          setState(() {
                            vc = index;
                            // point = calculatePoint(txt4, index).toString();
                            // print(
                            //     'point ${calculatePoint(txt4, index).toString()}');
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Same player can't be both'",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: vc != null && vc == index
                              ? Colors.black
                              : Theme.of(context).disabledColor.withOpacity(0.1),
                          border: Border.all(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .color
                                .withOpacity(0.1),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            vc != null && vc == index?'x1.5':txt7,
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: vc != null && vc == index
                                  ? Colors.white
                                  : Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .color,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      txt8,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Theme.of(context).textTheme.bodyText2.color,
                        letterSpacing: 0.6,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  short_the_name(title) {
    try {
      var txt = title.toString().split(' ');
      return '${txt[0].substring(0,1)}. ${txt[1]}';
    } catch (e) {
      print(e);
      return title;
    }
  }
  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          Expanded(child: SizedBox()),
          CountdownTimer(
            endTime: widget.time,
            endWidget: Text(
              'Live',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff0ebd01),
                fontWeight: FontWeight.bold,
              ),
            ),
            textStyle: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.white,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
          ),
          Expanded(child: SizedBox()),
          Icon(
            Icons.help,
            color: Colors.white,
            size: 24,
          ),
        ],
      ),
    );
  }

  void saveTeam() {
    String Cap_VC = '${widget.list[cap].pid},${widget.list[vc].pid}';
    showLoaderDialog(context);
    access_network()
        .updateTeam(
          getPlayers(),
          Cap_VC,
          ConstanceData.id.toString(),
          widget.id,
        )
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "${value}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0),
              access_network().getTeam().then((value) => {
                    setValues(value),
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.pop(context),
                  }),
            });
  }

  void fetchMatches() {}

  setValues(value) {
    if (value != null && value.length != 0) {
      print('sdr');
      setState(() {
        ConstanceData.setMyList(value);
      });
    } else {
      print('ad');
    }
  }

  String getPlayers() {
    String players;
    for (int i = 0; i < widget.list.length; i++) {
      if (i == 0) {
        players = widget.list[i].pid.toString();
        players += ',';
      } else if (i == widget.list.length - 1) {
        players += widget.list[i].pid.toString();
      } else {
        players += widget.list[i].pid.toString();
        players += ',';
      }
    }
    return players;
  }

  getPoint(pid) {
    for (var i in Pointlist) {
      if (pid.toString() == i.pid.toString()) {
        return i.total_point;
      }
    }
    return null;
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

  calculatePoint(data, index) {
    if (data != 'null') {
      if (cap == index) {
        return int.parse(data);
      } else if (vc == index) {
        return int.parse(data);
      } else {
        return int.parse(data);
      }
    } else {
      return '0';
    }
  }

  getDef() {
    return Container();
  }

  getCap(pid) {
    if (ConstanceData.selby_Player_list!=null&&ConstanceData.selby_Player_list.length>=1) {
      for(var i in ConstanceData.selby_Player_list){
        if(i.player_id.toString()==pid.toString()){
          return i.caption_select_ratio.toString();
        }
      }
    }
    return '0';
  }
  void fetchPoints() async {
    print('iqw ${widget.cid.toString()}');
    access_network().player_points(widget.cid.toString()).then((_) {
      setState(() {
        print('va ');
        Pointlist = _;
      });
    });
  }
  getVcCap(int pid) {
    if (ConstanceData.selby_Player_list!=null&&ConstanceData.selby_Player_list.length>=1) {
      for(var i in ConstanceData.selby_Player_list){
        if(i.player_id.toString()==pid.toString()){
          return i.vice_caption_select_ratio.toString();
        }
      }
    }
    return '0';
  }
}
