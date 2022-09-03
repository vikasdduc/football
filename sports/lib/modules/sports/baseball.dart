import 'package:carousel_pro/carousel_pro.dart';
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/widget/cardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../constance/constance.dart';

class BaseballPage extends StatefulWidget {
  @override
  _BaseballPageState createState() => _BaseballPageState();
}

class _BaseballPageState extends State<BaseballPage> {
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
                        ConstanceData.baslider1,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        ConstanceData.baslider2,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        ConstanceData.baslider3,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        ConstanceData.baslider4,
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
                      txt1: AppLocalizations.of('Korean Baseball League'),
                      txt2: "KT WIZ",
                      txt3: AppLocalizations.of('Rakuten Monkeys'),
                      txt4: "KTW",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 310 * 60,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "RM",
                      txt7: AppLocalizations.of('₹1 Lakhs'),
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
                      txt1: "CPBL",
                      txt2: AppLocalizations.of('SK Wyverns'),
                      txt3: AppLocalizations.of('CTBC Brothers'),
                      txt4: "SKW",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 250 * 260,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "CTB",
                      txt7: "₹50,000",
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
                      txt1: AppLocalizations.of('Korean Baseball League'),
                      txt2: AppLocalizations.of('Samsung Lions'),
                      txt3: AppLocalizations.of('Hanwha Eagles'),
                      txt4: "SL",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 85 * 200,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "HE",
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
                      txt1: "CPBL",
                      txt2: "KT WIZ",
                      txt3: AppLocalizations.of('Rakuten Monkeys'),
                      txt4: "KTW",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 150 * 160,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "RM",
                      txt7: AppLocalizations.of('₹1 Lakhs'),
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
