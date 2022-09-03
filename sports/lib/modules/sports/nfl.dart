import 'package:carousel_pro/carousel_pro.dart';
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/widget/cardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../constance/constance.dart';

class NFLPage extends StatefulWidget {
  @override
  _NFLPageState createState() => _NFLPageState();
}

class _NFLPageState extends State<NFLPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 180,
                child: Swiper(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) => Carousel(
                    boxFit: BoxFit.cover,
                    images: [
                      Image.asset(
                        ConstanceData.nslider1,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        ConstanceData.nslider2,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        ConstanceData.nslider3,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        ConstanceData.nslider4,
                        fit: BoxFit.cover,
                      ),
                    ],
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.transparent,
                    borderRadius: true,
                  ),
                  autoplay: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 15),
                child: Text(
                  AppLocalizations.of('Upcoming Matches'),
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Theme.of(context).textTheme.headline6.color,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.6,
                        fontSize: 18,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    CardView(
                      txt1: AppLocalizations.of('NFL 2020'),
                      txt2: AppLocalizations.of('Philadelphia Eagles'),
                      txt3: AppLocalizations.of("Kansas City Chief's"),
                      txt4: "PHI",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 98 * 45,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "KAN",
                      txt7: AppLocalizations.of('₹5 Lakhs'),
                      image1: Image.asset(
                        ConstanceData.mumbaiIndians,
                        fit: BoxFit.cover,
                      ),
                      image2: Image.asset(
                        ConstanceData.kolkata,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CardView(
                      txt1: AppLocalizations.of('NFL 2020'),
                      txt2: AppLocalizations.of('Baltimore Ravens'),
                      txt3: AppLocalizations.of('Buffalo Bills'),
                      txt4: "BAL",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 220 * 260,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "BUF",
                      txt7: AppLocalizations.of('₹5 Lakhs'),
                      image1: Image.asset(
                        ConstanceData.mumbaiIndians,
                        fit: BoxFit.cover,
                      ),
                      image2: Image.asset(
                        ConstanceData.kolkata,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CardView(
                      txt1: AppLocalizations.of('NFL 2020'),
                      txt2: AppLocalizations.of('Dallas Cowboys'),
                      txt3: AppLocalizations.of('Arizona Cardinals'),
                      txt4: "DC",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 250 * 160,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "AC",
                      txt7: AppLocalizations.of('₹5 Lakhs'),
                      image1: Image.asset(
                        ConstanceData.mumbaiIndians,
                        fit: BoxFit.cover,
                      ),
                      image2: Image.asset(
                        ConstanceData.kolkata,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CardView(
                      txt1: AppLocalizations.of('NFL 2020'),
                      txt2: AppLocalizations.of('Philadelphia Eagles'),
                      txt3: AppLocalizations.of("Kansas City Chief's"),
                      txt4: "PHI",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 66 * 900,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "KAN",
                      txt7: AppLocalizations.of('₹5 Lakhs'),
                      image1: Image.asset(
                        ConstanceData.mumbaiIndians,
                        fit: BoxFit.cover,
                      ),
                      image2: Image.asset(
                        ConstanceData.kolkata,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
