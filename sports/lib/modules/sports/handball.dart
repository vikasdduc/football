import 'package:carousel_pro/carousel_pro.dart';
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/widget/cardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../constance/constance.dart';

class HandballPage extends StatefulWidget {
  @override
  _HandballPageState createState() => _HandballPageState();
}

class _HandballPageState extends State<HandballPage> {
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
                        ConstanceData.hslider1,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        ConstanceData.hslider2,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        ConstanceData.hslider3,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        ConstanceData.hslider4,
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
                      txt1: AppLocalizations.of('German Mens Handball'),
                      txt2: AppLocalizations.of('MT Melsungen'),
                      txt3: AppLocalizations.of('TSV GWD Minden'),
                      txt4: "MM",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 600 * 60,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "GWD",
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
                      txt1: AppLocalizations.of('German Mens Handball'),
                      txt2: "THW- Kiel",
                      txt3: AppLocalizations.of('SG Flensburg-Handewitt'),
                      txt4: "KIE",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 90 * 60,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "SFH",
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
                      txt1: AppLocalizations.of('German Mens Handball'),
                      txt2: AppLocalizations.of('Frisch Auf Goppingen'),
                      txt3: AppLocalizations.of('HC Eriangen'),
                      txt4: "FAG",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 300 * 160,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "HCE",
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
                      txt1: AppLocalizations.of('German Mens Handball'),
                      txt2: "MT Melsungen",
                      txt3: AppLocalizations.of('TSV GWD Minden'),
                      txt4: "MM",
                      setTime: CountdownTimer(
                        endTime: DateTime.now().millisecondsSinceEpoch +
                            1000 * 400 * 30,
                        textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      txt6: "GWD",
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
