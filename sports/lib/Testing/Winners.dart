import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

import '../Model/WinnersListItem.dart';
import '../Networking/AccessNetwork.dart';

class Winner extends StatefulWidget {
  const Winner({Key key}) : super(key: key);

  @override
  _WinnerState createState() => _WinnerState();
}

class _WinnerState extends State<Winner> {
  List<winnerlist> list = new List<winnerlist>();

  @override
  void initState() {
    super.initState();
    fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              Container(
                padding: const EdgeInsets.only(left: 7, right: 7),
                height: 50,
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of('Mega Contest Winners'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).textTheme.headline6.color,
                        letterSpacing: 0.6,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      AppLocalizations.of('Filter by Tour'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.black87,
                        letterSpacing: 0.6,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.sort,
                      color: Colors.black87,
                      size: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height-250,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (cont, index) {
                    var data = list[index];
                    return Card(
                      elevation: 5,
                      child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of('${data.title}'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            letterSpacing: 0.6,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text(
                                      "${data.date.toString().split(' ')[0]}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .color,
                                            letterSpacing: 0.6,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 25,
                                      child: Image.network(data.teama_logo),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${data.teama_short_name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .color,
                                            letterSpacing: 0.6,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text(
                                      "vs",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .color,
                                            letterSpacing: 0.6,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text(
                                      "${data.teamb_short_name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .color,
                                            letterSpacing: 0.6,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 25,
                                      width: 25,
                                      child: Image.network(data.teamb_logo),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10),
                                child: Text(
                                  AppLocalizations.of(
                                      '₹${data.prize} Mega Contest'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Color(0xff317E2F),
                                        letterSpacing: 0.6,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                              Container(
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: data.winners.length,
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      EdgeInsets.only(left: 20, right: 20),
                                  itemBuilder: (con, ind) {
                                    var winner = data.winners[ind];
                                    return cardView(
                                      AppLocalizations.of(
                                          'Rank #${winner.rank}'),
                                      AppLocalizations.of(
                                          '${winner.user.name}'),
                                      AppLocalizations.of(
                                          'Total Point: ${winner.total_point}'),
                                      NetworkImage(
                                        'https://theapnateam.com/admin/public/document/user/'+winner.user.profile_image.toString().trim(),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget cardView(String txt1, String txt2, String txt3, ImageProvider image) {
    return Card(
      elevation: 5,
      child: Container(
        height: 140,
        width: 120,
        color: Theme.of(context).appBarTheme.color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Text(
                txt1,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                      fontSize: 10,
                    ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Text(
                txt2,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.bodyText2.color,
                      letterSpacing: 0.6,
                      fontSize: 10,
                    ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: CircleAvatar(
                  radius: 34,
                  backgroundColor: Theme.of(context).textTheme.headline6.color,
                  backgroundImage: image, ),
            ),
            Expanded(child: SizedBox()),
            Container(
              color: Color(0xff0E2F56),
              height: 20,
              child: Center(
                child: Text(
                  txt3,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.white,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void fetchList() {
    access_network().get_winner_list().then((value) {
      if (mounted) {
        setState(() {
                list = value;
              });
      } else {
        list = value;
      }
    });
  }
}
