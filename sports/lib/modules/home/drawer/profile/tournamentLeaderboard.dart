import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:flutter/material.dart';

import '../../../../Model/SeriesLeaderboardItem.dart';
import '../../../../Model/seriesItem.dart';
import '../../../../Model/week.dart';
import '../../../../Model/week.dart';
import '../../../../Model/weeklyLeaderboardItem.dart';
import '../../../../Networking/AccessNetwork.dart';
import '../../../../constance/constance.dart';

class TournamentLeaderBoardPage extends StatefulWidget {
  @override
  _TournamentLeaderBoardPageState createState() =>
      _TournamentLeaderBoardPageState();
}

class _TournamentLeaderBoardPageState extends State<TournamentLeaderBoardPage> {
  bool isSeries = true;
  bool isWeekly = false;
  List<series_leaderboard_item> list = new List<series_leaderboard_item>();
  List<WeeklyLeaderboardItem> list2 = new List<WeeklyLeaderboardItem>();
  List<week> weeks = List<week>();
  SeriesItem dropdownvalue;
  SeriesItem dropdownvalue1;
  int selected=0;
  AlertDialog alert;

  // List of items in our dropdown menu
  // List<String>items=new List<String>();

  @override
  void initState() {
    super.initState();
    fetchComp();
    try {
      fetchList();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('Series Leaderboard'),
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.white,
                letterSpacing: 0.6,
            fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            color: Theme.of(context).appBarTheme.color,
            child: Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Row(
                children: [
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSeries = true;
                        isWeekly = false;
                        // list2 = new List<WeeklyLeaderboardItem>();
                        if(list==null||list.length==0){
                          try {
                            fetchList();
                          } catch (e) {
                            Navigator.pop(context);
                            print(e);
                          }
                        }
                      });
                    },
                    child: Container(
                      child: Text(
                        AppLocalizations.of('Series'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: isSeries
                                  ? Colors.black
                                  : Theme.of(context).textTheme.bodyText2.color,
                              letterSpacing: 0.6,
                              fontSize: isSeries ? 16 : 14,
                              fontWeight:
                                  isSeries ? FontWeight.bold : FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSeries = false;
                        isWeekly = true;
                        // showLoaderDialog(context);
                        // fetchListW('2022-03-27','2022-03-31');
                      });
                    },
                    child: Container(
                      child: Text(
                        AppLocalizations.of('Weekly'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: isWeekly
                                  ? Colors.black
                                  : Theme.of(context).textTheme.bodyText2.color,
                              letterSpacing: 0.6,
                              fontSize: isWeekly ? 16 : 14,
                              fontWeight:
                                  isWeekly ? FontWeight.bold : FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
          isSeries
              ? Expanded(
                child: Container(

                    child: Column(
                      children: [
                        DropdownButton(
                          isExpanded: true,
                          value: dropdownvalue,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: ConstanceData.seriesPlayed.map((SeriesItem items) {
                            return DropdownMenuItem(
                              value: items,
                              child: SizedBox(
                                  width: 500,
                                  child: Text(items.title,overflow: TextOverflow.ellipsis,)),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (SeriesItem newValue) {
                            setState(() {
                              try {
                                dropdownvalue = newValue;
                              } catch (e) {
                                print(e);
                              }
                              showLoaderDialog(context);
                              fetchList();
                              // Navigator.pop(context);
                            });
                          },
                        ),
                        Container(
                          height: 22,
                          color: Colors.orange,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of('TEAM'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Colors.white,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  AppLocalizations.of('RANK'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Colors.white,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        dropdownvalue == null
                            ? Container()
                            : Expanded(
                                child: ListView.builder(
                                    itemCount: list.length,
                                    itemBuilder: (cont, index) {
                                      var data = list[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: container(
                                          Theme.of(context).appBarTheme.color,
                                          AppLocalizations.of('${data.team_name}'),
                                          "${data.point} Points",
                                          "#${index + 1}",
                                          Icons.arrow_left,
                                          Colors.green,
                                          NetworkImage(data.image),
                                        ),
                                      );
                                    }),
                              )
                      ],
                    ),
                  ),
              )
              : Expanded(
                child: Container(

                    child: Column(
                      children: [
                        DropdownButton(
                          isExpanded: true,
                          value: dropdownvalue1,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: ConstanceData.seriesPlayed.map((SeriesItem items) {
                            return DropdownMenuItem(
                              value: items,
                              child: SizedBox(
                                  width: 500,
                                  child: Text(items.title,overflow: TextOverflow.ellipsis,),),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (SeriesItem newValue) {
                            setState(() {
                              dropdownvalue1 = newValue;
                              access_network().get_week_info(ConstanceData.prof.id.toString(),dropdownvalue1.compition_id.toString()).then((_){
                                setState(() {
                                  weeks = _;
                                  print('da ${_}');
                                });
                              });
                            });
                          },
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: ListView.builder(
                                itemCount: weeks.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (cont,index){
                                  var data = weeks[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = index;
                                        fetchListW(ConstanceData.prof.id.toString(),index.toString(),dropdownvalue1.compition_id.toString(),data.start_date.toString(),data.end_date.toString());
                                      });
                                    },
                                    child: Card(
                                      elevation: selected==index?2:4,
                                      child: Container(
                                        height: 10,
                                        width: 90,
                                        color: selected==index?Colors.grey.shade100:Colors.grey.shade300,
                                        child: Center(
                                          child: Text(
                                            'Week ${data.week_no}', style: Theme.of(context).textTheme.caption.copyWith(
                                            color: Colors.black,
                                            letterSpacing: 0.6,
                                            fontSize:16,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Card(
                            //   elevation: 4,
                            //   child: Container(
                            //     height: 50,
                            //     width: 100,
                            //     child: Center(
                            //       child: Text(
                            //           'Week 2'
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 22,
                          color: Colors.orange,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            child: Row(
                              children: [
                                Text(
                                  AppLocalizations.of('TEAM'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Colors.white,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  AppLocalizations.of('RANK'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Colors.white,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        dropdownvalue1 == null
                            ? Container()
                            : Expanded(
                          child: ListView.builder(
                              itemCount: list2.length,
                              itemBuilder: (cont, index) {
                                var data = list2[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: container(
                                    Theme.of(context).appBarTheme.color,
                                    AppLocalizations.of('${data.team_name}'),
                                    "${data.point} Points",
                                    "#${index + 1}",
                                    Icons.arrow_left,
                                    Colors.green,
                                   NetworkImage(data.image),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
              )
        ],
      ),
    );
  }

  Widget container(Color color, String txt1, String txt2, String txt3,
      IconData icon, Color iconColor,  image) {
    return Container(
      // height: AppBar().preferredSize.height,
      color: color,
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              backgroundImage: image,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    txt1,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.headline6.color,
                          // letterSpacing: 0.6,
                          fontSize: 14,
                        ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  txt2,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).textTheme.bodyText2.color,
                        // letterSpacing: 0.6,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                ),

              ],
            ),
            Expanded(child: SizedBox()),
            Text(
              txt3,
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.6,
                    fontSize: 16,
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

  void fetchList() {
    showLoaderDialog(context);
    access_network()
        .leader_board_list_series(ConstanceData.prof.id.toString(), dropdownvalue.compition_id.toString())
        .then((_) {
      setState(() {
        list = _;
        print('${ConstanceData.prof.id.toString()} ${dropdownvalue.compition_id.toString()}');
        Navigator.pop(context);
        Navigator.pop(context);
      });
    });
    // for(var i in list){
    //   items.add(i.title);
    // }
  }
  void fetchListW(String id,week,compId,start,end) {
    access_network()
        .leader_board_list_week(id,week,compId,start, end)
        .then((_) {
      setState(() {
        list2 = _;
        // Navigator.pop(context);
      });
    });
    // for(var i in list){
    //   items.add(i.title);
    // }
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

  void fetchComp()async {
    access_network().get_series_list(ConstanceData.prof.id.toString()).then(
            (_){
          setState(() {
            ConstanceData.setSeriesPlayeds(_);

          });
        }
    );

  }
}
