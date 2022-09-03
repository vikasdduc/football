import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../Language/appLocalizations.dart';
import 'contestDetailsUser.dart';

class MatchDetailCardUser extends StatelessWidget {
  final String txt1;
  final String txt2;
  final String txt3;
  final String txt4;
  final String txt5;
  final int time;
  final dynamic data;
  final bool isClickable;
  final list;
  final index;


  MatchDetailCardUser(
      {this.txt1,
      this.txt2,
      this.txt3,
      this.txt4,
      this.txt5,
      this.time,
      this.data,
      this.isClickable,
      this.list,
      this.index});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        if (isClickable) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ContestDetailsUser(time,txt5,data,list,index,),
            ),
          );
        }
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of('Prize Pool'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                        letterSpacing: 0.6,
                        fontSize: 10,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      AppLocalizations.of('Entry'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                        letterSpacing: 0.6,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    Text(
                      txt1,
                      style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).textTheme.headline6.color,
                        letterSpacing: 0.6,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      height: 25,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Color(0xff0E2F56),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          txt2,
                          style: Theme.of(context).textTheme.caption.copyWith(
                            color: Colors.white,
                            letterSpacing: 0.6,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              LinearPercentIndicator(
                percent: 0.4,
                progressColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).disabledColor,
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Row(
                  children: [
                    Text(
                      txt3,
                      style: Theme.of(context).textTheme.caption.copyWith(
                        color: Color(0xffD30001),
                        letterSpacing: 0.6,
                        fontSize: 10,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      txt4,
                      style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.black54,
                        letterSpacing: 0.6,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(''),
                        style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.caption.color,
                          letterSpacing: 0.6,
                          fontSize: 10,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        "${calculate().floor()}%",
                        style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.caption.color,
                          letterSpacing: 0.6,
                          fontSize: 10,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        AppLocalizations.of('${data.content_type}'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).textTheme.caption.color,
                          letterSpacing: 0.6,
                          fontSize: 10,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Icon(
                        Icons.check_circle_outline,
                        color: Theme.of(context).textTheme.caption.color,
                        size: 18,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculate() {
    return data.spots_left/int.parse(data.spots.toString())*100;
  }
}

