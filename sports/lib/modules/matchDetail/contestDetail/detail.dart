import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/contest.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

import '../../../Model/Prize.dart';
import '../../../Networking/AccessNetwork.dart';

class DetailPage extends StatefulWidget {
  final cont, isLive;

  const DetailPage({Key key, this.cont, this.isLive}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<prize> list = new List<prize>();

  @override
  void initState() {
    super.initState();
    fetchPrize(widget.cont.id.toString());
  }

  void fetchPrize(contest_id) {
    access_network()
        .check_contest_admin(
      contest_id,
    )
        .then((value) {
      if (mounted) {
        setState(() {
          list = value;
        });
      } else {
        list = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              // border: Border.all(
              //   color: Colors.grey.shade500,
              // ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: !widget.isLive
              ? Column(
                  children: [
                    list != null && list.length > 0
                        ? SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Text(
                                            'Rank',
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Container()
                                ),
                                Expanded(
                                  flex: 2,
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
                          )
                        : Container(),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            padding: EdgeInsets.all(0.0),
                            itemCount: list.length,
                            itemBuilder: (cont, i) {
                              return SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container( padding: EdgeInsets.only(left: 20),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                '#${list[i].rank}',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child: Container(
                                    //     child: Center(
                                    //       child: Text(
                                    //         '${list[i].price_pool}',
                                    //         style: TextStyle(
                                    //           fontWeight:
                                    //           FontWeight.bold,
                                    //           color: Colors.black,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Expanded(
                                      flex: 2,
                                      child: Container()
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                '₹${list[i].winnings}',
                                                style: TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Container(
                    child: Image.asset(
                      'assets/images/winnings.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget row(String txt1, String txt2) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: Row(
        children: [
          Text(
            txt1,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Theme.of(context).textTheme.headline6.color,
                  letterSpacing: 0.6,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          ),
          // Expanded(child: SizedBox()),
          Text(
            txt2,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Theme.of(context).textTheme.headline6.color,
                  letterSpacing: 0.6,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
