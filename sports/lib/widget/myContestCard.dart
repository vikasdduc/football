import 'dart:math';

import 'package:flutter/material.dart';

import '../constance/constance.dart';

class MyContestCard extends StatefulWidget {
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
  final Widget image3;
  final Function onTap;

  MyContestCard(
      {this.txt1,
      this.txt2,
      this.txt3,
      this.txt4,
      this.setTime,
      this.txt6,
      this.txt7,
      this.txt8,
      this.image1,
      this.image2,
      this.onTap,
      this.image3});

  @override
  State<MyContestCard> createState() => _MyContestCardState();
}

class _MyContestCardState extends State<MyContestCard> {
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
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:250,
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
                              color: Colors.grey,  size:13,
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
                              widget.txt7 != ''
                                  ? Container(
                                      height: 20,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        // border: Border.all(
                                        //   color: Color(0xff85fe7c),
                                        // ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${widget.txt7}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(
                                            color: Colors.grey.shade700,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.6,
                                                fontSize: 10,
                                              ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                width: 5,
                              ),
                              widget.txt8 != ''
                                  ? Container(
                                      height: 20,
                                      width: 75,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        // border: Border.all(
                                        //   color: Color(0xff85fe7c),
                                        // ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${widget.txt8}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(
                                            color: Colors.grey.shade700,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.6,
                                                fontSize: 10,
                                              ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Expanded(child: SizedBox()),
                              widget.image3 == null
                                  ? Icon(
                                      Icons.outbox,
                                      color: Colors.grey,
                                      size: 20,
                                    )
                                  : widget.image3,
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
    if (txt8 == 'null' || txt8 == null) {
      return '';
    } else {
      return '₹${widget.txt8}';
    }
  }
}
