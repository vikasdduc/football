import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/modules/home/drawer/profile/pointSystem/baseballPoint.dart';
import 'package:fantacySports/modules/home/drawer/profile/pointSystem/basketballPoint.dart';
import 'package:fantacySports/modules/home/drawer/profile/pointSystem/cricketPoint.dart';
import 'package:fantacySports/modules/home/drawer/profile/pointSystem/footballPoint.dart';
import 'package:fantacySports/modules/home/drawer/profile/pointSystem/handballPoint.dart';
import 'package:fantacySports/modules/home/drawer/profile/pointSystem/nflPoint.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PointSystemPage extends StatefulWidget {
  @override
  _PointSystemPageState createState() => _PointSystemPageState();
}

class _PointSystemPageState extends State<PointSystemPage> {
  bool isCricket = true;
  bool isFootball = false;
  bool isBasketball = false;
  bool isBaseball = false;
  bool isNFL = false;
  bool isHandball = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Theme.of(context).primaryColor,
          ),
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
                      size: 22,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AppLocalizations.of('Point System'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.white,
                          letterSpacing: 0.6,
                      fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 14),
              children: [
                Container(
                  height: AppBar().preferredSize.height,
                  color: Theme.of(context).appBarTheme.color,
                  child: tabBar(),
                ),
                SizedBox(
                  height: 15,
                ),
                isCricket
                    ? CricketPointPage()
                    : isFootball
                        ? FootballPointPage()
                        : isBasketball
                            ? BasketballPointPage()
                            // : isBaseball
                            //     ? BaseballPointPage()
                            //     : isNFL
                            //         ? NFLPointPage()
                            //         : isHandball
                            //             ? HandballPointPage()
                                        : SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget tabBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(
          //   height: 6,
          // ),
          InkWell(
            onTap: () {
              setState(() {
                isCricket = true;

                isFootball = false;

                isBasketball = false;

                isBaseball = false;

                isNFL = false;

                isHandball = false;
              });
            },
            child: customColumn(
                AppLocalizations.of('Cricket'),
                FontAwesomeIcons.basketballBall,
                isCricket == true
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.caption.color,
                isCricket == true
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.caption.color),
          ),
          // SizedBox(
          //   width: 100,
          // ),
          // SizedBox(
          //   height: 6,
          // ),
          InkWell(
            onTap: () {
              setState(() {
                isCricket = false;

                isFootball = true;

                isBasketball = false;

                isBaseball = false;

                isNFL = false;

                isHandball = false;
              });
            },
            child: customColumn(
                AppLocalizations.of('Football'),
                FontAwesomeIcons.baseballBall,
                isFootball == true
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.caption.color,
                isFootball == true
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.caption.color),
          ),
          // SizedBox(
          //   width: 100,
          // ),
          // SizedBox(
          //   height: 6,
          // ),
          InkWell(
            onTap: () {
              setState(() {
                isCricket = false;

                isFootball = false;

                isBasketball = true;

                isBaseball = false;

                isNFL = false;

                isHandball = false;
              });
            },
            child: customColumn(
                AppLocalizations.of('Games'),
                FontAwesomeIcons.basketballBall,
                isBasketball == true
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.caption.color,
                isBasketball == true
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.caption.color),
          ),
          // SizedBox(
          //   width: 20,
          // ),
          // SizedBox(
          //   height: 6,
          // ),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       isCricket = false;
          //
          //       isFootball = false;
          //
          //       isBasketball = false;
          //
          //       isBaseball = true;
          //
          //       isNFL = false;
          //
          //       isHandball = false;
          //     });
          //   },
          // //   child: customColumn(
          // //       AppLocalizations.of('Baseball'),
          // //       FontAwesomeIcons.baseballBall,
          // //       isBaseball == true
          // //           ? Theme.of(context).primaryColor
          // //           : Theme.of(context).textTheme.caption.color,
          // //       isBaseball == true
          // //           ? Theme.of(context).primaryColor
          // //           : Theme.of(context).textTheme.caption.color),
          // // ),
          // // SizedBox(
          // //   width: 20,
          // // ),
          // // SizedBox(
          // //   height: 6,
          // // ),
          // // InkWell(
          // //   onTap: () {
          // //     setState(() {
          // //       isCricket = false;
          // //
          // //       isFootball = false;
          // //
          // //       isBasketball = false;
          // //
          // //       isBaseball = false;
          // //
          // //       isNFL = true;
          // //
          // //       isHandball = false;
          // //     });
          // //   },
          // //   child: customColumn(
          // //       AppLocalizations.of('NFL'),
          // //       FontAwesomeIcons.footballBall,
          // //       isNFL == true
          // //           ? Theme.of(context).primaryColor
          // //           : Theme.of(context).textTheme.caption.color,
          // //       isNFL == true
          // //           ? Theme.of(context).primaryColor
          // //           : Theme.of(context).textTheme.caption.color),
          // // ),
          // // SizedBox(
          // //   width: 20,
          // // ),
          // // SizedBox(
          // //   height: 6,
          // // ),
          // // InkWell(
          // //   onTap: () {
          // //     setState(() {
          // //       isCricket = false;
          // //
          // //       isFootball = false;
          // //
          // //       isBasketball = false;
          // //
          // //       isBaseball = false;
          // //
          // //       isNFL = false;
          // //
          // //       isHandball = true;
          // //     });
          // //   },
          // //   child: customColumn(
          // //       AppLocalizations.of('HandBall'),
          // //       FontAwesomeIcons.basketballBall,
          // //       isHandball == true
          // //           ? Theme.of(context).primaryColor
          // //           : Theme.of(context).textTheme.caption.color,
          // //       isHandball == true
          // //           ? Theme.of(context).primaryColor
          // //           : Theme.of(context).textTheme.caption.color),
          // ),
        ],
      ),
    );
  }

  Widget customColumn(
      String txt, IconData icon, Color iconColor, Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor),
        SizedBox(
          height: 5,
        ),
        Text(
          txt,
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.6,
                fontSize: 14,
              ),
        ),
      ],
    );
  }
}
