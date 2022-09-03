import 'package:fantacySports/modules/home/contests/Join/Select_Team_Join.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Language/appLocalizations.dart';
import 'Join/Select_Team.dart';
import 'Join/join_create_team.dart';

class ContestJoin extends StatefulWidget {
  final list, index, time, dataTeams;

  ContestJoin(this.list, this.index, this.time, this.dataTeams);

  @override
  State<ContestJoin> createState() => _ContestJoinState();
}

class _ContestJoinState extends State<ContestJoin> {
  var _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
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
                              AppLocalizations.of('Join Contest by Code'),
                              overflow: TextOverflow.ellipsis,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
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

            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 7,
                                  right: 7,
                                  bottom: 2,
                                  top: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: TextField(
                                    onChanged: (text) {
                                      setState(() {});
                                    },
                                    controller: _controller,
                                    decoration: new InputDecoration(
                                      hintText: 'Enter Contest Code',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Colors.grey.shade600,
                                            letterSpacing: 0.6,
                                            fontSize: 20,
                                          ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Colors.black,
                                          letterSpacing: 0.6,
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Card(
              elevation: 0,
              child: Container(
                height: 80,
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
                      if (_controller.text.isNotEmpty) {
                        if (widget.dataTeams == null ||
                            widget.dataTeams.length <= 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JoinCreateTeam(
                                  widget.list,
                                  widget.index,
                                  widget.list[widget.index].Competition.cid,
                                  widget.list[widget.index].match_id,
                                  widget.time.millisecondsSinceEpoch,
                                  _controller.text),
                            ),
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => select_team_join(
                                  _controller.text,
                                  widget.list[widget.index],
                                  widget.dataTeams,
                                ),
                              ));
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Enter a valid code",
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Text(
                          'Join',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
}
