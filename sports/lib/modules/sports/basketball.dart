import 'package:carousel_pro/carousel_pro.dart';
import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/widget/cardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../constance/constance.dart';

class BasketballPage extends StatefulWidget {
  @override
  _BasketballPageState createState() => _BasketballPageState();
}

class _BasketballPageState extends State<BasketballPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          child:  Image.asset(
            'assets/images/vollyball.webp',
            fit: BoxFit.cover,
          ),
        ),
      ),
      // child: ListView(
      //   padding: EdgeInsets.zero,
      //   children: [
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         SizedBox(
      //           height: 180,
      //           child: Swiper(
      //             itemCount: 4,
      //             itemBuilder: (BuildContext context, int index) => Carousel(
      //               boxFit: BoxFit.cover,
      //               images: [
      //                 Image.asset(
      //                   ConstanceData.bslider1,
      //                   fit: BoxFit.cover,
      //                 ),
      //                 Image.asset(
      //                   ConstanceData.bslider2,
      //                   fit: BoxFit.cover,
      //                 ),
      //                 Image.asset(
      //                   ConstanceData.bslider3,
      //                   fit: BoxFit.cover,
      //                 ),
      //                 Image.asset(
      //                   ConstanceData.bslider6,
      //                   fit: BoxFit.cover,
      //                 ),
      //               ],
      //               dotSize: 4.0,
      //               dotSpacing: 15.0,
      //               indicatorBgPadding: 5.0,
      //               dotBgColor: Colors.transparent,
      //               borderRadius: true,
      //             ),
      //             autoplay: false,
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(
      //               left: 20, right: 20, top: 20, bottom: 15),
      //           child: Text(
      //             AppLocalizations.of('Upcoming Matches'),
      //             style: Theme.of(context).textTheme.headline6.copyWith(
      //                   color: Theme.of(context).textTheme.headline6.color,
      //                   fontWeight: FontWeight.bold,
      //                   letterSpacing: 0.6,
      //                   fontSize: 18,
      //                 ),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 16, right: 16),
      //           child: Column(
      //             children: [
      //               CardView(
      //                 txt1: AppLocalizations.of('CBA League 2020-21'),
      //                 txt2: AppLocalizations.of('Jiangsu Dragons'),
      //                 txt3: AppLocalizations.of('Zhejiang Golden Bulls'),
      //                 txt4: "JD",
      //                 setTime: CountdownTimer(
      //                   endTime: DateTime.now().millisecondsSinceEpoch +
      //                       1000 * 20 * 20,
      //                   textStyle: TextStyle(
      //                     fontSize: 14,
      //                     color: Colors.red,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 txt6: "ZGB",
      //                 txt7: AppLocalizations.of('₹1 Lakhs'),
      //                 image1: Image.asset(
      //                   ConstanceData.mumbaiIndians,
      //                   fit: BoxFit.cover,
      //                 ),
      //                 image2: Image.asset(
      //                   ConstanceData.kolkata,
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               CardView(
      //                 txt1: AppLocalizations.of('CBA League 2020-21'),
      //                 txt2: AppLocalizations.of('Qingdo Eagles'),
      //                 txt3: AppLocalizations.of('Guangdong Southern Tigers'),
      //                 txt4: "QE",
      //                 setTime: CountdownTimer(
      //                   endTime: DateTime.now().millisecondsSinceEpoch +
      //                       1000 * 140 * 60,
      //                   textStyle: TextStyle(
      //                     fontSize: 14,
      //                     color: Colors.red,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 txt6: "GST",
      //                 txt7: AppLocalizations.of('₹1 Lakhs'),
      //                 image1: Image.asset(
      //                   ConstanceData.mumbaiIndians,
      //                   fit: BoxFit.cover,
      //                 ),
      //                 image2: Image.asset(
      //                   ConstanceData.kolkata,
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               CardView(
      //                 txt1: AppLocalizations.of('CBA League 2020-21'),
      //                 txt2: AppLocalizations.of('Andorra'),
      //                 txt3: AppLocalizations.of('Burgos'),
      //                 txt4: "AR",
      //                 setTime: CountdownTimer(
      //                   endTime: DateTime.now().millisecondsSinceEpoch +
      //                       1000 * 160 * 160,
      //                   textStyle: TextStyle(
      //                     fontSize: 14,
      //                     color: Colors.red,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 txt6: "BGL",
      //                 txt7: AppLocalizations.of('₹1 Lakhs'),
      //                 image1: Image.asset(
      //                   ConstanceData.mumbaiIndians,
      //                   fit: BoxFit.cover,
      //                 ),
      //                 image2: Image.asset(
      //                   ConstanceData.kolkata,
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               CardView(
      //                 txt1: AppLocalizations.of('Spanish Liga ACB'),
      //                 txt2: AppLocalizations.of('Jiangsu Dragons'),
      //                 txt3: AppLocalizations.of('Zhejiang Golden Bulls'),
      //                 txt4: "JD",
      //                 setTime: CountdownTimer(
      //                   endTime: DateTime.now().millisecondsSinceEpoch +
      //                       1000 * 70 * 60,
      //                   textStyle: TextStyle(
      //                     fontSize: 14,
      //                     color: Colors.red,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 txt6: "ZGB",
      //                 txt7: AppLocalizations.of('₹1 Lakhs'),
      //                 image1: Image.asset(
      //                   ConstanceData.mumbaiIndians,
      //                   fit: BoxFit.cover,
      //                 ),
      //                 image2: Image.asset(
      //                   ConstanceData.kolkata,
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         )
      //       ],
      //     )
      //   ],
      // ),
    );
  }
}
