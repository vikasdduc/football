import 'package:fantacySports/Language/appLocalizations.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:flutter/material.dart';

class WinnerPage extends StatefulWidget {
  @override
  _WinnerPageState createState() => _WinnerPageState();
}

class _WinnerPageState extends State<WinnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of('Winners'),
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.white,
                letterSpacing: 0.6,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.share,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of('Mega Contest Winners'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).textTheme.headline6.color,
                            letterSpacing: 0.6,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      AppLocalizations.of('Filter by Tour'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Colors.black87,
                            letterSpacing: 0.6,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.sort,
                      color: Colors.black87,
                      size: 18,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                // Card(
                //   elevation: 5,
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     child: Padding(
                //       padding: const EdgeInsets.only(top: 10, bottom: 10),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 10, right: 10),
                //             child: Row(
                //               children: [
                //                 Text(
                //                   AppLocalizations.of('ECST10-Barceiona'),
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .caption
                //                       .copyWith(
                //                         letterSpacing: 0.6,
                //                         fontSize: 10,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                 ),
                //                 Expanded(child: SizedBox()),
                //                 Text(
                //                   "20 Oct, 2020",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .caption
                //                       .copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 10,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //             height: 15,
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 10, right: 10),
                //             child: Row(
                //               children: [
                //                 Container(
                //                   height: 25,
                //                   width: 25,
                //                   child:
                //                       Image.asset(ConstanceData.mumbaiIndians),
                //                 ),
                //                 SizedBox(
                //                   width: 5,
                //                 ),
                //                 Text(
                //                   "MI",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .caption
                //                       .copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                 ),
                //                 Expanded(child: SizedBox()),
                //                 Text(
                //                   "vs",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .caption
                //                       .copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 10,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                 ),
                //                 Expanded(child: SizedBox()),
                //                 Text(
                //                   "KOL",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .caption
                //                       .copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                 ),
                //                 SizedBox(
                //                   width: 5,
                //                 ),
                //                 Container(
                //                   height: 25,
                //                   width: 25,
                //                   child: Image.asset(ConstanceData.kolkata),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //             height: 10,
                //           ),
                //           Divider(),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 10, right: 10),
                //             child: Text(
                //               AppLocalizations.of('₹50 Lakh Mega Contest'),
                //               style:
                //                   Theme.of(context).textTheme.caption.copyWith(
                //                         color: Color(0xff317E2F),
                //                         letterSpacing: 0.6,
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 10,
                //                       ),
                //             ),
                //           ),
                //           Container(
                //             height: 180,
                //             child: ListView(
                //               scrollDirection: Axis.horizontal,
                //               padding: EdgeInsets.only(left: 20, right: 20),
                //               children: [
                //                 Row(
                //                   children: [
                //                     cardView(
                //                       AppLocalizations.of('Rank #1'),
                //                       AppLocalizations.of('Riks kk patil'),
                //                       AppLocalizations.of('Won ₹1 Lakh'),
                //                       AssetImage(
                //                         ConstanceData.siraj,
                //                       ),
                //                     ),
                //                     cardView(
                //                       AppLocalizations.of('Rank #2'),
                //                       AppLocalizations.of('Riks kk patil'),
                //                       AppLocalizations.of('Won ₹1 Lakh'),
                //                       AssetImage(
                //                         ConstanceData.defaultPlayer,
                //                       ),
                //                     ),
                //                     cardView(
                //                       AppLocalizations.of('Rank #3'),
                //                       AppLocalizations.of('Riks kk patil'),
                //                       AppLocalizations.of('Won ₹1 Lakh'),
                //                       AssetImage(
                //                         ConstanceData.cricketerPic,
                //                       ),
                //                     ),
                //                     cardView(
                //                       "Rank #4",
                //                       AppLocalizations.of('Riks kk patil'),
                //                       AppLocalizations.of('Won ₹1 Lakh'),
                //                       AssetImage(
                //                         ConstanceData.joshi,
                //                       ),
                //                     ),
                //                     cardView(
                //                       "Rank #5",
                //                       AppLocalizations.of('Riks kk patil'),
                //                       AppLocalizations.of('Won ₹1 Lakh'),
                //                       AssetImage(
                //                         ConstanceData.siraj,
                //                       ),
                //                     ),
                //                   ],
                //                 )
                //               ],
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // Card(
                //   elevation: 5,
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     child: Padding(
                //       padding: const EdgeInsets.only(top: 10, bottom: 10),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 10, right: 10),
                //             child: Row(
                //               children: [
                //                 Text(
                //                   AppLocalizations.of('ECST10-Barceiona'),
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .caption
                //                       .copyWith(
                //                         letterSpacing: 0.6,
                //                         fontSize: 10,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                 ),
                //                 Expanded(child: SizedBox()),
                //                 Text(
                //                   "20 Oct, 2020",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .caption
                //                       .copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 10,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //             height: 15,
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 10, right: 10),
                //             child: Row(
                //               children: [
                //                 Container(
                //                   height: 25,
                //                   width: 25,
                //                   child:
                //                       Image.asset(ConstanceData.mumbaiIndians),
                //                 ),
                //                 SizedBox(
                //                   width: 5,
                //                 ),
                //                 Text(
                //                   "MI",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .caption
                //                       .copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                 ),
                //                 Expanded(child: SizedBox()),
                //                 Text(
                //                   "vs",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .caption
                //                       .copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 10,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                 ),
                //                 Expanded(child: SizedBox()),
                //                 Text(
                //                   "KOL",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .caption
                //                       .copyWith(
                //                         color: Theme.of(context)
                //                             .textTheme
                //                             .headline6
                //                             .color,
                //                         letterSpacing: 0.6,
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                 ),
                //                 SizedBox(
                //                   width: 5,
                //                 ),
                //                 Container(
                //                   height: 25,
                //                   width: 25,
                //                   child: Image.asset(ConstanceData.kolkata),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //             height: 10,
                //           ),
                //           Divider(),
                //           Padding(
                //             padding: const EdgeInsets.only(left: 10, right: 10),
                //             child: Text(
                //               AppLocalizations.of('₹50 Lakh Mega Contest'),
                //               style:
                //                   Theme.of(context).textTheme.caption.copyWith(
                //                         color: Color(0xff317E2F),
                //                         letterSpacing: 0.6,
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 10,
                //                       ),
                //             ),
                //           ),
                //           Container(
                //             height: 180,
                //             child: ListView(
                //               scrollDirection: Axis.horizontal,
                //               padding: EdgeInsets.only(left: 20, right: 20),
                //               children: [
                //                 Row(
                //                   children: [
                //                     cardView(
                //                       AppLocalizations.of('Rank #1'),
                //                       AppLocalizations.of('Riks kk patil'),
                //                       AppLocalizations.of('Won ₹1 Lakh'),
                //                       AssetImage(
                //                         ConstanceData.joshi,
                //                       ),
                //                     ),
                //                     cardView(
                //                       AppLocalizations.of('Rank #2'),
                //                       AppLocalizations.of('Riks kk patil'),
                //                       AppLocalizations.of('Won ₹1 Lakh'),
                //                       AssetImage(
                //                         ConstanceData.buttler,
                //                       ),
                //                     ),
                //                     cardView(
                //                       AppLocalizations.of('Rank #3'),
                //                       AppLocalizations.of('Riks kk patil'),
                //                       AppLocalizations.of('Won ₹1 Lakh'),
                //                       AssetImage(
                //                         ConstanceData.morris,
                //                       ),
                //                     ),
                //                     cardView(
                //                       "Rank #4",
                //                       AppLocalizations.of('Riks kk patil'),
                //                       AppLocalizations.of('Won ₹1 Lakh'),
                //                       AssetImage(
                //                         ConstanceData.cricketerPic,
                //                       ),
                //                     ),
                //                     cardView(
                //                       "Rank #5",
                //                       AppLocalizations.of('Riks kk patil'),
                //                       AppLocalizations.of('Won ₹1 Lakh'),
                //                       AssetImage(
                //                         ConstanceData.defaultPlayer,
                //                       ),
                //                     ),
                //                   ],
                //                 )
                //               ],
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardView(String txt1, String txt2, String txt3, AssetImage image) {
    return Card(
      elevation: 5,
      child: Container(
        height: 140,
        width: 120,
        color: Theme.of(context).appBarTheme.color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Text(
                txt1,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.headline6.color,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                      fontSize: 10,
                    ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Text(
                txt2,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).textTheme.bodyText2.color,
                      letterSpacing: 0.6,
                      fontSize: 10,
                    ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: CircleAvatar(
                  radius: 34,
                  backgroundColor: Theme.of(context).textTheme.headline6.color,
                  backgroundImage: image),
            ),
            Expanded(child: SizedBox()),
            Container(
              color: Color(0xff0E2F56),
              height: 20,
              child: Center(
                child: Text(
                  txt3,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Colors.white,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
