import 'dart:math';

import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/modules/matchDetail/matchDetailPage.dart';
import 'package:flutter/material.dart';

class CardView extends StatefulWidget {
  final String txt1;
  final String txt2;
  final String txt3;
  final String txt4;
  final Widget setTime;
  final String txt6;
  final String txt7;
  final String txt8;
  final Image image1;
  final Image image2;
  final Function onTap;

  const CardView(
      {Key key,
      this.txt1,
      this.txt2,
      this.txt3,
      this.txt4,
      this.txt6,
      this.txt7,
      this.txt8,
      this.image1,
      this.image2,
      this.setTime,
      this.onTap})
      : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap == null
          ? () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => MatchDetailPage(),
              //   ),
              // );
            }
          : widget.onTap,
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.color.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 9, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:300,
                              child: Text(
                                widget.txt1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).textTheme.caption.copyWith(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Icon(
                              Icons.notifications_on_outlined,
                              color: Colors.grey,
                              size:13,
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      widget.txt2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Colors.black87,
                                            fontSize: 11,
                                          ),
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      widget.txt3,
                                      textAlign: TextAlign.right,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: Colors.black87,
                                            fontSize: 11,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    child: widget.image1,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.txt4,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.6,
                                          fontSize: 14,
                                        ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  widget.setTime,
                                  Expanded(child: SizedBox()),
                                  Text(
                                    widget.txt6,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .color,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.6,
                                          fontSize: 14,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 25,
                                    width: 25,
                                    child: widget.image2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100.withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
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
                              SizedBox(
                                width: 5,
                              ),
                              widget.txt7!=''?Container(
                                height: 20,
                                width: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: Color(0xff85fe7c),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${widget.txt7}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Color(0xff0ebd01),
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.6,
                                          fontSize: 10,
                                        ),
                                  ),
                                ),
                              ):Container(),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${getText(widget.txt8)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.6,
                                      fontSize: 12,
                                    ),
                              ),
                              Expanded(child: SizedBox()),
                              Icon(
                                Icons.outbox,
                                color: Colors.grey,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getRandom() {
    Random().nextInt(ConstanceData.contests.length - 1);
  }

  getText(String txt8) {
    if(txt8=='null'||txt8==null){
      return '';
    }else{
      return '₹${widget.txt8}';
    }
  }
}

class CompleteCardView extends StatefulWidget {
  final String txt1;
  final String txt2;
  final String txt3;
  final String txt4;
  final String txt5;
  final String txt6;
  final String txt7;
  final Image image1;
  final Image image2;

  const CompleteCardView({
    Key key,
    this.txt1,
    this.txt2,
    this.txt3,
    this.txt4,
    this.txt6,
    this.txt7,
    this.image1,
    this.image2,
    this.txt5,
  }) : super(key: key);

  @override
  _CompleteCardViewState createState() => _CompleteCardViewState();
}

class _CompleteCardViewState extends State<CompleteCardView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MatchDetailPage(),
        //   ),
        // );
      },
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.txt1,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.6,
                                  fontSize: 14,
                                ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.notifications_on_outlined)
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.txt2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  widget.txt3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  child: widget.image1,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.txt4,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  widget.txt5,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  widget.txt6,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 35,
                                  width: 35,
                                  child: widget.image2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withOpacity(0.1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
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
                              widget.txt7,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 20,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of('Mega'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Icon(
                              Icons.outbox,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
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
  }
}
