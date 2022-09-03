import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/Model/Matche.dart';
import 'package:flutter/material.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/modules/sports/baseball.dart';
import 'package:fantacySports/modules/sports/basketball.dart';
import 'package:fantacySports/modules/sports/cricket.dart';
import 'package:fantacySports/modules/sports/football.dart';
import 'package:fantacySports/modules/sports/handball.dart';
import 'package:fantacySports/modules/sports/nfl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Networking/AccessNetwork.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  bool isCricket = true;
  bool isFootball = false;
  bool isBasketball = false;
  bool isBaseball = false;
  bool isNFL = false;
  bool isHandball = false;

  bool dataAvailable = false;

  @override
  void initState() {
    _pageController = PageController();
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          if (ConstanceData.matchUpcominglist==null||ConstanceData.matchUpcominglist.length<=0) {
            fetchupcoming_match_user();
          }
          fetchLEvel();
          fetchCompleteCompetition();
          // try {
          //   ConstanceData.matchLivelist =
          //       sortByTime(ConstanceData.matchLivelist);
          //   ConstanceData.matchSchedlist =
          //       sortByTime(ConstanceData.matchSchedlist);
          // } catch (e) {
          //   print(e);
          // }
        });
      } else {
        fetchLEvel();
        try {
          ConstanceData.matchLivelist = sortByTime(ConstanceData.matchLivelist);
          // ConstanceData.matchSchedlist =
          //     sortByTime(ConstanceData.matchSchedlist);
        } catch (e) {
          print(e);
        }
      }
    });
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          dataAvailable = true;
          try {
            // ConstanceData.matchLivelist =
            //     sortByTime(ConstanceData.matchLivelist);
            // ConstanceData.matchSchedlist =
            //     sortByTime(ConstanceData.matchSchedlist);
          } catch (e) {
            print(e);
          }
        });
      } else {
        dataAvailable = true;
        try {
          // ConstanceData.matchLivelist = sortByTime(ConstanceData.matchLivelist);
          // ConstanceData.matchSchedlist =
          //     sortByTime(ConstanceData.matchSchedlist);
        } catch (e) {
          print(e);
        }
      }
    });
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          dataAvailable = true;
          try {
            // ConstanceData.matchLivelist =
            //     sortByTime(ConstanceData.matchLivelist);
            // ConstanceData.matchSchedlist =
            //     sortByTime(ConstanceData.matchSchedlist);
          } catch (e) {
            print(e);
          }
        });
      } else {
        dataAvailable = true;
        try {
          // ConstanceData.matchLivelist = sortByTime(ConstanceData.matchLivelist);
          // ConstanceData.matchSchedlist =
          //     sortByTime(ConstanceData.matchSchedlist);
        } catch (e) {
          print(e);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int pageNumber = 0;
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .appBarTheme
            .color,
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .padding
                .top,
            color: Theme
                .of(context)
                .primaryColor,
          ),
          Container(
            height: AppBar().preferredSize.height,
            color: Theme
                .of(context)
                .scaffoldBackgroundColor,
            child: tabBar(),
          ),
          isCricket
              ? CricketPage(dataAvailable)
              : isFootball
              ? FootballPage()
              : isBasketball
              ? BasketballPage()
              : isBaseball
              ? BaseballPage()
              : isNFL
              ? NFLPage()
              : isHandball
              ? HandballPage()
              : SizedBox(),
        ],
      ),
    );
  }

  Widget tabBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                  ? Theme
                  .of(context)
                  .primaryColor
                  : Colors.grey.shade400,
              isCricket == true
                  ? Theme
                  .of(context)
                  .primaryColor
                  : Colors.grey.shade600,
            ),
          ),
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
                  ? Theme
                  .of(context)
                  .primaryColor
                  : Colors.grey.shade400,
              isFootball == true
                  ? Theme
                  .of(context)
                  .primaryColor
                  : Colors.grey.shade400,
            ),
          ),
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
                  ? Theme
                  .of(context)
                  .primaryColor
                  : Colors.grey.shade400,
              isBasketball == true
                  ? Theme
                  .of(context)
                  .primaryColor
                  : Colors.grey.shade400,),
          ),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       isCricket = false;
          //       isFootball = false;
          //       isBasketball = false;
          //       isBaseball = true;
          //       isNFL = false;
          //       isHandball = false;
          //     });
          //   },
          //   child: customColumn(
          //       AppLocalizations.of('Baseball'),
          //       FontAwesomeIcons.baseballBall,
          //       isBaseball == true
          //           ? Theme.of(context).primaryColor
          //           : Theme.of(context).textTheme.caption.color,
          //       isBaseball == true
          //           ? Theme.of(context).primaryColor
          //           : Theme.of(context).textTheme.caption.color),
          // ),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       isCricket = false;
          //       isFootball = false;
          //       isBasketball = false;
          //       isBaseball = false;
          //       isNFL = true;
          //       isHandball = false;
          //     });
          //   },
          //   child: customColumn(
          //       AppLocalizations.of('NFL'),
          //       FontAwesomeIcons.footballBall,
          //       isNFL == true
          //           ? Theme.of(context).primaryColor
          //           : Theme.of(context).textTheme.caption.color,
          //       isNFL == true
          //           ? Theme.of(context).primaryColor
          //           : Theme.of(context).textTheme.caption.color),
          // ),
          // InkWell(
          //   onTap: () {
          //     setState(() {
          //       isCricket = false;
          //       isFootball = false;
          //       isBasketball = false;
          //       isBaseball = false;
          //       isNFL = false;
          //       isHandball = true;
          //     });
          //   },
          //   child: customColumn(
          //       AppLocalizations.of('HandBall'),
          //       FontAwesomeIcons.basketballBall,
          //       isHandball == true
          //           ? Theme.of(context).primaryColor
          //           : Theme.of(context).textTheme.caption.color,
          //       isHandball == true
          //           ? Theme.of(context).primaryColor
          //           : Theme.of(context).textTheme.caption.color),
          // ),
        ],
      ),
    );
  }

  Widget customColumn(String txt, IconData icon, Color iconColor,
      Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 18,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          txt,
          style: Theme
              .of(context)
              .textTheme
              .bodyText2
              .copyWith(
            color: textColor,
            letterSpacing: 0.6,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  List<match> sortByTime(List<match> matchLivelist) {
    int high = matchLivelist.length - 1;
    int low = 0;
    List<match> result = quickSortTime(matchLivelist, low, high);
    return result;
  }

  List<match> quickSortTime(List list, int low, int high) {
    if (low < high) {
      int pi = partition(list, low, high);

      quickSortTime(list, low, pi - 1);
      quickSortTime(list, pi + 1, high);
    }
    return list;
  }

  int partition(List<match> list, low, high) {
    match pivot = list[high];

    int i = low - 1;
    for (int j = low; j < high; j++) {
      var date = DateTime(
        int.parse(list[j].date_start.split(' ')[0].split('-')[0]),
        int.parse(list[j].date_start.split(' ')[0].split('-')[1]),
        int.parse(list[j].date_start.split(' ')[0].split('-')[2]),
        int.parse(list[j].date_start.split(' ')[1].split(':')[0]),
        int.parse(list[j].date_start.split(' ')[1].split(':')[1]),
        int.parse(list[j].date_start.split(' ')[1].split(':')[2]),
      );
      var date1 = DateTime(
        int.parse(pivot.date_start.split(' ')[0].split('-')[0]),
        int.parse(pivot.date_start.split(' ')[0].split('-')[1]),
        int.parse(pivot.date_start.split(' ')[0].split('-')[2]),
        int.parse(pivot.date_start.split(' ')[1].split(':')[0]),
        int.parse(pivot.date_start.split(' ')[1].split(':')[1]),
        int.parse(pivot.date_start.split(' ')[1].split(':')[2]),
      );
      if (date.isBefore(date1)) {
        i++;
        swap(list, i, j);
      }
    }
    swap(list, i + 1, high);
    return i + 1;
  }

  void fetchLEvel() {
    try {
      access_network().level(ConstanceData.prof.id.toString()).then((value) =>
      {
        ConstanceData.setLvl(value),
      });
    } catch (e) {
      print(e);
    }
  }

  void swap(List list, int i, int j) {
    match temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }

  void fetchCompleteCompetition() {
    try {
      print('ghsf');
      access_network()
          .get_competed_match(ConstanceData.prof.id.toString(),0)
          .then((value) =>
      {
        ConstanceData.setCompMatch(value),
      });
    } catch (e) {
      print(e);
    }
  }


  void fetchupcoming_match_user() async {
    try {
      access_network()
          .get_upcoming_match_user(await ConstanceData.getId())
          .then((value) =>
      {
        ConstanceData.matchUpcominglist = value,
      });
    } catch (e) {
      print(e);
    }
  }

}
