import 'package:fantacySports/Model/Scorecard/Innings.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

class BatsScoreCard extends StatefulWidget {
  final int count;

  BatsScoreCard(this.count);

  @override
  _BatsScoreCardState createState() => _BatsScoreCardState();
}

class _BatsScoreCardState extends State<BatsScoreCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: ConstanceData.Innings[widget.count].batsmen.length>0?Container(
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0.0),
          itemCount: 2,
          itemBuilder: (con, index) {
            innings inning = ConstanceData.Innings[widget.count];
            return Container(
              padding: EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      inning.batsmen[inning.batsmen.length-(index+1)].name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      inning.batsmen[inning.batsmen.length-(index+1)].runs,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '(${inning.batsmen[inning.batsmen.length-(index+1)].balls_faced})',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ):Container(),
    );
  }
}
