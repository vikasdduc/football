import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

class RunsPerBowlScoreCard extends StatefulWidget {
  final  count;
  final List<String> runs;

  RunsPerBowlScoreCard(this.count, this.runs);

  @override
  _RunsPerBowlScoreCardState createState() => _RunsPerBowlScoreCardState();
}

class _RunsPerBowlScoreCardState extends State<RunsPerBowlScoreCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: ConstanceData.CommentariesCombo.last.event == 'overend'
            ? Text(
                'Over End',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    itemCount: widget.count==null||widget.count<=0?0:widget.count,
                    itemBuilder: (con, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 2, right: 2),
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${widget.runs.reversed.toList(growable: false)[index]}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    itemCount: widget.count==null||widget.count==0?0:6 - widget.count,
                    itemBuilder: (con, index) {
                      return Container(
                        margin: EdgeInsets.only(left: 2, right: 2),
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
