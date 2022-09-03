import 'package:flutter/material.dart';

import '../../../Language/appLocalizations.dart';
import '../../../Model/Prize.dart';
import '../../../Networking/AccessNetwork.dart';
import '../../../constance/constance.dart';
import '../../createTeam/createTeam.dart';
import 'Join/Select_Team.dart';
import 'Join/Select_Team_Create_Contest.dart';
import 'addTeam.dart';
import 'addToWallet.dart';

class PrizeBreakDown extends StatefulWidget {
  final name, size, fee, totalPrize, list, index, time, dataTeams;

  PrizeBreakDown(this.name, this.size, this.fee, this.totalPrize, this.list,
      this.index, this.time, this.dataTeams);

  @override
  State<PrizeBreakDown> createState() => _PrizeBreakDownState();
}

class _PrizeBreakDownState extends State<PrizeBreakDown> {
  List<prize> list = new List<prize>();
  int selected = 0;

  @override
  void initState() {
    super.initState();
    fetchPrize(widget.totalPrize.toString(), getList()[0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTop(),
            Container(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Max Prize Pool',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                '₹${widget.totalPrize}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                'Spots',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                '${widget.size}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                'Entry',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                '₹${widget.fee}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Select the number of winners',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 50,
                          child: Center(
                            child: ListView.builder(
                              padding: EdgeInsets.all(0.0),
                              scrollDirection: Axis.horizontal,
                              itemCount: getList().length,
                              itemBuilder: (cont, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GestureDetector(
                                    onTap: () => {
                                      setState(() {
                                        selected = index;
                                        fetchPrize(widget.totalPrize.toString(),
                                            getList()[index]);
                                      })
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: selected == index
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                        height: 40,
                                        width: 40,
                                        child: Center(
                                          child: Text(
                                            '${getList()[index]}',
                                            style: TextStyle(
                                              color: selected == index
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              'Rank',
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              '% of Prize Pool',
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              'Winnings',
                                              style: TextStyle(
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.all(0.0),
                                      itemCount: list.length,
                                      itemBuilder: (cont, i) {
                                        return SizedBox(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: Center(
                                                    child: Text(
                                                      '#${list[i].rank}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: Center(
                                                    child: Text(
                                                      '${list[i].price_pool}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: Center(
                                                    child: Text(
                                                      '₹${list[i].winnings}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Card(
              elevation: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  right: 10,
                  left: 10,
                ),
                child: Material(
                  child: InkWell(
                    splashColor: Colors.grey.shade800,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    onTap: () {
                      if (int.parse(ConstanceData.prof.balance.toString()) >
                          int.parse(widget.fee)) {
                        if (widget.dataTeams == null ||
                            widget.dataTeams.length <= 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTeam(
                                    widget.list,
                                    widget.index,
                                    widget.list[widget.index].Competition.cid,
                                    widget.list[widget.index].match_id,
                                    widget.time.millisecondsSinceEpoch,
                                    widget.name,
                                    widget.size,
                                    widget.fee,
                                    widget.totalPrize,
                                    getList()[selected],
                                    ''),
                              ));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    select_team_create_contest(
                                        widget.dataTeams,
                                        widget.list[widget.index],
                                        widget.name,
                                        widget.size,
                                        widget.fee,
                                        widget.totalPrize,
                                        getList()[selected],
                                        ''),
                              ));
                        }
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddToWallet(
                              (getFee()).toString(),
                              widget.list,
                              widget.index,
                              widget.time,
                              widget.list[widget.index].Competition.cid,
                              widget.list[widget.index].match_id,
                              widget.name,
                              widget.size,
                              widget.totalPrize,
                              widget.dataTeams,
                              getList()[selected],
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Create Contest',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getTop() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top,
          color: Theme.of(context).primaryColor,
        ),
        //Red space
        Container(
          height: AppBar().preferredSize.height,
          color: Theme.of(context).primaryColor,
          child: Padding(
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
                SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 270,
                        child: Text(
                          AppLocalizations.of('Choose prize breakdown'),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void fetchPrize(totalPrize, size) {
    print('zise ${size}');
    access_network()
        .check_contest(
      totalPrize,
      size,
    )
        .then((value) {
      setState(() {
        list = value;
      });
    });
  }

  List<int> getList() {
    List<int> odd = new List<int>();
    for (int i = 0; i < int.parse(widget.size) / 2; i++) {
      if (i % 2 != 0) {
        odd.add(i);
      }
    }
    return odd.reversed.toList(growable: false);
  }

  getFee() {
    var amount = int.parse(widget.fee) -
        int.parse(ConstanceData.prof.balance.toString());
    if (amount >= 0) {
      return amount;
    } else {
      return int.parse(widget.fee).toString();
    }
  }
}
