import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/contest.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/widget/matchDetailCardView.dart';
import 'package:flutter/material.dart';

class ContestsPage extends StatefulWidget {
  final time, title,plist,index,scrollController,teams;
  final List<Contest> list;

  ContestsPage(this.time, this.title, this.list, this.plist, this.index,this.scrollController,this.teams);

  @override
  _ContestsPageState createState() => _ContestsPageState();
}

class _ContestsPageState extends State<ContestsPage> {
  bool isLive = false;


  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: widget.list == null || widget.list.length == 0
                ? getWidget()
                : Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SingleChildScrollView(
                        controller: widget.scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            discounted(widget.list).length>0?Text(
                              'Discounted Entry',
                              key: ConstanceData.discounted,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),):Container(),
                            discounted(widget.list).length>0?SizedBox(
                              height: 5,
                            ):Container(),
                            discounted(widget.list).length>0?Container(
                              child: ListView.builder(
                                padding: EdgeInsets.all(0.0),
                                itemCount: discounted(widget.list).length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (cont, index) {
                                  var data = discounted(widget.list)[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom:5.0),
                                    child: Column(
                                      children: [
                                        MatchDetailCardView(
                                          txt1: AppLocalizations.of('₹${getPrizeName(data.prize)}'),
                                          txt2: "₹${data.entry}",
                                          txt3: '${data.spots_left}',
                                          txt4:'${data.spots}',
                                          txt5: widget.title,
                                          time: widget.time.millisecondsSinceEpoch,
                                          data: data,
                                          isClickable: true,
                                          list: widget.plist,
                                          index: widget.index,
                                          isLive: isLive,
                                          teams:widget.teams,
                                          percent: data.percent,
                                          isMega: data.isMega, first_price:data.first_price,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ):Container(),
                            beginners(widget.list).length>0?SizedBox(
                              height: 5,
                            ):Container(),
                            beginners(widget.list).length>0?Text('Only for beginners',
                              key: ConstanceData.beginners,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),):Container(),
                            beginners(widget.list).length>0?SizedBox(
                              height: 5,
                            ):Container(),
                            beginners(widget.list).length>0?Container(
                              child: ListView.builder(
                                padding: EdgeInsets.all(0.0),
                                itemCount: beginners(widget.list).length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (cont, index) {
                                  var data = beginners(widget.list)[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom:5.0),
                                    // height: 170,
                                    child: Column(
                                      children: [
                                        MatchDetailCardView(
                                          txt1: AppLocalizations.of('₹${getPrizeName(data.prize)}'),
                                          txt2: "₹${data.entry}",
                                          txt3: '${data.spots_left}',
                                          txt4:'${data.spots}',
                                          txt5: widget.title,
                                          time: widget.time.millisecondsSinceEpoch,
                                          data: data,
                                          isClickable: true,
                                          list: widget.plist,
                                          index: widget.index, isLive: isLive,  teams:widget.teams,  percent: data.percent,
                                          isMega: data.isMega, first_price:data.first_price,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ):Container(),
                           //Head to head
                            head_to_head(widget.list).length>0?SizedBox(
                              height: 5,
                            ):Container(),
                            head_to_head(widget.list).length>0?Text('Head to Head',
                              key: ConstanceData.headtohead,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),):Container(),
                            head_to_head(widget.list).length>0?SizedBox(
                              height: 5,
                            ):Container(),
                            head_to_head(widget.list).length>0?Container(
                              child: ListView.builder(
                                padding: EdgeInsets.all(0.0),
                                itemCount: head_to_head(widget.list).length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (cont, index) {
                                  var data = head_to_head(widget.list)[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom:5.0),
                                    // height: 170,
                                    child: Column(
                                      children: [
                                        MatchDetailCardView(
                                          txt1: AppLocalizations.of('₹${getPrizeName(data.prize)}'),
                                          txt2: "₹${data.entry}",
                                          txt3: '${data.spots_left}',
                                          txt4:'${data.spots}',
                                          txt5: widget.title,
                                          time: widget.time.millisecondsSinceEpoch,
                                          data: data,
                                          isClickable: true,
                                          list: widget.plist,
                                          index: widget.index, isLive: isLive,  teams:widget.teams,  percent: data.percent,
                                          isMega: data.isMega, first_price:data.first_price,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ):Container(),
                            low_entry(widget.list).length>0?SizedBox(
                              height: 5,
                            ):Container(),
                            low_entry(widget.list).length>0?Text('Low Entry',
                              key: ConstanceData.low_entry,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),):Container(),
                            low_entry(widget.list).length>0?SizedBox(
                              height: 5,
                            ):Container(),
                            low_entry(widget.list).length>0?Container(
                              child: ListView.builder(
                                padding: EdgeInsets.all(0.0),
                                itemCount: low_entry(widget.list).length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (cont, index) {
                                  var data = low_entry(widget.list)[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom:5.0),

                                    child: Column(
                                      children: [
                                        MatchDetailCardView(
                                          txt1: AppLocalizations.of('₹${getPrizeName(data.prize)}'),
                                          txt2: "₹${data.entry}",
                                          txt3: '${data.spots_left}',
                                          txt4:'${data.spots}',
                                          txt5: widget.title,
                                          time: widget.time.millisecondsSinceEpoch,
                                          data: data,
                                          isClickable: true,
                                          list: widget.plist,
                                          index: widget.index, isLive: isLive,  teams:widget.teams,  percent: data.percent,
                                          isMega: data.isMega, first_price:data.first_price,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ):Container(),
                            mega(widget.list).length>0?SizedBox(
                              height: 5,
                            ):Container(),
                            mega(widget.list).length>0?Text('Mega Contests',
                              key: ConstanceData.mega,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),):Container(),
                            mega(widget.list).length>0?SizedBox(
                              height: 5,
                            ):Container(),
                            mega(widget.list).length>0?Container(
                              child: ListView.builder(
                                padding: EdgeInsets.all(0.0),
                                itemCount: mega(widget.list).length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (cont, index) {
                                  var data = mega(widget.list)[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom:5.0),
                                    // height: 170,
                                    child: Column(
                                      children: [
                                        MatchDetailCardView(
                                          txt1: AppLocalizations.of('₹${getPrizeName(data.prize)}'),
                                          txt2: "₹${data.entry}",
                                          txt3: '${data.spots_left}',
                                          txt4:'${data.spots}',
                                          txt5: widget.title,
                                          time: widget.time.millisecondsSinceEpoch,
                                          data: data,
                                          isClickable: true,
                                          list: widget.plist,
                                          index: widget.index, isLive: isLive,  teams:widget.teams,  percent: data.percent,
                                          isMega: data.isMega, first_price:data.first_price,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ):Container(),
                            high_reward(widget.list).length>0?SizedBox(
                              height: 5,
                            ):Container(),
                            high_reward(widget.list).length>0?Text('High Reward Contests',
                              key: ConstanceData.high_reward,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),):Container(),
                            high_reward(widget.list).length>0?SizedBox(
                              height: 5,
                            ):Container(),
                            high_reward(widget.list).length>0?Container(
                              child: ListView.builder(
                                padding: EdgeInsets.all(0.0),
                                itemCount: high_reward(widget.list).length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (cont, index) {
                                  var data = high_reward(widget.list)[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom:5.0),
                                    // height: 170,
                                    child: Column(
                                      children: [
                                        MatchDetailCardView(
                                          txt1: AppLocalizations.of('₹${getPrizeName(data.prize)}'),
                                          txt2: "₹${data.entry}",
                                          txt3: '${data.spots_left}',
                                          txt4:'${data.spots}',
                                          txt5: widget.title,
                                          time: widget.time.millisecondsSinceEpoch,
                                          data: data,
                                          isClickable: true,
                                          list: widget.plist,
                                          index: widget.index, isLive: isLive,  teams:widget.teams,  percent: data.percent,
                                          isMega: data.isMega,
                                          first_price:data.first_price,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ):Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
  }

  getWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          left: 10,
          right: 10,
        ),
        child: Text(
          'Oops! Looks like no contests available for this filter',
        ),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.only(left: 20, right: 20),
      //   child: ListView.builder(
      //     itemCount: ConstanceData.fileteredContests.length,
      //     shrinkWrap: true,
      //     itemBuilder: (cont, index) {
      //       var data = ConstanceData.fileteredContests[index];
      //       return Container(
      //         child: Column(
      //           children: [
      //             MatchDetailCardView(
      //               txt1: AppLocalizations.of('₹${data.prize}'),
      //               txt2: "₹${data.entry}",
      //               txt3: AppLocalizations.of(
      //                   '${data.sports_left} sports left'),
      //               txt4: AppLocalizations.of('${data.sports} spots'),
      //               txt5: widget.title,
      //               time: widget.time,
      //               data: data,
      //               isClickable: true,
      //             ),
      //             SizedBox(
      //               height: 25,
      //             ),
      //           ],
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.time.isBefore(DateTime.now())) {
      print('12');
      if (mounted) {
        try {
          setState(() {
            isLive = true;
          });
        } catch (e) {
          print(e);
          isLive = true;
        }
      } else {
        isLive = true;
      }
    } else {
      print('121 ${widget.time} ${DateTime.now()}');
    }
  }

  @override
  void dispose() {
    ConstanceData.entry = null;
    ConstanceData.teams = null;
    ConstanceData.prize = null;
    ConstanceData.type = null;
    ConstanceData.discounted= GlobalKey();
    ConstanceData.beginners= GlobalKey();
    ConstanceData.headtohead= GlobalKey();
    ConstanceData.low_entry= GlobalKey();
    ConstanceData.mega= GlobalKey();
    super.dispose();

  }

  discounted(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for(var i in list){
      if(i.category_id==0){
        list1.add(i);
      }
    }
    return list1;
  }
  high_reward(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for(var i in list){
      if(i.category_id==8){
        list1.add(i);
      }
    }
    return list1;
  }
  beginners(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for(var i in list){
      if(i.category_id==3){
        list1.add(i);
      }
    }
    return list1;
  }
  head_to_head(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for(var i in list){
      if(i.category_id==2){
        list1.add(i);
      }
    }
    return list1;
  }
  low_entry(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for(var i in list){
      if(i.category_id==4){
        list1.add(i);
      }
    }
    return list1;
  }
  mega(List<Contest> list) {
    List<Contest> list1 = new List<Contest>();
    for(var i in list){
      if(i.category_id==1){
        list1.add(i);
      }
    }
    return list1;
  }

  getPrizeName(prize) {
    if (int.parse(prize.toString()) >= 100000 &&
        int.parse(prize.toString()) < 10000000) {
      String txt = prize.toString().split('')[0].toString();
      txt = txt+' lakh';
      return txt;
    }else if(int.parse(prize.toString()) > 10000000){
      String txt = prize.toString().split('')[0].toString();
      txt = txt+' Crore';
      return txt;
    }else{
      return '${prize}';
    }
  }
}
